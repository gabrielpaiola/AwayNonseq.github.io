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

Process, Close , Primo Marcos.exe
Process, Close , Primo Marcos-BETA.exe
;==================================================================================
;================================================================================== Valores Iniciais
;==================================================================================
URL = https://primomarcos.com/usuarios/
URLData = https://primomarcos.com/data		
Address = C:\PrimoConfigs\gsdfa.ini
CheckFile = C:\PrimoConfigs\windowscheck.ini
ValoresIniciais()

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
;================================================================================== DOWNLOAD DATA ATUAL
;==================================================================================
IniRead, User, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, User
IniRead, Nick_Tibia, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Nick_Tibia

IniRead, Account, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Account
IniRead, Password, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Password

CheckDate()

EndConfigSuporte = C:\PrimoConfigs\ConfigSuporte%Nick_Tibia%
EndConfigAtaque = C:\PrimoConfigs\ConfigAtaque%Nick_Tibia%
EndConfigAtaque1 = %EndConfigAtaque%

Load()	

;==================================================================================
;================================================================================== Checa se abriu pelo Launcher
;==================================================================================

;FileReadLine, VersaoPrimo, 	%CheckFile%, 1
;FileDelete, C:\PrimoConfigs\windowscheck.ini
if !FileExist("C:\PrimoConfigs\windowscheck.ini"){
	If (VersaoPrimo <> Versao_Web) {
		Gui, -AlwaysOnTop
		msgbox, ABRA DIRETO PELO LAUNCHER!!!!!!!
		ExitApp
	}
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
Gui, Add, Button, x215 y25 w40 h20 												gClearUser, Clear
Gui, Add, Button, x152 y80 w70 h20 												gCheckChars, Check
Gui, Add, Button, x152 y110 w70 h20												gLogin, Login
Gui, Show, % " w" GUIWidth " h" GUIHeight, Primo Login
}

if !FileExist("C:\PrimoConfigs\reload.ini"){
		goto Login
} 

return

DownloadFile(){
global
GuiControlGet, User
GuiControlGet, Nick_Tibia



IniWrite, %User%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, User
IniWrite, %Nick_Tibia%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Nick_Tibia
	
FileDelete, 					%Address%
UrlDownloadToFile, 				%URL%%User%.html, %Address%
FileReadLine, CheckFile, 		%Address%, 2
FileReadLine, Date_until, 		%Address%, 9
FileReadLine, UUID_File,		%Address%, 11
FileReadLine, UUID_File1,		%Address%, 12
FileReadLine, UUID_File2,		%Address%, 13
FileDelete,						%Address%

	
} ; Fim Download Files

