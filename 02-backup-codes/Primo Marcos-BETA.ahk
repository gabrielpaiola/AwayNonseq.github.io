; =======================================================================================
; Name ..........: Primo Marcos
; Description ...: V3 - 18/05_2021
; Language ......: Portugues Brasil (PT-BR)
; Author ........: Away
; =======================================================================================
#SingleInstance, Force
;#NoEnv
;#Warn
#NoTrayIcon ; Disable the tray icon of the script
SendMode, Input
SetWorkingDir, %A_ScriptDir%
SetBatchLines, -1
OnExit, ExitSub
GroupAdd, Primo, ahk_class Qt5QWindowOwnDCIcon
GroupAdd, Primo, ahk_class AutoHotkeyGUI
GroupAdd, Primo, ahk_exe client.exe
GroupAdd, Tibia, ahk_exe client.exe
GroupAdd, Tibia, ahk_class Qt5QWindowOwnDCIcon
GroupAdd, Tibia, ahk_exe taleon.exe
GroupAdd, OBSFullScreen, Projetor em tela inteira
GroupAdd, OBSFullScreen, Fullscreen Projector
WinActivate, Windowed Projector
WinActivate, Projetor em janela
WinActivate, Projetor em tela inteira
WinActivate, Fullscreen Projector
WinActivate, ahk_class Qt5QWindowOwnDCIcon
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
PID := DllCall("GetCurrentProcessId")
;Process, Priority, %PID%, Realtime
Process, Priority,, Low
Thread, interrupt, 0
Thread, NoTimers, true

if (A_ScriptName == "Primo Marcos-BETA.exe") {
	Process, Close , Primo Marcos.exe
} else if (A_ScriptName == "Primo Marcos.exe") {
	Process, Close , Primo Marcos-BETA.exe
}



;==================================================================================
;================================================================================== Valores Iniciais
;==================================================================================
baseurl = https://primomarcos.com

URLUser = %baseurl%/users.php?user=
URLData = %baseurl%/date.php
URLVersion = %baseurl%/infos.php

Address = C:\PrimoConfigs\gsdfa.ini
CheckFile = C:\PrimoConfigs\windowscheck.ini

UUID()
{
	For obj in ComObjGet("winmgmts:{impersonationLevel=impersonate}!\\" . A_ComputerName . "\root\cimv2").ExecQuery("Select * From Win32_ComputerSystemProduct")
		return obj.UUID	; http://msdn.microsoft.com/en-us/library/aa394105%28v=vs.85%29.aspx
}

if !FileExist("C:\PrimoConfigs"){
	FileCreateDir, C:\PrimoConfigs
	FileCreateDir, C:\PrimoConfigs\Padrao
		CONTEUDO_Geral=[Principal]`nEndConfigSuporte=`nEndConfigAtaque =`nUser=`nNick_Tibia =
		FileAppend, %CONTEUDO_Geral%, C:\PrimoConfigs\Padrao\ConfigGeral.ini	
}
	
;==================================================================================
;================================================================================== Inicio
;==================================================================================

ValoresIniciais()


;==================================================================================
;================================================================================== Checa se abriu pelo Launcher
;==================================================================================

if !FileExist("C:\PrimoConfigs\windowscheck.ini"){
		Gui, -AlwaysOnTop
		msgbox, ABRA DIRETO PELO LAUNCHER!!!!!!!
		ExitApp
} else {
	FileDelete, C:\PrimoConfigs\windowscheck.ini
}
;==================================================================================
;================================================================================== GUI LOGIN
;==================================================================================

GuiLogin() {
Global

IniRead, User, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, User
IniRead, Nick_Tibia, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Nick_Tibia
IniRead, VersaoPrimo1, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, VersaoPrimo1
	
		Static GUICreate := GuiLogin()
		GUIWidth := 262, GUIHeight := 142
		
Menu, Tray, Icon, 																Complementos\ICONS\Skull.ico
Menu, Tray, Tip, 																Primo Marcos Login
Menu, Tray, Add, 																Reload, Reload

Gui, +AlwaysOnTop ; FUNCAO ATIVA, DEIXA MACRO SEMPRE NA FRENTE DA TELA
Gui, +LastFound -Theme
Gui, Color, 																	202124 
Gui, Font, 																		cFFFFFF
Gui, Margin, 																	10, 10

Gui, Add, Text, x22 y35 h20,													Nick do Char:
Gui, Add, Edit, x22 y50 w120 h20 cBlack 										vNick_Tibia, %Nick_Tibia%
Gui, Add, Text, x22 y80 h20, 													Usuario:
Gui, Add, Edit, x22 y100 w120 h20 cBlack 		 								vUser, %User%
Gui, Font, 																		cWhite
		;Gui, Add, Button, x152 y80 w70 h20 												Chars, Check
	if FileExist("C:\PrimoConfigs\reload.ini"){
		Gui, Add, Button, x152 y50 w70 h70												gLogin, Login
		Gui, Show, % " w" GUIWidth " h" GUIHeight, Primo Login
	} ELSE {
		;Gui, Add, Text, x7 y15 h20,													Login Automatico - Aguarde
	}
;Gui, Show, % " w" GUIWidth " h" GUIHeight, Primo Login
}


if !FileExist("C:\PrimoConfigs\reload.ini"){
		goto Login
} 

return

;==================================================================================
Login:

if FileExist("C:\PrimoConfigs\reload.ini"){
	GuiControlGet Nick_Tibia
	GuiControlGet User
	IniWrite, %User%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, User
	IniWrite, %Nick_Tibia%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Nick_Tibia
	FileDelete, C:\PrimoConfigs\reload.ini
}

EndConfigSuporte = C:\PrimoConfigs\ConfigSuporte%Nick_Tibia%
EndConfigAtaque = C:\PrimoConfigs\ConfigAtaque%Nick_Tibia%

	ZeraValoresDownload()
	CheckDate()
	
	;if (URL_ID = "ID_NAME") {
		UUID1 = % UUID() A_ComputerName
	;} else {
	;	UUID1 = % UUID() 
	;}

If (((UUID_File == UUID1) or (UUID_File1 == UUID1) or (UUID_File2 == UUID1)) and (Data_Hoje<=Date_until)) {

		if FileExist(EndConfigSuporte ".ini"){
			Load()
			sleep 300
		}
		gui, destroy
		GuiMain()
		
WinGetPos, Tibia_X, Tibia_Y, Tibia_Width1, Tibia_Height1, Tibia - %Nome_Char%
Tibia_Width = % Tibia_Width1 + Tibia_X
Tibia_Height = % Tibia_Height1 + Tibia_Y
XTooltip = % Tibia_Width / 2
YTooltip = % Tibia_Height / 2

		
		if (VersaoPrimo1 = "ScriptUnico") {
			Settimer StartGeral, 200
			Settimer Save_Config, 5000
		} else {
			Settimer StartGeral, 1000	
			Settimer Save_Config, 1000
		}
		
		
		Settimer EnviaNumGui, 3000
		Settimer Save_Config_Ataque, 2000
		Settimer CheckValidade, 3600000
		Settimer Scriptsrapidos, 100
		
} else { ; DATA e login OK
	ExitApp
}
return

