; =======================================================================================
; Name ..........: Primo Marcos
; Description ...: V14 - 11/03_2021
; Language ......: Portugues Brasil (PT-BR)
; Author ........: Away
	
;========================================================================================
;========================================================================================
;========================================================================================
IniRead, EndConfigAtaque, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, EndConfigAtaque



Cliente = 0
Cliente1 = 0
Cliente2 = 0
Cliente3 = 0
Cliente4 = 0
Cliente5 = 0

;Rotacao Magia
QuantidadeDeMagia1 = 0
QuantidadeDeMagia1Aux = 0
TurnoMagia1 = 1
TurnoMagia1Aux = 0

QuantidadeDeMagia2 = 0
QuantidadeDeMagia2Aux = 0
TurnoMagia2 = 1
TurnoMagia2Aux = 0

DelayAtaque = 100

global tool := 0

;========================================================================================
;========================================================================================






#SingleInstance, Force ; Allow only one running instance of script
#Persistent ; Keep script permanently running until terminated
;#NoEnv ; Avoid checking empty variables to see if they are environment variables
;#Warn ; Enable warnings to assist with detecting common errors
#NoTrayIcon ; Disable the tray icon of the script
SendMode, Input ; Recommended for new scripts due to its superior speed and reliability
SetWorkingDir, %A_ScriptDir% ; Change the working directory of the script
SetBatchLines, -1 ; Run script at maximum speed
OnExit, ExitSub ; Run a subroutine or function automatically when the script exits
GroupAdd, Primo, ahk_class Qt5QWindowOwnDCIcon
GroupAdd, Primo, ahk_class AutoHotkeyGUI
#IfWinActive, ahk_group Primo
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



Thread, interrupt, 0
Process, Priority,, Low
Thread, NoTimers, true



XTooltip = % A_ScreenWidth / 2
YTooltip = % A_ScreenHeight / 2

Load()

SetTimer, Load_Config, 1000
SetTimer, TargetFunc, 0
SetTimer, StartScripts, %DelayAtaque%

;=======================================================================================================================================================================================================================
;=======================================================================================================================================================================================================================
;=======================================================================================================================================================================================================================
;=========================================================================================SCIPTS========================================================================================================================
;=======================================================================================================================================================================================================================
;=======================================================================================================================================================================================================================
;=======================================================================================================================================================================================================================
TargetFunc:


IF (TipoTarget = "First Target") {
ImageSearch, XBattle, YBattle, 0, 0, A_ScreenWidth, A_ScreenHeight, *15, Imagens\BattleList.png	; 
	if (ErrorLevel = 1) {
	goto OutBattle
	}
	if (ErrorLevel = 0) {
	XBattle1 = % XBattle + 4	
	YBattle1 = % YBattle + 20	
	XNextTarget = % XBattle + 4
	YNextTarget = % YBattle + 61
	
	XNextTarget1 = % XBattle + 50
	YNextTarget1 = % YBattle + 63
	}
OutBattle:
	if ((Ativa_Atk = 1) and (ForaPZ = 1)) {
		if (WinActive("ahk_class Qt5QWindowOwnDCIcon")) {
			PixelGetColor, CorBattle, %XNextTarget%, %YNextTarget%, RGB ; 
				if (CorBattle != "0xFF0000"){ 
					MouseGetPos  MousePosX, MousePosY
					sleep 10
					MouseClick, left, %XBattle1%, %YBattle1%
						sleep 100
					MouseClick, left, %XNextTarget1%, %YNextTarget1%
					sleep 20
					MouseMove MousePosX, MousePosY
				}
		}
	}
}

if ((Ativa_Atk = 1) and (TipoTarget = "Next Target")) {
	if ((AtkRune1 == 0) or (AtkRune2 == 0) or (AtkRotacao1 == 0) or (AtkRotacao2 == 0)) {
		ControlSend,, {%Hotkey_Target%}, Tibia - %Nome_Char%
		Sleep %DelayNextTarget%
	}
}	
	
	

if (AtkRune1 == 1){
	DelayAtaque = %TimeDelay1%
} else if (AtkRune2 == 1){
	DelayAtaque = %TimeDelay2%
} else if (AtkRotacao1 == 1){
	DelayAtaque = %TimeDelay3%
} else if (AtkRotacao2 == 1){
	DelayAtaque = %TimeDelay4%
}



return






;=======================================================================================================================================================================================================================
;=========================================================================================Ataque========================================================================================================================
;=======================================================================================================================================================================================================================
StartScripts:
IniRead, EndConfigAtaque, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, EndConfigAtaque

