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
	// 	// A_Log("Damaged by inflictor:" .. inflictor.GetClassName() .. " lastDamageWasCoffee:" .. lastDamageWasCoffee);
	// 	return super.DamageMobj(inflictor, source, damage, mod, flags, angle);
	// }
}


class DazzlerBall : DoomImpBall
{
  static const String TRANSLATIONS[] =
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
		// A_Log("DazzlerBall init");
    // SetRandomTranslation();
  }

  void SetRandomTranslation() {
    int randIdx = Random(0, TRANSLATIONS.Size() - 1);
    // int randIdx = (TID - 1) % TRANSLATIONS.Size();
    // int randIdx = 0;
    // Console.Printf("TID" .. TID .. ", randIdx:" .. randIdx);
    SetTranslation(randIdx);
  }

  void SetTranslation(int translationIdx) {
    let randTranslation = TRANSLATIONS[translationIdx % TRANSLATIONS.Size()];
		A_SetTranslation(randTranslation);
  }
}