;==================================================================================
;================================================================================== GUI Geral
;==================================================================================
GUIMain() {
	Global

;==================================================================================
Nome_Char = %Nick_Tibia%

;==================================================================================


	GUIWidth := 690, GUIHeight := 610
	
	;Menu, Tray, Icon, Complementos\ICONS\PrimoMarcos.png    ;Change the tray icon
	Menu, Tray, Tip, Primo Marcos ; Change the tooltip of the tray icon
	Menu, Tray, Add, Reload, Reload

	
	Gui, +AlwaysOnTop ; FUNCAO ATIVA, DEIXA MACRO SEMPRE NA FRENTE DA TELA
	Gui, +LastFound -Resize +Theme
	Gui, Color, 202124 ;202124 ;b2b2b2 ;FFFFFF
	Gui, Font, cFFFFFF
	Gui, Margin, 10, 10
	
	Gui, Add, Button, 		x560	y5 	w80 	h15 		gExitSub, EXIT

	Gui, add, Text, 		x540	y30						 	,%Nick_Tibia%
	Gui, Add, edit,			x540	y50	w120	h40	ReadOnly	hwndScriptPausado, ScriptPausado
	Gui, Add, Button, 		x560	y95 	w80 	h15 		gLoad_Images, Reload Images

	;Gui, add, text,			x440	y120					,Tank Mode Hotkey
	;Gui, Add, Hotkey, 		x440	y136 	w85					vHabilita_TankMode, %Habilita_TankMode%	
	
	Gui, Add, edit,			x540	y160 	w110	ReadOnly 	hwndStatusTank, StatusTank
	Gui, Add, edit,			x540	y185	w110	ReadOnly 	hwndStatusAtaque, StatusAtaque
	Gui, Add, edit,			x540	y210	w110	ReadOnly 	hwndStatusLooter, StatusLooter
	
	Gui, Add, CheckBox, 	x540	y235 				 		vQuickLooter, Quick Loot

	Gui, Add, text, 		x540	y270		w70				,Mouse Option
	Gui, Add, DropDownList, x540	y290	w85		cBlack		vMouseGetPosOption, Left Mouse|Right Mouse|Middle Mouse|Alt|%MouseGetPosOption%||

	Gui, Add, text, 		x540	y340		w70				,Pause Hotkey
	Gui, Add, Hotkey, 		x540	y360		w70				vHotkey_Pause, %Hotkey_Pause%
	
	if (VersaoPrimo1 = "ScriptUnico") {
	Gui, Add, text, 		x540	y385						,Ciclo do Macro (ms)
	Gui, add, Edit, 		x540	y400	cFF0000	w70			vDelayMacro, %DelayMacro%	
	}	

	Gui, Add, Button, 		x560 	y435 	w80	H15				gReload, Reload Macro
	
	Gui, Add, edit,			x535	y457	w150 h40	ReadOnly	 	hwndmyedit, myedit
	
	
	
	Gui, Add, CheckBox, 	x535	y500 				 		vManterTelaAtiva, ManterTelaAtiva
	Gui, Add, CheckBox, 	x535	y520 				 		vHUD, HUD
	Gui, Add, Button, 		x535 	y540 	w80	H30				gCoordinates_HUD, Set Coordinates
	
	
	Gui, Add, text, 		x540	y580						,%VersaoPrimo1%
	
	
Gui,Add,Tab3,x1 y5 w530 h600 ,Self Heal||Support|Defender|Sio|Ataque|Uteis|PVP|Looter|Oberon|Help   ;create a tab control

;===============================================================================================
Gui,Tab,Self Heal   ; enter tab 1=============================================================== HEALING
;===============================================================================================	


	Gui, add, text,			x425	y64							,Hotkeys

Intervalo = 25

	;================================= [LIFE AUTO HEALING] ;=================================
	Gui, Add, GroupBox, 	x5 		y29 	w520 	h125		,Auto Self Heal
	Gui, Add, CheckBox, 	x7 		y52 		 	h20 		vLife_AutoHealing, [HEALTH]
	;=================================STAGE1
	Gui, Add, Slider, 		x7		y80				h20			vPercent_Life_Stage1 Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %Percent_Life_Stage1%
	Gui, Add, text, 		x130	y80		w120				,Light Life Heal
	;Gui, Add, DropDownList, x370	y80		w50					vSpecialKey_LifeStage1 ,None|Shift|Ctrl|%SpecialKey_LifeStage1%||
	Gui, Add, Hotkey, 		x425	y80		w45					vHotkey_Life_Stage1, %Hotkey_Life_Stage1%
	;=================================STAGE2
	Gui, Add, Slider, 		x7		y100			h20			vPercent_Life_Stage2 Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %Percent_Life_Stage2%
	Gui, Add, text, 		x130	y100	w120				,Medium Life Heal
	;Gui, Add, DropDownList, x370	y100		w50				vSpecialKey_LifeStage2 ,None|Shift|Ctrl|%SpecialKey_LifeStage3%||
	Gui, Add, Hotkey, 		x425	y100	w45					vHotkey_Life_Stage2, %Hotkey_Life_Stage2%
	;=================================STAGE3
	Gui, Add, Slider, 		x7		y120			h20			vPercent_Life_Stage3 Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %Percent_Life_Stage3%
	Gui, Add, text, 		x130	y120	w120				,Heavy Life Heal (+ ignore mana)
	;Gui, Add, DropDownList, x370	y120		w50				vSpecialKey_LifeStage3 , None|Shift|Ctrl|%SpecialKey_LifeStage3%||
	Gui, Add, Hotkey, 		x425	y120	w45					vHotkey_Life_Stage3, %Hotkey_Life_Stage3%
	
	;================================= [MANA AUTO HEALING] ;=================================
	Gui, Add, GroupBox, 	x5 		y155 	w520 	h95			,Auto Self Mana
	Gui, Add, CheckBox,		x7		y175			h20 		vMana_AutoHealing, [MANA]
	;=================================STAGE1
	Gui, Add, Slider, 		x7		y198			h20			vPercent_Mana_Stage1 Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %Percent_Mana_Stage1%
	Gui, Add, text, 		x130	y198	w120				,Medium Mana Heal
	;Gui, Add, Picture, 	x130	y191 	w32 	h32, 		Complementos\ICONS\ManaPotion.ico
	Gui, Add, Hotkey, 		x425	y193	w45					vHotkey_Mana_Stage1, %Hotkey_Mana_Stage1%
	;=================================STAGE2 
	Gui, Add, Slider, 		x7		y218			h20			vPercent_Mana_Stage2 Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %Percent_Mana_Stage2%
	Gui, Add, text, 		x130	y218	w120				,Heavy Mana Heal
	;Gui, Add, Picture, 	x134	y216 	w23 	h23, 		Complementos\ICONS\UltimateMana.ico
	Gui, Add, Hotkey, 		x425	y213	w45					vHotkey_Mana_Stage2, %Hotkey_Mana_Stage2%
	
	
	
	;=================================[Utamo / Energy Ring] ;=================================
	Gui, Add, GroupBox, 	x5 		y250 	w520 	h220		,Auto Swap Energy Ring / Utamo Vita
	Gui, Add, Picture,		x130	y270	w32		h32,		Complementos\ICONS\EnergyRing.ico
	Gui, Add, CheckBox,		x7		y274			h20 		vEnergy_Ring, [MAGIC SHIELD]
	Gui, Add, DropDownList, x180	y270	w85					vTipoMagicShield, %TipoMagicShield%||Energy Ring|Utamo Vita
	;=================================ENERGY RING --- HP ;=================================
	Gui, add, Text, 		x20 	y300						,HEALTH PERCENT
	Gui, Add, Slider, 		x7		y320			h20			vPercent_Life_Equip_Energy Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %Percent_Life_Equip_Energy%
	Gui, add, Text, 		x127 	y320						,Life to Equip Ring/Utamo
	Gui, Add, Slider, 		x7		y340			h20			vPercent_Life_DeEquip_Energy Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %Percent_Life_DeEquip_Energy%
	Gui, add, Text, 		x127 	y340						,Life to De Equip ring/utamo
	;=================================ENERGY RING --- MP ;=================================	
	Gui, add, Text, 		x25 	y370						,MANA PERCENT
	Gui, Add, Slider, 		x7		y390			h20			vPercent_Mana_Equip_Energy Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %Percent_Mana_Equip_Energy%
	Gui, add, Text, 		x127 	y390						,Minimum Mana to Equip
	Gui, Add, Slider, 		x7		y410			h20			vPercent_Mana_DeEquip_Energy Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %Percent_Mana_DeEquip_Energy%
	Gui, add, Text, 		x127 	y410						,De Equip If mana less then
	;=================================ENERGY RING --- HOTKEYS ;=================================
	Gui, add, text,			x400	y325						,EQUIP / Utamo Vita
	Gui, Add, Hotkey, 		x425	y340	w45					vHotkey_Energy_Ring, %Hotkey_Energy_Ring%
	Gui, add, text,			x395	y375						,DeEQUIP / Exana Vita
	Gui, Add, Hotkey, 		x425	y390	w45					vHotkey_DeEnergy_Ring, %Hotkey_DeEnergy_Ring%
	;=================================Key to Active
	Gui, Add, text, 		x385	y270	w120				,KEY DISABLE/ENABLE
	Gui, Add, Hotkey, 		x425	y290	w45					vHotkey_AtivaSwap, %Hotkey_AtivaSwap%
	

;===============================================================================================
Gui,Tab, 2 ; ===================================================================================  SUPORTE
;===============================================================================================

	Gui, Add, GroupBox, 	x5 		y29 	w260 	h350		,Support Functions
	Gui, Add, GroupBox, 	x275	y29 	w250 	h350		,Support Functions
	;Gui, Add, text, 		x7		y33		w120				, Support Functions
	Gui, add, text,			x207	y55							,Hotkeys
	Gui, add, text,			x465	y55							,Hotkeys
	;================================= [Food] ;=================================
	Gui, Add, Picture, 		x7		y65 	w32 	h32, 		Complementos\ICONS\dragon_ham.ico
	Gui, Add, CheckBox, 	x47		y70	 		 	h20 		vEAT, [FOOD]
	Gui, Add, Hotkey, 		x207	y70		w45					vHotkey_Eat, %Hotkey_Eat%
	;================================= [BUFF] ;=================================
	Gui, Add, Picture, 		x285	y65 	w32 	h32, 		Complementos\ICONS\Buff.ico
	Gui, Add, CheckBox, 	x323	y70	 		 	h20 		vPotBuff, [BUFF]
	Gui, Add, Hotkey, 		x465	y70		w45					vHotkey_PotBuff, %Hotkey_PotBuff%
	;================================= [Haste] ;=================================
	Gui, Add, Picture, 		x7		y105 	w32 	h32, 		Complementos\ICONS\boh.ico
	Gui, Add, CheckBox, 	x47		y110 		 	h20 		vHaste, [HASTE] 
	Gui, Add, CheckBox, 	x120		y110 		h20	 		vRPUTITADO, [RP UTITO?] 
	Gui, Add, Hotkey, 		x207	y110	w45					vHotkey_Haste, %Hotkey_Haste%
	;================================= [Renew Boots] ;=================================
	Gui, Add, Picture, 		x285	y105 	w32 	h32, 		Complementos\ICONS\prismaticboots.ico
	Gui, Add, CheckBox, 	x323	y110 		 	h20 		vBoots, [Boots] 
	Gui, Add, Hotkey, 		x465	y110	w45					vHotkey_Boots, %Hotkey_Boots%
	;================================= [Paralize] ;=================================
	Gui, Add, Picture, 		x7		y145 	w32 	h32, 		Complementos\ICONS\Paralize.ico
	Gui, Add, CheckBox, 	x47		y150 		 	h20 		vParalize, [PARALIZE]
	Gui, Add, Hotkey, 		x207	y150	w45					vHotkey_Paralize, %Hotkey_Paralize%	
	;================================= [Amulet] ;=================================
	Gui, Add, Picture, 		x8		y190 	w32 	h32, 		Complementos\ICONS\NoAmulet.ico
	Gui, Add, CheckBox, 	x47		y195 		 	h20 		vAmulet, [AMULET]
	Gui, Add, Hotkey, 		x207	y195	w45					vAmulet_Hotkey, %Amulet_Hotkey%	
	;================================= [Ring] ;=================================
	Gui, Add, Picture, 		x285	y190 	w32		h32, 		Complementos\ICONS\NoRing.ico
	Gui, Add, CheckBox, 	x323	y195 		 	h20 		vRing, [RING]
	Gui, Add, Hotkey, 		x465	y195	w45					vHotkey_Ring, %Hotkey_Ring%	
	;================================= [Utamo Vita] ;=================================
	Gui, Add, Picture, 		x10		y233 	w27 	h27, 		Complementos\ICONS\Utamo.ico
	Gui, Add, CheckBox, 	x47		y234 		 	h20 		vUtamoVita, [Utamo Vita]
	Gui, Add, Hotkey, 		x207	y234	w45					vHotkey_Utamo, %Hotkey_Utamo%	
	Gui, Add, CheckBox, 	x47		y254 		 	h20 		vPotUtamoVita, [Pot Utamo]
	Gui, Add, Hotkey, 		x207	y254	w45					vHotkey_PotUtamo, %Hotkey_PotUtamo%	
	Gui, add, Text, 		x7 		y290						,Simbolo Utamo Vita na Barra
	Gui, Add, DropDownList, x7		y310	w85					vTipoUtamo, GLOBAL|OT|%TipoUtamo%||
	;================================= [Quiver] ;=================================
	Gui, Add, Picture, 		x285	y230 	w32		h32, 		Complementos\ICONS\QuiverAzul0.png
	Gui, Add, CheckBox, 	x323	y234 		 	h20 		vQuiver, [Quiver]
	Gui, Add, Hotkey, 		x465	y230	w45					vHotkey_Quiver, %Hotkey_Quiver%	
	
;===============================================================================================
Gui,Tab, 3 ; =================================================================================== DEFENDER
;===============================================================================================

	
	Gui, Add, text, 		x7		y33		w120				, Defender Function
	
	Gui, Add, text, 		x200	y37							,Delay SSA/MIGHT RING (ms)
	Gui, add, Edit, 		x345	y33	w70	cFF0000				vDelaySSAMIGHT, %DelaySSAMIGHT%
	
	Gui, Add, GroupBox, 	x5 		y310 	w520 	h70			,TANK MODE FUNCTION
	Gui, add, text,			x10		y330						,Key to Active (need to set the hotkeys in SSA and MIGHT ring to work)
	Gui, Add, Hotkey, 		x10		y350 	w85					vHabilita_TankMode, %Habilita_TankMode%	
	
	Gui, add, text,			x465	y45							,Hotkeys

	;================================= [SSA] ;=================================
	Gui, Add, Picture, 		x7 		y64 	w32 	h32, 		Complementos\ICONS\ssa.ico
	Gui, Add, CheckBox,		x42 	y72 		 	h20 		vSSA, [SSA] Auto
	Gui, Add, DropDownList, x7		y105	w85					vTank_Amulet, %Tank_Amulet%||SSA|Shockwave|Sacred|Leviathan
	Gui, Add, Slider, 		x130	y72				h20			vSSA_Life Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %SSA_Life%
	Gui, add, Text, 		x253 	y74							,Life Percent
	Gui, Add, Slider, 		x130	y102			h20			vSSA_Mana Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %SSA_Mana%
	Gui, add, Text, 		x253 	y104						,Mana Percent
	Gui, Add, Hotkey, 		x465	y72		w45					vSSA_Hotkey, %SSA_Hotkey%
	;================================= [MIGHT] ;=================================
	Gui, Add, Picture, 		x9 		y145 	w32 	h32, 		Complementos\ICONS\might.ico
	Gui, Add, CheckBox, 	x42 	y150 		 	h20 		vMIGHT, [MIGHT] Auto
	Gui, Add, CheckBox, 	x42 	y170 		 	h20 		vForcaMight, [Force]
	Gui, Add, Slider, 		x130	y150			h20			vMight_Life Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %Might_Life%
	Gui, add, Text, 		x253 	y152						,Life Percent
	Gui, Add, Slider, 		x130	y180			h20			vMight_Mana Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %Might_Mana%
	Gui, add, Text, 		x253 	y182						,Mana Percent
	Gui, Add, Hotkey, 		x465	y160	w45					vMight_Hotkey, %Might_Hotkey%
	;================================= [FOOD VIDA] ;=================================
	Gui, Add, Picture, 		x9 		y230 	w32 	h32, 		Complementos\ICONS\cupcakehp.ico
	Gui, Add, CheckBox, 	x42 	y238 		 	h20 		vFOODHP, [FOOD] HP
	Gui, Add, Slider, 		x130	y238			h20			vPercentFOODHP Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %PercentFOODHP%
	Gui, add, Text, 		x253 	y240						,Life Percent
	Gui, Add, Hotkey, 		x465	y238	w45					vHotkeyFOODHP, %HotkeyFOODHP%
	;================================= [FOOD MANA] ;=================================
	Gui, Add, Picture, 		x9 		y270 	w32 	h32, 		Complementos\ICONS\cupcakemp.ico
	Gui, Add, CheckBox, 	x42 	y278 		 	h20 		vFOODMP, [FOOD] MP
	Gui, Add, Slider, 		x130	y278			h20			vPercentFOODMP Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %PercentFOODMP%
	Gui, add, Text, 		x253 	y280						,Mana Percent
	Gui, Add, Hotkey, 		x465	y278	w45					vHotkeyFOODMP, %HotkeyFOODMP%
	
;===============================================================================================
Gui,Tab, 4 ; ===================================================================================  SIO FRIEND
;===============================================================================================

	Gui, Add, GroupBox, 	x5 		y30 	w520 	h85			,Self HP / MP Conditions 
	Gui, add, Text, 		x7 		y55							,Vida minima do ED para dar SIO
	Gui, Add, Slider, 		x7		y75				h20			vPercentSelfHealth Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %PercentSelfHealth%
	
	Gui, add, Text, 		x250	y55							,Mana minima do ED para dar SIO
	Gui, Add, Slider, 		x250	y75				h20			vPercentSelfMana Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %PercentSelfMana%
	;================================= [SIO EK] ;=================================
	;================================= Sio ;=================================
	Gui, Add, GroupBox, 	x5 		y130 	w520 	h115		,Friend Heal - PRINCIPAL (primeira pessoa do party list)
	;Gui, add, Text, 		x7 		y145						,Sio 1º Pessoa Party List [PRINCIPAL]
	Gui, add, Text, 		x365 	y145						,HEALTH PERCENT
	Gui, Add, Picture, 		x10		y174		w20		h20, 	Complementos\ICONS\ek.ico
	Gui, Add, CheckBox,		x42 	y174 				 		vSIOEK, [HealFriend1]
	Gui, add, Text, 		x240	y178						,HK SIO/UH
	Gui, Add, Hotkey, 		x300	y174		w45				vHotkey_SIO_1, %Hotkey_SIO_1%
	Gui, Add, Slider, 		x355	y174				h20		vPercentSIO1 Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %PercentSIO1%
	Gui, Add, Slider, 		x355	y214				h20		vPercentGranSIO1 Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %PercentGranSIO1%
	;================================= Gran Sio ;=================================
	Gui, add, Text, 		x235	y214						,HK Gran SIO
	Gui, Add, Hotkey, 		x300	y210	w45					vHotkey_GranSIO_1, %Hotkey_GranSIO_1%
	Gui, Add, DropDownList, x35		y206	w85					vHealFriend1, %HealFriend1%||SIO|UH
	;================================= [SIO RP] ;=================================
	;================================= Sio ;=================================
	Gui, Add, GroupBox, 	x5 		y270 	w520 	h115		,Friend Heal - SECUNDARIO (segunda pessoa do party list)
	;Gui, add, Text, 		x7 		y283						,Sio 2º Pessoa Party List [SECUNDARIO]
	Gui, add, Text, 		x365 	y283						,HEALTH PERCENT
	Gui, Add, Picture, 		x7		y303 	w38 	h38, 		Complementos\ICONS\rp.ico
	Gui, Add, CheckBox, 	x42 	y308 		 	h20 		vSIORP, [HealFriend2]
	Gui, add, Text, 		x240	y312						,HK SIO/UH
	Gui, Add, Hotkey, 		x300	y308	w45					vHotkey_SIO_2, %Hotkey_SIO_2%
	Gui, Add, Slider, 		x355	y308				h20		vPercentSIO3 Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %PercentSIO3%
	Gui, Add, DropDownList, x35		y340	w85					vHealFriend2, %HealFriend2%||SIO|UH

;===============================================================================================
Gui,Tab, 5 ; ===================================================================================  ATAQUE
;===============================================================================================

	Gui, Add, text, 		x7		y33							,Key to Active Attack
	Gui, Add, Hotkey, 		x120	y33		w60					vHotkey_ATK, %Hotkey_ATK%
	;================================= Selecionar Tipo de Ataque ;=================================
	Gui, Add, text, 		x7		y60							,Selecionar Tipo de Ataque
	Gui, Add, DropDownList, x7		y78		w85					vTipoAtaque, Desligado||Rune1|Rune2|Rotacao1|Rotacao2
	;================================= Auto Target ;=================================
	Gui, Add, text, 		x210	y40							,Next Target
	Gui, Add, Hotkey, 		x270	y40		w70					vHotkey_Target, %Hotkey_Target%
	
	Gui, Add, text, 		x210	y80							,Auto Target
	Gui, Add, DropDownList, x270	y75		w85					vTipoTarget, Desligado||First Target
	
	
	;================================= [RUNE 1] ;=================================
	Gui, add, Text, 		x10		y143	w70					,Hotkey
	Gui, add, Text,			x10		y163	w70					,Delay [ms]
	Gui, Add, GroupBox, 	x5 		y120 	w170 	h70			,[Rune / Spell] 1
	Gui, Add, Hotkey, 		x90		y140	w70					vRune1, %Rune1%
	Gui, add, Edit, 		x90		y160	w70	cFF0000			vTimeDelay1, %TimeDelay1%
	;================================= [RUNE 2] ;=================================
	Gui, add, Text, 		x261	y143	w70					,Hotkey
	Gui, add, Text,			x261	y163	w70					,Delay [ms]
	Gui, Add, GroupBox, 	x255	y120 	w170 	h70			,[Rune / Spell] 2
	Gui, Add, Hotkey, 		x344	y140	w70					vRune2, %Rune2%
	Gui, add, Edit, 		x344	y160	w70	cFF0000			vTimeDelay2, %TimeDelay2%

	
	
	;================================= Textos Rotacao de magia ;=================================
	Gui, add, Text,			x10		y243	w70					,Qtd
	Gui, add, Text, 		x10		y263	w70					,Hotkey1
	Gui, add, Text,			x10		y283	w70					,Hotkey2
	Gui, add, Text,			x10		y303	w70					,Hotkey3
	Gui, add, Text, 		x10		y323	w70					,Hotkey4
	Gui, add, Text,			x10		y343	w70					,Delay [ms]
	;================================= [ROTAÇÃO 1] ;=================================
	Gui, Add, GroupBox, 	x7		y220 	w170 	h150		,[Rotacao de Magias] 1
	Gui, Add, DropDownList, x90		y240	w70					vQuantidadeDeMagia1, %QuantidadeDeMagia1%||2|3|4
	Gui, Add, Hotkey, 		x90		y260	w70					vMagiaRotacao1_1, %MagiaRotacao1_1%
	Gui, Add, Hotkey, 		x90		y280	w70					vMagiaRotacao1_2, %MagiaRotacao1_2%
	Gui, Add, Hotkey, 		x90		y300	w70					vMagiaRotacao1_3, %MagiaRotacao1_3%
	Gui, Add, Hotkey, 		x90		y320	w70					vMagiaRotacao1_4, %MagiaRotacao1_4%
	Gui, add, Edit, 		x90		y340	w70	cFF0000			vTimeDelay3, %TimeDelay3%
	;================================= Textos Rotacao de magia ;=================================
	Gui, add, Text,			x261	y243	w70					,Qtd
	Gui, add, Text, 		x261	y263	w70					,Hotkey1
	Gui, add, Text,			x261	y283	w70					,Hotkey2
	Gui, add, Text,			x261	y303	w70					,Hotkey3
	Gui, add, Text, 		x261	y323	w70					,Hotkey4
	Gui, add, Text,			x261	y343	w70					,Delay [ms]
	;================================= [ROTAÇÃO 2] ;=================================
	Gui, Add, GroupBox, 	x255	y220 	w170 	h150		,[Rotacao de Magias] 2
	Gui, Add, DropDownList, x344	y240	w70					vQuantidadeDeMagia2, %QuantidadeDeMagia2%||2|3|4
	Gui, Add, Hotkey, 		x344	y260	w70					vMagiaRotacao2_1, %MagiaRotacao2_1%
	Gui, Add, Hotkey, 		x344	y280	w70					vMagiaRotacao2_2, %MagiaRotacao2_2%
	Gui, Add, Hotkey, 		x344	y300	w70					vMagiaRotacao2_3, %MagiaRotacao2_3%
	Gui, Add, Hotkey, 		x344	y320	w70					vMagiaRotacao2_4, %MagiaRotacao2_4%
	Gui, add, Edit, 		x344	y340	w70		cFF0000		vTimeDelay4, %TimeDelay4%
	
	;================================= [Safe Mode] ;=================================
	Gui, Add, GroupBox, 	x375	y33 	w148 	h60			,ALERTS / ALARMS
	Gui, Add, CheckBox, 	x381	y53							vSafe_Mode, Detect Player on Screen
	Gui, Add, CheckBox, 	x381	y73							vSafe_StopAttack, STOP if player on screen
;===============================================================================================
Gui,Tab, 6 ; ===================================================================================  UTEIS
;===============================================================================================
	
	
	
	;================================= [Mana training] ;=================================
	Gui, Add, GroupBox, 	x5 		y29 	w420 	h335		,MANA TRAINING
	;Gui, Add, Picture, 	x15		y50 	w32 	h32, 		Complementos\ICONS\ManaTrain.ico
	Gui, Add, CheckBox, 	x10		y45		 h20 				vManaTraining, [MANA TRAINING] 
	Gui, Add, DropDownList, x130	y40		w85					vOpcaoTreino, Desligado||Magia|Exercise|Magia e Exercise
	Gui, add, text,			x80		y68							,obs. ao habilitar o mana training todo o resto entra em stand by.
	
	Gui, Add, GroupBox, 	x12		y85		w180		h165	,Rune Maker
	Gui, Add, edit,			x150	y95	w40 ReadOnly 			hwndTimerManaTrain1, 0
	Gui, add, text,			x20		y108						,Hotkeys
	Gui, Add, Hotkey, 		x20		y124	w60					vHotkeyTrain1, %HotkeyTrain1%
	Gui, Add, Text,			x85		y128						,Training Hotkey 1
	Gui, Add, Hotkey, 		x20		y144	w60					vHotkeyTrain2, %HotkeyTrain2%
	Gui, Add, Text,			x85		y148						,Training Hotkey 2
	Gui, Add, Hotkey, 		x20		y164	w60					vHotkeyTrain3, %HotkeyTrain3%
	Gui, Add, Text,			x85		y168						,Training Hotkey 3
	Gui, Add, Hotkey, 		x20		y184	w60					vHotkeyTrain4, %HotkeyTrain4%
	Gui, Add, Text,			x85		y188						,Training Hotkey 4
	Gui, Add, Hotkey, 		x20		y204	w60					vHotkeyTrain5, %HotkeyTrain5%
	Gui, Add, Text,			x85		y208						,Training Hotkey 5
	Gui, Add, Edit, 		x20		y224	w60	cFF0000			vTimeDelay, %TimeDelay%
	Gui, Add, Text,			x85		y228						,SEGUNDOS
	
	;================================= [Exercise] ;=================================
	Gui, Add, GroupBox, 	x200	y85 	w210 	h165		,Exercise Training
	Gui, Add, edit,			x365	y95		w40 ReadOnly 		hwndTimerExercise1, 0
	Gui, Add, Hotkey, 		x210	y124		w60				vHotkey_Exercise, %Hotkey_Exercise%
	Gui, Add, Text,			x275	y128						,Hotkey Exercise Weapon
	Gui, add, Edit, 		x210	y144		w60	cFF0000		vExerciseDelay, %ExerciseDelay%
	Gui, Add, Text,			x275	y148						,SEGUNDOS

	Gui, Add, Text,			x295	y164						,X
	Gui, Add, Text,			x335	y164						,Y
	Gui, Add, edit,			x280	y184	w40 h20	ReadOnly	hwndGuiGetPosDummyX
	Gui, Add, edit,			x325	y184	w40 h20	ReadOnly	hwndGuiGetPosDummyY
	Gui, Add, Button,		x240	y220						gExercisePos, Insira Coordenada do Dummy
	
	;================================= [BUY POT NPC] ;=================================
	Gui, Add, GroupBox, 	x12		y255 	w180 	h100		,Buy Pot NPC
	Gui, Add, CheckBox, 	x20		y275 				 		vBUYPOT, BUY POT NPC
	
	Gui, Add, edit,			x120	y275	w40 ReadOnly 		hwndTimerBUYPOT1, 0
	
	Gui, add, Edit, 		x20		y300	w60	cFF0000			vPOTDELAY, %POTDELAY%
	Gui, Add, Text,			x85		y305						,SEGUNDOS
	
	Gui, Add, DropDownList, x20		y325	w55					vQTDPOT, 100||200|300|400|500
	Gui, Add, DropDownList, x120	y325	w55					vPOTTYPE, GMP||MP|SMP|UMP
	
	
	
	;================================= [Re login} ;=================================
	Gui, Add, GroupBox, 	x200	y255 	w210 	h100		,Auto Re Login
	Gui, Add, CheckBox, 	x210	y275 				 		vAuto_ReLogin, Auto Re Login
	Gui, Add, Text,			x210	y300						,Login:
	Gui, add, Edit, 		x260	y300	w130	cBlack		vAccount, %Account%
	Gui, Add, Text,			x210	y325						,Password:
	Gui, add, Edit, 		x260	y325	w130 Password cBlack		vPassword, %Password%
	
	
	;================================= [Push} ;=================================
	Gui, Add, CheckBox, 	x10		y400 				 		vPush, Função Push
	Gui, Add, Hotkey, 		x110	y400	w60					vHotkey_Push, %Hotkey_Push%
	Gui, Add, Button,		x190	y400	w80					gGetPosPush, Get Pos
	Gui, Add, Text,			x295	y380						,X
	Gui, Add, Text,			x335	y380						,Y
	Gui, Add, edit,			x280	y400	w40 h20	ReadOnly	hwndPos1PushX, Pos1PushX 
	Gui, Add, edit,			x325	y400	w40 h20	ReadOnly	hwndPos1PushY, Pos1PushY 
	Gui, Add, edit,			x280	y430	w40 h20	ReadOnly	hwndPos2PushX, Pos1PushX 
	Gui, Add, edit,			x325	y430	w40 h20	ReadOnly	hwndPos2PushY, Pos1PushY 
	Gui, Add, Button,		x370	y400						gClearPosPush, Clear
	
	

	
	
	
	;================================= [CONSECUTIVE FUNCTIONS] ;=================================
	Gui, Add, GroupBox, 	x5 		y480 	w520 	h115		,SMART TIMED USE
	
	Gui, Add, CheckBox, 	x7 		y500	 	h20		 		vConsecutiveFunction1, TIMED RUNE AT COORDINATE (exemple: wild grow - HK + POS)
	Gui, Add, Hotkey, 		x7		y520	w60					vHotkey_Consecutive1, %Hotkey_Consecutive1%
	Gui, add, Edit, 		x75		y520	w60	cFF0000			vDelay_Consecutive1, %Delay_Consecutive1%
	Gui, Add, Text,			x140	y523						,SEGUNDOS

	Gui, Add, Button,		x7		y550	w80					gGetPosConsecutive, Get Pos
	
	Gui, Add, Text,			x110	y555						,X
	Gui, Add, Text,			x110	y575						,Y
	Gui, Add, edit,			x120	y550	w40 h20	ReadOnly	hwndGuiPosConsecutive1X
	Gui, Add, edit,			x120	y570	w40 h20	ReadOnly	hwndGuiPosConsecutive1Y
	;=================================
	Gui, Add, CheckBox, 	x370	y500	 	h20		 		vConsecutiveFunction2, TIMED HK (SPELL)
	Gui, Add, Hotkey, 		x370	y520	w60					vHotkey_Consecutive2, %Hotkey_Consecutive2%
	Gui, add, Edit, 		x445	y520		w60	cFF0000		vDelay_Consecutive2, %Delay_Consecutive2%
	Gui, Add, Text,			x445	y545						,SEGUNDOS
	
;===============================================================================================
Gui,Tab, 7 ; ===================================================================================  PVP Functions
;===============================================================================================
	;================================= Flower ;=================================
	Gui, Add, GroupBox, 	x5 		y29 w520 h65 +Left			,Flower (Mouse Cursor)
	Gui, Add, Text, 		x292	y44 w155 h20 +Center		,Coordinates
	Gui, Add, Text, 		x292 	y67 w20 h15 				,X =
	Gui, Add, Text, 		x366 	y67 w20 h15 				,Y =
	Gui, Add, Text, 		x217 	y44 w70 h20 +Center			,Key To active
	Gui, Add, Picture, 		x12 	y49 w32 h32 				,Complementos\ICONS\Flower.ico
	Gui, Add, CheckBox, 	x46 	y49 w60 h32 				vFlower, Flower
	Gui, Font, cBlack
	Gui, Add, Hotkey, 		x217 	y65 w70 h20 				vKey_Enable_Flower,%Key_Enable_Flower%
	Gui, Font, cRed
	Gui, Add, edit,			x313	y65	w50 h20	ReadOnly		hwndGUIFlowerX, 0 
	Gui, Add, edit,			x387	y65	w50 h20	ReadOnly		hwndGUIFlowerY, 0 
	Gui, Font, cWhite
	Gui, Add, Button, 		x445 	y49 w70 h30 				gSelectCoordinatesFlower, Select Coordinates
	
	;================================= Tash SQM ;=================================
	Gui, Add, GroupBox, 	x5 		y99 w520 h130 				,Trash (Mouse Cursor)
	Gui, Add, Text, 		x292	y114 w155 h20 +Center		,Coordinates
	Gui, Add, Text, 		x292 	y137 w20 h15 				,X =
	Gui, Add, Text, 		x366 	y137 w20 h15 				,Y =
	Gui, Add, Text, 		x217 	y139 w70 h20 				, Key To active
	Gui, Add, Picture, 		x12 	y119 w32 h32  				,Complementos\ICONS\Worm.ico
	Gui, Add, CheckBox, 	x46 	y119 w60 h32 				vTrash1, Trash 1
	Gui, Font, cBlack
	Gui, Add, Hotkey, 		x217 	y165 w70 h20 				vKey_Enable_Trash,  %Key_Enable_Trash%
	Gui, Font, cRed
	Gui, Add, edit,			x313	y135	w50 h20	ReadOnly		hwndGUIGetPosTrash1X, 0 
	Gui, Add, edit,			x387	y135	w50 h20	ReadOnly		hwndGUIGetPosTrash1Y, 0 
	Gui, Font, cWhite
	Gui, Add, Button, 		x445 	y119 w70 h30 				gSelectCoordinatesTrash1, Select Coordinates
	Gui, Add, Text, 		x292 	y197 w20 h15 				,X =
	Gui, Add, Text, 		x366	y197 w20 h15 				,Y =
	Gui, Add, Picture, 		x12 	y149 w32 h32 				,Complementos\ICONS\Cherry.ico
	Gui, Add, CheckBox, 	x46 	y149 w60 h32 				vTrash2, Trash 2
	Gui, Add, DropDownList, x20		y190 w85					vOpcaoTrash, Mouse|Pe|%OpcaoTrash%||
	Gui, Font, cRed
	Gui, Add, edit,			x313	y195	w50 h20	ReadOnly		hwndGUIGetPosTrash2X, 0 
	Gui, Add, edit,			x387	y195	w50 h20	ReadOnly		hwndGUIGetPosTrash2Y, 0 
	Gui, Font, cWhite
	Gui, Add, Button, 		x445 	y179 w70 h30 				gSelectCoordinatesTrash2, Select Coordinates

	;================================= Item to BP ;=================================	
	Gui, Add, GroupBox,		x5 		y234 w520 h65 				,Push item to Backpack
	Gui, Add, Text, 		x292 	y244 w155 h20 +Center		,Coordinates
	Gui, Add, Text,			x292 	y267 w20 h15 				, X =
	Gui, Add, Text, 		x366 	y267 w20 h15 				, Y =
	Gui, Add, Text, 		x212 	y249 w70 h20 				, Key To active
	Gui, Add, Picture, 		x12 	y254 w32 h32 				,Complementos\ICONS\Backpack.ico
	Gui, Add, CheckBox, 	x46 	y254 w60 h32 				vPushItem, Push item
	Gui, Font, cBlack
	Gui, Add, Hotkey, 		x212 	y270 w70 h20 				vKey_Enable_PushItem, %Key_Enable_PushItem%
	Gui, Font, cRed
	Gui, Add, edit,			x313	y265	w50 h20	ReadOnly		hwndGUIPushItemBPX, 0 
	Gui, Add, edit,			x387	y265	w50 h20	ReadOnly		hwndGUIPushItemBPY, 0 
	Gui, Font, cWhite
	Gui, Add, Button, 		x445 	y249 w70 h30 				gSelectCoordinatesPushItem, Select Coordinates	
	
	
	
	
	
	
	
;===============================================================================================
Gui,Tab, 8 ; ===================================================================================  LOOTER
;===============================================================================================
	;================================= Delay Loot ;=================================
	Gui, add, Edit, 		x7		y50		w70	cFF0000			vDelayLoot, %DelayLoot%
	Gui, Add, Text,			x7		y35							,Clicks Delay (ms)
	;================================= Hotkey Start Stop perm ;=================================
	Gui, Add, Hotkey, 		x7		y90		w70					vHotkey_StartStopQuickloot, %Hotkey_StartStopQuickloot%
	Gui, Add, Text,			x7		y75							,Key to Active
	
	
	
	;================================= Hotkey Looter 1x ;=================================
	Gui, Add, Text,			x7		y115						,Key to quickloot one time
	Gui, Add, Hotkey, 		x7		y130	w70					vHotkey_Quickloot, %Hotkey_Quickloot%	
	Gui, Add, DropDownList, x85		y130	w100				vKeyMouseQuickLoot, Hotkey|Mouse Button 4|Mouse Button 5|%KeyMouseQuickLoot%||
	
	;================================= Key do Tibia para Lootear ;=======================
	Gui, Add, Text,			x7		y160	w140	h30				,MOUSE OPTION TO LOOT (CONFIG IN TIBIA)
	Gui, Add, DropDownList, x7		y190	w110				vKeyQuickLootTibia, LEFT|RIGHT|SHIFT_RIGHT|%KeyQuickLootTibia%||
	;================================= Stop Quick Loot ;=================================
	Gui, Add, Button,		x7		y220	w110				gDesligaQuickLoot, Disable Quick Loot
	
	Gui, Add, GroupBox, 	x7 		y300 	w420 	h200		,ATENCAO
	Gui, Add, Text,			x13		y320						,Para utilizar o quick loot, voce primeiro deve selecionar o SQM CENTRRAL
	Gui, Add, Text,			x17		y340						,conforme indicado na foto acima, clique em GET POS 1-2-3 e selecione
	Gui, Add, Text,			x17		y360						,o sqm indicado.
	
	gui,add,picture,		x190 	y30 						hwndmypic,Complementos\Imagens\%VersaoGrafico%\looter.png

	
	;================================= Pos 11 ;=================================
	Gui, Add, Button,		x195	y35							gGetPosLoot11, Get Pos 1
	
	Gui, Add, Text,			x195	y63							,X=
	Gui, Add, edit,			x207	y60	w40 h20	ReadOnly		hwndXguipos11, Xguipos11
	Gui, Add, Text,			x195	y83							,Y=
	Gui, Add, edit,			x207	y80	w40 h20	ReadOnly		hwndYguipos11, Yguipos11
	;================================= Pos 12 ;=================================
	Gui, Add, Text,			x275	y63							,X=
	Gui, Add, edit,			x288	y60	w40 h20	ReadOnly		hwndXguipos12, Xguipos12
	Gui, Add, Text,			x275	y83							,Y=
	Gui, Add, edit,			x288	y80	w40 h20	ReadOnly		hwndYguipos12, Yguipos12
	;================================= Pos 13 ;=================================
	Gui, Add, Text,			x345	y63							,X=
	Gui, Add, edit,			x358	y60	w40 h20	ReadOnly		hwndXguipos13, Xguipos13
	Gui, Add, Text,			x345	y83							,Y=
	Gui, Add, edit,			x358	y80	w40 h20	ReadOnly		hwndYguipos13, Yguipos13
	;================================= Pos 21 ;=================================
	Gui, Add, Text,			x195	y138						,X=
	Gui, Add, edit,			x207	y135 w40 h20	ReadOnly	hwndXguipos21, Xguipos21
	Gui, Add, Text,			x195	y158						,Y=
	Gui, Add, edit,			x207	y155 w40 h20	ReadOnly	hwndYguipos21, Yguipos21
	;================================= Pos 22 ;=================================
	Gui, Add, Button,		x275	y115						gGetPosLoot22, Get Pos 2
	
	Gui, Add, Text,			x275	y138						,X=
	Gui, Add, edit,			x288	y135 w40 h20	ReadOnly	hwndXguipos22, Xguipos22
	Gui, Add, Text,			x275	y158						,Y=
	Gui, Add, edit,			x288	y155 w40 h20	ReadOnly	hwndYguipos22, Yguipos22
	;================================= Pos 23 ;=================================
	Gui, Add, Text,			x345	y138						,X=
	Gui, Add, edit,			x358	y135 w40 h20	ReadOnly	hwndXguipos23, Xguipos23
	Gui, Add, Text,			x345	y158						,Y=
	Gui, Add, edit,			x358	y155 w40 h20	ReadOnly	hwndYguipos23, Yguipos23
	;================================= Pos 31 ;=================================
	Gui, Add, Text,			x195	y213						,X=
	Gui, Add, edit,			x207	y210 w40 h20	ReadOnly	hwndXguipos31, Xguipos31
	Gui, Add, Text,			x195	y233						,Y=
	Gui, Add, edit,			x207	y230 w40 h20	ReadOnly	hwndYguipos31, Yguipos31
	;================================= Pos 32 ;=================================
	Gui, Add, Text,			x275	y213						,X=
	Gui, Add, edit,			x288	y210 w40 h20	ReadOnly	hwndXguipos32, Xguipos32
	Gui, Add, Text,			x275	y233						,Y=
	Gui, Add, edit,			x288	y230 w40 h20	ReadOnly	hwndYguipos32, Yguipos32
	;================================= Pos 33 ;=================================
	Gui, Add, Button,		x345	y190						gGetPosLoot33, Get Pos 3
	
	Gui, Add, Text,			x345	y213						,X=
	Gui, Add, edit,			x358	y210 w40 h20	ReadOnly	hwndXguipos33, Xguipos33
	Gui, Add, Text,			x345	y233						,Y=
	Gui, Add, edit,			x358	y230 w40 h20	ReadOnly	hwndYguipos33, Yguipos33
	
;===============================================================================================
Gui,Tab, 9 ; ===================================================================================  HELP
;===============================================================================================

	Gui, Add, Text,			x10		y30							,The world will
	Gui, Add, Button,		x120	y30							goberon_msg1, Msg1
	
	Gui, Add, Text,			x10		y70							,You appear like
	Gui, Add, Button,		x120	y70							goberon_msg2, Msg2
	
	Gui, Add, Text,			x10		y110						,People fall at
	Gui, Add, Button,		x120	y110						goberon_msg3, Msg3
	
	Gui, Add, Text,			x10		y150						,This will be the
	Gui, Add, Button,		x120	y150						goberon_msg4, Msg4
	
	Gui, Add, Text,			x10		y190						,I will remove you
	Gui, Add, Button,		x120	y190						goberon_msg5, Msg5
	
	Gui, Add, Text,			x10		y230						,Dragons will soon
	Gui, Add, Button,		x120	y230						goberon_msg6, Msg6
	
	Gui, Add, Text,			x10		y270						,The true virtue
	Gui, Add, Button,		x120	y270						goberon_msg7, Msg7
	
	Gui, Add, Text,			x10		y310						,I lead the most
	Gui, Add, Button,		x120	y310						goberon_msg8, Msg8
	
	Gui, Add, Text,			x10		y350						,ULTAH SALID
	Gui, Add, Button,		x120	y350						goberon_msg9, Msg9

;===============================================================================================
Gui,Tab, 10 ; ===================================================================================  HELP
;===============================================================================================

	Gui, add, text,			x7		y30							,=====ATENÇÃO=====
	gui,add,picture, 		x7 		y50 						hwndmypic,Complementos\Imagens\%VersaoGrafico%\StatusBar.png
	Gui, add, text,			x137	y30							,..............MANTER A STATUS BAR ABERTA.............
	Gui, add, text,			x137	y50							,CASO NÃO ESTEJA FUNCIONANDO ENCHER A VIDA
	Gui, add, text,			x137	y70							,..............E CLICAR EM RELOAD IMAGENS.............


	Gui, add, Text, 		x7		y150						,DEIXAR O PARTY LIST DESSE JEITO (com escolha de classes aparentes)
	gui,add,picture, 		x7 		y170 						hwndmypic,Complementos\Imagens\%VersaoGrafico%\PartyListBarra.png


	gui,add,picture, 		x7 		y280						hwndmypic,Complementos\Imagens\%VersaoGrafico%\Battle.png
	Gui, add, text,			x127	y260						,***PARA UTILIZAR FIRST TARGET NECESSÀRIO MANTER
	Gui, add, text,			x200	y280						,BATTLE ABERTO DESTA FORMA E TAMBÉM
	Gui, add, text,			x200	y300						,NECESSÁRIO COLOCAR O BATTLE EM
	Gui, add, text,			x200	y320						,====SORT ASCENDING BY DISTANCE====
	Gui, add, text,			x200	y360						,***PARA UTILIZAR NEXT TAGERT BASTA
	Gui, add, text,			x200	y380						,CONFIGURAR A HOTKEY NO CLIENTE
	
	Gui, add, Text, 		x7		y420						,PARA PLAYER ALERT ABRIR UM NOVO BATTLE E NOMEAR PARA PLAYER
	Gui, add, Text, 		x7		y440						,E DEIXAR ASSIM (foto abaixo)
	gui,add,picture, 		x7 		y460 						hwndmypic,Complementos\Imagens\%VersaoGrafico%\BattlePlayerAlert.png

;===============================================================================================
;===============================================================================================
;===============================================================================================


Gui, Show, % " w" GUIWidth " h" GUIHeight, Primo Marcos

} ; FIM DO GUI

