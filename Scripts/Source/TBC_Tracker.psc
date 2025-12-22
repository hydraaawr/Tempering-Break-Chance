Scriptname TBC_Tracker extends ReferenceAlias  

Actor Property PlayerRef auto


Event OnInit()
    Debug.Notification("TBC Initialized")
    RegisterForMenu("Crafting Menu")
    PO3_Events_Alias.RegisterForItemCrafted(self)
endEvent



Event OnMenuOpen(String menuName)
    if (menuName == "Crafting Menu") ;&& (Game.GetCurrentCrosshairRef().HasKeywordString("isBlacksmithWorkbench") || Game.GetCurrentCrosshairRef().HasKeywordString("CraftingSmithingSharpeningWheel")))
        Debug.Notification("Opened a tempering bench") ; DEBUG

    endif
EndEvent



Event OnItemCrafted(ObjectReference akBench, Location akLocation, Form akCreatedItem)
    Debug.Notification("Item Crafted")
EndEvent