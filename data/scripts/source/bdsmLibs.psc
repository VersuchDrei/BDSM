;/* bdsmLibs
* * this is a collection of all the properties the various bdsm scripts utilize
* * basic mods shouldn't need a reference to this
*/;
ScriptName bdsmLibs Extends Quest

; a reference of Game::GetPlayer for quick access, as calling the function is slow
Actor Property PlayerRef Auto
; an empty FormList for the inventory filter in bdsmActorImpl
FormList Property bdsmEmptyList Auto
; you know what lockpicks are
MiscObject Property Lockpick Auto
; the unarmed weapon, makes unequipping two handed weapons / spells easier
Weapon Property Unarmed Auto
; to identify both hand spells
EquipSlot Property BothHands Auto

; ---------- factions ----------
; faction for actors that get aroused by being tied up
Faction Property bdsmBondageLoverFaction Auto
; faction for dominant actors
Faction Property bdsmDominantFaction Auto
; faction for masochistic actors
Faction Property bdsmMasochistFaction Auto
; faction for sadistic actors
Faction Property bdsmSadistFaction Auto
; faction for submissive actors
Faction Property bdsmSubmissiveFaction Auto

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

; ---------- item effect abilities ----------
; the holder quest for the slow effect of devices that restrain speed
bdsmAbilityHolder Property bdsmAbilityHolderRestrainRunning Auto
; the holder quest for the slow effect of devices that restrain speed heavily
bdsmAbilityHolder Property bdsmAbilityHolderRestrainWalking Auto
; the holder quest for the effect that prevents eating / drinking potions when gaggeg
bdsmAbilityHolder Property bdsmAbilityHolderRestrainFood Auto
; the holder quest for the blindness effect of blindfolds
bdsmAbilityHolder Property bdsmAbilityHolderRestrainSight Auto
; an ability with a keyword for condition checks in dialogue topics
Spell Property bdsmAbRestrainSpeech Auto
; an ability with a keyword for condition checks in dialogue topics
Spell Property bdsmAbRestrainSpeechFull Auto


; the super keyword for any item handled by this framework, every bonadge item needs this or the framework won't recognize it
Keyword Property bdsmLockable Auto
; keyword for items that can just be removed again but still need to be handled by the scripts (e.g. plugs)
Keyword Property bdsmRemovable Auto
; items that are to be removed when they get unlocked
Keyword Property bdsmRemoveOnUnlock Auto

; keywords for item classification
Keyword Property bdsmAnkleChain Auto
Keyword Property bdsmArmbinder Auto
Keyword Property bdsmArmbinderOpen Auto ; armbinder that doesn't prevent (un-)equipping cuffs etc.
Keyword Property bdsmArmRestraint Auto
Keyword Property bdsmBlindfold Auto
Keyword Property bdsmBoots Auto
Keyword Property bdsmBootsOverknee Auto
Keyword Property bdsmBootsThighhigh Auto
Keyword Property bdsmCatsuit Auto
Keyword Property bdsmCatsuitOpen Auto
Keyword Property bdsmChastityBelt Auto
Keyword Property bdsmChastityBeltOpen Auto
Keyword Property bdsmChastityBra Auto
Keyword Property bdsmCockCage Auto
Keyword Property bdsmCollar Auto
Keyword Property bdsmCorset Auto
Keyword Property bdsmCuffsArms Auto
Keyword Property bdsmCuffsLegs Auto
Keyword Property bdsmGag Auto
Keyword Property bdsmGagBig Auto
Keyword Property bdsmGagOpen Auto
Keyword Property bdsmGagOTM Auto
Keyword Property bdsmGloves Auto
Keyword Property bdsmHarness Auto
Keyword Property bdsmHood Auto
Keyword Property bdsmHoodGwen Auto
Keyword Property bdsmHoodAirway Auto
Keyword Property bdsmLegbinder Auto
Keyword Property bdsmLegbinderOpen Auto ; legbinder that doesn't prevent unequipping cuffs etc.
Keyword Property bdsmMask Auto ; basically hoods that don't cover eyes or mouth
Keyword Property bdsmMittens Auto
Keyword Property bdsmPlugAnal Auto
Keyword Property bdsmPlugVaginal Auto
Keyword Property bdsmStraitjacket Auto
Keyword Property bdsmStraitjacketOpen Auto ; straitjacket with open boobs
Keyword Property bdsmYoke Auto

