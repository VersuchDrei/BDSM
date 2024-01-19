ScriptName bdsmSKSE

Function Unequip(Actor Act, Armor Item) Global
	Act.UnequipItemEx(Item)
	UI.InvokeString("InventoryMenu", "_global.skse.CloseMenu", "InventoryMenu")
	UI.InvokeString("InventoryMenu", "_global.skse.OpenMenu", "InventoryMenu")
EndFunction