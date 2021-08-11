#SingleInstance, Force
OnExit, ExitSub
Thread, interrupt, 0
Thread, NoTimers, true
Process, Priority,, Low

Address = C:\PrimoConfigs\gsdfa.ini
URL = http://www.primomarcos.com/usuarios/
URLData = http://www.primomarcos.com/
URLDownload = http://www.primomarcos.com/Downloads/

FileDelete, Primo.zip
FileDelete, C:\PrimoConfigs\windowscheck.ini

if !FileExist("7z.exe"){
	UrlDownloadToFile, 					%URLDownload%7z.exe, 	7z.exe
	FileSetAttrib, +H, 7z.exe
}
if !FileExist("7z.dll"){
	UrlDownloadToFile, 					%URLDownload%7z.dll, 	7z.dll
	FileSetAttrib, +H, 7z.dll
}
if !FileExist("unzip.bat"){
	UrlDownloadToFile, 					%URLDownload%unzip.bat, 	unzip.bat
	FileSetAttrib, +H, unzip.bat
}


if !FileExist("C:\PrimoConfigs"){
	FileCreateDir, C:\PrimoConfigs
	FileCreateDir, C:\PrimoConfigs\Padrao
		CONTEUDO_Geral=[Principal]`nEndConfigSuporte=`nEndConfigAtaque =`nUser=`nNick_Tibia =
		FileAppend, %CONTEUDO_Geral%, C:\PrimoConfigs\Padrao\ConfigGeral.ini	
}

updating = 0
CheckFile = 0

UUID()
{
	For obj in ComObjGet("winmgmts:{impersonationLevel=impersonate}!\\" . A_ComputerName . "\root\cimv2").ExecQuery("Select * From Win32_ComputerSystemProduct")
		return obj.UUID	; http://msdn.microsoft.com/en-us/library/aa394105%28v=vs.85%29.aspx
}

GuiLauncher() {
Global
if FileExist("C:\PrimoConfigs\Padrao\ConfigGeral.ini"){ 
	IniRead, User, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, User
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
Gui, Add, Button, 		x200 	y315 									gPrimeiroLogin, Primeiro Login
Gui, Add, Text, 		x180 	y340 	h20, 							Usuario:
	if FileExist("C:\PrimoConfigs\Padrao\ConfigGeral.ini"){ 
		Gui, Add, Edit,			x180 	y360 w120 h20 cBlack 					vUser, %User%
	} else {
		Gui, Add, Edit,			x180 	y360 w120 h20 cBlack 					vUser	
	}

Gui, Add, Button, 		x320	y335 	w80 	h40 					gUpdate, Update Download
Gui, Add, Button, 		x410	y335 	w80 	h40 					gStart, Ligar
Gui, Add, Text, 		x7		y350	h20								,Versão Local
Gui, Add, edit,			x7		y365	w60			ReadOnly			hwndGui_VL,
Gui, Add, Text, 		x100	y350	h20								,Versão WEB
Gui, Add, edit,			x100	y365	w60			ReadOnly			hwndGui_VW,
;Gui, Add, Text, 		x7		y300	h20								,Status:
Gui, Add, edit,			x7		y320		w155			ReadOnly	hwndGui_status,


Gui, Add, Tab, x1 y1 w500 h310 ,												Launcher|Contato
Gui, Tab, 										Launcher
Gui, Add, edit,			x7		y30		w487 	h270	ReadOnly		hwndGui_msg,
Gui, Tab, 										Contato
Gui, Add, Link,		x12 	y40,											Convite para <a href="https://discord.gg/7tduQuNrJU">Discord</a>
Gui, Add, Text,		x12		y70,											Discord para Contato: Away#8001
Gui, Add, Link,		x12 	y90,											Em caso de Duvidas <a href="https://discord.gg/xn99BseQHc">Tutoriais</a>





Gui, Show, % " w" GUIWidth " h" GUIHeight, Primo Login
}
trydownloadagain:
FileDelete, 																Data.ini
UrlDownloadToFile, 					%URLData%data.html, 	Data.ini
FileReadLine, CheckFile, 									Data.ini, 1
FileReadLine, Versao_Web, 									Data.ini, 3
FileReadLine, Mensagem, 									Data.ini, 4
	if (CheckFile <> "<html>") {
		Gui, -AlwaysOnTop
			msgbox, Servidor Offline`nEntre em contato com o fornecedor.
			goto trydownloadagain
	}
FileDelete,																		Data.ini
ControlSetText,, %Mensagem%, ahk_id %Gui_msg%

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

Update:
if (updating = 0) {
	updating = 1
CheckUser()
	if ((Status = "NECESSÁRIO ATUALIZAÇÃO") or (Status = "PRIMO NÂO ENCONTRADO")) {
		if (CheckFile <> "PrimoMarcosCode") {
			Gui, -AlwaysOnTop
			msgbox, Digite um Usuario Valido`nCaso seja primeiro login`nClique no Botao acima
			return
		} 
downloadagain:
			Download()
unzipagain:
			if FileExist("Primo.zip") {
				Unzip()
				sleep 1000
			} 
			if !FileExist("Version.ini"){
				goto unzipagain
			}
			FileDelete, Primo.zip
			goto trydownloadagain
	} else if (Status = "Primo Atualizado") {
		Gui, -AlwaysOnTop
		msgbox, Primo ja Atualizado!
	}
}
return

Download() {
global
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
	}
}

PrimeiroLogin:
Gui, -AlwaysOnTop
	MsgBox, Foi criado um arquivo na pasta do Raiz do Primo`ncom o nome Enviar.ini`nApos isso na Aba Contato no launcher`nentrar no discord e enviar o arquivo para -> Away (adm no servidor)
FileDelete, 			Enviar.ini
FileAppend, % UUID(), 	Enviar.ini
return

CheckUser(){
global
GuiControlGet, User
IniWrite, %User%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, User
FileDelete, 					%Address%
UrlDownloadToFile, 				%URL%%User%.html, %Address%
FileReadLine, CheckFile, 		%Address%, 2
FileDelete,						%Address%
}

Start:
CheckUser()
	if (Status = "Primo Atualizado") {
		if (CheckFile <> "PrimoMarcosCode") {
			Gui, -AlwaysOnTop
			msgbox, Digite um Usuario Valido`nCaso seja primeiro login`nClique no Botao acima
			return
		} 
		FileAppend, Checando, 	C:\PrimoConfigs\windowscheck.ini
		FileDelete, Enviar.ini
		run Primo\Primo Marcos.exe
		goto ExitSub
	}
return

Unzip(){
global
comando=
	Run unzip.bat,,Hide
	;run, cmd /T:0A /k "title %title2%&mode con lines=4000 cols=120&%comando%,,,pid2
	;WinWait, ahk_pid %pid2%
	;sleep 500
	;Process, Close, cmd.exe
	;Process, WaitClose, cmd.exe
}


GuiEscape:
GuiClose:
ExitSub:
ExitApp ; Terminate the script unconditionally