; keywords for item effects
Keyword Property bdsmRestrainShouts Auto
Keyword Property bdsmRestrainSight Auto
Keyword Property bdsmRestrainSpells Auto
Keyword Property bdsmRestrainSpeech Auto
Keyword Property bdsmRestrainSpeechFull Auto
Keyword Property bdsmRestrainWeapons Auto
Keyword Property bdsmSlowMovement Auto
Keyword Property bdsmVerySlowMovement Auto

; keywords for item covering (covered items cannot be unlocked)
Keyword Property bdsmCoverAnus Auto
Keyword Property bdsmCoverArms Auto
Keyword Property bdsmCoverBelly Auto
Keyword Property bdsmCoverEyes Auto
Keyword Property bdsmCoverGenital Auto
Keyword Property bdsmCoverLegs Auto
Keyword Property bdsmCoverMouth Auto

; keywords for physics
Keyword Property bdsmBellyPhysicsOff Auto
Keyword Property bdsmBellyPhysicsOn Auto
Keyword Property bdsmBreastPhysicsOff Auto
Keyword Property bdsmBreastPhysicsOn Auto
Keyword Property bdsmButtPhysicsOff Auto
Keyword Property bdsmButtPhysicsOn Auto
Keyword Property bdsmLegPhysicsOff Auto
Keyword Property bdsmLegPhysicsOn Auto
Keyword Property bdsmPenisPhysicsOff Auto
Keyword Property bdsmPenisPhysicsOn Auto

; library to look up restrain masks per keyword
Keyword[] libraryKeywords
int[] libraryRestrainMasks
Keyword[] libraryInverseKeywords
int[] libraryInverseRestrainMasks

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Messages ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; gets shown when the player manually equips an item and has the MCM option enabled
Message Property bdsmConfirmationMessage Auto
; gets shown when the player tries to drop or stash an item they are currently wearing
Message Property bdsmMustUnlockFirstMessage Auto
; gets shown when the player can't unlock an item because their arms are restrained
Message Property bdsmFreeArmsFirstMessage Auto
; gets shown when the item can't be unlocked because the arms are covered by another item
Message Property bdsmUnlockArmsFirstMessage Auto
; gets shown when trying to unequip a plug that is held in place by a castity belt / harness
Message Property bdsmUnlockBeltFirstMessage Auto
; gets shown when trying to unequip a nipple piercing / clamp that is held in place by a castity bra
Message Property bdsmUnlockBraFirstMessage Auto
; gets shown when trying to unequip a gag / blindfold that is held in place by a hood
Message Property bdsmUnlockHoodFirstMessage Auto
; gets shown when the item can't be unlocked because the legs are covered by another item
Message Property bdsmUnlockLegsFirstMessage Auto
; gets shown when trying to unlock a harness that is held in place by a straitjacket
Message Property bdsmUnlockBodyFirstMessage Auto
; gets shown when the player has no means to unlock this item
Message Property bdsmCantUnlockMessage Auto
; gets shown when the player tries to unlock an item and states their options
Message Property bdsmUnlockOptionMessage Auto
GlobalVariable Property bdsmOfferUnlockOptionKey Auto ; can unlock the item with a key
GlobalVariable Property bdsmOfferUnlockOptionLockpick Auto ; can lockpick the item
GlobalVariable Property bdsmOfferUnlockOptionStruggle Auto ; can struggle out of the item
GlobalVariable Property bdsmOfferUnlockOptionMagic Auto ; can use magic to unlock the item
int Property UnlockOptionKey = 0 AutoReadOnly ; use the key to unlock the item
int Property UnlockOptionLockpick = 1 AutoReadOnly ; try to pick the items lock
int Property UnlockOptionStruggle = 2 AutoReadOnly ; try to struggle out of the item
int Property UnlockOptionMagic = 3 AutoReadOnly ; try to unlock the item with magic
int Property UnlockOptionCancel = 4 AutoReadOnly ; do nothing

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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Locks ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; the holder quest for the lockpicking minigame
bdsmMinigameHolder Property bdsmMinigameHolderLockpick Auto

; keywords for the different lock difficulties
Keyword[] Property bdsmLockDifficulties Auto
; the keys to unlock the respective locks
Key[] Property bdsmBasicKeys Auto

