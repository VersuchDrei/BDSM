;/* bdsmActor
* * API for managing lockable items on actors, for the implementation see bdsmActorImpl.psc
* * get's attached to actors when they first need it
* * you can cast (akActor as bdsmActor) if:
* * - it is the player, the player automatically get's this script attached at game start
* * - the NPC is currently wearing a lockable item
* * - you've already used the NPC as bdsmActor before
* * in any other case use bdsmUtils::AsBdsmActor to make sure the actor get's the script attached if they don't have it yet
*/;
ScriptName bdsmActor Extends Actor

;/* CanEquip
* * checks if equipping the given item does not conflict with any of the items currently locked on the player
* * 
* * @param: akArmor, the item to check for
* * 
* * @return: True if equipping the item is possible
*/;
bool Function CanEquip(Armor akArmor)
	Return CanEquipSlotMask(akArmor.GetSlotMask())
EndFunction

;/* CanEquipAll
* * checks if equipping the given items does not conflict with any of the items currently locked on the player
* * does not check if the given items conflict with each other
* * 
* * @param akArmors, the items to check for
* * 
* * @return: True if equipping the items is possible
*/;
bool Function CanEquipAll(Armor[] akArmors)
	int slotMask = 0x0
	int i = akArmors.Length
	While i
		i -= 1
		slotMask = Math.LogicalOr(slotMask, akArmors[i].GetSlotMask())
	EndWhile
	Return CanEquipSlotMask(slotMask)
EndFunction

;/* CanEquipSlotMask
* * checks if equipping an item in the given slot mask does not conflict with any of the items currently locked on the player
* * 
* * @param: aiSlotMask, the restrain slot mask the check for, as in the list of properties above, not to be confused with armor slot masks
* *
* * @return: True if equipping an item in the slot mask is possible
*/;
bool Function CanEquipSlotMask(int aiSlotMask)
	; implemented in bdsmActorImpl.psc
	Return False
EndFunction

;/* IsRestrained
* * checks if the given slot mask is restrained
* *
* * @param: aiRestrainMask, the slot mask to check for
* *
* * @return: True, if the given slot mask is restrained
*/;
bool Function IsRestrained(int aiRestrainMask)
	Return False
EndFunction

;/* IsItemLocked
* * checks if the given item is locked on the player
* * 
* * @param: akArmor, the item to check for
* * 
* * @return: True if the item is locked in the player
*/;
bool Function IsItemLocked(Armor akArmor)
	Return False
EndFunction

;/* LockItem
* * adds an instance of the item to the actor if needed and equips and locks it
* *
* * @param: akArmor, the item to lock on the player
* * @param: abAlwaysAdd, if True a new instance of the item is added to the actor even if they already have one, this is however not advised
* *
* * @return: True if the item is now locked on the player, False if another locked item is blocking it
*/;
bool Function LockItem(Armor akArmor, bool abAlwaysAdd = False)
	; implemented in bdsmActorImpl.psc
	Return False
EndFunction

;/* UnlockItemByForm
* * unlocks and unequips the item from the actor, if it is locked on them
* * 
* * @param: akArmor, the item to unlock
* * @param: abRemove, if True one instance of the item is removed from the actors inventory after unlocking it
* * 
* * @return: True if the item was unlocked, False if it wasn't locked on the actor in the first place
*/;
bool Function UnlockItemByForm(Armor akArmor, bool abRemove = True)
	; implemented in bdsmActorImpl.psc
	Return False
EndFunction

;/* UnlockItemByReference
* * unlocks and unequips the item from the actor, if it is locked on them
* * note that due to technical limitations this will also unlock a different object reference of the same base form
* * 
* * @param: akItemReference, the item to unlock
* * @param: abRemove, if True one instance of the item is removed from the actors inventory after unlocking it
* * 
* * @return: True if the item was unlocked, False if it wasn't locked on the actor in the first place
*/;
bool Function UnlockItemByReference(ObjectReference akItemReference, bool abRemove = True)
	Armor baseForm = akItemReference.GetBaseObject() As Armor
	If baseForm
		Return UnlockitemByForm(baseForm, abRemove)
	EndIf
	Return False
EndFunction

;/* UnlockItemBySlot
* * unlocks and unequips the item in the given slot, if one is locked in that slot
* * see https://www.creationkit.com/index.php?title=Biped_Object for reference
* * 
* * @param: aiSlot, the slot to unlock the item from
* * @param: abRemove, if True one instance of the item is removed from the actors inventory after unlocking it
* * 
* * @return: True if an item was unlocked, False if none was locked on the actor in the given slot
*/;
bool Function UnlockItemBySlot(int aiSlot, bool abRemove = True)
	Return UnlockItemByForm(GetEquippedArmorInSlot(aiSlot), abRemove)
EndFunction

;/* UnlockItembySlotMask
* * unlocks and unequips the item in the given slot mask, if one is locked in that slot mask
* * see https://www.creationkit.com/index.php?title=Slot_Masks_-_Armor for reference
* * 
* * @param: aiSlotMask, the slot mask to unlock the item from
* * @param: abRemove, if True one instance of the item is removed from the actors inventory after unlocking it
* * 
* * @return: True if an item was unlocked, False if none was locked on the actor in the given slot mask
*/;
bool Function UnlockItembySlotMask(int aiSlotMask, bool abRemove = True)
	Return UnlockItemByForm(GetWornForm(aiSlotMask) As Armor, abRemove)
EndFunction