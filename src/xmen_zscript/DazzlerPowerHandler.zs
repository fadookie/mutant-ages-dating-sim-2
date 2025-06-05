enum DazzlerEventType
{
		NOOP,
		END, // Ends dance sequence prematurely. Not neccessary if there's an event at the end of the sequence, but allows early termination.
		HUD_1,
		HUD_2,
		HUD_3,
		HUD_4,
		HUD_GO,
		HUD_JUMP,
		HUD_CROUCH,
		SINGLE,
		VERTICAL_LINE,
		CIRCLE,
		HORIZONTAL_LINE,
		BARRAGE_RTL,
		BARRAGE_LTR,
}

enum DazzlerShotType {
	SHOT_NONE,
	DAZZLER_BALL,
	DAZZLER_HEALTH,
}

enum BarrageType {
	NONE,
	LTR,
	RTL,
}

class DazzlerPowerHandler : EventHandler
{
	// const PI = 3.14159265358979323846;
	const DANCE_QUEUE_TIME_S = 1.0;
	const DESYNC_THRESHOLD_S = 0.5;
	const NUM_SPAWN_ORIGINS = 5;
	const SPAWN_ORIGIN_TID_RANGE_START = 994;
	const TARGET_TID = 999;
	const EXIT_DOOR_SECTOR_TAG = 715;
	const INNER_CIRCLE_DOOR_SECTOR_TAG = 716;
	const CHEERING_ACTOR_TID = 3;
	const DAZZLER_WIND_UP_SEEK_AHEAD_AMOUNT_SEC = 0.5;

	// Lose/Win condition stuff
	const PLAYER_FAILURES_BEFORE_SKIP_OPTION = 2;
	int numPlayerFailures;
	bool CHEAT_INVINCIBLE; // Player can't fail sequence

	DazzlerPowerEventSequence events;
	int currentEventIdx;
	bool dazzlerWindUpTriggeredThisEvent;

	int danceQueueTimeTk;

	int danceStartTimeTk;
	uint danceStartTimeMs;
	float danceStartSync;

	int barrageStartTimeTk;
	int barrageMaxBalls;
	int barrageNumBallsFired;
	float barrageHeight;
	BarrageType barrageType;

	PoochyPlayer player;
	Dazzler dazzler;
	Actor spawnOrigins[NUM_SPAWN_ORIGINS];
	Actor centerSpawnOrigin;
	Actor target;
	ActorIterator cheeringActorFinder;

	override void WorldLoaded(WorldEvent e) {
		Console.Printf("DazzlerPowerHandler#WorldLoaded v2");

 		CHEAT_INVINCIBLE = true; // TODO: Disable
		
		events = New("DazzlerPowerEventSequence");
		events.Init();

		player = CallBus.FindPlayer();
		dazzler = CallBus.FindDazzler();

		for(int i = 0; i < NUM_SPAWN_ORIGINS; ++i) {
			let spawnOriginTID = SPAWN_ORIGIN_TID_RANGE_START + i;
			spawnOrigins[i] = CallBus.FindActor(spawnOriginTID);
			if (spawnOrigins[i] == null) {
				Console.Printf("Error! No Dazzler spawnOrigin found for spawnOrigins[" .. i .. "], TID:" .. spawnOriginTID);
			} else {
				Console.Printf("Found Dazzler spawnOrigin: spawnOrigins[" .. i .. "], TID:" .. spawnOriginTID .. " actor: ".. spawnOrigins[i]);
			}
		}
		centerSpawnOrigin = spawnOrigins[2];

		target = CallBus.FindActor(TARGET_TID);
		if (target == null) {
			Console.Printf("Error! No Dazzler target found.");
		} else {
			Console.Printf("Found Dazzler Target: " .. target);
		}

		cheeringActorFinder = ActorIterator.Create(CHEERING_ACTOR_TID);

// 		boardSpot = FindActor(BOARD_SPOT_TID);
// 		if (boardSpot == null) {
// 			Console.Printf("No board spot found with TID " .. BOARD_SPOT_TID .. ", creating one...");
// 			boardSpot = player.Spawn("Shotgun", (0,0,0), NO_REPLACE);
// 		}
	}
	
