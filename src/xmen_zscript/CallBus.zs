/**
 * This class acts as glue code to allow ACS to call into ZScript classes and handlers via ScriptCall() and player Actor
 */
class CallBus
{
  play static void TriggerClubEnter(Actor activator)
  {
		Console.Printf("CallBus.TriggerClubEnter");
    ClubMusicHandlerStatic clubMusicHandler = ClubMusicHandlerStatic(StaticEventHandler.Find("ClubMusicHandlerStatic"));
    if(clubMusicHandler) {
      clubMusicHandler.StartMusic();
    } else {
      Console.Printf("Error! ClubMusicHandlerStatic not found!");
    }
	}

  play static void StartDanceSequence(Actor activator)
  {
		Console.Printf("CallBus.StartDanceSequence");
    DazzlerPowerHandler dazzlerPowerHandler = DazzlerPowerHandler(EventHandler.Find("DazzlerPowerHandler"));
    if(dazzlerPowerHandler) {
      dazzlerPowerHandler.QueueDanceSequence();
    } else {
      Console.Printf("Error! DazzlerPowerHandler not found!");
    }
  }

  play static void SkipDanceSequence(Actor activator)
  {
		Console.Printf("CallBus.SkipDanceSequence");
    DazzlerPowerHandler dazzlerPowerHandler = DazzlerPowerHandler(EventHandler.Find("DazzlerPowerHandler"));
    if(dazzlerPowerHandler) {
      dazzlerPowerHandler.SkipDanceSequence();
    } else {
      Console.Printf("Error! DazzlerPowerHandler not found!");
    }
  }

	play static PoochyPlayer FindPlayer() {
		let result = PoochyPlayer(players[consoleplayer].Mo);
		if (result == null) {
			Console.Printf("Error! No player found.");
		} else {
			Console.Printf("Found player: " .. result);
		}
		return result;
	}

	play static Dazzler FindDazzler() {
		ThinkerIterator finder = ThinkerIterator.Create("Dazzler");
		let result = Dazzler(finder.Next());
		if (result == null) {
			Console.Printf("Error! No Dazzler found.");
		} else {
			Console.Printf("Found Dazzler: " .. result);
		}
		return result;
	}

  play static Actor FindActor(int tid) {
		let actorFinder = level.CreateActorIterator(tid);
		return actorFinder.Next(); 
	}
}