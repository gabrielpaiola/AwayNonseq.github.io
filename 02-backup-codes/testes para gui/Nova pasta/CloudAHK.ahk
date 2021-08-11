; v0.0.2 Alpha

#NoEnv
SetBatchLines, -1
OnExit, OnExit

; Include the Neutron library
#Include <Neutron>

; Create a new NeutronWindow and navigate to our HTML page
neutron := new NeutronWindow()
neutron.Load("editor/index.html")
for i, elem in neutron.Each(neutron.qsa(".neutron"))
	elem.classList.remove("neutron")

; Replace the print function with one more suited to console use
text_print =
(
Blockly.AutoHotkey['text_print'] = function(block) {
  // Print statement.
  var msg = Blockly.AutoHotkey.valueToCode(block, 'TEXT',
      Blockly.AutoHotkey.ORDER_NONE) || '""';
  var functionName = Blockly.AutoHotkey.provideFunction_(
      'Print',
      [Blockly.AutoHotkey.FUNCTION_NAME_PLACEHOLDER_ +
          '(value)',
        '{',
        '\tFileOpen("*", "w").Write(IsObject(value)',
        '\t\t? "<object>``n" : value "``n")',
        '}']);
  return functionName + '(' + msg + ')\n';
};
)
neutron.wnd.eval(text_print)
while neutron.wb.ReadyState < 4
	Sleep, 50
neutron.wnd.myUpdateFunction()

; Use the Gui method to set a custom label prefix for GUI events. This code is
; equivalent to the line `Gui, name:+LabelNeutron` for a normal GUI.
neutron.Gui("+LabelNeutron")

; Show the GUI, with an initial size of 1000 x 700. Unlike with a normal GUI
; this size includes the title bar area, so the "client" area will be slightly
; shorter vertically than if you were to make this GUI the normal way.
neutron.Show("w1000 h700")
return

; FileInstall all your dependencies, but put the FileInstall lines somewhere
; they won't ever be reached. Right below your AutoExecute section is a great
; location!
FileInstall, editor/index.html, *
FileInstall, editor/index.js, *
FileInstall, editor/index.css, *
FileInstall, editor/blocks.js, *
FileInstall, css/index.css, *
FileInstall, vendor/jquery/jquery.min.js, *
FileInstall, vendor/bootstrap/css/bootstrap.min.css, *
FileInstall, vendor/bootstrap/js/bootstrap.bundle.min.js, *
FileInstall, vendor/code-prettify/loader/prettify.css, *
FileInstall, vendor/code-prettify/loader/prettify.js, *
FileInstall, vendor/Font-Awesome/css/all.min.css, *
FileInstall, vendor/Font-Awesome/webfonts/fa-solid-900.eot, *
FileInstall, vendor/Font-Awesome/webfonts/fa-solid-900.svg, *
FileInstall, vendor/Font-Awesome/webfonts/fa-solid-900.woff, *
FileInstall, vendor/Font-Awesome/webfonts/fa-solid-900.woff2, *
FileInstall, vendor/pxt-blockly/autohotkey_compressed.js, *
FileInstall, vendor/pxt-blockly/blockly_compressed.js, *
FileInstall, vendor/pxt-blockly/blocks_compressed.js, *
FileInstall, vendor/pxt-blockly/msg/messages.js, *
FileInstall, vendor/pxt-blockly/media/delete.ogg, *
FileInstall, vendor/pxt-blockly/media/delete.wav, *
FileInstall, vendor/pxt-blockly/media/delete-x.svg, *
FileInstall, vendor/pxt-blockly/media/disconnect.mp3, *
FileInstall, vendor/pxt-blockly/media/disconnect.ogg, *
FileInstall, vendor/pxt-blockly/media/disconnect.wav, *
FileInstall, vendor/pxt-blockly/media/dropdown-arrow.svg, *
FileInstall, vendor/pxt-blockly/media/dropdown-arrow-dark.svg, *
FileInstall, vendor/pxt-blockly/media/handclosed.cur, *
FileInstall, vendor/pxt-blockly/media/handdelete.cur, *
FileInstall, vendor/pxt-blockly/media/handopen.cur, *
FileInstall, vendor/pxt-blockly/media/pilcrow.png, *
FileInstall, vendor/pxt-blockly/media/position_eyedropper.svg, *
FileInstall, vendor/pxt-blockly/media/question.svg, *
FileInstall, vendor/pxt-blockly/media/quote0.png, *
FileInstall, vendor/pxt-blockly/media/quote0.svg, *
FileInstall, vendor/pxt-blockly/media/quote1.png, *
FileInstall, vendor/pxt-blockly/media/quote1.svg, *
FileInstall, vendor/pxt-blockly/media/remove.svg, *
FileInstall, vendor/pxt-blockly/media/removeArg.svg, *
FileInstall, vendor/pxt-blockly/media/sprites.png, *
FileInstall, vendor/pxt-blockly/media/sprites.svg, *
FileInstall, vendor/pxt-blockly/media/1x1.gif, *
FileInstall, vendor/pxt-blockly/media/add.svg, *
FileInstall, vendor/pxt-blockly/media/arrow.svg, *
FileInstall, vendor/pxt-blockly/media/click.mp3, *
FileInstall, vendor/pxt-blockly/media/click.ogg, *
FileInstall, vendor/pxt-blockly/media/click.wav, *
FileInstall, vendor/pxt-blockly/media/comment-arrow-down.svg, *
FileInstall, vendor/pxt-blockly/media/comment-arrow-up.svg, *
FileInstall, vendor/pxt-blockly/media/delete.mp3, *


