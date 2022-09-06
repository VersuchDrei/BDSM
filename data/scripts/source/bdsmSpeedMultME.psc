ScriptName bdsmSpeedMultME Extends ActiveMagicEffect

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.ModAV("CarryWeight", 0.1)
	akTarget.ModAV("CarryWeight", -0.1)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.ModAV("CarryWeight", 0.1)
	akTarget.ModAV("CarryWeight", -0.1)
EndEvent