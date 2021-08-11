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

EquipandoSSA = 0
EquipandoMight = 0
PuxandoEnergyRing = 0


Settimer Load_Config, 1000
Settimer Start, 50



Start:
	If (Energy_Ring == 1) {
		AutoSelfRing()
	}
return












AutoSelfRing() {
global
	PercentLifeEquip = %  XInicioVida + ((lifewidth * Percent_Life_Equip_Energy) // 100)
	PixelGetColor, CorLifeEquipe, %PercentLifeEquip%, %YVida%, RGB ; 
	
	PercentLifeDeEquip = %  XInicioVida + ((lifewidth * Percent_Life_DeEquip_Energy) // 100)
	PixelGetColor, CorLifeDeEquipe, %PercentLifeDeEquip%, %YVida%, RGB ;
	
	
	PercentManaMin = %  XInicioMana + ((manawidth * Percent_Mana_Equip_Energy) // 100)
	PixelGetColor, CorManaMinEquip, %PercentManaMin%, %YMana%, RGB ; 
	
	PercentManaDeEquip = %  XInicioMana + ((manawidth * Percent_Mana_DeEquip_Energy) // 100)
	PixelGetColor, CorManaDeEquip, %PercentManaDeEquip%, %YMana%, RGB ; 
	
	if (TipoMagicShield = "Utamo Vita") {
		if ((CorLifeDeEquipe == CorDaVida) or (CorManaDeEquip != CorDaMana)) {
			ImageSearch, FoundX, FoundY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\Utamo.png	; CHECA SE ESTA DE UTAMO
			if (ErrorLevel = 0) {
				ImageSearch, FirstStageX, FirstStageY, 0, 0, A_ScreenWidth, A_ScreenHeight, *15, Imagens\%VersaoGrafico%\ExanaVitaCD.png		;Checa se tem cool down do exana vita
				if (ErrorLevel = 0){	
					ControlSend,, {%Hotkey_DeEnergy_Ring%}, ahk_pid %Actual_PID%  ;
						sleep 300
				}			
			}
		}
		if ((CorLifeEquipe != CorDaVida) and (CorManaMinEquip == CorDaMana)) {
			ImageSearch, FoundX, FoundY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\Utamo.png	; CHECA SE ESTA DE UTAMO
			if (ErrorLevel = 1) {
				ImageSearch, FirstStageX, FirstStageY, 0, 0, A_ScreenWidth, A_ScreenHeight, *15, Imagens\%VersaoGrafico%\UtamoCD.png		;Checa se tem cool down de utamo vita
				if (ErrorLevel = 0) {	
					ControlSend,, {%Hotkey_Energy_Ring%}, ahk_pid %Actual_PID% 
						sleep 300
				}
			}
		}
	} 
	if (TipoMagicShield = "Energy Ring") {	
		if ((CorLifeDeEquipe == CorDaVida) or (CorManaDeEquip != CorDaMana)) {
			ImageSearch, FoundX, FoundY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\utamo_ring.png	; CHECA SE ESTA DE ENERGY RING
			if (ErrorLevel = 0) {
				ControlSend,, {%Hotkey_DeEnergy_Ring%}, ahk_pid %Actual_PID% 
					sleep 300
				PuxandoEnergyRing = 0
			}
		}
		if ((CorLifeEquipe != CorDaVida) and (CorManaMinEquip == CorDaMana)) {	
			ImageSearch, FoundX, FoundY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\utamo_ring.png	; CHECA SE ESTA DE ENERGY RING
			if (ErrorLevel = 1) {
				ControlSend,, {%Hotkey_Energy_Ring%}, ahk_pid %Actual_PID%  ; ENERGY RING
					sleep 300
				PuxandoEnergyRing = 1
			}
		}
	}	
} ; Fim Energy Ring Utamo
;==================================================================================

Load_Config:
	Load()
return

Load() {
Global
IniRead, VersaoGrafico, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, VersaoGrafico

IniRead, DelayMacro, %EndConfigSuporte%.ini, Principal, DelayMacro

IniRead, Nome_Char, %EndConfigSuporte%.ini, Principal, Nome_Char
IniRead, Actual_PID, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Actual_PID


;[Energy Ring]
IniRead, Percent_Life_Equip_Energy, %EndConfigSuporte%.ini, Energy_Ring, Percent_Life_Equip_Energy
IniRead, Percent_Mana_Equip_Energy, %EndConfigSuporte%.ini, Energy_Ring, Percent_Mana_Equip_Energy
IniRead, Percent_Life_DeEquip_Energy, %EndConfigSuporte%.ini, Energy_Ring, Percent_Life_DeEquip_Energy
IniRead, Percent_Mana_DeEquip_Energy, %EndConfigSuporte%.ini, Energy_Ring, Percent_Mana_DeEquip_Energy
IniRead, Hotkey_Energy_Ring, %EndConfigSuporte%.ini, Energy_Ring, Hotkey_Energy_Ring
IniRead, Hotkey_DeEnergy_Ring, %EndConfigSuporte%.ini, Energy_Ring, Hotkey_DeEnergy_Ring
IniRead, TipoMagicShield, %EndConfigSuporte%.ini, Energy_Ring, TipoMagicShield


IniRead, Energy_Ring, %EndConfigSuporte%.ini, Principal, Energy_Ring

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

IniWrite, %PuxandoEnergyRing%, %EndConfigSuporte%.ini, Principal, PuxandoEnergyRing

}

GuiEscape:
GuiClose:
ExitSub:
msgbox, fechou
ExitApp ; Terminate the script unconditionally

