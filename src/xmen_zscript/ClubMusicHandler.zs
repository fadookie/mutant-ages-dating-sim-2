/**
 * This class is just a shim so we can serialize the music playing state
 * so it can be resumed when loading a savegame.
 * See ClubMusicHandlerStatic for most of the logic.
 */
class ClubMusicHandler : EventHandler
{
	bool musicPlaying;
	int currentTrackIdx;

	override void OnRegister()
	{
		SetOrder(ClubMusicHandlerStatic.EVENT_HANDLER_ORDER_CLUB_MUSIC_HANDLER);
	}

	override /*play*/ void WorldLoaded(WorldEvent e) {
		Console.Printf("ClubMusicHandler.WorldLoaded");
		// EventHandler.SendInterfaceEvent(consoleplayer, ClubMusicHandlerStatic.INTERFACEEVENT_WORLDLOADED, int(musicPlaying), currentTrackIdx);
	}

	/**
	 * Handler for incoming events from ui scope  -> play scope
	 */
	override /*play*/ void NetworkProcess (ConsoleEvent e)
	{
		if (e.name == ClubMusicHandlerStatic.NETWORKEVENT_ON_LOAD_REFRESH_QUERY) {
			// Send serialized state to static handler
			Console.Printf("ClubMusicHandler.NetworkProcess NETWORKEVENT_ON_LOAD_REFRESH_QUERY e:" .. e);
			EventHandler.SendInterfaceEvent(consoleplayer, ClubMusicHandlerStatic.INTERFACEEVENT_ON_LOAD_REFRESH_REPLY, int(musicPlaying), currentTrackIdx);
		} else if (e.name == ClubMusicHandlerStatic.NETWORKEVENT_SET_TRACK_IDX) {
			currentTrackIdx = e.Args[0];
			Console.Printf("ClubMusicHandler.NetworkProcess NETWORKEVENT_SET_TRACK_IDX currentTrackIdx:" .. currentTrackIdx);
		}
	}
}
