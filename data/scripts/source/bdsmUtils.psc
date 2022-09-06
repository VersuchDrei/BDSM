;/* bdsmUtils
* * collection of global functions
*/;
ScriptName bdsmUtils

bdsmActor Function AsBdsmActor(Actor akActor) Global
	bdsmActor bdsmActorAPI = akActor As bdsmActor
	If bdsmActorAPI
		Return bdsmActorAPI
	EndIf

	bdsmLibs.AttachBdsmActor(akActor)
	Return akActor As bdsmActor
EndFunction