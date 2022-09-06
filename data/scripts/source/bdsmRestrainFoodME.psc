ScriptName bdsmRestrainFoodME Extends ActiveMagicEffect

ObjectReference Property FoodChest Auto

Actor Target

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Target = akTarget

	int i = Target.GetNumItems()
	While i
		i -= 1
		CheckItem(Target.GetNthForm(i))
	EndWhile
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	CheckItem(akBaseItem)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	FoodChest.RemoveAllItems(akTarget, True, False)
EndEvent

Function CheckItem(Form akBaseItem)
	If akBaseItem As Potion
		Target.RemoveItem(akBaseItem, Target.GetItemCount(akBaseItem), True, FoodChest)
	EndIf
EndFunction