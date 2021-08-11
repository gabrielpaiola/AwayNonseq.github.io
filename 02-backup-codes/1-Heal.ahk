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
IgnoreMana = 0

Settimer Load_Config, 1000
Settimer Start, 50



Start:
	If (Life_AutoHealing == 1) {
		AutoSelfHeal()
	}
	If ((Mana_AutoHealing == 1)) {
		AutoSelfMana()
	}

return

;==================================================================================
AutoSelfHeal() {
global
GuiControlGet, Percent_Life_Stage3
GuiControlGet, Percent_Life_Stage2
GuiControlGet, Percent_Life_Stage1
GuiControlGet, Hotkey_Life_Stage3
GuiControlGet, Hotkey_Life_Stage2
GuiControlGet, Hotkey_Life_Stage1

	PercentLife3 = %  XInicioVida + ((lifewidth * Percent_Life_Stage3) // 100)
	PixelGetColor, CorVidaStage3, %PercentLife3%, %YVida%, RGB ; Stage 3 Vida
	if (CorVidaStage3 != CorDaVida){ 
		ControlSend,, {%Hotkey_Life_Stage3%}, ahk_pid %Actual_PID% 
		sleep 100
		IgnoreMana = 1
		goto saidastage3
	} else {
		IgnoreMana = 0
	}

	PercentLife2 = %  XInicioVida + ((lifewidth * Percent_Life_Stage2) // 100)
	PixelGetColor, CorVidaStage2, %PercentLife2%, %YVida%, RGB ; Stage 2 Vida
	if (CorVidaStage2 != CorDaVida){ 
		ControlSend,, {%Hotkey_Life_Stage2%}, ahk_pid %Actual_PID% 
		sleep 100
	}
saidastage3:	
	PercentLife1 = %  XInicioVida + ((lifewidth * Percent_Life_Stage1) // 100)
	PixelGetColor, CorVidaStage1, %PercentLife1%, %YVida%, RGB ; Stage 1 Vida
	if (CorVidaStage1 != CorDaVida){ 
		ControlSend,, {%Hotkey_Life_Stage1%}, ahk_pid %Actual_PID% 
		sleep 100
	}
} ; Fim Self Heal
;==================================================================================
AutoSelfMana() {
global
GuiControlGet, Percent_Mana_Stage1
GuiControlGet, Percent_Mana_Stage2
GuiControlGet, Hotkey_Mana_Stage2
GuiControlGet, Hotkey_Mana_Stage1

	if (IgnoreMana = 0) {
		PercentMana2 = %  XInicioMana + ((lifewidth * Percent_Mana_Stage2) // 100)
		PixelGetColor, CorManaStage2, %PercentMana2%, %YMana%, RGB ; Stage 2 Vida
			if (CorManaStage2 != CorDaMana){ 
				Send {%Hotkey_Mana_Stage2%}  ; Stage 2 Mana food talvez
				sleep 200
			}
		PercentMana1 = %  XInicioMana + ((lifewidth * Percent_Mana_Stage1) // 100)
		PixelGetColor, CorManaStage1, %PercentMana1%, %YMana%, RGB ; Stage 1 Vida
			if (CorManaStage1 != CorDaMana){ 
				ControlSend,, {%Hotkey_Mana_Stage1%}, ahk_pid %Actual_PID%  ; POT MANA
				sleep 200
			}	
	}
} ; Fim Self Mana



Load_Config:
	Load()
return




Load() {
Global
IniRead, DelayMacro, %EndConfigSuporte%.ini, Principal, DelayMacro

IniRead, Nome_Char, %EndConfigSuporte%.ini, Principal, Nome_Char
IniRead, Actual_PID, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Actual_PID

;[LIFE]
IniRead, Percent_Life_Stage1, %EndConfigSuporte%.ini, AutoHeal, Percent_Life_Stage1
IniRead, Hotkey_Life_Stage1, %EndConfigSuporte%.ini, AutoHeal, Hotkey_Life_Stage1

IniRead, Percent_Life_Stage2, %EndConfigSuporte%.ini, AutoHeal, Percent_Life_Stage2
IniRead, Hotkey_Life_Stage2, %EndConfigSuporte%.ini, AutoHeal, Hotkey_Life_Stage2

IniRead, Percent_Life_Stage3, %EndConfigSuporte%.ini, AutoHeal, Percent_Life_Stage3
IniRead, Hotkey_Life_Stage3, %EndConfigSuporte%.ini, AutoHeal, Hotkey_Life_Stage3

;[Energy Ring]
IniRead, Percent_Life_Equip_Energy, %EndConfigSuporte%.ini, Energy_Ring, Percent_Life_Equip_Energy
IniRead, Percent_Mana_Equip_Energy, %EndConfigSuporte%.ini, Energy_Ring, Percent_Mana_Equip_Energy
IniRead, Percent_Life_DeEquip_Energy, %EndConfigSuporte%.ini, Energy_Ring, Percent_Life_DeEquip_Energy
IniRead, Percent_Mana_DeEquip_Energy, %EndConfigSuporte%.ini, Energy_Ring, Percent_Mana_DeEquip_Energy
IniRead, Hotkey_Energy_Ring, %EndConfigSuporte%.ini, Energy_Ring, Hotkey_Energy_Ring
IniRead, Hotkey_DeEnergy_Ring, %EndConfigSuporte%.ini, Energy_Ring, Hotkey_DeEnergy_Ring
IniRead, TipoMagicShield, %EndConfigSuporte%.ini, Energy_Ring, TipoMagicShield


;[MANA]
IniRead, Percent_Mana_Stage1, %EndConfigSuporte%.ini, ManaHeal, Percent_Mana_Stage1
IniRead, Hotkey_Mana_Stage1, %EndConfigSuporte%.ini, ManaHeal, Hotkey_Mana_Stage1
IniRead, Percent_Mana_Stage2, %EndConfigSuporte%.ini, ManaHeal, Percent_Mana_Stage2
IniRead, Hotkey_Mana_Stage2, %EndConfigSuporte%.ini, ManaHeal, Hotkey_Mana_Stage2





IniRead, Life_AutoHealing, %EndConfigSuporte%.ini, Principal, Life_AutoHealing
IniRead, Mana_AutoHealing, %EndConfigSuporte%.ini, Principal, Mana_AutoHealing

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

