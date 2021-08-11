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
if (ForaPZ = 1) {
	if (WinActive("ahk_class Qt5QWindowOwnDCIcon")) {
		If (EAT == 1) {
			AutoEat()
		}
		If (Paralize == 1){
			AutoParalyze()
		}
		If (Haste == 1) {	
			AutoHaste()
		}
		If (Boots == 1) {		
			AutoBoots()
		}	
		if (UtamoVita == 1) {	
			AutoUtamo()
		}
		if ((Amulet == 1) and (EquipandoSSA = 0)) {	
			AutoAmulet()
		}
		if ((Ring == 1) and (EquipandoMight = 0) and (PuxandoEnergyRing = 0)) {
			AutoRing()
		}
		if (Quiver == 1) {
			AutoQuiver()
		}	
		if (PotBuff == 1) {	
			AutoBuff()
		}
	}
}
return

;==================================================================================
AutoEat() {
global
	ImageSearch,  FoundX, FoundY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *25, Imagens\%VersaoGrafico%\Fome.png		;Checa se esta com fome
		if (ErrorLevel = 0){
			send {%Hotkey_Eat%} ; Come food
			sleep 500
		}
} ; Auto Eat fim
;==================================================================================
AutoParalyze() {
global
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\Paralize.png		;Checa se esta paralizado 
		if (ErrorLevel = 0){
			if (RPUTITADO = 1){
			ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\Buff.png		;Checa se esta sem Buff
				if (ErrorLevel = 0){	
					goto fimparalyze
				}
			}
			send {%Hotkey_Paralize%} ; Auto Cure Paralize
		}	
fimparalyze:
} ; Fim Auto Paralyze
;==================================================================================
AutoHaste() {
global
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\Haste.png		;Checa se nao esta com haste
		if (ErrorLevel = 1){
			if (RPUTITADO = 1){
			ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\Buff.png		;Checa se esta sem Buff
				if (ErrorLevel = 0){	
					goto fimautohaste
				}
			}
			send {%Hotkey_Haste%} ; Auto Haste
		}
fimautohaste:
} ; Fim Auto Haste	
;==================================================================================
AutoBoots() {
global
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\NoBoots.png		;Checa se nao esta sem boots
		if (ErrorLevel = 0){
			if (WinActive("ahk_class Qt5QWindowOwnDCIcon")) {
				send {%Hotkey_Boots%} ; Auto Renew Boots
					sleep 700
			}
		}
} ; Fim Auto Boots
;==================================================================================
AutoUtamo() {
global

	if (TipoUtamo = "GLOBAL") {
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\Utamo.png		;Checa se esta de Utamo
		if (ErrorLevel = 0) {	
			goto LabelUtamoOut
		}
	ImageSearch, FirstStageX, FirstStageY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *15, Imagens\%VersaoGrafico%\UtamoCD.png	;Checa se tem cool down de utamo vita
		if (ErrorLevel = 1){	
			goto LabelPotUtamo
		}
			
	}

	if (TipoUtamo = "OT") {
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\utamo_ring.png		;Checa se esta de Utamo
		if (ErrorLevel = 0) {	
			goto LabelUtamoOut
		}
	}
					send {%Hotkey_Utamo%} ;  Hotkey Utamo Vita
						sleep 50
						
LabelPotUtamo:						
	if (WinActive("ahk_class Qt5QWindowOwnDCIcon")) {
		if ((ErrorLevel = 1) and (PotUtamoVita == 1)) {	
			send {%Hotkey_PotUtamo%}	
				sleep 200
		}
	}
	LabelUtamoOut:
} ; Fim Auto Utamo
;==================================================================================
AutoAmulet() {
global
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\NoAmulet.png		;Checa se esta sem amuleto
		if (ErrorLevel = 0){		
			send {%Amulet_Hotkey%} ;  Hotkey Amulet
				sleep 300
		}
} ; Fim Auto Amulet
;==================================================================================
AutoRing() {
global	
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\NoRing.png		;Checa se esta sem RING
		if (ErrorLevel = 0){		
			send {%Hotkey_Ring%} ;  Hotkey Ring
				sleep 300
		}
} ;  Fim Auto Ring
;==================================================================================
AutoQuiver() {
global	
	ImageSearch, QuiverX, QuiverY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *25, Imagens\%VersaoGrafico%\Quiver.png		;Checa se Quiver esta zerado
		if (ErrorLevel = 0){
			MouseGetPos  MousePosXPush, MousePosYPush
				SendEvent ^{Click %QuiverX% %QuiverY% Down}
				SendEvent ^{Click %XTooltip% %YTooltip% Up}
			MouseMove MousePosXPush, MousePosYPush
			goto quiverlabel
		}
	ImageSearch, QuiverX, QuiverY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *25, Imagens\%VersaoGrafico%\Red Quiver.png		;Checa se Quiver esta zerado
		if (ErrorLevel = 0){
			MouseGetPos  MousePosXPush, MousePosYPush
				SendEvent ^{Click %QuiverX% %QuiverY% Down}
				SendEvent ^{Click %XTooltip% %YTooltip% Up}
			MouseMove MousePosXPush, MousePosYPush
			goto quiverlabel
		}
	ImageSearch, QuiverX, QuiverY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *25, Imagens\%VersaoGrafico%\Blue Quiver.png		;Checa se Quiver esta zerado
		if (ErrorLevel = 0){
			MouseGetPos  MousePosXPush, MousePosYPush
				SendEvent ^{Click %QuiverX% %QuiverY% Down}
				SendEvent ^{Click %XTooltip% %YTooltip% Up}
			MouseMove MousePosXPush, MousePosYPush
			goto quiverlabel
		}		
	quiverlabel:
	ImageSearch, QuiverX, QuiverY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *25, Imagens\%VersaoGrafico%\ShieldVazio.png		;Checa se Quiver esta zerado
		if (ErrorLevel = 0){
			send {%Hotkey_Quiver%} ;  Hotkey Quiver
			sleep 500
		}
} ;  Fim Auto Quiver
;==================================================================================
AutoBuff() {
global	
GuiControlGet, Hotkey_PotBuff
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Imagens\%VersaoGrafico%\Buff.png		;Checa se esta sem Buff
		if (ErrorLevel = 1){		
			Send {%Hotkey_PotBuff%} ;  Hotkey Buff
				sleep 500
		}
} ; Fim Auto Buff
















