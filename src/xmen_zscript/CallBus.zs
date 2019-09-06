/**
 * This class acts as glue code to allow ACS to call into ZScript classes and handlers via ScriptCall()
 */
class CallBus
{
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
}