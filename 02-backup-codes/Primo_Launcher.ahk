#SingleInstance, Force
#NoTrayIcon ; Disable the tray icon of the script
OnExit, ExitSub
Thread, interrupt, 0
Thread, NoTimers, true
Process, Priority,, Low

ChecaValidade = 0

;if not A_IsAdmin
;	Run *RunAs "%A_ScriptFullPath%" ; (A_AhkPath is usually optional if the script has the .ahk extension.) You would typically check  first.
baseurl = https://primomarcos.com

Address = C:\PrimoConfigs\gsdfa.ini
URL = %baseurl%/users.php?user=
URLData = %baseurl%/date.php
URLmsg = %baseurl%/msglauncherauto.php
URLVersion = %baseurl%/infos.php

Status_Usuario = Checando Usuario
Versao_Launcher_Local = Launcher10

downloadnecessario = 0

checkagain7zip:
process, exist, 7z.exe
	if errorlevel {
		Process, Close , 7z.exe
		goto checkagain7zip
	}
if FileExist("Primo.zip") {
	FileDelete, Primo.zip
}
			
if FileExist("C:\PrimoConfigs\reload.ini"){
	FileDelete, C:\PrimoConfigs\reload.ini
}



;==================================================================================
;================================================================================== DOWNLOAD DATA ATUAL
;==================================================================================
checkdateagain:

if !FileExist("C:\PrimoConfigs"){
	FileCreateDir, C:\PrimoConfigs
	FileCreateDir, C:\PrimoConfigs\Padrao
		CONTEUDO_Geral=[Principal]`nEndConfigSuporte=`nEndConfigAtaque =`nUser=`nNick_Tibia =
		FileAppend, %CONTEUDO_Geral%, C:\PrimoConfigs\Padrao\ConfigGeral.ini	
}

ZeraValoresDownload()

UUID()
{
	For obj in ComObjGet("winmgmts:{impersonationLevel=impersonate}!\\" . A_ComputerName . "\root\cimv2").ExecQuery("Select * From Win32_ComputerSystemProduct")
		return obj.UUID	; http://msdn.microsoft.com/en-us/library/aa394105%28v=vs.85%29.aspx
}

