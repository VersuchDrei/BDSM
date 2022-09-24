;/* bdsmActorImpl
* * the implementation of bdsmActor.psc
* * it is only documented for people who want to know how exactly the code works
* * you are not supposed to call any of these functions directly
* * refer to the documentation in bdsmActor.psc for how to use the API in your mod
*/;
ScriptName bdsmActorImpl Extends bdsmActor

bdsmLibs Libs

Armor[] lockedItems
int nextIndex = 0
int lockedSlotMasks = 0x0
int restrainMask = 0x0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Events ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Event OnInit()
	lockedItems = new Armor[5]
	Libs = bdsmLibs.GetInstance()
	AddInventoryEventFilter(Libs.bdsmEmptyList)
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	If akBaseObject As Weapon
		If IsRestrained(restrainWeapons)
			UnequipWeapons()
		EndIf
		Return
	EndIf

	If akBaseObject As Spell
		If IsRestrained(restrainSpells)
			UnequipSpells()
		EndIf
		Return
	EndIf

	If akBaseObject As Shout
		If IsRestrained(restrainShouts)
			UnequipShouts()
		EndIf
		Return
	EndIf

	Armor baseArmor = akBaseObject As Armor
	If !baseArmor
		Return
	EndIf

	If !baseArmor.HasKeyword(Libs.bdsmLockable)
		; there's a weird bug where you can equip two items to the same slot mask
		; in order to prevent that we have to manually unequip items in blocked slot masks
		If !CanEquip(baseArmor)
			UnequipItemEx(baseArmor)
		EndIf
		Return
	EndIf

	If IsItemLocked(baseArmor)
		Return
	EndIf

	If !CanEquip(baseArmor) || IsSlotCovered(baseArmor, False)
		UnequipItemEx(baseArmor)
		Return
	EndIf

	If !libs.ShowConfirmationMessage || Libs.bdsmConfirmationMessage.Show() == 0
		LockItem(baseArmor)
	Else
		UnequipItemEx(baseArmor)
	EndIf
EndEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	If !akBaseObject.HasKeyword(Libs.bdsmLockable)
		Return
	EndIf

	Armor baseArmor = akBaseObject As Armor
	If !baseArmor
		Return
	EndIf

	If !IsItemLocked(baseArmor)
		Return
	EndIf

	If GetItemCount(baseArmor) == 0
		; the last instance of this item was removed from the inventory
		; this is where OnItemRemoved handles reequipping
		Return
	EndIf

	EquipItemEx(baseArmor, 0, False, False)

	If Self == Libs.PlayerRef
		TryUnlock(baseArmor)
	EndIf
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	If GetItemCount(akBaseItem) != 0
		Return
	EndIf

	If akDestContainer
		akDestContainer.RemoveItem(akBaseItem, 1, True, Self)
	ElseIf akItemReference
		akItemReference.Delete()
		AddItem(akBaseItem, 1, True)
	Else
		AddItem(akBaseItem, 1, True)
	EndIf

	EquipItemEx(akBaseItem, 0, False, False)

	If akDestContainer == Libs.PlayerRef
		TryUnlock(akBaseItem As Armor)
	ElseIf Self == Libs.PlayerRef
		Libs.bdsmMustUnlockFirstMessage.Show()
	EndIf
EndEvent

