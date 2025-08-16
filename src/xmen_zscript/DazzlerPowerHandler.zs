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
		HUD_WIN,
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
	const BOARD_CENTER_TELEPORT_DEST_TID = 175;
	const TARGET_TID = 999;
	const EXIT_DOOR_SECTOR_TAG = 715;
	const INNER_CIRCLE_DOOR_SECTOR_TAG = 716;
	const CHEERING_ACTOR_TID = 3;
	const DAZZLER_WIND_UP_SEEK_AHEAD_AMOUNT_SEC = 0.5;

	// Lose/Win condition stuff
	const PLAYER_FAILURES_BEFORE_SKIP_OPTION = 3;
	private int numPlayerFailures;
	private bool CHEAT_INVINCIBLE; // Player can't fail sequence

	private DazzlerPowerEventSequence events;
	private int currentEventIdx;
	private bool dazzlerWindUpTriggeredThisEvent;

	private int danceQueueTimeTk;

	private int danceStartTimeTk;
	private uint danceStartTimeMs;

	private int barrageStartTimeTk;
	private int barrageMaxBalls;
	private int barrageNumBallsFired;
	private float barrageHeight;
	private BarrageType barrageType;

	private PoochyPlayer player;
	private Dazzler dazzler;
	private Actor boardCenterTeleportDest;
	private Actor spawnOrigins[NUM_SPAWN_ORIGINS];
	private Actor centerSpawnOrigin;
	private Actor target;

	private Sound music;

	override void WorldLoaded(WorldEvent e) {
		Console.DebugPrintf(DMSG_SPAMMY, "DazzlerPowerHandler#WorldLoaded v2");

 		CHEAT_INVINCIBLE = false; // TODO: Disable

		music = Sound("el/dazzlerSong");
		
		events = New("DazzlerPowerEventSequence");
		events.Init();

		player = CallBus.FindPlayer();
		dazzler = CallBus.FindDazzler();
		boardCenterTeleportDest = CallBus.FindActor(BOARD_CENTER_TELEPORT_DEST_TID);

		for(int i = 0; i < NUM_SPAWN_ORIGINS; ++i) {
			let spawnOriginTID = SPAWN_ORIGIN_TID_RANGE_START + i;
			spawnOrigins[i] = CallBus.FindActor(spawnOriginTID);
			if (spawnOrigins[i] == null) {
				Console.DebugPrintf(DMSG_SPAMMY, "Error! No Dazzler spawnOrigin found for spawnOrigins[" .. i .. "], TID:" .. spawnOriginTID);
			} else {
				Console.DebugPrintf(DMSG_SPAMMY, "Found Dazzler spawnOrigin: spawnOrigins[" .. i .. "], TID:" .. spawnOriginTID .. " actor: ".. spawnOrigins[i]);
			}
		}
		centerSpawnOrigin = spawnOrigins[2];

		target = CallBus.FindActor(TARGET_TID);
		if (target == null) {
			Console.DebugPrintf(DMSG_SPAMMY, "Error! No Dazzler target found.");
		} else {
			Console.DebugPrintf(DMSG_SPAMMY, "Found Dazzler Target: " .. target);
		}

// 		boardSpot = FindActor(BOARD_SPOT_TID);
// 		if (boardSpot == null) {
// 			Console.DebugPrintf(DMSG_SPAMMY, "No board spot found with TID " .. BOARD_SPOT_TID .. ", creating one...");
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

		float currentEventTimeS = events.eventTimestampsS[currentEventIdx];
		let currentEventType = events.eventTypes[currentEventIdx];

		// Console.DebugPrintf(DMSG_SPAMMY, "timeSinceStartTk:" .. timeSinceStartTk .. " timeSinceStartS:" .. timeSinceStartS .. " currentEventTimeS:" .. currentEventTimeS);

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
			if (currentEventType == END) {
				Console.DebugPrintf(DMSG_SPAMMY, "END dance sequence event fired");
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
			// Console.DebugPrintf(DMSG_SPAMMY, "Barrage in progress, barrageStartTimeTk:" .. barrageStartTimeTk .. " timeSinceStart:" .. timeSinceBarrageStartTk);
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
				Console.DebugPrintf(DMSG_SPAMMY, "intervalIdx:" .. intervalIdx);
				// TODO: support health?
				let posY = (intervalIdx * BALL_SPACING) - ((NUM_BALLS * BALL_SPACING) / 2)+5;
				let pos = (centerSpawnOrigin.Pos.x, centerSpawnOrigin.Pos.y + posY, barrageHeight);
				let ball = DazzlerBall(centerSpawnOrigin.SpawnMissileXYZ(pos, target, "DazzlerBall"));
				if (ball) {
					SetBallTranslation(ball, pos, intervalIdx);
				} else {
					Console.DebugPrintf(DMSG_SPAMMY, "Barrage time slice encountered null ball");
				}
				Console.DebugPrintf(DMSG_SPAMMY, "Barrage FIRE, numFired:" .. barrageNumBallsFired .. " maxBalls:" .. barrageMaxBalls .. " intervalIdx:" .. intervalIdx);
				++barrageNumBallsFired;
				if (intervalIdx % 3 == 0) dazzler.SetStateLabel("Throw");
			}
			if (barrageNumBallsFired >= barrageMaxBalls) {
				Console.DebugPrintf(DMSG_SPAMMY, "Barrage terminate numFired:" .. barrageNumBallsFired .. " maxBalls:");
				barrageNumBallsFired = 0;
				barrageStartTimeTk = 0;
			}
		}
	}

	// Should only be called after reaching end of events list
	private void CheckWinCondition() {
		if (player.health > 1 || CHEAT_INVINCIBLE) {
			// Player won
			OnPlayerWin(false);
		} else {
			// Player was too hurt to win
			OnPlayerLose();
		}
	}

	private void OnPlayerWin(bool wasSkipped) {
		// let innerCircleLine = "\nI'll let you through to see my friends in the inner circle, go through the door to your right...";
		// if (wasSkipped) {
		// 	Console.MidPrint("BIGFONT", "Okay, your dance skills could use some work but you definitely tried your best." .. innerCircleLine);
		// } else {
		// 	Console.MidPrint("BIGFONT", "Nice footwork! You impressed me." .. innerCircleLine);
		// }
		player.GiveInventoryType("DazzlerAskForSkipInventory"); // Needed to skip to end of dialogue
		if (!wasSkipped) {
			player.GiveInventoryType("DazzlerWonInventory");
			dazzler.StartConversation(player);
		}
		Door_Open(INNER_CIRCLE_DOOR_SECTOR_TAG, 16);
	}

	private void OnPlayerLose() {
		numPlayerFailures++;

		if (numPlayerFailures >= PLAYER_FAILURES_BEFORE_SKIP_OPTION) {
			numPlayerFailures = 0;
			player.GiveInventoryType("DazzlerAskForSkipInventory");
			dazzler.StartConversation(player);
		} else {
			Console.MidPrint("BIGFONT", "Ooh, nice try, but you looked a little clumsy out there.\nWhy don't we give it another shot?");
		}
	}

	private void FireEvent(DazzlerEventType currentEventType, float currentEventTimeS) {
		Console.DebugPrintf(DMSG_SPAMMY, "Fire event[" .. currentEventIdx .. "] = type " .. currentEventType .. " at " .. currentEventTimeS);
		// Console.DebugPrintf(DMSG_SPAMMY, "DazzlerHandler#WorldTick event level.time:" .. level.time .. " MSTime:" .. MSTime() .. " currentSync:" .. currentSync .. " danceStartSync:" .. danceStartSync .. " Desync:" .. desync);
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
				SpawnDazzlerShot(events.eventShotTypes[currentEventIdx], spawnOrigin, pos);
				break;
			}

			case VERTICAL_LINE: {
				let originIndex = events.eventArg0Ints[currentEventIdx];
				let spawnOrigin = spawnOrigins[originIndex];
				let arg0Float = events.eventArg0Floats[currentEventIdx];
				let originZOffset = arg0Float == DazzlerPowerEventSequence.EVENT_ARG_NA ? 0 : arg0Float;
				let NUM_BALLS = 10;
				let BALL_SPACING = 15.0;
				for(int i = 0; i < NUM_BALLS; ++i) {
					let ballZOffset = i * BALL_SPACING;
					let pos = (spawnOrigin.Pos.x, spawnOrigin.Pos.y, spawnOrigin.Pos.z + originZOffset + ballZOffset);
					let ball = DazzlerBall(centerSpawnOrigin.SpawnMissileXYZ(pos, target, "DazzlerBall"));
					if (ball) {
						ball.SetTranslation(i);
					} else {
						Console.DebugPrintf(DMSG_SPAMMY, "SpawnBallLine encountered null ball");
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
					// Console.DebugPrintf(DMSG_SPAMMY, "Spawn missile, pos:" .. pos .. " i:" .. i .. " theta:" .. theta .. " result:" .. result);
					let ball = DazzlerBall(centerSpawnOrigin.SpawnMissileXYZ(pos, target, "DazzlerBall"));
					if (ball) {
						ball.SetTranslation(i);
					} else {
						Console.DebugPrintf(DMSG_SPAMMY, "WorldTick Circle Event encountered null ball");
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
					SpawnDazzlerShot(events.eventShotTypes[currentEventIdx], centerSpawnOrigin, pos, i);
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

			case HUD_WIN:
				Console.MidPrint("BIGFONT", "CLEAR!");
				break;

			default:
				ThrowAbortException("Unknown event type: %d", currentEventType);
		}
	}

	private void SpawnDazzlerShot(DazzlerShotType shotType, Actor spawnOrigin, Vector3 pos, int translationIdx = -1) {
		switch (shotType) {
			case SHOT_NONE:
				return;
			case DAZZLER_BALL: {
				let ball = DazzlerBall(spawnOrigin.SpawnMissileXYZ(pos, target, "DazzlerBall"));
				if (ball) {
					SetBallTranslation(ball, pos, translationIdx);
				} else {
					Console.DebugPrintf(DMSG_SPAMMY, "SpawnDazzlerShot encountered null ball");
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

	private void SetBallTranslation(DazzlerBall ball, Vector3 pos, int translationIdx = -1) {
		if (pos.z == DazzlerPowerEventSequence.JUMP_HEIGHT) {
			ball.A_SetTranslation(DazzlerBall.JUMP_TRANSLATION);
		} else if (pos.z == DazzlerPowerEventSequence.CROUCH_HEIGHT) {
			ball.A_SetTranslation(DazzlerBall.CROUCH_TRANSLATION);
		} else if (translationIdx >= 0) {
			ball.SetTranslation(translationIdx);
		} else {
			ball.SetRandomTranslation();
		}
	}

	void QueueDanceSequence() {
		Console.DebugPrintf(DMSG_SPAMMY, "DazzlerPowerHandler#QueueDanceSequence level.time:" .. level.time .. " MSTime:" .. MSTime());
		danceQueueTimeTk = level.time;
		player.Teleport(boardCenterTeleportDest.Pos, 0, true);
		Console.MidPrint("BIGFONT", "Get ready in 3, 2, 1...");
	}

	private void StartDanceSequence() {
		Console.DebugPrintf(DMSG_SPAMMY, "DazzlerPowerHandler#StartDanceSequence CHEAT_INVINCIBLE:" .. CHEAT_INVINCIBLE .. " level.time:" .. level.time .. " MSTime:" .. MSTime());
		Console.MidPrint("BIGFONT", "Let's jam!");
		danceStartTimeTk = level.time;
		danceStartTimeMs = MSTime();

		StartMusic();
		// S_ChangeMusic(String music_name, int order = 0, bool looping = true, bool force = false)
		// Force restart of music if already playing
		// S_ChangeMusic("*", force: true);
		// S_ChangeMusic("music/petty-0.75.ogg", force: true);

		// Close exit door
		Floor_Stop(EXIT_DOOR_SECTOR_TAG);
		Floor_MoveToValue(EXIT_DOOR_SECTOR_TAG, 128, 8 + 64);

 		// To force player to low health at beginning, uncomment A_SetHealth and comment out A_ResetHealth:
		// player.A_SetHealth(2);
		player.A_ResetHealth();
		player.SetInventory("DazzlerAskForSkipInventory", 0);

		SetCheeringActorState(true);
	}

	void SkipDanceSequence() {
		Console.DebugPrintf(DMSG_SPAMMY, "DazzlerPowerHandler#SkipDanceSequence");
		OnPlayerWin(true);
	}

	private void EndDanceSequence() {
		Console.DebugPrintf(DMSG_SPAMMY, "DazzlerPowerHandler#EndDanceSequence");
		currentEventIdx = 0;
		danceStartTimeTk = 0;

		StopMusic();

		// Open exit door
		Floor_Stop(EXIT_DOOR_SECTOR_TAG);
		Floor_MoveToValue(EXIT_DOOR_SECTOR_TAG, 64, 8);

		player.A_ResetHealth();

		SetCheeringActorState(false);
	}

	private void StartMusic() {
		CallBus.FindClubMusicHandler().StopMusic();
		S_ChangeMusic("music/silence.ogg", force: true);

		// Play music track at user's current music volume setting
		let musicVolumeCVar = CVar.GetCVar("snd_musicvolume", players[consoleplayer]).GetFloat();
		Console.DebugPrintf(DMSG_SPAMMY, "DazzlerPowerHandler.StartMusic musicVolumeCVar:" .. musicVolumeCVar .. " music:" .. music);
		if (player != null) {
			player.A_StartSound(music, CHAN_WEAPON, CHANF_DEFAULT /* pause while game is paused */, musicVolumeCVar);
		}
	}

	private void StopMusic() {
		player.A_StopSound(CHAN_WEAPON);
		CallBus.FindClubMusicHandler().StartMusic();
		// S_ChangeMusic("D_STALKS");
	}

	private void SetCheeringActorState(bool cheering) {
		let cheeringActorFinder = level.CreateActorIterator(CHEERING_ACTOR_TID);
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
}