;==================================================================================
CheckChars:
ZeraValoresDownload()
DownloadFile()
	if  (User == "") {
		Gui, -AlwaysOnTop
		MsgBox, digite um usuario valido.
		return
	} else if (CheckFile <> "PrimoMarcosCode") {
		Gui, -AlwaysOnTop
		MsgBox, Usuario nao encontrado!
		FileDelete, %Address%
		return
	}
	
	If ((UUID_File <> UUID()) and (UUID_File1 <> UUID()) and (UUID_File2 <> UUID())){
		Gui, -AlwaysOnTop
		msgbox, Computador NAO autorizado para uso.`nEntre em contato com o Fornecedor.
	} else {
		if (Data_Hoje > Date_until) {
			Gui, -AlwaysOnTop
			msgbox, Computador autorizado.`n`nUsuario: %User%`nSeu Contrato expirou.`nEntre em contato.
		} else if (Data_Hoje <= Date_until) {
			Gui, -AlwaysOnTop
			msgbox, Computador autorizado.`nVoce tem mais %DifDate% dia(s).`nBom jogo.
		}
	}
ZeraValoresDownload()
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

	ZeraValoresDownload()
	DownloadFile()
	ValoresIniciais()

	If (((UUID_File == UUID()) or (UUID_File1 == UUID()) or (UUID_File2 == UUID())) and (Data_Hoje<=Date_until)) {
		gui, destroy
		GuiMain()
		
WinGetPos, Tibia_X, Tibia_Y, Tibia_Width1, Tibia_Height1, Tibia - %Nome_Char%
Tibia_Width = % Tibia_Width1 + Tibia_X
Tibia_Height = % Tibia_Height1 + Tibia_Y
XTooltip = % Tibia_Width / 2
YTooltip = % Tibia_Height / 2


		Settimer StartGeral, 100
		Settimer Save_Config, 3000
		Settimer Save_Config_Ataque, 1000
		Settimer CheckValidade, 6000
		Settimer Scriptsrapidos, 100
	} ; DATA e login OK
return
;==================================================================================
ClearUser:
User =
Nick_Tibia =
IniWrite, %User%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, User
IniWrite, %Nick_Tibia%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Nick_Tibia
return

;==================================================================================
;================================================================================== GUI Geral
;==================================================================================
GUIMain() {
	Global

;==================================================================================
Nome_Char = %Nick_Tibia%


;==================================================================================
	
if !FileExist(EndConfigSuporte ".ini"){
	FileRead, CONTEUDO_Suporte, Complementos\Configs\Padrao\ConfigSuporte.ini
	FileAppend, %CONTEUDO_Suporte%, %EndConfigSuporte%.ini
		sleep 1000
}
if !FileExist(EndConfigAtaque ".ini"){
	FileRead, CONTEUDO_Ataque, Complementos\Configs\Padrao\ConfigAtaque.ini
	FileAppend, %CONTEUDO_Ataque%, %EndConfigAtaque%.ini
		sleep 1000
}	

	
Load()	

	GUIWidth := 590, GUIHeight := 610
	
	
	Menu, Tray, Icon, Complementos\ICONS\Skull.png    ;Change the tray icon
	Menu, Tray, Tip, Primo Marcos ; Change the tooltip of the tray icon
	Menu, Tray, Add, Reload, Reload

	
	Gui, +AlwaysOnTop ; FUNCAO ATIVA, DEIXA MACRO SEMPRE NA FRENTE DA TELA
	Gui, +LastFound -Resize +Theme
	Gui, Color, 202124 ;b2b2b2 ;FFFFFF
	Gui, Font, cFFFFFF
	Gui, Margin, 10, 10
	
	Gui, Add, Button, 		x460	y5 	w80 	h15 		gExitSub, EXIT

	Gui, add, Text, 		x440	y30						 	,%Nick_Tibia%
	Gui, Add, edit,			x440	y50	w120		ReadOnly	hwndScriptPausado, ScriptPausado
	Gui, Add, Button, 		x460	y75 	w80 	h15 		gLoad_Images, Reload Images

	;Gui, add, text,			x440	y120						,Tank Mode Hotkey
	;Gui, Add, Hotkey, 		x440	y136 	w85					vHabilita_TankMode, %Habilita_TankMode%	
	
	Gui, Add, edit,			x440	y160 	w110	ReadOnly 	hwndStatusTank, StatusTank
	Gui, Add, edit,			x440	y185	w110	ReadOnly 	hwndStatusAtaque, StatusAtaque
	Gui, Add, edit,			x440	y210	w110	ReadOnly 	hwndStatusLooter, StatusLooter
	
	Gui, Add, CheckBox, 	x440	y235 				 		vQuickLooter, Quick Loot

	
	Gui, Add, text, 		x440	y340		w70				,Pause Hotkey
	Gui, Add, Hotkey, 		x440	y360		w70				vHotkey_Pause, %Hotkey_Pause%
	
	Gui, Add, text, 		x440	y385						,Ciclo do Macro (ms)
	Gui, add, Edit, 		x440	y400	cFF0000	w70			vDelayMacro, %DelayMacro%
	
	
	Gui, Add, Button, 		x460 	y435 	w80	H15				gReload, Reload Macro
	
	Gui, Add, edit,			x435	y457	w150 h40	ReadOnly	 	hwndmyedit, myedit
	
Gui,Add,Tab3,x1 y5 w430 h600 ,Self Heal||Support|Defender|Sio|Ataque|Uteis|PVP|Looter|Help   ;create a tab control

;===============================================================================================
Gui,Tab,Self Heal   ; enter tab 1=============================================================== HEALING
;===============================================================================================	


	Gui, add, text,			x365	y64							,Hotkeys

Intervalo = 25

	;================================= [LIFE AUTO HEALING] ;=================================
	Gui, Add, GroupBox, 	x5 		y29 	w420 	h125		,Auto Self Heal
	;Gui, Add, text, 		x7		y33		w120				,Auto Self Heal
	Gui, Add, CheckBox, 	x7 		y52 		 	h20 		vLife_AutoHealing, [HEALTH]
	;=================================STAGE1
	Gui, Add, Slider, 		x7		y80				h20			vPercent_Life_Stage1 Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %Percent_Life_Stage1%
	Gui, Add, text, 		x130	y80		w120				,Light Life Heal
	;Gui, Add, Picture, 	x130	y82 	w32 	h32, 		Complementos\ICONS\Health.ico
	Gui, Add, Hotkey, 		x365	y80		w45					vHotkey_Life_Stage1, %Hotkey_Life_Stage1%
	;=================================STAGE2
	Gui, Add, Slider, 		x7		y100			h20			vPercent_Life_Stage2 Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %Percent_Life_Stage2%
	Gui, Add, text, 		x130	y100	w120				,Medium Life Heal
	;Gui, Add, Picture,		x130	y95 	w32 	h32, 		Complementos\ICONS\GreatHealth.ico
	Gui, Add, Hotkey, 		x365	y100	w45					vHotkey_Life_Stage2, %Hotkey_Life_Stage2%
	;=================================STAGE3
	Gui, Add, Slider, 		x7		y120			h20			vPercent_Life_Stage3 Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %Percent_Life_Stage3%
	Gui, Add, text, 		x130	y120	w120				,Heavy Life Heal
	;Gui, Add, Picture, 	x134	y117 	w23 	h23, 		Complementos\ICONS\SupremeHealth.ico
	Gui, Add, Hotkey, 		x365	y120	w45					vHotkey_Life_Stage3, %Hotkey_Life_Stage3%
	
	;================================= [MANA AUTO HEALING] ;=================================
	Gui, Add, GroupBox, 	x5 		y155 	w420 	h95			,Auto Self Mana
	Gui, Add, CheckBox,		x7		y175			h20 		vMana_AutoHealing, [MANA]
	;=================================STAGE1
	Gui, Add, Slider, 		x7		y198			h20			vPercent_Mana_Stage1 Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %Percent_Mana_Stage1%
	Gui, Add, text, 		x130	y198	w120				,Medium Mana Heal
	;Gui, Add, Picture, 	x130	y191 	w32 	h32, 		Complementos\ICONS\ManaPotion.ico
	Gui, Add, Hotkey, 		x365	y193	w45					vHotkey_Mana_Stage1, %Hotkey_Mana_Stage1%
	;=================================STAGE2 
	Gui, Add, Slider, 		x7		y218			h20			vPercent_Mana_Stage2 Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %Percent_Mana_Stage2%
	Gui, Add, text, 		x130	y218	w120				,Heavy Mana Heal
	;Gui, Add, Picture, 	x134	y216 	w23 	h23, 		Complementos\ICONS\UltimateMana.ico
	Gui, Add, Hotkey, 		x365	y213	w45					vHotkey_Mana_Stage2, %Hotkey_Mana_Stage2%
	
	
	
	;=================================[Utamo / Energy Ring] ;=================================
	Gui, Add, GroupBox, 	x5 		y250 	w420 	h200		,Auto Swap Energy Ring / Utamo Vita
	Gui, Add, Picture,		x150	y270	w32		h32,		Complementos\ICONS\EnergyRing.ico
	Gui, Add, CheckBox,		x7		y274			h20 		vEnergy_Ring, [MAGIC SHIELD]
	Gui, Add, DropDownList, x250	y270	w85					vTipoMagicShield, %TipoMagicShield%||Energy Ring|Utamo Vita
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
	Gui, add, text,			x330	y325						,EQUIP/Utamo Vita
	Gui, Add, Hotkey, 		x365	y340	w45					vHotkey_Energy_Ring, %Hotkey_Energy_Ring%
	Gui, add, text,			x320	y375						,DeEQUIP/Exana Vita
	Gui, Add, Hotkey, 		x365	y390	w45					vHotkey_DeEnergy_Ring, %Hotkey_DeEnergy_Ring%
	;=================================Ring ou Utamo ;=================================
	

;===============================================================================================
Gui,Tab, 2 ; ===================================================================================  SUPORTE
;===============================================================================================


	Gui, Add, text, 		x7		y33		w120				, Support Functions
	Gui, add, text,			x130	y55							,Hotkeys
	;================================= [Food] ;=================================
	Gui, Add, Picture, 		x7		y65 	w32 	h32, 		Complementos\ICONS\dragon_ham.ico
	Gui, Add, CheckBox, 	x47		y70	 		 	h20 		vEAT, [FOOD]
	Gui, Add, Hotkey, 		x127	y70		w45					vHotkey_Eat, %Hotkey_Eat%
	;================================= [BUFF] ;=================================
	Gui, Add, Picture, 		x185	y65 	w32 	h32, 		Complementos\ICONS\Buff.ico
	Gui, Add, CheckBox, 	x223	y70	 		 	h20 		vPotBuff, [BUFF]
	Gui, Add, Hotkey, 		x283	y70		w45					vHotkey_PotBuff, %Hotkey_PotBuff%
	;================================= [Haste] ;=================================
	Gui, Add, Picture, 		x7		y105 	w32 	h32, 		Complementos\ICONS\boh.ico
	Gui, Add, CheckBox, 	x47		y110 		 	h20 		vHaste, [HASTE] 
	Gui, Add, Hotkey, 		x127	y110	w45					vHotkey_Haste, %Hotkey_Haste%
	;================================= [Renew Boots] ;=================================
	Gui, Add, Picture, 		x185	y105 	w32 	h32, 		Complementos\ICONS\prismaticboots.ico
	Gui, Add, CheckBox, 	x223	y110 		 	h20 		vBoots, [Boots] 
	Gui, Add, Hotkey, 		x283	y110	w45					vHotkey_Boots, %Hotkey_Boots%
	;================================= [Paralize] ;=================================
	Gui, Add, Picture, 		x7		y145 	w32 	h32, 		Complementos\ICONS\Paralize.ico
	Gui, Add, CheckBox, 	x47		y150 		 	h20 		vParalize, [PARALIZE]
	Gui, Add, Hotkey, 		x127	y150	w45					vHotkey_Paralize, %Hotkey_Paralize%	
	;================================= [Amulet] ;=================================
	Gui, Add, Picture, 		x8		y190 	w32 	h32, 		Complementos\ICONS\NoAmulet.ico
	Gui, Add, CheckBox, 	x47		y195 		 	h20 		vAmulet, [AMULET]
	Gui, Add, Hotkey, 		x127	y195	w45					vAmulet_Hotkey, %Amulet_Hotkey%	
	;================================= [Ring] ;=================================
	Gui, Add, Picture, 		x185	y190 	w32		h32, 		Complementos\ICONS\NoRing.ico
	Gui, Add, CheckBox, 	x223	y195 		 	h20 		vRing, [RING]
	Gui, Add, Hotkey, 		x283	y195	w45					vHotkey_Ring, %Hotkey_Ring%	
	;================================= [Utamo Vita] ;=================================
	Gui, Add, Picture, 		x1		y233 	w42 	h42, 		Complementos\ICONS\Utamo.ico
	Gui, Add, CheckBox, 	x47		y234 		 	h20 		vUtamoVita, [Utamo Vita]
	Gui, Add, Hotkey, 		x127	y234	w45					vHotkey_Utamo, %Hotkey_Utamo%	
	Gui, Add, CheckBox, 	x47		y254 		 	h20 		vPotUtamoVita, [Pot Utamo]
	Gui, Add, Hotkey, 		x127	y254	w45					vHotkey_PotUtamo, %Hotkey_PotUtamo%	
	Gui, add, Text, 		x7 		y290						,Simbolo Utamo Vita na Barra
	Gui, Add, DropDownList, x7		y310	w85					vTipoUtamo, |GLOBAL||OT
	;================================= [Quiver] ;=================================
	Gui, Add, Picture, 		x185	y230 	w32		h32, 		Complementos\ICONS\QuiverAzul0.png
	Gui, Add, CheckBox, 	x223	y230 		 	h20 		vQuiver, [Quiver]
	Gui, Add, Hotkey, 		x283	y230	w45					vHotkey_Quiver, %Hotkey_Quiver%	
	
;===============================================================================================
Gui,Tab, 3 ; =================================================================================== DEFENDER
;===============================================================================================

	
	Gui, Add, text, 		x7		y33		w120				, Defender Function
	
	Gui, Add, GroupBox, 	x5 		y310 	w420 	h70			,TANK MODE FUNCTION
	Gui, add, text,			x10		y330						,Key to Active (need to set the hotkeys in SSA and MIGHT ring to work)
	Gui, Add, Hotkey, 		x10		y350 	w85					vHabilita_TankMode, %Habilita_TankMode%	
	
	Gui, add, text,			x365	y45							,Hotkeys

	;================================= [SSA] ;=================================
	Gui, Add, Picture, 		x7 		y64 	w32 	h32, 		Complementos\ICONS\ssa.ico
	Gui, Add, CheckBox,		x42 	y72 		 	h20 		vSSA, [SSA] Auto
	Gui, Add, DropDownList, x7		y105	w85					vTank_Amulet, %Tank_Amulet%||SSA|Shockwave|Sacred|Leviathan
	Gui, Add, Slider, 		x130	y72				h20			vSSA_Life Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %SSA_Life%
	Gui, add, Text, 		x253 	y74							,Life Percent
	Gui, Add, Slider, 		x130	y102			h20			vSSA_Mana Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %SSA_Mana%
	Gui, add, Text, 		x253 	y104						,Mana Percent
	Gui, Add, Hotkey, 		x365	y72		w45					vSSA_Hotkey, %SSA_Hotkey%
	;================================= [MIGHT] ;=================================
	Gui, Add, Picture, 		x9 		y145 	w32 	h32, 		Complementos\ICONS\might.ico
	Gui, Add, CheckBox, 	x42 	y150 		 	h20 		vMIGHT, [MIGHT] Auto
	Gui, Add, CheckBox, 	x42 	y170 		 	h20 		vForcaMight, [Force]
	Gui, Add, Slider, 		x130	y150			h20			vMight_Life Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %Might_Life%
	Gui, add, Text, 		x253 	y152						,Life Percent
	Gui, Add, Slider, 		x130	y180			h20			vMight_Mana Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %Might_Mana%
	Gui, add, Text, 		x253 	y182						,Mana Percent
	Gui, Add, Hotkey, 		x365	y160	w45					vMight_Hotkey, %Might_Hotkey%
	;================================= [FOOD VIDA] ;=================================
	Gui, Add, Picture, 		x9 		y230 	w32 	h32, 		Complementos\ICONS\cupcakehp.ico
	Gui, Add, CheckBox, 	x42 	y238 		 	h20 		vFOODHP, [FOOD] HP
	Gui, Add, Slider, 		x130	y238			h20			vPercentFOODHP Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %PercentFOODHP%
	Gui, add, Text, 		x253 	y240						,Life Percent
	Gui, Add, Hotkey, 		x365	y238	w45					vHotkeyFOODHP, %HotkeyFOODHP%
	;================================= [FOOD MANA] ;=================================
	Gui, Add, Picture, 		x9 		y270 	w32 	h32, 		Complementos\ICONS\cupcakemp.ico
	Gui, Add, CheckBox, 	x42 	y278 		 	h20 		vFOODMP, [FOOD] MP
	Gui, Add, Slider, 		x130	y278			h20			vPercentFOODMP Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %PercentFOODMP%
	Gui, add, Text, 		x253 	y280						,Mana Percent
	Gui, Add, Hotkey, 		x365	y278	w45					vHotkeyFOODMP, %HotkeyFOODMP%
	
;===============================================================================================
Gui,Tab, 4 ; ===================================================================================  SIO FRIEND
;===============================================================================================

	Gui, Add, text, 		x7		y33							, Friend Heal Function
	
	Gui, add, Text, 		x7 		y55							,Vida minima do ED para dar SIO
	Gui, Add, Slider, 		x7		y75				h20			vPercentSelfHealth Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %PercentSelfHealth%
	
	Gui, add, Text, 		x250	y55							,Mana minima do ED para dar SIO
	Gui, Add, Slider, 		x250	y75				h20			vPercentSelfMana Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %PercentSelfMana%
	;================================= [SIO EK] ;=================================
	;================================= Sio ;=================================
	Gui, add, Text, 		x7 		y145						,Sio 1º Pessoa Party List [PRINCIPAL]
	Gui, add, Text, 		x265 	y145						,HEALTH PERCENT
	Gui, Add, Picture, 		x0 		y174		w40		h40, 	Complementos\ICONS\ek.ico
	Gui, Add, CheckBox,		x42 	y174 				 		vSIOEK, [HealFriend1]
	Gui, add, Text, 		x140	y178						,HK SIO/UH
	Gui, Add, Hotkey, 		x200	y174		w45				vHotkey_SIO_1, %Hotkey_SIO_1%
	Gui, Add, Slider, 		x255	y174				h20		vPercentSIO1 Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %PercentSIO1%
	Gui, Add, Slider, 		x255	y214				h20		vPercentGranSIO1 Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %PercentGranSIO1%
	;================================= Gran Sio ;=================================
	Gui, add, Text, 		x135	y214						,HK Gran SIO
	Gui, Add, Hotkey, 		x200	y210	w45					vHotkey_GranSIO_1, %Hotkey_GranSIO_1%
	Gui, Add, DropDownList, x7		y216	w85					vHealFriend1, %HealFriend1%||SIO|UH
	;================================= [SIO RP] ;=================================
	;================================= Sio ;=================================
	Gui, add, Text, 		x7 		y283						,Sio 2º Pessoa Party List [SECUNDARIO]
	Gui, add, Text, 		x265 	y283						,HEALTH PERCENT
	Gui, Add, Picture, 		x0 		y303 	w48 	h48, 		Complementos\ICONS\rp.ico
	Gui, Add, CheckBox, 	x42 	y308 		 	h20 		vSIORP, [HealFriend2]
	Gui, add, Text, 		x140	y312						,HK SIO/UH
	Gui, Add, Hotkey, 		x200	y308	w45					vHotkey_SIO_2, %Hotkey_SIO_2%
	Gui, Add, Slider, 		x255	y308				h20		vPercentSIO3 Range0-100 TickInterval%Intervalo% +tooltip AltSubmit, %PercentSIO3%
	Gui, Add, DropDownList, x7		y340	w85					vHealFriend2, %HealFriend2%||SIO|UH

;===============================================================================================
Gui,Tab, 5 ; ===================================================================================  ATAQUE
;===============================================================================================

	Gui, Add, text, 		x7		y33							,Key to Active Attack
	Gui, Add, Hotkey, 		x120	y33		w60					vHotkey_ATK, %Hotkey_ATK%
	;================================= Selecionar Tipo de Ataque ;=================================
	Gui, Add, text, 		x7		y60							,Selecionar Tipo de Ataque
	Gui, Add, DropDownList, x7		y78		w85					vTipoAtaque, Desligado||Rune1|Rune2|Rotacao1|Rotacao2
	;================================= Auto Target ;=================================
	Gui, Add, text, 		x250	y33							,Hotkey Next Target
	Gui, Add, Hotkey, 		x360	y33		w70					vHotkey_Target, %Hotkey_Target%
	Gui, Add, text, 		x245	y53							,Delay Next Target (ms)
	Gui, add, Edit, 		x360	y53	w70	cFF0000				vDelayNextTarget, %DelayNextTarget%
	
	Gui, Add, text, 		x217	y82							,Escolha Opcao de target
	Gui, Add, DropDownList, x340	y78		w85					vTipoTarget, Desligado||First Target
	
	Gui, add, Text, 		x10		y173	w70					,Hotkey
	Gui, add, Text,			x10		y193	w70					,Delay
	;================================= [RUNE 1] ;=================================
	Gui, Add, GroupBox, 	x5 		y150 	w135 	h70			,[Rune / Spell] 1
;	Gui, Add, Picture, 		x7 		y124 	w32 	h32, 		Complementos\ICONS\SD.ico
;	Gui, add, Text,			x42		y132	w70					,Rune 1
	Gui, Add, Hotkey, 		x60		y170	w70					vRune1, %Rune1%
	Gui, add, Edit, 		x60		y190	w70	cFF0000			vTimeDelay1, %TimeDelay1%
	;================================= [RUNE 2] ;=================================
	Gui, add, Text, 		x161	y173	w70					,Hotkey
	Gui, add, Text,			x161	y193	w70					,Delay
	
	Gui, Add, GroupBox, 	x155	y150 	w135 	h70			,[Rune / Spell] 2
;	Gui, Add, Picture,		x161	y124		w32		h32,	Complementos\ICONS\Fireball.ico
;	Gui, add, Text,			x198		y132	w70				,Rune 2
	Gui, Add, Hotkey, 		x214	y170	w70					vRune2, %Rune2%
	Gui, add, Edit, 		x214	y190	w70	cFF0000			vTimeDelay2, %TimeDelay2%
	
	
	;================================= Textos Rotacao de magia ;=================================
	Gui, add, Text,			x7		y273	w70					,Qtd
	Gui, add, Text, 		x10		y293	w70					,Hotkey1
	Gui, add, Text,			x10		y313	w70					,Hotkey2
	Gui, add, Text,			x10		y333	w70					,Hotkey3
	Gui, add, Text, 		x10		y353	w70					,Hotkey4
	Gui, add, Text,			x10		y373	w70					,Delay
	;================================= [ROTAÇÃO 1] ;=================================
	Gui, Add, GroupBox, 	x7		y250 	w135 	h150		,[Rotacao de Magias] 1
;	Gui, Add, Picture, 		x7 		y234	w32		h32, 		Complementos\ICONS\magia1.ico
;	Gui, add, Text,			x42		y240	w70					,Rotacao 1
	Gui, Add, DropDownList, x60		y270	w70					vQuantidadeDeMagia1, %QuantidadeDeMagia1%||2|3|4
	Gui, Add, Hotkey, 		x60		y290	w70					vMagiaRotacao1_1, %MagiaRotacao1_1%
	Gui, Add, Hotkey, 		x60		y310	w70					vMagiaRotacao1_2, %MagiaRotacao1_2%
	Gui, Add, Hotkey, 		x60		y330	w70					vMagiaRotacao1_3, %MagiaRotacao1_3%
	Gui, Add, Hotkey, 		x60		y350	w70					vMagiaRotacao1_4, %MagiaRotacao1_4%
	Gui, add, Edit, 		x60		y370	w70	cFF0000			vTimeDelay3, %TimeDelay3%
	;================================= Textos Rotacao de magia ;=================================
	Gui, add, Text,			x161	y273	w70					,Qtd
	Gui, add, Text, 		x161	y293	w70					,Hotkey1
	Gui, add, Text,			x161	y313	w70					,Hotkey2
	Gui, add, Text,			x161	y333	w70					,Hotkey3
	Gui, add, Text, 		x161	y353	w70					,Hotkey4
	Gui, add, Text,			x161	y373	w70					,Delay
	;================================= [ROTAÇÃO 2] ;=================================
	Gui, Add, GroupBox, 	x155	y250 	w135 	h150		,[Rotacao de Magias] 2
;	Gui, Add, Picture,		x161	y234	w32		h32,		Complementos\ICONS\magia2.ico 
;	Gui, add, Text,			x198		y240	w70				,Rotacao 2
	Gui, Add, DropDownList, x214	y270	w70					vQuantidadeDeMagia2, %QuantidadeDeMagia2%||2|3|4
	Gui, Add, Hotkey, 		x214	y290	w70					vMagiaRotacao2_1, %MagiaRotacao2_1%
	Gui, Add, Hotkey, 		x214	y310	w70					vMagiaRotacao2_2, %MagiaRotacao2_2%
	Gui, Add, Hotkey, 		x214	y330	w70					vMagiaRotacao2_3, %MagiaRotacao2_3%
	Gui, Add, Hotkey, 		x214	y350	w70					vMagiaRotacao2_4, %MagiaRotacao2_4%
	Gui, add, Edit, 		x214	y370	w70		cFF0000		vTimeDelay4, %TimeDelay4%
	
	;================================= [Safe Mode] ;=================================
	Gui, Add, GroupBox, 	x7		y420 	w283 	h150		,ALERTS / ALARMS
	Gui, Add, CheckBox, 	x7		y440						vSafe_Mode, Detect Player on Screen
	Gui, Add, CheckBox, 	x7		y460						vSafe_StopAttack, Stop Auto Attack if player on screen
	
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
	Gui, Add, DropDownList, x120	y275	w55					vPOTTYPE, GMP||MP|SMP|UMP
	Gui, add, Edit, 		x20		y300	w60	cFF0000			vPOTDELAY, %POTDELAY%
	Gui, Add, Text,			x85		y305						,SEGUNDOS
	Gui, Add, edit,			x20		y325	w40 ReadOnly 		hwndTimerBUYPOT1, 0
	
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
	Gui, Add, GroupBox, 	x5 		y480 	w420 	h115		,CONSECUTIVE FUNCTIONS
	
	Gui, Add, CheckBox, 	x7 		y500	 	h20		 		vConsecutiveFunction1, [FUNCTION 1] (exemple: wild grow - HK + POS)
	Gui, Add, Hotkey, 		x7		y520	w60					vHotkey_Consecutive1, %Hotkey_Consecutive1%
	Gui, add, Edit, 		x75		y520	w60	cFF0000			vDelay_Consecutive1, %Delay_Consecutive1%
	Gui, Add, Text,			x140	y523						,SEGUNDOS

	Gui, Add, Button,		x7		y550	w80					gGetPosConsecutive, Get Pos
	
	Gui, Add, Text,			x110	y555						,X
	Gui, Add, Text,			x110	y575						,Y
	Gui, Add, edit,			x120	y550	w40 h20	ReadOnly	hwndGuiPosConsecutive1X
	Gui, Add, edit,			x120	y570	w40 h20	ReadOnly	hwndGuiPosConsecutive1Y
	;=================================
	Gui, Add, CheckBox, 	x270	y500	 	h20		 		vConsecutiveFunction2, [FUNCTION 2] (ONLY HK)
	Gui, Add, Hotkey, 		x270	y520	w60					vHotkey_Consecutive2, %Hotkey_Consecutive2%
	Gui, add, Edit, 		x345	y520		w60	cFF0000		vDelay_Consecutive2, %Delay_Consecutive2%
	Gui, Add, Text,			x345	y545						,SEGUNDOS
	
;===============================================================================================
Gui,Tab, 7 ; ===================================================================================  PVP Functions
;===============================================================================================
	;================================= Flower ;=================================
	Gui, Add, GroupBox, 	x5 		y29 w420 h65 +Left			,Flower (Mouse Cursor)
	Gui, Add, Text, 		x192	y44 w155 h20 +Center		,Coordinates
	Gui, Add, Text, 		x192 	y67 w20 h15 				,X =
	Gui, Add, Text, 		x266 	y67 w20 h15 				,Y =
	Gui, Add, Text, 		x117 	y44 w70 h20 +Center			,Key To active
	Gui, Add, Picture, 		x12 	y49 w32 h32 				,Complementos\ICONS\Flower.ico
	Gui, Add, CheckBox, 	x46 	y49 w60 h32 				vFlower, Flower
	Gui, Font, cBlack
	Gui, Add, Hotkey, 		x117 	y65 w70 h20 				vKey_Enable_Flower,%Key_Enable_Flower%
	Gui, Font, cRed
	Gui, Add, edit,			x213	y65	w50 h20	ReadOnly		hwndGUIFlowerX, 0 
	Gui, Add, edit,			x287	y65	w50 h20	ReadOnly		hwndGUIFlowerY, 0 
	Gui, Font, cWhite
	Gui, Add, Button, 		x345 	y49 w70 h30 				gSelectCoordinatesFlower, Select Coordinates
	
	;================================= Tash SQM ;=================================
	Gui, Add, GroupBox, 	x5 		y99 w420 h130 				,Trash (Mouse Cursor)
	Gui, Add, Text, 		x192	y114 w155 h20 +Center		,Coordinates
	Gui, Add, Text, 		x192 	y137 w20 h15 				,X =
	Gui, Add, Text, 		x266 	y137 w20 h15 				,Y =
	Gui, Add, Text, 		x117 	y139 w70 h20 				, Key To active
	Gui, Add, Picture, 		x12 	y129 w32 h32  				,Complementos\ICONS\Worm.ico
	Gui, Add, CheckBox, 	x46 	y129 w60 h32 				vTrash1, Trash 1
	Gui, Font, cBlack
	Gui, Add, Hotkey, 		x117 	y165 w70 h20 				vKey_Enable_Trash,  %Key_Enable_Trash%
	Gui, Font, cRed
	Gui, Add, edit,			x213	y135	w50 h20	ReadOnly		hwndGUIGetPosTrash1X, 0 
	Gui, Add, edit,			x287	y135	w50 h20	ReadOnly		hwndGUIGetPosTrash1Y, 0 
	Gui, Font, cWhite
	Gui, Add, Button, 		x345 	y119 w70 h30 				gSelectCoordinatesTrash1, Select Coordinates
	Gui, Add, Text, 		x192 	y197 w20 h15 				,X =
	Gui, Add, Text, 		x266	y197 w20 h15 				,Y =
	Gui, Add, Picture, 		x12 	y169 w32 h32 				,Complementos\ICONS\Cherry.ico
	Gui, Add, CheckBox, 	x46 	y169 w60 h32 				vTrash2, Trash 2
	Gui, Font, cRed
	Gui, Add, edit,			x213	y195	w50 h20	ReadOnly		hwndGUIGetPosTrash2X, 0 
	Gui, Add, edit,			x287	y195	w50 h20	ReadOnly		hwndGUIGetPosTrash2Y, 0 
	Gui, Font, cWhite
	Gui, Add, Button, 		x345 	y179 w70 h30 				gSelectCoordinatesTrash2, Select Coordinates

	;================================= Item to BP ;=================================	
	Gui, Add, GroupBox,		x5 		y234 w420 h65 				,Push item to Backpack
	Gui, Add, Text, 		x192 	y244 w155 h20 +Center		,Coordinates
	Gui, Add, Text,			x192 	y267 w20 h15 				, X =
	Gui, Add, Text, 		x266 	y267 w20 h15 				, Y =
	Gui, Add, Text, 		x112 	y249 w70 h20 				, Key To active
	Gui, Add, Picture, 		x12 	y254 w32 h32 				,Complementos\ICONS\Backpack.ico
	Gui, Add, CheckBox, 	x46 	y254 w60 h32 				vPushItem, Push item
	Gui, Font, cBlack
	Gui, Add, Hotkey, 		x112 	y270 w70 h20 				vKey_Enable_PushItem, %Key_Enable_PushItem%
	Gui, Font, cRed
	Gui, Add, edit,			x213	y265	w50 h20	ReadOnly		hwndGUIPushItemBPX, 0 
	Gui, Add, edit,			x287	y265	w50 h20	ReadOnly		hwndGUIPushItemBPY, 0 
	Gui, Font, cWhite
	Gui, Add, Button, 		x345 	y249 w70 h30 				gSelectCoordinatesPushItem, Select Coordinates	
	
	
	
	
	
	
	
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
	Gui, Add, Hotkey, 		x7		y130	w70					vHotkey_Quickloot, %Hotkey_Quickloot%	
	Gui, Add, Text,			x7		y115							,Key to quickloot one time
	;================================= Stop Quick Loot ;=================================
	Gui, Add, Button,		x7		y170						gDesligaQuickLoot, Disable Quick Loot
	
	Gui, Add, GroupBox, 	x7 		y300 	w420 	h200		,ATENCAO
	Gui, Add, Text,			x13		y320						,Para utilizar o quick loot, voce primeiro deve selecionar os 3 SQM 
	Gui, Add, Text,			x17		y340						,conforme indicado na foto acima, clique em GET POS 1 e selecione o SQM do seu 
	Gui, Add, Text,			x17		y360						,norte esquerda,  depois GET POS 2 e selecione o SQM do centro por fim GET POS 3
	Gui, Add, Text,			x17		y380						,e selecione o SQM do sul direita (exetamente como indicado na foto).
	Gui, Add, Text,			x13		y440						,O QUICK LOOT POR ENQUANTO ESTA UTILIZANDO
	Gui, Add, Text,			x17		y460						,SOMENTE O SHIFT + RIGHT MOUSE BUTTON
	
	
	gui,add,picture,		x190 	y30 						hwndmypic,Complementos\Imagens\looter.png

	Gui, Add, Button,		x195	y35							gGetPosLoot11, Get Pos 1
	;================================= Pos 11 ;=================================
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
	
	Gui, Add, Button,		x275	y110						gGetPosLoot22, Get Pos 2
	;================================= Pos 21 ;=================================
	Gui, Add, Text,			x195	y138						,X=
	Gui, Add, edit,			x207	y135 w40 h20	ReadOnly	hwndXguipos21, Xguipos21
	Gui, Add, Text,			x195	y158						,Y=
	Gui, Add, edit,			x207	y155 w40 h20	ReadOnly	hwndYguipos21, Yguipos21
	;================================= Pos 22 ;=================================
	Gui, Add, Text,			x275	y138						,X=
	Gui, Add, edit,			x288	y135 w40 h20	ReadOnly	hwndXguipos22, Xguipos22
	Gui, Add, Text,			x275	y158						,Y=
	Gui, Add, edit,			x288	y155 w40 h20	ReadOnly	hwndYguipos22, Yguipos22
	;================================= Pos 23 ;=================================
	Gui, Add, Text,			x345	y138						,X=
	Gui, Add, edit,			x358	y135 w40 h20	ReadOnly	hwndXguipos23, Xguipos23
	Gui, Add, Text,			x345	y158						,Y=
	Gui, Add, edit,			x358	y155 w40 h20	ReadOnly	hwndYguipos23, Yguipos23
	
	
	Gui, Add, Button,		x345	y185						gGetPosLoot33, Get Pos 3
	;================================= Pos 21 ;=================================
	Gui, Add, Text,			x195	y213						,X=
	Gui, Add, edit,			x207	y210 w40 h20	ReadOnly	hwndXguipos31, Xguipos31
	Gui, Add, Text,			x195	y233						,Y=
	Gui, Add, edit,			x207	y230 w40 h20	ReadOnly	hwndYguipos31, Yguipos31
	;================================= Pos 22 ;=================================
	Gui, Add, Text,			x275	y213						,X=
	Gui, Add, edit,			x288	y210 w40 h20	ReadOnly	hwndXguipos32, Xguipos32
	Gui, Add, Text,			x275	y233						,Y=
	Gui, Add, edit,			x288	y230 w40 h20	ReadOnly	hwndYguipos32, Yguipos32
	;================================= Pos 23 ;=================================
	Gui, Add, Text,			x345	y213						,X=
	Gui, Add, edit,			x358	y210 w40 h20	ReadOnly	hwndXguipos33, Xguipos33
	Gui, Add, Text,			x345	y233						,Y=
	Gui, Add, edit,			x358	y230 w40 h20	ReadOnly	hwndYguipos33, Yguipos33
	
;===============================================================================================
Gui,Tab, 9 ; ===================================================================================  HELP
;===============================================================================================

	Gui, add, text,			x7		y30							,=====ATENÇÃO=====
	gui,add,picture, 		x7 		y50 						hwndmypic,Complementos\Imagens\StatusBar.png
	Gui, add, text,			x137	y30							,..............MANTER A STATUS BAR ABERTA.............
	Gui, add, text,			x137	y50							,CASO NÃO ESTEJA FUNCIONANDO ENCHER A VIDA
	Gui, add, text,			x137	y70							,..............E CLICAR EM RELOAD IMAGENS.............


	Gui, add, Text, 		x7		y150						,DEIXAR O PARTY LIST DESSE JEITO (com escolha de classes aparentes)
	gui,add,picture, 		x7 		y170 						hwndmypic,Complementos\Imagens\PartyListBarra.png


	gui,add,picture, 		x7 		y280						hwndmypic,Complementos\Imagens\Battle.png
	Gui, add, text,			x127	y260						,***PARA UTILIZAR FIRST TARGET NECESSÀRIO MANTER
	Gui, add, text,			x200	y280						,BATTLE ABERTO DESTA FORMA E TAMBÉM
	Gui, add, text,			x200	y300						,NECESSÁRIO COLOCAR O BATTLE EM
	Gui, add, text,			x200	y320						,====SORT ASCENDING BY DISTANCE====
	Gui, add, text,			x200	y360						,***PARA UTILIZAR NEXT TAGERT BASTA
	Gui, add, text,			x200	y380						,CONFIGURAR A HOTKEY NO CLIENTE

;===============================================================================================
;===============================================================================================
;===============================================================================================

CheckDate()

Gui, Show, % " w" GUIWidth " h" GUIHeight, Primo Marcos

CheckDate()

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

return 

StartGeral:

ChecaCliente()
EnviaNumGui()
RotinaContinua()

GuiControlGet, ManaTraining

if ((ImagemCliente = 1) and (State_Pause = 0) and (ManaTraining == 0)) {
	
GuiControlGet, ConsecutiveFunction1 
GuiControlGet, ConsecutiveFunction2 
	if (ConsecutiveFunction1 = 1) {
		ConsecutiveFunc1()
	}
	if (ConsecutiveFunction2 = 1) {
		ConsecutiveFunc2()
	}
	
GuiControlGet, Energy_Ring
	If (Energy_Ring == 1) {
		AutoSelfRing()
	}
	
GuiControlGet, Life_AutoHealing
	If (Life_AutoHealing == 1) {
		AutoSelfHeal()
	}
GuiControlGet, Mana_AutoHealing
	If ((Mana_AutoHealing == 1) and (IgnoreMana == 0)) {
		AutoSelfMana()
	}
	
if (ForaPZ = 1) {	
GuiControlGet, EAT
	If (EAT == 1) {
		AutoEat()
	}
GuiControlGet, Paralize
	If (Paralize == 1){
		AutoParalyze()
	}
GuiControlGet, Haste
	If (Haste == 1) {	
		AutoHaste()
	}
GuiControlGet, Boots
	If (Boots == 1) {		
		AutoBoots()
	}	
GuiControlGet, UtamoVita
	if (UtamoVita == 1) {	
		AutoUtamo()
	}
GuiControlGet, Amulet
	if ((Amulet == 1) and (EquipandoSSA = 0)) {	
		AutoAmulet()
	}
GuiControlGet, Ring
	if ((Ring == 1) and (EquipandoMight = 0) and (PuxandoEnergyRing = 0)) {
		AutoRing()
	}
GuiControlGet, Quiver
	if (WinActive("ahk_class Qt5QWindowOwnDCIcon")) {
		if (Quiver == 1) {
			AutoQuiver()
		}	
	}	
GuiControlGet, PotBuff
	if (WinActive("ahk_class Qt5QWindowOwnDCIcon")) {
		if (PotBuff == 1) {	
			AutoBuff()
		}
	}
GuiControlGet, SSA
	if ((SSA == 1) or (Ativa_TankMode = 1)) {
		AutoSSA()
	}
GuiControlGet, MIGHT
	if ((MIGHT == 1) or (Ativa_TankMode = 1)) {	
		AutoMIGHT()
	}
GuiControlGet, FOODHP
	if (WinActive("ahk_class Qt5QWindowOwnDCIcon")) {
		If (FOODHP == 1) {	
			AutoFOODHP()
		}
	}
GuiControlGet, FOODMP
	if (WinActive("ahk_class Qt5QWindowOwnDCIcon")) {
		If (FOODMP == 1) {	
			AutoFOODMP()
		}
	}	
} ; Fora PZ


GuiControlGet, SIOEK 
GuiControlGet, SIORP 
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
}
	
	
if (ManaTraining == 1) {
	ManaTrain()
}
	
	
	
	tooltip
	sleep %DelayMacro%
return


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
			ImageSearch, FoundX, FoundY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\Utamo.png	; CHECA SE ESTA DE UTAMO
			if (ErrorLevel = 0) {
				ImageSearch, FirstStageX, FirstStageY, 0, 0, A_ScreenWidth, A_ScreenHeight, *15, Complementos\Imagens\ExanaVitaCD.png		;Checa se tem cool down do exana vita
				if (ErrorLevel = 0){	
					ControlSend,, {%Hotkey_DeEnergy_Ring%}, Tibia - %Nome_Char% ;
				}			
			}
		}
		if ((CorLifeEquipe != CorDaVida) and (CorManaMinEquip == CorDaMana)) {
			ImageSearch, FoundX, FoundY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\Utamo.png	; CHECA SE ESTA DE UTAMO
			if (ErrorLevel = 1) {
				ImageSearch, FirstStageX, FirstStageY, 0, 0, A_ScreenWidth, A_ScreenHeight, *15, Complementos\Imagens\UtamoCD.png		;Checa se tem cool down de utamo vita
				if (ErrorLevel = 0) {	
					ControlSend,, {%Hotkey_Energy_Ring%}, Tibia - %Nome_Char%
				}
			}
		}
	} 
	if (TipoMagicShield = "Energy Ring") {	
		if ((CorLifeDeEquipe == CorDaVida) or (CorManaDeEquip != CorDaMana)) {
			ImageSearch, FoundX, FoundY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\utamo_ring.png	; CHECA SE ESTA DE ENERGY RING
			if (ErrorLevel = 0) {
				ControlSend,, {%Hotkey_DeEnergy_Ring%}, Tibia - %Nome_Char%
				PuxandoEnergyRing = 0
			}
		}
		if ((CorLifeEquipe != CorDaVida) and (CorManaMinEquip == CorDaMana)) {	
			ImageSearch, FoundX, FoundY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\utamo_ring.png	; CHECA SE ESTA DE ENERGY RING
			if (ErrorLevel = 1) {
				ControlSend,, {%Hotkey_Energy_Ring%}, Tibia - %Nome_Char% ; ENERGY RING
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
		ControlSend,, {%Hotkey_Life_Stage3%}, Tibia - %Nome_Char%
		sleep 500
		IgnoreMana = 1
		goto saidastage3
	} else {
		IgnoreMana = 0
	}

	PercentLife2 = %  XInicioVida + ((lifewidth * Percent_Life_Stage2) // 100)
	PixelGetColor, CorVidaStage2, %PercentLife2%, %YVida%, RGB ; Stage 2 Vida
	if (CorVidaStage2 != CorDaVida){ 
		ControlSend,, {%Hotkey_Life_Stage2%}, Tibia - %Nome_Char%
		sleep 500
	}
saidastage3:	
	PercentLife1 = %  XInicioVida + ((lifewidth * Percent_Life_Stage1) // 100)
	PixelGetColor, CorVidaStage1, %PercentLife1%, %YVida%, RGB ; Stage 1 Vida
	if (CorVidaStage1 != CorDaVida){ 
		ControlSend,, {%Hotkey_Life_Stage1%}, Tibia - %Nome_Char%
		sleep 500
	}
} ; Fim Self Heal
;==================================================================================
AutoSelfMana() {
global
GuiControlGet, Percent_Mana_Stage1
GuiControlGet, Percent_Mana_Stage2
GuiControlGet, Hotkey_Mana_Stage2
GuiControlGet, Hotkey_Mana_Stage1

	PercentMana2 = %  XInicioMana + ((lifewidth * Percent_Mana_Stage2) // 100)
	PixelGetColor, CorManaStage2, %PercentMana2%, %YMana%, RGB ; Stage 2 Vida
		if (CorManaStage2 != CorDaMana){ 
			Send {%Hotkey_Mana_Stage2%}  ; Stage 2 Mana food talvez
		}
	PercentMana1 = %  XInicioMana + ((lifewidth * Percent_Mana_Stage1) // 100)
	PixelGetColor, CorManaStage1, %PercentMana1%, %YMana%, RGB ; Stage 1 Vida
		if (CorManaStage1 != CorDaMana){ 
			ControlSend,, {%Hotkey_Mana_Stage1%}, Tibia - %Nome_Char% ; POT MANA
		}	

} ; Fim Self Mana
;==================================================================================
AutoEat() {
global
GuiControlGet, Hotkey_Eat
	ImageSearch,  FoundX, FoundY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\Fome.png		;Checa se esta com fome
		if (ErrorLevel = 0){
			ControlSend,, {%Hotkey_Eat%}, Tibia - %Nome_Char% ; Come food
		}
} ; Auto Eat fim
;==================================================================================
AutoParalyze() {
global
GuiControlGet, Hotkey_Paralize
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\Paralize.png		;Checa se esta paralizado 
		if (ErrorLevel = 0){
			ControlSend,, {%Hotkey_Paralize%}, Tibia - %Nome_Char% ; Auto Cure Paralize
		}	
} ; Fim Auto Paralyze
;==================================================================================
AutoHaste() {
global
GuiControlGet, Hotkey_Haste
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\Haste.png		;Checa se nao esta com haste
		if (ErrorLevel = 1){
			if (WinActive("ahk_class Qt5QWindowOwnDCIcon")) {
				ControlSend,, {%Hotkey_Haste%}, Tibia - %Nome_Char% ; Auto Haste
			}
		}
} ; Fim Auto Haste	
;==================================================================================
AutoBoots() {
global
GuiControlGet, Hotkey_Boots
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\NoBoots.png		;Checa se nao esta sem boots
		if (ErrorLevel = 0){
			if (WinActive("ahk_class Qt5QWindowOwnDCIcon")) {
				ControlSend,, {%Hotkey_Boots%}, Tibia - %Nome_Char% ; Auto Renew Boots
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
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\Utamo.png		;Checa se esta de Utamo
		if (ErrorLevel = 0) {	
			goto LabelUtamoOut
		}
	ImageSearch, FirstStageX, FirstStageY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *15, Complementos\Imagens\UtamoCD.png	;Checa se tem cool down de utamo vita
		if (ErrorLevel = 1){	
			goto LabelPotUtamo
		}
			
	}

	if (TipoUtamo = "OT") {
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\utamo_ring.png		;Checa se esta de Utamo
		if (ErrorLevel = 0) {	
			goto LabelUtamoOut
		}
	}
					ControlSend,, {%Hotkey_Utamo%}, Tibia - %Nome_Char% ;  Hotkey Utamo Vita
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
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\NoAmulet.png		;Checa se esta sem amuleto
		if (ErrorLevel = 0){		
			ControlSend,, {%Amulet_Hotkey%}, Tibia - %Nome_Char% ;  Hotkey Amulet
		}
} ; Fim Auto Amulet
;==================================================================================
AutoRing() {
global	
GuiControlGet, Hotkey_Ring
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\NoRing.png		;Checa se esta sem RING
		if (ErrorLevel = 0){		
			ControlSend,, {%Hotkey_Ring%}, Tibia - %Nome_Char% ;  Hotkey Ring
				sleep 40
		}
} ;  Fim Auto Ring
;==================================================================================
AutoQuiver() {
global	
GuiControlGet, Hotkey_Quiver
	ImageSearch, QuiverX, QuiverY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *25, Complementos\Imagens\Quiver.png		;Checa se Quiver esta zerado
		if (ErrorLevel = 0){
			MouseGetPos  MousePosXPush, MousePosYPush
				SendEvent ^{Click %QuiverX% %QuiverY% Down}
				SendEvent ^{Click %XTooltip% %YTooltip% Up}
			MouseMove MousePosXPush, MousePosYPush
			goto quiverlabel
		}
	ImageSearch, QuiverX, QuiverY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *25, Complementos\Imagens\Red Quiver.png		;Checa se Quiver esta zerado
		if (ErrorLevel = 0){
			MouseGetPos  MousePosXPush, MousePosYPush
				SendEvent ^{Click %QuiverX% %QuiverY% Down}
				SendEvent ^{Click %XTooltip% %YTooltip% Up}
			MouseMove MousePosXPush, MousePosYPush
			goto quiverlabel
		}
	ImageSearch, QuiverX, QuiverY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *25, Complementos\Imagens\Blue Quiver.png		;Checa se Quiver esta zerado
		if (ErrorLevel = 0){
			MouseGetPos  MousePosXPush, MousePosYPush
				SendEvent ^{Click %QuiverX% %QuiverY% Down}
				SendEvent ^{Click %XTooltip% %YTooltip% Up}
			MouseMove MousePosXPush, MousePosYPush
			goto quiverlabel
		}		
	quiverlabel:
	ImageSearch, QuiverX, QuiverY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *25, Complementos\Imagens\ShieldVazio.png		;Checa se Quiver esta zerado
		if (ErrorLevel = 0){
			ControlSend,, {%Hotkey_Quiver%}, Tibia - %Nome_Char% ;  Hotkey Quiver
		}
} ;  Fim Auto Quiver
;==================================================================================
AutoBuff() {
global	
GuiControlGet, Hotkey_PotBuff
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\Buff.png		;Checa se esta sem Buff
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

	if (Tank_Amulet = "SSA") {
		ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\SSA.png
			if (ErrorLevel = 1){
				SemTankAmulet = 1
					if (Ativa_TankMode = 1) {
						ControlSend,, {%SSA_Hotkey%}, Tibia - %Nome_Char% ;  Hotkey SSA
						EquipandoSSA = 1
					}
			}
			if (ErrorLevel = 0){
				SemTankAmulet = 0
			}
	}
	if (Tank_Amulet = "Leviathan") {
		ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\Leviathan.png
			if (ErrorLevel = 1){
				SemTankAmulet = 1
			}
			if (ErrorLevel = 0){
				SemTankAmulet = 0
			}
	}
	if (Tank_Amulet = "Sacred") {
		ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\Sacred.png
			if (ErrorLevel = 1){
				SemTankAmulet = 1
			}
			if (ErrorLevel = 0){
				SemTankAmulet = 0
			}
	}
	if (Tank_Amulet = "Shockwave") {
		ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\PrismaticAmulet.png ; Se estiver de Prismatic, vai puxar o outro
			if (ErrorLevel = 0){
				SemTankAmulet = 1
										goto PuxarTankAmulet
			}	
			if (ErrorLevel = 1){
				SemTankAmulet = 0
			}
		ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\lightningPendu.png ; Se estiver de lightning Pendulant, vai puxar o outro
			if (ErrorLevel = 0){
				SemTankAmulet = 1
										goto PuxarTankAmulet
			}	
			if (ErrorLevel = 1){
				SemTankAmulet = 0
			}	
		
		ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\NoAmulet.png		;Checa se esta sem amuleto
			if (ErrorLevel = 0){
				SemTankAmulet = 1
			}
	}


PuxarTankAmulet:
		PercentSSA = %  XInicioVida + ((lifewidth * SSA_Life) // 100)
		PixelGetColor, CorVidaSSA, %PercentSSA%, %YVida%, RGB
		if ((CorVidaSSA != CorDaVida) or (SSA_Life = 100)) {
			if (SemTankAmulet = 1){
				ControlSend,, {%SSA_Hotkey%}, Tibia - %Nome_Char% ;  Hotkey SSA
				EquipandoSSA = 1
					sleep 100
				goto saidaSSA
			}
		}
	if (SSA_Mana > 0) {
		PercentSSA1 = %  XInicioMana + ((manawidth * SSA_Mana) // 100)
		PixelGetColor, CorManaSSA, %PercentSSA1%, %YMana%, RGB
		if ((CorManaSSA != CorDaMana) or (SSA_Mana = 100)) {
			if (SemTankAmulet = 1){
				ControlSend,, {%SSA_Hotkey%}, Tibia - %Nome_Char% ;  Hotkey SSA
				EquipandoSSA = 1
					sleep 100
			}	
		}
	}
saidaSSA:



if (((SSA == 0) or ((CorVidaSSA = CorDaVida) and (CorManaSSA = CorDaMana))) and (Ativa_TankMode = 0)) {
EquipandoSSA = 0
}
} ;Fim SSA
;==================================================================================
AutoMIGHT() {
global
GuiControlGet, ForcaMight
GuiControlGet, Might_Hotkey
GuiControlGet, MIGHT_Life
GuiControlGet, Might_Mana

	NoRingEquip = 0
	MightEquip = 0
	
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\NoRing.png		;Checa se esta com MIGHT RING
	if (ErrorLevel = 0){
		NoRingEquip = 1
	}
	ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\Might.png
	if (ErrorLevel = 0){
		MightEquip = 1
	}
	if (ErrorLevel = 1){
		MightEquip = 0
			if ((Ativa_TankMode = 1) and (PuxandoEnergyRing = 0)) {
				ControlSend,, {%Might_Hotkey%}, Tibia - %Nome_Char% ;  Hotkey MIGHT RING
				EquipandoMight = 1
			}
	}
	
		PercentMIGHT = %  XInicioVida + ((lifewidth * Might_Life) // 100)
		PixelGetColor, CorVidaMIGHT, %PercentMIGHT%, %YVida%, RGB ;
		if ((CorVidaMIGHT != CorDaVida) or (Might_Life = 100)) {
			if (((NoRingEquip = 1) or (ForcaMight = 1)) and (MightEquip = 0) and (PuxandoEnergyRing = 0)){
				ControlSend,, {%Might_Hotkey%}, Tibia - %Nome_Char% ;  Hotkey MIGHT RING
				EquipandoMight = 1
					sleep 100
				goto saidamight
			}		
		}

		PercentMIGHT1 = %  XInicioMana + ((manawidth * Might_Mana) // 100)
		PixelGetColor, CorManaMIGHT, %PercentMIGHT1%, %YMana%, RGB ;
		if ((CorManaMIGHT != CorDaMana) or (Might_Mana = 100)) {
			if (((NoRingEquip = 1) or (ForcaMight = 1)) and (MightEquip = 0) and (PuxandoEnergyRing = 0)){
				ControlSend,, {%Might_Hotkey%}, Tibia - %Nome_Char% ;  Hotkey MIGHT RING
				EquipandoMight = 1
					sleep 100
			}
		}

saidamight:
if (((MIGHT == 0) or ((CorVidaMIGHT = CorDaVida) and (CorManaMIGHT = CorDaMana))) and (Ativa_TankMode = 0)) {
	EquipandoMight = 0
}
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
				sleep 40
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
				sleep 40
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
						ControlSend,, {%Hotkey_GranSio_1%}, Tibia - %Nome_Char% ; Exura Gran Sio
					}
				}
			PixelVidaParty1 = %  Xini_Life_PT1 + ((129 * PercentSIO1) // 100)
			PixelGetColor, CorVidaParty1, %PixelVidaParty1%, %Yref_Life_PT1%, RGB
				if ((CorVidaParty1 !="0x00C000") and (CorVidaParty1 !="0x60C060") and (CorVidaParty1 !="0xC0C000") and (CorVidaParty1 !="0xC03030") and (CorVidaParty1 !="0xC00000")){ 
					if (HealFriend1 = "SIO") {
						ControlSend,, {%Hotkey_Sio_1%}, Tibia - %Nome_Char% ; Exura Sio
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
GuiControlGet, UHRP
GuiControlGet, PercentSIO3
	PixelSearch, Px, Py, %Xini_Char_tela_3%, %Yini_Char_tela_3%, %Xfim_Char_tela_3%, %Yfim_Char_tela_3%, 0xC0C0C0, 0, FAST RGB ; Confere char na tela
		if (ErrorLevel = 0){	
			PixelVidaParty3 = %  Xini_Life_PT3 + ((129 * PercentSIO3) // 100)
			PixelGetColor, CorVidaParty3, %PixelVidaParty3%, %Yref_Life_PT3%, RGB
				if ((CorVidaParty3 !="0x00C000") and (CorVidaParty3 !="0x60C060") and (CorVidaParty3 !="0xC0C000") and (CorVidaParty3 !="0xC03030") and (CorVidaParty3 !="0xC00000")){ 
					if (HealFriend2 = "SIO") {
						ControlSend,, {%Hotkey_Sio_2%}, Tibia - %Nome_Char% ; Exura Sio
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
		ControlSend,, {%Hotkey_Consecutive1%}, Tibia - %Nome_Char%
		sleep 50
		ControlClick,  x%PosConsecutive1X% y%PosConsecutive1Y% , Tibia - %Nome_Char%,, LEFT,, Pos.
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
		ControlSend,, {%Hotkey_Consecutive2%}, Tibia - %Nome_Char%
	}
}

;================================================================================Mana Train

ManaTrain() {
global
GuiControlGet, HotkeyTrain1
GuiControlGet, HotkeyTrain2
GuiControlGet, HotkeyTrain3
GuiControlGet, HotkeyTrain4
GuiControlGet, HotkeyTrain5
GuiControlGet, TimeDelay
GuiControlGet, Hotkey_Life_Stage1
GuiControlGet, Hotkey_Exercise
GuiControlGet, ExerciseDelay
GuiControlGet, OpcaoTreino
GuiControlGet, BUYPOT
GuiControlGet, POTTYPE
GuiControlGet, POTDELAY

sleep 500

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
	TimerBUYPOT = % TimerBUYPOT + 1
}

ControlSetText,, %TimerBUYPOT%, ahk_id %TimerBUYPOT1%
ControlSetText,, %TimerManaTrain%, ahk_id %TimerManaTrain1%
ControlSetText,, %TimerExercise%, ahk_id %TimerExercise1%

if (((OpcaoTreino = "Magia") or (OpcaoTreino = "Magia e Exercise")) and (TimerManaTrain = 1)) {
	ControlSend,, {%HotkeyTrain1%}, Tibia - %Nome_Char%
	ControlSend,, {%HotkeyTrain2%}, Tibia - %Nome_Char%
	ControlSend,, {%HotkeyTrain3%}, Tibia - %Nome_Char%
	ControlSend,, {%HotkeyTrain4%}, Tibia - %Nome_Char%
	ControlSend,, {%HotkeyTrain5%}, Tibia - %Nome_Char%
}	


	if (((OpcaoTreino = "Exercise") or (OpcaoTreino = "Magia e Exercise")) and (GetPosDummyX != 0) and (GetPosDummyY != 0) and (TimerExercise = 1)){
		;WinGetActiveTitle, TelaAtiva
		;MouseGetPos  MousePosX, MousePosY
		;WinActivate, ahk_class Qt5QWindowOwnDCIcon
		ControlSend,, {%HotkeyTrain1%}, Tibia - %Nome_Char% ; 
		ControlSend,, {%Hotkey_Exercise%}, Tibia - %Nome_Char% ; 
		ControlSend,, {%Hotkey_Exercise%}, Tibia - %Nome_Char% ; 
		;MouseMove %GetPosDummyX%, %GetPosDummyY%
		;MouseClick, left, %GetPosDummyX%, %GetPosDummyY%
		ControlClick,  x%GetPosDummyX% y%GetPosDummyY% , Tibia - %Nome_Char%,, LEFT,, Pos.
		;WinActivate, %TelaAtiva%
		;MouseMove MousePosX, MousePosY
	}
	
	
	
	
	
	
	IF ((BUYPOT = 1) and (TimerBUYPOT = 1)) {
		WinGetActiveTitle, TelaAtiva
		MouseGetPos  MousePosX, MousePosY
		WinActivate, ahk_class Qt5QWindowOwnDCIcon
		
		ImageSearch, Xconfig, Yconfig,0, 0, 6000, 6000, *45, Complementos\Imagens\NPC\configs.png	; 
		buscarinicX = % Xconfig - 400
		buscarfimcX = % Xconfig + 200
		
		checkfecharagain:
		ImageSearch, fechaX, fechaY, %buscarinicX%, 0, %buscarfimcX%, 6000, *25, Complementos\Imagens\NPC\fechar.png	; 
			if (ErrorLevel = 0) {
				MouseMove %fechaX%, %fechaY%
				sleep 10
				MouseClick, left, %fechaX%, %fechaY%
				sleep 300
				goto checkfecharagain
			}
		
		ImageSearch, ChatX, ChatY, 0, 0, 6000, 6000, *25, Complementos\Imagens\NPC\localchat.png	; 
		if (ErrorLevel = 0) {
				MouseMove %ChatX%, %ChatY%
				sleep 10
				MouseClick, left, %ChatX%, %ChatY%
		}
		ImageSearch, ChatX, ChatY, 0, 0, 6000, 6000, *25, Complementos\Imagens\NPC\localchat1.png	; 
		if (ErrorLevel = 0) {
				MouseMove %ChatX%, %ChatY%
				sleep 10
				MouseClick, left, %ChatX%, %ChatY%
		}
		ImageSearch, ChatX, ChatY, 0, 0, 6000, 6000, *25, Complementos\Imagens\NPC\localchat2.png	; 
		if (ErrorLevel = 0) {
				MouseMove %ChatX%, %ChatY%
				sleep 10
				MouseClick, left, %ChatX%, %ChatY%
		}
		
		checachatoff:
		ImageSearch, ChatX, ChatY, 0, 0, 6000, 6000, *25, Complementos\Imagens\NPC\chatoff.png	; 
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
			
		
		ImageSearch, potX, potY, 0, 0, 6000, 6000, *25, Complementos\Imagens\NPC\%POTTYPE%.png	; 
		if (ErrorLevel = 0) {
				MouseMove %potX%, %potY%
				sleep 10
				MouseClick, left, %potX%, %potY%
			sleep 600
			ImageSearch, qtdX, qtdY, 0, 0, 6000, 6000, *25, Complementos\Imagens\NPC\99qtd.png	; 
			if (ErrorLevel = 0) {
				MouseMove %qtdX%, %qtdY%
				sleep 10
				MouseClick, left, %qtdX%, %qtdY%
				sleep 600
				ImageSearch, OKx, OKy, 0, 0, 6000, 6000, *25, Complementos\Imagens\NPC\OK.png	; 
				if (ErrorLevel = 0) {
					MouseMove %OKx%, %OKy%
					sleep 10
					MouseClick, left, %OKx%, %OKy%
					sleep 600
					ControlSend,, bye{ENTER}, Tibia - %Nome_Char% ;  
				}
			}
		}
		
		WinActivate, %TelaAtiva%
		MouseMove MousePosX, MousePosY
	}
	
	
} ;  Fim Mana Train
;==================================================================================
EnviaNumGui() {
global

;Status Geral
ControlSetText,, %State_Pause1%, ahk_id %ScriptPausado%
;Status Primo Ataque
ControlSetText,, %PrimoAtaqueStatus%, ahk_id %StatusAtaque%
;Status Quick Loot
ControlSetText,, %QuickLootOn%, ahk_id %StatusLooter%
;Status Tank Mode
ControlSetText,, %StatusTankMode%, ahk_id %StatusTank%

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
	
	
ControlSetText,, %GetPosDummyX%, ahk_id %GuiGetPosDummyX%
ControlSetText,, %GetPosDummyY%, ahk_id %GuiGetPosDummyY%

ControlSetText,, %PosConsecutive1X%, ahk_id %GuiPosConsecutive1X%
ControlSetText,, %PosConsecutive1Y%, ahk_id %GuiPosConsecutive1Y%
}
;==================================================================================
ChecaCliente() {
global
StartScripts:

if (WinActive("ahk_class Qt5QWindowOwnDCIcon")) {
ToolTip, %State_Pause1%, 270, 10,2
ToolTip, %StatusTankMode%, 450, 10,3
ToolTip, %PrimoAtaqueStatus%, 640, 10,4
ToolTip, %QuickLootOn%, 770, 10,5
} else {
ToolTip,,,,2
ToolTip,,,,3
ToolTip,,,,4
ToolTip,,,,5
}

IfWinExist, Tibia - %Nome_Char%
{
	Cliente = 1
		process, exist, ReLogin.exe
			if errorlevel
			Process, Close , ReLogin.exe
			
	goto ClienteEncontrado
} Else {
	Cliente = 0
}

IfWinExist, Tibia
{
	State_Pause1 = Aguardando Login
	
	GuiControlGet, Auto_ReLogin
	If (Auto_ReLogin == 1) {
		process, exist, ReLogin.exe
		if errorlevel
			goto OutReLogin
		else
			run, Complementos\ReLogin.exe

	}
OutReLogin:
}

ClienteEncontrado:

IfWinNotExist, ahk_class Qt5QWindowOwnDCIcon
{
	State_Pause1 = Client Closed
			process, exist, ReLogin.exe
			if errorlevel
			Process, Close , ReLogin.exe
}

	if (Cliente = 1) {
		ImageSearch, FoundX, FoundY, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *50, Complementos\Imagens\checaclienteaberto.png	; Checa coracao do cliente
			if (ErrorLevel = 1) {
				ImagemCliente = 0
				State_Pause1 = Client not Found
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

ImageSearch, FirstStageX, FirstStageY, %CheckSetXini%, %CheckSetYini%, %CheckSetXfim%, %CheckSetYfim%, *15, Complementos\Imagens\pz.png		;Checa se esta fora do PZ	
	if (ErrorLevel = 1){
		ForaPZ = 1
	}
	if (ErrorLevel = 0){
		ForaPZ = 0
			Ativa_QuickLoot = 0
			Ativa_QuickLoot_Perm = 0
	}

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

GuiControlGet, Hotkey_QuickLoot
GuiControlGet, Hotkey_StartStopQuickloot
IF ((QuickLooter = 1) Fand (ForaPZ = 1)) {
	Hotkey, ~<%Hotkey_QuickLoot%, QuickLooter, On
	Hotkey, ~<%Hotkey_StartStopQuickloot%, QuickLooter_Active, On
} else {
	Ativa_QuickLoot_Perm = 0	
}

If (((Ativa_QuickLoot_Perm == 1) or (Ativa_QuickLoot == 1)) and (GetPosLoot11X != 0) and (ForaPZ = 1) and (State_Pause1 = "Primo R")) {
	;if (WinActive("ahk_class Qt5QWindowOwnDCIcon")) {
		QuickLooter()
		QuickLootOn = Looter Ligado
	;}	
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
;==================================================================================	Primo Ataque
;==================================================================================
if (Hotkey_ATK <> "ERROR") {
	Hotkey, ~<%Hotkey_ATK%, Ativa_Ataque, Off
}
GuiControlGet, AtkRune1
GuiControlGet, AtkRune2
GuiControlGet, AtkRotacao1
GuiControlGet, AtkRotacao2
GuiControlGet, Hotkey_ATK
GuiControlGet, TipoAtaque
GuiControlGet, TipoTarget
GuiControlGet, Safe_Mode

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


if (((TipoTarget = "First Target") or (TipoTarget = "Next Target") or (Safe_Mode = 1) or (AtkRune1 = 1) or (AtkRune2 = 1) or (AtkRotacao1 = 1) or (AtkRotacao2 = 1)) and (ForaPZ = 1)) {
	Hotkey, ~<%Hotkey_ATK%, Ativa_Ataque, On
		Process, Exist, Primo_Ataque.exe
	If (!ErrorLevel= 0) {
		goto Label7
	}
		run, Complementos\Primo_Ataque.exe
}
Label7:
if (((TipoTarget = "Desligado") and (Safe_Mode = 0) and (AtkRune1 = 0) and (AtkRune2 = 0) and (AtkRotacao1 = 0) and (AtkRotacao2 = 0)) or (ForaPZ = 0) or (State_Pause = 1)) {
		Ativa_Atk = 0
		PrimoAtaqueStatus = Ataque Desligado
		Process, Exist, Primo_Ataque.exe
	If (!ErrorLevel= 0) {
		Process, Close , Primo_Ataque.exe
	}
}
} ; Fim Rotina Continua
;==================================================================================
;================================================================================== Tank Mode
;==================================================================================
TankMode_Func:
	if (Ativa_TankMode = 0) {
		StatusTankMode = Tank Mode ON
		Ativa_TankMode = 1	
		tooltip Tank Mode - ON, %XTooltip%,%YTooltip%
		sleep 100
		return
	}
	if (Ativa_TankMode = 1) {
		StatusTankMode = Tank Mode OFF
		Ativa_TankMode = 0	
		tooltip Tank Mode - OFF, %XTooltip%,%YTooltip%
		sleep 500
		tooltip
	}
return

;==================================================================================
;================================================================================== Ataque Mode
;==================================================================================
Ativa_Ataque:
	if ((Ativa_Atk = 0) and (ForaPZ = 1)) {
		tooltip Primo Ataque [ON]
		PrimoAtaqueStatus = Ataque Ligado
		Ativa_Atk = 1
		return
	}
	if (Ativa_Atk = 1) {
		PrimoAtaqueStatus = Ataque Desligado
		tooltip Primo Ataque [OFF]
		Ativa_Atk = 0
	}
return

;==================================================================================
;================================================================================== Checa Validade
;==================================================================================
CheckDate() {
Global
checkdateagain:
FileDelete, 					%Address%
UrlDownloadToFile, 				%URL%%User%, %Address%
FileReadLine, Date_until, 		%Address%, 9
FileDelete,						%Address%

FileDelete, 															Data.ini
UrlDownloadToFile, 					%URLData%, 	Data.ini
FileSetAttrib, +H, 														Data.ini
FileReadLine, Data_Hoje, 									Data.ini, 2
FileReadLine, Versao_Web, 									Data.ini, 3
	if !FileExist("Data.ini"){
		Gui, -AlwaysOnTop
			msgbox, Não foi Possivel Validar a Data Atual`nContate o Fornecedor
			goto checkdateagain
	}