	override void WorldTick()
	{
		if (currentEventIdx >= events.eventTimestampsS.Size()) {
			EndDanceSequence();
			CheckWinCondition();
			return;
		}
		
		if (!CHEAT_INVINCIBLE && player.health == 1) {
			EndDanceSequence();
			OnPlayerLose();
			return;
		}
		
		if (danceQueueTimeTk > 0
			&& Utils.Tics2Secondsf(level.time - danceQueueTimeTk) >= DANCE_QUEUE_TIME_S) {
			danceQueueTimeTk = 0;
			// Just in case a dance sequence was still going (player is forcing a restart), end any active sequence
			EndDanceSequence();
			StartDanceSequence();
		}
		if (danceStartTimeTk <= 0) {
			return;
		}
		let timeSinceStartTk = level.time - danceStartTimeTk;
		let timeSinceStartS = Utils.Tics2Secondsf(timeSinceStartTk);

		if(CheckDesync()) { return; }

		float currentEventTimeS = events.eventTimestampsS[currentEventIdx];
		let currentEventType = events.eventTypes[currentEventIdx];

		// Console.Printf("timeSinceStartTk:" .. timeSinceStartTk .. " timeSinceStartS:" .. timeSinceStartS .. " currentEventTimeS:" .. currentEventTimeS);

		// Seek ahead to next event to trigger dazzler's wind-up animation
		if (!dazzlerWindUpTriggeredThisEvent
			&& timeSinceStartS >= currentEventTimeS - DAZZLER_WIND_UP_SEEK_AHEAD_AMOUNT_SEC
			&& (currentEventType == SINGLE
					|| currentEventType == VERTICAL_LINE
					|| currentEventType == CIRCLE
					|| currentEventType == HORIZONTAL_LINE
					// Process barrage elsewhere
			)
		) {
			dazzler.SetStateLabel("Throw");
			dazzlerWindUpTriggeredThisEvent = true;
		}

		// Check if next event should be dequeued
		while (timeSinceStartS >= currentEventTimeS) {
			if(CheckDesync()) { return; }
			if (currentEventType == END) {
				Console.Printf("END dance sequence event fired");
				EndDanceSequence();
				return;
			}
			FireEvent(currentEventType, currentEventTimeS);
			++currentEventIdx;
			dazzlerWindUpTriggeredThisEvent = false;
			if (currentEventIdx >= events.eventTimestampsS.Size()) {
				// We've reached the end of the dance sequence.
				EndDanceSequence();
				CheckWinCondition();
				return;
			}
			currentEventTimeS = events.eventTimestampsS[currentEventIdx];
			currentEventType = events.eventTypes[currentEventIdx];
		};

		// Process barrage time slice
		if (barrageStartTimeTk > 0) {
			let NUM_BALLS = barrageMaxBalls;
			let BALL_SPACING = 38.0;

			let BARRAGE_INTERVAL_TK = 5;
			let timeSinceBarrageStartTk = level.time - barrageStartTimeTk;
			// Console.Printf("Barrage in progress, barrageStartTimeTk:" .. barrageStartTimeTk .. " timeSinceStart:" .. timeSinceBarrageStartTk);
			if (timeSinceBarrageStartTk % BARRAGE_INTERVAL_TK == 0) {
				// We just crossed the interval time
				int intervalIdx;
				switch (barrageType) {
					case RTL:
						intervalIdx = timeSinceBarrageStartTk / BARRAGE_INTERVAL_TK;
						break;
					case LTR:
						intervalIdx = (NUM_BALLS - 1) - (timeSinceBarrageStartTk / BARRAGE_INTERVAL_TK);
						break;
					default:
						ThrowAbortException("Unknown barrage type: %d", barrageType);
				}
				Console.Printf("intervalIdx:" .. intervalIdx);
				// TODO: support health?
				let posY = (intervalIdx * BALL_SPACING) - ((NUM_BALLS * BALL_SPACING) / 2)+5;
				let pos = (centerSpawnOrigin.Pos.x, centerSpawnOrigin.Pos.y + posY, barrageHeight);
				let ball = DazzlerBall(centerSpawnOrigin.SpawnMissileXYZ(pos, target, "DazzlerBall"));
				if (ball) {
					ball.SetTranslation(intervalIdx);
				} else {
					Console.Printf("Barrage time slice encountered null ball");
				}
				Console.Printf("Barrage FIRE, numFired:" .. barrageNumBallsFired .. " maxBalls:" .. barrageMaxBalls .. " intervalIdx:" .. intervalIdx);
				++barrageNumBallsFired;
				if (intervalIdx % 3 == 0) dazzler.SetStateLabel("Throw");
			}
			if (barrageNumBallsFired >= barrageMaxBalls) {
				Console.Printf("Barrage terminate numFired:" .. barrageNumBallsFired .. " maxBalls:");
				barrageNumBallsFired = 0;
				barrageStartTimeTk = 0;
			}
		}
	}