Event OnPlayerLoadGame()
	If libs.ControlBreastPyhsics && Math.LogicalAnd(restrainMask, stopBreastPhysics)
		bdsmLibs.DisableBreastPhysics(Self)
	EndIf
		
	If libs.ControlBellyPyhsics && Math.LogicalAnd(restrainMask, stopBellyPhysics)
		bdsmLibs.DisableBellyPhysics(Self)
	EndIf
		
	If libs.ControlButtPyhsics && Math.LogicalAnd(restrainMask, stopButtPhysics)
		bdsmLibs.DisableButtPhysics(Self)
	EndIf
		
	If libs.ControlPenisPyhsics && Math.LogicalAnd(restrainMask, stopPenisPhysics)
		bdsmLibs.DisablePenisPhysics(Self)
	EndIf
		
	If libs.ControlLegPyhsics && Math.LogicalAnd(restrainMask, stopLegPhysics)
		bdsmLibs.DisableLegPhysics(Self)
	EndIf
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SKSE Functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;/* ExpandArmorArray
* * increases the size of the given array of armors by the given size
* *
* * @param: akArmors, the array to expand
* * @param: aiSize, the size to add to the array
* *
* * @return: the new, expanded array
*/;
Armor[] Function ExpandArmorArray(Armor[] akArmors, int aiSize) Global Native

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Function PushLockedItem(Armor akArmor)
	If lockedItems.Length == nextIndex
		LockedItems = ExpandArmorArray(lockedItems, 5)
	EndIf

	lockedItems[nextIndex] = akArmor
	nextIndex += 1
	AddInventoryEventFilter(akArmor)
EndFunction

bool Function IsSlotCovered(Armor akArmor, bool abInfoMessage = False)
	int slotMask = akArmor.GetSlotMask()

	If Math.LogicalAnd(slotMask, akArmor.kSlotMask50 + akArmor.kSlotMask52 + akArmor.kSlotMask57) && IsRestrained(coverGenital)
		If abInfoMessage
			Libs.bdsmUnlockBeltFirstMessage.Show()
		EndIf
		Return True
	EndIf

	If Math.LogicalAnd(slotMask, akArmor.kSlotMask48) && IsRestrained(coverAnus)
		If abInfoMessage
			Libs.bdsmUnlockBeltFirstMessage.Show()
		EndIf
		Return True
	EndIf

	If Math.LogicalAnd(slotMask, akArmor.kSlotMask51) && IsRestrained(coverChest)
		If abInfoMessage
			Libs.bdsmUnlockBraFirstMessage.Show()
		EndIf
		Return True
	EndIf

	If Math.LogicalAnd(slotMask, akArmor.kSlotMask58) && IsRestrained(coverUpperBody)
		If abInfoMessage
			Libs.bdsmUnlockBodyFirstMessage.Show()
		EndIf
		Return True
	EndIf

	If Math.LogicalAnd(slotMask, akArmor.kSlotMask33 + akArmor.kSlotMask59) && IsRestrained(coverArms)
		If abInfoMessage
			Libs.bdsmUnlockArmsFirstMessage.Show()
		EndIf
		Return True
	EndIf

	If Math.LogicalAnd(slotMask, akArmor.kSlotMask38 + akArmor.kSlotMask53) && IsRestrained(coverLegs)
		If abInfoMessage
			Libs.bdsmUnlockLegsFirstMessage.Show()
		EndIf
		Return True
	EndIf

	If Math.LogicalAnd(slotMask, akArmor.kSlotMask55) && IsRestrained(coverEyes)
		If abInfoMessage
			Libs.bdsmUnlockHoodFirstMessage.Show()
		EndIf
		Return True
	EndIf

	If Math.LogicalAnd(slotMask, akArmor.kSlotMask44) && IsRestrained(coverMouth)
		If abInfoMessage
			Libs.bdsmUnlockHoodFirstMessage.Show()
		EndIf
		Return True
	EndIf
EndFunction

