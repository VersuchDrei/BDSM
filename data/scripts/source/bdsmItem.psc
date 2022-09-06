ScriptName bdsmItem Extends ObjectReference

Event OnEquipped(Actor akActor)
	Debug.Notification("on equipped")
EndEvent

Event OnUnequipped(Actor akActor)
	Debug.Notification("on unequipped")
EndEvent