; items that can't be lockpicked
Keyword Property bdsmRequiresKey Auto
; locks the player can't reach themselves (like armbinders for example)
Keyword Property bdsmUnreachableLock Auto
; ignore the MCM setting and never consume the key when unlocking this item
Keyword Property bdsmNeverConsumeKey Auto
; ignore the MCM setting and always consume the key when unlocking this item
Keyword Property bdsmAlwaysConsumeKey Auto

; items that require a custom key
Keyword Property bdsmCustomKey Auto
; keywords for the different custom keys
FormList Property bdsmCustomKeyKeywords Auto
; the different custom keys
FormList Property bdsmCustomKeys Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Struggle ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; the holder quest for the struggling minigame
bdsmMinigameHolder Property bdsmMinigameHolderStruggle Auto
; keywords for the different struggle difficulties
Keyword[] Property bdsmStruggleDifficulties Auto

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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Magic ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; the holder quest for the struggling minigame
bdsmMinigameHolder Property bdsmMinigameHolderMagic Auto
; keywords for the different struggle difficulties
Keyword[] Property bdsmMagicDifficulties Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SKSE Functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;/* AttachBdsmActor
* * attaches the bdsmActor script (or more precisely the bdsmActorImpl script) to the given actor, if they don't already have it
* * 
* * @param: akActor, the actor to attach the script to
*/;
Function AttachBdsmActor(Actor akActor) Global Native

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