	// Should only be called after reaching end of events list
	void CheckWinCondition() {
		if (player.health > 1 || CHEAT_INVINCIBLE) {
			// Player won
			OnPlayerWin(false);
		} else {
			// Player was too hurt to win
			OnPlayerLose();
		}
	}

	void OnPlayerWin(bool wasSkipped) {
		let innerCircleLine = "\nI'll let you through to see my friends in the inner circle, go through the door to your right...";
		if (wasSkipped) {
			Console.MidPrint("BIGFONT", "Okay, your dance skills could use some work but you definitely tried your best." .. innerCircleLine);
		} else {
			Console.MidPrint("BIGFONT", "Nice footwork! You impressed me." .. innerCircleLine);
		}
		player.GiveInventoryType("DazzlerAskForSkipInventory"); // Needed to skip to end of dialogue
		player.GiveInventoryType("DazzlerWonInventory");
		Door_Open(INNER_CIRCLE_DOOR_SECTOR_TAG, 16);
	}

	void OnPlayerLose() {
		numPlayerFailures++;

		if (numPlayerFailures >= PLAYER_FAILURES_BEFORE_SKIP_OPTION) {
			numPlayerFailures = 0;
			player.GiveInventoryType("DazzlerAskForSkipInventory");
			dazzler.StartConversation(player);
		} else {
			Console.MidPrint("BIGFONT", "Ooh, nice try, but you looked a little clumsy out there.\nWhy don't we give it another shot?");
		}
	}

	void FireEvent(DazzlerEventType currentEventType, float currentEventTimeS) {
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
				let originIndex = events.eventArg0Ints[currentEventIdx];
				let height = events.eventArg0Floats[currentEventIdx];
				let spawnOrigin = spawnOrigins[originIndex];
				let pos = (spawnOrigin.Pos.x, spawnOrigin.Pos.y, spawnOrigin.Pos.z + height);
				SpawnDazzlerShot(events.eventShotTypes[currentEventIdx], spawnOrigin, pos, true);
				break;
			}

			case VERTICAL_LINE: {
				let originIndex = events.eventArg0Ints[currentEventIdx];
				let spawnOrigin = spawnOrigins[originIndex];
				let NUM_BALLS = 10;
				let BALL_SPACING = 15.0;
				for(int i = 0; i < NUM_BALLS; ++i) {
					let zOffset = i * BALL_SPACING;
					let pos = (spawnOrigin.Pos.x, spawnOrigin.Pos.y, spawnOrigin.Pos.z + zOffset);
					let ball = DazzlerBall(centerSpawnOrigin.SpawnMissileXYZ(pos, target, "DazzlerBall"));
					if (ball) {
						ball.SetTranslation(i);
					} else {
						Console.Printf("SpawnBallLine encountered null ball");
					}
				}
				break;
			}

