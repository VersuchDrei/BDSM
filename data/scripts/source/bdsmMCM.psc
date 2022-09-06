ScriptName bdsmMCM Extends SKI_ConfigBase

bdsmLibs Property Libs Auto

Event OnConfigInit()
	Pages = new string[5]
	Pages[0] = "General"
	Pages[1] = "Item Customization"
	Pages[2] = "Escape Minigames"
	Pages[3] = "Player Customization"
	Pages[4] = "Debug"
EndEvent

Event OnPageReset(string Page)
	If Page == Pages[0]
		BuildGeneralPage()
	ElseIf Page == Pages[1]
		BuildItemPage()
	ElseIf Page == Pages[2]
		BuildMinigamePage()
	ElseIf Page == Pages[3]
		BuildPlayerPage()
	ElseIf Page == Pages[4]
		BuildDebugPage()
	EndIf
EndEvent

Function BuildGeneralPage()
	SetCursorFillMode(LEFT_TO_RIGHT)
	SetCursorPosition(0)
	AddHeaderOption("General Settings")
	SetCursorPosition(2)
	AddToggleOptionST("OID_ShowConfirmationMessage", "Equip Confirmation Message", Libs.ShowConfirmationMessage)
	SetCursorPosition(4)
	AddMenuOptionST("OID_UnlockMode", "Unlock Mode", Libs.UnlockModeOptions[Libs.bdsmUnlockMode.value As int])
	SetCursorPosition(6)
	AddToggleOptionST("OID_OpenGagsOnly", "Open Gags only", Libs.OpenGagsOnly)

	SetCursorPosition(10)
	AddHeaderOption("Locks")
	SetCursorPosition(12)
	AddToggleOptionST("OID_ExactKeysOnly", "exact Keys only", Libs.ExactKeysOnly)
	SetCursorPosition(14)
	AddToggleOptionST("OID_ConsumeKeys", "consume Keys", Libs.ConsumeKeys)

	SetCursorPosition(1)
	AddHeaderOption("Physics Controls")
	SetCursorPosition(3)
	AddToggleOptionST("OID_ControlBreastPhysics", "Breasts", Libs.ControlBreastPyhsics)
	SetCursorPosition(5)
	AddToggleOptionST("OID_ControlBellyPhysics", "Belly", Libs.ControlBellyPyhsics)
	SetCursorPosition(7)
	AddToggleOptionST("OID_ControlButtPhysics", "Butt", Libs.ControlButtPyhsics)
	SetCursorPosition(9)
	AddToggleOptionST("OID_ControlPenisPhysics", "Penis", Libs.ControlPenisPyhsics)
	SetCursorPosition(11)
	AddToggleOptionST("OID_ControlLegPhysics", "Legs", Libs.ControlLegPyhsics)
EndFunction

Function BuildItemPage()
	SetCursorFillMode(LEFT_TO_RIGHT)
	SetCursorPosition(0)
	AddHeaderOption("Gags")
	SetCursorPosition(2)
	AddToggleOptionST("OID_AllGagsAllowFood", "all Gags allow Food", Libs.AllGagsAllowFood)
	SetCursorPosition(4)
	AddSliderOptionST("OID_GagOpenShoutPenalty", "Open Gag Shout Penalty %", Libs.bdsmGagOpenShoutPenalty.value, "{0}")

	SetCursorPosition(8)
	AddHeaderOption("Blindfolds")
	SetCursorPosition(10)
	AddSliderOptionST("OID_RestrainSightVisionRange", "Vision Range", Libs.bdsmRestrainSightVisionRange.value, "{0}")

	SetCursorPosition(14)
	AddHeaderOption("Chains/Heels")
	SetCursorPosition(16)
	AddSliderOptionST("OID_SlowSpeedPenalty", "Slow Speed Penalty %", Libs.bdsmSlowSpeedPenalty.value, "{0}")

	SetCursorPosition(1)
	AddHeaderOption("Mittens")
	SetCursorPosition(3)
	AddSliderOptionST("OID_MittensSpellPenalty", "Spell Penalty %", Libs.bdsmMittensSpellPenalty.value, "{0}")
	SetCursorPosition(5)
	AddSliderOptionST("OID_MittensWeaponPenalty", "Weapon Penalty %", Libs.bdsmMittensWeaponPenalty.value, "{0}")
	SetCursorPosition(7)
	AddSliderOptionST("OID_MittensLockpickPenalty", "Lockpicking Penalty %", Libs.bdsmMittensLockpickPenalty.value, "{0}")

	;SetCursorPosition(11)
	;AddHeaderOption("Yokes")
	;SetCursorPosition(13)
	;AddSliderOptionST("OID_YokeSpellPenalty", "Spell Penalty %", Libs.bdsmYokeSpellPenalty.value, "{0}")
