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
IniRead, VersaoGrafico, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, VersaoGrafico
Load()
CorVidaSSA = %CorDaVida%
CorManaSSA = %CorDaMana%
CorVidaMIGHT = %CorDaVida%
CorManaMIGHT = %CorDaMana%
EquipandoSSA = 0

Settimer Load_Config, 1000
Settimer Start, 50


Start:
if (ForaPZ = 1) {
	;tooltip EquipandoSSA=%EquipandoSSA%`nSSA=%SSA%`nCorVidaSSA=%CorVidaSSA% CorManaSSA=%CorManaSSA%`nCorVidaMIGHT=%CorVidaMIGHT% CorManaMIGHT=%CorManaMIGHT%`nCorDaVida=%CorDaVida% CorDaMana=%CorDaMana%`nAtiva_TankMode=%Ativa_TankMode%, 0,0
	if (WinActive("ahk_class Qt5QWindowOwnDCIcon")) {
		if ((SSA == 1) or (Ativa_TankMode = 1)) {
			AutoSSA()
		}
		if ((MIGHT == 1) or (Ativa_TankMode = 1)) {	
			AutoMIGHT()
		}
		If (FOODHP == 1) {	
			AutoFOODHP()
		}
		If (FOODMP == 1) {	
			AutoFOODMP()
		}
	}	
}
return

;==================================================================================
AutoSSA() {
global
	if (Tank_Amulet = "SSA") {
		ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\SSA.png
			if (ErrorLevel = 1){
				SemTankAmulet = 1
					if (Ativa_TankMode = 1) {
						send {%SSA_Hotkey%} ;  Hotkey SSA
						EquipandoSSA = 1
						sleep %DelaySSAMIGHT%
						goto saidaSSA
					}
			}
			if (ErrorLevel = 0){
				SemTankAmulet = 0
			}
	}
	if (Tank_Amulet = "Leviathan") {
		ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\Leviathan.png
			if (ErrorLevel = 1){
				SemTankAmulet = 1
			}
			if (ErrorLevel = 0){
				SemTankAmulet = 0
			}
	}
	if (Tank_Amulet = "Sacred") {
		ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\Sacred.png
			if (ErrorLevel = 1){
				SemTankAmulet = 1
			}
			if (ErrorLevel = 0){
				SemTankAmulet = 0
			}
	}
	if (Tank_Amulet = "Shockwave") {
		ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\PrismaticAmulet.png ; Se estiver de Prismatic, vai puxar o outro
			if (ErrorLevel = 0){
				SemTankAmulet = 1
										goto PuxarTankAmulet
			}	
			if (ErrorLevel = 1){
				SemTankAmulet = 0
			}
		ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\lightningPendu.png ; Se estiver de lightning Pendulant, vai puxar o outro
			if (ErrorLevel = 0){
				SemTankAmulet = 1
										goto PuxarTankAmulet
			}	
			if (ErrorLevel = 1){
				SemTankAmulet = 0
			}	
		
		ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\NoAmulet.png		;Checa se esta sem amuleto
			if (ErrorLevel = 0){
				SemTankAmulet = 1
			}
	}


PuxarTankAmulet:
		PercentSSA = %  XInicioVida + ((lifewidth * SSA_Life) // 100)
		PixelGetColor, CorVidaSSA, %PercentSSA%, %YVida%, RGB
		if ((CorVidaSSA != CorDaVida) or (SSA_Life = 100)) {
			if (SemTankAmulet = 1){
				send {%SSA_Hotkey%} ;  Hotkey SSA
				EquipandoSSA = 1
					sleep %DelaySSAMIGHT%
				goto saidaSSA
			} 
		} else {
				EquipandoSSA = 0
		}
	if (SSA_Mana > 0) {
		PercentSSA1 = %  XInicioMana + ((manawidth * SSA_Mana) // 100)
		PixelGetColor, CorManaSSA, %PercentSSA1%, %YMana%, RGB
		if ((CorManaSSA != CorDaMana) or (SSA_Mana = 100)) {
			if (SemTankAmulet = 1){
				send {%SSA_Hotkey%} ;  Hotkey SSA
				EquipandoSSA = 1
					sleep %DelaySSAMIGHT%
			}	
		} else {
				EquipandoSSA = 0
		}
	}
saidaSSA:
} ;Fim SSA
;==================================================================================
AutoMIGHT() {
global
	NoRingEquip = 0
	MightEquip = 0
	
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\NoRing.png		;Checa se esta com MIGHT RING
	if (ErrorLevel = 0){
		NoRingEquip = 1
	}
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\Might.png
	if (ErrorLevel = 0){
		MightEquip = 1
	}
	if (ErrorLevel = 1){
		MightEquip = 0
			if ((Ativa_TankMode = 1) and (PuxandoEnergyRing = 0)) {
				send {%Might_Hotkey%} ;  Hotkey MIGHT RING
				EquipandoMight = 1
				sleep %DelaySSAMIGHT%
				goto saidamight
			} else {
				EquipandoMight = 0
			}
	}
	
		PercentMIGHT = %  XInicioVida + ((lifewidth * Might_Life) // 100)
		PixelGetColor, CorVidaMIGHT, %PercentMIGHT%, %YVida%, RGB ;
		if ((CorVidaMIGHT != CorDaVida) or (Might_Life = 100)) {
			if (((NoRingEquip = 1) or (ForcaMight = 1)) and (MightEquip = 0) and (PuxandoEnergyRing = 0)){
				send {%Might_Hotkey%} ;  Hotkey MIGHT RING
				EquipandoMight = 1
					sleep %DelaySSAMIGHT%
				goto saidamight
			}		
		} else {
			EquipandoMight = 0
		}

		PercentMIGHT1 = %  XInicioMana + ((manawidth * Might_Mana) // 100)
		PixelGetColor, CorManaMIGHT, %PercentMIGHT1%, %YMana%, RGB ;
		if ((CorManaMIGHT != CorDaMana) or (Might_Mana = 100)) {
			if (((NoRingEquip = 1) or (ForcaMight = 1)) and (MightEquip = 0) and (PuxandoEnergyRing = 0)){
				send {%Might_Hotkey%} ;  Hotkey MIGHT RING
				EquipandoMight = 1
					sleep %DelaySSAMIGHT%
			}
		} else {
			EquipandoMight = 0
		}

saidamight:
} ;Fim Might
;==================================================================================
AutoFOODHP() {
global
	CoordFOODHP = %  XInicioVida + ((lifewidth * PercentFOODHP) // 100)
	PixelGetColor, CorFOODHP, %CoordFOODHP%, %YVida%, RGB ;
		if (CorFOODHP != CorDaVida){ 
			send {%HotkeyFOODHP%} ; FOOD HP
				sleep 200
		}
} ; Fim Food HP
;==================================================================================
AutoFOODMP() {
global
	CoordFOODMP = %  XInicioMana + ((manawidth * PercentFOODMP) // 100)
	PixelGetColor, CorFOODMP, %CoordFOODMP%, %YMana%, RGB ; 
		if (CorFOODMP != CorDaMana){ 
			send {%HotkeyFOODMP%} ; FOOD MP
				sleep 200
		}
} ; Fim Food MP
;==================================================================================



Load_Config:
	Load()
return




Load() {
Global
IniRead, VersaoGrafico, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, VersaoGrafico
IniRead, DelayMacro, %EndConfigSuporte%.ini, Principal, DelayMacro

IniRead, DelaySSAMIGHT, %EndConfigSuporte%.ini, Principal, DelaySSAMIGHT

IniRead, Nome_Char, %EndConfigSuporte%.ini, Principal, Nome_Char
IniRead, Actual_PID, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Actual_PID

IniRead, ForaPZ, %EndConfigAtaque%.ini, Principal, ForaPZ
IniRead, Ativa_TankMode, %EndConfigAtaque%.ini, Principal, Ativa_TankMode

IniRead, PuxandoEnergyRing, %EndConfigSuporte%.ini, Principal, PuxandoEnergyRing

IniRead, SSA, %EndConfigSuporte%.ini, Principal, SSA
IniRead, MIGHT, %EndConfigSuporte%.ini, Principal, MIGHT
IniRead, ForcaMight, %EndConfigSuporte%.ini, Principal, ForcaMight
IniRead, FOODHP, %EndConfigSuporte%.ini, Principal, FOODHP
IniRead, FOODMP, %EndConfigSuporte%.ini, Principal, FOODMP

;[SSA]
IniRead, SSA_Hotkey, %EndConfigSuporte%.ini, Stone_Skin_Amulet, SSA_Hotkey
IniRead, SSA_Life, %EndConfigSuporte%.ini, Stone_Skin_Amulet, SSA_Life
IniRead, SSA_Mana, %EndConfigSuporte%.ini, Stone_Skin_Amulet, SSA_Mana
IniRead, Tank_Amulet, %EndConfigSuporte%.ini, Stone_Skin_Amulet, Tank_Amulet

;[MIGHT]
IniRead, Might_Hotkey, %EndConfigSuporte%.ini, Might_Ring, Might_Hotkey
IniRead, Might_Life, %EndConfigSuporte%.ini, Might_Ring, Might_Life
IniRead, Might_Mana, %EndConfigSuporte%.ini, Might_Ring, Might_Mana

;[FOODHP]
IniRead, HotkeyFOODHP, %EndConfigSuporte%.ini, FOODHP, HotkeyFOODHP
IniRead, PercentFOODHP, %EndConfigSuporte%.ini, FOODHP, PercentFOODHP

;[FOODMP]
IniRead, PREHotkeyFOODMP, %EndConfigSuporte%.ini, FOODMP, PREHotkeyFOODMP
IniRead, HotkeyFOODMP, %EndConfigSuporte%.ini, FOODMP, HotkeyFOODMP
IniRead, PercentFOODMP, %EndConfigSuporte%.ini, FOODMP, PercentFOODMP

IniWrite, %EquipandoSSA%, %EndConfigSuporte%.ini, Principal, EquipandoSSA
IniWrite, %EquipandoMight%, %EndConfigSuporte%.ini, Principal, EquipandoMight

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

