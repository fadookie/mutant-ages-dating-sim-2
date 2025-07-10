class XMenConversationMenu : ConversationMenu
{
	override int Init(StrifeDialogueNode CurNode, PlayerInfo player, int activereply) {
    // Console.Printf("XMenConversationMenu:Init");
    let res = super.Init(CurNode, player, activereply);

    // DontBlur = false;

    return res;
  }

  override bool DrawBackdrop() {
    // Console.Printf("XMenConversationMenu:DrawBackdrop");
    super.DrawBackdrop();
    return true; // Always dim background
  }
}