GuiLauncher() {
Global
IniRead, VersaoPrimo, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, VersaoPrimo
	if (VersaoPrimo = "ERROR") {
		VersaoPrimo = MultiScripts
	}
IniRead, VersaoGrafico, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, VersaoGrafico
	if (VersaoGrafico = "ERROR") {
		VersaoGrafico = OpenGL
	}
	
FileDelete, C:\PrimoConfigs\windowscheck.ini

if FileExist("C:\PrimoConfigs\Padrao\ConfigGeral.ini"){ 
	IniRead, User, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, User
	IniRead, Nick_tibia, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Nick_tibia
} else {
	User = NA
	Nick_tibia = NA
}

		Static GUICreate := GuiLauncher()
		GUIWidth := 510, GUIHeight := 400
		
Menu, Tray, Tip, 																Primo Marcos Launcher

Gui, +AlwaysOnTop ; FUNCAO ATIVA, DEIXA MACRO SEMPRE NA FRENTE DA TELA
Gui, +LastFound -Theme
Gui, Color, 																	202124 
Gui, Font, 																		cFFFFFF
Gui, Margin, 																	10, 10

Gui, Add, Button, 		x160	y3		h16							gPacotes, Pacotes
Gui, Add, DropDownList, x250	y1	w85		cBlack		vVersaoGrafico, %VersaoGrafico%||DirectX|OpenGL
Gui, Add, DropDownList, x350	y1	w85		cBlack		vVersaoPrimo, %VersaoPrimo%||ScriptUnico|MultiScripts|BETAUnico|BETAMulti

Gui, Add, Button, 		x470	y4 	w30	h15								gExitSub, Exit


Gui, Add, Text, 		x340 	y285 	h20,							Nick do Char:
Gui, Add, Edit, 		x340 	y300 	w120 	h20 cBlack 				vNick_Tibia, %Nick_Tibia%


Gui, Add, Text, 		x180 	y285 		h20							,Usuario:
Gui, Add, Edit,			x180 	y300 w120 	h20 cBlack 					vUser, %User%
Gui, Add, edit,			x180	y330	w120			ReadOnly		hwndGui_StatusUsuario,
Gui, Add, edit,			x180	y360		w120 	ReadOnly	 		hwndmyedit, myedit

Gui, Add, edit,			x7		y300		w155	ReadOnly			hwndGui_status,
Gui, Add, Text, 		x7		y330	h20								,Versão Local
Gui, Add, edit,			x7		y345	w60			ReadOnly			hwndGui_VL,
Gui, Add, Text, 		x100	y330	h20								,Versão WEB
Gui, Add, edit,			x100	y345	w60			ReadOnly			hwndGui_VW,
;Gui, Add, Button, 		x40		y290 		h15							gReload, Reload Launcher






	
	
;Gui, Add, Button, 		x320 	y345 			w80	h40					gPrimeiroLogin, Primeiro Login
;Gui, Add, Button, 		x320	y325 	w80 	h40 					gCheck, Update Download
;Gui, Add, Button, 		x410	y345 	w80 	h40 					gStart, Start
Gui, Add, Button, 		x340	y345 	w120 	h40 					gStart, START



Gui, Add, Tab, x1 y1 w500 h280 											,Launcher|Contato
Gui, Tab, 										Launcher
Gui, Add, Text, 		x7		y30		w487 h220							vMsg_GUI
Gui, Add, Text, 		x7		y45		w487 h15							vMsg_GUI1
Gui, Add, Text, 		x7		y60		w487 h15							vMsg_GUI2
Gui, Add, Text, 		x7		y75		w487 h15							vMsg_GUI3
Gui, Add, Text, 		x7		y90		w487 h15							vMsg_GUI4
Gui, Add, Text, 		x7		y105	w487 h15							vMsg_GUI5
Gui, Add, Text, 		x7		y120	w487 h15							vMsg_GUI6
Gui, Add, Text, 		x7		y135	w487 h15							vMsg_GUI7
Gui, Add, Text, 		x7		y150	w487 h15							vMsg_GUI8
Gui, Add, Text, 		x7		y165	w487 h15							vMsg_GUI9
Gui, Add, Text, 		x7		y180	w487 h15							vMsg_GUI10
Gui, Add, Text, 		x7		y195	w487 h15							vMsg_GUI11
Gui, Add, Text, 		x7		y210	w487 h15							vMsg_GUI12
Gui, Add, Text, 		x7		y225	w487 h15							vMsg_GUI13
Gui, Add, Text, 		x7		y240	w487 h15							vMsg_GUI14
Gui, Add, Text, 		x7		y255	w487 h15							vMsg_GUI15

Gui, Tab, 										Contato
Gui, Add, Link,		x12 	y40,											Convite para <a href="https://discord.gg/7tduQuNrJU">Discord</a>
Gui, Add, Text,		x12		y70,											Discord para Contato: Away#8001
Gui, Add, Link,		x12 	y90,											Em caso de Duvidas <a href="https://discord.gg/xn99BseQHc">Tutoriais</a>





Gui, Show, % " w" GUIWidth " h" GUIHeight, Primo Launcher
}
trydownloadagain:
FileDelete,		Data.ini
FileDelete,		Msg.ini
FileDelete,		Versions.ini
UrlDownloadToFile, 					%URLData%, 	Data.ini
FileSetAttrib, +H, Data.ini
UrlDownloadToFile, 					%URLmsg%, 	Msg.ini
FileSetAttrib, +H, Msg.ini
UrlDownloadToFile, 					%URLVersion%, 	Versions.ini
FileSetAttrib, +H, Versions.ini

