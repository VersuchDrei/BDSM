ScriptName bdsmSKSE

Function StartEscapeGame(Quest MiniGame, int Difficulty, Actor Target, Armor Restraint) Global
	bdsmEscapeGame EscapeGame = MiniGame As bdsmEscapeGame
	If !EscapeGame
		Return
	EndIf

	EscapeGame.StartEscapeGame(Difficulty, Target, Restraint)
EndFunction