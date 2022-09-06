ScriptName bdsmPlayerAlias Extends ReferenceAlias

Event OnPlayerLoadGame()
	(GetOwningQuest() As bdsmEvents).Maintenance()
EndEvent