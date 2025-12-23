Scriptname TBC_Tracker extends ReferenceAlias  

Actor Property PlayerRef auto

; Base break chance (0.0 - 100.0, where 100.0 = 100%)
GlobalVariable Property _TBC_BaseBreakChance Auto
; How much the smithing level reduces break chance (0.0 - 100.0)
; At 100.0, level 100 smithing eliminates all break chance
GlobalVariable Property _TBC_SkillScalingFactor Auto


Event OnInit()
    Debug.Notification("TBC Initialized")
    PO3_Events_Alias.RegisterForItemCrafted(self)
endEvent



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
    Debug.Notification("Item Crafted")
    if(akBench.HasKeywordString("WICraftingSmithingTempering")) ;; sharpening wheel or armor workbench
        Debug.Notification("Item tempered at a tempering bench") ; DEBUG
        
        float smithingLevel = PlayerRef.GetActorValue("Smithing")
        float breakChance = CalculateBreakChance(smithingLevel)
        float roll = Utility.RandomFloat(0.0, 1.0)
        
        Debug.Notification("Break chance: " + breakChance + " | Roll: " + roll) ; DEBUG
        
        if (roll < breakChance)
            Debug.Notification("Item broke during tempering!")
            PlayerRef.RemoveItem(akCreatedItem, 1, true)
        endif
    endif
EndEvent