Function TryUnlock(Armor akArmor)
	bool isArmRestraint = Libs.IsArmRestraint(akArmor)
	If (Libs.PlayerRef As bdsmActor).IsRestrained(restrainArms) && (Self != Libs.PlayerRef || !isArmRestraint)
		Libs.bdsmFreeArmsFirstMessage.Show()
		Return
	EndIf

	If IsSlotCovered(akArmor, True)
		Return
	EndIf

	If akArmor.HasKeyword(Libs.bdsmRemovable)
		Libs.PlayerUnlocksItem(Self, akArmor)
		Return
	EndIf

	bool unreachableLock = isArmRestraint || akArmor.HasKeywordString(Libs.bdsmUnreachableLock)
	int unlockMode = Libs.bdsmUnlockMode.GetValue() As int

	Key itemKey = None
	If Self != Libs.PlayerRef || !unreachableLock
		itemKey = Libs.FindUsableKey(akArmor)
	EndIf

	If itemKey
		If unlockMode == Libs.UnlockmodeAuto
			UnlockWithKey(akArmor, itemKey)
			Return
		Else
			Libs.bdsmOfferUnlockOptionKey.SetValue(1)
		EndIf
	Else
		Libs.bdsmOfferUnlockOptionKey.SetValue(0)
	EndIf

	bool canLockpick = (Self != Libs.PlayerRef || !unreachableLock) && Libs.PlayerRef.GetItemCount(Libs.Lockpick) && Libs.CanLockpick(akArmor)
	If canLockPick
		If unlockMode == Libs.UnlockmodeAuto
			bdsmLibs.CloseAllMenues()
			Libs.bdsmMinigameHolderLockpick.Minigame.StartMinigame(Self, akArmor)
			Return
		Else
			Libs.bdsmOfferUnlockOptionLockpick.SetValue(1)
		EndIf
	Else
		Libs.bdsmOfferUnlockOptionLockpick.SetValue(0)
	EndIf

	bool canStruggle = Libs.CanStruggleOut(akArmor)
	If canStruggle
		If unlockMode == Libs.UnlockmodeAuto
			bdsmLibs.CloseAllMenues()
			Libs.bdsmMinigameHolderStruggle.Minigame.StartMinigame(Self, akArmor)
			Return
		Else
			Libs.bdsmOfferUnlockOptionStruggle.SetValue(1)
		EndIf
	Else
		Libs.bdsmOfferUnlockOptionStruggle.SetValue(0)
	EndIf

	bool canUseMagic = Libs.CanStruggleOut(akArmor)
	If canUseMagic
		If unlockMode == Libs.UnlockmodeAuto
			bdsmLibs.CloseAllMenues()
			Libs.bdsmMinigameHolderMagic.Minigame.StartMinigame(Self, akArmor)
			Return
		Else
			Libs.bdsmOfferUnlockOptionMagic.SetValue(1)
		EndIf
	Else
		Libs.bdsmOfferUnlockOptionMagic.SetValue(0)
	EndIf

	If unlockMode == Libs.UnlockModeAuto
		Libs.bdsmCantUnlockMessage.Show()
		Return
	ElseIf unlockMode == Libs.UnlockModeSemi
		If itemKey && !canLockpick && !canStruggle && !canUseMagic
			UnlockWithKey(akArmor, itemKey)
			Return
		ElseIf !itemKey && canLockpick && !canStruggle && !canUseMagic
			bdsmLibs.CloseAllMenues()
			Libs.bdsmMinigameHolderLockpick.Minigame.StartMinigame(Self, akArmor)
			Return
		ElseIf !itemKey && !canLockpick && canStruggle && !canUseMagic
			bdsmLibs.CloseAllMenues()
			Libs.bdsmMinigameHolderStruggle.Minigame.StartMinigame(Self, akArmor)
			Return
		ElseIf !itemKey && !canLockpick && !canStruggle && canUseMagic
			bdsmLibs.CloseAllMenues()
			Libs.bdsmMinigameHolderMagic.Minigame.StartMinigame(Self, akArmor)
			Return
		ElseIf !itemKey && !canLockpick && !canStruggle && !canUseMagic
			Libs.bdsmCantUnlockMessage.Show()
			Return
		EndIf
	EndIf

	int option = Libs.bdsmUnlockOptionMessage.Show()
	If option == Libs.UnlockOptionKey
		UnlockWithKey(akArmor, itemKey)
	ElseIf option == Libs.UnlockOptionLockpick
		bdsmLibs.CloseAllMenues()
		Libs.bdsmMinigameHolderLockpick.Minigame.StartMinigame(Self, akArmor)
	ElseIf option == Libs.UnlockOptionStruggle
		bdsmLibs.CloseAllMenues()
		Libs.bdsmMinigameHolderStruggle.Minigame.StartMinigame(Self, akArmor)
	ElseIf option == Libs.UnlockOptionMagic
		bdsmLibs.CloseAllMenues()
		Libs.bdsmMinigameHolderMagic.Minigame.StartMinigame(Self, akArmor)
	EndIf
