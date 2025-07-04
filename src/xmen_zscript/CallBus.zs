/**
 * This class acts as glue code to allow ACS to call into ZScript classes and handlers via ScriptCall() and player Actor
 */
class CallBus
{
  play static void TriggerClubEnter(Actor activator)
  {
		Console.DebugPrintf(DMSG_SPAMMY, "CallBus.TriggerClubEnter");
    ClubMusicHandlerStatic clubMusicHandler = FindClubMusicHandler();
    clubMusicHandler.StartMusic();
	}

  play static void TriggerClubExit(Actor activator)
  {
		Console.DebugPrintf(DMSG_SPAMMY, "CallBus.TriggerClubExit");
    ClubMusicHandlerStatic clubMusicHandler = FindClubMusicHandler();
    clubMusicHandler.StopMusic();
	}

  play static void StartDanceSequence(Actor activator)
  {
		Console.DebugPrintf(DMSG_SPAMMY, "CallBus.StartDanceSequence");
    DazzlerPowerHandler dazzlerPowerHandler = DazzlerPowerHandler(EventHandler.Find("DazzlerPowerHandler"));
    if(dazzlerPowerHandler) {
      dazzlerPowerHandler.QueueDanceSequence();
    } else {
      ThrowAbortException("Error! DazzlerPowerHandler not found!");
    }
  }

  play static void SkipDanceSequence(Actor activator)
  {
		Console.DebugPrintf(DMSG_SPAMMY, "CallBus.SkipDanceSequence");
    DazzlerPowerHandler dazzlerPowerHandler = DazzlerPowerHandler(EventHandler.Find("DazzlerPowerHandler"));
    if(dazzlerPowerHandler) {
      dazzlerPowerHandler.SkipDanceSequence();
    } else {
      ThrowAbortException("Error! DazzlerPowerHandler not found!");
    }
  }

	play static ClubMusicHandlerStatic FindClubMusicHandler() {
    let clubMusicHandler = ClubMusicHandlerStatic(StaticEventHandler.Find("ClubMusicHandlerStatic"));
    if (clubMusicHandler == null) {
			ThrowAbortException("ClubMusicHandlerStatic was null");
		}
		return clubMusicHandler;
	}

	play static PoochyPlayer FindPlayer() {
		let result = PoochyPlayer(players[consoleplayer].Mo);
		if (result == null) {
			ThrowAbortException("Error! No player found.");
		} else {
			Console.DebugPrintf(DMSG_SPAMMY, "Found player: " .. result);
		}
		return result;
	}

	play static Dazzler FindDazzler() {
		ThinkerIterator finder = ThinkerIterator.Create("Dazzler");
		let result = Dazzler(finder.Next());
		if (result == null) {
			ThrowAbortException("Error! No Dazzler found.");
		} else {
			Console.DebugPrintf(DMSG_SPAMMY, "Found Dazzler: " .. result);
		}
		return result;
	}

  play static Actor FindActor(int tid) {
		let actorFinder = level.CreateActorIterator(tid);
		return actorFinder.Next(); 
	}
}