			case CIRCLE: {
				let radius = 70.0 * 1.5;
				let NUM_BALLS = 32;
				let offset = (0.0, 0.0, 70.0 * 1.5);
				for(int i = 0; i < NUM_BALLS; ++i) {
					let theta = Utils.Mapd(i, 0.0, NUM_BALLS, 0, 360);
					let result = Utils.Polar2Cartesian(radius, theta);
					let pos = (centerSpawnOrigin.Pos.x, centerSpawnOrigin.Pos.y + result.x, result.y);
					pos += offset;
					// Console.Printf("Spawn missile, pos:" .. pos .. " i:" .. i .. " theta:" .. theta .. " result:" .. result);
					let ball = DazzlerBall(centerSpawnOrigin.SpawnMissileXYZ(pos, target, "DazzlerBall"));
					if (ball) {
						ball.SetTranslation(i);
					} else {
						Console.Printf("WorldTick Circle Event encountered null ball");
					}
				}
				break;
			}

			case HORIZONTAL_LINE: {
				let NUM_BALLS = 20;
				let BALL_SPACING = 18.0;
				let height = events.eventArg0Floats[currentEventIdx];
				for(int i = 0; i < NUM_BALLS; ++i) {
					let posY = (i * BALL_SPACING) - ((NUM_BALLS * BALL_SPACING) / 2)+5;
					let pos = (centerSpawnOrigin.Pos.x, centerSpawnOrigin.Pos.y + posY, height);
					SpawnDazzlerShot(events.eventShotTypes[currentEventIdx], centerSpawnOrigin, pos, false, i);
				}
				break;
			}


			case BARRAGE_RTL: {
				barrageStartTimeTk = level.time;
				barrageMaxBalls = 10;
				barrageNumBallsFired = 0;
				barrageType = RTL;
				barrageHeight = events.eventArg0Floats[currentEventIdx];
				break;
			}

			case BARRAGE_LTR: {
				barrageStartTimeTk = level.time;
				barrageMaxBalls = 10;
				barrageNumBallsFired = 0;
				barrageType = LTR;
				barrageHeight = events.eventArg0Floats[currentEventIdx];
				break;
			}

			case NOOP:
				break;

			case HUD_1:
				Console.MidPrint("BIGFONT", "1");
				break;

			case HUD_2:
				Console.MidPrint("BIGFONT", "2");
				break;

			case HUD_3:
				Console.MidPrint("BIGFONT", "3");
				break;

			case HUD_4:
				Console.MidPrint("BIGFONT", "4");
				break;

			case HUD_GO:
				Console.MidPrint("BIGFONT", "GO!");
				break;

			case HUD_JUMP:
				// Console.MidPrint("BIGFONT", "JUMP!");
				player.ACS_NamedExecute("DazzlerPrintJump", 0);
				break;

			case HUD_CROUCH:
				// Console.MidPrint("BIGFONT", "CROUCH!");
				player.ACS_NamedExecute("DazzlerPrintCrouch", 0);
				break;

