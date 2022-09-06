;/* bdsmMinigameModel
* * this is the basic model for any of the minigames
* * if you want to replace a minigame with your own implementation extend this script
* * and set it in the respective holder quest (see bdsmMinigameHolder.psc)
*/;
ScriptName bdsmMinigameModel Extends Quest
;/* StartMinigame
* * starts the minigame to remove the item
* *
* * @param, akActor, the actor to remove the item from, if this is not the player the PC is trying to remove the item from them
* * @param, akArmor, the armor form of the item
* * @param, akReference, the object reference of the item
*/;
Function StartMinigame(Actor akActor, Armor akArmor)
	; abstract function, overwrite in implementation
EndFunction

;/* MinigameSuccess
* * call this when the minigame succeeded and the item is to be removed
* *
* * @param: akActor, the actor to remove the item from
* * @param: akArmor, the armor form of the item
*/;
Function MinigameSuccess(Actor akActor, Armor akArmor)
	bdsmLibs.GetInstance().PlayerUnlocksItem(akActor As bdsmActor, akArmor)
EndFunction