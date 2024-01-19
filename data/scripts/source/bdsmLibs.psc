;/* bdsmLibs
* * this is a collection of all the properties the various bdsm scripts utilize
* * basic mods shouldn't need a reference to this
*/;
ScriptName bdsmLibs Extends Quest

; a reference of Game::GetPlayer for quick access, as calling the function is slow
Actor Property PlayerRef Auto

; ---------- item effect perks ----------
; applies a magnitude multiplier to shouts when wearing open gags
Perk Property bdsmGagOpenShoutPenaltyPerk Auto
; applies a difficulty multiplier to lockpicking when wearing mittens
Perk Property bdsmMittensLockpickPenaltyPerk Auto
; applies a magnitude multiplier to spells when wearing mittens
Perk Property bdsmMittensSpellPenaltyPerk Auto
; applies a damage multiplier to weapons when wearing mittens
Perk Property bdsmMittensWeaponPenaltyPerk Auto
; applies a magnitude multiplier to spells when wearing yokes
Perk Property bdsmYokeSpellPenaltyPerk Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; MCM General ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; if enabled a confirmation messagebox will appear when equipping items
; if disabled items will be equipped instantly
GlobalVariable Property bdsmShowConfirmationMessage Auto
bool Property ShowConfirmationMessage
	bool Function Get()
		Return bdsmShowConfirmationMessage.GetValue() == 1
	EndFunction
EndProperty

; how items will be unlocked
GlobalVariable Property bdsmUnlockMode Auto
int Property UnlockModeManual = 0 AutoReadOnly ; bdsmUnlockOptionMessage is always shown
int Property UnlockModeSemi = 1 AutoReadOnly ; if only one option it is choosen automatically, otherwise bdsmUnlockOptionMessage is shown
int Property UnlockModeAuto = 2 AutoReadOnly ; automatically chooses the first availabe option, for order see bdsmUnlockOptionMessage
string[] Property UnlockModeOptions Auto ; MCM values for the unlock mode

; if enabled auto equipped gags will only be ring gags, this is useful for people playing in survival mode
; there is no guarantee that this setting will be respected by addons, however
GlobalVariable Property bdsmOpenGagsOnly Auto
bool Property OpenGagsOnly
	bool Function Get()
		Return bdsmOpenGagsOnly.GetValue() == 1
	EndFunction
EndProperty

; ---------- locks ----------
; if enabled only the key with the respective difficulty level of the lock can be used
; if disabled higher keys can unlock lower locks
GlobalVariable Property bdsmExactKeysOnly Auto
bool Property ExactKeysOnly
	bool Function Get()
		Return bdsmExactKeysOnly.value == 1
	EndFunction
EndProperty

; if enabled keys will be consumed when used to unlock items
GlobalVariable Property bdsmConsumeKeys Auto
bool Property ConsumeKeys
	bool Function Get()
		Return bdsmConsumeKeys.value == 1
	EndFunction
EndProperty

; ---------- physics settings ----------
; if enabled certrain items disable boob jiggling
GlobalVariable Property bdsmControlBreastPhysics Auto
bool Property ControlBreastPyhsics
	bool Function Get()
		Return bdsmControlBreastPhysics.value == 1
	EndFunction
EndProperty

; if enabled certrain items disable belly jiggling
GlobalVariable Property bdsmControlBellyPhysics Auto
bool Property ControlBellyPyhsics
	bool Function Get()
		Return bdsmControlBellyPhysics.value == 1
	EndFunction
EndProperty

; if enabled certrain items disable booty jiggling
GlobalVariable Property bdsmControlButtPhysics Auto
bool Property ControlButtPyhsics
	bool Function Get()
		Return bdsmControlButtPhysics.value == 1
	EndFunction
EndProperty

; if enabled certrain items disable schlong jiggling
GlobalVariable Property bdsmControlPenisPhysics Auto
bool Property ControlPenisPyhsics
	bool Function Get()
		Return bdsmControlPenisPhysics.value == 1
	EndFunction