FileDelete,																Data.ini

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

ControlSetText,, %msgvalidade%, ahk_id %myedit%


if (Data_Hoje>Date_until) {
	Gui, -AlwaysOnTop
			msgbox, Seu Contato Expirou.`nEntre em contato com o Fornecedor.
	exitapp
}
}

;==================================================================================
;================================================================================== Quick Loot
;==================================================================================
QuickLooter_Active:
	if ((Ativa_QuickLoot_Perm = 0) and (ForaPZ = 1)) {
		Ativa_QuickLoot_Perm = 1	
		tooltip QuickLoot - ON, %XTooltip%,%YTooltip%
		return
	}
	if (Ativa_QuickLoot_Perm = 1) {
		Ativa_QuickLoot_Perm = 0	
		tooltip QuickLoot - OFF, %XTooltip%,%YTooltip%
		sleep 1000
		tooltip
	}
return

QuickLooter(){
global
QuickLooter:
		send, {shift Down}
		ControlClick,  x%GetPosLoot11X% y%GetPosLoot11Y% , Tibia - %Nome_Char%,, RIGHT,, Pos.
		send, {shift Up}
		sleep %DelayLoot%
		send, {shift Down}
		ControlClick,  x%GetPosLoot12X% y%GetPosLoot12Y% , Tibia - %Nome_Char%,, RIGHT,, Pos.
		send, {shift Up}
		sleep %DelayLoot%
		send, {shift Down}
		ControlClick,  x%GetPosLoot13X% y%GetPosLoot13Y% , Tibia - %Nome_Char%,, RIGHT,, Pos.
		send, {shift Up}
		sleep %DelayLoot%
		send, {shift Down}
		ControlClick,  x%GetPosLoot21X% y%GetPosLoot21Y% , Tibia - %Nome_Char%,, RIGHT,, Pos.
		send, {shift Up}
		sleep %DelayLoot%
		send, {shift Down}
		ControlClick,  x%GetPosLoot22X% y%GetPosLoot22Y% , Tibia - %Nome_Char%,, RIGHT,, Pos.
		send, {shift Up}
		sleep %DelayLoot%
		send, {shift Down}
		ControlClick,  x%GetPosLoot23X% y%GetPosLoot23Y% , Tibia - %Nome_Char%,, RIGHT,, Pos.
		send, {shift Up}
		sleep %DelayLoot%
		send, {shift Down}
		ControlClick,  x%GetPosLoot31X% y%GetPosLoot31Y% , Tibia - %Nome_Char%,, RIGHT,, Pos.
		send, {shift Up}
		sleep %DelayLoot%
		send, {shift Down}
		ControlClick,  x%GetPosLoot32X% y%GetPosLoot32Y% , Tibia - %Nome_Char%,, RIGHT,, Pos.
		send, {shift Up}
		sleep %DelayLoot%
		send, {shift Down}
		ControlClick,  x%GetPosLoot33X% y%GetPosLoot33Y% , Tibia - %Nome_Char%,, RIGHT,, Pos.
		send, {shift Up}
		sleep %DelayLoot%
Ativa_QuickLoot = 0
return
} ; Fim Quick Loot

DesligaQuickLoot:
	Ativa_QuickLoot = 0
	Ativa_QuickLoot_Perm = 0
	send, {shift Up}
return


GetPosLoot11:
	tooltip APERTE ALT NO CENTRO DO SQM NORTE ESQUERDO
	KeyWait, Alt, D
	MouseGetPos, GetPosLoot11X, GetPosLoot11Y
	tooltip Pos 1 OK
	sleep 300
	tooltip
	GetPosLoot21X = %GetPosLoot11X%
	GetPosLoot31X = %GetPosLoot11X%
	GetPosLoot12Y = %GetPosLoot11Y%
	GetPosLoot13Y = %GetPosLoot11Y%
return

GetPosLoot22:
	tooltip APERTE ALT NO CENTRO DO SQM DO CHAR
	KeyWait, Alt, D
	MouseGetPos, GetPosLoot22X, GetPosLoot22Y
	tooltip Pos 2 OK
	sleep 300
	tooltip
	GetPosLoot12X = %GetPosLoot22X%
	GetPosLoot32X = %GetPosLoot22X%
	GetPosLoot21Y = %GetPosLoot22Y%
	GetPosLoot23Y = %GetPosLoot22Y%
return

GetPosLoot33:
	tooltip APERTE ALT NO CENTRO DO SQM SUL DIREITO
	KeyWait, Alt, D
	MouseGetPos, GetPosLoot33X, GetPosLoot33Y
	tooltip Pos 3 OK
	sleep 300
	tooltip
	GetPosLoot13X = %GetPosLoot33X%
	GetPosLoot23X = %GetPosLoot33X%
	GetPosLoot31Y = %GetPosLoot33Y%
	GetPosLoot32Y = %GetPosLoot33Y%
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
	tooltip APERTE ALT NO SQM DESEJADO
	KeyWait, Alt, D
	MouseGetPos, PosConsecutive1X, PosConsecutive1Y
	tooltip Pos OK
	sleep 1000
	tooltip
return

;==================================================================================
;================================================================================== Exercise
;==================================================================================
ExercisePos:
	tooltip APERTE ALT NO Dummy
	sleep 1000
	tooltip
	KeyWait, Alt, D
	MouseGetPos, GetPosDummyX, GetPosDummyY
	tooltip Pos Dummy OK
	sleep 1000
	tooltip
return

;==================================================================================
;================================================================================== PVPs Functions
;==================================================================================
SelectCoordinatesFlower:
	tooltip APERTE "ALT" na posicao FIXA da Flower na backpack.
	sleep 1000
	tooltip
	KeyWait, Alt, D
	MouseGetPos, GetPosFlowerX, GetPosFlowerY
	tooltip Pos OK
	sleep 1000
	tooltip
return

FlowerOnMouse:
GuiControlGet, Flower
if (Flower == 1) {
Send, {Shift Down}
MouseGetPos, StartX, StartY
Click D %GetPosFlowerX%, %GetPosFlowerY%
Click u %StartX%, %StartY%
Send, {Shift Up}
}
return
;==================================================================================

SelectCoordinatesTrash1:
	tooltip APERTE "ALT" na posicao FIXA do Trash1 na backpack.
	sleep 1000
	tooltip
	KeyWait, Alt, D
	MouseGetPos, GetPosTrash1X, GetPosTrash1Y
	tooltip Pos OK
	sleep 1000
	tooltip
return

SelectCoordinatesTrash2:
	tooltip APERTE "ALT" na posicao FIXA do Trash2 na backpack.
	sleep 1000
	tooltip
	KeyWait, Alt, D
	MouseGetPos, GetPosTrash2X, GetPosTrash2Y
	tooltip Pos OK
	sleep 1000
	tooltip

return

TrashOnMouse:
GuiControlGet, Trash1
GuiControlGet, Trash2
MouseGetPos, StartX, StartY
if (Trash1 == 1) {
Click D, %GetPosTrash1X%, %GetPosTrash1Y%
Send, +{Click u %StartX%, %StartY%}
}
Sleep 300
if (Trash2 == 1) {
Click D, %GetPosTrash2X%, %GetPosTrash2Y%
Send, +{Click u %StartX%, %StartY%}
}
return

;==================================================================================
SelectCoordinatesPushItem:
	tooltip APERTE "ALT" na posicao FIXA do da backpack.
	sleep 1000
	tooltip
	KeyWait, Alt, D
	MouseGetPos, PushItemBPX, PushItemBPY
	tooltip Pos OK
	sleep 1000
	tooltip
return

PushItemOnBP:
GuiControlGet, PushItem
if (PushItem == 1) {
Send, {Control down}
MouseGetPos, StartX, StartY
Click D
Click u, %PushItemBPX%, %PushItemBPY%
Send, {Control up}
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
WinGetPos, Tibia_X, Tibia_Y, Tibia_Width1, Tibia_Height1, Tibia - %Nome_Char%
Tibia_Width = % Tibia_Width1 + Tibia_X
Tibia_Height = % Tibia_Height1 + Tibia_Y
XTooltip = % Tibia_Width / 2
YTooltip = % Tibia_Height / 2


		CheckSetXini = % Tibia_Width - 200
		CheckSetYini = -23
		CheckSetXfim = % Tibia_Width - 20
		CheckSetYfim = 470
	
;	ImageSearch, XStop1, YStop1, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *15, Complementos\Imagens\Stop.png
;	if (ErrorLevel = 1) {
;		tooltip NÃO ENCONTRADO Barra Status / Amuleto e ring 
;		sleep 1000
;		goto OutStop
;	}
;	if (ErrorLevel = 0) {
;		XStop = %XStop1%
;		YStop = %YStop1%
;		CheckSetXini = % XStop - 140
;		CheckSetYini = % YStop - 150
;		CheckSetXfim = %XStop%
;		CheckSetYfim = % YStop + 20
;	}
;OutStop:

;	MouseMove %CheckSetXini%, %CheckSetYini%
;	Gui, -AlwaysOnTop
;	msgbox, pos 1
;	MouseMove %CheckSetXfim%, %CheckSetYfim%
;	Gui, -AlwaysOnTop
;	msgbox, pos 2

ImageSearch, XParty1, YParty1, %Tibia_X%, %Tibia_Y%, %Tibia_Width1%, %Tibia_Height1%, *15, Complementos\Imagens\PartyList.png	; 
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

ImageSearch, XInicioVida1, YInicioVida1, %Tibia_X%, %Tibia_Y%, %Tibia_Width%, %Tibia_Height%, *15, Complementos\Imagens\HP100Percent.png	; Checa Vida 100%
	if (ErrorLevel = 1) {
		tooltip NÃO ENCONTRADO -> LIFE FULL
		sleep 1000	
	goto OutVida
	}
	if (ErrorLevel = 0) {
		XInicioVida = %XInicioVida1%
		YInicioVida = %YInicioVida1%
		gui,add,picture, x900 hwndmypic,Complementos\Imagens\HP100Percent.png
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
;================================================================================== Load
;==================================================================================
Load() {
Global
IniRead, DelayMacro, %EndConfigSuporte%.ini, Principal, DelayMacro

IniRead, Account, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Account
IniRead, Password, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Password

IniRead, GetPosDummyX, %EndConfigSuporte%.ini, Principal, GetPosDummyX
IniRead, GetPosDummyY, %EndConfigSuporte%.ini, Principal, GetPosDummyY

IniRead, Tibia_X, %EndConfigSuporte%.ini, Principal, Tibia_X
IniRead, Tibia_Y, %EndConfigSuporte%.ini, Principal, Tibia_Y
IniRead, Tibia_Width, %EndConfigSuporte%.ini, Principal, Tibia_Width
IniRead, Tibia_Height, %EndConfigSuporte%.ini, Principal, Tibia_Height

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

;[EatFood]
IniRead, Hotkey_Eat, %EndConfigSuporte%.ini, EAT, Hotkey_Eat

;[BUFF]
IniRead, Hotkey_PotBuff, %EndConfigSuporte%.ini, Buff, Hotkey_PotBuff

;[HASTE]
IniRead, Hotkey_Haste, %EndConfigSuporte%.ini, Haste, Hotkey_Haste

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

IniRead, Yref_Life_PT2, %EndConfigSuporte%.ini, Coordenadas, Yref_Life_PT2
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

;[PVP FUNCTIONS]
IniRead, Key_Enable_Flower, %EndConfigSuporte%.ini, Principal, Key_Enable_Flower
IniRead, GetPosFlowerX, %EndConfigSuporte%.ini, Principal, GetPosFlowerX
IniRead, GetPosFlowerY, %EndConfigSuporte%.ini, Principal, GetPosFlowerY

IniRead, Key_Enable_Trash, %EndConfigSuporte%.ini, Principal, Key_Enable_Trash
IniRead, GetPosTrash1X, %EndConfigSuporte%.ini, Principal, GetPosTrash1X
IniRead, GetPosTrash1Y, %EndConfigSuporte%.ini, Principal, GetPosTrash1Y
IniRead, GetPosTrash2X, %EndConfigSuporte%.ini, Principal, GetPosTrash2X
IniRead, GetPosTrash2Y, %EndConfigSuporte%.ini, Principal, GetPosTrash2Y


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
IniWrite, %EndConfigAtaque1%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, EndConfigAtaque

GuiControlGet, Hotkey_Consecutive1
IniWrite, %Hotkey_Consecutive1%, %EndConfigSuporte%.ini, Principal, Hotkey_Consecutive1
GuiControlGet, Hotkey_Consecutive2
IniWrite, %Hotkey_Consecutive2%, %EndConfigSuporte%.ini, Principal, Hotkey_Consecutive2
GuiControlGet, Delay_Consecutive1
IniWrite, %Delay_Consecutive1%, %EndConfigSuporte%.ini, Principal, Delay_Consecutive1
GuiControlGet, Delay_Consecutive2
IniWrite, %Delay_Consecutive2%, %EndConfigSuporte%.ini, Principal, Delay_Consecutive2


GuiControlGet, Account
IniWrite, %Account%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Account
GuiControlGet, Password
IniWrite, %Password%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Password

GuiControlGet, DelayMacro
IniWrite, %DelayMacro%, %EndConfigSuporte%.ini, Principal, DelayMacro

GuiControlGet, Hotkey_Pause
IniWrite, %Hotkey_Pause%, %EndConfigSuporte%.ini, Principal, Hotkey_Pause

;[Principal]

IniWrite, %Nome_Char%, %EndConfigSuporte%.ini, Principal, Nome_Char




GuiControlGet, LigarPrimo
IniWrite, %LigarPrimo%, %EndConfigSuporte%.ini, Principal, LigarPrimo

GuiControlGet, Life_AutoHealing
IniWrite, %Life_AutoHealing%, %EndConfigSuporte%.ini, Principal, Life_AutoHealing
GuiControlGet, Mana_AutoHealing
IniWrite, %Mana_AutoHealing%, %EndConfigSuporte%.ini, Principal, Mana_AutoHealing
GuiControlGet, Energy_Ring
IniWrite, %Energy_Ring%, %EndConfigSuporte%.ini, Principal, Energy_Ring


GuiControlGet, EAT
IniWrite, %EAT%, %EndConfigSuporte%.ini, Principal, EAT
GuiControlGet, PotBuff
IniWrite, %PotBuff%, %EndConfigSuporte%.ini, Principal, PotBuff
GuiControlGet, Haste
IniWrite, %Haste%, %EndConfigSuporte%.ini, Principal, Haste
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
IniWrite, %Safe_Mode%, %EndConfigSuporte%.ini, Principal, Safe_Mode
IniWrite, %Safe_StopAttack%, %EndConfigSuporte%.ini, Principal, Safe_StopAttack

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

IniWrite, %Yref_Life_PT2%, %EndConfigSuporte%.ini, Coordenadas, Yref_Life_PT2
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

;[PVP FUNCTIONS]
GuiControlGet, Key_Enable_Flower
IniWrite, %Key_Enable_Flower%, %EndConfigSuporte%.ini, Principal, Key_Enable_Flower

IniWrite, %GetPosFlowerX%, %EndConfigSuporte%.ini, Principal, GetPosFlowerX
IniWrite, %GetPosFlowerY%, %EndConfigSuporte%.ini, Principal, GetPosFlowerY

GuiControlGet, Key_Enable_Trash
IniWrite, %Key_Enable_Trash%, %EndConfigSuporte%.ini, Principal, Key_Enable_Trash

IniWrite, %GetPosTrash1X%, %EndConfigSuporte%.ini, Principal, GetPosTrash1X
IniWrite, %GetPosTrash1Y%, %EndConfigSuporte%.ini, Principal, GetPosTrash1Y
IniWrite, %GetPosTrash2X%, %EndConfigSuporte%.ini, Principal, GetPosTrash2X


IniWrite, %PushItemBPX%, %EndConfigSuporte%.ini, Principal, PushItemBPX
IniWrite, %PushItemBPY%, %EndConfigSuporte%.ini, Principal, PushItemBPY



;[Treinar]
GuiControlGet, Hotkey_Exercise
IniWrite, %Hotkey_Exercise%, %EndConfigSuporte%.ini, Principal, Hotkey_Exercise
GuiControlGet, ExerciseDelay
IniWrite, %ExerciseDelay%, %EndConfigSuporte%.ini, Principal, ExerciseDelay
GuiControlGet, POTDELAY
IniWrite, %POTDELAY%, %EndConfigSuporte%.ini, Principal, POTDELAY


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

GuiControlGet DelayNextTarget
IniWrite, %DelayNextTarget%, %EndConfigAtaque%.ini, Principal, DelayNextTarget

}

ValoresIniciais() {
Global
IniRead, User, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, User
IniRead, Nick_Tibia, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Nick_Tibia

IniRead, Account, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Account
IniRead, Password, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Password

EndConfigSuporte = C:\PrimoConfigs\ConfigSuporte%Nick_Tibia%
EndConfigAtaque = C:\PrimoConfigs\ConfigAtaque%Nick_Tibia%
EndConfigAtaque1 = %EndConfigAtaque%

TimerConsecutive1 = 0
TimerConsecutive2 = 0

ReloadInicial = 0
IgnoreMana = 0
EquipandoSSA = 0
EquipandoMight = 0
PuxandoEnergyRing = 0

VidaSioOK = 0

Cliente = 0
EsperandoLogar = 0

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

IniWrite, %EquipandoSSA%, %EndConfigSuporte%.ini, Principal, EquipandoSSA
IniWrite, %EquipandoMight%, %EndConfigSuporte%.ini, Principal, EquipandoMight
IniWrite, %PuxandoEnergyRing%, %EndConfigSuporte%.ini, Principal, PuxandoEnergyRing


Delay_Consecutive1=10
Delay_Consecutive2=10
DelayMacro=50
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


}

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
				Process, Close , Primo_Ataque.exe
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
	FileAppend, %Versao_Web%, 	C:\PrimoConfigs\windowscheck.ini
	FileAppend, reload, 	C:\PrimoConfigs\reload.ini
	FileSetAttrib, +H, C:\PrimoConfigs\windowscheck.ini
	Reload
return

GuiEscape:
GuiClose:
ExitSub:
Process, Close , Primo_Ataque.exe
Process, Close , ReLogin.exe
ExitApp ; Terminate the script unconditionally