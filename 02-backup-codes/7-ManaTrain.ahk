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
IniRead, EndConfigSuporte, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, EndConfigSuporte
IniRead, EndConfigAtaque, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, EndConfigAtaque 

TimerManaTrain = 0
TimerExercise = 0
TimerBUYPOT = 0

Settimer Load_Config, 1000
Settimer Start, 1000


Start:

if (ManaTraining == 1) {
	ManaTrain()
}

return



;================================================================================Mana Train
ManaTrain() {
global

if (TimerManaTrain >= TimeDelay) {
	TimerManaTrain = 1
} else {
	TimerManaTrain = % TimerManaTrain + 1
}

if (TimerExercise >= ExerciseDelay) {
	TimerExercise = 1
} else {
	TimerExercise = % TimerExercise + 1
}

if (TimerBUYPOT >= POTDELAY) {
	TimerBUYPOT = 1
} else {
	process, exist, BUYPOT.exe
		if errorlevel
			goto OUTbuypot1
		else
	TimerBUYPOT = % TimerBUYPOT + 1
}
OUTbuypot1:

if (((OpcaoTreino = "Magia") or (OpcaoTreino = "Magia e Exercise")) and (TimerManaTrain = 1)) {
	GetKeyState, state, Shift
	if (state = "D") {
		shift_state = 1
		;Send {Shift Up}
	} else {
		shift_state = 0
	}
	GetKeyState, state, CapsLock
	if (state = "D") {
		CapsLock_state = 1
		;Send {CapsLock Up}
	} else {
		CapsLock_state = 0
	}


	ControlSend,, {CapsLock Up}{Shift Up}{%HotkeyTrain1%}{%HotkeyTrain2%}{%HotkeyTrain3%}{%HotkeyTrain4%}{%HotkeyTrain5%}, ahk_pid %Actual_PID%
	
	
	if (shift_state = 1) {
		Send {Shift Down} 
	} 
	if (CapsLock_state = 1) {
		Send {CapsLock Down} 
	} 
		
}	


	if (((OpcaoTreino = "Exercise") or (OpcaoTreino = "Magia e Exercise")) and (GetPosDummyX != 0) and (GetPosDummyY != 0) and (TimerExercise = 1)){
			process, exist, BUYPOT.exe
		if errorlevel
			goto OUTbuypot2
		else
		ControlSend,, {%HotkeyTrain1%}, ahk_pid %Actual_PID% ; 
		ControlSend,, {%Hotkey_Exercise%}, ahk_pid %Actual_PID% ; 
		ControlSend,, {%Hotkey_Exercise%}, ahk_pid %Actual_PID% ; 
		ControlClick,  x%GetPosDummyX% y%GetPosDummyY% , ahk_pid %Actual_PID%,, LEFT,, Pos.
	}
OUTbuypot2:	
	
	
	
	
	
	IF ((BUYPOT = 1) and (TimerBUYPOT = 1)) {
	process, exist, BUYPOT.exe
		if errorlevel
			goto OUTbuypot
		else
		run, BUYPOT.exe
	}
OUTbuypot:	
	
} ;  Fim Mana Train










Load_Config:
	Load()
return




Load() {
Global
IniRead, DelayMacro, %EndConfigSuporte%.ini, Principal, DelayMacro
IniRead, ManaTraining, %EndConfigSuporte%.ini, ManaTraining, ManaTraining
IniRead, Nome_Char, %EndConfigSuporte%.ini, Principal, Nome_Char
IniRead, Actual_PID, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Actual_PID

IniRead, GetPosDummyX, %EndConfigSuporte%.ini, Principal, GetPosDummyX
IniRead, GetPosDummyY, %EndConfigSuporte%.ini, Principal, GetPosDummyY

;[ManaTraining]
IniRead, HotkeyTrain1, %EndConfigSuporte%.ini, ManaTraining, HotkeyTrain1
IniRead, HotkeyTrain2, %EndConfigSuporte%.ini, ManaTraining, HotkeyTrain2
IniRead, HotkeyTrain3, %EndConfigSuporte%.ini, ManaTraining, HotkeyTrain3
IniRead, HotkeyTrain4, %EndConfigSuporte%.ini, ManaTraining, HotkeyTrain4
IniRead, HotkeyTrain5, %EndConfigSuporte%.ini, ManaTraining, HotkeyTrain5
IniRead, TimeDelay, %EndConfigSuporte%.ini, ManaTraining, TimeDelay 

IniRead, Hotkey_Exercise, %EndConfigSuporte%.ini, Principal, Hotkey_Exercise
IniRead, ExerciseDelay, %EndConfigSuporte%.ini, Principal, ExerciseDelay
IniRead, POTDELAY, %EndConfigSuporte%.ini, Principal, POTDELAY
IniRead, POTTYPE, %EndConfigSuporte%.ini, Principal, POTTYPE
IniRead, QTDPOT, %EndConfigSuporte%.ini, Principal, QTDPOT


IniRead, OpcaoTreino, %EndConfigSuporte%.ini, ManaTraining, OpcaoTreino 
IniRead, BUYPOT, %EndConfigSuporte%.ini, ManaTraining, BUYPOT

IniRead, CheckSetXini, %EndConfigSuporte%.ini, Coordenadas, CheckSetXini
IniRead, CheckSetYini, %EndConfigSuporte%.ini, Coordenadas, CheckSetYini
IniRead, CheckSetXfim, %EndConfigSuporte%.ini, Coordenadas, CheckSetXfim
IniRead, CheckSetYfim, %EndConfigSuporte%.ini, Coordenadas, CheckSetYfim

IniRead, XTooltip, %EndConfigSuporte%.ini, Principal, XTooltip
IniRead, YTooltip, %EndConfigSuporte%.ini, Principal, YTooltip


IniWrite, %TimerManaTrain%, %EndConfigSuporte%.ini, ManaTraining, TimerManaTrain
IniWrite, %TimerExercise%, %EndConfigSuporte%.ini, ManaTraining, TimerExercise
IniWrite, %TimerBUYPOT%, %EndConfigSuporte%.ini, ManaTraining, TimerBUYPOT

IniRead, Tibia_X, %EndConfigSuporte%.ini, Principal, Tibia_X
IniRead, Tibia_Y, %EndConfigSuporte%.ini, Principal, Tibia_Y
IniRead, Tibia_Width, %EndConfigSuporte%.ini, Principal, Tibia_Width
IniRead, Tibia_Height, %EndConfigSuporte%.ini, Principal, Tibia_Height

}

GuiEscape:
GuiClose:
ExitSub:
Process, Close , BUYPOT.exe
msgbox, fechou
ExitApp ; Terminate the script unconditionally

