
ScriptName bdsmActorImpl Extends bdsmActor

Function UnequipWeapons()
	Weapon wpn = GetEquippedWeapon(0)
	If wpn
		If wpn == Libs.Unarmed
			Return
		EndIf

		int weaponType = wpn.GetWeaponType()
		; unequipping two handed weapons will equip one handed weapons, so instead we simply equip the unarmed weapon
		If weaponType == 5 || weaponType == 6 || weaponType == 7 || weaponType == 9
			UnequipItemEx(wpn, 1, False)
			;EquipItemEx(Libs.Unarmed, 1, False, False)
			Return
		EndIf

		UnequipItemEx(wpn, 1, False)
	EndIf

	wpn = GetEquippedWeapon(1)
	If wpn
		UnequipItemEx(wpn, 2, False)
	EndIf
EndFunction

Function UnequipSpells()
	Spell spl = GetEquippedSpell(0)
	If spl
		If spl.GetEquipType() == Libs.BothHands
			UnequipSpell(spl, 0)
			;EquipItemEx(Libs.Unarmed, 1, False, False)
			Return
		EndIf

		UnequipSpell(spl, 0)
	EndIf
	spl = GetEquippedSpell(1)
	If spl
		UnequipSpell(spl, 1)
	EndIf
EndFunction

Function UnequipShouts()
	Shout sht = GetEquippedShout()
	If sht
		UnequipShout(sht)
	EndIf
EndFunction