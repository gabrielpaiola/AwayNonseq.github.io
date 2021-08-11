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


Settimer Load_Config, 1000
Settimer Start, 50


Start:

	if ((SIOEK = 1) or (SIORP = 1)) {
		AutoSIO()
	}
		
	if ((VidaSioOK = 1) and (ManaSioOK = 1)) {
		if (SIOEK = 1) {
			AutoSIOEK()
		}
		if (SIORP = 1) {
			AutoSIORP()
		}
	}
return


AutoSIO() {
global
	CoordSelfHealthSio = %  XInicioVida + ((lifewidth * PercentSelfHealth) // 100)
	PixelGetColor, CorSelfHealthSio, %CoordSelfHealthSio%, %YVida%, RGB ; Checa vida do ed para dar SIO
		if (CorSelfHealthSio != CorDaVida){ 
			VidaSioOK = 0
		}
		if (CorSelfHealthSio = CorDaVida){ 
			VidaSioOK = 1
		}
	
	CoordSelfManaSio = %  XInicioMana + ((lifewidth * PercentSelfMana) // 100)
	PixelGetColor, CorSelfManaSio, %CoordSelfManaSio%, %YMana%, RGB ; Checa mana do ed para dar SIO
		if (CorSelfManaSio != CorDaMana){ 
			ManaSioOK = 0
		}
		if (CorSelfManaSio = CorDaMana){ 
			ManaSioOK = 1
		}
} ; Fim Auto SIO
;==================================================================================
AutoSIOEK() {
global
	PixelSearch, Px, Py, %Xini_Char_tela_1%, %Yini_Char_tela_1%, %Xfim_Char_tela_1%, %Yfim_Char_tela_1%, 0xC0C0C0, 0, FAST RGB ; Confere char na tela
		if (ErrorLevel = 0){	
			PixelVidaParty2 = %  Xini_Life_PT1 + ((129 * PercentGranSIO1) // 100)
			PixelGetColor, CorVidaParty2, %PixelVidaParty2%, %Yref_Life_PT1%, RGB
			if ((CorVidaParty2 !="0x00C000") and (CorVidaParty2 !="0x60C060") and (CorVidaParty2 !="0xC0C000") and (CorVidaParty2 !="0xC03030") and (CorVidaParty2 !="0xC00000")){ 
					if (HealFriend1 = "SIO") {
						ControlSend,, {%Hotkey_GranSio_1%}, Tibia - %Nome_Char% ; Exura Gran Sio
							sleep 300
					}
				}
			PixelVidaParty1 = %  Xini_Life_PT1 + ((129 * PercentSIO1) // 100)
			PixelGetColor, CorVidaParty1, %PixelVidaParty1%, %Yref_Life_PT1%, RGB
				if ((CorVidaParty1 !="0x00C000") and (CorVidaParty1 !="0x60C060") and (CorVidaParty1 !="0xC0C000") and (CorVidaParty1 !="0xC03030") and (CorVidaParty1 !="0xC00000")){ 
					if (HealFriend1 = "SIO") {
						ControlSend,, {%Hotkey_Sio_1%}, Tibia - %Nome_Char% ; Exura Sio
							sleep 500
					}
					if (HealFriend1 = "UH") {
						MouseGetPos  MousePosX, MousePosY
						ControlSend,, {%Hotkey_Sio_1%}, Tibia - %Nome_Char% ; Hotkey que esta UH
							sleep 50
						MouseClick, left, %Xref_Life_PT1%, %Yref_Life_PT1%
							Sleep 50
						MouseMove MousePosX, MousePosY
					}
				}
		}
		;MouseMove %PixelVidaParty1%, %Yref_Life_PT1%
		;msgbox, Xini_Life_PT1=%Xini_Life_PT1% PercentGranSIO1=%PercentGranSIO1% PercentSIO1=%PercentSIO1% Yref_Life_PT1=%Yref_Life_PT1%
		;msgbox, CorVidaParty1=%CorVidaParty1% CorVidaParty2=%CorVidaParty2%
} ; Fim Sio EK
;==================================================================================
AutoSIORP() {
global
	PixelSearch, Px, Py, %Xini_Char_tela_3%, %Yini_Char_tela_3%, %Xfim_Char_tela_3%, %Yfim_Char_tela_3%, 0xC0C0C0, 0, FAST RGB ; Confere char na tela
		if (ErrorLevel = 0){	
			PixelVidaParty3 = %  Xini_Life_PT3 + ((129 * PercentSIO3) // 100)
			PixelGetColor, CorVidaParty3, %PixelVidaParty3%, %Yref_Life_PT3%, RGB
				if ((CorVidaParty3 !="0x00C000") and (CorVidaParty3 !="0x60C060") and (CorVidaParty3 !="0xC0C000") and (CorVidaParty3 !="0xC03030") and (CorVidaParty3 !="0xC00000")){ 
					if (HealFriend2 = "SIO") {
						ControlSend,, {%Hotkey_Sio_2%}, Tibia - %Nome_Char% ; Exura Sio
							sleep 500
					}
					if (HealFriend2 = "UH") {
						MouseGetPos  MousePosX, MousePosY
						ControlSend,, {%Hotkey_Sio_2%}, Tibia - %Nome_Char% ; Hotkey que esta UH
							sleep 50
						MouseClick, left, %Xref_Life_PT1%, %Yref_Life_PT3%
							Sleep 50
						MouseMove MousePosX, MousePosY
					}
				}
		}
} ; Fim Sio RP
;==================================================================================












Load_Config:
	Load()
return




Load() {
Global
IniRead, DelayMacro, %EndConfigSuporte%.ini, Principal, DelayMacro

IniRead, Nome_Char, %EndConfigSuporte%.ini, Principal, Nome_Char

IniRead, ForaPZ, %EndConfigAtaque%.ini, Principal, ForaPZ

IniRead, SIOEK, %EndConfigSuporte%.ini, Principal, SIOEK
IniRead, UHEK, %EndConfigSuporte%.ini, Principal, UHEK
IniRead, SIORP, %EndConfigSuporte%.ini, Principal, SIORP
IniRead, UHRP, %EndConfigSuporte%.ini, Principal, UHRP

IniRead, Xref_Life_PT1, %EndConfigSuporte%.ini, Coordenadas, Xref_Life_PT1
IniRead, Yref_Life_PT1, %EndConfigSuporte%.ini, Coordenadas, Yref_Life_PT1
IniRead, Xini_Life_PT1, %EndConfigSuporte%.ini, Coordenadas, Xini_Life_PT1
IniRead, Yini_Life_PT1, %EndConfigSuporte%.ini, Coordenadas, Yini_Life_PT1
IniRead, Xfim_Life_PT1, %EndConfigSuporte%.ini, Coordenadas, Xfim_Life_PT1
IniRead, Yfim_Life_PT1, %EndConfigSuporte%.ini, Coordenadas, Yfim_Life_PT1
IniRead, Xini_Char_tela_1, %EndConfigSuporte%.ini, Coordenadas, Xini_Char_tela_1
IniRead, Yini_Char_tela_1, %EndConfigSuporte%.ini, Coordenadas, Yini_Char_tela_1
IniRead, Xfim_Char_tela_1, %EndConfigSuporte%.ini, Coordenadas, Xfim_Char_tela_1
IniRead, Yfim_Char_tela_1, %EndConfigSuporte%.ini, Coordenadas, Yfim_Char_tela_1

IniRead, Yref_Life_PT3, %EndConfigSuporte%.ini, Coordenadas, Yref_Life_PT3
IniRead, Xini_Life_PT3, %EndConfigSuporte%.ini, Coordenadas, Xini_Life_PT3
IniRead, Yini_Life_PT3, %EndConfigSuporte%.ini, Coordenadas, Yini_Life_PT3
IniRead, Xfim_Life_PT3, %EndConfigSuporte%.ini, Coordenadas, Xfim_Life_PT3
IniRead, Yfim_Life_PT3, %EndConfigSuporte%.ini, Coordenadas, Yfim_Life_PT3
IniRead, Xini_Char_tela_3, %EndConfigSuporte%.ini, Coordenadas, Xini_Char_tela_3
IniRead, Yini_Char_tela_3, %EndConfigSuporte%.ini, Coordenadas, Yini_Char_tela_3
IniRead, Xfim_Char_tela_3, %EndConfigSuporte%.ini, Coordenadas, Xfim_Char_tela_3
IniRead, Yfim_Char_tela_3, %EndConfigSuporte%.ini, Coordenadas, Yfim_Char_tela_3

;[SIO]
IniRead, PercentSelfHealth, %EndConfigSuporte%.ini, EKSIO, PercentSelfHealth
IniRead, PercentSelfMana, %EndConfigSuporte%.ini, EKSIO, PercentSelfMana

;[SIO EK]
IniRead, Hotkey_SIO_1, %EndConfigSuporte%.ini, EKSIO, Hotkey_SIO_1
IniRead, Hotkey_GranSIO_1, %EndConfigSuporte%.ini, EKSIO, Hotkey_GranSIO_1
IniRead, HealFriend1, %EndConfigSuporte%.ini, EKSIO, HealFriend1
IniRead, PercentSIO1, %EndConfigSuporte%.ini, EKSIO, PercentSIO1
IniRead, PercentGranSIO1, %EndConfigSuporte%.ini, EKSIO, PercentGranSIO1

;[SIO RP]
IniRead, Hotkey_SIO_2, %EndConfigSuporte%.ini, RPSIO, Hotkey_SIO_2
IniRead, HealFriend2, %EndConfigSuporte%.ini, RPSIO, HealFriend2
IniRead, PercentSIO3, %EndConfigSuporte%.ini, RPSIO, PercentSIO3

IniRead, XInicioVida, %EndConfigSuporte%.ini, Coordenadas, XInicioVida
IniRead, lifewidth, %EndConfigSuporte%.ini, Coordenadas, lifewidth
IniRead, YVida, %EndConfigSuporte%.ini, Coordenadas, YVida

IniRead, XInicioMana, %EndConfigSuporte%.ini, Coordenadas, XInicioMana
IniRead, YInicioMana, %EndConfigSuporte%.ini, Coordenadas, YInicioMana
IniRead, manawidth, %EndConfigSuporte%.ini, Coordenadas, manawidth
IniRead, YMana, %EndConfigSuporte%.ini, Coordenadas, YMana

IniRead, CheckSetXini, %EndConfigSuporte%.ini, Coordenadas, CheckSetXini
IniRead, CheckSetYini, %EndConfigSuporte%.ini, Coordenadas, CheckSetYini
IniRead, CheckSetXfim, %EndConfigSuporte%.ini, Coordenadas, CheckSetXfim
IniRead, CheckSetYfim, %EndConfigSuporte%.ini, Coordenadas, CheckSetYfim
	
IniRead, CorDaVida, %EndConfigSuporte%.ini, Coordenadas, CorDaVida
IniRead, CorDaMana, %EndConfigSuporte%.ini, Coordenadas, CorDaMana
}

GuiEscape:
GuiClose:
ExitSub:
msgbox, fechou
ExitApp ; Terminate the script unconditionally

