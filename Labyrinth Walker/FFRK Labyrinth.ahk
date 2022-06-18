#NoEnv
#SingleInstance Force
#WinActivateForce
Menu, Tray, Icon, %A_ScriptDir%\images\FFRK.ico
SetWorkingDir %A_ScriptDir% ;Sets the working directory where the script is actually located.
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
SendMode Input ;More reliable sending mode



TheAlarm=%A_WinDir%\Media\Alarm01.wav
StateChest=%A_AppData%\RK Squared\state\chest.txt

;Limit the search area for ImageSearch. Use %A_ScreenWidth% and %A_ScreenHeight% if you want to search the whole screen
SearchWidth=479
SearchHeight=811

;Paitings Priority
;Change the numbers to change the order
;Remove "painting_boss" if you want to choose a different team for the boss battle
;Priority1=painting_treasure
;Priority2=painting_exploration
;Priority3=painting_onslaught
;Priority4=painting_restoration
;Priority5=painting_combatred
;Priority6=painting_combatorange
;Priority7=painting_combatgreen
;Priority8=painting_portal
;Priority9=painting_boss

;ReturnMouse=yes ;Returns the mouse to the position it was at before clicking on the emulator
;OpenSealedDoor=yes
;ReenterLabyrinth=no
;UseAStaminaPotion=yes
;OpenChestRank=3 ;used for old chest clicker
;MaxChestsToOpen5=1 ;Hero Artifacts. Set to 3 to always open. Set to 1 or 0 if done farming Hero Artifacts
;MaxChestsToOpen4=3 ;Anima Lenses. Set to 3 to always open.
;MaxChestsToOpen3=2 ;6* Motes. Set to 2 if you want to spend 1 key, set to 3 if you want to spend 3 keys
;MaxChestsToOpen2=1 ;Crystals. set to 1 or 0
;MaxChestsToOpen1=0 ;Orbs. set to 1 or 0