EndFunction

Function UnlockWithKey(Armor akArmor, Key akKey)
	If Libs.ConsumeKeys && !akArmor.HasKeyword(Libs.bdsmNeverConsumeKey) || akArmor.HasKeyword(Libs.bdsmAlwaysConsumeKey)
		Libs.PlayerRef.RemoveItem(akKey, 1)
	EndIf

	Libs.PlayerUnlocksItem(Self, akArmor)
EndFunction

Function AddRestrainMask(Armor akArmor)
	int oldMask = restrainMask
	restrainMask = Math.LogicalOr(restrainMask, Libs.GetRestrainMask(akArmor))

	If !Math.logicalAnd(oldMask, restrainArms) && Math.LogicalAnd(restrainMask, restrainArms)
		AddSpell(Libs.bdsmAbRestrainArms, False)
	EndIf

	If !Math.logicalAnd(oldMask, restrainWeapons) && Math.LogicalAnd(restrainMask, restrainWeapons)
		AddSpell(Libs.bdsmAbRestrainWeapons, False)
		UnequipWeapons()
	EndIf

	If !Math.logicalAnd(oldMask, restrainSpells) && Math.LogicalAnd(restrainMask, restrainSpells)
		AddSpell(Libs.bdsmAbRestrainSpells, False)
		UnequipSpells()
	EndIf

	If !Math.logicalAnd(oldMask, restrainShouts) && Math.LogicalAnd(restrainMask, restrainShouts)
		AddSpell(Libs.bdsmAbRestrainShouts, False)
		UnequipShouts()
	EndIf


	If !Math.logicalAnd(oldMask, restrainRunning) && Math.LogicalAnd(restrainMask, restrainRunning)
		AddSpell(Libs.bdsmAbilityHolderRestrainRunning.Ability, False)
	EndIf

	If !Math.logicalAnd(oldMask, restrainWalking) && Math.LogicalAnd(restrainMask, restrainWalking)
		AddSpell(libs.bdsmAbilityHolderRestrainWalking.Ability, False)
	EndIf

	If !Math.logicalAnd(oldMask, restrainSpeech) && Math.LogicalAnd(restrainMask, restrainSpeech)
		AddSpell(Libs.bdsmAbRestrainSpeech, False)
	EndIf

	If !Math.logicalAnd(oldMask, restrainSpeechFull) && Math.LogicalAnd(restrainMask, restrainSpeechFull)
		AddSpell(Libs.bdsmAbRestrainSpeechFull, False)
	EndIf

	If !Math.logicalAnd(oldMask, restrainFood) && Math.LogicalAnd(restrainMask, restrainFood)
		AddSpell(Libs.bdsmAbilityHolderRestrainFood.Ability, False)
	EndIf

	If !Math.logicalAnd(oldMask, restrainSight) && Math.LogicalAnd(restrainMask, restrainSight)
		AddSpell(Libs.bdsmAbilityHolderRestrainSight.Ability, False)
	EndIf


	If !Math.logicalAnd(oldMask, openMouth) && Math.LogicalAnd(restrainMask, openMouth)
		If (MfgConsoleFunc.GetPhonemeModifier(Self, 0, 1) != 100 || MfgConsoleFunc.GetPhonemeModifier(Self, 0, 11) != 70) && MfgConsoleFunc.GetPhonemeModifier(Self, 0, 0) != 70
			MfgConsoleFunc.SetPhonemeModifier(Self, 0, 1, 100)
			MfgConsoleFunc.SetPhonemeModifier(Self, 0, 11, 70)
		EndIf
	EndIf


	If Self == Libs.PlayerRef
		If libs.ControlBreastPyhsics && !Math.logicalAnd(oldMask, stopBreastPhysics) && Math.LogicalAnd(restrainMask, stopBreastPhysics)
			bdsmLibs.DisableBreastPhysics(Self)
		EndIf
		
		If libs.ControlBellyPyhsics && !Math.logicalAnd(oldMask, stopBellyPhysics) && Math.LogicalAnd(restrainMask, stopBellyPhysics)
			bdsmLibs.DisableBellyPhysics(Self)
		EndIf
		
		If libs.ControlButtPyhsics && !Math.logicalAnd(oldMask, stopButtPhysics) && Math.LogicalAnd(restrainMask, stopButtPhysics)
			bdsmLibs.DisableButtPhysics(Self)
		EndIf
		
		If libs.ControlPenisPyhsics && !Math.logicalAnd(oldMask, stopPenisPhysics) && Math.LogicalAnd(restrainMask, stopPenisPhysics)
			bdsmLibs.DisablePenisPhysics(Self)
		EndIf
		
		If libs.ControlLegPyhsics && !Math.logicalAnd(oldMask, stopLegPhysics) && Math.LogicalAnd(restrainMask, stopLegPhysics)
			bdsmLibs.DisableLegPhysics(Self)
		EndIf
	EndIf