;FileReadLine, CheckFileDate, 								Data.ini, 1
FileReadLine, Data_Hoje, 									Data.ini, 2



FileReadLine, Versao_Web, 									Versions.ini, 2
FileReadLine, Versao_Beta,									Versions.ini, 3
FileReadLine, Versao_Launcher,								Versions.ini, 4
FileReadLine, URLDownload, 									Versions.ini, 5
FileReadLine, URL_ID, 										Versions.ini, 6

FileReadLine, Mensagem, 									Msg.ini, 2
FileReadLine, Mensagem1, 									Msg.ini, 3
FileReadLine, Mensagem2, 									Msg.ini, 4
FileReadLine, Mensagem3, 									Msg.ini, 5
FileReadLine, Mensagem4, 									Msg.ini, 6
FileReadLine, Mensagem5, 									Msg.ini, 7
FileReadLine, Mensagem6, 									Msg.ini, 8
FileReadLine, Mensagem7, 									Msg.ini, 9
FileReadLine, Mensagem8, 									Msg.ini, 10
FileReadLine, Mensagem9, 									Msg.ini, 11
FileReadLine, Mensagem10, 									Msg.ini, 12
FileReadLine, Mensagem11, 									Msg.ini, 13
FileReadLine, Mensagem12, 									Msg.ini, 14
FileReadLine, Mensagem13, 									Msg.ini, 15
FileReadLine, Mensagem14, 									Msg.ini, 16