			default:
				ThrowAbortException("Unknown event type: %d", currentEventType);
		}
	}

	void SpawnDazzlerShot(DazzlerShotType shotType, Actor spawnOrigin, Vector3 pos, bool useRandomTranslation = false, int translationIdx = 0) {
		switch (shotType) {
			case SHOT_NONE:
				return;
			case DAZZLER_BALL: {
				let ball = DazzlerBall(spawnOrigin.SpawnMissileXYZ(pos, target, "DazzlerBall"));
				if (ball) {
					if (useRandomTranslation) {
						ball.SetRandomTranslation();
					} else {
						ball.SetTranslation(translationIdx);
					}
				} else {
					Console.Printf("SpawnDazzlerShot encountered null ball");
				}
				return;
			}
			case DAZZLER_HEALTH: {
				spawnOrigin.SpawnMissileXYZ(pos, target, "DazzlerHealth");
				return;
			}
			default:
				ThrowAbortException("Unknown dazzler shot type: %d", shotType);
		}
	}

	void QueueDanceSequence() {
		Console.Printf("DazzlerPowerHandler#QueueDanceSequence level.time:" .. level.time .. " MSTime:" .. MSTime());
		danceQueueTimeTk = level.time;
		Console.MidPrint("BIGFONT", "Get ready in 3, 2, 1...");
	}

	void StartDanceSequence() {
		Console.Printf("DazzlerPowerHandler#StartDanceSequence CHEAT_INVINCIBLE:" .. CHEAT_INVINCIBLE .. " level.time:" .. level.time .. " MSTime:" .. MSTime());
		Console.MidPrint("BIGFONT", "Let's jam!");
		danceStartTimeTk = level.time;
		danceStartTimeMs = MSTime();
		danceStartSync = calculateSync(danceStartTimeTk, danceStartTimeMs);
		// S_ChangeMusic(String music_name, int order = 0, bool looping = true, bool force = false)
		// Force restart of music if already playing
		S_ChangeMusic("*", force: true);
		S_ChangeMusic("music/petty-0.75-clicktrack.ogg", force: true);

		// Close exit door
		Floor_Stop(EXIT_DOOR_SECTOR_TAG);
		Floor_MoveToValue(EXIT_DOOR_SECTOR_TAG, 128, 8 + 64);
 		// TODO: Disable A_SetHealth and re-enable A_ResetHealth
		// player.A_ResetHealth();
		player.A_SetHealth(2);
		player.SetInventory("DazzlerAskForSkipInventory", 0);

		SetCheeringActorState(true);
	}

	void SkipDanceSequence() {
		Console.Printf("DazzlerPowerHandler#SkipDanceSequence");
		OnPlayerWin(true);
	}

	void EndDanceSequence() {
		Console.Printf("DazzlerPowerHandler#EndDanceSequence");
		currentEventIdx = 0;
		danceStartTimeTk = 0;
		// Restore default music
		S_ChangeMusic("D_STALKS");

		// Open exit door
		Floor_Stop(EXIT_DOOR_SECTOR_TAG);
		Floor_MoveToValue(EXIT_DOOR_SECTOR_TAG, 64, 8);

		player.A_ResetHealth();

		SetCheeringActorState(false);
	}

	bool CheckDesync() {
		let currentSync = CalculateSync(level.time, MSTime());
		let desync = Abs(currentSync - danceStartSync);
		// Console.Printf("DazzlerHandler#WorldTick desync check level.time:" .. level.time .. " MSTime:" .. MSTime() .. " currentSync:" .. currentSync .. " danceStartSync:" .. danceStartSync .. " Desync:" .. desync);
		if (desync > DESYNC_THRESHOLD_S) {
			Console.Printf("Desync detected!");
			// MidPrint(Font fontname, string textlabel, bool bold = false);
			// let font = Font.GetFont("SMALLFONT");
			// Console.MidPrint(font, "Don't you know it's rude to not pay attention during a performance? Please don't pause the game while we are dancing. Let's try that again...", bold: false);
			// CallBus.PrintDazzlerDesyncWarning();
			// Console.MidPrint("BIGFONT", "Don't you know it's rude to not pay attention during a performance?\nPlease don't pause the game while we are dancing.\nLet's try that again...");
			EndDanceSequence();
			player.ACS_NamedExecute("DazzlerPrintDesync", 0);
			return true;
		}
		return false;
	}

	/**
	 * Calculates the drift in sync between wall time and sim time, in fractional seconds
	 */
	float CalculateSync(float ticks, uint epochMs) {
			let ticksInSeconds = (ticks / 35.0);
			float epochMsInSeconds = epochMs / 1000.0;
			let sync = ticksInSeconds - epochMsInSeconds;
			// Console.Printf("DazzlerPowerHandler#calculateSync(ticks:" .. ticks .. " epochMs:" .. epochMs .. ") => ticksInSeconds:" .. ticksInSeconds .. " - epochMsInSeconds" .. epochMsInSeconds .. " = sync:" .. sync);
			return sync;
	}

	void SetCheeringActorState(bool cheering) {
		cheeringActorFinder.Reinit();
		let actor = cheeringActorFinder.Next(); 
		while (actor != null) {
			if (cheering) {
				actor.SetStateLabel("Cheer");
			} else {
				actor.SetStateLabel("Spawn");
			}
			actor = cheeringActorFinder.Next();
		}
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
