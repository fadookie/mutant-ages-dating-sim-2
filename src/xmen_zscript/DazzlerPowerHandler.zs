class DazzlerPowerHandler : EventHandler
{
	// const PI = 3.14159265358979323846;
	const DESYNC_THRESHOLD_S = 0.5;
	const NUM_EVENTS = 6;
	const TARGET_TID = 999;
	float eventTimestampsS[NUM_EVENTS];
	int currentEventIdx;
	int danceStartTimeTk;
	uint danceStartTimeMs;
	float danceStartSync;
	PoochyPlayer player;
	Dazzler dazzler;
	Actor target;

	override void WorldLoaded(WorldEvent e) {
		Console.Printf("DazzlerPowerHandler#WorldLoaded v2");
		player = CallBus.FindPlayer();
		dazzler = CallBus.FindDazzler();
		target = CallBus.FindActor(TARGET_TID);
// 		boardSpot = FindActor(BOARD_SPOT_TID);
// 		if (boardSpot == null) {
// 			Console.Printf("No board spot found with TID " .. BOARD_SPOT_TID .. ", creating one...");
// 			boardSpot = player.Spawn("Shotgun", (0,0,0), NO_REPLACE);
// 		}

		eventTimestampsS[0] = 0.0; // Measure 1
		eventTimestampsS[1] = 2.0; // Measure 2
		eventtimestampss[2] = 4.0; // Measure 3
		eventTimestampsS[3] = 6.0;
		eventTimestampsS[4] = 8.0;
		eventTimestampsS[5] = 10.0;
		// eventTimestampsS[6] = 12.0;
		// eventTimestampsS[7] = 14.0;
		// eventTimestampsS[8] = 16.0;
		// eventTimestampsS[9] = 18.0;
		// eventTimestampsS[10] = 20.0; // Measure 11
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
				/* Missile options:
				native Actor SpawnMissile(Actor dest, class<Actor> type, Actor owner = null);
				native Actor SpawnMissileXYZ(Vector3 pos, Actor dest, Class<Actor> type, bool checkspawn = true, Actor owner = null);
				native Actor SpawnMissileZ (double z, Actor dest, class<Actor> type);
				native Actor SpawnMissileAngleZSpeed (double z, class<Actor> type, double angle, double vz, double speed, Actor owner = null, bool checkspawn = true);
				native Actor SpawnMissileZAimed (double z, Actor dest, Class<Actor> type);
				native Actor OldSpawnMissile(Actor dest, class<Actor> type, Actor owner = null);
				// FUNC P_SpawnMissileAngle
				Actor SpawnMissileAngle (class<Actor> type, double angle, double vz)
					return SpawnMissileAngleZSpeed (pos.z + 32 + GetBobOffset(), type, angle, vz, GetDefaultSpeed (type));
				Actor SpawnMissileAngleZ (double z, class<Actor> type, double angle, double vz)
					return SpawnMissileAngleZSpeed (z, type, angle, vz, GetDefaultSpeed (type));
				*/
				// dazzler.SpawnMissile(target, "DazzlerBall");

				// Circle
				let radius = 64.0 * 1.5;
				let NUM_BALLS = 32;
				let offset = (0.0, 0.0, 64.0 * 1.5);
				for(int i = 0; i < NUM_BALLS; ++i) {
					let theta = Utils.Mapd(i, 0.0, NUM_BALLS, 0, 360);
					let result = Utils.Polar2Cartesian(radius, theta);
					let pos = (0.0, result.x, result.y);
					pos += offset;
					// Console.Printf("Spawn missile, pos:" .. pos .. " i:" .. i .. " theta:" .. theta .. " result:" .. result);
					dazzler.SpawnMissileXYZ(pos, target, "DazzlerBall");
				}

				// Cross?
				// dazzler.SpawnMissileXYZ((0.0, 0.0, 0.0), target, "DazzlerBall");
				// dazzler.SpawnMissileXYZ((0.0, 64.0, 0.0), target, "DazzlerBall");
				// dazzler.SpawnMissileXYZ((0.0, 64.0, 64.0), target, "DazzlerBall");

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