;/* RebuildRestrainMaskLibrary
* * rebuilds the library of restrain masks per keyword
* * there is no reason to ever call this in your plugin
*/;
Function RebuildRestrainMaskLibrary()
	bdsmActor masks = PlayerRef As bdsmActor

	libraryKeywords = new Keyword[38]
	libraryRestrainMasks = new int[38]

	libraryInverseKeywords = new Keyword[14]
	libraryInverseRestrainMasks = new int[14]

	; ---------- classification keywords ----------
	libraryKeywords[0]       = bdsmArmbinder
	libraryRestrainMasks[0]  = masks.restrainArms + masks.restrainWeapons + masks.restrainSpells + masks.blockHands + masks.coverArms
	
	libraryKeywords[1]       = bdsmArmRestraint
	libraryRestrainMasks[1]  = masks.restrainArms + masks.restrainWeapons + masks.restrainSpells + masks.blockHands
	
	libraryKeywords[2]       = bdsmBlindfold
	libraryRestrainMasks[2]  = masks.restrainSight
	
	libraryKeywords[3]       = bdsmBootsThighhigh
	libraryRestrainMasks[3]  = masks.stopLegPhysics
	
	libraryKeywords[4]       = bdsmCatsuit
	libraryRestrainMasks[4]  = masks.blockVagina + masks.blockCock + masks.blockAnus + masks.coverGenital + masks.coverAnus + masks.blockChest + masks.coverChest
	
	libraryKeywords[5]       = bdsmChastityBelt
	libraryRestrainMasks[5]  = masks.blockVagina + masks.blockCock + masks.blockAnus + masks.coverGenital + masks.coverAnus + masks.stopBellyPhysics + masks.stopButtPhysics + masks.stopPenisPhysics
	
	libraryKeywords[6]       = bdsmChastityBra
	libraryRestrainMasks[6]  = masks.blockChest + masks.coverChest + masks.stopBreastPhysics
	
	libraryKeywords[7]       = bdsmCockCage
	libraryRestrainMasks[7]  = masks.blockCock + masks.stopPenisPhysics

	libraryKeywords[8]       = bdsmCorset
	libraryRestrainMasks[8]  = masks.coverBelly + masks.stopBellyPhysics
	
	libraryKeywords[9]       = bdsmGag
	libraryRestrainMasks[9]  = masks.restrainSpeech + masks.restrainShouts + masks.restrainFood + masks.blockMouth + masks.openMouth

	libraryKeywords[10]      = bdsmGagBig
	libraryRestrainMasks[10] = masks.restrainSpeechFull

	libraryKeywords[11]      = bdsmHood
	libraryRestrainMasks[11] = masks.coverMouth + masks.coverEyes
	
	libraryKeywords[12]      = bdsmLegbinder
	libraryRestrainMasks[12] = masks.restrainWalking + masks.coverLegs + masks.stopLegPhysics

	libraryKeywords[13]      = bdsmMittens
	RebuildMittensMaskLibrary(masks)
	
	libraryKeywords[14]      = bdsmPlugAnal
	libraryRestrainMasks[14] = masks.blockAnus
	
	libraryKeywords[15]      = bdsmPlugVaginal
	libraryRestrainMasks[15] = masks.blockVagina
	
	libraryKeywords[16]      = bdsmStraitjacket
	libraryRestrainMasks[16] = masks.restrainArms + masks.restrainWeapons + masks.restrainSpells + masks.blockHands + masks.coverArms + masks.coverChest + masks.coverUpperBody + masks.stopBellyPhysics

	libraryKeywords[17]      = bdsmYoke
	RebuildYokeMaskLibrary(masks)

	; ---------- effect keywords ----------
	libraryKeywords[18]      = bdsmRestrainShouts
	libraryRestrainMasks[18] = masks.restrainShouts
	
	libraryKeywords[19]      = bdsmRestrainSight
	libraryRestrainMasks[19] = masks.restrainSight
	
	libraryKeywords[20]      = bdsmRestrainSpells
	libraryRestrainMasks[2] = masks.restrainSpells
	
	libraryKeywords[21]      = bdsmRestrainSpeech
	libraryRestrainMasks[21] = masks.restrainSpeech
	
	libraryKeywords[22]      = bdsmRestrainSpeechFull
	libraryRestrainMasks[22] = masks.restrainSpeechFull
	
	libraryKeywords[23]      = bdsmRestrainWeapons
	libraryRestrainMasks[23] = masks.restrainWeapons
	
	libraryKeywords[24]      = bdsmSlowMovement
	libraryRestrainMasks[24] = masks.restrainRunning

	libraryKeywords[25]      = bdsmVerySlowMovement
	libraryRestrainMasks[25] = masks.restrainWalking
	
	; ---------- cover keywords ----------
	libraryKeywords[26]      = bdsmCoverAnus
	libraryRestrainMasks[26] = masks.coverAnus
	
	libraryKeywords[27]      = bdsmCoverArms
	libraryRestrainMasks[27] = masks.coverArms

	libraryKeywords[28]      = bdsmCoverBelly
	libraryRestrainMasks[28] = masks.coverBelly
	
	libraryKeywords[29]      = bdsmCoverEyes
	libraryRestrainMasks[29] = masks.coverEyes
	
	libraryKeywords[30]      = bdsmCoverGenital
	libraryRestrainMasks[30] = masks.coverGenital
	
	libraryKeywords[31]      = bdsmCoverLegs
	libraryRestrainMasks[31] = masks.coverLegs
	
	libraryKeywords[32]      = bdsmCoverMouth
	libraryRestrainMasks[32] = masks.coverMouth

	; ---------- physics keywords ----------
	libraryKeywords[33]      = bdsmBellyPhysicsOff
	libraryRestrainMasks[33] = masks.stopBellyPhysics
	
	libraryKeywords[34]      = bdsmBreastPhysicsOff
	libraryRestrainMasks[34] = masks.stopBreastPhysics
	
	libraryKeywords[35]      = bdsmButtPhysicsOff
	libraryRestrainMasks[35] = masks.stopButtPhysics
	
	libraryKeywords[36]      = bdsmLegPhysicsOff
	libraryRestrainMasks[36] = masks.stopLegPhysics
	
	libraryKeywords[37]      = bdsmPenisPhysicsOff
	libraryRestrainMasks[37] = masks.stopPenisPhysics

	; ---------- inverse classification keywords ----------
	libraryInverseKeywords[0] = bdsmArmbinderOpen
	libraryInverseRestrainMasks[0] = masks.coverArms

	libraryInverseKeywords[1] = bdsmCatsuitOpen
	libraryInverseRestrainMasks[1] = masks.blockVagina + masks.blockCock + masks.blockAnus + masks.coverGenital + masks.coverAnus

	libraryInverseKeywords[2] = bdsmChastityBeltOpen
	libraryInverseRestrainMasks[2] = masks.blockAnus + masks.coverAnus

	libraryInverseKeywords[3] = bdsmGagOpen
	RebuildGagOpenMaskLibrary(masks)

	libraryInverseKeywords[4] = bdsmGagOTM
	libraryInverseRestrainMasks[4] = masks.openMouth

	libraryInverseKeywords[5] = bdsmHoodGwen
	libraryInverseRestrainMasks[5] = masks.coverEyes

	libraryInverseKeywords[6] = bdsmHoodAirway
	libraryInverseRestrainMasks[6] = masks.coverMouth

	libraryInverseKeywords[7] = bdsmLegbinderOpen
	libraryInverseRestrainMasks[7] = masks.coverLegs

	libraryInverseKeywords[8] = bdsmStraitjacketOpen
	libraryInverseRestrainMasks[8] = masks.coverChest
	
	libraryInverseKeywords[9]      = bdsmBellyPhysicsOn
	libraryInverseRestrainMasks[9] = masks.stopBellyPhysics
	
	libraryInverseKeywords[10]      = bdsmBreastPhysicsOn
	libraryInverseRestrainMasks[10] = masks.stopBreastPhysics
	
	libraryInverseKeywords[11]      = bdsmButtPhysicsOn
	libraryInverseRestrainMasks[11] = masks.stopButtPhysics
	
	libraryInverseKeywords[12]      = bdsmLegPhysicsOn
	libraryInverseRestrainMasks[12] = masks.stopLegPhysics
	
	libraryInverseKeywords[13]      = bdsmPenisPhysicsOn
	libraryInverseRestrainMasks[13] = masks.stopPenisPhysics

	; ---------- inverse physics keywords ----------
