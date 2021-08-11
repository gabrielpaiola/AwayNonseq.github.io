; =======================================================================================
; Name ..........: Primo Marcos
; Description ...: V3 - 18/05_2021
; Language ......: Portugues Brasil (PT-BR)
; Author ........: Away
; =======================================================================================
#Persistent
#SingleInstance, Force
;#NoEnv
;#Warn
#NoTrayIcon ; Disable the tray icon of the script
SendMode, Input
SetWorkingDir, %A_ScriptDir%
SetBatchLines, -1
OnExit, ExitSub
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
ListLines Off
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
PID := DllCall("GetCurrentProcessId")
Process, Priority,, Low
Thread, interrupt, 0
Thread, NoTimers, true

nextpoint = 1

IniRead, EndConfigAtaque, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, EndConfigAtaque
IniRead, EndConfigSuporte, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, EndConfigSuporte
IniRead, Actual_PID, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Actual_PID
IniRead, Hotkey_Quickloot, %EndConfigSuporte%.ini, Loot, Hotkey_Quickloot
IniRead, Tibia_X, %EndConfigSuporte%.ini, Principal, Tibia_X
IniRead, Tibia_Y, %EndConfigSuporte%.ini, Principal, Tibia_Y
IniRead, Tibia_Width, %EndConfigSuporte%.ini, Principal, Tibia_Width
IniRead, Tibia_Height, %EndConfigSuporte%.ini, Principal, Tibia_Height