EndFunction

Function BuildMinigamePage()
	SetCursorFillMode(LEFT_TO_RIGHT)
	SetCursorPosition(0)
	AddHeaderOption("Struggle")
	SetCursorPosition(2)
	AddSliderOptionST("OID_StruggleEscapeMult", "Escape Multiplier", Libs.bdsmStruggleEscapeMult.value, "{2}")
	SetCursorPosition(4)
	AddSliderOptionST("OID_StruggleStaminaMult", "Stamina Multiplier", Libs.bdsmStruggleStaminaMult.value, "{2}")
	SetCursorPosition(6)
	AddKeyMapOptionST("OID_StruggleKey1", "Key 1", Libs.bdsmStruggleKey1.value As int)
	SetCursorPosition(8)
	AddKeyMapOptionST("OID_StruggleKey2", "Key 2", Libs.bdsmStruggleKey2.value As int)
	SetCursorPosition(10)
	AddKeyMapOptionST("OID_StruggleKey3", "Key 3", Libs.bdsmStruggleKey3.value As int)
	SetCursorPosition(12)
	AddKeyMapOptionST("OID_StruggleKey4", "Key 4", Libs.bdsmStruggleKey4.value As int)
EndFunction

Function BuildPlayerPage()
	SetCursorFillMode(LEFT_TO_RIGHT)
	SetCursorPosition(0)
	AddHeaderOption("Characteristics")
	SetCursorPosition(2)
	AddSliderOptionST("OID_PlayerBondageLover", "Bondage Lover", Libs.GetFactionRankUnsigned(Libs.PlayerRef, Libs.bdsmBondageLoverFaction), "{0}")
	SetCursorPosition(4)
	AddSliderOptionST("OID_PlayerSadist", "Sadist", Libs.GetFactionRankUnsigned(Libs.PlayerRef, Libs.bdsmSadistFaction), "{0}")
	SetCursorPosition(6)
	AddSliderOptionST("OID_PlayerMasochist", "Masochist", Libs.GetFactionRankUnsigned(Libs.PlayerRef, Libs.bdsmMasochistFaction), "{0}")
EndFunction

Function BuildDebugPage()
	SetCursorFillMode(LEFT_TO_RIGHT)
	SetCursorPosition(0)
	AddTextOptionST("OID_FreePlayer", "Free me!", "click here")
	SetCursorPosition(2)
	AddSliderOptionST("OID_PlayerDominant", "Player Dominant", Libs.GetFactionRankUnsigned(Libs.PlayerRef, Libs.bdsmDominantFaction), "{0}")
	SetCursorPosition(4)
	AddSliderOptionST("OID_PlayerSubmissive", "Player Submissive", Libs.GetFactionRankUnsigned(Libs.PlayerRef, Libs.bdsmSubmissiveFaction), "{0}")
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; General Settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

State OID_ShowConfirmationMessage
	Event OnHighlightST()
		SetInfoText("When disabled equipped items will be locked direclty without asking for confirmation.")
	EndEvent

	Event OnSelectST()
		float newValue = 1 - Libs.bdsmShowConfirmationMessage.value
		Libs.bdsmShowConfirmationMessage.value = newValue
		SetToggleOptionValueST(newValue)
	EndEvent
EndState

State OID_UnlockMode
	Event OnHighlightST()
		SetInfoText("affects what unlock option is chosen\nmanual - always choose manually\nsemi - if only one is available do that automatically\nauto - always choose the first one available automatically")
	EndEvent

	Event OnMenuOpenST()
		SetMenuDialogOptions(Libs.UnlockModeOptions)
		SetMenuDialogStartIndex(Libs.bdsmUnlockMode.Value As int)
		SetMenuDialogDefaultIndex(0)
	EndEvent

	Event OnMenuAcceptST(int index)
		Libs.bdsmUnlockMode.value = index
		SetMenuOptionValueST(Libs.UnlockModeOptions[index])
	EndEvent

	Event OnDefaultST()
		Libs.bdsmUnlockMode.value = 0
		SetMenuOptionValueST(Libs.UnlockModeOptions[0])
	EndEvent
EndState

State OID_OpenGagsOnly
	Event OnHighlightST()
		SetInfoText("When enabled will not automatically equip gags that prevent eating. It is not guaranteed that addons will respect this setting, though.")
	EndEvent

	Event OnSelectST()
		float newValue = 1 - Libs.bdsmOpenGagsOnly.value
		Libs.bdsmOpenGagsOnly.value = newValue
		SetToggleOptionValueST(newValue)
	EndEvent