; The built in GuiClose, GuiEscape, and GuiDropFiles event handlers will work
; with Neutron GUIs. Using them is the current best practice for handling these
; types of events. Here, we're using the name NeutronClose because the GUI was
; given a custom label prefix up in the auto-execute section.
NeutronClose:
ExitApp
return

OnExit:
ExitApp
return


ExecScript(script)
{
	static sCmd := A_AhkPath . (A_IsCompiled ? " /E" : "") . " /CP65001 *"
	
	DllCall("CreatePipe"
	, "Ptr*", hStdInRd ; PHANDLE               hReadPipe
	, "Ptr*", hStdInWr ; PHANDLE               hWritePipe
	, "Ptr", 0         ; LPSECURITY_ATTRIBUTES lpPipeAttributes
	, "UInt", 0        ; DWORD                 nSize
	, "Int") ; BOOL
	DllCall("CreatePipe"
	, "Ptr*", hStdOutRd ; PHANDLE               hReadPipe
	, "Ptr*", hStdOutWr ; PHANDLE               hWritePipe
	, "Ptr", 0          ; LPSECURITY_ATTRIBUTES lpPipeAttributes
	, "UInt", 0         ; DWORD                 nSize
	, "Int") ; BOOL
	DllCall("SetHandleInformation"
	, "Ptr", hStdInRd ; HANDLE hObject
	, "UInt", 1         ; DWORD  dwMask
	, "UInt", 1         ; DWORD  dwFlags (HANDLE_FLAG_INHERIT)
	, "Int") ; BOOL
	DllCall("SetHandleInformation"
	, "Ptr", hStdOutWr ; HANDLE hObject
	, "UInt", 1        ; DWORD  dwMask
	, "UInt", 1        ; DWORD  dwFlags (HANDLE_FLAG_INHERIT)
	, "Int") ; BOOL
	
	VarSetCapacity(pi, 8+A_PtrSize*2, 0)
	cb := VarSetCapacity(si, 32+A_PtrSize*9, 0)
	NumPut(cb       , si, 0             , "UInt") ; cb
	NumPut(0x100    , si, 28+A_PtrSize*4, "UInt") ; dwFlags = STARTF_USESTDHANDLES
	NumPut(hStdInRd , si, 32+A_PtrSize*6, "Ptr")  ; hStdInput
	NumPut(hStdOutWr, si, 32+A_PtrSize*7, "Ptr")  ; hStdOutput
	NumPut(hStdOutWr, si, 32+A_PtrSize*8, "Ptr")  ; hStdError
	
	if !DllCall("CreateProcess"
		, "Ptr", 0     ; LPCWSTR               lpApplicationName
		, "Ptr", &sCmd ; LPWSTR                lpCommandLine
		, "Ptr", 0     ; LPSECURITY_ATTRIBUTES lpProcessAttributes
		, "Ptr", 0     ; LPSECURITY_ATTRIBUTES lpThreadAttributes
		, "Int", True  ; BOOL                  bInheritHandles
		, "UInt", 0    ; DWORD                 dwCreationFlags
		, "Ptr", 0     ; LPVOID                lpEnvironment
		, "Ptr", 0     ; LPCWSTR               lpCurrentDirectory
		, "Ptr", &si   ; LPSTARTUPINFOW        lpStartupInfo
		, "Ptr", &pi   ; LPPROCESS_INFORMATION lpProcessInformation
		, "Int") ; BOOL
	{
		DllCall("CloseHandle", "Ptr", hStdInRd, "Int")
		DllCall("CloseHandle", "Ptr", hStdInWr, "Int")
		DllCall("CloseHandle", "Ptr", hStdOutRd, "Int")
		DllCall("CloseHandle", "Ptr", hStdOutWr, "Int")
		return
	}
	
	DllCall("CloseHandle", "Ptr", hStdOutWr, "Int")
	DllCall("CloseHandle", "Ptr", hStdInRd, "Int")
	
	; The write pipe must be closed before reading the stdout.
	FileOpen(hStdInWr, "h", "UTF-8").Write(script)
	DllCall("CloseHandle", "Ptr", hStdInWr, "Int")
	
	return {"base": {"__Delete": "CloseHandles"}, "hStdOutRd": hStdOutRd, "hProcess": NumGet(pi, 0), "hThread": NumGet(pi, A_PtrSize)}
}

