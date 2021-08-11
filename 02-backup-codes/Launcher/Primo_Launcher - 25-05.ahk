#SingleInstance, Force
OnExit, ExitSub
Thread, interrupt, 0
Thread, NoTimers, true
Process, Priority,, Low

Address = C:\PrimoConfigs\gsdfa.ini
URL = https://primomarcos.com/usuarios/
URLData = https://primomarcos.com/data
URLDownload = https://primomarcos.com/Downloads/

Status_Usuario = Checando Usuario
Versao_Launcher_Local = Launcher3

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
		
;Menu, Tray, Icon, 																Complementos\ICONS\Skull.ico
Menu, Tray, Tip, 																Primo Marcos Launcher

Gui, +AlwaysOnTop ; FUNCAO ATIVA, DEIXA MACRO SEMPRE NA FRENTE DA TELA
Gui, +LastFound -Theme
Gui, Color, 																	4F4F4F 
Gui, Font, 																		cFFFFFF
Gui, Margin, 																	10, 10

Gui, Add, Button, 		x360	y4 		h15								gReload, Reload Launcher
Gui, Add, Button, 		x470	y4 	w30	h15								gExitSub, Exit


Gui, Add, Text, 		x180 	y285 	h20,							Nick do Char:
Gui, Add, Edit, 		x180 	y300 	w120 	h20 cBlack 				vNick_Tibia, %Nick_Tibia%

Gui, Add, Text, 		x180 	y325 	h20, 							Usuario:
Gui, Add, Edit,			x180 	y340 w120 h20 cBlack 					vUser, %User%
Gui, Add, edit,			x180	y370	w120			ReadOnly		hwndGui_StatusUsuario,

Gui, Add, Text, 		x7		y340	h20								,Versão Local
Gui, Add, edit,			x7		y355	w60			ReadOnly			hwndGui_VL,
Gui, Add, Text, 		x100	y340	h20								,Versão WEB
Gui, Add, edit,			x100	y355	w60			ReadOnly			hwndGui_VW,
Gui, Add, edit,			x7		y310		w155			ReadOnly	hwndGui_status,

Gui, Add, Button, 		x320 	y325 			w80	h40					gPrimeiroLogin, Primeiro Login
;Gui, Add, Button, 		x320	y325 	w80 	h40 					gCheck, Update Download
Gui, Add, Button, 		x410	y325 	w80 	h40 					gStart, Start




Gui, Add, Tab, x1 y1 w500 h280 											,Launcher|Contato
Gui, Tab, 										Launcher
;Gui, Add, Text, 		x7		y30		w487 h220							vMsg_GUI
Gui, Add, Text, 		x7		y30		w487 h15							vMsg_GUI1
Gui, Add, Text, 		x7		y45		w487 h15							vMsg_GUI2
Gui, Add, Text, 		x7		y60		w487 h15							vMsg_GUI3
Gui, Add, Text, 		x7		y75		w487 h15							vMsg_GUI4
Gui, Add, Text, 		x7		y90		w487 h15							vMsg_GUI5
Gui, Add, Text, 		x7		y105	w487 h15							vMsg_GUI6
Gui, Add, Text, 		x7		y120	w487 h15							vMsg_GUI7
Gui, Add, Text, 		x7		y135	w487 h15							vMsg_GUI8
Gui, Add, Text, 		x7		y150	w487 h15							vMsg_GUI9
Gui, Add, Text, 		x7		y165	w487 h15							vMsg_GUI10
Gui, Add, Text, 		x7		y180	w487 h15							vMsg_GUI11
Gui, Add, Text, 		x7		y195	w487 h15							vMsg_GUI12
Gui, Add, Text, 		x7		y210	w487 h15							vMsg_GUI13
Gui, Add, Text, 		x7		y225	w487 h15							vMsg_GUI14
Gui, Add, Text, 		x7		y240	w487 h15							vMsg_GUI15
Gui, Add, Text, 		x7		y255	w487 h15							vMsg_GUI16

Gui, Tab, 										Contato
Gui, Add, Link,		x12 	y40,											Convite para <a href="https://discord.gg/7tduQuNrJU">Discord</a>
Gui, Add, Text,		x12		y70,											Discord para Contato: Away#8001
Gui, Add, Link,		x12 	y90,											Em caso de Duvidas <a href="https://discord.gg/xn99BseQHc">Tutoriais</a>





