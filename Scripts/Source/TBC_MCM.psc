ScriptName TBC_MCM extends SKI_ConfigBase

; Properties
GlobalVariable Property _TBC_BaseBreakChance Auto
GlobalVariable Property _TBC_SkillScalingFactor Auto

; Control IDs
int baseBreakChanceOID
int skillScalingFactorOID

Event OnConfigInit()
    ModName = "Tempering Break Chance"
    Pages = new string[1]
    Pages[0] = "General Settings"
    
    ; Initialize default values only on first load
    _TBC_BaseBreakChance.SetValue(50.0)
    _TBC_SkillScalingFactor.SetValue(80.0)
EndEvent

Event OnPageReset(string page)
    SetTitleText("Tempering Break Chance Configuration")
    SetCursorFillMode(TOP_TO_BOTTOM)

    ; Break Chance Settings Section
    AddHeaderOption("Break Chance Settings")
    baseBreakChanceOID = AddSliderOption("Base Break Chance", _TBC_BaseBreakChance.GetValue(), "{0}%", OPTION_FLAG_NONE)

    ; Skill Scaling Factor Section
    AddHeaderOption("Skill Scaling Settings")
    skillScalingFactorOID = AddSliderOption("Skill Scaling Factor", _TBC_SkillScalingFactor.GetValue(), "{0}%", OPTION_FLAG_NONE)
EndEvent

; Slider Events
Event OnOptionSliderOpen(int option)
    if (option == baseBreakChanceOID)
        SetSliderDialogStartValue(_TBC_BaseBreakChance.GetValue())
        SetSliderDialogDefaultValue(50.0)    ; Default 50%
        SetSliderDialogRange(0.0, 100.0)     ; 0% to 100%
        SetSliderDialogInterval(1.0)         ; 1% increments
    elseif (option == skillScalingFactorOID)
        SetSliderDialogStartValue(_TBC_SkillScalingFactor.GetValue())
        SetSliderDialogDefaultValue(80.0)    ; Default 80%
        SetSliderDialogRange(0.0, 100.0)     ; 0% to 100%
        SetSliderDialogInterval(1.0)         ; 1% increments
    endif
EndEvent

Event OnOptionSliderAccept(int option, float value)
    if (option == baseBreakChanceOID)
        _TBC_BaseBreakChance.SetValue(value)
        SetSliderOptionValue(baseBreakChanceOID, value, "{0}%")
    elseif (option == skillScalingFactorOID)
        _TBC_SkillScalingFactor.SetValue(value)
        SetSliderOptionValue(skillScalingFactorOID, value, "{0}%")
    endif
EndEvent

Event OnOptionHighlight(int option)
    if (option == baseBreakChanceOID)
        SetInfoText("Base chance for an item to break during tempering. Default: 50%")
    elseif (option == skillScalingFactorOID)
        SetInfoText("How much the smithing level reduces break chance. Default: 80%")
    endif
EndEvent