;msgbox, EndConfigSuporte=%EndConfigSuporte%`n EndConfigAtaque=%EndConfigAtaque%`nTibia_X=%Tibia_X% Tibia_Y=%Tibia_Y%`n Tibia_Width=%Tibia_Width% Tibia_Height=%Tibia_Height%

GUIMain()

;==================================================================================
;================================================================================== GUI Geral
;==================================================================================
GUIMain() {
	Global

;==================================================================================
Nome_Char = %Nick_Tibia%

;==================================================================================


	GUIWidth := 290, GUIHeight := 150
	
	Menu, Tray, Tip, Primo Marcos ; Change the tooltip of the tray icon
	
	Gui, +AlwaysOnTop ; FUNCAO ATIVA, DEIXA MACRO SEMPRE NA FRENTE DA TELA
	Gui, +LastFound -Resize +Theme
	Gui, Color, 202124 ;202124 ;b2b2b2 ;FFFFFF
	Gui, Font, cFFFFFF
	Gui, Margin, 10, 10
	
	Gui, Add, edit,			x10		y5	w150 h20	ReadOnly	 	hwndmyedit, myedit
	Gui, Add, Button, 		x200	y5 	w80 	 					gExitSub, EXIT

	Gui, add, Text, 		x7		y30					 			,%Nick_Tibia%
	
	Gui, Add, CheckBox, 	x7		y40 			 				vCaveHunt, Cave Bot
	Gui, Add, DropDownList, x80		y40		w40		cBlack			vQtdSqms, 2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|%QtdSqms%||
	
	Gui, Add, CheckBox, 	x7		y70 			 				vLureMode, Lure Mode
	Gui, Add, DropDownList, x7		y90	w40		cBlack				vQtdLure, 2|3|4|%QtdLure%||
	
	Gui, Add, CheckBox, 	x120	y70 			 				vLootear, Looter

	

Gui, Show, % " w" GUIWidth " h" GUIHeight, Primo Marcos

} ; FIM DO GUI

Settimer, Cave, 100


		i = 1
		WinGetActiveTitle, TelaAtiva
		
		WinActivate, ahk_class Qt5QWindowOwnDCIcon
		
		ImageSearch, XRef, YRef, 0, 0, 3000, 2000, *45, Imagens\REFMAPA.png	; 
		if (ErrorLevel = 0) {
			Xini = % XRef - 125
			Yini = % YRef - 93

			XCentro1 = % XRef - 73
			XCentro2 = % XRef - 61
			
			YCentro1 = % YRef - 46 
			YCentro2 = % YRef - 34
			
			;msgbox, XRef=%XRef% YRef=%YRef%`nXCentro1=%XCentro1%, YCentro1=%YCentro1%`n XCentro2=%XCentro2%, YCentro2=%YCentro2%
			
			;MouseMove XCentro1, YCentro1
			;msgbox, %XCentro1%, %YCentro1%
			;MouseMove XCentro2, YCentro2
			;msgbox,  %XCentro2%, %YCentro2%
		} else {
			msgbox, imagem do cliente não encontrada
		}
		
		
		Cave:
		ControlSetText,, %Ponto%, ahk_id %myedit%
		
		ImageSearch, XBattle, YBattle, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *15, Imagens\BattleList.png	; 
				if (ErrorLevel = 0) {
						noBattleX =  % XBattle + 31
						1noBattleY = % YBattle + 79
						2noBattleY = % YBattle + 100
						3noBattleY = % YBattle + 122
						4noBattleY = % YBattle + 145
				} 
				;msgbox,  XBattle=%XBattle% YBattle=%YBattle%`nnoBattleX=%noBattleX%`n1noBattleY=%1noBattleY%`n2noBattleY=%2noBattleY%`n3noBattleY=%3noBattleY%`n4noBattleY=%4noBattleY%
				
					; 4 no battle
						LFColors := "0x00C000|0x60C060|0xC0C000|0xC03030|0xC00000|0x00C000|0x600000"
						Loop, Parse, LFColors, `|
						{	PixelSearch, X, Y, %noBattleX%, %4noBattleY%, %noBattleX%, %4noBattleY%, A_LoopField, 0, Fast, RGB
							If (ErrorLevel = 0) {
								MOBSBattle = 4
								goto outcheckbattle
							}
						}
					; 3 no battle
						Loop, Parse, LFColors, `|
						{	PixelSearch, X, Y, %noBattleX%, %3noBattleY%, %noBattleX%, %3noBattleY%, A_LoopField, 0, Fast, RGB
							If (ErrorLevel = 0) {
								MOBSBattle = 3
								goto outcheckbattle
							}
						}
					; 2 no battle
						Loop, Parse, LFColors, `|
						{	PixelSearch, X, Y, %noBattleX%, %2noBattleY%, %noBattleX%, %2noBattleY%, A_LoopField, 0, Fast, RGB
							If (ErrorLevel = 0) {
								MOBSBattle = 2
								goto outcheckbattle
							}
						}
					; 1 no battle
						Loop, Parse, LFColors, `|
						{	PixelSearch, X, Y, %noBattleX%, %1noBattleY%, %noBattleX%, %1noBattleY%, A_LoopField, 0, Fast, RGB
							If (ErrorLevel = 0) {
								MOBSBattle = 1
								goto outcheckbattle
							} else {
								MOBSBattle = 0
								GuiControlGet, Looter
								if ((Looter = 1) and (nextpoint = 0)) {
									nextpoint = 1
									tooltip looteando
									ControlSend,, {%Hotkey_QuickLoot%}, ahk_pid %Actual_PID% ;
									sleep 500
									tooltip
								} else {
									nextpoint = 1
								}
							}
						}
				outcheckbattle:
				
				GuiControlGet, LureMode
				GuiControlGet, QtdLure
				if ((LureMode = 1) and (MOBSBattle >= %QtdLure%)) {
					PararParaMatar = 1
					nextpoint = 0
					Ponto = Parando para matar lure
				} else {
					PararParaMatar = 0
				} 
				
				
				if ((LureMode = 0) and (MOBSBattle >= 1)) {
					PararParaMatar = 1
					nextpoint = 0
					Ponto = Parando para matar single
				} else {
					PararParaMatar = 0
				}
				
		GuiControlGet, CaveHunt
		
				;tooltip MOBSBattle=%MOBSBattle% QtdLure=%QtdLure%`nLureMode=%LureMode%`nCaveHunt=%CaveHunt%`nPararParaMatar=%PararParaMatar%`nCaveHunt=%CaveHunt% PararParaMatar=%PararParaMatar%`ni=%i% QtdSqms=%QtdSqms%`nnextpoint=%nextpoint%,300,0,1
		
		if ((CaveHunt = 1) and (PararParaMatar = 0)) {	
			
			MouseGetPos  MousePosX, MousePosY
			ImageSearch, Xclick, Yclick, %Xini%, %Yini%, %XRef%, %yRef%, *25, Imagens\%i%.png	; 
			if (ErrorLevel = 0) {
				MouseClick, left, %Xclick%, %Yclick%
				MouseMove MousePosX, MousePosY
			ImageSearch, xx, yy, %XCentro1%, %YCentro1%, %XCentro2%, %YCentro2%, *25, Imagens\%i%.png	; 
				sleep 500
				if (ErrorLevel = 1) {	
					goto Cave
				} else {
					if ((PararParaMatar = 0) or (nextpoint = 1)) {
						i++
					}
				}
			} else {
				if ((PararParaMatar = 0) or (nextpoint = 1)) {
						i++
				}
			}
				
		}
		
		GuiControlGet, QtdSqms
		
		if (i > QtdSqms) {
			Ponto = Done
			i = 1
		}
		if (PararParaMatar = 0){
			Ponto = caminhando para ponto %i%
		}
		
		
		return
		
HOME::
ExitApp
return

		
	;IniRead, CaveHunt, %EndConfigAtaque%.ini, Principal, CaveHunt
	;IniRead, nextpoint, %EndConfigAtaque%.ini, Principal, nextpoint
	
		
	;IniWrite, %Nome_Char%, %EndConfigAtaque%.ini, Principal, Nome_Char
	
	




GuiEscape:
GuiClose:
ExitSub:
ExitApp ; Terminate the script unconditionally

