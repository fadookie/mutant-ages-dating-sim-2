class ClubMusicHandlerStatic : StaticEventHandler
{
	// const INTERFACEEVENT_WORLDLOADED = "ClubMusicHandler:WorldLoaded";
	const INTERFACEEVENT_WORLDLOADED_STATIC = "ClubMusicHandlerStatic:WorldLoaded";
	const INTERFACEEVENT_UPDATE_CURRENT_TRACK_LENGTH = "ClubMusicHandlerStatic:UpdateCurrentTrackLength";
	const INTERFACEEVENT_PLAY_NEXT_TRACK = "ClubMusicHandlerStatic:PlayNextTrack";
	const INTERFACEEVENT_UPDATE_MUSIC_PLAYING = "ClubMusicHandlerStatic:UpdateMusicPlaying";
	const INTERFACEEVENT_ON_LOAD_REFRESH_REPLY = "ClubMusicHandlerStatic:OnLoadRefreshReply"; // Reply for ClubMusicHandler state

	const NETWORKEVENT_ON_LOAD_REFRESH_QUERY = "ClubMusicHandler:OnLoadRefreshQuery"; // Query ClubMusicHandler state
	const NETWORKEVENT_SYNC_SERIALIZED_MUSIC_PLAYING = "ClubMusicHandlerStatic:SyncSerializedMusicPlaying";
	const NETWORKEVENT_SET_TRACK_IDX = "ClubMusicHandler:SetTrackIdx";

	// Event order numbers to try to ensure proper ordering of init event/messages
	const EVENT_HANDLER_ORDER_CLUB_MUSIC_HANDLER_STATIC = 800;
	const EVENT_HANDLER_ORDER_CLUB_MUSIC_HANDLER = 801;

  static const Sound MUSIC_TRACKS[] =
  {
		// TODO switch order back?
		Sound("el/mutantAgesComicBookTheme"),
		Sound("el/instrumentalTheme"),
		Sound("el/xMenMetaphorSong")
	};

	const DESYNC_THRESHOLD_MS = 2.0 * 1000.0;

	private ui bool musicPlaying;
	private ui int currentTrackIdx;
	private ui float currentTrackLengthSec;
	private ui float trackStartTimeMs;
	private ui bool hasUiTickedSinceMusicStarted;
	private ui float lastUiTickMs;

	private play PoochyPlayer player;
	private play bool wasLoadedFromSave;
	private play ClubMusicHandler clubMusicHandler;

	override void OnRegister()
	{
		SetOrder(EVENT_HANDLER_ORDER_CLUB_MUSIC_HANDLER_STATIC);
	}
	
	// #region ui scoped methods
	override /*ui*/ void UiTick()
	{
		if (musicPlaying) {
			// Console.Printf("ClubMusicHandlerStatic.UiTick MSTime:" .. MSTime() .. " MSTimeF:" .. MSTimeF() (which I am assuming are in milliseconds), System.GetTimeFrac(),  SystemTime.Now(), etc but havi
			let desyncThreshold = MSTimeF() - lastUiTickMs;
			// Console.Printf("ClubMusicHandlerStatic.UiTick MSTimeF:" .. MSTimeF() .. " desyncThrehsold:" .. desyncThreshold);
			if (hasUiTickedSinceMusicStarted && desyncThreshold > DESYNC_THRESHOLD_MS) {
				Console.Printf("ClubMusicHandlerStatic.UiTick DESYNC DETECTED, desyncThreshold:" .. desyncThreshold ..  " MSTimeF:" .. MSTimeF());
				lastUiTickMs = MSTimeF();
				AdvanceTrackIndex();
				PlayNextTrack();
				return;
			}
			hasUiTickedSinceMusicStarted = true;

			lastUiTickMs = MSTimeF();
			let elapsedTimeMs = lastUiTickMs - trackStartTimeMs;
			let elapsedTimeS = elapsedTimeMs / 1000;

			if (elapsedTimeS > currentTrackLengthSec) {
				AdvanceTrackIndex();
				PlayNextTrack();
			}
		}
	}

	/**
	 * Handler for incoming events from play scope -> ui scope
	 */
	override /*ui*/ void InterfaceProcess(ConsoleEvent e) {
		if (e.name == INTERFACEEVENT_ON_LOAD_REFRESH_REPLY) {
				// ClubMusicHandler has loaded
				let serializedCurrentTrackIdx = e.Args[1];
				Console.Printf("ClubMusicHandlerStatic.InterfaceProcess INTERFACEEVENT_ON_LOAD_REFRESH_REPLY serializedMusicPlaying:" .. e.Args[0] .. " serializedCurrentTrackIdx:" .. serializedCurrentTrackIdx .. " e:" .. e);
				currentTrackIdx = serializedCurrentTrackIdx;
				EventHandler.SendNetworkEvent(NETWORKEVENT_SYNC_SERIALIZED_MUSIC_PLAYING, e.Args[0]);
		} else if (e.name == INTERFACEEVENT_WORLDLOADED_STATIC) {
				Console.Printf("ClubMusicHandlerStatic.InterfaceProcess INTERFACEEVENT_WORLDLOADED_STATIC MSTimeF (reset lastUiTickMs):" .. MSTimeF());
				hasUiTickedSinceMusicStarted = false;
				lastUiTickMs = 0.0;
		} else if (e.name == INTERFACEEVENT_UPDATE_CURRENT_TRACK_LENGTH) {
			Console.Printf("ClubMusicHandlerStatic.InterfaceProcess INTERFACEEVENT_UPDATE_CURRENT_TRACK_LENGTH e:" .. e);
			UpdateCurrentTrackLength();
		} else if (e.name == INTERFACEEVENT_PLAY_NEXT_TRACK) {
			Console.Printf("ClubMusicHandlerStatic.InterfaceProcess INTERFACEEVENT_PLAY_NEXT_TRACK e:" .. e);
			PlayNextTrack();
		} else if (e.name == INTERFACEEVENT_UPDATE_MUSIC_PLAYING) {
			musicPlaying = bool(e.Args[0]);
			hasUiTickedSinceMusicStarted = false;
			Console.Printf("ClubMusicHandlerStatic.InterfaceProcess INTERFACEEVENT_UPDATE_MUSIC_PLAYING musicPlaying:" .. musicPlaying .. " e:" .. e);
			if (musicPlaying) {
				PlayNextTrack();
			}
		}
	}

	private ui void UpdateCurrentTrackLength() {
		let currentTrack = MUSIC_TRACKS[currentTrackIdx];
		currentTrackLengthSec = S_GetLength(currentTrack);
	}

	private ui void AdvanceTrackIndex() {
		currentTrackIdx = (currentTrackIdx + 1) % MUSIC_TRACKS.Size();
		// Persist track index in ClubMusicHandler
		EventHandler.SendNetworkEvent(NETWORKEVENT_SET_TRACK_IDX, currentTrackIdx);
	}

	private ui void PlayNextTrack() {
		trackStartTimeMs = MSTimeF();
		let currentTrack = MUSIC_TRACKS[currentTrackIdx];
		// Play music track at user's current music volume setting
		let musicVolumeCVar = CVar.GetCVar("snd_musicvolume", players[consoleplayer]).GetFloat();
		UpdateCurrentTrackLength();
		Console.Printf("ClubMusicHandlerStatic.PlayNextTrack musicVolumeCVar:" .. musicVolumeCVar .. " currentTrack:" .. currentTrack .. " currentTrackIdx" .. currentTrackIdx .. " currentTrackLengthSec:" .. currentTrackLengthSec);
		if (player != null) {
			player.A_StartSound(currentTrack, CHAN_WEAPON, CHANF_UI /* = play while paused */, musicVolumeCVar);
		}
	}

	// #endregion ui scoped methods

	// #region play scoped methods

	override /*play*/ void WorldLoaded(WorldEvent e) {
		player = CallBus.FindPlayer();
    clubMusicHandler = ClubMusicHandler(EventHandler.Find("ClubMusicHandler"));
    if(clubMusicHandler == null) {
      ThrowAbortException("Error! ClubMusicHandler not found!");
    }
		wasLoadedFromSave = e.IsSaveGame;
		Console.Printf("ClubMusicHandlerStatic.WorldLoaded IsSaveGame:" .. e.IsSaveGame ..  " MSTimeF:" .. MSTimeF()); //.. " this.musicPlaying:" .. musicPlaying .. " ClubMusicHandler.musicPlaying:" .. ClubMusicHandler.musicPlaying);
		// TODO: Handle Load from save desync
		EventHandler.SendNetworkEvent(NETWORKEVENT_ON_LOAD_REFRESH_QUERY);
		EventHandler.SendInterfaceEvent(consoleplayer, INTERFACEEVENT_WORLDLOADED_STATIC);
	}

	/**
	 * Handler for incoming events from ui scope  -> play scope
	 */
	override /*play*/ void NetworkProcess (ConsoleEvent e)
	{
		if (e.name == NETWORKEVENT_SYNC_SERIALIZED_MUSIC_PLAYING) {
			let serializedMusicPlaying = bool(e.Args[0]);
			Console.Printf("ClubMusicHandlerStatic.NetworkProcess NETWORKEVENT_SYNC_SERIALIZED_MUSIC_PLAYING serializedMusicPlaying:" .. serializedMusicPlaying .. " e:" .. e);
			SetSerializedMusicPlaying(serializedMusicPlaying);
			if (serializedMusicPlaying) {
      	StartMusicImpl();
			}
		}
	}

	private play void SetSerializedMusicPlaying(bool playing) {
		clubMusicHandler.musicPlaying = playing;
	}

	play void StartMusic() {
		Console.Printf("ClubMusicHandlerStatic.StartMusic clubMusicHandler:" .. clubMusicHandler);
		if (clubMusicHandler != null && !clubMusicHandler.musicPlaying) {
			StartMusicImpl();
		}
	}

	private play void StartMusicImpl() {
		S_ChangeMusic("music/silence.ogg", force: true);
		Console.Printf("ClubMusicHandlerStatic.StartMusicImpl");
		clubMusicHandler.musicPlaying = true;
		EventHandler.SendInterfaceEvent(consoleplayer, INTERFACEEVENT_UPDATE_MUSIC_PLAYING, 1);
		EventHandler.SendNetworkEvent(INTERFACEEVENT_PLAY_NEXT_TRACK);
	}

	play void StopMusic() {
		Console.Printf("ClubMusicHandlerStatic.StopMusic");
		if (clubMusicHandler.musicPlaying) {
			StopMusicImpl();
		}
	}


	private play void StopMusicImpl() {
		Console.Printf("ClubMusicHandlerStatic.StopMusicImpl");
		clubMusicHandler.musicPlaying = false;
		EventHandler.SendInterfaceEvent(consoleplayer, INTERFACEEVENT_UPDATE_MUSIC_PLAYING, 0);
		player.A_StopSound(CHAN_WEAPON);
		// S_ChangeMusic("*", force: true);
		S_ChangeMusic("D_STALKS", force: true);
	}

	// #endregion play scoped methods
}
