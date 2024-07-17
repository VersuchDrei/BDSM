ScriptName bdsmEscapeGameStruggle Extends bdsmEscapeGame

Actor Property PlayerRef Auto

GlobalVariable Property bdsmStruggleKey1 Auto
GlobalVariable Property bdsmStruggleKey2 Auto
GlobalVariable Property bdsmStruggleKey3 Auto
GlobalVariable Property bdsmStruggleKey4 Auto

GlobalVariable Property bdsmStruggleEscapeMult Auto
GlobalVariable Property bdsmStruggleStaminaMult Auto

Keyword Property bdsmArmbinder Auto
Keyword Property bdsmYoke Auto

OSexBar Property bdsmStruggleProgressBar Auto
Spell Property bdsmAbStruggleBlockStaminaRegen Auto

bool shownTutorial = false

bool isPlayer

bool key1pressed = False
bool key2pressed = False
bool key3pressed = False
bool key4pressed = False

float goal = 0.0
float progress = 0.0
int randomIndex = 0

Actor TargetVar
Armor RestraintVar

Event OnKeyDown(int KeyCode)
	If bdsmStruggleKey1.value == KeyCode
		key1pressed = True
	ElseIf bdsmStruggleKey2.value == KeyCode
		key2pressed = True
	ElseIf bdsmStruggleKey3.value == KeyCode
		key3pressed = True
	ElseIf bdsmStruggleKey4.value == KeyCode
		key4pressed = True
	EndIf
EndEvent

Event OnKeyUp(int KeyCode, float HoldTime)
	If bdsmStruggleKey1.value == KeyCode
		key1pressed = False
	ElseIf bdsmStruggleKey2.value == KeyCode
		key2pressed = False
	ElseIf bdsmStruggleKey3.value == KeyCode
		key3pressed = False
	ElseIf bdsmStruggleKey4.value == KeyCode
		key4pressed = False
	EndIf
EndEvent

Event OnUpdate()
	If Utility.RandomInt(0, 5) == 0
		SetRandomIndex()
	Else
		bdsmStruggleProgressBar.SecondaryColor = 0x808080
	EndIf

	int keyCount = GetKeyCount()

	If keyCount > 1
		DamageStamina(5)
	ElseIf IsRandomKeyPressed()
		progress += 2 * bdsmStruggleEscapeMult.value
		bdsmStruggleProgressBar.SetPercent(progress / goal)
		DamageStamina(1)
	ElseIf keyCount == 1
		DamageStamina(2)
	EndIf

	If progress >= goal
		TearDown()
		EscapeGameSuccess(TargetVar, RestraintVar)
	ElseIf PlayerRef.GetAV("stamina") <= 0
		TearDown()
	Else
		RegisterForSingleUpdate(0.2)
	EndIf
EndEvent

Function StartEscapeGame(int Difficulty, Actor Target, Armor Restraint)
	CloseAllMenus()

	If !shownTutorial
		Debug.MessageBox(OData.Localize("$bdsm_escape_game_struggle_tutorial"))
		shownTutorial = true
	EndIf

	bdsmStruggleProgressBar.ForcePercent(0)
	bdsmStruggleProgressBar.FadeTo(100, 1)
	bdsmStruggleProgressBar.FadedOut = False

	TargetVar = Target
	RestraintVar = Restraint

	isPlayer = Target == PlayerRef

	key1pressed = False
	key2pressed = False
	key3pressed = False
	key4pressed = False

	goal = 20 * (Difficulty + 1)
	progress = 0
	SetRandomIndex()

	Game.ForceThirdPerson()

	Game.SetPlayerAIDriven(true)
	Game.DisablePlayerControls(false, false, false, false, false, false, true, false, 0)

	If !isPlayer
		Target.SetUnconscious(True)
		Target.SetRestrained(True)
	EndIf

	RegisterForKey(bdsmStruggleKey1.value As int)
	RegisterForKey(bdsmStruggleKey2.value As int)
	RegisterForKey(bdsmStruggleKey3.value As int)
	RegisterForKey(bdsmStruggleKey4.value As int)

	If Restraint.HasKeyword(bdsmArmbinder)
		Debug.SendAnimationEvent(Target, "bdsmStruggleArmbinder")
	ElseIf Restraint.HasKeyword(bdsmYoke)
		Debug.SendAnimationEvent(Target, "bdsmStruggleYoke")
	Else
		Debug.SendAnimationEvent(Target, "bdsmStruggleGeneral")
	EndIf

	If !isPlayer
		Debug.SendAnimationEvent(PlayerRef, "bdsmStruggleGeneral")
	EndIf

	PlayerRef.AddSpell(bdsmAbStruggleBlockStaminaRegen, False)

	RegisterForSingleUpdate(0.2)
EndFunction

Function TearDown()
	bdsmStruggleProgressBar.FadeTo(0, 1)
	bdsmStruggleProgressBar.FadedOut = True

	Game.SetPlayerAIDriven(false)
	Game.EnablePlayerControls(false, false, false, false, false, false, true, false, 0)

	If !isPlayer
		TargetVar.SetUnconscious(False)
		TargetVar.SetRestrained(False)
	EndIf

	UnregisterForKey(bdsmStruggleKey1.value As int)
	UnregisterForKey(bdsmStruggleKey2.value As int)
	UnregisterForKey(bdsmStruggleKey3.value As int)
	UnregisterForKey(bdsmStruggleKey4.value As int)

	Debug.SendAnimationEvent(TargetVar, "IdleForceDefaultState")

	If !isPlayer
		Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
	EndIf

	PlayerRef.RemoveSpell(bdsmAbStruggleBlockStaminaRegen)
EndFunction

Function SetRandomIndex()
	randomIndex = Utility.RandomInt(0, 3)
	bdsmStruggleProgressBar.SecondaryColor = 0xFFFFFF
EndFunction

bool Function IsRandomKeyPressed()
	If randomIndex == 0
		Return key1pressed
	ElseIf randomIndex == 1
		Return key2pressed
	ElseIf randomIndex == 2
		Return key3pressed
	ElseIf randomIndex == 3
		Return key4pressed
	EndIf
EndFunction

int Function GetKeyCount()
	int keyCount = 0

	If key1pressed
		keyCount += 1
	EndIf
	If key2pressed
		keyCount += 1
	EndIf
	If key3pressed
		keyCount += 1
	EndIf
	If key4pressed
		keyCount += 1
	EndIf

	Return keyCount
EndFunction

Function DamageStamina(float damage)
	PlayerRef.DamageAV("stamina", damage * bdsmStruggleStaminaMult.value)
EndFunction