Scriptname TBC_Tracker extends ReferenceAlias  

Actor Property PlayerRef auto


Event OnInit()
    Debug.Notification("TBC Initialized")
    RegisterForMenu("Crafting Menu")
    PO3_Events_Alias.RegisterForItemCrafted(self)
endEvent



Event OnMenuOpen(String menuName)
    if (menuName == "Crafting Menu")
        Debug.Notification("Opened crafting menu") ; DEBUG

    endif
EndEvent



Event OnItemCrafted(ObjectReference akBench, Location akLocation, Form akCreatedItem)
    Debug.Notification("Item Crafted")
    if(akBench.HasKeywordString("WICraftingSmithingTempering")) ;; sharpening wheel or armor workbench
        Debug.Notification("Item tempered at a tempering bench") ; DEBUG
    endif
EndEvent