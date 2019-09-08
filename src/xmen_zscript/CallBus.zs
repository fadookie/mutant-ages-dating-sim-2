/**
 * This class acts as glue code to allow ACS to call into ZScript classes and handlers via ScriptCall() and player Actor
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

	play static PoochyPlayer FindPlayer() {
		ThinkerIterator playerFinder = ThinkerIterator.Create("PoochyPlayer");
		let playerResult = PoochyPlayer(playerFinder.Next());
		if (playerResult == null) {
			Console.Printf("Error! No player found.");
		} else {
			Console.Printf("Found player: " .. playerResult);
		}
		return playerResult;
	}

  play static Actor FindActor(int tid) {
		let actorFinder = ActorIterator.Create(tid);
		return actorFinder.Next(); 
	}
}