if ((Ativa_Atk == 1) and (ForaPZ == 1)) {
	
	
;=========================Rune1=============================
		if (AtkRune1 == 1){
			ControlSend,, {%Rune1%}, Tibia - %Nome_Char%
			Sleep %TimeDelay1%
		}
;=========================Rune2=============================
		if (AtkRune2 == 1){
			ControlSend,, {%Rune2%}, Tibia - %Nome_Char%
			Sleep %TimeDelay2%
		}
;====================Rotação de Magia 1=====================
		if (AtkRotacao1 == 1){
			if (TurnoMagia1 == 1) {
				HK_Rotacao1 = %MagiaRotacao1_1%
			}
			if (TurnoMagia1 == 2) {
				HK_Rotacao1 = %MagiaRotacao1_2%
			}
			if (TurnoMagia1 == 3) {
				HK_Rotacao1 = %MagiaRotacao1_3%
			}
			if (TurnoMagia1 == 4) {
				HK_Rotacao1 = %MagiaRotacao1_4%
			}
			
			if (TurnoMagia1 <= QuantidadeDeMagia1) {
			ControlSend,, {%HK_Rotacao1%}, Tibia - %Nome_Char%
			TurnoMagia1Aux = %TurnoMagia1%
			TurnoMagia1 = % TurnoMagia1Aux + 1
			Sleep %TimeDelay3%
			}
		
		QuantidadeDeMagia1Aux = % QuantidadeDeMagia1 + 1

			if (TurnoMagia1 == QuantidadeDeMagia1Aux) {
				TurnoMagia1 = 1
			}
		}
		
		if (AtkRotacao1 == 0){
			TurnoMagia1 = 1
		}
		
;====================Rotação de Magia 2=====================
GuiControlGet, AtkRotacao2
		if (AtkRotacao2 == 1){
			if (TurnoMagia2 == 1) {
				HK_Rotacao2 = %MagiaRotacao2_1%
			}
			if (TurnoMagia2 == 2) {
				HK_Rotacao2 = %MagiaRotacao2_2%
			}
			if (TurnoMagia2 == 3) {
				HK_Rotacao2 = %MagiaRotacao2_3%
			}
			if (TurnoMagia2 == 4) {
				HK_Rotacao2 = %MagiaRotacao2_4%
			}
			
			if (TurnoMagia2 <= QuantidadeDeMagia2) {
			ControlSend,, {%HK_Rotacao2%}, Tibia - %Nome_Char%
			TurnoMagia2Aux = %TurnoMagia2%
			TurnoMagia2 = % TurnoMagia2Aux + 1
			Sleep %TimeDelay4%
			}
			
		QuantidadeDeMagia2Aux = % QuantidadeDeMagia2 + 1	
			
			if (TurnoMagia2 == QuantidadeDeMagia2Aux) {
				TurnoMagia2 = 1
			}
		}
		
		if (AtkRotacao2 == 0){
			TurnoMagia2 = 1
		}
		
	


}


return
;=======================================================================================================================================================================================================================
;==========================================================================================[[BUTTON LOAD CONFIG]========================================================================================================
;=======================================================================================================================================================================================================================
Load_Config:
	Load()
return


;=======================================================================================================================================================================================================================
;================================================================================================[Load]=================================================================================================================
;=======================================================================================================================================================================================================================
Load() {
Global


IniRead, Nome_Char, %EndConfigAtaque%.ini, Principal, Nome_Char
IniRead, Ativa_Atk, %EndConfigAtaque%.ini, Principal, Ativa_Atk
IniRead, ForaPZ, %EndConfigAtaque%.ini, Principal, ForaPZ
IniRead, DelayNextTarget, %EndConfigAtaque%.ini, Principal, DelayNextTarget



IniRead, Rune1, %EndConfigAtaque%.ini, AtkRune1, Rune1
IniRead, TimeDelay1, %EndConfigAtaque%.ini, AtkRune1, TimeDelay1
IniRead, Rune2, %EndConfigAtaque%.ini, AtkRune2, Rune2
IniRead, TimeDelay2, %EndConfigAtaque%.ini, AtkRune2, TimeDelay2
IniRead, QuantidadeDeMagia1, %EndConfigAtaque%.ini, AtkRotacao1, QuantidadeDeMagia1
IniRead, MagiaRotacao1_1, %EndConfigAtaque%.ini, AtkRotacao1, MagiaRotacao1_1
IniRead, MagiaRotacao1_2, %EndConfigAtaque%.ini, AtkRotacao1, MagiaRotacao1_2
IniRead, MagiaRotacao1_3, %EndConfigAtaque%.ini, AtkRotacao1, MagiaRotacao1_3
IniRead, MagiaRotacao1_4, %EndConfigAtaque%.ini, AtkRotacao1, MagiaRotacao1_4
IniRead, TimeDelay3, %EndConfigAtaque%.ini, AtkRotacao1, TimeDelay3
IniRead, QuantidadeDeMagia2, %EndConfigAtaque%.ini, AtkRotacao2, QuantidadeDeMagia2
IniRead, MagiaRotacao2_1, %EndConfigAtaque%.ini, AtkRotacao2, MagiaRotacao2_1
IniRead, MagiaRotacao2_2, %EndConfigAtaque%.ini, AtkRotacao2, MagiaRotacao2_2
IniRead, MagiaRotacao2_3, %EndConfigAtaque%.ini, AtkRotacao2, MagiaRotacao2_3
IniRead, MagiaRotacao2_4, %EndConfigAtaque%.ini, AtkRotacao2, MagiaRotacao2_4
IniRead, TimeDelay4, %EndConfigAtaque%.ini, AtkRotacao2, TimeDelay4


IniRead, Nome_Char_Atk, %EndConfigAtaque%.ini, Principal, Nome_Char_Atk 

IniRead, Hotkey_ATK, %EndConfigAtaque%.ini, Principal, Hotkey_ATK

IniRead, Target, %EndConfigAtaque%.ini, Principal, Target
IniRead, Hotkey_Target, %EndConfigAtaque%.ini, Principal, Hotkey_Target

IniRead, AtkRune1, %EndConfigAtaque%.ini, Principal, AtkRune1
IniRead, AtkRune2, %EndConfigAtaque%.ini, Principal, AtkRune2
IniRead, AtkRotacao1, %EndConfigAtaque%.ini, Principal, AtkRotacao1
IniRead, AtkRotacao2, %EndConfigAtaque%.ini, Principal, AtkRotacao2
IniRead, TipoTarget, %EndConfigAtaque%.ini, Principal, TipoTarget

}

;=======================================================================================================================================================================================================================
;===================================================================================================Menu Tray===========================================================================================================
;=======================================================================================================================================================================================================================




GuiEscape:
GuiClose:
ExitSub:
ExitApp ; Terminate the script unconditionally