FileDelete,		Msg.ini
FileDelete,		Data.ini
FileDelete,		Versions.ini


	;if (CheckFileDate <> "PrimoMarcosDate") {
	;	Gui, -AlwaysOnTop
	;	msgbox, Servidor Offline`nEntre em contato com o fornecedor.
	;	goto trydownloadagain
	;}

	if (Versao_Launcher <> Versao_Launcher_Local) { 
		CheckUser()
		if (Status_Usuario = "Usuario autorizado") {
			UrlDownloadToFile, 				%URLDownload%Primo_Launcher.exe, 	Primo_%Versao_Launcher%.exe
			Gui, -AlwaysOnTop
			msgbox, Necessario atualizar launcher`nUtilizar a versao nova ja disponivel na pasta %A_WorkingDir%`n Nome do novo > Primo_%Versao_Launcher%.exe
			exitapp
		} else {
			Gui, -AlwaysOnTop
			msgbox, Launcher Desatualizado e Usuario não autorizado, entre em contato com o Fornecedor
			exitapp
		}
	}
	
	

GuiControl,, Msg_GUI, %Mensagem%		
GuiControl,, Msg_GUI1, %Mensagem1%
GuiControl,, Msg_GUI2, %Mensagem2%
GuiControl,, Msg_GUI3, %Mensagem3%
GuiControl,, Msg_GUI4, %Mensagem4%
GuiControl,, Msg_GUI5, %Mensagem5%
GuiControl,, Msg_GUI6, %Mensagem6%
GuiControl,, Msg_GUI7, %Mensagem7%
GuiControl,, Msg_GUI8, %Mensagem8%
GuiControl,, Msg_GUI9, %Mensagem9%
GuiControl,, Msg_GUI10, %Mensagem10%
GuiControl,, Msg_GUI11, %Mensagem11%
GuiControl,, Msg_GUI12, %Mensagem12%
GuiControl,, Msg_GUI13, %Mensagem13%
GuiControl,, Msg_GUI14, %Mensagem14%





	Settimer LancherScript, 2000
return

LancherScript:
	ZeraValoresDownload()
	CheckUser()

GuiControlGet, VersaoPrimo
IniWrite, %VersaoPrimo%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, VersaoPrimo
GuiControlGet, VersaoGrafico
IniWrite, %VersaoGrafico%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, VersaoGrafico

updating = 0
if FileExist("Version.ini"){
	FileReadLine, Versao_Local, 								Version.ini, 1
	FileReadLine, Versao_Beta_Local, 								Version.ini, 2
} else {
	Versao_Local = 0
}
	if !FileExist("Primo"){
		Status = PRIMO NÂO ENCONTRADO
		ControlSetText,, %Status_Usuario%, ahk_id %Gui_StatusUsuario%
		ControlSetText,, %Status%, ahk_id %Gui_status%
		goto Update	
	}
	
	if ((VersaoPrimo == "BETAUnico")  or (VersaoPrimo == "BETAMulti"))  { 
		if !FileExist("Primo\BETA"){
			Status = PRIMO BETA NÂO ENCONTRADO
			ControlSetText,, %Status_Usuario%, ahk_id %Gui_StatusUsuario%
			ControlSetText,, %Status%, ahk_id %Gui_status%
			goto Update	
		} else  if (Versao_BETA_Local <> Versao_BETA) {
			Status = NECESSÁRIO ATUALIZAÇÃO
			ControlSetText,, %Status_Usuario%, ahk_id %Gui_StatusUsuario%
			ControlSetText,, %Status%, ahk_id %Gui_status%
			goto Update	
		}
	}
		
		
	if (Versao_Local <> Versao_Web) {
		Status = NECESSÁRIO ATUALIZAÇÃO
		ControlSetText,, %Status_Usuario%, ahk_id %Gui_StatusUsuario%
		ControlSetText,, %Status%, ahk_id %Gui_status%
		goto Update	
	} Else {
		Status = Primo Atualizado
		if (downloadnecessario = 1) {
			Gui, Download: Destroy
			WinRestore Primo Launcher
			downloadnecessario = 0
		}
		
	}

ControlSetText,, %Status_Usuario%, ahk_id %Gui_StatusUsuario%
ControlSetText,, %Status%, ahk_id %Gui_status%

if ((VersaoPrimo == "BETAUnico") or (VersaoPrimo == "BETAMulti")) { 
ControlSetText,, %Versao_Beta_Local%, ahk_id %Gui_VL%
ControlSetText,, %Versao_Beta%, ahk_id %Gui_VW%	
} else {
ControlSetText,, %Versao_Local%, ahk_id %Gui_VL%
ControlSetText,, %Versao_Web%, ahk_id %Gui_VW%	
}

return


;==================================================================================
;================================================================================== Botão Update
;==================================================================================
Update:
if (updating = 0) {
	updating = 1
	if (((Status = "NECESSÁRIO ATUALIZAÇÃO") or (Status = "PRIMO NÂO ENCONTRADO")) and (Status_User = 1)) {
		Status = FAZENDO DOWNLOAD
	
;TrayTip ,Primo Marcos, Fazendo Download do Primo!!
WinMinimize Primo Launcher
downloadnecessario = 1
Gui, -AlwaysOnTop
Gui,Download: +AlwaysOnTop
Gui,Download: Color, 202124 
Gui,Download: Font, cFF0000
Gui,Download:Add, Text,     , FAZENDO DOWNLOAD DO PRIMO
Gui,Download:+toolwindow
Gui,Download:Show






		ControlSetText,, %Status%, ahk_id %Gui_status%
		DownloadUtilitarios()

downloadagain:
			Download()
unzipagain:
			if FileExist("Primo.zip") {
				Run unzip.bat,,Hide
				sleep 1000
				FileDelete, 	Version.ini
			} 
			if !FileExist("Primo"){
				goto unzipagain
			} else {
				FileAppend, %Versao_Web%`n%Versao_Beta%, 	Version.ini
				FileSetAttrib, +H, Version.ini
			}
			FileDelete, Primo.zip
			goto trydownloadagain
	} 
}
updating = 0
return

;==================================================================================
;================================================================================== Botão Start
;==================================================================================
Start:
CheckUser()

