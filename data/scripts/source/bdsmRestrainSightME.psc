ScriptName bdsmRestrainSightME Extends ActiveMagicEffect

bdsmLibs Property Libs Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If Weather.GetSkyMode() != 0
		ConsoleUtil.ExecuteCommand("ts")
	EndIf

	ConsoleUtil.ExecuteCommand("setfog 0 " + Libs.bdsmRestrainSightVisionRange.value As int)

	UI.SetNumber("HUD Menu", "_root.HUDMovieBaseInstance.CompassShoutMeterHolder._alpha", 0)
	UI.SetNumber("HUD Menu", "_root.HUDMovieBaseInstance.CompassShoutMeterHolder.Compass.DirectionRect._alpha", 0)
	UI.SetNumber("HUD Menu", "_root.HUDMovieBaseInstance.CompassShoutMeterHolder.Compass.CompassFrame._alpha", 0)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	If Weather.GetSkyMode() == 0
		COnsoleUtil.ExecuteCommand("ts")
	EndIf

	ConsoleUtil.ExecuteCommand("setfog 0 0")

	UI.SetNumber("HUD Menu", "_root.HUDMovieBaseInstance.CompassShoutMeterHolder._alpha", 100)
	UI.SetNumber("HUD Menu", "_root.HUDMovieBaseInstance.CompassShoutMeterHolder.Compass.DirectionRect._alpha", 100)
	UI.SetNumber("HUD Menu", "_root.HUDMovieBaseInstance.CompassShoutMeterHolder.Compass.CompassFrame._alpha", 100)
EndEvent