CheckValidade:
CheckDate()
return

Scriptsrapidos:
;==================================================================================
;================================================================================== PVP
;==================================================================================
if (Key_Enable_Flower <> "ERROR") {
	Hotkey, ~<%Key_Enable_Flower%, FlowerOnMouse, Off
}
GuiControlGet, Key_Enable_Flower
Hotkey, ~<%Key_Enable_Flower%, FlowerOnMouse, On

if (Key_Enable_Trash <> "ERROR") {
	Hotkey, ~<%Key_Enable_Trash%, TrashOnMouse, Off
}
GuiControlGet, Key_Enable_Trash
Hotkey, ~<%Key_Enable_Trash%, TrashOnMouse, On

if (Key_Enable_PushItem <> "ERROR") {
	Hotkey, ~<%Key_Enable_PushItem%, PushItemOnBP, Off
}
GuiControlGet, Key_Enable_PushItem
Hotkey, ~<%Key_Enable_PushItem%, PushItemOnBP, On


;==================================================================================
;================================================================================== Tank Mode
;==================================================================================
if (Habilita_TankMode <> "ERROR") {
	Hotkey, ~<%Habilita_TankMode%, TankMode_Func, Off
}
GuiControlGet, Habilita_TankMode
Hotkey, ~<%Habilita_TankMode%, TankMode_Func, On

;==================================================================================
;==================================================================================Quick Loot
;==================================================================================
GuiControlGet, QuickLooter
if (Hotkey_QuickLoot <> "ERROR") {
	Hotkey, ~<%Hotkey_QuickLoot%, QuickLooter, Off
}
if (Hotkey_StartStopQuickloot <> "ERROR") {
	Hotkey, ~<%Hotkey_StartStopQuickloot%, QuickLooter_Active, Off
}


GuiControlGet, Hotkey_StartStopQuickloot
GuiControlGet, KeyMouseQuickLoot
if (KeyMouseQuickLoot = "Mouse Button 4"){
	Hotkey_QuickLoot = XButton1
} else if (KeyMouseQuickLoot = "Mouse Button 5"){
	Hotkey_QuickLoot = XButton2
} else if (KeyMouseQuickLoot = "Hotkey"){
	GuiControlGet, Hotkey_QuickLoot
}

IF ((QuickLooter = 1) and (ForaPZ = 1)) {
	Hotkey, ~<%Hotkey_QuickLoot%, QuickLooter, On
	Hotkey, ~<%Hotkey_StartStopQuickloot%, QuickLooter_Active, On
} else {
	Ativa_QuickLoot_Perm = 0	
}

If (((Ativa_QuickLoot_Perm == 1) or (Ativa_QuickLoot == 1)) and (QuickLooter = 1) and (GetPosLoot11X != 0) and (ForaPZ = 1) and (State_Pause1 = "Primo Running")) {
		QuickLooter()
		QuickLootOn = Looter Ligado
} else {
	Ativa_QuickLoot_Perm = 0
	QuickLootOn = Looter Desligado
}

;==================================================================================
;================================================================================== Push
;==================================================================================
GuiControlGet, Push
if (Hotkey_Push <> "ERROR") {
	Hotkey, ~<%Hotkey_Push%, Push_Func, Off
}
GuiControlGet, Hotkey_Push
If ((Push = 1) and (PosPushX1 > 0 )) {
	Hotkey, ~<%Hotkey_Push%, Push_Func, On
	If (Ativa_Push == 1) {
		Push_Func1()
	}
} else {
	Ativa_Push = 0
}
	
;==================================================================================
;================================================================================== Pause
;==================================================================================	
if (Hotkey_Pause <> "ERROR") {
	Hotkey, ~<%Hotkey_Pause%, Pause_Script, Off
}
GuiControlGet, Hotkey_Pause
Hotkey, ~<%Hotkey_Pause%, Pause_Script, On


;==================================================================================
;================================================================================== Swap Energy Ring + Utamo Vita
;==================================================================================	

GuiControlGet, Energy_Ring
if (Hotkey_AtivaSwap <> "ERROR") {
	Hotkey, ~<%Hotkey_AtivaSwap%, Swap_Ring_Utamo, Off
}
GuiControlGet, Hotkey_AtivaSwap
If (Energy_Ring = 1) {
	Hotkey, ~<%Hotkey_AtivaSwap%, Swap_Ring_Utamo, On
	If (Ativa_Swap == 1) {
		Status_SwapRing = SwapRing/Utamo ON
	} else {
		Status_SwapRing = SwapRing/Utamo Off
	}
}

;==================================================================================	
;==================================================================================	Primo Ataque
;==================================================================================
if (Hotkey_ATK <> "ERROR") {
	Hotkey, ~<%Hotkey_ATK%, Ativa_Ataque, Off
}
GuiControlGet, Hotkey_ATK
GuiControlGet, Safe_Mode
if (((TipoTarget = "First Target") or (TipoTarget = "Next Target") or (Safe_Mode = 1) or (AtkRune1 = 1) or (AtkRune2 = 1) or (AtkRotacao1 = 1) or (AtkRotacao2 = 1)) and (ForaPZ = 1)) {
	Hotkey, ~<%Hotkey_ATK%, Ativa_Ataque, On
		Process, Exist, 6.exe
	If (!ErrorLevel= 0) {
		goto Label7
	}
		run, Complementos\6.exe
}
Label7:
if (((TipoTarget = "Desligado") and (Safe_Mode = 0) and (AtkRune1 = 0) and (AtkRune2 = 0) and (AtkRotacao1 = 0) and (AtkRotacao2 = 0)) or (ForaPZ = 0) or (State_Pause = 1)) {
		Ativa_Atk = 0
		PrimoAtaqueStatus = Ataque Desligado
		Process, Exist, 6.exe
	If (!ErrorLevel= 0) {
		Process, Close , 6.exe
	}
}

return 

StartGeral:

ChecaCliente()
RotinaContinua()

GuiControlGet, ManterTelaAtiva
	if (ManterTelaAtiva = 1) {
		#IfWin[Not]Active ahk_pid %Actual_PID%
		WinActivate, ahk_pid %Actual_PID%
	}
	