EndState

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Lock Settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
State OID_ExactKeysOnly
	Event OnHighlightST()
		SetInfoText("When enabled higher level keys will not be used for lower level locks.")
	EndEvent

	Event OnSelectST()
		float newValue = 1 - Libs.bdsmExactKeysOnly.value
		Libs.bdsmExactKeysOnly.value = newValue
		SetToggleOptionValueST(newValue)
	EndEvent
EndState

State OID_ConsumeKeys
	Event OnHighlightST()
		SetInfoText("When enabled unlocking an item will consume the key.")
	EndEvent

	Event OnSelectST()
		float newValue = 1 - Libs.bdsmConsumeKeys.value
		Libs.bdsmConsumeKeys.value = newValue
		SetToggleOptionValueST(newValue)
	EndEvent
EndState

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Physics Settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
State OID_ControlBreastPhysics
	Event OnHighlightST()
		SetInfoText("When enabled some restraints (e.g. chastity bras) will disable breast physics.")
	EndEvent

	Event OnSelectST()
		float newValue = 1 - Libs.bdsmControlBreastPhysics.value
		Libs.bdsmControlBreastPhysics.value = newValue
		SetToggleOptionValueST(newValue)
	EndEvent
EndState

State OID_ControlBellyPhysics
	Event OnHighlightST()
		SetInfoText("When enabled some restraints (e.g. corsets) will disable belly physics.")
	EndEvent

	Event OnSelectST()
		float newValue = 1 - Libs.bdsmControlBellyPhysics.value
		Libs.bdsmControlBellyPhysics.value = newValue
		SetToggleOptionValueST(newValue)
	EndEvent
EndState

State OID_ControlButtPhysics
	Event OnHighlightST()
		SetInfoText("When enabled some restraints (e.g. chastity belts) will disable butt physics.")
	EndEvent

	Event OnSelectST()
		float newValue = 1 - Libs.bdsmControlButtPhysics.value
		Libs.bdsmControlButtPhysics.value = newValue
		SetToggleOptionValueST(newValue)
	EndEvent
EndState

State OID_ControlPenisPhysics
	Event OnHighlightST()
		SetInfoText("When enabled some restraints (e.g. cock cages) will disable penis physics.")
	EndEvent

	Event OnSelectST()
		float newValue = 1 - Libs.bdsmControlPenisPhysics.value
		Libs.bdsmControlPenisPhysics.value = newValue
		SetToggleOptionValueST(newValue)
	EndEvent
EndState

State OID_ControlLegPhysics
	Event OnHighlightST()
		SetInfoText("When enabled some restraints (e.g. restrictive thigh high boots) will disable leg physics.")
	EndEvent

	Event OnSelectST()
		float newValue = 1 - Libs.bdsmControlLegPhysics.value
		Libs.bdsmControllegPhysics.value = newValue
		SetToggleOptionValueST(newValue)
	EndEvent
EndState

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Item Settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
State OID_AllGagsAllowFood
	Event OnHighlightST()
		SetInfoText("When enabled gags will not prevent eating / drinking potions.")
	EndEvent

	Event OnSelectST()
		float newValue = 1 - Libs.bdsmAllGagsAllowFood.value
		Libs.bdsmAllGagsAllowFood.value = newValue
		SetToggleOptionValueST(newValue)
	EndEvent
EndState

State OID_GagOpenShoutPenalty
	Event OnHighlightST()
		SetInfoText("Penalty for shouts while wearing an open gag. 100 will prevent equipping.")
	EndEvent

	Event OnSliderOpenST()
		SetSliderDialogStartValue(Libs.bdsmGagOpenShoutPenalty.value)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(10)
	EndEvent

	Event OnSliderAcceptST(float Value)
		Libs.bdsmGagOpenShoutPenalty.value = Value
		SetSliderOptionValueST(Value, "{0}")
	EndEvent
EndState

State OID_RestrainSightVisionRange
	Event OnHighlightST()
		SetInfoText("Vision range while blindfolded. Note: This ranges from the camera in third person, not the player character.")
	EndEvent

	Event OnSliderOpenST()
		SetSliderDialogStartValue(Libs.bdsmRestrainSightVisionRange.value)
		SetSliderDialogDefaultValue(500)
		SetSliderDialogRange(300, 2000)
		SetSliderDialogInterval(50)
	EndEvent

	Event OnSliderAcceptST(float Value)
		Libs.bdsmRestrainSightVisionRange.value = Value
		SetSliderOptionValueST(Value, "{0}")
	EndEvent