CloseHandles(handles)
{
	DetectHiddenWindows, On
	WinKill, % "ahk_class AutoHotkey ahk_pid" DllCall("GetProcessId", "Ptr", handles.hProcess, "UInt")
	;	DllCall("TerminateProcess", "Ptr", handles.hProcess, "UInt", 0, "Int")
	for k, handle in handles
		DllCall("CloseHandle", "Ptr", handle)
}



CheckIfRunning()
{
	global neutron, handles, output
	
	if !DllCall("PeekNamedPipe"
		, "Ptr", handles.hStdOutRd ; HANDLE  hNamedPipe
		, "Ptr", 0                 ; LPVOID  lpBuffer
		, "UInt", 0                ; DWORD   nBufferSize
		, "Ptr", 0                 ; LPDWORD lpBytesRead
		, "UInt*", nTot            ; LPDWORD lpTotalBytesAvail
		, "Ptr", 0                 ; LPDWORD lpBytesLeftThisMessage
		, "Int") ; BOOL
	{
		handles := ""
		SetTimer, CheckIfRunning, Off
		neutron.qs("#run-button").innerText := "Run"
		return
	}
	
	if !nTot
		return
	
	VarSetCapacity(sTemp, nTot+1, 0)
	DllCall("ReadFile"
	, "Ptr", handles.hStdOutRd ; HANDLE       hFile
	, "Ptr", &sTemp            ; LPVOID       lpBuffer
	, "UInt", nTot             ; DWORD        nNumberOfBytesToRead
	, "Ptr*", nSize            ; LPDWORD      lpNumberOfBytesRead
	, "Ptr", 0                 ; LPOVERLAPPED lpOverlapped
	, "Int") ; BOOL
	
	output .= StrGet(&sTemp, nSize, "UTF-8")
	conout := neutron.qs("#conout div")
	conout.innerText := output
	conout.scrollTop := conout.scrollHeight
}

; --- Trigger AHK by page events ---

RunButton(neutron, event)
{
	global handles, output
	
	neutron.wnd.jQuery("#conout").collapse("show")
	
	if (handles) ; Running
		handles := "" ; CheckIfRunning updates the GUI
	else ; Not running or doesn't exist
	{
		handles := ExecScript(neutron.qs("#code").innerText)
		event.target.innerText := "Kill"
		SetTimer, CheckIfRunning, 100

		output := ""
		neutron.qs("#conout div").innerText := output
	}
}