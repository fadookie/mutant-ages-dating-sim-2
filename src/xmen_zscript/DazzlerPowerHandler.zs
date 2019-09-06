class DazzlerPowerHandler : EventHandler
{
	const DESYNC_THRESHOLD_S = 2.0;
	const NUM_EVENTS = 6;
	float eventTimestampsS[NUM_EVENTS];
	int currentEventIdx;
	int danceStartTimeTk;
	float danceStartSync;

	override void WorldLoaded(WorldEvent e) {
			Console.Printf("DazzlerPowerHandler#WorldLoaded" .. e);
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
			Console.Printf("Ending dance sequence.");
			currentEventIdx = 0;
			danceStartTimeTk = 0;
		}
		if (danceStartTimeTk > 0) {
			let timeSinceStartTk = level.time - danceStartTimeTk;
			let timeSinceStartS = Thinker.Tics2Seconds(timeSinceStartTk);

			float currentEventTimeS = eventTimestampsS[currentEventIdx];

			// Console.Printf("timeSinceStartS:" .. timeSinceStartS .. " currentEventTimeS:" .. currentEventTimeS);

			// let currentSync = calculateSync(level.time, MSTime());
			// if (Abs(currentSync - danceStartSync) > DESYNC_THRESHOLD_S) {
			// 	Console.Printf("Desync detected! currentSync:" .. currentSync .. " danceStartSync:" .. danceStartSync .. " Desync:" .. Abs(currentSync - danceStartSync));
			// 	Console.Printf("DazzlerHandler#WorldTick level.time:" .. level.time .. " level.Frozen" .. level.Frozen);
			// }

			if (timeSinceStartS >= currentEventTimeS) {
				Console.Printf("Event at " .. currentEventTimeS);
				++currentEventIdx;
			}
		}
	}

	void StartDanceSequence() {
		Console.Printf("DazzlerPowerHandler#StartDanceSequence");
		danceStartTimeTk = level.time;
		let danceStartTimeMs = MSTime();
		danceStartSync = calculateSync(danceStartTimeTk, danceStartTimeMs);
		//  S_ChangeMusic(String music_name, int order = 0, bool looping = true, bool force = false)
		S_ChangeMusic("music/clickTrack.mp3");
	}

	float calculateSync(float ticks, uint millis) {
			let danceStartTimeSFromTK = Thinker.Tics2Seconds(ticks);
			float danceStartTimeSFromMs = millis * 1000.0;
			return danceStartTimeSFromTK - danceStartTimeSFromMs;
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