;Gui, Font, s8, Segoe UI
Gui, Add, GroupBox, x10 y0 w170 h290, Painting Priority
Gui, Add, DropDownList, x20 y20 w150 h20 R9 vPriority1, painting_treasure||painting_exploration|painting_onslaught|painting_restoration|painting_combatred|painting_combatorange|painting_combatgreen|painting_portal|painting_boss
Gui, Add, DropDownList, x20 y50 w150 h20 R9 vPriority2, painting_treasure|painting_exploration||painting_onslaught|painting_restoration|painting_combatred|painting_combatorange|painting_combatgreen|painting_portal|painting_boss
Gui, Add, DropDownList, x20 y80 w150 h10 R9 vPriority3, painting_treasure|painting_exploration|painting_onslaught||painting_restoration|painting_combatred|painting_combatorange|painting_combatgreen|painting_portal|painting_boss
Gui, Add, DropDownList, x20 y110 w150 h20 R9 vPriority4, painting_treasure|painting_exploration|painting_onslaught|painting_restoration||painting_combatred|painting_combatorange|painting_combatgreen|painting_portal|painting_boss
Gui, Add, DropDownList, x20 y140 w150 h10 R9 vPriority5, painting_treasure|painting_exploration|painting_onslaught|painting_restoration|painting_combatred||painting_combatorange|painting_combatgreen|painting_portal|painting_boss
Gui, Add, DropDownList, x20 y170 w150 h10 R9 vPriority6, painting_treasure|painting_exploration|painting_onslaught|painting_restoration|painting_combatred|painting_combatorange||painting_combatgreen|painting_portal|painting_boss
Gui, Add, DropDownList, x20 y200 w150 h20 R9 vPriority7, painting_treasure|painting_exploration|painting_onslaught|painting_restoration|painting_combatred|painting_combatorange|painting_combatgreen||painting_portal|painting_boss
Gui, Add, DropDownList, x20 y230 w150 h20 R9 vPriority8, painting_treasure|painting_exploration|painting_onslaught|painting_restoration|painting_combatred|painting_combatorange|painting_combatgreen|painting_portal||painting_boss
Gui, Add, DropDownList, x20 y260 w150 h20 R9 vPriority9, painting_treasure|painting_exploration|painting_onslaught|painting_restoration|painting_combatred|painting_combatorange|painting_combatgreen|painting_portal|painting_boss||
Gui, Add, GroupBox, x210 y0 w190 h170, Max Chests To Open
Gui, Add, Text, x220 y20 w110 h20, Hero Artifacts
Gui, Add, Text, x220 y50 w110 h20, Anima Lenses
Gui, Add, Text, x220 y80 w110 h20, 6* Motes
Gui, Add, Text, x220 y110 w110 h20, 6* Crystals
Gui, Add, Text, x220 y140 w110 h20, 5* Orbs
Gui, Add, DropDownList, x340 y20 w50 h20 R4 vMaxChestsToOpen5, 3||2|1|0
Gui, Add, DropDownList, x340 y50 w50 h20 R4 vMaxChestsToOpen4, 3||2|1|0
Gui, Add, DropDownList, x340 y80 w50 h20 R4 vMaxChestsToOpen3, 3|2||1|0
Gui, Add, DropDownList, x340 y110 w50 h20 R4 vMaxChestsToOpen2, 3|2||1|0
Gui, Add, DropDownList, x340 y140 w50 h20 R4 vMaxChestsToOpen1, 3|2|1|0||
Gui, Add, Text, x220 y180 w110 h20, Return Mouse
Gui, Add, Text, x220 y210 w110 h20, Open Sealed Door
Gui, Add, Text, x220 y240 w110 h20, Re-Enter Lab
Gui, Add, Text, x220 y270 w110 h20, Use A Stamina Potion
Gui, Add, DropDownList, x340 y180 w50 h20 R2 vReturnMouse, yes||no
Gui, Add, DropDownList, x340 y210 w50 h20 R2 vOpenSealedDoor, yes||no
Gui, Add, DropDownList, x340 y240 w50 h20 R2 vReenterLabyrinth, yes||no
Gui, Add, DropDownList, x340 y270 w50 h20 R2 vUseAStaminaPotion, yes||no
Gui, Show, AutoSize, FFRK Labyrinth Walker


Pause ;Script begins paused
Gosub, TheMainLoop

F1::
;Press F1 to start and stop your script
Pause, Toggle
WinMove, (MEmu1), , 0, 0 ;, 479, 811 ;Automtically move and resize emulator window
WinMove, RK Squared - Labyrinth, , 583, 0
Gosub, TheMainLoop
Return

F2::
;Press F2 to force close script at anytime.
ExitApp
Return

ClickOnFoundImage:
MouseGetPos, ReturnX, ReturnY
WinGet, Active_ID, ID, A
Click, %FoundX%, %FoundY%, Left
If (ReturnMouse="yes")
	{
	Click, %ReturnX%, %ReturnY%, 0
	WinActivate ahk_id %Active_ID%
	}
TimeoutCounter = 0
Return

