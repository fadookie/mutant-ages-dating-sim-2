class CoffeeGuy : Actor //30014
{
	Default
	{
		+FRIENDLY
		+BUDDHA
		+NOBLOOD
		+LOOKALLAROUND
		
		PainChance 0;
	}
	
	int levitationStartTimeTk;

  States
  {
  Spawn:
    FHOC A 1;
    Loop;
		//goto Cheer;
  Cheer:
    FHOC A 0 {
			levitationStartTimeTk = level.time;
		}
		goto CheerBounce;
	CheerBounce:
    FHOC A 1 {
			int elapsedTimeTk = level.time - levitationStartTimeTk;
			// Console.Printf("CoffeeGuy CheerBounce frame elapsedTimeTk:" .. elapsedTimeTk);
			self.bNOGRAVITY = true;
			self.bFLY = true;
			Vector3 newpos = self.pos;
			newpos.z += sin((elapsedTimeTk + self.pos.x) * 20.0) * 0.75;
			self.SetOrigin(newpos, true);
		}
    Loop;
  }
}