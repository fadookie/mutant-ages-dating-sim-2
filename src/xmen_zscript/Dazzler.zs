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
		A_Log("DazzlerBall init");
    SetRandomTranslation();
  }

  void SetRandomTranslation() {
    // int randIdx = Random(0, TRANSLATIONS.Size() - 1);
    int randIdx = (TID - 1) % TRANSLATIONS.Size();
    Console.Printf("TID" .. TID .. ", randIdx:" .. randIdx);
    String randTranslation = TRANSLATIONS[randIdx];
		A_SetTranslation(randTranslation);
  }
}