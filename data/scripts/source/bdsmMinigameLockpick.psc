ScriptName bdsmMinigameLockpick Extends bdsmMinigameModel

bdsmLibs Property Libs Auto

ObjectReference[] Property Chests Auto

Actor Target
Armor Item

Function StartMinigame(Actor akActor, Armor akArmor)
	Target = akActor
	Item = akArmor

	int level = 100
	int i = Libs.bdsmLockDifficulties.Length
	While i
		i -= 1
		If akArmor.HasKeyword(Libs.bdsmLockDifficulties[i])
			level = i * 25
		EndIf
	EndWhile

	ObjectReference Chest = Chests[0]
	Chest.Lock()
	Chest.SetLockLevel(level)
	Chest.Activate(Libs.PlayerRef)
EndFunction

Function ChestUnlocked()
	bdsmLibs.CloseAllMenues()
	UI.InvokeString("ContainerMenu", "_global.skse.CloseMenu", "ContainerMenu")
	UI.InvokeString("Lockpicking Menu", "_global.skse.CloseMenu", "Lockpicking Menu")

	MinigameSuccess(Target, Item)
EndFunction