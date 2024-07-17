ScriptName bdsmEscapeGameLockpickChest Extends ObjectReference

bdsmEscapeGameLockpick Property LockpickingGame Auto

Event OnLockStateChanged()
	If !IsLocked()
		LockpickingGame.ChestUnlocked()
	EndIf
EndEvent