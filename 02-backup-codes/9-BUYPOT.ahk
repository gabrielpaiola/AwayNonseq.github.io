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
IniRead, VersaoGrafico, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, VersaoGrafico
IniRead, EndConfigSuporte, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, EndConfigSuporte
IniRead, EndConfigAtaque, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, EndConfigAtaque 

TimerManaTrain = 0
TimerExercise = 0
TimerBUYPOT = 0

IniRead, DelayMacro, %EndConfigSuporte%.ini, Principal, DelayMacro
IniRead, ManaTraining, %EndConfigSuporte%.ini, ManaTraining, ManaTraining
IniRead, Nome_Char, %EndConfigSuporte%.ini, Principal, Nome_Char

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



		WinGetActiveTitle, TelaAtiva
		MouseGetPos  MousePosX, MousePosY
		WinActivate, ahk_class Qt5QWindowOwnDCIcon
		
		ImageSearch, Xconfig, Yconfig, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *45, Imagens\%VersaoGrafico%\NPC\configs.png	; 
		buscarinicX = % Xconfig - 400
		buscarfimcX = % Xconfig + 200
		
		checkfecharagain:
		ImageSearch, fechaX, fechaY, %buscarinicX%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\NPC\fechar.png	; 
			if (ErrorLevel = 0) {
				MouseMove %fechaX%, %fechaY%
				sleep 10
				MouseClick, left, %fechaX%, %fechaY%
				sleep 300
				goto checkfecharagain
			}
		
		ImageSearch, ChatX, ChatY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\NPC\localchat.png	; 
		if (ErrorLevel = 0) {
				MouseMove %ChatX%, %ChatY%
				sleep 10
				MouseClick, left, %ChatX%, %ChatY%
		}
		ImageSearch, ChatX, ChatY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\NPC\localchat1.png	; 
		if (ErrorLevel = 0) {
				MouseMove %ChatX%, %ChatY%
				sleep 10
				MouseClick, left, %ChatX%, %ChatY%
		}
		ImageSearch, ChatX, ChatY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\NPC\localchat2.png	; 
		if (ErrorLevel = 0) {
				MouseMove %ChatX%, %ChatY%
				sleep 10
				MouseClick, left, %ChatX%, %ChatY%
		}
		
		checachatoff:
		ImageSearch, ChatX, ChatY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\NPC\chatoff.png	; 
		if (ErrorLevel = 0) {
				MouseMove %ChatX%, %ChatY%
				sleep 10
				MouseClick, left, %ChatX%, %ChatY%
				goto checachatoff
		}
		
		ControlSend,, hi{ENTER}, Tibia - %Nome_Char% ; ; 
			sleep 3000
		ControlSend,, trade{ENTER}, Tibia - %Nome_Char% ; 
			sleep 3000
		ControlSend,, potions{ENTER}, Tibia - %Nome_Char% ; 
			sleep 3000
			
		
		ImageSearch, potX, potY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\NPC\%POTTYPE%.png	; 
		if (ErrorLevel = 0) {
				MouseMove %potX%, %potY%
				sleep 10
				MouseClick, left, %potX%, %potY%
			sleep 600
			ImageSearch, qtdX, qtdY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\NPC\99qtd.png	; 
			if (ErrorLevel = 0) {
				MouseMove %qtdX%, %qtdY%
				sleep 10
				MouseClick, left, %qtdX%, %qtdY%
				sleep 600
				ImageSearch, OKx, OKy, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\NPC\OK.png	; 
				if (ErrorLevel = 0) {
					MouseMove %OKx%, %OKy%
					sleep 10
					if (QTDPOT = 100) {
						
						MouseClick, left, %OKx%, %OKy%
						
					} else if (QTDPOT = 200) {
						
						MouseClick, left, %OKx%, %OKy%
						sleep 1000
						MouseClick, left, %OKx%, %OKy%
						
					} else if (QTDPOT = 300) {
						
						MouseClick, left, %OKx%, %OKy%
						sleep 1000
						MouseClick, left, %OKx%, %OKy%
						sleep 1000
						MouseClick, left, %OKx%, %OKy%
						
					} else if (QTDPOT = 400) {
						
						MouseClick, left, %OKx%, %OKy%
						sleep 1000
						MouseClick, left, %OKx%, %OKy%
						sleep 1000
						MouseClick, left, %OKx%, %OKy%
						sleep 1000
						MouseClick, left, %OKx%, %OKy%
						
					} else if (QTDPOT = 500) {
						
						MouseClick, left, %OKx%, %OKy%
						sleep 1000
						MouseClick, left, %OKx%, %OKy%
						sleep 1000
						MouseClick, left, %OKx%, %OKy%
						sleep 1000
						MouseClick, left, %OKx%, %OKy%
						sleep 1000
						MouseClick, left, %OKx%, %OKy%
					}
					sleep 600
					ControlSend,, bye{ENTER}, Tibia - %Nome_Char% ;  
				}
			}
		}
		
		WinActivate, %TelaAtiva%
		WinActivate, %TelaAtiva%
		MouseMove MousePosX, MousePosY
	




GuiEscape:
GuiClose:
ExitSub:
ExitApp ; Terminate the script unconditionally