GuiControlGet, ManaTraining
if ((ImagemCliente = 1) and (State_Pause = 0) and (ManaTraining == 0)) {

GuiControlGet, Life_AutoHealing
	If (Life_AutoHealing == 1) {
		if (VersaoPrimo1 = "MultiScripts") {
			process, exist, 1.exe
			if errorlevel
				goto OutHeal
			else
				run, Complementos\1.exe
		} else if (VersaoPrimo1 = "ScriptUnico") {
				AutoSelfHeal()
		}
	} 
OutHeal:

GuiControlGet, Mana_AutoHealing
	If (Mana_AutoHealing == 1) {
		if (VersaoPrimo1 = "MultiScripts") {
			process, exist, 1.exe
			if errorlevel
				goto OutMana
			else
				run, Complementos\1.exe
		} else if (VersaoPrimo1 = "ScriptUnico") {
				AutoSelfMana()
		}
	} 
OutMana:

if ((Life_AutoHealing == 9) and (Mana_AutoHealing == 0))  {
	process, exist, 1.exe
	if errorlevel
		Process, Close , 1.exe
}

GuiControlGet, Energy_Ring
	If ((Energy_Ring == 1) and (Ativa_Swap = 1)) {
		if (VersaoPrimo1 = "MultiScripts") {
			process, exist, 3.exe
			if errorlevel
				goto OutUtamoEnergy
			else
				run, Complementos\3.exe
		} else if (VersaoPrimo1 = "ScriptUnico") {
			AutoSelfRing()
		}
	} else {
		process, exist, 3.exe
		if errorlevel
			Process, Close , 3.exe
	}
OutUtamoEnergy:

if (ForaPZ = 1) {	
GuiControlGet, EAT
GuiControlGet, Paralize
GuiControlGet, Haste
GuiControlGet, Boots
GuiControlGet, UtamoVita
GuiControlGet, Amulet
GuiControlGet, Ring
GuiControlGet, Quiver
GuiControlGet, PotBuff
	if (VersaoPrimo1 = "MultiScripts") {
		If ((EAT == 1) or (Paralize == 1) or (Haste == 1) or (Boots == 1) or (UtamoVita == 1) or (Amulet == 1) or (Ring == 1) or (Quiver == 1) or (PotBuff == 1)) {
			process, exist, 2.exe
			if errorlevel
				goto OutSupport
			else
				run, Complementos\2.exe
		} else {
			process, exist, 2.exe
			if errorlevel
				Process, Close , 2.exe
		}
		OutSupport:	
	} else if (VersaoPrimo1 = "ScriptUnico") {
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

GuiControlGet, SSA
GuiControlGet, MIGHT
GuiControlGet, FOODHP
GuiControlGet, FOODMP
	if (VersaoPrimo1 = "MultiScripts") {
		if ((SSA == 1) or (Ativa_TankMode = 1) or (MIGHT == 1) or (FOODHP == 1) or (FOODMP == 1)) {
			process, exist, 4.exe
			if errorlevel
				goto OutDefender
			else
				run, Complementos\4.exe
		} else {
			EquipandoSSA = 0
			process, exist, 4.exe
			if errorlevel
				Process, Close , 4.exe
		}
	OutDefender:
	} else if (VersaoPrimo1 = "ScriptUnico") {
		if (WinActive("ahk_class Qt5QWindowOwnDCIcon")) {
			if ((SSA == 1) or (Ativa_TankMode = 1)) {
				AutoSSA()
			} else {
				EquipandoSSA = 0
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
} else { ; PZ
	process, exist, 2.exe
			if errorlevel
				Process, Close , 2.exe
	process, exist, 4.exe
			if errorlevel
				Process, Close , 4.exe
} ; PZ

GuiControlGet, SIOEK 
GuiControlGet, SIORP 
	if (VersaoPrimo1 = "MultiScripts") {
		if ((SIOEK = 1) or (SIORP = 1)) {
			StatusSIO = Friend HEAL ON
			process, exist, 5.exe
			if errorlevel
				goto OutSio
			else
				run, Complementos\5.exe
		} else {
			StatusSIO = Friend HEAL OFF
			process, exist, 5.exe
			if errorlevel
				Process, Close , 5.exe
		}
	OutSio:
	} else if (VersaoPrimo1 = "ScriptUnico") {
		if ((SIOEK = 1) or (SIORP = 1)) {
			StatusSIO = Friend HEAL ON
			AutoSIO()
		} else {
			StatusSIO = Friend HEAL OFF
		}
		if ((VidaSioOK = 1) and (ManaSioOK = 1)) {
			if (SIOEK = 1) {
				AutoSIOEK()
			}
			if (SIORP = 1) {
				AutoSIORP()
			}
		}
	}

GuiControlGet, ConsecutiveFunction1 
GuiControlGet, ConsecutiveFunction2 
	if (ConsecutiveFunction1 = 1) {
		ConsecutiveFunc1()
	}
	if (ConsecutiveFunction2 = 1) {
		ConsecutiveFunc2()
	}
	
	

} else { ; Cliente na tela / nao treinando
		Process, Close , 1.exe
		Process, Close , 2.exe
		Process, Close , 4.exe
		Process, Close , 5.exe
		Process, Close , 3.exe
}
	
	if (ManaTraining == 1) {
		process, exist, 7.exe
		if errorlevel
			goto OutManaTrain
		else
			run, Complementos\7.exe

	} else {
		process, exist, 7.exe
		if errorlevel
			Process, Close , 7.exe
	}
OutManaTrain:
	
	tooltip
return


;==================================================================================
ChecaCliente() {
global
StartScripts:
GuiControlGet, HUD 
if ((WinActive("ahk_class Qt5QWindowOwnDCIcon")) and (HUD = 1)) {
	
	HUD1Y = % HUDY + 20
	HUD2Y = % HUD1Y + 20
	HUD3Y = % HUD2Y + 20
	HUD4Y = % HUD3Y + 20
	HUD5Y = % HUD4Y + 20
	
	ToolTip, %State_Pause1%, %HUDX%, %HUDY%,2
	if ( State_Pause1 <> "Status Bars Closed or hidden") {
		ToolTip, %StatusTankMode%, %HUDX%, %HUD1Y%,3
		ToolTip, %PrimoAtaqueStatus%, %HUDX%, %HUD2Y%,4
		ToolTip, %QuickLootOn%, %HUDX%, %HUD3Y%,5
		ToolTip, %StatusSIO%, %HUDX%, %HUD4Y%,6
		if (Energy_Ring = 1) {
			ToolTip, %Status_SwapRing%, %HUDX%, %HUD5Y%,7
		}
	} else {
		ToolTip,,,,3
		ToolTip,,,,4
		ToolTip,,,,5
		ToolTip,,,,6
		ToolTip,,,,7
	}
} else {
	ToolTip,,,,2
	ToolTip,,,,3
	ToolTip,,,,4
	ToolTip,,,,5
	ToolTip,,,,6
	ToolTip,,,,7
}

GuiControlGet, MouseGetPosOption
if (MouseGetPosOption = "Left Mouse"){
	MouseGetPosOption1 = LButton
} else if (MouseGetPosOption = "Right Mouse"){
	MouseGetPosOption1 = RButton
} else if (MouseGetPosOption = "Middle Mouse"){
	MouseGetPosOption1 = MButton
} else if (MouseGetPosOption = "Alt"){
	MouseGetPosOption1 = Alt
}

IfWinExist, Tibia - %Nome_Char%
{
	Cliente = 1
		process, exist, 8.exe
			if errorlevel
			Process, Close , 8.exe
			
	goto ClienteEncontrado
} Else {
	Cliente = 0
	process, exist, BUYPOT.exe
			if errorlevel
				Process, Close , BUYPOT.exe
	process, exist, 4.exe
			if errorlevel
				Process, Close , 4.exe
	process, exist, 1.exe
			if errorlevel
				Process, Close , 1.exe
	process, exist, 7.exe
			if errorlevel
				Process, Close , 7.exe
	process, exist, 6.exe
			if errorlevel
				Process, Close , 6.exe
	process, exist, 5.exe
			if errorlevel
				Process, Close , 5.exe
	process, exist, 2.exe
			if errorlevel
				Process, Close , 2.exe
	process, exist, 3.exe
			if errorlevel
				Process, Close , 3.exe
}

IfWinExist, Tibia
{
	State_Pause1 = Aguardando Login
	fecharsubrotinas()
	GuiControlGet, Auto_ReLogin
	If (Auto_ReLogin == 1) {
		process, exist, 8.exe
		if errorlevel
			goto OutReLogin
		else
			run, Complementos\8.exe

	} else {
		process, exist, 8.exe
			if errorlevel
			Process, Close , 8.exe
	}
OutReLogin:
}
ClienteEncontrado:

IfWinNotExist, ahk_class Qt5QWindowOwnDCIcon
{
	State_Pause1 = Client Closed
			process, exist, 8.exe
			if errorlevel
			Process, Close , 8.exe
}

	if (Cliente = 1) {
		Tibia_X1 = % Tibia_Width1 - 300
		Tibia_Y1 = % Tibia_Y + 600
		
		ImageSearch, FoundX, FoundY, %Tibia_X1%, %Tibia_Y%, %Tibia_Width%, %Tibia_Y1%, *50, Complementos\Imagens\%VersaoGrafico%\checaclienteaberto.png	; Checa coracao do cliente
			if (ErrorLevel = 1) {
				ImagemCliente = 0
				State_Pause1 = Status Bars Closed or hidden
				fecharsubrotinas()
			}
			if ((ErrorLevel = 0) and (ManaTraining == 0)) {
				ImagemCliente = 1	
				if (State_Pause = 0) {
					State_Pause1 = Primo Running
					if (ReloadInicial = 0) {
						SearchImages()
						ReloadInicial = 1
					}
				}
				if (State_Pause = 1) {
					State_Pause1 = Primo Paused
					QuickLootOn = Looter Off
				}
			}
			if (ManaTraining == 1) {
				State_Pause1 = Primo Training
				QuickLootOn = Looter Off	
			}
	} ; Cliente OK
} ; Checa Cliente
;==================================================================================
RotinaContinua() {
global

ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\pz.png		;Checa se esta fora do PZ	
	if (ErrorLevel = 1){
		ForaPZ = 1
	}
	if (ErrorLevel = 0){
		ForaPZ = 0
			Ativa_QuickLoot = 0
			Ativa_QuickLoot_Perm = 0
	}



;==================================================================================	
;==================================================================================	Primo Ataque
;==================================================================================

GuiControlGet, AtkRune1
GuiControlGet, AtkRune2
GuiControlGet, AtkRotacao1
GuiControlGet, AtkRotacao2
GuiControlGet, Hotkey_ATK
GuiControlGet, TipoAtaque
GuiControlGet, TipoTarget


if (TipoAtaque = "Rune1") {
	AtkRune1 = 1
} else {  
	AtkRune1 = 0
} 

if (TipoAtaque = "Rune2") {
	AtkRune2 = 1
} else {  
	AtkRune2 = 0
} 

if (TipoAtaque = "Rotacao1") {
	AtkRotacao1 = 1
} else {  
	AtkRotacao1 = 0
} 

if (TipoAtaque = "Rotacao2") {
	AtkRotacao2 = 1
} else {  
	AtkRotacao2 = 0
}

} ; Fim Rotina Continua

;==================================================================================
EnviaNumGui:
;Status Geral
ControlSetText,, %State_Pause1%, ahk_id %ScriptPausado%
;Status Primo Ataque
ControlSetText,, %PrimoAtaqueStatus%, ahk_id %StatusAtaque%
;Status Quick Loot
ControlSetText,, %QuickLootOn%, ahk_id %StatusLooter%
;Status Tank Mode
ControlSetText,, %StatusTankMode%, ahk_id %StatusTank%

; Validade
ControlSetText,, %msgvalidade%, ahk_id %myedit%

;Pos 11
ControlSetText,, %GetPosLoot11X%, ahk_id %Xguipos11%
ControlSetText,, %GetPosLoot11Y%, ahk_id %Yguipos11%
;Pos 12
ControlSetText,, %GetPosLoot12X%, ahk_id %Xguipos12%
ControlSetText,, %GetPosLoot12Y%, ahk_id %Yguipos12%
;Pos 13
ControlSetText,, %GetPosLoot13X%, ahk_id %Xguipos13%
ControlSetText,, %GetPosLoot13Y%, ahk_id %Yguipos13%

;Pos 21
ControlSetText,, %GetPosLoot21X%, ahk_id %Xguipos21%
ControlSetText,, %GetPosLoot21Y%, ahk_id %Yguipos21%
;Pos 22
ControlSetText,, %GetPosLoot12X%, ahk_id %Xguipos22%
ControlSetText,, %GetPosLoot22Y%, ahk_id %Yguipos22%
;Pos 23
ControlSetText,, %GetPosLoot23X%, ahk_id %Xguipos23%
ControlSetText,, %GetPosLoot23Y%, ahk_id %Yguipos23%

;Pos 31
ControlSetText,, %GetPosLoot31X%, ahk_id %Xguipos31%
ControlSetText,, %GetPosLoot31Y%, ahk_id %Yguipos31%
;Pos 32
ControlSetText,, %GetPosLoot32X%, ahk_id %Xguipos32%
ControlSetText,, %GetPosLoot32Y%, ahk_id %Yguipos32%
;Pos 33
ControlSetText,, %GetPosLoot33X%, ahk_id %Xguipos33%
ControlSetText,, %GetPosLoot33Y%, ahk_id %Yguipos33%

;POS1 PUSH
ControlSetText,, %PosPushX1%, ahk_id %Pos1PushX%
ControlSetText,, %PosPushY1%, ahk_id %Pos1PushY%
;POS2 PUSH
ControlSetText,, %PosPushX2%, ahk_id %Pos2PushX%
ControlSetText,, %PosPushY2%, ahk_id %Pos2PushY%

	ControlSetText,, %GetPosTrash2X%, ahk_id %GUIGetPosTrash2X%
	ControlSetText,, %GetPosTrash2Y%, ahk_id %GUIGetPosTrash2Y%
	ControlSetText,, %GetPosTrash1X%, ahk_id %GUIGetPosTrash1X%
	ControlSetText,, %GetPosTrash1Y%, ahk_id %GUIGetPosTrash1Y%
	ControlSetText,, %GetPosFlowerX%, ahk_id %GUIFlowerX%
	ControlSetText,, %GetPosFlowerY%, ahk_id %GUIFlowerY%
	ControlSetText,, %PushItemBPX%, ahk_id %GUIPushItemBPX%
	ControlSetText,, %PushItemBPY%, ahk_id %GUIPushItemBPY%
	
	

IniRead, TimerManaTrain, %EndConfigSuporte%.ini, ManaTraining, TimerManaTrain
IniRead, TimerExercise, %EndConfigSuporte%.ini, ManaTraining, TimerExercise
IniRead, TimerBUYPOT, %EndConfigSuporte%.ini, ManaTraining, TimerBUYPOT

ControlSetText,, %TimerManaTrain%, ahk_id %TimerManaTrain1%
ControlSetText,, %TimerExercise%, ahk_id %TimerExercise1%
ControlSetText,, %TimerBUYPOT%, ahk_id %TimerBUYPOT1%

ControlSetText,, %GetPosDummyX%, ahk_id %GuiGetPosDummyX%
ControlSetText,, %GetPosDummyY%, ahk_id %GuiGetPosDummyY%


ControlSetText,, %PosConsecutive1X%, ahk_id %GuiPosConsecutive1X%
ControlSetText,, %PosConsecutive1Y%, ahk_id %GuiPosConsecutive1Y%
return
;==================================================================================
;================================================================================== Tank Mode
;==================================================================================
TankMode_Func:
	if (Ativa_TankMode = 0) {
		StatusTankMode = Tank Mode ON
		Ativa_TankMode = 1	
		;tooltip Tank Mode - ON, %XTooltip%,%YTooltip%
		sleep 200
		return
	}
	if (Ativa_TankMode = 1) {
		StatusTankMode = Tank Mode OFF
		Ativa_TankMode = 0	
		;tooltip Tank Mode - OFF, %XTooltip%,%YTooltip%
		sleep 300
	}
return

;==================================================================================
;================================================================================== Ataque Mode
;==================================================================================
Ativa_Ataque:
	if ((Ativa_Atk = 0) and (ForaPZ = 1)) {
		;tooltip Primo Ataque [ON]
		PrimoAtaqueStatus = Ataque Ligado
		Ativa_Atk = 1
		sleep 200
		return
	}
	if (Ativa_Atk = 1) {
		PrimoAtaqueStatus = Ataque Desligado
		;tooltip Primo Ataque [OFF]
		Ativa_Atk = 0
		sleep 200
	}
return


;==================================================================================
;================================================================================== Checa Validade
;==================================================================================
CheckDate() {
Global
checkdateagain:
UrlDownloadToFile, 					https://primomarcos.com/last_login.php?user=%User%, 		login.ini
FileDelete,		login.ini
	
FileDelete, 	%Address%
FileDelete,		Data.ini
;FileDelete,		Versions.ini


UrlDownloadToFile, 					%URLUser%%User%, 	%Address%
UrlDownloadToFile, 					%URLData%, 			Data.ini
;UrlDownloadToFile, 					%URLVersion%, 		Versions.ini


FileReadLine, Date_until, 									%Address%, 3
FileReadLine, Status_WEB_User,								%Address%, 4
FileReadLine, UUID_File,									%Address%, 5
FileReadLine, UUID_File1,									%Address%, 6
FileReadLine, UUID_File2,									%Address%, 7

FileReadLine, CheckFileDate, 								Data.ini, 1
FileReadLine, Data_Hoje, 									Data.ini, 2

;FileReadLine, Versao_Web, 									Versions.ini, 2
;FileReadLine, Versao_Beta,									Versions.ini, 3
;FileReadLine, Versao_Launcher,								Versions.ini, 4
;FileReadLine, URLDownload, 								Versions.ini, 5
;FileReadLine, URL_ID, 										Versions.ini, 6

	if !FileExist("Data.ini"){
		Gui, -AlwaysOnTop
			msgbox, Não foi Possivel Validar a Data Atual`nContate o Fornecedor
			exitapp
	}
	
FileDelete,		%Address%
FileDelete,		Data.ini
;FileDelete,		Versions.ini

DifDate = %Date_until%

EnvSub, DifDate, %Data_Hoje%, days

if (DifDate > 1) {
	 msgvalidade = Voce tem mais %DifDate% dias de uso!
} else if (DifDate = 1) {
	 msgvalidade = Voce tem mais 2 dias de uso!
} else if (DifDate = 0) {
	 msgvalidade = Voce tem mais 1 dia de uso!
} else if (DifDate < 0) {
	 msgvalidade = Contrato Expirado
}

	if (Data_Hoje>Date_until) {
		Gui, -AlwaysOnTop
				msgbox, Seu Contato Expirou.`nEntre em contato com o Fornecedor.
		exitapp
	}
	if (Status_WEB_User <> "Ativo") {
		Gui, -AlwaysOnTop
				msgbox, Seu Usuario esta Desativado.`nEntre em contato com o Fornecedor.
		exitapp
	}
}


;==================================================================================
AutoSelfRing() {
global
GuiControlGet, Percent_Life_Equip_Energy
GuiControlGet, Percent_Life_DeEquip_Energy
GuiControlGet, Percent_Mana_Equip_Energy
GuiControlGet, Percent_Mana_DeEquip_Energy
GuiControlGet, Hotkey_Energy_Ring
GuiControlGet, Hotkey_DeEnergy_Ring
GuiControlGet, TipoMagicShield

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
			ImageSearch, FoundX, FoundY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\Utamo.png	; CHECA SE ESTA DE UTAMO
			if (ErrorLevel = 0) {
				ImageSearch, FirstStageX, FirstStageY, 0, 0, A_ScreenWidth, A_ScreenHeight, *15, Complementos\Imagens\%VersaoGrafico%\ExanaVitaCD.png		;Checa se tem cool down do exana vita
				if (ErrorLevel = 0){	
					ControlSend,, {%Hotkey_DeEnergy_Ring%}, ahk_pid %Actual_PID% ;
				}			
			}
		}
		if ((CorLifeEquipe != CorDaVida) and (CorManaMinEquip == CorDaMana)) {
			ImageSearch, FoundX, FoundY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\Utamo.png	; CHECA SE ESTA DE UTAMO
			if (ErrorLevel = 1) {
				ImageSearch, FirstStageX, FirstStageY, 0, 0, A_ScreenWidth, A_ScreenHeight, *15, Complementos\Imagens\%VersaoGrafico%\UtamoCD.png		;Checa se tem cool down de utamo vita
				if (ErrorLevel = 0) {	
					ControlSend,, {%Hotkey_Energy_Ring%}, ahk_pid %Actual_PID% 
				}
			}
		}
	} 
	if (TipoMagicShield = "Energy Ring") {	
		if ((CorLifeDeEquipe == CorDaVida) or (CorManaDeEquip != CorDaMana)) {
			ImageSearch, FoundX, FoundY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\utamo_ring.png	; CHECA SE ESTA DE ENERGY RING
			if (ErrorLevel = 0) {
				ControlSend,, {%Hotkey_DeEnergy_Ring%}, ahk_pid %Actual_PID% 
				PuxandoEnergyRing = 0
			}
		}
		if ((CorLifeEquipe != CorDaVida) and (CorManaMinEquip == CorDaMana)) {	
			ImageSearch, FoundX, FoundY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\utamo_ring.png	; CHECA SE ESTA DE ENERGY RING
			if (ErrorLevel = 1) {
				ControlSend,, {%Hotkey_Energy_Ring%}, ahk_pid %Actual_PID% ; ENERGY RING
				PuxandoEnergyRing = 1
			}
		}
	}		
} ; Fim Energy Ring Utamo
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
				ControlSend,, {%Hotkey_Mana_Stage1%}, ahk_pid %Actual_PID% ; POT MANA
				sleep 200
			}	
	}
}
;==================================================================================
AutoEat() {
global
GuiControlGet, Hotkey_Eat
	ImageSearch,  FoundX, FoundY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\Fome.png		;Checa se esta com fome
		if (ErrorLevel = 0){
			send {%Hotkey_Eat%} ; Come food
		}
} ; Auto Eat fim
;==================================================================================
AutoParalyze() {
global
GuiControlGet, Hotkey_Paralize
GuiControlGet, RPUTITADO
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\Paralize.png		;Checa se esta paralizado 
		if (ErrorLevel = 0){
			if (RPUTITADO = 1){
			ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\Buff.png		;Checa se esta sem Buff
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
GuiControlGet, Hotkey_Haste
GuiControlGet, RPUTITADO

	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\Haste.png		;Checa se nao esta com haste
		if (ErrorLevel = 1){
			if (RPUTITADO = 1){
			ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\Buff.png		;Checa se esta sem Buff
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
GuiControlGet, Hotkey_Boots
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\NoBoots.png		;Checa se nao esta sem boots
		if (ErrorLevel = 0){
			if (WinActive("ahk_class Qt5QWindowOwnDCIcon")) {
				send {%Hotkey_Boots%} ; Auto Renew Boots
					sleep 40
			}
		}
} ; Fim Auto Boots
;==================================================================================
AutoUtamo() {
global
GuiControlGet, PotUtamoVita
GuiControlGet, TipoUtamo
GuiControlGet, Hotkey_Utamo
GuiControlGet, Hotkey_PotUtamo
	if (TipoUtamo = "GLOBAL") {
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\Utamo.png		;Checa se esta de Utamo
		if (ErrorLevel = 0) {	
			goto LabelUtamoOut
		}
	ImageSearch, FirstStageX, FirstStageY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *15, Complementos\Imagens\%VersaoGrafico%\UtamoCD.png	;Checa se tem cool down de utamo vita
		if (ErrorLevel = 1){	
			goto LabelPotUtamo
		}
			
	}

	if (TipoUtamo = "OT") {
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\utamo_ring.png		;Checa se esta de Utamo
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
GuiControlGet, Amulet_Hotkey
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\NoAmulet.png		;Checa se esta sem amuleto
		if (ErrorLevel = 0){		
			send {%Amulet_Hotkey%} ;  Hotkey Amulet
		}
} ; Fim Auto Amulet
;==================================================================================
AutoRing() {
global	
GuiControlGet, Hotkey_Ring
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\NoRing.png		;Checa se esta sem RING
		if (ErrorLevel = 0){		
			send {%Hotkey_Ring%} ;  Hotkey Ring
				sleep 40
		}
} ;  Fim Auto Ring
;==================================================================================
AutoQuiver() {
global	
GuiControlGet, Hotkey_Quiver
	ImageSearch, QuiverX, QuiverY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *25, Complementos\Imagens\%VersaoGrafico%\Quiver.png		;Checa se Quiver esta zerado
		if (ErrorLevel = 0){
			MouseGetPos  MousePosXPush, MousePosYPush
				SendEvent ^{Click %QuiverX% %QuiverY% Down}
				SendEvent ^{Click %XTooltip% %YTooltip% Up}
			MouseMove MousePosXPush, MousePosYPush
			goto quiverlabel
		}
	ImageSearch, QuiverX, QuiverY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *25, Complementos\Imagens\%VersaoGrafico%\Red Quiver.png		;Checa se Quiver esta zerado
		if (ErrorLevel = 0){
			MouseGetPos  MousePosXPush, MousePosYPush
				SendEvent ^{Click %QuiverX% %QuiverY% Down}
				SendEvent ^{Click %XTooltip% %YTooltip% Up}
			MouseMove MousePosXPush, MousePosYPush
			goto quiverlabel
		}
	ImageSearch, QuiverX, QuiverY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *25, Complementos\Imagens\%VersaoGrafico%\Blue Quiver.png		;Checa se Quiver esta zerado
		if (ErrorLevel = 0){
			MouseGetPos  MousePosXPush, MousePosYPush
				SendEvent ^{Click %QuiverX% %QuiverY% Down}
				SendEvent ^{Click %XTooltip% %YTooltip% Up}
			MouseMove MousePosXPush, MousePosYPush
			goto quiverlabel
		}		
	quiverlabel:
	ImageSearch, QuiverX, QuiverY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *25, Complementos\Imagens\%VersaoGrafico%\ShieldVazio.png		;Checa se Quiver esta zerado
		if (ErrorLevel = 0){
			send {%Hotkey_Quiver%} ;  Hotkey Quiver
		}
} ;  Fim Auto Quiver
;==================================================================================
AutoBuff() {
global	
GuiControlGet, Hotkey_PotBuff
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\Buff.png		;Checa se esta sem Buff
		if (ErrorLevel = 1){		
			Send {%Hotkey_PotBuff%} ;  Hotkey Buff
				sleep 300
		}
} ; Fim Auto Buff
;==================================================================================
AutoSSA() {
global
GuiControlGet, Tank_Amulet
GuiControlGet, SSA_Hotkey
GuiControlGet, SSA_Life
GuiControlGet, SSA_Mana
GuiControlGet, DelaySSAMIGHT

	if (Tank_Amulet = "SSA") {
		ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\SSA.png
			if (ErrorLevel = 1){
				SemTankAmulet = 1
					if (Ativa_TankMode = 1) {
						send {%SSA_Hotkey%} ;  Hotkey SSA
						EquipandoSSA = 1
						sleep %DelaySSAMIGHT%
						goto saidaSSA
					} else {
						EquipandoSSA = 0
					}
			}
			if (ErrorLevel = 0){
				SemTankAmulet = 0
			}
	}
	if (Tank_Amulet = "Leviathan") {
		ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\Leviathan.png
			if (ErrorLevel = 1){
				SemTankAmulet = 1
			}
			if (ErrorLevel = 0){
				SemTankAmulet = 0
			}
	}
	if (Tank_Amulet = "Sacred") {
		ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\Sacred.png
			if (ErrorLevel = 1){
				SemTankAmulet = 1
			}
			if (ErrorLevel = 0){
				SemTankAmulet = 0
			}
	}
	if (Tank_Amulet = "Shockwave") {
		ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\PrismaticAmulet.png ; Se estiver de Prismatic, vai puxar o outro
			if (ErrorLevel = 0){
				SemTankAmulet = 1
										goto PuxarTankAmulet
			}	
			if (ErrorLevel = 1){
				SemTankAmulet = 0
			}
		ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\lightningPendu.png ; Se estiver de lightning Pendulant, vai puxar o outro
			if (ErrorLevel = 0){
				SemTankAmulet = 1
										goto PuxarTankAmulet
			}	
			if (ErrorLevel = 1){
				SemTankAmulet = 0
			}	
		
		ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\NoAmulet.png		;Checa se esta sem amuleto
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
GuiControlGet, ForcaMight
GuiControlGet, Might_Hotkey
GuiControlGet, MIGHT_Life
GuiControlGet, Might_Mana
GuiControlGet, DelaySSAMIGHT


	NoRingEquip = 0
	MightEquip = 0
	
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\NoRing.png		;Checa se esta com MIGHT RING
	if (ErrorLevel = 0){
		NoRingEquip = 1
	}
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\%VersaoGrafico%\Might.png
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
GuiControlGet, PercentFOODHP 
GuiControlGet, HotkeyFOODHP 
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
GuiControlGet, PercentFOODMP 
GuiControlGet, HotkeyFOODMP 

	CoordFOODMP = %  XInicioMana + ((manawidth * PercentFOODMP) // 100)
	PixelGetColor, CorFOODMP, %CoordFOODMP%, %YMana%, RGB ; 
		if (CorFOODMP != CorDaMana){ 
			send {%HotkeyFOODMP%} ; FOOD MP
				sleep 200
		}
} ; Fim Food MP
;==================================================================================
AutoSIO() {
global
GuiControlGet, PercentSelfHealth 
GuiControlGet, PercentSelfMana 
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
GuiControlGet, UHEK
GuiControlGet, PercentSIO1
GuiControlGet, PercentGranSIO1
	PixelSearch, Px, Py, %Xini_Char_tela_1%, %Yini_Char_tela_1%, %Xfim_Char_tela_1%, %Yfim_Char_tela_1%, 0xC0C0C0, 0, FAST RGB ; Confere char na tela
		if (ErrorLevel = 0){	
			PixelVidaParty2 = %  Xini_Life_PT1 + ((129 * PercentGranSIO1) // 100)
			PixelGetColor, CorVidaParty2, %PixelVidaParty2%, %Yref_Life_PT1%, RGB
			if ((CorVidaParty2 !="0x00C000") and (CorVidaParty2 !="0x60C060") and (CorVidaParty2 !="0xC0C000") and (CorVidaParty2 !="0xC03030") and (CorVidaParty2 !="0xC00000")){ 
					if (HealFriend1 = "SIO") {
						ControlSend,, {%Hotkey_GranSio_1%}, ahk_pid %Actual_PID% ; Exura Gran Sio
					}
				}
			PixelVidaParty1 = %  Xini_Life_PT1 + ((129 * PercentSIO1) // 100)
			PixelGetColor, CorVidaParty1, %PixelVidaParty1%, %Yref_Life_PT1%, RGB
				if ((CorVidaParty1 !="0x00C000") and (CorVidaParty1 !="0x60C060") and (CorVidaParty1 !="0xC0C000") and (CorVidaParty1 !="0xC03030") and (CorVidaParty1 !="0xC00000")){ 
					if (HealFriend1 = "SIO") {
						ControlSend,, {%Hotkey_Sio_1%}, ahk_pid %Actual_PID% ; Exura Sio
					}
					if (HealFriend1 = "UH") {
						MouseGetPos  MousePosX, MousePosY
						ControlSend,, {%Hotkey_Sio_1%}, ahk_pid %Actual_PID% ; Hotkey que esta UH
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
GuiControlGet, UHRP
GuiControlGet, PercentSIO3
	PixelSearch, Px, Py, %Xini_Char_tela_3%, %Yini_Char_tela_3%, %Xfim_Char_tela_3%, %Yfim_Char_tela_3%, 0xC0C0C0, 0, FAST RGB ; Confere char na tela
		if (ErrorLevel = 0){	
			PixelVidaParty3 = %  Xini_Life_PT3 + ((129 * PercentSIO3) // 100)
			PixelGetColor, CorVidaParty3, %PixelVidaParty3%, %Yref_Life_PT3%, RGB
				if ((CorVidaParty3 !="0x00C000") and (CorVidaParty3 !="0x60C060") and (CorVidaParty3 !="0xC0C000") and (CorVidaParty3 !="0xC03030") and (CorVidaParty3 !="0xC00000")){ 
					if (HealFriend2 = "SIO") {
						ControlSend,, {%Hotkey_Sio_2%}, ahk_pid %Actual_PID% ; Exura Sio
					}
					if (HealFriend2 = "UH") {
						MouseGetPos  MousePosX, MousePosY
						ControlSend,, {%Hotkey_Sio_2%}, ahk_pid %Actual_PID% ; Hotkey que esta UH
							sleep 50
						MouseClick, left, %Xref_Life_PT1%, %Yref_Life_PT3%
							Sleep 50
						MouseMove MousePosX, MousePosY
					}
				}
		}
} ; Fim Sio RP
;================================================================================Function 1
ConsecutiveFunc1() {
global
GuiControlGet, Delay_Consecutive1 
GuiControlGet, Hotkey_Consecutive1 
Delay_Consecutive1 = % Delay_Consecutive1 - 1

if (TimerConsecutive1 >= Delay_Consecutive1) {
		TimerConsecutive1 = 1
	} else {
		TimerConsecutive1 = % TimerConsecutive1 + 1
	}

	if (TimerConsecutive1 = 1) {
		;MouseGetPos  MousePosX, MousePosY
		ControlSend,, {%Hotkey_Consecutive1%}, ahk_pid %Actual_PID% 
		sleep 50
		ControlClick,  x%PosConsecutive1X% y%PosConsecutive1Y% , ahk_pid %Actual_PID% ,, LEFT,, Pos.
		;MouseClick, left, %PosConsecutive1X%, %PosConsecutive1Y%
		;MouseMove MousePosX, MousePosY
	}	
}
;================================================================================Function 2
ConsecutiveFunc2() {
global
GuiControlGet, Delay_Consecutive2
GuiControlGet, Hotkey_Consecutive2 
Delay_Consecutive2 = % Delay_Consecutive2 * 4

if (TimerConsecutive2 >= Delay_Consecutive2) {
		TimerConsecutive2 = 1
	} else {
		TimerConsecutive2 = % TimerConsecutive2 + 1
	}

	if (TimerConsecutive2 = 1) {
		ControlSend,, {%Hotkey_Consecutive2%}, ahk_pid %Actual_PID% 
	}
}

;==================================================================================
;================================================================================== Swap Utamo Vita / Energy Ring
;==================================================================================
Swap_Ring_Utamo:
	IF (Ativa_Swap = 0) {
		Ativa_Swap = 1
	} else {
		Ativa_Swap = 0
	}
return

;==================================================================================
;================================================================================== Quick Loot
;==================================================================================
QuickLooter_Active:
	if ((Ativa_QuickLoot_Perm = 0) and (ForaPZ = 1)) {
		Ativa_QuickLoot_Perm = 1	
		;tooltip QuickLoot - ON, %XTooltip%,%YTooltip%
		sleep 200
		return
	}
	if (Ativa_QuickLoot_Perm = 1) {
		Ativa_QuickLoot_Perm = 0	
		;tooltip QuickLoot - OFF, %XTooltip%,%YTooltip%
		sleep 500
	}
return

QuickLooter(){
global
QuickLooter:
GuiControlGet, KeyQuickLootTibia

	if (KeyQuickLootTibia = "RIGHT") {
		ControlClick,  x%GetPosLoot11X% y%GetPosLoot11Y% , ahk_pid %Actual_PID% ,, RIGHT,, Pos.
		sleep %DelayLoot%
		ControlClick,  x%GetPosLoot12X% y%GetPosLoot12Y% , ahk_pid %Actual_PID% ,, RIGHT,, Pos.
		sleep %DelayLoot%
		ControlClick,  x%GetPosLoot13X% y%GetPosLoot13Y% , ahk_pid %Actual_PID% ,, RIGHT,, Pos.
		sleep %DelayLoot%
		ControlClick,  x%GetPosLoot21X% y%GetPosLoot21Y% , ahk_pid %Actual_PID% ,, RIGHT,, Pos.
		sleep %DelayLoot%
		ControlClick,  x%GetPosLoot22X% y%GetPosLoot22Y% , ahk_pid %Actual_PID% ,, RIGHT,, Pos.
		sleep %DelayLoot%
		ControlClick,  x%GetPosLoot23X% y%GetPosLoot23Y% , ahk_pid %Actual_PID% ,, RIGHT,, Pos.
		sleep %DelayLoot%
		ControlClick,  x%GetPosLoot31X% y%GetPosLoot31Y% , ahk_pid %Actual_PID% ,, RIGHT,, Pos.
		sleep %DelayLoot%
		ControlClick,  x%GetPosLoot32X% y%GetPosLoot32Y% , ahk_pid %Actual_PID% ,, RIGHT,, Pos.
		sleep %DelayLoot%
		ControlClick,  x%GetPosLoot33X% y%GetPosLoot33Y% , ahk_pid %Actual_PID% ,, RIGHT,, Pos.
		sleep %DelayLoot%
	} else if (KeyQuickLootTibia = "LEFT") {
		ControlClick,  x%GetPosLoot11X% y%GetPosLoot11Y% , ahk_pid %Actual_PID% ,, LEFT,, Pos.
		sleep %DelayLoot%
		ControlClick,  x%GetPosLoot12X% y%GetPosLoot12Y% , ahk_pid %Actual_PID% ,, LEFT,, Pos.
		sleep %DelayLoot%
		ControlClick,  x%GetPosLoot13X% y%GetPosLoot13Y% , ahk_pid %Actual_PID% ,, LEFT,, Pos.
		sleep %DelayLoot%
		ControlClick,  x%GetPosLoot21X% y%GetPosLoot21Y% , ahk_pid %Actual_PID% ,, LEFT,, Pos.
		sleep %DelayLoot%
		ControlClick,  x%GetPosLoot22X% y%GetPosLoot22Y% , ahk_pid %Actual_PID% ,, LEFT,, Pos.
		sleep %DelayLoot%
		ControlClick,  x%GetPosLoot23X% y%GetPosLoot23Y% , ahk_pid %Actual_PID% ,, LEFT,, Pos.
		sleep %DelayLoot%
		ControlClick,  x%GetPosLoot31X% y%GetPosLoot31Y% , ahk_pid %Actual_PID% ,, LEFT,, Pos.
		sleep %DelayLoot%
		ControlClick,  x%GetPosLoot32X% y%GetPosLoot32Y% , ahk_pid %Actual_PID% ,, LEFT,, Pos.
		sleep %DelayLoot%
		ControlClick,  x%GetPosLoot33X% y%GetPosLoot33Y% , ahk_pid %Actual_PID% ,, LEFT,, Pos.
		sleep %DelayLoot%
	} else if (KeyQuickLootTibia = "SHIFT_RIGHT") {
		send, {shift Down}
		ControlClick,  x%GetPosLoot11X% y%GetPosLoot11Y% , ahk_pid %Actual_PID% ,, RIGHT,, Pos.
		send, {shift Up}
		sleep %DelayLoot%
		send, {shift Down}
		ControlClick,  x%GetPosLoot12X% y%GetPosLoot12Y% , ahk_pid %Actual_PID% ,, RIGHT,, Pos.
		send, {shift Up}
		sleep %DelayLoot%
		send, {shift Down}
		ControlClick,  x%GetPosLoot13X% y%GetPosLoot13Y% , ahk_pid %Actual_PID% ,, RIGHT,, Pos.
		send, {shift Up}
		sleep %DelayLoot%
		send, {shift Down}
		ControlClick,  x%GetPosLoot21X% y%GetPosLoot21Y% , ahk_pid %Actual_PID% ,, RIGHT,, Pos.
		send, {shift Up}
		sleep %DelayLoot%
		send, {shift Down}
		ControlClick,  x%GetPosLoot22X% y%GetPosLoot22Y% , ahk_pid %Actual_PID% ,, RIGHT,, Pos.
		send, {shift Up}
		sleep %DelayLoot%
		send, {shift Down}
		ControlClick,  x%GetPosLoot23X% y%GetPosLoot23Y% , ahk_pid %Actual_PID% ,, RIGHT,, Pos.
		send, {shift Up}
		sleep %DelayLoot%
		send, {shift Down}
		ControlClick,  x%GetPosLoot31X% y%GetPosLoot31Y% , ahk_pid %Actual_PID% ,, RIGHT,, Pos.
		send, {shift Up}
		sleep %DelayLoot%
		send, {shift Down}
		ControlClick,  x%GetPosLoot32X% y%GetPosLoot32Y% , ahk_pid %Actual_PID% ,, RIGHT,, Pos.
		send, {shift Up}
		sleep %DelayLoot%
		send, {shift Down}
		ControlClick,  x%GetPosLoot33X% y%GetPosLoot33Y% , ahk_pid %Actual_PID% ,, RIGHT,, Pos.
		send, {shift Up}
		sleep %DelayLoot%
	}
Ativa_QuickLoot = 0
return
} ; Fim Quick Loot

DesligaQuickLoot:
	Ativa_QuickLoot = 0
	Ativa_QuickLoot_Perm = 0
	send, {shift Up}
return

GetPosLoot11:
	tooltip  %MouseGetPosOption% CLICK NO CENTRO DO SQM NORTE ESQUERDO
	KeyWait, %MouseGetPosOption1%, D
	MouseGetPos, GetPosLoot11X, GetPosLoot11Y
	tooltip Pos 1 OK
	sleep 300
	GetPosLoot21X = %GetPosLoot11X%
	GetPosLoot31X = %GetPosLoot11X%
	GetPosLoot12Y = %GetPosLoot11Y%
	GetPosLoot13Y = %GetPosLoot11Y%
return

GetPosLoot22:
	tooltip %MouseGetPosOption% CLICK NO CENTRO DO SQM DO CHAR
	KeyWait, %MouseGetPosOption1%, D
	MouseGetPos, GetPosLoot22X, GetPosLoot22Y
	tooltip Pos 2 OK
	sleep 300
	GetPosLoot12X = %GetPosLoot22X%
	GetPosLoot32X = %GetPosLoot22X%
	GetPosLoot21Y = %GetPosLoot22Y%
	GetPosLoot23Y = %GetPosLoot22Y%
return

GetPosLoot33:
	tooltip %MouseGetPosOption% CLICK NO CENTRO DO SQM SUL DIREITO
	KeyWait, %MouseGetPosOption1%, D
	MouseGetPos, GetPosLoot33X, GetPosLoot33Y
	tooltip Pos 3 OK
	sleep 300
	GetPosLoot13X = %GetPosLoot33X%
	GetPosLoot23X = %GetPosLoot33X%
	GetPosLoot31Y = %GetPosLoot33Y%
	GetPosLoot32Y = %GetPosLoot33Y%
return
;==================================================================================
;================================================================================== Get HUD
;==================================================================================

Coordinates_HUD:
	tooltip %MouseGetPosOption% CLICK ONDE DESEJA COLOCAR O HUD
	KeyWait, %MouseGetPosOption1%, D
	MouseGetPos, HUDX, HUDY
	tooltip Pos OK
	sleep 300
return

;==================================================================================
;================================================================================== Get Push Pos
;==================================================================================
Push_Func:
GuiControlGet, Push
	if ((Ativa_Push = 0) and (PosPushX1 > 0) and (PosPushX2 > 0)) {
		Ativa_Push = 1	
		tooltip Push - ON
		return
	}
	if (Ativa_Push = 1) {
		Ativa_Push = 0	
		tooltip Push - OFF
		tooltip
	}
return

Push_Func1() {	
global 
	if (WinActive("ahk_class Qt5QWindowOwnDCIcon")) {
		MouseGetPos  MousePosXPush, MousePosYPush
			SendEvent ^{Click %PosPushX1% %PosPushY1% Down}
			SendEvent ^{Click %PosPushX2% %PosPushY2% Up}
		MouseMove MousePosXPush, MousePosYPush
		sleep 15
	}
}

GetPosPush:
	tooltip APERTE ALT NA POSICAO ORIGEM`nAPÓS CONFIRMAÇÃO DA POS 1`nAPERTAR ALT DE NOVO PARA POS 2
	KeyWait, Alt, D
	MouseGetPos, PosPushX1, PosPushY1
	tooltip Pos Push 1 OK
	sleep 500
	KeyWait, Alt, D
	MouseGetPos, PosPushX2, PosPushY2
	tooltip Pos Push 2 OK
	sleep 500
	tooltip
return

ClearPosPush:
	PosPushX1 = 0
	PosPushY1 = 0
	PosPushX2 = 0
	PosPushY2 = 0
return

;==================================================================================
;================================================================================== Consecutive Function
;==================================================================================
GetPosConsecutive:
	tooltip %MouseGetPosOption% CLICK NO SQM DESEJADO
	KeyWait, %MouseGetPosOption1%, D
	MouseGetPos, PosConsecutive1X, PosConsecutive1Y
	tooltip Pos OK
	sleep 1000
return

;==================================================================================
;================================================================================== Exercise
;==================================================================================
ExercisePos:
	tooltip %MouseGetPosOption% CLICK NO Dummy
	KeyWait, %MouseGetPosOption1%, D
	MouseGetPos, GetPosDummyX, GetPosDummyY
	tooltip Pos Dummy OK
	sleep 1000
return

;==================================================================================
;================================================================================== PVPs Functions
;==================================================================================
SelectCoordinatesFlower:
	tooltip %MouseGetPosOption% CLICK na posicao FIXA da Flower na backpack.
	KeyWait, %MouseGetPosOption1%, D
	MouseGetPos, GetPosFlowerX, GetPosFlowerY
	tooltip Pos OK
	sleep 1000
return

FlowerOnMouse:
GuiControlGet, Flower
if (Flower == 1) {
MouseGetPos, StartX, StartY
SendEvent +{Click %GetPosFlowerX% %GetPosFlowerY% Down}
SendEvent +{Click %StartX% %StartY% Up}	
}
return
;==================================================================================

SelectCoordinatesTrash1:
	tooltip %MouseGetPosOption% CLICK na posicao FIXA do Trash1 na backpack.
	KeyWait, %MouseGetPosOption1%, D
	MouseGetPos, GetPosTrash1X, GetPosTrash1Y
	tooltip Pos OK
	sleep 1000
return

SelectCoordinatesTrash2:
	tooltip %MouseGetPosOption% CLICK na posicao FIXA do Trash2 na backpack.
	KeyWait, %MouseGetPosOption1%, D
	MouseGetPos, GetPosTrash2X, GetPosTrash2Y
	tooltip Pos OK
	sleep 1000
return

TrashOnMouse:
GuiControlGet, Trash1
GuiControlGet, Trash2
GuiControlGet, OpcaoTrash
MouseGetPos, StartX, StartY

if (Trash1 == 1) {
	SendEvent +{Click %GetPosTrash1X% %GetPosTrash1Y% Down}
	if (OpcaoTrash = "Pe") {
		SendEvent +{Click %GetPosLoot22X% %GetPosLoot22Y% Up}
	} else {
		SendEvent +{Click %StartX% %StartY% Up}	
	}
}
Sleep 150
if (Trash2 == 1) {
	SendEvent +{Click %GetPosTrash2X% %GetPosTrash2Y% Down}
	if (OpcaoTrash = "Pe") {
		SendEvent +{Click %GetPosLoot22X% %GetPosLoot22Y% Up}
	} else {
		SendEvent +{Click %StartX% %StartY% Up}	
	}
}
return

;==================================================================================
SelectCoordinatesPushItem:
	tooltip %MouseGetPosOption% CLICK na posicao FIXA do da backpack.
	KeyWait, %MouseGetPosOption1%, D
	MouseGetPos, PushItemBPX, PushItemBPY
	tooltip Pos OK
	sleep 1000
return

PushItemOnBP:
GuiControlGet, PushItem
if (PushItem == 1) {
MouseGetPos, StartX, StartY
SendEvent ^{Click %StartX% %StartY% Down}	
SendEvent ^{Click %PushItemBPX% %PushItemBPY% Up}	
MouseMove, %StartX%, %StartY%
sleep 50
MouseMove, %StartX%, %StartY%
}
return
;==================================================================================
;================================================================================== Atalhos
;==================================================================================

^!a::
MouseGetPos, CoordenadaX5, CoordenadaY5
	MsgBox, 262208, Ctrl + Alt + A -- Infos, blablabla
return


^!U::
	run, Complementos\ThirdExe\anydesk.exe
return

oberon_msg1:
clipboard := "Are you ever going to fight or do you prefer talking!"
WinActivate, ahk_class Qt5QWindowOwnDCIcon
Send ^v {ENTER}
 return
oberon_msg2:
clipboard := "How appropriate, you look like something worms already got the better of!"
WinActivate, ahk_class Qt5QWindowOwnDCIcon
Send ^v {ENTER}
 return
oberon_msg3:
clipboard := "Even before they smell your breath?"
WinActivate, ahk_class Qt5QWindowOwnDCIcon
Send ^v {ENTER}
 return
oberon_msg4:
clipboard := "Then let me show you the concept of mortality before it!"
WinActivate, ahk_class Qt5QWindowOwnDCIcon
Send ^v {ENTER}
 return
oberon_msg5:
clipboard := "Too bad you barely exist at all!"
WinActivate, ahk_class Qt5QWindowOwnDCIcon
Send ^v {ENTER}
 return
oberon_msg6:
clipboard := "Excuse me but I still do not get the message!"
WinActivate, ahk_class Qt5QWindowOwnDCIcon
Send ^v {ENTER}
 return
oberon_msg7:
clipboard := "Dare strike up a Minnesang and you will receive your last accolade!"
WinActivate, ahk_class Qt5QWindowOwnDCIcon
Send ^v {ENTER}
 return
oberon_msg8:
clipboard := "Then why are we fighting alone right now?"
WinActivate, ahk_class Qt5QWindowOwnDCIcon
Send ^v {ENTER}
 return
oberon_msg9:
clipboard := "SEHWO ASIMO, TOLIDO ESD!"
WinActivate, ahk_class Qt5QWindowOwnDCIcon
Send ^v {ENTER}
 return
;==================================================================================
;================================================================================== Saves Config
;==================================================================================
Save_Config:
	Save()
return

Save_Config_Ataque:
	SaveAtaque()
return


;==================================================================================
;================================================================================== Reload Imagens - Search Imagens
;==================================================================================
Load_Images:
	SearchImages()
return

SearchImages() {
Global
WinActivate, Tibia - %Nome_Char%
WinGet, Actual_PID, PID, Tibia - %Nome_Char%
;msgbox, Actual_PID=%Actual_PID%

WinGetPos, Tibia_X, Tibia_Y, Tibia_Width1, Tibia_Height1, ahk_pid %Actual_PID%
Tibia_Width = % Tibia_Width1 + Tibia_X
Tibia_Height = % Tibia_Height1 + Tibia_Y
XTooltip = % Tibia_Width / 2
YTooltip = % Tibia_Height / 2

		CheckSetXini = % Tibia_Width - 200
		CheckSetYini = -23
		CheckSetXfim = % Tibia_Width - 20
		CheckSetYfim = 470

	
ImageSearch, XParty1, YParty1, %Tibia_X%, %Tibia_Y%, %Tibia_Width1%, %Tibia_Height1%, *15, Complementos\Imagens\%VersaoGrafico%\PartyList.png	; 
	if (ErrorLevel = 1) {
		tooltip PARTY LIST FECHADO
		sleep 500
	goto OutParty
	}
	if (ErrorLevel = 0) {
		XParty = %XParty1%
		YParty = %YParty1%
		; Char 1 party
		Xref_Life_PT1 = % XParty + 27
		Yref_Life_PT1 = % (YParty + 56) + (3 // 2)
		
		Xini_Life_PT1 = % XParty + 27
		Yini_Life_PT1 = % (YParty + 57)
		
		Xfim_Life_PT1 = % XParty + 27 + 130
		Yfim_Life_PT1 = % YParty + 57 + 3
		
		Xini_Char_tela_1 = %Xref_Life_PT1%
		Yini_Char_tela_1 = % Yref_Life_PT1 - 14
		
		Xfim_Char_tela_1 = % Xref_Life_PT1 + 26 
		Yfim_Char_tela_1 = % Yref_Life_PT1 - 4
		
		
		; Char 2 party
		Yref_Life_PT3 = % (YParty + 81) + (3 // 2)
		
		Xini_Life_PT3 = %Xini_Life_PT1%
		Yini_Life_PT3 = % (YParty + 82)
		
		Xfim_Life_PT3 = %Xfim_Life_PT1%
		Yfim_Life_PT3 = % YParty + 82 + 3
		
		Xini_Char_tela_3 = %Xini_Char_tela_1%
		Yini_Char_tela_3 = % Yref_Life_PT3 - 14
		
		Xfim_Char_tela_3 = %Xfim_Char_tela_1%
		Yfim_Char_tela_3 = % Yref_Life_PT3 - 4
}
OutParty:

ImageSearch, XInicioVida1, YInicioVida1, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *15, Complementos\Imagens\%VersaoGrafico%\HP100Percent.png	; Checa Vida 100%
	if (ErrorLevel = 1) {
		tooltip NÃO ENCONTRADO -> LIFE FULL
		sleep 1000	
	goto OutVida
	}
	if (ErrorLevel = 0) {
		XInicioVida = %XInicioVida1%
		YInicioVida = %YInicioVida1%
		gui,add,picture, x900 hwndmypic,Complementos\Imagens\%VersaoGrafico%\HP100Percent.png
		controlgetpos,,,lifewidth,lifeheight,,ahk_id %mypic%
		manawidth = %lifewidth%
		
		VidaFull = % XInicioVida + lifewidth
		YVida = % YInicioVida + (lifeheight // 2)
		MeioVida = % XInicioVida + (lifewidth // 2)
		PixelGetColor, CorDaVida, %MeioVida%, %YVida%, RGB ; 

		XInicioMana = %XInicioVida%
		ManaFull = %VidaFull%
		YMana = % YVida + 13
		PixelGetColor, CorDaMana, %XInicioMana%, %YMana%, RGB ; 
		
	}
OutVida:	


IfWinNotExist, ahk_class Qt5QWindowOwnDCIcon
	MsgBox, 262192, Primo Marcos Avisa, CLIENTE NÃO ENCONTRADO`nQUANDO ABRI-LO CLICAR EM RELOAD IMAGENS

}

;==================================================================================
;================================================================================== fecharsubrotinas
;==================================================================================
fecharsubrotinas() {
global
	process, exist, 1.exe
	if errorlevel
		Process, Close , 1.exe
	process, exist, 2.exe
	if errorlevel
		Process, Close , 2.exe
	process, exist, 3.exe
	if errorlevel
		Process, Close , 3.exe
	process, exist, 4.exe
	if errorlevel
		Process, Close , 4.exe
	process, exist, 5.exe
	if errorlevel
		Process, Close , 5.exe
	process, exist, 6.exe
	if errorlevel
		Process, Close , 6.exe
}
;==================================================================================
;================================================================================== Load
;==================================================================================
Load() {
Global
IniRead, VersaoGrafico, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, VersaoGrafico

IniRead, GetPosDummyX, %EndConfigSuporte%.ini, Principal, GetPosDummyX
IniRead, GetPosDummyY, %EndConfigSuporte%.ini, Principal, GetPosDummyY

IniRead, MouseGetPosOption, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, MouseGetPosOption
if (MouseGetPosOption = "ERROR"){
	MouseGetPosOption = Middle Mouse
}



IniRead, Tibia_X, %EndConfigSuporte%.ini, Principal, Tibia_X
IniRead, Tibia_Y, %EndConfigSuporte%.ini, Principal, Tibia_Y
IniRead, Tibia_Width, %EndConfigSuporte%.ini, Principal, Tibia_Width
IniRead, Tibia_Height, %EndConfigSuporte%.ini, Principal, Tibia_Height

IniRead, DelayMacro, %EndConfigSuporte%.ini, Principal, DelayMacro
	if (DelayMacro = "ERROR") {
		DelayMacro = 50
	}

IniRead, KeyMouseQuickLoot, %EndConfigSuporte%.ini, Principal, KeyMouseQuickLoot
	if (KeyMouseQuickLoot = "ERROR") {
		KeyMouseQuickLoot = Hotkey
	}
IniRead, KeyQuickLootTibia, %EndConfigSuporte%.ini, Principal, KeyQuickLootTibia
	if (KeyQuickLootTibia = "ERROR") {
		KeyQuickLootTibia = SHIFT_RIGHT
	}


;[LIFE]
IniRead, SpecialKey_LifeStage1, %EndConfigSuporte%.ini, SpecialKeys, SpecialKey_LifeStage1
	if (SpecialKey_LifeStage1 = "ERROR") {
		 SpecialKey_LifeStage1 = None
	}
IniRead, SpecialKey_LifeStage2, %EndConfigSuporte%.ini, SpecialKeys, SpecialKey_LifeStage2
	if (SpecialKey_LifeStage2 = "ERROR") {
	 SpecialKey_LifeStage2 = None
	}
IniRead, SpecialKey_LifeStage3, %EndConfigSuporte%.ini, SpecialKeys, SpecialKey_LifeStage3
	if (SpecialKey_LifeStage3 = "ERROR") {
	 SpecialKey_LifeStage3 = None
	}

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
IniRead, Hotkey_AtivaSwap, %EndConfigSuporte%.ini, Energy_Ring, Hotkey_AtivaSwap

IniRead, TipoMagicShield, %EndConfigSuporte%.ini, Energy_Ring, TipoMagicShield
	if (TipoMagicShield = "ERROR") {
		TipoMagicShield = Energy Ring
	}

;[MANA]
IniRead, Percent_Mana_Stage1, %EndConfigSuporte%.ini, ManaHeal, Percent_Mana_Stage1
IniRead, Hotkey_Mana_Stage1, %EndConfigSuporte%.ini, ManaHeal, Hotkey_Mana_Stage1
IniRead, Percent_Mana_Stage2, %EndConfigSuporte%.ini, ManaHeal, Percent_Mana_Stage2
IniRead, Hotkey_Mana_Stage2, %EndConfigSuporte%.ini, ManaHeal, Hotkey_Mana_Stage2

;[EatFood]
IniRead, Hotkey_Eat, %EndConfigSuporte%.ini, EAT, Hotkey_Eat

;[BUFF]
IniRead, Hotkey_PotBuff, %EndConfigSuporte%.ini, Buff, Hotkey_PotBuff

;[HASTE]
IniRead, Hotkey_Haste, %EndConfigSuporte%.ini, Haste, Hotkey_Haste
IniRead, RPUTITADO, %EndConfigSuporte%.ini, Principal, RPUTITADO

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

;[DELAY SSA e MIGHT]
IniRead, DelaySSAMIGHT, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, DelaySSAMIGHT
if (DelaySSAMIGHT = "ERROR"){
	DelaySSAMIGHT = 100
}

;[SSA]
IniRead, SSA_Hotkey, %EndConfigSuporte%.ini, Stone_Skin_Amulet, SSA_Hotkey
IniRead, SSA_Life, %EndConfigSuporte%.ini, Stone_Skin_Amulet, SSA_Life
IniRead, SSA_Mana, %EndConfigSuporte%.ini, Stone_Skin_Amulet, SSA_Mana
IniRead, Tank_Amulet, %EndConfigSuporte%.ini, Stone_Skin_Amulet, Tank_Amulet
	if (Tank_Amulet = "ERROR") {
		Tank_Amulet = SSA
	}
	
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

;[SIO]
IniRead, PercentSelfHealth, %EndConfigSuporte%.ini, EKSIO, PercentSelfHealth
IniRead, PercentSelfMana, %EndConfigSuporte%.ini, EKSIO, PercentSelfMana

;[SIO EK]
IniRead, Hotkey_SIO_1, %EndConfigSuporte%.ini, EKSIO, Hotkey_SIO_1
IniRead, Hotkey_GranSIO_1, %EndConfigSuporte%.ini, EKSIO, Hotkey_GranSIO_1
IniRead, HealFriend1, %EndConfigSuporte%.ini, EKSIO, HealFriend1
	if (HealFriend1 = "ERROR") {
		HealFriend1 = SIO
	}
IniRead, PercentSIO1, %EndConfigSuporte%.ini, EKSIO, PercentSIO1
IniRead, PercentGranSIO1, %EndConfigSuporte%.ini, EKSIO, PercentGranSIO1

;[SIO RP]
IniRead, Hotkey_SIO_2, %EndConfigSuporte%.ini, RPSIO, Hotkey_SIO_2
IniRead, HealFriend2, %EndConfigSuporte%.ini, RPSIO, HealFriend2
	if (HealFriend2 = "ERROR") {
		HealFriend2 = SIO
	}
IniRead, PercentSIO3, %EndConfigSuporte%.ini, RPSIO, PercentSIO3

;[COORDENADAS SIO]
IniRead, CoordenadaX, %EndConfigSuporte%.ini, COORDSIO, CoordenadaX
IniRead, CoordenadaY, %EndConfigSuporte%.ini, COORDSIO, CoordenadaY
IniRead, CoordenadaXAux, %EndConfigSuporte%.ini, COORDSIO, CoordenadaXAux
IniRead, CoordenadaX1, %EndConfigSuporte%.ini, COORDSIO, CoordenadaX1
IniRead, CoordenadaY1, %EndConfigSuporte%.ini, COORDSIO, CoordenadaY1

;[ManaTraining]
IniRead, HotkeyTrain1, %EndConfigSuporte%.ini, ManaTraining, HotkeyTrain1
IniRead, HotkeyTrain2, %EndConfigSuporte%.ini, ManaTraining, HotkeyTrain2
IniRead, HotkeyTrain3, %EndConfigSuporte%.ini, ManaTraining, HotkeyTrain3
IniRead, HotkeyTrain4, %EndConfigSuporte%.ini, ManaTraining, HotkeyTrain4
IniRead, HotkeyTrain5, %EndConfigSuporte%.ini, ManaTraining, HotkeyTrain5
IniRead, TimeDelay, %EndConfigSuporte%.ini, ManaTraining, TimeDelay 

;[PRIMO ATAQUE]
IniRead, Hotkey_ATK, %EndConfigAtaque%.ini, Principal, Hotkey_ATK
IniRead, Hotkey_Target, %EndConfigAtaque%.ini, Principal, Hotkey_Target
IniRead, TipoTarget, %EndConfigAtaque%.ini, Principal, TipoTarget

IniRead, Rune1, %EndConfigAtaque%.ini, AtkRune1, Rune1
IniRead, TimeDelay1, %EndConfigAtaque%.ini, AtkRune1, TimeDelay1
IniRead, Rune2, %EndConfigAtaque%.ini, AtkRune2, Rune2
IniRead, TimeDelay2, %EndConfigAtaque%.ini, AtkRune2, TimeDelay2


IniRead, TipoUtamo, %EndConfigSuporte%.ini, Principal, TipoUtamo
	if (TipoUtamo = "ERROR") {
		TipoUtamo = GLOBAL
	}

IniRead, QuantidadeDeMagia1,  %EndConfigAtaque%.ini, AtkRotacao1, QuantidadeDeMagia1
IniRead, MagiaRotacao1_1,  %EndConfigAtaque%.ini, AtkRotacao1, MagiaRotacao1_1
IniRead, MagiaRotacao1_2,  %EndConfigAtaque%.ini, AtkRotacao1, MagiaRotacao1_2
IniRead, MagiaRotacao1_3,  %EndConfigAtaque%.ini, AtkRotacao1, MagiaRotacao1_3
IniRead, MagiaRotacao1_4,  %EndConfigAtaque%.ini, AtkRotacao1, MagiaRotacao1_4
IniRead, TimeDelay3, %EndConfigAtaque%.ini, AtkRotacao1, TimeDelay3

IniRead, QuantidadeDeMagia2,  %EndConfigAtaque%.ini, AtkRotacao2, QuantidadeDeMagia2
IniRead, MagiaRotacao2_1,  %EndConfigAtaque%.ini, AtkRotacao2, MagiaRotacao2_1
IniRead, MagiaRotacao2_2,  %EndConfigAtaque%.ini, AtkRotacao2, MagiaRotacao2_2
IniRead, MagiaRotacao2_3,  %EndConfigAtaque%.ini, AtkRotacao2, MagiaRotacao2_3
IniRead, MagiaRotacao2_4,  %EndConfigAtaque%.ini, AtkRotacao2, MagiaRotacao2_4
IniRead, TimeDelay4, %EndConfigAtaque%.ini, AtkRotacao2, TimeDelay4
IniRead, DelayNextTarget, %EndConfigAtaque%.ini, Principal, DelayNextTarget
	;[Push]
IniRead, Hotkey_Push, %EndConfigSuporte%.ini, Principal, Hotkey_Push

	;[Tank mode]
IniRead, Habilita_TankMode, %EndConfigSuporte%.ini, Principal, Habilita_TankMode


	;[Pixel Vida Mana]
IniRead, XInicioVida, %EndConfigSuporte%.ini, Coordenadas, XInicioVida
IniRead, lifewidth, %EndConfigSuporte%.ini, Coordenadas, lifewidth
IniRead, YVida, %EndConfigSuporte%.ini, Coordenadas, YVida

IniRead, XInicioMana, %EndConfigSuporte%.ini, Coordenadas, XInicioMana
IniRead, YInicioMana, %EndConfigSuporte%.ini, Coordenadas, YInicioMana
IniRead, manawidth, %EndConfigSuporte%.ini, Coordenadas, manawidth
IniRead, YMana, %EndConfigSuporte%.ini, Coordenadas, YMana

	;[Pixel Set]
IniRead, CheckSetXini, %EndConfigSuporte%.ini, Coordenadas, CheckSetXini
IniRead, CheckSetYini, %EndConfigSuporte%.ini, Coordenadas, CheckSetYini
IniRead, CheckSetXfim, %EndConfigSuporte%.ini, Coordenadas, CheckSetXfim
IniRead, CheckSetYfim, %EndConfigSuporte%.ini, Coordenadas, CheckSetYfim

IniRead, CorDaVida, %EndConfigSuporte%.ini, Coordenadas, CorDaVida
IniRead, CorDaMana, %EndConfigSuporte%.ini, Coordenadas, CorDaMana

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




	;[Quick Loot]
IniRead, DelayLoot, %EndConfigSuporte%.ini, Loot, DelayLoot
IniRead, Hotkey_Quickloot, %EndConfigSuporte%.ini, Loot, Hotkey_Quickloot
IniRead, Hotkey_StartStopQuickloot, %EndConfigSuporte%.ini, Loot, Hotkey_StartStopQuickloot

IniRead, GetPosLoot11X, %EndConfigSuporte%.ini, Loot, GetPosLoot11X
IniRead, GetPosLoot11Y, %EndConfigSuporte%.ini, Loot, GetPosLoot11Y
IniRead, GetPosLoot12X, %EndConfigSuporte%.ini, Loot, GetPosLoot12X
IniRead, GetPosLoot12Y, %EndConfigSuporte%.ini, Loot, GetPosLoot12Y
IniRead, GetPosLoot13X, %EndConfigSuporte%.ini, Loot, GetPosLoot13X
IniRead, GetPosLoot13Y, %EndConfigSuporte%.ini, Loot, GetPosLoot13Y

IniRead, GetPosLoot21X, %EndConfigSuporte%.ini, Loot, GetPosLoot21X
IniRead, GetPosLoot21Y, %EndConfigSuporte%.ini, Loot, GetPosLoot21Y
IniRead, GetPosLoot22X, %EndConfigSuporte%.ini, Loot, GetPosLoot22X
IniRead, GetPosLoot22Y, %EndConfigSuporte%.ini, Loot, GetPosLoot22Y
IniRead, GetPosLoot23X, %EndConfigSuporte%.ini, Loot, GetPosLoot23X
IniRead, GetPosLoot23Y, %EndConfigSuporte%.ini, Loot, GetPosLoot23Y

IniRead, GetPosLoot31X, %EndConfigSuporte%.ini, Loot, GetPosLoot31X
IniRead, GetPosLoot31Y, %EndConfigSuporte%.ini, Loot, GetPosLoot31Y
IniRead, GetPosLoot32X, %EndConfigSuporte%.ini, Loot, GetPosLoot32X
IniRead, GetPosLoot32Y, %EndConfigSuporte%.ini, Loot, GetPosLoot32Y
IniRead, GetPosLoot33X, %EndConfigSuporte%.ini, Loot, GetPosLoot33X
IniRead, GetPosLoot33Y, %EndConfigSuporte%.ini, Loot, GetPosLoot33Y


IniRead, HUDX, %EndConfigSuporte%.ini, Loot, HUDX
IniRead, HUDY, %EndConfigSuporte%.ini, Loot, HUDY

;[PVP FUNCTIONS]
IniRead, Key_Enable_Flower, %EndConfigSuporte%.ini, Principal, Key_Enable_Flower
IniRead, GetPosFlowerX, %EndConfigSuporte%.ini, Principal, GetPosFlowerX
IniRead, GetPosFlowerY, %EndConfigSuporte%.ini, Principal, GetPosFlowerY

IniRead, Key_Enable_Trash, %EndConfigSuporte%.ini, Principal, Key_Enable_Trash
IniRead, GetPosTrash1X, %EndConfigSuporte%.ini, Principal, GetPosTrash1X
IniRead, GetPosTrash1Y, %EndConfigSuporte%.ini, Principal, GetPosTrash1Y
IniRead, GetPosTrash2X, %EndConfigSuporte%.ini, Principal, GetPosTrash2X
IniRead, GetPosTrash2Y, %EndConfigSuporte%.ini, Principal, GetPosTrash2Y
IniRead, OpcaoTrash, %EndConfigSuporte%.ini, Principal, OpcaoTrash
	if (OpcaoTrash = "ERROR") {
		OpcaoTrash = Mouse
	}
IniRead, Key_Enable_PushItem, %EndConfigSuporte%.ini, Principal, Key_Enable_PushItem
IniRead, PushItemBPX, %EndConfigSuporte%.ini, Principal, PushItemBPX
IniRead, PushItemBPY, %EndConfigSuporte%.ini, Principal, PushItemBPY



;[Treinar]
IniRead, Hotkey_Exercise, %EndConfigSuporte%.ini, Principal, Hotkey_Exercise
IniRead, ExerciseDelay, %EndConfigSuporte%.ini, Principal, ExerciseDelay
IniRead, POTDELAY, %EndConfigSuporte%.ini, Principal, POTDELAY
IniRead, Hotkey_Pause, %EndConfigSuporte%.ini, Principal, Hotkey_Pause

;[Quiver]
IniRead, Hotkey_Quiver, %EndConfigSuporte%.ini, Principal, Hotkey_Quiver

IniRead, Hotkey_Consecutive1, %EndConfigSuporte%.ini, Principal, Hotkey_Consecutive1
IniRead, Hotkey_Consecutive2, %EndConfigSuporte%.ini, Principal, Hotkey_Consecutive2
IniRead, Delay_Consecutive1, %EndConfigSuporte%.ini, Principal, Delay_Consecutive1
IniRead, Delay_Consecutive2, %EndConfigSuporte%.ini, Principal, Delay_Consecutive2
}

;==================================================================================
;================================================================================== Save
;==================================================================================
Save() {
Global

;[Principal]
IniWrite, %EndConfigSuporte%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, EndConfigSuporte
IniWrite, %EndConfigAtaque%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, EndConfigAtaque
IniWrite, %Actual_PID%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Actual_PID

GuiControlGet, MouseGetPosOption
IniWrite, %MouseGetPosOption%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, MouseGetPosOption

GuiControlGet, Account
IniWrite, %Account%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Account
GuiControlGet, Password
IniWrite, %Password%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Password

GuiControlGet, DelayMacro
IniWrite, %DelayMacro%, %EndConfigSuporte%.ini, Principal, DelayMacro

GuiControlGet, Hotkey_Consecutive1
IniWrite, %Hotkey_Consecutive1%, %EndConfigSuporte%.ini, Principal, Hotkey_Consecutive1
GuiControlGet, Hotkey_Consecutive2
IniWrite, %Hotkey_Consecutive2%, %EndConfigSuporte%.ini, Principal, Hotkey_Consecutive2
GuiControlGet, Delay_Consecutive1
IniWrite, %Delay_Consecutive1%, %EndConfigSuporte%.ini, Principal, Delay_Consecutive1
GuiControlGet, Delay_Consecutive2
IniWrite, %Delay_Consecutive2%, %EndConfigSuporte%.ini, Principal, Delay_Consecutive2

GuiControlGet, Hotkey_Pause
IniWrite, %Hotkey_Pause%, %EndConfigSuporte%.ini, Principal, Hotkey_Pause

;[Principal]
	
IniWrite, %Nome_Char%, %EndConfigSuporte%.ini, Principal, Nome_Char

IniWrite, %XTooltip%, %EndConfigSuporte%.ini, Principal, XTooltip
IniWrite, %YTooltip%, %EndConfigSuporte%.ini, Principal, YTooltip



GuiControlGet, KeyMouseQuickLoot
IniWrite, %KeyMouseQuickLoot%, %EndConfigSuporte%.ini, Principal, KeyMouseQuickLoot
GuiControlGet, KeyQuickLootTibia
IniWrite, %KeyQuickLootTibia%, %EndConfigSuporte%.ini, Principal, KeyQuickLootTibia

GuiControlGet, TipoUtamo
IniWrite, %TipoUtamo%, %EndConfigSuporte%.ini, Principal, TipoUtamo


GuiControlGet, LigarPrimo
IniWrite, %LigarPrimo%, %EndConfigSuporte%.ini, Principal, LigarPrimo

GuiControlGet, Life_AutoHealing
IniWrite, %Life_AutoHealing%, %EndConfigSuporte%.ini, Principal, Life_AutoHealing
GuiControlGet, Mana_AutoHealing
IniWrite, %Mana_AutoHealing%, %EndConfigSuporte%.ini, Principal, Mana_AutoHealing

GuiControlGet, Energy_Ring
IniWrite, %Energy_Ring%, %EndConfigSuporte%.ini, Principal, Energy_Ring

if (Energy_Ring == 0) {
	IniWrite, 0, %EndConfigSuporte%.ini, Principal, PuxandoEnergyRing
}
GuiControlGet, Energy_Ring
IniWrite, %Quiver%, %EndConfigSuporte%.ini, Principal, Quiver

GuiControlGet, EAT
IniWrite, %EAT%, %EndConfigSuporte%.ini, Principal, EAT
GuiControlGet, PotBuff
IniWrite, %PotBuff%, %EndConfigSuporte%.ini, Principal, PotBuff
GuiControlGet, Haste
IniWrite, %Haste%, %EndConfigSuporte%.ini, Principal, Haste
GuiControlGet, RPUTITADO
IniWrite, %RPUTITADO%, %EndConfigSuporte%.ini, Principal, RPUTITADO
GuiControlGet, Boots
IniWrite, %Boots%, %EndConfigSuporte%.ini, Principal, Boots
GuiControlGet, Paralize
IniWrite, %Paralize%, %EndConfigSuporte%.ini, Principal, Paralize
GuiControlGet, Amulet
IniWrite, %Amulet%, %EndConfigSuporte%.ini, Principal, Amulet
GuiControlGet, Ring
IniWrite, %Ring%, %EndConfigSuporte%.ini, Principal, Ring
GuiControlGet, UtamoVita
IniWrite, %UtamoVita%, %EndConfigSuporte%.ini, Principal, UtamoVita
GuiControlGet, PotUtamoVita
IniWrite, %PotUtamoVita%, %EndConfigSuporte%.ini, Principal, PotUtamoVita

IniWrite, %Tibia_X%, %EndConfigSuporte%.ini, Principal, Tibia_X
IniWrite, %Tibia_Y%, %EndConfigSuporte%.ini, Principal, Tibia_Y
IniWrite, %Tibia_Width%, %EndConfigSuporte%.ini, Principal, Tibia_Width
IniWrite, %Tibia_Height%, %EndConfigSuporte%.ini, Principal, Tibia_Height

GuiControlGet, Safe_Mode
IniWrite, %Safe_Mode%, %EndConfigSuporte%.ini, Principal, Safe_Mode
GuiControlGet, Safe_StopAttack
IniWrite, %Safe_StopAttack%, %EndConfigSuporte%.ini, Principal, Safe_StopAttack


GuiControlGet, DelaySSAMIGHT
IniWrite, %DelaySSAMIGHT%, %EndConfigSuporte%.ini, Principal, DelaySSAMIGHT
GuiControlGet, SSA
IniWrite, %SSA%, %EndConfigSuporte%.ini, Principal, SSA
GuiControlGet, MIGHT
IniWrite, %MIGHT%, %EndConfigSuporte%.ini, Principal, MIGHT
GuiControlGet, ForcaMight
IniWrite, %ForcaMight%, %EndConfigSuporte%.ini, Principal, ForcaMight
GuiControlGet, FOODHP
IniWrite, %FOODHP%, %EndConfigSuporte%.ini, Principal, FOODHP
GuiControlGet, FOODMP
IniWrite, %FOODMP%, %EndConfigSuporte%.ini, Principal, FOODMP

if (SSA == 0) {
	IniWrite, 0, %EndConfigSuporte%.ini, Principal, EquipandoSSA
}
if (MIGHT == 0) {
	IniWrite, 0, %EndConfigSuporte%.ini, Principal, EquipandoMight
}

GuiControlGet, SIOEK
IniWrite, %SIOEK%, %EndConfigSuporte%.ini, Principal, SIOEK
GuiControlGet, UHEK
IniWrite, %UHEK%, %EndConfigSuporte%.ini, Principal, UHEK
GuiControlGet, SIORP
IniWrite, %SIORP%, %EndConfigSuporte%.ini, Principal, SIORP
GuiControlGet, UHRP
IniWrite, %UHRP%, %EndConfigSuporte%.ini, Principal, UHRP

IniWrite, %GetPosDummyX%, %EndConfigSuporte%.ini, Principal, GetPosDummyX
IniWrite, %GetPosDummyY%, %EndConfigSuporte%.ini, Principal, GetPosDummyY

;[LIFE]
GuiControlGet, SpecialKey_LifeStage1
IniWrite, %SpecialKey_LifeStage1%, %EndConfigSuporte%.ini, SpecialKeys, SpecialKey_LifeStage1
GuiControlGet, SpecialKey_LifeStage2
IniWrite, %SpecialKey_LifeStage2%, %EndConfigSuporte%.ini, SpecialKeys, SpecialKey_LifeStage2
GuiControlGet, SpecialKey_LifeStage3
IniWrite, %SpecialKey_LifeStage3%, %EndConfigSuporte%.ini, SpecialKeys, SpecialKey_LifeStage3
GuiControlGet, Percent_Life_Stage1
IniWrite, %Percent_Life_Stage1%, %EndConfigSuporte%.ini, AutoHeal, Percent_Life_Stage1
GuiControlGet, Hotkey_Life_Stage1
IniWrite, %Hotkey_Life_Stage1%, %EndConfigSuporte%.ini, AutoHeal, Hotkey_Life_Stage1

GuiControlGet, Percent_Life_Stage2
IniWrite, %Percent_Life_Stage2%, %EndConfigSuporte%.ini, AutoHeal, Percent_Life_Stage2
GuiControlGet, Hotkey_Life_Stage2
IniWrite, %Hotkey_Life_Stage2%, %EndConfigSuporte%.ini, AutoHeal, Hotkey_Life_Stage2

GuiControlGet, Percent_Life_Stage3
IniWrite, %Percent_Life_Stage3%, %EndConfigSuporte%.ini, AutoHeal, Percent_Life_Stage3
GuiControlGet, Hotkey_Life_Stage3
IniWrite, %Hotkey_Life_Stage3%, %EndConfigSuporte%.ini, AutoHeal, Hotkey_Life_Stage3

;[Energy Ring]
GuiControlGet, Percent_Life_Equip_Energy
IniWrite, %Percent_Life_Equip_Energy%, %EndConfigSuporte%.ini, Energy_Ring, Percent_Life_Equip_Energy
GuiControlGet, Percent_Mana_Equip_Energy
IniWrite, %Percent_Mana_Equip_Energy%, %EndConfigSuporte%.ini, Energy_Ring, Percent_Mana_Equip_Energy
GuiControlGet, Percent_Life_DeEquip_Energy
IniWrite, %Percent_Life_DeEquip_Energy%, %EndConfigSuporte%.ini, Energy_Ring, Percent_Life_DeEquip_Energy
GuiControlGet, Percent_Mana_DeEquip_Energy
IniWrite, %Percent_Mana_DeEquip_Energy%, %EndConfigSuporte%.ini, Energy_Ring, Percent_Mana_DeEquip_Energy
GuiControlGet, Hotkey_Energy_Ring
IniWrite, %Hotkey_Energy_Ring%, %EndConfigSuporte%.ini, Energy_Ring, Hotkey_Energy_Ring
GuiControlGet, Hotkey_DeEnergy_Ring
IniWrite, %Hotkey_DeEnergy_Ring%, %EndConfigSuporte%.ini, Energy_Ring, Hotkey_DeEnergy_Ring
GuiControlGet, Hotkey_AtivaSwap
IniWrite, %Hotkey_AtivaSwap%, %EndConfigSuporte%.ini, Energy_Ring, Hotkey_AtivaSwap
GuiControlGet, TipoMagicShield
IniWrite, %TipoMagicShield%, %EndConfigSuporte%.ini, Energy_Ring, TipoMagicShield

;[MANA]
GuiControlGet, Percent_Mana_Stage1
IniWrite, %Percent_Mana_Stage1%, %EndConfigSuporte%.ini, ManaHeal, Percent_Mana_Stage1
GuiControlGet, Hotkey_Mana_Stage1
IniWrite, %Hotkey_Mana_Stage1%, %EndConfigSuporte%.ini, ManaHeal, Hotkey_Mana_Stage1
GuiControlGet, Percent_Mana_Stage2
IniWrite, %Percent_Mana_Stage2%, %EndConfigSuporte%.ini, ManaHeal, Percent_Mana_Stage2
GuiControlGet, Hotkey_Mana_Stage2
IniWrite, %Hotkey_Mana_Stage2%, %EndConfigSuporte%.ini, ManaHeal, Hotkey_Mana_Stage2

;[Quiver]
GuiControlGet, Hotkey_Quiver
IniWrite, %Hotkey_Quiver%, %EndConfigSuporte%.ini, Principal, Hotkey_Quiver

;[EatFood]
GuiControlGet, Hotkey_Eat
IniWrite, %Hotkey_Eat%, %EndConfigSuporte%.ini, EAT, Hotkey_Eat

;[Haste]
GuiControlGet, Hotkey_Haste
IniWrite, %Hotkey_Haste%, %EndConfigSuporte%.ini, Haste, Hotkey_Haste

;[BUFF]
GuiControlGet, Hotkey_PotBuff
IniWrite, %Hotkey_PotBuff%, %EndConfigSuporte%.ini, Buff, Hotkey_PotBuff

;[Renew Boots]
GuiControlGet, Hotkey_Boots
IniWrite, %Hotkey_Boots%, %EndConfigSuporte%.ini, AutoBoots, Hotkey_Boots

;[paralize]
GuiControlGet, Hotkey_Paralize
IniWrite, %Hotkey_Paralize%, %EndConfigSuporte%.ini, Paralize, Hotkey_Paralize

;[UtamoVita]
GuiControlGet, Hotkey_Utamo
IniWrite, %Hotkey_Utamo%, %EndConfigSuporte%.ini, UtamoVita, Hotkey_Utamo
GuiControlGet, Hotkey_PotUtamo
IniWrite, %Hotkey_PotUtamo%, %EndConfigSuporte%.ini, UtamoVita, Hotkey_PotUtamo

;[Amulet]
GuiControlGet, Amulet_Hotkey
IniWrite, %Amulet_Hotkey%, %EndConfigSuporte%.ini, Amulet, Amulet_Hotkey

;[Ring]
GuiControlGet, Hotkey_Ring
IniWrite, %Hotkey_Ring%, %EndConfigSuporte%.ini, Ring, Hotkey_Ring

;[SSA]
GuiControlGet, SSA_Hotkey
IniWrite, %SSA_Hotkey%, %EndConfigSuporte%.ini, Stone_Skin_Amulet, SSA_Hotkey
GuiControlGet, SSA_Life
IniWrite, %SSA_Life%, %EndConfigSuporte%.ini, Stone_Skin_Amulet, SSA_Life
GuiControlGet, SSA_Mana
IniWrite, %SSA_Mana%, %EndConfigSuporte%.ini, Stone_Skin_Amulet, SSA_Mana
GuiControlGet, Tank_Amulet
IniWrite, %Tank_Amulet%, %EndConfigSuporte%.ini, Stone_Skin_Amulet, Tank_Amulet

;[MIGHT RING]
GuiControlGet, Might_Hotkey
IniWrite, %Might_Hotkey%, %EndConfigSuporte%.ini, Might_Ring, Might_Hotkey
GuiControlGet, Might_Life
IniWrite, %Might_Life%, %EndConfigSuporte%.ini, Might_Ring, Might_Life
GuiControlGet, Might_Mana
IniWrite, %Might_Mana%, %EndConfigSuporte%.ini, Might_Ring, Might_Mana

;[FOODHP]
GuiControlGet, HotkeyFOODHP
IniWrite, %HotkeyFOODHP%, %EndConfigSuporte%.ini, FOODHP, HotkeyFOODHP
GuiControlGet, PercentFOODHP
IniWrite, %PercentFOODHP%, %EndConfigSuporte%.ini, FOODHP, PercentFOODHP

;[FOODMP]
GuiControlGet, PREHotkeyFOODMP
IniWrite, %PREHotkeyFOODMP%, %EndConfigSuporte%.ini, FOODMP, PREHotkeyFOODMP
GuiControlGet, HotkeyFOODMP
IniWrite, %HotkeyFOODMP%, %EndConfigSuporte%.ini, FOODMP, HotkeyFOODMP
GuiControlGet, PercentFOODMP
IniWrite, %PercentFOODMP%, %EndConfigSuporte%.ini, FOODMP, PercentFOODMP

;[SIO]
GuiControlGet, PercentSelfHealth
IniWrite, %PercentSelfHealth%, %EndConfigSuporte%.ini, EKSIO, PercentSelfHealth
GuiControlGet, PercentSelfMana
IniWrite, %PercentSelfMana%, %EndConfigSuporte%.ini, EKSIO, PercentSelfMana

;[SIO EK]
GuiControlGet, Hotkey_SIO_1
IniWrite, %Hotkey_SIO_1%, %EndConfigSuporte%.ini, EKSIO, Hotkey_SIO_1
GuiControlGet, Hotkey_GranSIO_1
IniWrite, %Hotkey_GranSIO_1%, %EndConfigSuporte%.ini, EKSIO, Hotkey_GranSIO_1
GuiControlGet, HealFriend1
IniWrite, %HealFriend1%, %EndConfigSuporte%.ini, EKSIO, HealFriend1
GuiControlGet, PercentSIO1
IniWrite, %PercentSIO1%, %EndConfigSuporte%.ini, EKSIO, PercentSIO1
GuiControlGet, PercentGranSIO1
IniWrite, %PercentGranSIO1%, %EndConfigSuporte%.ini, EKSIO, PercentGranSIO1

;[COORDENADAS SIO]
IniWrite, %CoordenadaX%, %EndConfigSuporte%.ini, COORDSIO, CoordenadaX
IniWrite, %CoordenadaY%, %EndConfigSuporte%.ini, COORDSIO, CoordenadaY
IniWrite, %CoordenadaXAux%, %EndConfigSuporte%.ini, COORDSIO, CoordenadaXAux
IniWrite, %CoordenadaX1%, %EndConfigSuporte%.ini, COORDSIO, CoordenadaX1
IniWrite, %CoordenadaY1%, %EndConfigSuporte%.ini, COORDSIO, CoordenadaY1

;[SIO RP]
GuiControlGet, Hotkey_SIO_2
IniWrite, %Hotkey_SIO_2%, %EndConfigSuporte%.ini, RPSIO, Hotkey_SIO_2
GuiControlGet, HealFriend2
IniWrite, %HealFriend2%, %EndConfigSuporte%.ini, RPSIO, HealFriend2
GuiControlGet, PercentSIO3
IniWrite, %PercentSIO3%, %EndConfigSuporte%.ini, RPSIO, PercentSIO3

	;[ManaTraining]
GuiControlGet, ManaTraining
IniWrite, %ManaTraining%, %EndConfigSuporte%.ini, ManaTraining, ManaTraining
GuiControlGet, HotkeyTrain1
IniWrite, %HotkeyTrain1%, %EndConfigSuporte%.ini, ManaTraining, HotkeyTrain1
GuiControlGet, HotkeyTrain2
IniWrite, %HotkeyTrain2%, %EndConfigSuporte%.ini, ManaTraining, HotkeyTrain2
GuiControlGet, HotkeyTrain3
IniWrite, %HotkeyTrain3%, %EndConfigSuporte%.ini, ManaTraining, HotkeyTrain3
GuiControlGet, HotkeyTrain4
IniWrite, %HotkeyTrain4%, %EndConfigSuporte%.ini, ManaTraining, HotkeyTrain4
GuiControlGet, HotkeyTrain5
IniWrite, %HotkeyTrain5%, %EndConfigSuporte%.ini, ManaTraining, HotkeyTrain5
GuiControlGet, TimeDelay
IniWrite, %TimeDelay%, %EndConfigSuporte%.ini, ManaTraining, TimeDelay 

GuiControlGet, OpcaoTreino
IniWrite, %OpcaoTreino%, %EndConfigSuporte%.ini, ManaTraining, OpcaoTreino 
GuiControlGet, BUYPOT
IniWrite, %BUYPOT%, %EndConfigSuporte%.ini, ManaTraining, BUYPOT

	;[Push]
GuiControlGet, Hotkey_Push
IniWrite, %Hotkey_Push%, %EndConfigSuporte%.ini, Principal, Hotkey_Push

	;[TankMode]
GuiControlGet, Habilita_TankMode
IniWrite, %Habilita_TankMode%, %EndConfigSuporte%.ini, Principal, Habilita_TankMode


	;[Pixel Vida Mana]
IniWrite, %XInicioVida%, %EndConfigSuporte%.ini, Coordenadas, XInicioVida
IniWrite, %lifewidth%, %EndConfigSuporte%.ini, Coordenadas, lifewidth
IniWrite, %YVida%, %EndConfigSuporte%.ini, Coordenadas, YVida

IniWrite, %XInicioMana%, %EndConfigSuporte%.ini, Coordenadas, XInicioMana
IniWrite, %YInicioMana%, %EndConfigSuporte%.ini, Coordenadas, YInicioMana
IniWrite, %manawidth%, %EndConfigSuporte%.ini, Coordenadas, manawidth
IniWrite, %YMana%, %EndConfigSuporte%.ini, Coordenadas, YMana


	;[Pixel Set]
IniWrite, %CheckSetXini%, %EndConfigSuporte%.ini, Coordenadas, CheckSetXini
IniWrite, %CheckSetYini%, %EndConfigSuporte%.ini, Coordenadas, CheckSetYini
IniWrite, %CheckSetXfim%, %EndConfigSuporte%.ini, Coordenadas, CheckSetXfim
IniWrite, %CheckSetYfim%, %EndConfigSuporte%.ini, Coordenadas, CheckSetYfim
	
IniWrite, %CorDaVida%, %EndConfigSuporte%.ini, Coordenadas, CorDaVida
IniWrite, %CorDaMana%, %EndConfigSuporte%.ini, Coordenadas, CorDaMana


IniWrite, %Xref_Life_PT1%, %EndConfigSuporte%.ini, Coordenadas, Xref_Life_PT1
IniWrite, %Yref_Life_PT1%, %EndConfigSuporte%.ini, Coordenadas, Yref_Life_PT1
IniWrite, %Xini_Life_PT1%, %EndConfigSuporte%.ini, Coordenadas, Xini_Life_PT1
IniWrite, %Yini_Life_PT1%, %EndConfigSuporte%.ini, Coordenadas, Yini_Life_PT1
IniWrite, %Xfim_Life_PT1%, %EndConfigSuporte%.ini, Coordenadas, Xfim_Life_PT1
IniWrite, %Yfim_Life_PT1%, %EndConfigSuporte%.ini, Coordenadas, Yfim_Life_PT1
IniWrite, %Xini_Char_tela_1%, %EndConfigSuporte%.ini, Coordenadas, Xini_Char_tela_1
IniWrite, %Yini_Char_tela_1%, %EndConfigSuporte%.ini, Coordenadas, Yini_Char_tela_1
IniWrite, %Xfim_Char_tela_1%, %EndConfigSuporte%.ini, Coordenadas, Xfim_Char_tela_1
IniWrite, %Yfim_Char_tela_1%, %EndConfigSuporte%.ini, Coordenadas, Yfim_Char_tela_1

IniWrite, %Yref_Life_PT3%, %EndConfigSuporte%.ini, Coordenadas, Yref_Life_PT3
IniWrite, %Xini_Life_PT3%, %EndConfigSuporte%.ini, Coordenadas, Xini_Life_PT3
IniWrite, %Yini_Life_PT3%, %EndConfigSuporte%.ini, Coordenadas, Yini_Life_PT3
IniWrite, %Xfim_Life_PT3%, %EndConfigSuporte%.ini, Coordenadas, Xfim_Life_PT3
IniWrite, %Yfim_Life_PT3%, %EndConfigSuporte%.ini, Coordenadas, Yfim_Life_PT3
IniWrite, %Xini_Char_tela_3%, %EndConfigSuporte%.ini, Coordenadas, Xini_Char_tela_3
IniWrite, %Yini_Char_tela_3%, %EndConfigSuporte%.ini, Coordenadas, Yini_Char_tela_3
IniWrite, %Xfim_Char_tela_3%, %EndConfigSuporte%.ini, Coordenadas, Xfim_Char_tela_3
IniWrite, %Yfim_Char_tela_3%, %EndConfigSuporte%.ini, Coordenadas, Yfim_Char_tela_3


	;[Quick Loot]
GuiControlGet, DelayLoot
IniWrite, %DelayLoot%, %EndConfigSuporte%.ini, Loot, DelayLoot
GuiControlGet, Hotkey_Quickloot
IniWrite, %Hotkey_Quickloot%, %EndConfigSuporte%.ini, Loot, Hotkey_Quickloot
GuiControlGet, Hotkey_StartStopQuickloot
IniWrite, %Hotkey_StartStopQuickloot%, %EndConfigSuporte%.ini, Loot, Hotkey_StartStopQuickloot

IniWrite, %GetPosLoot11X%, %EndConfigSuporte%.ini, Loot, GetPosLoot11X
IniWrite, %GetPosLoot11Y%, %EndConfigSuporte%.ini, Loot, GetPosLoot11Y
IniWrite, %GetPosLoot12X%, %EndConfigSuporte%.ini, Loot, GetPosLoot12X
IniWrite, %GetPosLoot12Y%, %EndConfigSuporte%.ini, Loot, GetPosLoot12Y
IniWrite, %GetPosLoot13X%, %EndConfigSuporte%.ini, Loot, GetPosLoot13X
IniWrite, %GetPosLoot13Y%, %EndConfigSuporte%.ini, Loot, GetPosLoot13Y

IniWrite, %GetPosLoot21X%, %EndConfigSuporte%.ini, Loot, GetPosLoot21X
IniWrite, %GetPosLoot21Y%, %EndConfigSuporte%.ini, Loot, GetPosLoot21Y
IniWrite, %GetPosLoot22X%, %EndConfigSuporte%.ini, Loot, GetPosLoot22X
IniWrite, %GetPosLoot22Y%, %EndConfigSuporte%.ini, Loot, GetPosLoot22Y
IniWrite, %GetPosLoot23X%, %EndConfigSuporte%.ini, Loot, GetPosLoot23X
IniWrite, %GetPosLoot23Y%, %EndConfigSuporte%.ini, Loot, GetPosLoot23Y

IniWrite, %GetPosLoot31X%, %EndConfigSuporte%.ini, Loot, GetPosLoot31X
IniWrite, %GetPosLoot31Y%, %EndConfigSuporte%.ini, Loot, GetPosLoot31Y
IniWrite, %GetPosLoot32X%, %EndConfigSuporte%.ini, Loot, GetPosLoot32X
IniWrite, %GetPosLoot32Y%, %EndConfigSuporte%.ini, Loot, GetPosLoot32Y
IniWrite, %GetPosLoot33X%, %EndConfigSuporte%.ini, Loot, GetPosLoot33X
IniWrite, %GetPosLoot33Y%, %EndConfigSuporte%.ini, Loot, GetPosLoot33Y

IniWrite, %HUDX%, %EndConfigSuporte%.ini, Loot, HUDX
IniWrite, %HUDY%, %EndConfigSuporte%.ini, Loot, HUDY

;[PVP FUNCTIONS]
GuiControlGet, Key_Enable_Flower
IniWrite, %Key_Enable_Flower%, %EndConfigSuporte%.ini, Principal, Key_Enable_Flower

IniWrite, %GetPosFlowerX%, %EndConfigSuporte%.ini, Principal, GetPosFlowerX
IniWrite, %GetPosFlowerY%, %EndConfigSuporte%.ini, Principal, GetPosFlowerY

GuiControlGet, Key_Enable_Trash
IniWrite, %Key_Enable_Trash%, %EndConfigSuporte%.ini, Principal, Key_Enable_Trash
GuiControlGet, OpcaoTrash
IniWrite, %OpcaoTrash%, %EndConfigSuporte%.ini, Principal, OpcaoTrash

IniWrite, %GetPosTrash1X%, %EndConfigSuporte%.ini, Principal, GetPosTrash1X
IniWrite, %GetPosTrash1Y%, %EndConfigSuporte%.ini, Principal, GetPosTrash1Y
IniWrite, %GetPosTrash2X%, %EndConfigSuporte%.ini, Principal, GetPosTrash2X
IniWrite, %GetPosTrash2Y%, %EndConfigSuporte%.ini, Principal, GetPosTrash2Y

GuiControlGet, Key_Enable_PushItem
IniWrite, %Key_Enable_PushItem%, %EndConfigSuporte%.ini, Principal, Key_Enable_PushItem
IniWrite, %PushItemBPX%, %EndConfigSuporte%.ini, Principal, PushItemBPX
IniWrite, %PushItemBPY%, %EndConfigSuporte%.ini, Principal, PushItemBPY

;[Treinar]
GuiControlGet, Hotkey_Exercise
IniWrite, %Hotkey_Exercise%, %EndConfigSuporte%.ini, Principal, Hotkey_Exercise
GuiControlGet, ExerciseDelay
IniWrite, %ExerciseDelay%, %EndConfigSuporte%.ini, Principal, ExerciseDelay
GuiControlGet, POTDELAY
IniWrite, %POTDELAY%, %EndConfigSuporte%.ini, Principal, POTDELAY
GuiControlGet, POTTYPE
IniWrite, %POTTYPE%, %EndConfigSuporte%.ini, Principal, POTTYPE
GuiControlGet, QTDPOT
IniWrite, %QTDPOT%, %EndConfigSuporte%.ini, Principal, QTDPOT
}


SaveAtaque() {
Global


	;[Ataque]
IniWrite, %Nome_Char%, %EndConfigAtaque%.ini, Principal, Nome_Char
	;[Ataque]
IniWrite, %Ativa_Atk%, %EndConfigAtaque%.ini, Principal, Ativa_Atk




GuiControlGet LigarPrimo
IniWrite, %LigarPrimo%, %EndConfigAtaque%.ini, Principal, LigarPrimo
GuiControlGet Hotkey_ATK
IniWrite, %Hotkey_ATK%, %EndConfigAtaque%.ini, Principal, Hotkey_ATK
GuiControlGet Hotkey_Target
IniWrite, %Hotkey_Target%, %EndConfigAtaque%.ini, Principal, Hotkey_Target
GuiControlGet Target
IniWrite, %Target%, %EndConfigAtaque%.ini, Principal, Target
GuiControlGet TipoTarget
IniWrite, %TipoTarget%, %EndConfigAtaque%.ini, Principal, TipoTarget


IniWrite, %AtkRune1%, %EndConfigAtaque%.ini, Principal, AtkRune1
IniWrite, %AtkRune2%, %EndConfigAtaque%.ini, Principal, AtkRune2
IniWrite, %AtkRotacao1%, %EndConfigAtaque%.ini, Principal, AtkRotacao1
IniWrite, %AtkRotacao2%, %EndConfigAtaque%.ini, Principal, AtkRotacao2

GuiControlGet Rune1
IniWrite, %Rune1%, %EndConfigAtaque%.ini, AtkRune1, Rune1
GuiControlGet TimeDelay1
IniWrite, %TimeDelay1%, %EndConfigAtaque%.ini, AtkRune1, TimeDelay1

GuiControlGet Rune2
IniWrite, %Rune2%, %EndConfigAtaque%.ini, AtkRune2, Rune2
GuiControlGet TimeDelay2
IniWrite, %TimeDelay2%, %EndConfigAtaque%.ini, AtkRune2, TimeDelay2

GuiControlGet QuantidadeDeMagia1
IniWrite, %QuantidadeDeMagia1%,  %EndConfigAtaque%.ini, AtkRotacao1, QuantidadeDeMagia1
GuiControlGet MagiaRotacao1_1
IniWrite, %MagiaRotacao1_1%,  %EndConfigAtaque%.ini, AtkRotacao1, MagiaRotacao1_1
GuiControlGet MagiaRotacao1_2
IniWrite, %MagiaRotacao1_2%,  %EndConfigAtaque%.ini, AtkRotacao1, MagiaRotacao1_2
GuiControlGet MagiaRotacao1_3
IniWrite, %MagiaRotacao1_3%,  %EndConfigAtaque%.ini, AtkRotacao1, MagiaRotacao1_3
GuiControlGet MagiaRotacao1_4
IniWrite, %MagiaRotacao1_4%,  %EndConfigAtaque%.ini, AtkRotacao1, MagiaRotacao1_4
GuiControlGet TimeDelay3
IniWrite, %TimeDelay3%, %EndConfigAtaque%.ini, AtkRotacao1, TimeDelay3

GuiControlGet QuantidadeDeMagia2
IniWrite, %QuantidadeDeMagia2%,  %EndConfigAtaque%.ini, AtkRotacao2, QuantidadeDeMagia2
GuiControlGet MagiaRotacao2_1
IniWrite, %MagiaRotacao2_1%,  %EndConfigAtaque%.ini, AtkRotacao2, MagiaRotacao2_1
GuiControlGet MagiaRotacao2_2
IniWrite, %MagiaRotacao2_2%,  %EndConfigAtaque%.ini, AtkRotacao2, MagiaRotacao2_2
GuiControlGet MagiaRotacao2_3
IniWrite, %MagiaRotacao2_3%,  %EndConfigAtaque%.ini, AtkRotacao2, MagiaRotacao2_3
GuiControlGet MagiaRotacao2_4
IniWrite, %MagiaRotacao2_4%,  %EndConfigAtaque%.ini, AtkRotacao2, MagiaRotacao2_4
GuiControlGet TimeDelay4
IniWrite, %TimeDelay4%, %EndConfigAtaque%.ini, AtkRotacao2, TimeDelay4



IniWrite, %ForaPZ%, %EndConfigAtaque%.ini, Principal, ForaPZ
IniWrite, %Ativa_TankMode%, %EndConfigAtaque%.ini, Principal, Ativa_TankMode

GuiControlGet DelayNextTarget
IniWrite, %DelayNextTarget%, %EndConfigAtaque%.ini, Principal, DelayNextTarget

}

ValoresIniciais() {
Global

if FileExist("C:\PrimoConfigs\reload.ini"){
	GuiControlGet Nick_Tibia
	GuiControlGet User
	IniWrite, %User%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, User
	IniWrite, %Nick_Tibia%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Nick_Tibia
} else {
	IniRead, User, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, User
	IniRead, Nick_Tibia, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Nick_Tibia
}	

	IniRead, Account, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Account
	IniRead, Password, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Password


TimerConsecutive1 = 0
TimerConsecutive2 = 0

ReloadInicial = 0
IgnoreMana = 0
EquipandoSSA = 0
EquipandoMight = 0
PuxandoEnergyRing = 0
IgnoreMana = 0
VidaSioOK = 0

Cliente = 0
EsperandoLogar = 0

Ativa_Swap = 1

State_Pause1 = Iniciando
State_Pause = 0
PrimoAtaqueStatus = Ataque Desligado
QuickLootOn = Looter Desligado
StatusTankMode = TankMode Desligado

State_Pause = 0
Ativa_TankMode = 0

PosPushX1 = 0
PosPushY1 = 0

PosPushX2 = 0
PosPushY2 = 0
EsperandoLogar = 0
ImagemCliente = 0

Ativa_QuickLoot = 0	
Ativa_QuickLoot_Perm = 0
Ativa_Push = 0

ManaTraining = 0

DelayNextTarget = 1000

UUID = 0

	TimerManaTrain = 0
	TimerExercise = 0
	TimerBUYPOT = 0
	
GetPosLoot11X = 0
GetPosLoot11Y = 0
GetPosLoot12X = 0
GetPosLoot12Y = 0
GetPosLoot13X = 0
GetPosLoot13Y = 0

GetPosLoot21X = 0
GetPosLoot21Y = 0
GetPosLoot22X = 0
GetPosLoot22Y = 0
GetPosLoot23X = 0
GetPosLoot23Y = 0

GetPosLoot31X = 0
GetPosLoot31Y = 0
GetPosLoot32X = 0
GetPosLoot32Y = 0
GetPosLoot33X = 0
GetPosLoot33Y = 0

Delay_Consecutive1=10
Delay_Consecutive2=10
ExerciseDelay=120
TimeDelay=10
HealFriend1=SIO
HealFriend2=Sio
Tank_Amulet=SSA
TipoMagicShield=Energy Ring
POTDELAY=240
DelayLoot=50

GetPosDummyX=0
GetPosDummyY=0
GetPosFlowerX=0
GetPosFlowerY=0
GetPosTrash1X=0
GetPosTrash1Y=0
GetPosTrash2X=0
GetPosTrash2Y=0
PushItemBPX=0
PushItemBPY=0

CoordenadaX=0
CoordenadaY=0
CoordenadaXAux=0
CoordenadaX1=0
CoordenadaY1=0

YInicioMana=0
Xref_Life_PT1=0
Yref_Life_PT1=0
Xini_Life_PT1=0
Yini_Life_PT1=0
Xfim_Life_PT1=0
Yfim_Life_PT1=0
Xini_Char_tela_1=0
Yini_Char_tela_1=0
Xfim_Char_tela_1=0
Yfim_Char_tela_1=0
Yref_Life_PT3=0
Xini_Life_PT3=0
Yini_Life_PT3=0
Xfim_Life_PT3=0
Yfim_Life_PT3=0
Xini_Char_tela_3=0
Yini_Char_tela_3=0
Xfim_Char_tela_3=0
Yfim_Char_tela_3=0

CorVidaSSA = %CorDaVida%
CorManaSSA = %CorDaMana%
CorVidaMIGHT = %CorDaVida%
CorManaMIGHT = %CorDaMana%
EquipandoSSA = 0
} ; FIM

ZeraValoresDownload(){
global
CheckFile = 0
Date_until = 0
UUID_File = 0
}
;=======================================================================================================================================================================================================================
;===================================================================================================Menu Tray===========================================================================================================
;=======================================================================================================================================================================================================================
Pause_Script:
	if (State_Pause = 0) {
			if (WinExist("ahk_class Qt5QWindowOwnDCIcon")) {
				tooltip Script PARADO, %XTooltip%,%YTooltip%
				State_Pause = 1
				Ativa_QuickLoot = 0	
				Ativa_QuickLoot_Perm = 0
				Process, Close , 6.exe
				sleep 400
				tooltip
				return
			}
		}
		if (State_Pause = 1) {
			if (WinExist("ahk_class Qt5QWindowOwnDCIcon")) {
				tooltip Script RODANDO, %XTooltip%,%YTooltip%
				State_Pause = 0
				sleep 500
				tooltip
			}
		}
return

Reload:
	FileAppend, hello, 	C:\PrimoConfigs\windowscheck.ini
	FileAppend, reload, 	C:\PrimoConfigs\reload.ini
	FileSetAttrib, +H, C:\PrimoConfigs\windowscheck.ini
	Reload
return

GuiEscape:
GuiClose:
ExitSub:
Process, Close , 6.exe
Process, Close , 1.exe
Process, Close , 2.exe
Process, Close , 4.exe
Process, Close , 5.exe
Process, Close , 3.exe
Process, Close , 8.exe
Process, Close , 7.exe
ExitApp ; Terminate the script unconditionally