EndProperty

; if enabled certrain items disable ham jiggling
GlobalVariable Property bdsmControlLegPhysics Auto
bool Property ControlLegPyhsics
	bool Function Get()
		Return bdsmControlLegPhysics.value == 1
	EndFunction
EndProperty

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;; MCM Item Customization ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GlobalVariable Property bdsmAllGagsAllowFood Auto
bool Property AllGagsAllowFood
	bool Function Get()
		Return bdsmAllGagsAllowFood.value == 1
	EndFunction
EndProperty

GlobalVariable Property bdsmRestrainSightVisionRange Auto
GlobalVariable Property bdsmGagOpenShoutPenalty Auto
GlobalVariable Property bdsmMittensSpellPenalty Auto
GlobalVariable Property bdsmMittensWeaponPenalty Auto
GlobalVariable Property bdsmMittensLockpickPenalty Auto
GlobalVariable Property bdsmYokeSpellPenalty Auto
GlobalVariable Property bdsmSlowSpeedPenalty Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; MCM Debug ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; if enabled gag talk will be disabled
GlobalVariable Property bdsmDisableGagTalk Auto
bool Property DisableGagTalk
	bool Function Get()
		Return bdsmDisableGagTalk.value == 1
	EndFunction
EndProperty

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Struggle ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; multiplier for the difficulty of the struggle minigame
GlobalVariable Property bdsmStruggleEscapeMult Auto
; multiplier for the stamina drain of the struggle minigame
GlobalVariable Property bdsmStruggleStaminaMult Auto
; keys for the struggle minigame
GlobalVariable Property bdsmStruggleKey1 Auto
GlobalVariable Property bdsmStruggleKey2 Auto
GlobalVariable Property bdsmStruggleKey3 Auto
GlobalVariable Property bdsmStruggleKey4 Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Global Functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;/* GetLibs
* *	returns the instance of the bdsmLibs quest, which has this script attached
* *
* * @return: the quest this script is attached to
*/;
bdsmLibs Function GetInstance() Global
	Return Game.GetFormFromFile(0x000d61, "BDSM.esp") As bdsmLibs
EndFunction

;/* CloseAllMenues
* * closes all menues for the player
*/;
Function CloseAllMenues() Global
	Game.DisablePlayerControls(abMovement = false, abFighting = false, abMenu = true, abActivate = false)
	Utility.Wait(0.1)
	Game.EnablePlayerControls(abMovement = false, abFighting = false, abCamSwitch = false, abLooking = false, abSneaking = false, abMenu = true, abActivate = false, abJournalTabs = false)
EndFunction

Function EnableBreastPhysics(Actor akTarget) Global
	CBPCPluginScript.StartPhysics(akTarget, "L Breast01")
	CBPCPluginScript.StartPhysics(akTarget, "L Breast02")
	CBPCPluginScript.StartPhysics(akTarget, "L Breast03")
	CBPCPluginScript.StartPhysics(akTarget, "R Breast01")
	CBPCPluginScript.StartPhysics(akTarget, "R Breast02")
	CBPCPluginScript.StartPhysics(akTarget, "R Breast03")
EndFunction

Function DisableBreastPhysics(Actor akTarget) Global
	CBPCPluginScript.StopPhysics(akTarget, "L Breast01")
	CBPCPluginScript.StopPhysics(akTarget, "L Breast02")
	CBPCPluginScript.StopPhysics(akTarget, "L Breast03")
	CBPCPluginScript.StopPhysics(akTarget, "R Breast01")
	CBPCPluginScript.StopPhysics(akTarget, "R Breast02")
	CBPCPluginScript.StopPhysics(akTarget, "R Breast03")
EndFunction

Function EnableBellyPhysics(Actor akTarget) Global
	CBPCPluginScript.StartPhysics(akTarget, "NPC Belly")
EndFunction

Function DisableBellyPhysics(Actor akTarget) Global
	CBPCPluginScript.StopPhysics(akTarget, "NPC Belly")
