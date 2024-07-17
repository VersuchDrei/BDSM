ScriptName bdsmEscapeGameLockpick Extends bdsmEscapeGame

Actor Property PlayerRef Auto
ObjectReference Property Chest Auto

Actor TargetVar
Armor RestraintVar

Function StartEscapeGame(int Difficulty, Actor Target, Armor Restraint)
	CloseAllMenus()

	TargetVar = Target
	RestraintVar = Restraint

	Chest.Lock()
	Chest.SetLockLevel(Difficulty * 25)
	Chest.Activate(PlayerRef)
EndFunction

Function ChestUnlocked()
	UI.InvokeString("ContainerMenu", "_global.skse.CloseMenu", "ContainerMenu")
	UI.InvokeString("Lockpicking Menu", "_global.skse.CloseMenu", "Lockpicking Menu")

	EscapeGameSuccess(TargetVar, RestraintVar)
EndFunction