if ((Status = "Primo Atualizado") and (Data_Hoje<=Date_until)) {
	if (Nick_Tibia == "") {
		Gui, -AlwaysOnTop
		MsgBox, digite um nick valido.
		return
	}
	IF (Status_User = 1) {
		waitcreate:
		FileAppend, %Versao_Web%, 	C:\PrimoConfigs\windowscheck.ini
		FileDelete, Enviar.ini
		if FileExist("C:\PrimoConfigs\windowscheck.ini") {
			if (VersaoPrimo == "ScriptUnico") {
				
				if FileExist("Primo\Primo Marcos.exe") {
					IniWrite, ScriptUnico, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, VersaoPrimo1
					run Primo\Primo Marcos.exe
				} else {
					goto Update
				}
			} else if (VersaoPrimo == "MultiScripts") { 
				if FileExist("Primo\Primo Marcos.exe") {
					IniWrite, MultiScripts, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, VersaoPrimo1
					run Primo\Primo Marcos.exe
				} else {
					goto Update
				}
			}
			if (VersaoPrimo == "BETAUnico") { 
				
				if FileExist("Primo\BETA\Primo Marcos-BETA.exe") {
					IniWrite, ScriptUnico, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, VersaoPrimo1
					run Primo\BETA\Primo Marcos-BETA.exe
				} else {
					goto Update
				}
				
			} else if (VersaoPrimo == "BETAMulti") { 
				if FileExist("Primo\BETA\Primo Marcos-BETA.exe") {
					IniWrite, MultiScripts, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, VersaoPrimo1
					run Primo\BETA\Primo Marcos-BETA.exe
				} else {
					goto Update
				}
			}
		} else {
			goto waitcreate
		}
		goto GuiEscape
	}
}
return


Download() {
global
deleteagain:
	FileRemoveDir,	Primo, 1
	FileDelete, 	Version.ini
	FileDelete, Primo
	FileDelete, Primo.zip
	sleep 500
	
	if !FileExist("Primo"){
		if FileExist("Primo.zip") {
			FileDelete, Primo.zip
		} else {
			UrlDownloadToFile, 				%URLDownload%Primo.zip, 	Primo.zip
		}
	} else {
		goto deleteagain
	}
}

