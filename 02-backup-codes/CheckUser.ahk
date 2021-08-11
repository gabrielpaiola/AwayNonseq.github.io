; =======================================================================================
; Name ..........: Primo Marcos
; Description ...: V3 - 18/05_2021
; Language ......: Portugues Brasil (PT-BR)
; Author ........: Away
; =======================================================================================


;==================================================================================
;================================================================================== Valores Iniciais
;==================================================================================
URL = https://primomarcos.com/users.php?user=
URLData = https://primomarcos.com/date.php
Address = C:\PrimoConfigs\gsdfa.ini


;==================================================================================
;================================================================================== GUI LOGIN
;==================================================================================

GuiLogin() {
Global

IniRead, UserCheck1, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, UserCheck1
	
	
		Static GUICreate := GuiLogin()
		GUIWidth := 262, GUIHeight := 142
		
Menu, Tray, Tip, 																Primo Marcos Check Users


Gui, +AlwaysOnTop ; FUNCAO ATIVA, DEIXA MACRO SEMPRE NA FRENTE DA TELA
Gui, +LastFound -Theme
Gui, Color, 																	202124 
Gui, Font, 																		cFFFFFF
Gui, Margin, 																	10, 10


Gui, Add, Text, x22 y20 h20, 													Usuario:
Gui, Add, Edit, x22 y40 w120 h20 cBlack 		 								vUserCheck1, %UserCheck1%
Gui, Font, 																		cWhite


Gui, Add, edit,			x7	y80	w150 h40	ReadOnly	 	hwndmyedit, myedit


Gui, Show, % " w" GUIWidth " h" GUIHeight, Primo Check Users
}

Settimer Start, 100
return

;==================================================================================
;================================================================================== Checa Validade
;==================================================================================
Start:
GuiControlGet, UserCheck1
ControlSetText,, %msgvalidade%, ahk_id %myedit%
IniWrite, %UserCheck1%, C:\PrimoConfigs\Padrao\ConfigGeral.ini, Principal, UserCheck1



FileDelete, 					%Address%
UrlDownloadToFile, 				%URL%%UserCheck1%, %Address%
FileReadLine, CheckFile, 		%Address%, 1
FileReadLine, Date_until, 		%Address%, 3
FileDelete,						%Address%

FileDelete, 															Data.ini
UrlDownloadToFile, 					%URLData%, 	Data.ini
FileSetAttrib, +H, 														Data.ini
FileReadLine, Data_Hoje, 									Data.ini, 2
	if !FileExist("Data.ini"){
		Gui, -AlwaysOnTop
			msgbox, Não foi Possivel Validar a Data Atual`nContate o Fornecedor
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

if (CheckFile <> "PrimoMarcosCode") {
		msgvalidade = Usuario Nao Encontrado
		goto Start
	}


return



GuiEscape:
GuiClose:
ExitSub:

ExitApp ; Terminate the script unconditionally