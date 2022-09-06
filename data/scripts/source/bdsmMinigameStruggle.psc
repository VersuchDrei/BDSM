ScriptName bdsmMinigameStruggle Extends bdsmMinigameModel

bdsmLibs Property Libs Auto

bdsmMeter Property bdsmStruggleProgressBar Auto
Spell Property bdsmAbStruggleBlockStaminaRegen Auto

bool isPlayer

bool key1pressed = False
bool key2pressed = False
bool key3pressed = False
bool key4pressed = False

float goal = 0.0
float progress = 0.0
int randomIndex = 0

Actor target
Armor item

Event OnKeyDown(int KeyCode)
	If Libs.bdsmStruggleKey1.value == KeyCode
		key1pressed = True
	ElseIf Libs.bdsmStruggleKey2.value == KeyCode
		key2pressed = True
	ElseIf Libs.bdsmStruggleKey3.value == KeyCode
		key3pressed = True
	ElseIf Libs.bdsmStruggleKey4.value == KeyCode
		key4pressed = True
	EndIf
EndEvent

Event OnKeyUp(int KeyCode, float HoldTime)
	If Libs.bdsmStruggleKey1.value == KeyCode
		key1pressed = False
	ElseIf Libs.bdsmStruggleKey2.value == KeyCode
		key2pressed = False
	ElseIf Libs.bdsmStruggleKey3.value == KeyCode
		key3pressed = False
	ElseIf Libs.bdsmStruggleKey4.value == KeyCode
		key4pressed = False
	EndIf
EndEvent

Event OnUpdate()
	If Utility.RandomInt(0, 5) == 0
		SetRandomIndex()
	EndIf

	int keyCount = GetKeyCount()

	If keyCount > 1
		DamageStamina(5)
	ElseIf IsRandomKeyPressed()
		progress += 2 * libs.bdsmStruggleEscapeMult.value
		bdsmStruggleProgressBar.SetPercent(progress / goal)
		DamageStamina(1)
	ElseIf keyCount == 1
		DamageStamina(2)
	EndIf

	If progress >= goal
		TearDown()
		MinigameSuccess(target, item)
	ElseIf Libs.PlayerRef.GetAV("stamina") <= 0
		TearDown()
	Else
		RegisterForSingleUpdate(0.2)
	EndIf
EndEvent

Function StartMinigame(Actor akActor, Armor akArmor)
	bdsmStruggleProgressBar.ForcePercent(0)
	bdsmStruggleProgressBar.FadeTo(100, 1)
	bdsmStruggleProgressBar.FadedOut = False

	target = akActor
	item = akArmor

	isPlayer = akActor == Libs.PlayerRef

	key1pressed = False
	key2pressed = False
	key3pressed = False
	key4pressed = False

	int i = Libs.bdsmStruggleDifficulties.Length
	While i
		i -= 1
		If akArmor.HasKeyword(Libs.bdsmStruggleDifficulties[i])
			goal = 20 * (i + 1)
		EndIf
	EndWhile
	progress = 0
	SetRandomIndex()

	Game.ForceThirdPerson()

	akActor.SetUnconscious(True)
	akActor.SetRestrained(True)

	If !isPlayer
		Libs.PlayerRef.SetUnconscious(True)
		Libs.PlayerRef.SetRestrained(True)
	EndIf

	RegisterForKey(Libs.bdsmStruggleKey1.value As int)
	RegisterForKey(Libs.bdsmStruggleKey2.value As int)
	RegisterForKey(Libs.bdsmStruggleKey3.value As int)
	RegisterForKey(Libs.bdsmStruggleKey4.value As int)

	If akArmor.HasKeyword(Libs.bdsmArmbinder)
		Debug.SendAnimationEvent(akActor, "bdsmStruggleArmbinder")
	ElseIf akArmor.HasKeyword(Libs.bdsmYoke)
		Debug.SendAnimationEvent(akActor, "bdsmStruggleYoke")
	Else
		Debug.SendAnimationEvent(akActor, "bdsmStruggleGeneral")
	EndIf

	If !isPlayer
		Debug.SendAnimationEvent(Libs.PlayerRef, "bdsmStruggleGeneral")
	EndIf

	Libs.PlayerRef.AddSpell(bdsmAbStruggleBlockStaminaRegen, False)

	RegisterForSingleUpdate(0.2)
EndFunction

Function TearDown()
	bdsmStruggleProgressBar.FadeTo(0, 1)
	bdsmStruggleProgressBar.FadedOut = True

	target.SetUnconscious(False)
	target.SetRestrained(False)

	If !isPlayer
		Libs.PlayerRef.SetUnconscious(False)
		Libs.PlayerRef.SetUnconscious(False)
	EndIf

	UnregisterForKey(Libs.bdsmStruggleKey1.value As int)
	UnregisterForKey(Libs.bdsmStruggleKey2.value As int)
	UnregisterForKey(Libs.bdsmStruggleKey3.value As int)
	UnregisterForKey(Libs.bdsmStruggleKey4.value As int)

	Debug.SendAnimationEvent(target, "IdleForceDefaultState")

	If !isPlayer
		Debug.SendAnimationEvent(Libs.PlayerRef, "IdleForceDefaultState")
	EndIf

	Libs.PlayerRef.RemoveSpell(bdsmAbStruggleBlockStaminaRegen)
EndFunction

Function SetRandomIndex()
	randomIndex = Utility.RandomInt(0, 3)
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
	Libs.PlayerRef.DamageAV("stamina", damage * Libs.bdsmStruggleStaminaMult.value)
EndFunction