CheckUser(){
global
ControlSetText,, %Status_Usuario%, ahk_id %Gui_StatusUsuario%

GuiControlGet, User
GuiControlGet, Nick_Tibia
IniWrite, %User%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, User
IniWrite, %Nick_Tibia%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, Nick_Tibia



FileDelete, 					%Address%
UrlDownloadToFile, 				%URL%%User%, %Address%
FileReadLine, CheckFileUser, 	%Address%, 1
FileReadLine, Date_until, 		%Address%, 3
FileReadLine, Status_WEB_User,		%Address%, 4
FileReadLine, UUID_File,		%Address%, 5
FileReadLine, UUID_File1,		%Address%, 6
FileReadLine, UUID_File2,		%Address%, 7
FileDelete,						%Address%
DifDate = %Date_until%
EnvSub, DifDate, %Data_Hoje%, days

if (DifDate > 1) {
	 msgvalidade = %DifDate% dias de uso!
} else if (DifDate = 1) {
	 msgvalidade = 2 dias de uso!
} else if (DifDate = 0) {
	 msgvalidade = Ultimo dia de uso!
} else if (DifDate < 0) {
	 msgvalidade = Contrato Expirado!
	 	FileRemoveDir,	Primo, 1
		FileDelete, 	Version.ini
		FileDelete, Primo
		FileDelete, Primo.zip
}

if ((DifDate > 0) and (DifDate < 4)) {
	if (ChecaValidade = 0) {
		Gui, -AlwaysOnTop
		MsgBox, 262208, Marcos Informa, Sua Licença esta prestes a expirar.`nEntre em contato com a nossa equipe para nao ficar sem acesso ao primo.`nLembre-se de informar seu usuario %user%.
		ChecaValidade = 1
	}
}
	
	
ControlSetText,, %msgvalidade%, ahk_id %myedit%



if (CheckFileUser <> "PrimoMarcosCode") {
	Status_User = 0
	Status_Usuario = Usuario nao encontrado
	return
} ; Check Usuario Existe

	CheckFileUser = 0
	
	if (URL_ID = "ID_NAME") {
		UUID1 = % UUID() A_ComputerName
	} else {
		UUID1 = % UUID() 
	}
	


If (((UUID_File == UUID1) or (UUID_File1 == UUID1) or (UUID_File2 == UUID1)) and (Data_Hoje<=Date_until) and (Status_WEB_User = "Ativo")) {
	Status_User = 1
} else if (Status_WEB_User = "Inativo") {
	Status_User = 0
	Status_Usuario = Usuario Inativo
	return
} else if (Data_Hoje>Date_until) {
	Status_User = 0
	Status_Usuario = Usuario Expirado
	if (ChecaValidade = 0) {
		Gui, -AlwaysOnTop
		MsgBox, 262208, Marcos Informa, Sua Licença expirou.`nEntre em contato com a nossa equipe para nao ficar sem acesso ao primo.`nLembre-se de informar seu usuario %user%.
		ChecaValidade = 1
	}
	return
} else {
	Status_User = 0
	Status_Usuario = Usuario nao autorizado
	PrimeirologinFunc()
	return
} ; DATA e login OK	
	Status_Usuario = Usuario autorizado
	UrlDownloadToFile, 					https://primomarcos.com/last_login.php?user=%User%, 		login.ini
	FileDelete,		login.ini	
} ; Fim Check User


ZeraValoresDownload(){
global
Status_User = 0
CheckFile = 0
Date_until = 0
UUID_File = 0
updating = 0

}

DownloadUtilitarios(){
global
	if !FileExist("7z.exe"){
		UrlDownloadToFile, 					%URLDownload%7z.exe, 	7z.exe
		FileSetAttrib, +H, 7z.exe
		sleep 600
	}
	if !FileExist("7z.dll"){
		UrlDownloadToFile, 					%URLDownload%7z.dll, 	7z.dll
		FileSetAttrib, +H, 7z.dll
		sleep 600
	}
	if !FileExist("unzip.bat"){
		UrlDownloadToFile, 					%URLDownload%unzip.bat, 	unzip.bat
		FileSetAttrib, +H, unzip.bat
		sleep 600
	}
	if !FileExist("AnyDesk.exe"){
		UrlDownloadToFile, 					%URLDownload%AnyDesk.exe, 	AnyDesk.exe
		FileSetAttrib, +H, anydesk.exe
		sleep 600
	}
	
	
	
} ; Fim Download utilitarios

PrimeiroLogin:
PrimeirologinFunc()
return

PrimeirologinFunc(){
global
		if (Status_User = 1){
			return
		}
		if (User == "") {
			return
		}
		
	UUID1 = % UUID() A_ComputerName
	UrlDownloadToFile, 					https://www.primomarcos.com/first_login.php?user=%User%&id=%UUID1%, 	Cadastro.ini
	FileDelete,		Cadastro.ini
	sleep 4000
		if (Status_Usuario = "Usuario nao autorizado"){
			;Gui, -AlwaysOnTop
			;MsgBox, 262208, Marcos Informa, Encontramos um problema no cadastro de seu Computador.`nEntre em contato com nossa Equipe`nLembre-se de informar seu usuario %user%.
			Status_Usuario = Erro no Cadastro
			return
		}
	
}

^!U::
	run, anydesk.exe
return

Pacotes:
Run https://www.primomarcos.com/Pacotes.html
return

Reload:
	Reload
return

GuiEscape:
GuiClose:
ExitSub:
ExitApp ; Terminate the script unconditionally