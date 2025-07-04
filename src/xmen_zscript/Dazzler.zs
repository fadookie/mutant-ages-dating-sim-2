class Dazzler: Actor
{
	Default
	{
    +FRIENDLY
    +BUDDHA
    +NOBLOOD
    +LOOKALLAROUND
    PainChance 0;
		// Speed 0;
	}
	
	States
	{
		Spawn: //used as idle state 
		DZLR A 10 A_Look; //actively looks for player
		Loop;
		
		Throw:
		DZLR BCDEFGH 4 A_Look;
		Goto Spawn;
		
		// See:  
		// CDBB AB 10 A_Chase;
		// goto spawn;
		
		// Pain:  //pain frames 
		// CDBB A 2 ACS_NamedExecute("coffeehitboss",0);
		// CDBB B 2 A_Pain;
		// Goto See;
		
		// Melee:     //works like a switch statement , should carry down
		// Missile:
		// CDBB A 8 A_FaceTarget;
		// CDBB AB 8 A_BruisAttack;
		// Goto See;
		
		// Death:
		// Stop;
	}
	
	// override int DamageMobj(Actor inflictor, Actor source, int damage, Name mod, int flags, double angle) {
	// 	lastDamageWasCoffee = inflictor.GetClassName() == "CoffeeMug_Missile";
	// 	bFriendly = lastDamageWasCoffee;
	// 	if (!lastDamageWasCoffee) {
	// 		source.bBuddha = false; // Actually kill target/player if possible
	// 	}
	// 	// Console.DebugPrintf(DMSG_SPAMMY, "Damaged by inflictor:" .. inflictor.GetClassName() .. " lastDamageWasCoffee:" .. lastDamageWasCoffee);
	// 	return super.DamageMobj(inflictor, source, damage, mod, flags, angle);
	// }
}


class DazzlerBall : DoomImpBall
{
	Default
	{
		Damage 1;
		DeathSound "";
	// 	Height 64;
  //   MissileHeight 64;
  }

	// States
	// {
	// Spawn:
	// 	BAL1 AB 4 BRIGHT Offset(10,42);
	// 	Loop;
  // }

	const JUMP_TRANSLATION = "PurpleDesat";

	const CROUCH_TRANSLATION = "OrangeDesat";

  static const String RAINBOW_TRANSLATIONS[] =
  {
      // "GreenBall",
      // "Ice"
      // "BlueBall",
      // "BlueColorize",
      "BlueDesat",
      "GreenDesat",
      "YellowDesat",
      "PinkDesat"
  };

	override void PostBeginPlay() {
		super.PostBeginPlay();
		// Console.DebugPrintf(DMSG_SPAMMY, "DazzlerBall init");
    // SetRandomTranslation();

		// Make SeeSound a bit quieter
		A_SoundVolume(CHAN_VOICE, 0.1);
  }

  void SetRandomTranslation() {
    int randIdx = Random(0, RAINBOW_TRANSLATIONS.Size() - 1);
    // int randIdx = (TID - 1) % RAINBOW_TRANSLATIONS.Size();
    // int randIdx = 0;
    // Console.DebugPrintf(DMSG_SPAMMY, "TID" .. TID .. ", randIdx:" .. randIdx);
    SetTranslation(randIdx);
  }

  void SetTranslation(int translationIdx) {
    let randTranslation = RAINBOW_TRANSLATIONS[translationIdx % RAINBOW_TRANSLATIONS.Size()];
		//Console.DebugPrintf(DMSG_SPAMMY, "DazzlerBall#SetTranslation index:" .. translationIdx .. ", randTranslation:" .. randTranslation);
		A_SetTranslation(randTranslation);
  }
}

class DazzlerHealth : Actor
{
	Default
	{
		Radius 6;
		Height 8;
		Speed 10;
		FastSpeed 20;
		Damage 0;
		Projectile;
		//+RANDOMIZE
		//+ZDOOMTRANS
		//RenderStyle "Add";
		//Alpha 1;
		//SeeSound "imp/attack";
		//DeathSound "imp/shotx";

		// Inventory.Amount 10;
		// Inventory.PickupMessage "$GOTSTIM";
	}
	States
	{
	Spawn:
		DHEA A 4;
		BAL1 AB 4 BRIGHT;
		Loop;
	Death:
		TNT1 A 1;
		Stop;
	}

	override int SpecialMissileHit(Actor victim) {
		// Heal target
		victim.GiveBody(5);
		victim.A_StartSound("misc/health_pkup");
		return 0; // destroy projectile
	}
}