EndState

State OID_SlowSpeedPenalty
	Event OnHighlightST()
		SetInfoText("Reduction to movement speed while wearing slowing restraints (ankle chains / heels). Carful: This stacks additive with other modifiers to movement speed and a total value of 0 or less will cause you to run at default speed.")
	EndEvent

	Event OnSliderOpenST()
		SetSliderDialogStartValue(Libs.bdsmSlowSpeedPenalty.value)
		SetSliderDialogDefaultValue(30)
		SetSliderDialogRange(10, 100)
		SetSliderDialogInterval(10)
	EndEvent

	Event OnSliderAcceptST(float Value)
		Libs.bdsmSlowSpeedPenalty.value = Value
		SetSliderOptionValueST(Value, "{0}")
	EndEvent
EndState

State OID_MittensSpellPenalty
	Event OnHighlightST()
		SetInfoText("Penalty for spells while wearing mittens. 100 will prevent equipping.")
	EndEvent

	Event OnSliderOpenST()
		SetSliderDialogStartValue(Libs.bdsmMittensSpellPenalty.value)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(10)
	EndEvent

	Event OnSliderAcceptST(float Value)
		Libs.bdsmMittensSpellPenalty.value = Value
		SetSliderOptionValueST(Value, "{0}")
	EndEvent
EndState

State OID_MittensWeaponPenalty
	Event OnHighlightST()
		SetInfoText("Penalty for weapon damage while wearing mittens. 100 will prevent equipping.")
	EndEvent

	Event OnSliderOpenST()
		SetSliderDialogStartValue(Libs.bdsmMittensWeaponPenalty.value)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(10)
	EndEvent

	Event OnSliderAcceptST(float Value)
		Libs.bdsmMittensWeaponPenalty.value = Value
		SetSliderOptionValueST(Value, "{0}")
	EndEvent
EndState

State OID_MittensLockpickPenalty
	Event OnHighlightST()
		SetInfoText("Penalty for lockpicking while wearing mittens. 100 will prevent equipping.")
	EndEvent

	Event OnSliderOpenST()
		SetSliderDialogStartValue(Libs.bdsmMittensLockpickPenalty.value)
		SetSliderDialogDefaultValue(80)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(10)
	EndEvent

	Event OnSliderAcceptST(float Value)
		Libs.bdsmMittensLockpickPenalty.value = Value
		SetSliderOptionValueST(Value, "{0}")
	EndEvent
EndState

State OID_YokeSpellPenalty
	Event OnHighlightST()
		SetInfoText("Penalty for spells while wearing yoke. 100 will prevent equipping.")
	EndEvent

	Event OnSliderOpenST()
		SetSliderDialogStartValue(Libs.bdsmYokeSpellPenalty.value)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(10)
	EndEvent

	Event OnSliderAcceptST(float Value)
		Libs.bdsmYokeSpellPenalty.value = Value
		SetSliderOptionValueST(Value, "{0}")
	EndEvent
EndState

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;; Minigame Struggle Settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
State OID_StruggleEscapeMult
	Event OnHighlightST()
		SetInfoText("Multiplier for your progression torwards escaping the item. Higher values make escaping easier.")
	EndEvent

	Event OnSliderOpenST()
		SetSliderDialogStartValue(Libs.bdsmStruggleEscapeMult.value)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(0, 10)
		SetSliderDialogInterval(0.01)
	EndEvent

	Event OnSliderAcceptST(float Value)
		Libs.bdsmStruggleEscapeMult.value = Value
		SetSliderOptionValueST(Value, "{2}")
	EndEvent
EndState

State OID_StruggleStaminaMult
	Event OnHighlightST()
		SetInfoText("Multiplier for the struggle stamina cost. Higher values make escaping harder.")
	EndEvent

	Event OnSliderOpenST()
		SetSliderDialogStartValue(Libs.bdsmStruggleStaminaMult.value)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(0, 10)
		SetSliderDialogInterval(0.01)
	EndEvent

	Event OnSliderAcceptST(float Value)
		Libs.bdsmStruggleStaminaMult.value = Value
		SetSliderOptionValueST(Value, "{2}")
	EndEvent
EndState

State OID_StruggleKey1
	Event OnHighlightST()
		SetInfoText("The first key used to struggle.")
	EndEvent

	Event OnKeyMapChangeST(int KeyCode, string ConflictControl, string ConflictName)
		Libs.bdsmStruggleKey1.value = KeyCode
		SetKeyMapOptionValueST(keyCode)
	EndEvent
EndState

