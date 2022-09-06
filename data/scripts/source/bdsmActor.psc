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

int Property restrainArms       = 0x00000001 AutoReadOnly ; armbinders / straitjackets / yokes / arm restraints, needs to be unlocked before other items can
int Property restrainWeapons    = 0x00000002 AutoReadOnly ; armbinders / straitjackets / yokes (/ mittens), prevents equipping weapons
int Property restrainSpells     = 0x00000004 AutoReadOnly ; armbinders / straitjackets / (/ yokes / mittens), prevents equipping spells
int Property blockHands         = 0x00000008 AutoReadOnly ; armbinders / yokes / straitjackets / mittens, prevents handjobs
int Property coverArms          = 0x00000010 AutoReadOnly ; armbinders / straitjackets, prevents unlocking mittens / gloves / arm cuffs

int Property restrainRunning    = 0x00000020 AutoReadOnly ; ankle chains, toggles slow moving
int Property restrainWalking    = 0x00000040 AutoReadOnly ; legbinders, toggles very slow moving
int Property blockFeet          = 0x00000080 AutoReadOnly ; boots / heels, prevents footjobs
int Property coverLegs          = 0x00000100 AutoReadOnly ; legbinders, prevents unlocking leg cuffs

int Property restrainSpeech     = 0x00000200 AutoReadOnly ; gags, toggles dialogue minigame
int Property restrainSpeechFull = 0x00000400 AutoReadOnly ; big gags, fully prevents dialogue
int Property restrainShouts     = 0x00000800 AutoReadOnly ; gags (/ ring gags), prevents equipping shouts
int Property restrainFood       = 0x00001000 AutoReadOnly ; gags other than ring gags
int Property blockMouth         = 0x00002000 AutoReadOnly ; gags other than ring gags, prevents oral
int Property openMouth          = 0x00004000 AutoReadOnly ; opens the mouth
int Property coverMouth         = 0x00008000 AutoReadOnly ; hoods that cover the mouth, prevents unlocking of gags

int Property restrainSight      = 0x00010000 AutoReadOnly ; blindfolds, toggles blind effect
int Property coverEyes          = 0x00020000 AutoReadOnly ; hoods that cover the eyes, prevents unlocking of blindfolds

int Property blockVagina        = 0x00040000 AutoReadOnly ; chastity belts / vaginal plugs, prevents vaginal
int Property blockCock          = 0x00080000 AutoReadOnly ; chastity belts / cock cages, prevents penetration
int Property blockAnus          = 0x00100000 AutoReadOnly ; chastity belts / anal plugs, prevents anal
int Property coverGenital       = 0x00200000 AutoReadOnly ; chastity belts, prevents unlocking vaginal plugs / cock cages
int Property coverAnus          = 0x00400000 AutoReadOnly ; chastity belts, prevents unlocking anal plugs

int Property blockChest         = 0x00800000 AutoReadOnly ; chastity bras, prevents boobjobs
int Property coverChest         = 0x01000000 AutoReadOnly ; chastity bras, prevents unlocking nipple piercings / clamps
int Property coverUpperBody     = 0x02000000 AutoReadOnly ; straitjackets, perevents unlocking harnesses
int Property coverBelly         = 0x04000000 AutoReadOnly ; corsets / straitjackets, prevents unlocking belly button piercings

int Property stopBreastPhysics  = 0x08000000 AutoReadOnly ; chastity bras, stops booby bouncing
int Property stopBellyPhysics   = 0x10000000 AutoReadOnly ; corsets / chastity belts / straitjackets, stops belly bouncing
int Property stopButtPhysics    = 0x20000000 AutoReadOnly ; chastity belts, stops booty bouncing
int Property stopPenisPhysics   = 0x40000000 AutoReadOnly ; chastity belts / cock cages, stops schlong bouncing
int Property stopLegPhysics     = 0x80000000 AutoReadOnly ; thigh high boots / legbinders, stops ham bouncing

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