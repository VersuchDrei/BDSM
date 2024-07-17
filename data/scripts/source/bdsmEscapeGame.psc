;/* bdsmEscapeGame
* * this is the basic model for any of the escape games
*/;
ScriptName bdsmEscapeGame Extends Quest

;/* StartEscapeGame
* * starts the minigame to remove the item
* *
* * @param: Difficulty, the difficulty of item as per definition in the escape game .json
* * @param: Target, the actor to remove the item from, if this is not the player the PC is trying to remove the item from them
* * @param: Restraint, the armor form of the item
*/;
Function StartEscapeGame(int Difficulty, Actor Target, Armor Restraint)
	; abstract function, overwrite in implementation
EndFunction


;/* CloseAllMenus
* * closes the players inventory, or whever other menu they are currently looking at
*/;
Function CloseAllMenus()
	Game.DisablePlayerControls(abMovement = false, abFighting = false, abMenu = true, abActivate = false)
	Utility.Wait(0.1)
	Game.EnablePlayerControls(abMovement = false, abFighting = false, abCamSwitch = false, abLooking = false, abSneaking = false, abMenu = true, abActivate = false, abJournalTabs = false)
EndFunction

;/* EscapeGameSuccess
* * call this when the escape game succeeded and the item is to be removed
* *
* * @param: akActor, the actor to remove the item from
* * @param: akArmor, the armor form of the item
*/;
Function EscapeGameSuccess(Actor Target, Armor Restraint)
	EscapeGameSuccessNative(Target, Restraint)
EndFunction

Function EscapeGameSuccessNative(Actor Target, Armor Restraint) Global Native