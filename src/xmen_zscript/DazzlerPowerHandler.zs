class DazzlerPowerHandler : EventHandler
{
	const DESYNC_THRESHOLD_S = 0.5;
	const NUM_EVENTS = 6;
	float eventTimestampsS[NUM_EVENTS];
	int currentEventIdx;
	int danceStartTimeTk;
	uint danceStartTimeMs;
	float danceStartSync;
	PoochyPlayer player;

	override void WorldLoaded(WorldEvent e) {
		Console.Printf("DazzlerPowerHandler#WorldLoaded v2");
		player = CallBus.FindPlayer();
// 		boardSpot = FindActor(BOARD_SPOT_TID);
// 		if (boardSpot == null) {
// 			Console.Printf("No board spot found with TID " .. BOARD_SPOT_TID .. ", creating one...");
// 			boardSpot = player.Spawn("Shotgun", (0,0,0), NO_REPLACE);
// 		}

		eventTimestampsS[0] = 2.0; // Measure 2
		eventtimestampss[1] = 4.0; // Measure 3
		eventTimestampsS[2] = 6.0;
		eventTimestampsS[3] = 8.0;
		eventTimestampsS[4] = 10.0;
		eventTimestampsS[5] = 12.0;
		// eventTimestampsS[6] = 14.0;
		// eventTimestampsS[7] = 16.0;
		// eventTimestampsS[8] = 18.0;
		// eventTimestampsS[9] = 20.0; // Measure 11
	}
	
	override void WorldTick()
	{
		if (currentEventIdx >= NUM_EVENTS) {
			EndDanceSequence();
		}
		if (danceStartTimeTk > 0) {
			let timeSinceStartTk = level.time - danceStartTimeTk;
			let timeSinceStartS = Thinker.Tics2Seconds(timeSinceStartTk);

			float currentEventTimeS = eventTimestampsS[currentEventIdx];

			// Console.Printf("timeSinceStartS:" .. timeSinceStartS .. " currentEventTimeS:" .. currentEventTimeS);

			let currentSync = calculateSync(level.time, MSTime());
			let desync = Abs(currentSync - danceStartSync);
			// Console.Printf("DazzlerHandler#WorldTick desync check level.time:" .. level.time .. " MSTime:" .. MSTime() .. " currentSync:" .. currentSync .. " danceStartSync:" .. danceStartSync .. " Desync:" .. desync);
			if (desync > DESYNC_THRESHOLD_S) {
				Console.Printf("Desync detected!");
				// MidPrint(Font fontname, string textlabel, bool bold = false);
				let font = Font.GetFont("SMALLFONT");
				// Console.MidPrint(font, "Don't you know it's rude to not pay attention during a performance? Please don't pause the game while we are dancing. Let's try that again...", bold: false);
				// CallBus.PrintDazzlerDesyncWarning();
				player.A_Print("Don't you know it's rude to not pay attention during a performance?\nPlease don't pause the game while we are dancing.\nLet's try that again...", 7.0, "BIGFONT");
				// ACS_NamedExecute("PrintDazzlerDesyncWarning", 0);
				EndDanceSequence();
			}

			if (timeSinceStartS >= currentEventTimeS) {
				Console.Printf("Event at " .. currentEventTimeS);
				// Console.Printf("DazzlerHandler#WorldTick event level.time:" .. level.time .. " MSTime:" .. MSTime() .. " currentSync:" .. currentSync .. " danceStartSync:" .. danceStartSync .. " Desync:" .. desync);
				++currentEventIdx;

			}
		}
	}

	void StartDanceSequence() {
		Console.Printf("DazzlerPowerHandler#StartDanceSequence level.time:" .. level.time .. " MSTime:" .. MSTime());
		danceStartTimeTk = level.time;
		danceStartTimeMs = MSTime();
		danceStartSync = calculateSync(danceStartTimeTk, danceStartTimeMs);
		// S_ChangeMusic(String music_name, int order = 0, bool looping = true, bool force = false)
		// Force restart of music if already playing
		S_ChangeMusic("*", force: true);
		S_ChangeMusic("music/clickTrack.mp3", force: true);
	}

	void EndDanceSequence() {
		Console.Printf("DazzlerPowerHandler#EndDanceSequence");
		currentEventIdx = 0;
		danceStartTimeTk = 0;
		// Restore default music
		S_ChangeMusic("*");
	}

	/**
	 * Calculates the drift in sync between wall time and sim time, in fractional seconds
	 */
	float calculateSync(float ticks, uint epochMs) {
			let ticksInSeconds = (ticks / 35.0);
			float epochMsInSeconds = epochMs / 1000.0;
			let sync = ticksInSeconds - epochMsInSeconds;
			// Console.Printf("DazzlerPowerHandler#calculateSync(ticks:" .. ticks .. " epochMs:" .. epochMs .. ") => ticksInSeconds:" .. ticksInSeconds .. " - epochMsInSeconds" .. epochMsInSeconds .. " = sync:" .. sync);
			return sync;
	}

/*
	void FindDoodads() {
		ActorIterator iterator = level.CreateActorIterator(DOODAD_TID);
		Actor current;
		while(true) {
			current = iterator.Next();
			Console.Printf("FindDoodads for TID: " .. DOODAD_TID .. " :" .. current);
			if (current == null) {
				Console.Printf("DazzlerPowerHandler#FindDoodads, found " .. doodads.Size() .. " doodads.");
				return;
			} else {
				doodads.Push(current);
			}
		}
	}
	*/
}