EndFunction

Function RebuildRestrainMask()
	int newMask = 0x0

	int i = lockedItems.Length
	While i
		i -= 1
		newMask = Math.LogicalOr(newMask, Libs.GetRestrainMask(lockedItems[i]))
	EndWhile

	int oldMask = restrainMask
	restrainMask = newMask

	If Math.logicalAnd(oldMask, restrainArms) && !Math.LogicalAnd(restrainMask, restrainArms)
		RemoveSpell(Libs.bdsmAbRestrainArms)
	EndIf

	If Math.logicalAnd(oldMask, restrainWeapons) && !Math.LogicalAnd(restrainMask, restrainWeapons)
		RemoveSpell(Libs.bdsmAbRestrainWeapons)
	EndIf

	If Math.logicalAnd(oldMask, restrainSpells) && !Math.LogicalAnd(restrainMask, restrainSpells)
		RemoveSpell(Libs.bdsmAbRestrainSpells)
	EndIf

	If Math.logicalAnd(oldMask, restrainShouts) && !Math.LogicalAnd(restrainMask, restrainShouts)
		RemoveSpell(Libs.bdsmAbRestrainShouts)
	EndIf


	If Math.logicalAnd(oldMask, restrainRunning) && !Math.LogicalAnd(restrainMask, restrainRunning)
		RemoveSpell(Libs.bdsmAbilityHolderRestrainRunning.Ability)
	EndIf

	If Math.logicalAnd(oldMask, restrainWalking) && !Math.LogicalAnd(restrainMask, restrainWalking)
		RemoveSpell(Libs.bdsmAbilityHolderRestrainWalking.Ability)
	EndIf

	If Math.logicalAnd(oldMask, restrainSpeech) && !Math.LogicalAnd(restrainMask, restrainSpeech)
		RemoveSpell(Libs.bdsmAbRestrainSpeech)
	EndIf

	If Math.logicalAnd(oldMask, restrainSpeechFull) && !Math.LogicalAnd(restrainMask, restrainSpeechFull)
		RemoveSpell(Libs.bdsmAbRestrainSpeechFull)
	EndIf

	If Math.logicalAnd(oldMask, restrainFood) && !Math.LogicalAnd(restrainMask, restrainFood)
		RemoveSpell(Libs.bdsmAbilityHolderRestrainFood.Ability)
	EndIf

	If Math.logicalAnd(oldMask, restrainSight) && !Math.LogicalAnd(restrainMask, restrainSight)
		RemoveSpell(Libs.bdsmAbilityHolderRestrainSight.Ability)
	EndIf


	If Math.logicalAnd(oldMask, openMouth) && !Math.LogicalAnd(restrainMask, openMouth)
		MfgConsoleFunc.SetPhonemeModifier(Self, 0, 1, 0)
		MfgConsoleFunc.SetPhonemeModifier(Self, 0, 11, 0)
	EndIf


	If Self == Libs.PlayerRef
		If libs.ControlBreastPyhsics && Math.logicalAnd(oldMask, stopBreastPhysics) && !Math.LogicalAnd(restrainMask, stopBreastPhysics)
			bdsmLibs.EnableBreastPhysics(Self)
		EndIf
		
		If libs.ControlBellyPyhsics && Math.logicalAnd(oldMask, stopBellyPhysics) && !Math.LogicalAnd(restrainMask, stopBellyPhysics)
			bdsmLibs.EnableBellyPhysics(Self)
		EndIf
		
		If libs.ControlButtPyhsics && Math.logicalAnd(oldMask, stopButtPhysics) && !Math.LogicalAnd(restrainMask, stopButtPhysics)
			bdsmLibs.EnableButtPhysics(Self)
		EndIf
		
		If libs.ControlPenisPyhsics && Math.logicalAnd(oldMask, stopPenisPhysics) && !Math.LogicalAnd(restrainMask, stopPenisPhysics)
			bdsmLibs.EnablePenisPhysics(Self)
		EndIf
		
		If libs.ControlLegPyhsics && Math.logicalAnd(oldMask, stopLegPhysics) && !Math.LogicalAnd(restrainMask, stopLegPhysics)
			bdsmLibs.EnableLegPhysics(Self)
		EndIf
	EndIf
	
