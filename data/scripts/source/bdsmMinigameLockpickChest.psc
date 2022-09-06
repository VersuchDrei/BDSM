ScriptName bdsmMinigameLockpickChest Extends ObjectReference

bdsmMinigameLockpick Property Minigame Auto

Event OnLockStateChanged()
	If !IsLocked()
		Minigame.ChestUnlocked()
	EndIf
EndEvent