TheMainLoop:
Loop
	{
	Sleep 100
	Gui, Submit, NoHide
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\werenotabletoconnect.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\resume.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\restart_defeat.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\restart.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\systemerror_ok.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\backtotitle.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\announcements.png
	If (ErrorLevel = 0)
		{
		ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\close_announcements.png
		If (ErrorLevel = 0)
			{
			Gosub, ClickOnFoundImage
			Sleep 2000
			}
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\missioncomplete.png
	If (ErrorLevel = 0)
		{
		ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\close_missioncomplete.png
		If (ErrorLevel = 0)
			{
			Gosub, ClickOnFoundImage
			Sleep 2000
			}
		ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\close_missioncomplete2.png
		If (ErrorLevel = 0)
			{
			Gosub, ClickOnFoundImage
			Sleep 2000
			}
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\useastaminapotion.png
	If (ErrorLevel = 0)
		{
		If (UseAStaminaPotion="yes")
			{
			Gosub, ClickOnFoundImage
			Sleep 2000
			}
		else
			{
			Sleep 540000 ;9 minutes
			}
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\useastaminapotion_yes.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\useastaminapotion_yes2.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\back.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\homescreen.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\instabattle.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\auto.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\abilitiesoff.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\soulbreaksoff.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\ffrkapp.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\play.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *50 %A_ScriptDir%\images\exploring.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *50 %A_ScriptDir%\images\labyrinthdungeons.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\enter_start_labyrinth.png
	If (ErrorLevel = 0)
		{
		If (ReenterLabyrinth="yes")
			{
			Sleep 2000
			Gosub, ClickOnFoundImage
			Sleep 2000
			}
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\enter_start_labyrinth2.png
	If (ErrorLevel = 0)
		{
		If (ReenterLabyrinth="yes")
			{
			Gosub, ClickOnFoundImage
			Sleep 2000
			}
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\beginbattle.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\go.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\ok.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\ok_brown.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\ok_magicite_level.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\ok2.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\ok3.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\ok_restorestamina.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\ok_anerrorhasoccurred.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\inside_explorationpainting.png
	If (ErrorLevel = 0)
		{
		;This "Move On" button is only clicked when inside an "Exploration Painting" to prevent the script from clicking on the "Move On" button while inside a "Treasure Painting"
		ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\moveon.png
		If (ErrorLevel = 0)
			{
			Gosub, ClickOnFoundImage
			Sleep 2000
			}
		ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\moveon2.png
		If (ErrorLevel = 0)
			{
			Gosub, ClickOnFoundImage
			Sleep 2000
			}
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\inside_restoration.png
	If (ErrorLevel = 0)
		{
		;This "Move On" button is only clicked when inside an "Restoration Painting" to prevent the script from clicking on the "Move On" button while inside a "Treasure Painting"
		ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\moveon.png
		If (ErrorLevel = 0)
			{
			Gosub, ClickOnFoundImage
			Sleep 2000
			}
		ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\moveon2.png
		If (ErrorLevel = 0)
			{
			Gosub, ClickOnFoundImage
			Sleep 2000
			}
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\inside_onslaught.png
	If (ErrorLevel = 0)
		{
		;This "Move On" button is only clicked when inside an "Onslaught Painting" to prevent the script from clicking on the "Move On" button while inside a "Treasure Painting"
		ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\moveon.png
		If (ErrorLevel = 0)
			{
			Gosub, ClickOnFoundImage
			Sleep 2000
			}
		ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\moveon2.png
		If (ErrorLevel = 0)
			{
			Gosub, ClickOnFoundImage
			Sleep 2000
			}
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\skip.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\next.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\sealeddoor.png
	If (ErrorLevel = 0)
		{
		If (OpenSealedDoor="yes")
			{
			ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\yes.png
			If (ErrorLevel = 0)
				{
				;Only click on "Yes" when presented with a Sealed Door.
				Gosub, ClickOnFoundImage
				Sleep 2000
				}
			}
		If (OpenSealedDoor="no")
			{
			ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\no.png
			If (ErrorLevel = 0)
				{
				;Only click on "no" when presented with a Sealed Door.
				Gosub, ClickOnFoundImage
				Sleep 2000
				}
			}
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\inside_treasurepainting.png
	If (ErrorLevel = 0)
		{
		If FileExist(StateChest)
			{
			;SoundPlay, %TheAlarm%, 1
			FileReadLine, ChestLine, %StateChest%, 1
			ChestArray := StrSplit(ChestLine, ",")
			Gosub, ClickChests
			}
		Else
			{
			SoundPlay, %TheAlarm%, 1
			}
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\open.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		ChestsOpened += 1
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\useamagickey.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\dungeoncomplete.png
	If (ErrorLevel = 0)
		{
		If (ReenterLabyrinth="yes")
			{
			ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\close_dungeoncomplete.png
			If (ErrorLevel = 0)
				{
				Gosub, ClickOnFoundImage
				Sleep 2000
				}
			}
		If (ReenterLabyrinth="no")
			{
			SoundPlay, %TheAlarm%, 1
			}
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\labyrinth_blue.png
	If (ErrorLevel = 0)
		{
		;Only use the painting priority loop when inside main labyrinth to prevent the script from cycling too early and choosing the wrong painting.
		Sleep 2000
		Gosub, PaintingPriority
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\labyrinth_purple.png
	If (ErrorLevel = 0)
		{
		;Last floor is purple. Only use the painting priority loop when inside main labyrinth to prevent the script from cycling too early and choosing the wrong painting.
		Sleep 2000
		Gosub, PaintingPriority
		}
	TimeoutCounter += 1
	;Tooltip, %TimeoutCounter%
	If (TimeoutCounter > 180)
		{
		SoundPlay, %TheAlarm%, 1
		ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\home.png
		If (ErrorLevel = 0)
			{
			Gosub, ClickOnFoundImage
			Sleep 2000
			}
		}
	}
Return

ClickChests:
If (MaxChestsToOpen5 = 3) ;Hero Artifacts are skipped to last if MaxChestsToOpen5 is not 3
{
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest1.png
	If (ErrorLevel = 0)
		{
		If (ChestArray[1] = 5 and MaxChestsToOpen5 > ChestsOpened)
			{
			Gosub, ClickOnFoundImage
			Sleep 2000
			}
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest2.png
	If (ErrorLevel = 0)
		{
		If (ChestArray[2] = 5 and MaxChestsToOpen5 > ChestsOpened)
			{
			Gosub, ClickOnFoundImage
			Sleep 2000
			}
		}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest3.png
	If (ErrorLevel = 0)
		{
		If (ChestArray[3] = 5 and MaxChestsToOpen5 > ChestsOpened)
			{
			Gosub, ClickOnFoundImage
			Sleep 2000
			}
		}
}



ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest1.png
If (ErrorLevel = 0)
	{
	If (ChestArray[1] = 4 and MaxChestsToOpen4 > ChestsOpened)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	}
ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest2.png
If (ErrorLevel = 0)
	{
	If (ChestArray[2] = 4 and MaxChestsToOpen4 > ChestsOpened)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	}
ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest3.png
If (ErrorLevel = 0)
	{
	If (ChestArray[3] = 4 and MaxChestsToOpen4 > ChestsOpened)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	}




ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest1.png
If (ErrorLevel = 0)
	{
	If (ChestArray[1] = 3 and MaxChestsToOpen3 > ChestsOpened)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	}
ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest2.png
If (ErrorLevel = 0)
	{
	If (ChestArray[2] = 3 and MaxChestsToOpen3 > ChestsOpened)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	}
ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest3.png
If (ErrorLevel = 0)
	{
	If (ChestArray[3] = 3 and MaxChestsToOpen3 > ChestsOpened)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	}



ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest1.png
If (ErrorLevel = 0)
	{
	If (ChestArray[1] = 2 and MaxChestsToOpen2 > ChestsOpened)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	}
ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest2.png
If (ErrorLevel = 0)
	{
	If (ChestArray[2] = 2 and MaxChestsToOpen2 > ChestsOpened)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	}
ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest3.png
If (ErrorLevel = 0)
	{
	If (ChestArray[3] = 2 and MaxChestsToOpen2 > ChestsOpened)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	}



ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest1.png
If (ErrorLevel = 0)
	{
	If (ChestArray[1] = 1 and MaxChestsToOpen1 > ChestsOpened)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	}
ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest2.png
If (ErrorLevel = 0)
	{
	If (ChestArray[2] = 1 and MaxChestsToOpen1 > ChestsOpened)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	}
ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest3.png
If (ErrorLevel = 0)
	{
	If (ChestArray[3] = 1 and MaxChestsToOpen1 > ChestsOpened)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	}




ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest1.png
If (ErrorLevel = 0)
	{
	If (ChestArray[1] = 5 and MaxChestsToOpen5 > ChestsOpened)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	}
ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest2.png
If (ErrorLevel = 0)
	{
	If (ChestArray[2] = 5 and MaxChestsToOpen5 > ChestsOpened)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	}
ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest3.png
If (ErrorLevel = 0)
	{
	If (ChestArray[3] = 5 and MaxChestsToOpen5 > ChestsOpened)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		}
	}





If (ChestsOpened >= 1)
	{
	;As a safety measure this Move On will only be clicked if at least 1 Treasure Chest has been opened.
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\moveon.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		ChestsOpened = 0
		}
	}
Return


ClickChestsOld:
If (ChestArray[1] >= OpenChestRank)
	{
	;MsgBox % "Opening left chest with rank " ChestArray[1]
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest1.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		Goto, TheMainLoop
		}
	}
If (ChestArray[2] >= OpenChestRank)
	{
	;MsgBox % "Opening center chest with rank " ChestArray[2]
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest2.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		Goto, TheMainLoop
		}
	}
If (ChestArray[3] >= OpenChestRank)
	{
	;MsgBox % "Opening right chest with rank " ChestArray[3]
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\chest3.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		Goto, TheMainLoop
		}
	}
If (ChestsOpened >= 1)
	{
	;As a safety measure this Move On will only be clicked if at least 1 Treasure Chest has been opened.
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\moveon.png
	If (ErrorLevel = 0)
		{
		Gosub, ClickOnFoundImage
		Sleep 2000
		ChestsOpened = 0
		}
	}
Return


PaintingPriority:
ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\%Priority1%.png
If (ErrorLevel = 0)
	{
	Gosub, ClickOnFoundImage
	Sleep 500
	Gosub, ClickOnFoundImage
	Sleep 2000
	}
ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\%Priority2%.png
If (ErrorLevel = 0)
	{
	Gosub, ClickOnFoundImage
	Sleep 500
	Gosub, ClickOnFoundImage
	Sleep 2000
	}
ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\%Priority3%.png
If (ErrorLevel = 0)
	{
	Gosub, ClickOnFoundImage
	Sleep 500
	Gosub, ClickOnFoundImage
	Sleep 2000
	}
ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\%Priority4%.png
If (ErrorLevel = 0)
	{
	Gosub, ClickOnFoundImage
	Sleep 500
	Gosub, ClickOnFoundImage
	Sleep 2000
	}
ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\%Priority5%.png
If (ErrorLevel = 0)
	{
	Gosub, ClickOnFoundImage
	Sleep 500
	Gosub, ClickOnFoundImage
	Sleep 2000
	}
ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\%Priority6%.png
If (ErrorLevel = 0)
	{
	Gosub, ClickOnFoundImage
	Sleep 500
	Gosub, ClickOnFoundImage
	Sleep 2000
	}
ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\%Priority7%.png
If (ErrorLevel = 0)
	{
	Gosub, ClickOnFoundImage
	Sleep 500
	Gosub, ClickOnFoundImage
	Sleep 2000
	}
ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\%Priority8%.png
If (ErrorLevel = 0)
	{
	Gosub, ClickOnFoundImage
	Sleep 500
	Gosub, ClickOnFoundImage
	Sleep 2000
	}
	ImageSearch, FoundX, FoundY, 0, 0, %SearchWidth%, %SearchHeight%, *90 %A_ScriptDir%\images\%Priority9%.png
If (ErrorLevel = 0)
	{
	Gosub, ClickOnFoundImage
	Sleep 500
	Gosub, ClickOnFoundImage
	Sleep 2000
	}
Return

GuiClose:
ExitApp