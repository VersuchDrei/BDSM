ScriptName bdsmEvents Extends Quest

bdsmLibs Property Libs Auto

Event OnInit()
	Maintenance()
EndEvent

Function Maintenance()
	Libs.BuildMCMArrays()

	If !Libs.PlayerRef.HasPerk(Libs.bdsmGagOpenShoutPenaltyPerk)
		Libs.PlayerRef.AddPerk(Libs.bdsmGagOpenShoutPenaltyPerk)
	EndIf

	If !Libs.PlayerRef.HasPerk(Libs.bdsmMittensLockpickPenaltyPerk)
		Libs.PlayerRef.AddPerk(Libs.bdsmMittensLockpickPenaltyPerk)
	EndIf

	If !Libs.PlayerRef.HasPerk(Libs.bdsmMittensSpellPenaltyPerk)
		Libs.PlayerRef.AddPerk(Libs.bdsmMittensSpellPenaltyPerk)
	EndIf

	If !Libs.PlayerRef.HasPerk(Libs.bdsmMittensWeaponPenaltyPerk)
		Libs.PlayerRef.AddPerk(Libs.bdsmMittensWeaponPenaltyPerk)
	EndIf

	If !Libs.PlayerRef.HasPerk(Libs.bdsmYokeSpellPenaltyPerk)
		Libs.PlayerRef.AddPerk(Libs.bdsmYokeSpellPenaltyPerk)
	EndIf
EndFunction