Gui, Show, % " w" GUIWidth " h" GUIHeight, Primo Launcher
}
trydownloadagain:
FileDelete,		Data.ini
UrlDownloadToFile, 					%URLData%, 	Data.ini
FileReadLine, CheckFile, 									Data.ini, 1
FileReadLine, Versao_Web, 									Data.ini, 3
FileReadLine, Versao_Launcher,								Data.ini, 4
FileReadLine, Mensagem, 									Data.ini, 5
FileReadLine, Mensagem1, 									Data.ini, 6
FileReadLine, Mensagem2, 									Data.ini, 7
FileReadLine, Mensagem3, 									Data.ini, 8
FileReadLine, Mensagem4, 									Data.ini, 9
FileReadLine, Mensagem5, 									Data.ini, 10
FileReadLine, Mensagem6, 									Data.ini, 11
FileReadLine, Mensagem7, 									Data.ini, 12
FileReadLine, Mensagem8, 									Data.ini, 13
FileReadLine, Mensagem9, 									Data.ini, 14
FileReadLine, Mensagem10, 									Data.ini, 15
FileReadLine, Mensagem11, 									Data.ini, 16
FileReadLine, Mensagem12, 									Data.ini, 17
FileReadLine, Mensagem13, 									Data.ini, 18
FileReadLine, Mensagem14, 									Data.ini, 19
FileReadLine, Mensagem15, 									Data.ini, 20
FileReadLine, Mensagem16, 									Data.ini, 21
FileDelete,		Data.ini

	if (CheckFile <> "<html>") {
		Gui, -AlwaysOnTop
		msgbox, Servidor Offline`nEntre em contato com o fornecedor.
		goto trydownloadagain
	}

	if (Versao_Launcher <> Versao_Launcher_Local)	{ 
		UrlDownloadToFile, 				%URLDownload%Primo_Launcher.exe, 	Primo_%Versao_Launcher%.exe
		Gui, -AlwaysOnTop
		msgbox, Necessario atualizar launcher`nUtilizar a versao nova ja disponivel na pasta %A_WorkingDir%`n Nome do novo > Primo_%Versao_Launcher%.exe
		exitapp
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
GuiControl,, Msg_GUI15, %Mensagem15%
GuiControl,, Msg_GUI16, %Mensagem16%





	Settimer LancherScript, 0
return

LancherScript:
	ZeraValoresDownload()
	CheckUser()
	
updating = 0
if FileExist("Version.ini"){
	FileReadLine, Versao_Local, 								Version.ini, 1
} else {
	Versao_Local = 0
}
	if !FileExist("Primo"){
		Status = PRIMO NÂO ENCONTRADO
		goto Update	
		goto needUpdate
	}
	if (Versao_Local <> Versao_Web) {
		Status = NECESSÁRIO ATUALIZAÇÃO
		goto Update	
		goto needUpdate
	} Else {
		Status = Primo Atualizado
	}
needUpdate:

ControlSetText,, %Status_Usuario%, ahk_id %Gui_StatusUsuario%
ControlSetText,, %Status%, ahk_id %Gui_status%
ControlSetText,, %Versao_Local%, ahk_id %Gui_VL%
ControlSetText,, %Versao_Web%, ahk_id %Gui_VW%	

return


;==================================================================================
;================================================================================== Botão Update
;==================================================================================
Update:
if (updating = 0) {
	updating = 1
	if (((Status = "NECESSÁRIO ATUALIZAÇÃO") or (Status = "PRIMO NÂO ENCONTRADO")) and (Status_User = 1)) {
		Status = FAZENDO DOWNLOAD
		ControlSetText,, %Status%, ahk_id %Gui_status%
		tooltip, FAZENDO DOWNLOAD AGUARDE
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
				FileAppend, %Versao_Web%, 	Version.ini
				FileSetAttrib, +H, Version.ini
			}
			FileDelete, Primo.zip
			tooltip
			goto trydownloadagain
	} else if ((Status = "Primo Atualizado") and (Status_User = 1)) {
		Gui, -AlwaysOnTop
		msgbox, Primo ja Atualizado!
	} 
}
updating = 0
return

;==================================================================================
;================================================================================== Botão Start
;==================================================================================
Start:
CheckUser()
if (Status = "Primo Atualizado") {
	if (Nick_Tibia == "") {
		Gui, -AlwaysOnTop
		MsgBox, digite um nick valido.
		return
	}
	IF (Status_User = 1) {
		FileAppend, %Versao_Web%, 	C:\PrimoConfigs\windowscheck.ini
		FileDelete, Enviar.ini
		waitcreate:
		if FileExist("C:\PrimoConfigs\windowscheck.ini") {
			run Primo\Primo Marcos.exe
			goto ExitSub
		} else {
			goto waitcreate
		}
	}
} else if ((Status <> "Primo Atualizado") and (Status_User = 1)) {
		Gui, -AlwaysOnTop
		msgbox, Versao atual do Primo Nao Encontrada`nNecessario Baixar Atualizado`nClique no Botao Update/Download
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
UrlDownloadToFile, 				%URL%%User%.html, %Address%
FileReadLine, CheckFile, 		%Address%, 2
FileReadLine, Date_until, 		%Address%, 9
FileReadLine, UUID_File,		%Address%, 11
FileReadLine, UUID_File1,		%Address%, 12
FileReadLine, UUID_File2,		%Address%, 13
FileDelete,						%Address%
DifDate = %Date_until%
EnvSub, DifDate, %Data_Hoje%, days

if (CheckFile <> "PrimoMarcosCode") {
	Status_User = 0
	Status_Usuario = Usuario nao encontrado
	return
} ; Check Usuario Existe
	
If (((UUID_File == UUID()) or (UUID_File1 == UUID()) or (UUID_File2 == UUID())) and (Data_Hoje<=Date_until)) {
	Status_User = 1
} else { 
	Status_User = 0
	Status_Usuario = Usuario nao autorizado
	return
} ; DATA e login OK	
	Status_Usuario = Usuario autorizado
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
} ; Fim Download utilitarios


PrimeiroLogin:
Gui, -AlwaysOnTop
	MsgBox, Foi criado um arquivo na pasta do Raiz do Primo`ncom o nome Enviar.ini`nApos isso na Aba Contato no launcher`nentrar no discord e enviar o arquivo para -> Away (adm no servidor)
FileDelete, 			Enviar.ini
FileAppend, % UUID(), 	Enviar.ini
return

Reload:
	Reload
return

GuiEscape:
GuiClose:
ExitSub:
ExitApp ; Terminate the script unconditionally