EndFunction

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;; bdsmActor.psc API functions ;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; refer to bdsmActor.psc for documentation
bool Function CanEquipSlotMask(int aiSlotMask)
	Return Math.LogicalAnd(aiSlotMask, lockedSlotMasks) == 0x0
EndFunction

bool Function IsRestrained(int aiRestrainMask)
	Return Math.LogicalAnd(restrainMask, aiRestrainMask) == aiRestrainMask
EndFunction

bool Function IsItemLocked(Armor akArmor)
	If nextIndex == 0
		Return False
	EndIf

	Return lockedItems.RFind(akArmor, nextIndex - 1) >= 0
EndFunction

bool Function LockItem(Armor akArmor, bool alwaysAdd = False)
	If !CanEquip(akArmor)
		Return False
	EndIf

	PushLockedItem(akArmor)
	lockedSlotMasks += akArmor.GetSlotMask()
	If alwaysAdd || GetItemCount(akArmor) == 0
		AddItem(akArmor, 1, True)
	EndIf
	If !IsEquipped(akArmor)
		EquipItemEx(akArmor, 0, False, False)
	EndIf

	AddRestrainMask(akArmor)

	Return True
EndFunction

bool Function UnlockItemByForm(Armor akArmor, bool abRemove = True)
	If !akArmor || !akArmor.HasKeyword(Libs.bdsmLockable) || nextIndex == 0
		Return False
	EndIf

	int index = lockedItems.RFind(akArmor, nextIndex - 1)
	If index < 0
		Return False
	EndIf

	nextIndex -= 1
	If index != nextIndex
		lockedItems[index] = lockedItems[nextIndex]
	EndIf
	lockedItems[nextIndex] = None
	RemoveInventoryEventFilter(akArmor)
	lockedSlotMasks -= akArmor.GetSlotMask()

	UnequipItemEx(akArmor)

	If abRemove || akArmor.HasKeyword(Libs.bdsmRemoveOnUnlock)
		RemoveItem(akArmor, 1, True)
	EndIf

	RebuildRestrainMask()

	Return True
EndFunction