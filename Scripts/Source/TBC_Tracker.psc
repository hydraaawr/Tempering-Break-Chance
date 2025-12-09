Scriptname TBC_Tracker extends ReferenceAlias  

Event OnInit()
    Debug.Notification("TBC Initialized")
    PO3_Events_Alias.RegisterForItemCrafted(self)
endEvent


Event OnItemCrafted(ObjectReference akBench, Location akLocation, Form akCreatedItem)
    Debug.Notification("Item Crafted")
EndEvent