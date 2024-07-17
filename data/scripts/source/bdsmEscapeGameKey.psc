ScriptName bdsmEscapeGameKey Extends bdsmEscapeGame

Actor Property PlayerRef Auto
Key[] Property Keys Auto

Function StartEscapeGame(int Difficulty, Actor Target, Armor Restraint)
	Key RequiredKey = Keys[Difficulty]

	If PlayerRef.GetItemCount(RequiredKey) > 0
		PlayerRef.RemoveItem(RequiredKey)
		EscapeGameSuccess(Target, Restraint)
	ElseIf Target.GetItemCount(RequiredKey) > 0
		Target.RemoveItem(RequiredKey)
		EscapeGameSuccess(Target, Restraint)
	EndIf
EndFunction