EndFunction

;/* RebuildGagOpenMaskLibrary
* * rebuilds the library of restrain masks for ring gags
* * there is no reason to ever call this in your plugin
* *
* * @param: masks, a bdsmActor to access the restrain masks
*/;
Function RebuildGagOpenMaskLibrary(bdsmActor masks)
	int value = masks.restrainFood + masks.blockMouth
	If bdsmGagOpenShoutPenalty.value != 100
		value += masks.restrainShouts
	EndIf

	libraryInverseRestrainMasks[3] = value
EndFunction

;/* RebuildMittensMaskLibrary
* * rebuilds the library of restrain masks for mittens
* * there is no reason to ever call this in your plugin
* *
* * @param: masks, a bdsmActor to access the restrain masks
*/;
Function RebuildMittensMaskLibrary(bdsmActor masks)
	int value = masks.blockHands
	If bdsmMittensSpellPenalty.value == 100
		value += masks.restrainSpells
	EndIf
	If bdsmMittensWeaponPenalty.value == 100
		value += masks.restrainWeapons
	EndIf

	libraryRestrainMasks[13] = value
EndFunction

;/* RebuildYokeMaskLibrary
* * rebuilds the library of restrain masks for yokes
* * there is no reason to ever call this in your plugin
* *
* * @param: masks, a bdsmActor to access the restrain masks
*/;
Function RebuildYokeMaskLibrary(bdsmActor masks)
	int value = masks.restrainArms + masks.restrainWeapons + masks.blockHands
	If bdsmYokeSpellPenalty.value == 100
		value += masks.restrainSpells
	EndIf

	libraryRestrainMasks[17] = value
EndFunction

;/* GetRestrainMask
* *
* * builds the restrain mask of the given item
* *
* * @param: akArmor, the item to build the restrain mask for
* *
* * @return: the restrain mask of the item
*/;
int Function GetRestrainMask(Armor akArmor)
	int armorMask = 0x0
	int inverseMask = 0x0

	Keyword[] keywords = akArmor.GetKeywords()

	int i = keywords.Length
	While i
		i -= 1
		int j = libraryKeywords.Find(keywords[i])
		If j != -1
			armorMask = Math.LogicalOr(armorMask, libraryRestrainMasks[j])
		Else
			j = libraryInverseKeywords.Find(keywords[i])
			if j != -1
				inverseMask = Math.LogicalOr(inverseMask, libraryInverseRestrainMasks[j])
			EndIf
		EndIf
	EndWhile

	return Math.LogicalAnd(armorMask, Math.LogicalNot(inverseMask))
EndFunction

;/* PlayerUnlocksItem
* * unlocks the item and if it was on an NPC moves it to the players inventory
* *
* * @param: akActor, the actor to unlock the item from
* * @param: akArmor, the item to unlock
*/;
Function PlayerUnlocksItem(bdsmActor akActor, Armor akArmor)
	If akActor.UnlockItemByForm(akArmor, False) && akActor != PlayerRef && !akArmor.HasKeyword(bdsmRemoveOnUnlock)
		akActor.RemoveItem(akArmor, 1, False, PlayerRef)
	EndIf
EndFunction