EndFunction

Function EnableButtPhysics(Actor akTarget) Global
	CBPCPluginScript.StartPhysics(akTarget, "NPC L Butt")
	CBPCPluginScript.StartPhysics(akTarget, "NPC R Butt")
EndFunction

Function DisableButtPhysics(Actor akTarget) Global
	CBPCPluginScript.StopPhysics(akTarget, "NPC L Butt")
	CBPCPluginScript.StopPhysics(akTarget, "NPC R Butt")
EndFunction

Function EnablePenisPhysics(Actor akTarget) Global
	CBPCPluginScript.StartPhysics(akTarget, "NPC GenitalsBase [GenBase]")
	CBPCPluginScript.StartPhysics(akTarget, "NPC GenitalsScrotum [GenScrot]")
	CBPCPluginScript.StartPhysics(akTarget, "NPC Genitals01 [Gen01]")
	CBPCPluginScript.StartPhysics(akTarget, "NPC Genitals01 [Gen02]")
	CBPCPluginScript.StartPhysics(akTarget, "NPC Genitals01 [Gen03]")
	CBPCPluginScript.StartPhysics(akTarget, "NPC Genitals01 [Gen04]")
	CBPCPluginScript.StartPhysics(akTarget, "NPC Genitals01 [Gen05]")
	CBPCPluginScript.StartPhysics(akTarget, "NPC Genitals01 [Gen06]")
EndFunction

Function DisablePenisPhysics(Actor akTarget) Global
	CBPCPluginScript.StopPhysics(akTarget, "NPC GenitalsBase [GenBase]")
	CBPCPluginScript.StopPhysics(akTarget, "NPC GenitalsScrotum [GenScrot]")
	CBPCPluginScript.StopPhysics(akTarget, "NPC Genitals01 [Gen01]")
	CBPCPluginScript.StopPhysics(akTarget, "NPC Genitals01 [Gen02]")
	CBPCPluginScript.StopPhysics(akTarget, "NPC Genitals01 [Gen03]")
	CBPCPluginScript.StopPhysics(akTarget, "NPC Genitals01 [Gen04]")
	CBPCPluginScript.StopPhysics(akTarget, "NPC Genitals01 [Gen05]")
	CBPCPluginScript.StopPhysics(akTarget, "NPC Genitals01 [Gen06]")
EndFunction

Function EnableLegPhysics(Actor akTarget) Global
	CBPCPluginScript.StartPhysics(akTarget, "NPC L FrontThigh")
	CBPCPluginScript.StartPhysics(akTarget, "NPC R FrontThigh")
	CBPCPluginScript.StartPhysics(akTarget, "NPC L RearThigh")
	CBPCPluginScript.StartPhysics(akTarget, "NPC R RearThigh")
	CBPCPluginScript.StartPhysics(akTarget, "NPC L RearCalf [LrClf]")
	CBPCPluginScript.StartPhysics(akTarget, "NPC R RearCalf [LrClf]")
EndFunction

Function DisableLegPhysics(Actor akTarget) Global
	CBPCPluginScript.StopPhysics(akTarget, "NPC L FrontThigh")
	CBPCPluginScript.StopPhysics(akTarget, "NPC R FrontThigh")
	CBPCPluginScript.StopPhysics(akTarget, "NPC L RearThigh")
	CBPCPluginScript.StopPhysics(akTarget, "NPC R RearThigh")
	CBPCPluginScript.StopPhysics(akTarget, "NPC L RearCalf [LrClf]")
	CBPCPluginScript.StopPhysics(akTarget, "NPC R RearCalf [LrClf]")
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Member Functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;/* BuildMCMArrays
* * rebuilds the text options for the MCM
* * there is no reason to ever call this in your plugin
*/;
Function BuildMCMArrays()
	UnlockModeOptions = new string[3]
	UnlockModeOptions[0] = "Manual"
	UnlockModeOptions[1] = "Semi"
	UnlockModeOptions[2] = "Auto"
EndFunction