/**
 * This class acts as glue code to allow ACS to call into ZScript classes and handlers via ScriptCall()
 */
class CallBus : Actor
{
  // static CallBus _instance;

  // play static CallBus instance() {
  //   if (_instance) return _instance;
  //   _instance = CallBus(Spawn("CallBus"));
  //   return _instance;
  // }

	// override void PostBeginPlay()
  // {
  //   super.PostBeginPlay();
  // }

  play static void StartDanceSequence(Actor activator)
  {
		Console.Printf("CallBus.StartDanceSequence");
    DazzlerPowerHandler dazzlerPowerHandler = DazzlerPowerHandler(EventHandler.Find("DazzlerPowerHandler"));
    if(dazzlerPowerHandler) {
      dazzlerPowerHandler.StartDanceSequence();
    } else {
      Console.Printf("Error! DazzlerPowerHandler not found!");
    }
  }

  play void PrintDazzlerDesyncWarning() {
    ACS_NamedExecute("PrintDazzlerDesyncWarning", 0);
  }
}