Load_Config:
	Load()
return




Load() {
Global
IniRead, VersaoGrafico, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, VersaoGrafico

IniRead, DelayMacro, %EndConfigSuporte%.ini, Principal, DelayMacro

IniRead, Nome_Char, %EndConfigSuporte%.ini, Principal, Nome_Char
IniRead, Actual_PID, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Actual_PID

IniRead, ForaPZ, %EndConfigAtaque%.ini, Principal, ForaPZ

IniRead, EquipandoSSA, %EndConfigSuporte%.ini, Principal, EquipandoSSA
IniRead, EquipandoMight, %EndConfigSuporte%.ini, Principal, EquipandoMight
IniRead, PuxandoEnergyRing, %EndConfigSuporte%.ini, Principal, PuxandoEnergyRing

IniRead, EAT, %EndConfigSuporte%.ini, Principal, EAT
IniRead, PotBuff, %EndConfigSuporte%.ini, Principal, PotBuff
IniRead, Haste, %EndConfigSuporte%.ini, Principal, Haste
IniRead, Boots, %EndConfigSuporte%.ini, Principal, Boots
IniRead, Paralize, %EndConfigSuporte%.ini, Principal, Paralize
IniRead, Amulet, %EndConfigSuporte%.ini, Principal, Amulet
IniRead, Ring, %EndConfigSuporte%.ini, Principal, Ring
IniRead, UtamoVita, %EndConfigSuporte%.ini, Principal, UtamoVita
IniRead, PotUtamoVita, %EndConfigSuporte%.ini, Principal, PotUtamoVita
IniRead, Quiver, %EndConfigSuporte%.ini, Principal, Quiver


;[Quiver]
IniRead, Hotkey_Quiver, %EndConfigSuporte%.ini, Principal, Hotkey_Quiver

;[EatFood]
IniRead, Hotkey_Eat, %EndConfigSuporte%.ini, EAT, Hotkey_Eat

;[Haste]
IniRead, Hotkey_Haste, %EndConfigSuporte%.ini, Haste, Hotkey_Haste
IniRead, RPUTITADO, %EndConfigSuporte%.ini, Principal, RPUTITADO

;[BUFF]
IniRead, Hotkey_PotBuff, %EndConfigSuporte%.ini, Buff, Hotkey_PotBuff

;[Renew Boots]
IniRead, Hotkey_Boots, %EndConfigSuporte%.ini, AutoBoots, Hotkey_Boots

;[paralize]
IniRead, Hotkey_Paralize, %EndConfigSuporte%.ini, Paralize, Hotkey_Paralize

;[UtamoVita]
IniRead, Hotkey_Utamo, %EndConfigSuporte%.ini, UtamoVita, Hotkey_Utamo
IniRead, Hotkey_PotUtamo, %EndConfigSuporte%.ini, UtamoVita, Hotkey_PotUtamo

;[Amulet]
IniRead, Amulet_Hotkey, %EndConfigSuporte%.ini, Amulet, Amulet_Hotkey

;[Ring]
IniRead, Hotkey_Ring, %EndConfigSuporte%.ini, Ring, Hotkey_Ring

IniRead, CheckSetXini, %EndConfigSuporte%.ini, Coordenadas, CheckSetXini
IniRead, CheckSetYini, %EndConfigSuporte%.ini, Coordenadas, CheckSetYini
IniRead, CheckSetXfim, %EndConfigSuporte%.ini, Coordenadas, CheckSetXfim
IniRead, CheckSetYfim, %EndConfigSuporte%.ini, Coordenadas, CheckSetYfim

IniRead, XTooltip, %EndConfigSuporte%.ini, Principal, XTooltip
IniRead, YTooltip, %EndConfigSuporte%.ini, Principal, YTooltip
IniRead, TipoUtamo, %EndConfigSuporte%.ini, Principal, TipoUtamo

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