;/* FindUsableKey
* * looks for a suitable key in the player inventory to unlock the given item
* *
* * @param: akArmor, the item to unlock
* *
* * @return the key if one was found or else None
*/;
Key Function FindUsableKey(Armor akArmor)
	If akArmor.HasKeyword(bdsmCustomKey)
		int i = bdsmCustomKeyKeywords.GetSize()
		While i
			i -= 1
			If akArmor.HasKeyword(bdsmCustomKeyKeywords.GetAt(i) As Keyword)
				Key customKey = bdsmCustomKeys.GetAt(i) As Key
				If PlayerRef.GetItemCount(customKey)
					Return customKey
				Else
					Return None
				EndIf
			EndIf
		EndWhile
		Debug.Trace("Item " + akArmor.GetName() + " is marked for a custom key but no custom key keyword could be found.")
	Else
		int i = 0
		bool suitable = False
		While i < bdsmLockDifficulties.Length
			If suitable
				Key basicKey = bdsmBasicKeys[i]
				If PlayerRef.GetItemCount(basicKey)
					Return basicKey
				EndIf
			ElseIf akArmor.hasKeyword(bdsmLockDifficulties[i])
				Key basicKey = bdsmBasicKeys[i]
				If PlayerRef.GetItemCount(basicKey)
					Return BasicKey
				ElseIf !ExactKeysOnly
					suitable = True
				Else
					Return None
				EndIf
			EndIf
			i += 1
		EndWhile
	EndIf

	Return None
EndFunction

;/* CanLockpick
* * checks if the given item can be lockpicked
* *
* * @param: akArmor, the item to check
* *
* * @return: True if the item can be lockpicked
*/;
bool Function CanLockpick(Armor akArmor)
	If akArmor.HasKeyword(bdsmRequiresKey)
		Return False
	EndIf

	int i = bdsmLockDifficulties.Length
	While i
		i -= 1
		If akArmor.HasKeyword(bdsmLockDifficulties[i])
			Return True
		EndIf
	EndWhile

	Return False
EndFunction

;/* CanStruggleOut
* * checks if the given item can be struggled out of
* *
* * @param: akArmor, the item to check
* *
* * @return: True if the item can be struggled out of
*/;
bool Function CanStruggleOut(Armor akArmor)
	int i = bdsmStruggleDifficulties.Length
	While i
		i -= 1
		If akArmor.HasKeyword(bdsmStruggleDifficulties[i])
			Return True
		EndIf
	EndWhile

	Return False
EndFunction

;/* CanUseMagic
* * checks if the given item can be unlocked by magic
* *
* * @param: akArmor, the item to check
* *
* * @return: True if the item can be unlocked by magic
*/;
bool Function CanUseMagic(Armor akArmor)
	int i = bdsmStruggleDifficulties.Length
	While i
		i -= 1
		If akArmor.HasKeyword(bdsmMagicDifficulties[i])
			Return True
		EndIf
	EndWhile

	Return False
EndFunction

;/* IsArmRestraint
* * checks if the given item is an arm restraint
* *
* * @param: akArmor, the item to check
* *
* * @return: True if the item is an arm restraint
*/;
bool Function IsArmRestraint(Armor akArmor)
	Return akArmor.HasKeyword(bdsmArmbinder) || akArmor.HasKeyword(bdsmArmRestraint) || akArmor.HasKeyword(bdsmStraitjacket) || akArmor.HasKeyword(bdsmStraitjacketOpen) || akArmor.HasKeyword(bdsmYoke)
EndFunction

;/* GetFactionRankUnsigned
* * returns the faction rank of the given actor in the given faction, but negative numbers will return 0
* * 
* * @param: akActor, the actor to get the rank for
* * @param: akFaction, the faction to get the rank in
* *
* * @return: the rank
*/;
int Function GetFactionRankUnsigned(Actor akActor, Faction akFaction)
	int rank = akActor.GetFactionRank(akFaction)

	If rank < 0
		Return 0
	EndIf
	Return rank
EndFunction

;/* SetFactionRankSave
* * sets the faction rank of the given actor in the given faction, adds the actor to the faction if they are not yet a member
* *
* * @param: akActor, the actor to set the rank for
* * @param: akFaction, the faction to get the rank in
* * @param aiRank, the rank to set
*/;
Function SetFactionRankSave(Actor akActor, Faction akFaction, int aiRank)
	If !akActor.IsInFaction(akFaction)
		akActor.AddToFaction(akFaction)
	EndIf

	akActor.ModFactionRank(akFaction, aiRank)
EndFunction