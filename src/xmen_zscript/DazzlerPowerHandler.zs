enum DazzlerEventType
{
		SINGLE,
		CIRCLE,
		HORIZONTAL_LINE_CROUCH,
		HORIZONTAL_LINE_JUMP,
		BARRAGE,
		NOOP,
}

class DazzlerPowerHandler : EventHandler
{
	// const PI = 3.14159265358979323846;
	const DANCE_QUEUE_TIME_S = 1.0;
	const DESYNC_THRESHOLD_S = 0.5;
	const NUM_EVENTS = 2;
	const TARGET_TID = 999;

	float eventTimestampsS[NUM_EVENTS];
	DazzlerEventType eventTypes[NUM_EVENTS];
	int currentEventIdx;

	int danceQueueTimeTk;

	int danceStartTimeTk;
	uint danceStartTimeMs;
	float danceStartSync;

	int barrageStartTimeTk;
	int barrageMaxBalls;
	int barrageNumBallsFired;

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
		eventTypes			[0] = BARRAGE;
		// eventTypes			[0] = HORIZONTAL_LINE_CROUCH;

		// eventTimestampsS[1] = 2.0; // Measure 2
		eventTimestampsS[1] = 20.0; // Measure 2
		eventTypes			[1] = NOOP;
		// eventTypes			[1] = HORIZONTAL_LINE_JUMP;

		// eventtimestampss[2] = 4.0; // Measure 3
		// eventTypes			[2] = BARRAGE;
		// eventTypes			[2] = HORIZONTAL_LINE_CROUCH;

		// eventTimestampsS[3] = 6.0;
		// eventTypes			[3] = BARRAGE;
		// eventTypes			[3] = HORIZONTAL_LINE_JUMP;

		// eventTimestampsS[4] = 8.0;
		// eventTypes			[4] = BARRAGE;
		// eventTypes			[4] = CIRCLE;