State OID_StruggleKey2
	Event OnHighlightST()
		SetInfoText("The second key used to struggle.")
	EndEvent

	Event OnKeyMapChangeST(int KeyCode, string ConflictControl, string ConflictName)
		Libs.bdsmStruggleKey2.value = KeyCode
		SetKeyMapOptionValueST(keyCode)
	EndEvent
EndState

State OID_StruggleKey3
	Event OnHighlightST()
		SetInfoText("The third key used to struggle.")
	EndEvent

	Event OnKeyMapChangeST(int KeyCode, string ConflictControl, string ConflictName)
		Libs.bdsmStruggleKey3.value = KeyCode
		SetKeyMapOptionValueST(keyCode)
	EndEvent
EndState

State OID_StruggleKey4
	Event OnHighlightST()
		SetInfoText("The fourth key used to struggle.")
	EndEvent

	Event OnKeyMapChangeST(int KeyCode, string ConflictControl, string ConflictName)
		Libs.bdsmStruggleKey4.value = KeyCode
		SetKeyMapOptionValueST(keyCode)
	EndEvent
EndState

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Player Settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
State OID_PlayerBondageLover
	Event OnHighlightST()
		SetInfoText("Players attraction to being tied up.")
	EndEvent

	Event OnSliderOpenST()
		SetSliderDialogStartValue(Libs.GetFactionRankUnsigned(Libs.PlayerRef, Libs.bdsmBondageLoverFaction))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 10)
		SetSliderDialogInterval(1)
	EndEvent

	Event OnSliderAcceptST(float Value)
		Libs.SetFactionRankSave(Libs.PlayerRef, Libs.bdsmBondageLoverFaction, Value As int)
		Libs.bdsmMittensLockpickPenalty.value = Value
		SetSliderOptionValueST(Value, "{0}")
	EndEvent
EndState

State OID_PlayerSadist
	Event OnHighlightST()
		SetInfoText("Players sadism level.")
	EndEvent

	Event OnSliderOpenST()
		SetSliderDialogStartValue(Libs.GetFactionRankUnsigned(Libs.PlayerRef, Libs.bdsmSadistFaction))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 10)
		SetSliderDialogInterval(1)
	EndEvent

	Event OnSliderAcceptST(float Value)
		Libs.SetFactionRankSave(Libs.PlayerRef, Libs.bdsmSadistFaction, Value As int)
		Libs.bdsmMittensLockpickPenalty.value = Value
		SetSliderOptionValueST(Value, "{0}")
	EndEvent
EndState

State OID_PlayerMasochist
	Event OnHighlightST()
		SetInfoText("Players masochism level.")
	EndEvent

	Event OnSliderOpenST()
		SetSliderDialogStartValue(Libs.GetFactionRankUnsigned(Libs.PlayerRef, Libs.bdsmMasochistFaction))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 10)
		SetSliderDialogInterval(1)
	EndEvent

	Event OnSliderAcceptST(float Value)
		Libs.SetFactionRankSave(Libs.PlayerRef, Libs.bdsmMasochistFaction, Value As int)
		Libs.bdsmMittensLockpickPenalty.value = Value
		SetSliderOptionValueST(Value, "{0}")
	EndEvent
EndState

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Debug Settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

State OID_PlayerDominant
	Event OnHighlightST()
		SetInfoText("Players dominance level. This is supposed to raise by dialogue choices in addons. This setting is just for debugging.")
	EndEvent

	Event OnSliderOpenST()
		SetSliderDialogStartValue(Libs.GetFactionRankUnsigned(Libs.PlayerRef, Libs.bdsmDominantFaction))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(10)
	EndEvent

	Event OnSliderAcceptST(float Value)
		Libs.SetFactionRankSave(Libs.PlayerRef, Libs.bdsmDominantFaction, Value As int)
		Libs.bdsmMittensLockpickPenalty.value = Value
		SetSliderOptionValueST(Value, "{0}")
	EndEvent
EndState

State OID_PlayerSubmissive
	Event OnHighlightST()
		SetInfoText("Players submission level. This is supposed to raise by dialogue choices in addons. This setting is just for debugging.")
	EndEvent

	Event OnSliderOpenST()
		SetSliderDialogStartValue(Libs.GetFactionRankUnsigned(Libs.PlayerRef, Libs.bdsmSubmissiveFaction))
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(10)
	EndEvent

	Event OnSliderAcceptST(float Value)
		Libs.SetFactionRankSave(Libs.PlayerRef, Libs.bdsmSubmissiveFaction, Value As int)
		Libs.bdsmMittensLockpickPenalty.value = Value
		SetSliderOptionValueST(Value, "{0}")
	EndEvent
EndState