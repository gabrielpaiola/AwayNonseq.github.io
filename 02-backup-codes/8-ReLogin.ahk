; =======================================================================================
; Name ..........: Primo Marcos
; Description ...: V3 - 18/05_2021
; Language ......: Portugues Brasil (PT-BR)
; Author ........: Away
; =======================================================================================
#Persistent
#SingleInstance, Force
#NoTrayIcon ; Disable the tray icon of the script
;#NoEnv
;#Warn
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

Load()

Settimer Load_Config, 1000
Settimer Start, 0

Start:
MouseGetPos  MousePosXPush, MousePosYPush
;tooltip tentando logar VersaoGrafico=%VersaoGrafico%`n Tibia_X=%Tibia_X% Tibia_Y=%Tibia_Y%`n Tibia_Width=%Tibia_Width% Tibia_Height=%Tibia_Height%`nEndConfigSuporte=%EndConfigSuporte%
if (WinActive("ahk_class Qt5QWindowOwnDCIcon")) {
		ImageSearch, FoundPassX, FoundPassY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\Login\Password.png
		if (ErrorLevel = 0) {
			;tooltip ENCONTROU PASSWORD
			EmailX = % FoundPassX + 78
			EmailY = % FoundPassY - 28
			Send {Click, %EmailX%, %EmailY%} 
			Send {Click, %EmailX%, %EmailY%} 
			Send {Click, %EmailX%, %EmailY%} 
			send {Delete}
			send %Account%
			
			PassX = % FoundPassX + 78
			PassY = % FoundPassY + 4
			Send {Click, %PassX%, %PassY%} 
			Send {Click, %PassX%, %PassY%} 
			Send {Click, %PassX%, %PassY%} 
			send {Delete}
			send %Password%
			
			
			
			ImageSearch, LoginX, LoginY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\Login\Login.png
			if (ErrorLevel = 0) {
				Send {Click, %LoginX%, %LoginY%} 
			}
		}
				
		ImageSearch, FoundX, FoundY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\Login\ConnectionLost.png	; 
		if (ErrorLevel = 0) {
			ImageSearch, OK1x, OK1y, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\Login\OK1.png	; 
			if (ErrorLevel = 0) {
				Send {Click, %OK1x%, %OK1y%} 
			}
		}
		
		ImageSearch, FoundX, FoundY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\Login\ConnectionLost2.png	; 
		if (ErrorLevel = 0) {
			ImageSearch, OK1x, OK1y, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\Login\OK1.2.png	; 
			if (ErrorLevel = 0) {
				Send {Click, %OK1x%, %OK1y%} 
			}
		}
			
		ImageSearch, FoundX, FoundY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\Login\SelectCharacter.png	;
		if (ErrorLevel = 0) {
			Send {Enter} 
			ImageSearch, OK2x, OK2y, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\Login\OK2.png	; 
			if (ErrorLevel = 0) {
				Send {Click, %OK2x%, %OK2y%} 
			}	
		}
		
		ImageSearch, FoundX, FoundY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\Login\SelectCharacter2.png	;
		if (ErrorLevel = 0) {
			Send {Enter} 
			ImageSearch, OK21x, OK21y, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\Login\OK21.png	; 
			if (ErrorLevel = 0) {
				Send {Click, %OK21x%, %OK21y%}
			}	
		}
		
		ImageSearch, FoundX, FoundY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\Login\ErroVM.png	;
		if (ErrorLevel = 0) {
			ImageSearch, OK3x, OK3y, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\Login\OK3.png	;
			if (ErrorLevel = 0) {
				Send {Click, %OK3x%, %OK3y%} 
			}	
		}
		
		
		ImageSearch, FoundX, FoundY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\Login\svoff.png	; 
		if (ErrorLevel = 0) {
			ImageSearch, OK0x, OK0y, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\Login\oksvoff.png	; 
			if (ErrorLevel = 0) {
				Send {Click, %OK0x%, %OK0y%} 
			}
		}
		
		ImageSearch, FoundX, FoundY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\Login\wrongpassword.png	; 
		if (ErrorLevel = 0) {
			ImageSearch, OK4x, OK4y, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\Login\wrongpasswordOK.png	; 
			if (ErrorLevel = 0) {
				Send {Click, %OK4x%, %OK4y%} 
			}
		}
		
		ImageSearch, FoundX, FoundY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\Login\sorryerrologin.png	; 
		if (ErrorLevel = 0) {
			ImageSearch, OK5x, OK5y, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *25, Imagens\%VersaoGrafico%\Login\oksorry.png	; 
			if (ErrorLevel = 0) {
				Send {Click, %OK5x%, %OK5y%} 
			}
		}
	MouseMove MousePosXPush, MousePosYPush
	sleep 3000
}
return





Load_Config:
	Load()
return




Load() {
Global
IniRead, VersaoGrafico, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, VersaoGrafico
IniRead, Actual_PID, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Actual_PID
IniRead, Account, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Account
IniRead, Password, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Password

IniRead, Tibia_X, %EndConfigSuporte%.ini, Principal, Tibia_X
IniRead, Tibia_Y, %EndConfigSuporte%.ini, Principal, Tibia_Y
IniRead, Tibia_Width, %EndConfigSuporte%.ini, Principal, Tibia_Width
IniRead, Tibia_Height, %EndConfigSuporte%.ini, Principal, Tibia_Height
}

GuiEscape:
GuiClose:
ExitSub:
msgbox, fechou
ExitApp ; Terminate the script unconditionally

