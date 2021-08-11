#SingleInstance, Force
OnExit, ExitSub
Thread, interrupt, 0
Thread, NoTimers, true
Process, Priority,, Low

Address = C:\PrimoConfigs\gsdfa.ini
URL = https://primomarcos.com/usuarios/
URLData = https://primomarcos.com/data
URLDownload = https://primomarcos.com/Downloads/

Versao_Launcher_Local = Launcher1

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

Gui, Add, Button, 		x470	y4 	w30	h15								gExitSub, Exit
Gui, Add, Button, 		x320 	y315 			w80	h40					gPrimeiroLogin, Primeiro Login

Gui, Add, Text, 		x180 	y315 	h20,							Nick do Char:
Gui, Add, Edit, 		x180 	y330 	w120 	h20 cBlack 				vNick_Tibia, %Nick_Tibia%

Gui, Add, Text, 		x180 	y355 	h20, 							Usuario:
Gui, Add, Edit,			x180 	y370 w120 h20 cBlack 					vUser, %User%
Gui, Add, Button, 		x320	y355 	w80 	h40 					gUpdate, Update Download
Gui, Add, Button, 		x410	y315 	w80 	h80 					gStart, Start
Gui, Add, Text, 		x7		y350	h20								,Versão Local
Gui, Add, edit,			x7		y365	w60			ReadOnly			hwndGui_VL,
Gui, Add, Text, 		x100	y350	h20								,Versão WEB
Gui, Add, edit,			x100	y365	w60			ReadOnly			hwndGui_VW,
Gui, Add, edit,			x7		y320		w155			ReadOnly	hwndGui_status,


Gui, Add, Tab, x1 y1 w500 h310 ,												Launcher|Contato
Gui, Tab, 										Launcher
Gui, Add, Text, 		x7		y30		w487 h270							vMsg_GUI
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
FileDelete,		Data.ini

	if (CheckFile <> "<html>") {
		Gui, -AlwaysOnTop
		msgbox, Servidor Offline`nEntre em contato com o fornecedor.
		goto trydownloadagain
	}

	if (Versao_Launcher <> Versao_Launcher_Local)	{ 
		Gui, -AlwaysOnTop
		msgbox, Necessario atualizar launcher`nbaixe em nosso site ou entre em contato com o fornecedor!!`nLauncher Local   %Versao_Launcher_Local%`nLauncher Web   %Versao_Launcher%
		exitapp
	}
	
	
	
GuiControl,, Msg_GUI, %Mensagem%		

	
	Settimer LancherScript, 0
return

LancherScript:
updating = 0
if FileExist("Version.ini"){
	FileReadLine, Versao_Local, 								Version.ini, 1
} else {
	Versao_Local = 0
}
	if !FileExist("Primo"){
		Status = PRIMO NÂO ENCONTRADO
		goto needUpdate
	}
	if (Versao_Local <> Versao_Web) {
		Status = NECESSÁRIO ATUALIZAÇÃO
		goto needUpdate
	} Else {
		Status = Primo Atualizado
	}
needUpdate:

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
ZeraValoresDownload()
CheckUser()	
	if (((Status = "NECESSÁRIO ATUALIZAÇÃO") or (Status = "PRIMO NÂO ENCONTRADO")) and (Status_User = 1)) {
		tooltip, FAZENDO DOWNLOAD AGUARDE
		ZeraValoresDownload()
		CheckUser()
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
ZeraValoresDownload()
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
	Gui, -AlwaysOnTop
	msgbox, Usuario Nao Encontrado`nCaso seja primeiro login`nClique no Botao acima
	return
} ; Check Usuario Existe
	
If (((UUID_File == UUID()) or (UUID_File1 == UUID()) or (UUID_File2 == UUID())) and (Data_Hoje<=Date_until)) {
	Status_User = 1
} else { 
	Status_User = 0
	Gui, -AlwaysOnTop
	MsgBox, Login nao autorizado!`nVoce tem %DifDate% dias de uso(s).`nEntre em contato com o Fornecedor.
	return
} ; DATA e login OK	

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

GuiEscape:
GuiClose:
ExitSub:
ExitApp ; Terminate the script unconditionally