Scriptname TBC_Tracker extends ReferenceAlias  

Actor Property PlayerRef auto

; Base break chance (0.0 - 100.0, where 100.0 = 100%)
GlobalVariable Property _TBC_BaseBreakChance Auto
; How much the smithing level reduces break chance (0.0 - 100.0)
; At 100.0, level 100 smithing eliminates all break chance
GlobalVariable Property _TBC_SkillScalingFactor Auto

bool honedMetalActive = false ; 1.1.0 - Honed Metal compatibility fixed


Event OnInit()
    Debug.Notification("TBC Initialized")
    PO3_Events_Alias.RegisterForItemCrafted(self)
    RegisterForModEvent("HMServiceStarted", "OnHMServiceStarted")
    RegisterForModEvent("HMServiceFinished", "OnHMServiceFinished")
endEvent

;; 1.1.0 - Listen to HM events for compatibility fix
Event OnHMServiceStarted(string eventName, string strArg, float numArg, Form sender)
    honedMetalActive = true
    ;Debug.Notification("Honed Metal service started")
EndEvent

Event OnHMServiceFinished(string eventName, string strArg, float numArg, Form sender)
    honedMetalActive = false
    ;Debug.Notification("Honed Metal service finished")
EndEvent



float Function CalculateBreakChance(float smithingLevel)
    ; Break chance decreases as smithing level increases
    ; Formula: baseChance * (1 - (skillLevel / 100) * scalingFactor)
    float reduction = (smithingLevel / 100.0) * (_TBC_SkillScalingFactor.GetValue() / 100.0)
    float finalChance = (_TBC_BaseBreakChance.GetValue() / 100.0) * (1.0 - reduction)
    
    ; Clamp between 0 and base chance to prevent negative probs
    if (finalChance < 0.0)
        finalChance = 0.0
    endif
    
    return finalChance
EndFunction


Event OnItemCrafted(ObjectReference akBench, Location akLocation, Form akCreatedItem)
    ;Debug.Notification("Item Crafted") ; DEBUG
    if(akBench.HasKeywordString("WICraftingSmithingTempering")) ;; sharpening wheel or armor workbench
        ;Debug.Notification("Item tempered at a tempering bench") ; DEBUG
        
        ; Skip break chance if Honed Metal is active
        if honedMetalActive
            ;Debug.Notification("Honed Metal active, skipping break chance") ; DEBUG
            return
        endif
        
        float smithingLevel = PlayerRef.GetActorValue("Smithing")
        float breakChance = CalculateBreakChance(smithingLevel)
        float roll = Utility.RandomFloat(0.0, 1.0)
        
        ;Debug.Notification("Break chance: " + breakChance + " | Roll: " + roll) ; DEBUG
        
        if (roll < breakChance)
            Debug.Notification("Item broke during tempering!")
            PlayerRef.RemoveItem(akCreatedItem, 1, true)
        endif
    endif
EndEvent