		// eventTimestampsS[5] = 10.0;
		// eventTypes			[5] = BARRAGE;
		// eventTypes			[5] = HORIZONTAL_LINE_CROUCH;
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
			return;
		}
		if (danceQueueTimeTk > 0
			&& Thinker.Tics2Seconds(level.time - danceQueueTimeTk) >= DANCE_QUEUE_TIME_S) {
			danceQueueTimeTk = 0;
			StartDanceSequence();
		}
		if (danceStartTimeTk <= 0) {
			return;
		}
		let timeSinceStartTk = level.time - danceStartTimeTk;
		let timeSinceStartS = Thinker.Tics2Seconds(timeSinceStartTk);

		float currentEventTimeS = eventTimestampsS[currentEventIdx];
		let currentEventType = eventTypes[currentEventIdx];

		// Console.Printf("timeSinceStartS:" .. timeSinceStartS .. " currentEventTimeS:" .. currentEventTimeS);

		let currentSync = calculateSync(level.time, MSTime());
		let desync = Abs(currentSync - danceStartSync);
		// Console.Printf("DazzlerHandler#WorldTick desync check level.time:" .. level.time .. " MSTime:" .. MSTime() .. " currentSync:" .. currentSync .. " danceStartSync:" .. danceStartSync .. " Desync:" .. desync);
		if (desync > DESYNC_THRESHOLD_S) {
			Console.Printf("Desync detected!");
			// MidPrint(Font fontname, string textlabel, bool bold = false);
			// let font = Font.GetFont("SMALLFONT");
			// Console.MidPrint(font, "Don't you know it's rude to not pay attention during a performance? Please don't pause the game while we are dancing. Let's try that again...", bold: false);
			// CallBus.PrintDazzlerDesyncWarning();
			player.A_Print("Don't you know it's rude to not pay attention during a performance?\nPlease don't pause the game while we are dancing.\nLet's try that again...", 7.0, "BIGFONT");
			// ACS_NamedExecute("PrintDazzlerDesyncWarning", 0);
			EndDanceSequence();
		}

		if (timeSinceStartS >= currentEventTimeS) {
			Console.Printf("Fire event[" .. currentEventIdx .. "] = type " .. currentEventType .. " at " .. currentEventTimeS);
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

			switch(currentEventType) {
				case SINGLE: {
					let ball = DazzlerBall(dazzler.SpawnMissile(target, "DazzlerBall"));
					ball.SetRandomTranslation();
					break;
				}

				case CIRCLE: {
					let radius = 64.0 * 1.5;
					let NUM_BALLS = 32;
					let offset = (0.0, 0.0, 64.0 * 1.5);
					for(int i = 0; i < NUM_BALLS; ++i) {
						let theta = Utils.Mapd(i, 0.0, NUM_BALLS, 0, 360);
						let result = Utils.Polar2Cartesian(radius, theta);
						let pos = (0.0, result.x, result.y);
						pos += offset;
						// Console.Printf("Spawn missile, pos:" .. pos .. " i:" .. i .. " theta:" .. theta .. " result:" .. result);
						let ball = DazzlerBall(dazzler.SpawnMissileXYZ(pos, target, "DazzlerBall"));
						ball.SetTranslation(i);
					}
					break;
				}

				case HORIZONTAL_LINE_CROUCH: {
					SpawnBallLine(32.0);	
					break;
				}

				case HORIZONTAL_LINE_JUMP: {
					SpawnBallLine(8.0);	
					break;
				}

				case BARRAGE: {
					barrageStartTimeTk = level.time;
					barrageMaxBalls = 10;
					break;
				}

				case NOOP:
					break;

				default:
					ThrowAbortException("Unknown event type: %d", currentEventType);
			}
			++currentEventIdx;
		}

		// Process barrage time slice
		if (barrageStartTimeTk > 0) {
			let NUM_BALLS = barrageMaxBalls;
			let BALL_SPACING = 16.0;
			let height = 32.0;

			let BARRAGE_INTERVAL_TK = 10;
			let timeSinceBarrageStartTk = level.time - barrageStartTimeTk;
			// Console.Printf("Barrage in progress, barrageStartTimeTk:" .. barrageStartTimeTk .. " timeSinceStart:" .. timeSinceBarrageStartTk);
			if (timeSinceBarrageStartTk % BARRAGE_INTERVAL_TK == 0) {
				// We just crossed the interval time
				int intervalIdx = timeSinceBarrageStartTk / BARRAGE_INTERVAL_TK;
				let posY = (intervalIdx * BALL_SPACING) - ((NUM_BALLS * BALL_SPACING) / 2);
				let pos = (0.0, posY, height);
				let ball = DazzlerBall(dazzler.SpawnMissileXYZ(pos, target, "DazzlerBall"));
				ball.SetTranslation(intervalIdx);
				Console.Printf("Barrage FIRE, numFired:" .. barrageNumBallsFired .. " maxBalls:" .. barrageMaxBalls .. " intervalIdx:" .. intervalIdx);
				++barrageNumBallsFired;
			}
			if (barrageNumBallsFired >= barrageMaxBalls) {
				Console.Printf("Barrage terminate numFired:" .. barrageNumBallsFired .. " maxBalls:");
				barrageNumBallsFired = 0;
				barrageStartTimeTk = 0;
			}
		}
	}

	void SpawnBallLine(double height) {
		let NUM_BALLS = 20;
		let BALL_SPACING = 16.0;
		for(int i = 0; i < NUM_BALLS; ++i) {
			let posY = (i * BALL_SPACING) - ((NUM_BALLS * BALL_SPACING) / 2);
			let pos = (0.0, posY, height);
			let ball = DazzlerBall(dazzler.SpawnMissileXYZ(pos, target, "DazzlerBall"));
			ball.SetTranslation(i);
		}
	}

	void QueueDanceSequence() {
		Console.Printf("DazzlerPowerHandler#QueueDanceSequence level.time:" .. level.time .. " MSTime:" .. MSTime());
		danceQueueTimeTk = level.time;
		player.A_Print("Get ready in 3, 2, 1...", 3.0, "BIGFONT");
	}

	void StartDanceSequence() {
		Console.Printf("DazzlerPowerHandler#StartDanceSequence level.time:" .. level.time .. " MSTime:" .. MSTime());
		player.A_Print("Let's jam!", 1.0, "BIGFONT");
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
