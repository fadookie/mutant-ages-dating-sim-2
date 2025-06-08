class ClubMusicHandler : EventHandler
{
	bool musicPlaying;
	int currentTrackIdx;
	float currentTrackLengthSec;
	int trackStartTimeTk;
  static const Sound MUSIC_TRACKS[] =
  {
		Sound("el/instrumentalTheme"),
		Sound("el/mutantAgesComicBookTheme"),
		Sound("el/xMenMetaphorSong")
	};
	
	override void WorldLoaded(WorldEvent e) {
		// currentTrackIdx = 0;
		// musicPlaying = false;
		UpdateCurrentTrackLength();
	}
	
	override void WorldTick()
	{
		if (musicPlaying) {
			let timeSeconds = Utils.Tics2Secondsf(level.time);
			int elapsedTimeTk = level.time - trackStartTimeTk;
			let elapsedTimeS = Utils.Tics2Secondsf(elapsedTimeTk);

			if (elapsedTimeS > currentTrackLengthSec) {
				currentTrackIdx = (currentTrackIdx + 1) % MUSIC_TRACKS.Size();
				PlayNextTrack();
			}
		}
	}

	void UpdateCurrentTrackLength() {
		let currentTrack = MUSIC_TRACKS[currentTrackIdx];
		currentTrackLengthSec = S_GetLength(currentTrack);
	}

	void StartMusic() {
		S_ChangeMusic("music/silence.ogg", force: true);
		Console.Printf("ClubMusicHandler.StartMusic");
		musicPlaying = true;
		PlayNextTrack();
	}

	private void PlayNextTrack() {
		trackStartTimeTk = level.time;
		let currentTrack = MUSIC_TRACKS[currentTrackIdx];
		// Play music track at user's current music volume setting
		let musicVolumeCVar = CVar.GetCVar("snd_musicvolume", players[consoleplayer]).GetFloat();
		UpdateCurrentTrackLength();
		Console.Printf("ClubMusicHandler.PlayNextTrack musicVolumeCVar:" .. musicVolumeCVar .. " currentTrack:" .. currentTrack .. " currentTrackIdx" .. currentTrackIdx .. " currentTrackLengthSec:" .. currentTrackLengthSec);
		S_StartSound(currentTrack, CHAN_AUTO, CHANF_DEFAULT, musicVolumeCVar);
	}

	void StopMusic() {
		musicPlaying = false;
		S_ChangeMusic("*", force: true);
	}
}
