Gui, -Caption
Gui, font, s22 cwhite

Gui, Add, Picture, x0 y0, titlebar2.png
Gui, Add, Text, x0 y0 w450 h40 +BackgroundTrans gUImove
Gui, Add, Picture, x458 y4 gGuiEscape +BackgroundTrans, Close Circle Buttons.png
Gui, Add, Picture, x0 y40, bg.png

Gui, Add, Text, x20 y83 +BackgroundTrans, Internet
Gui, Add, Button, x310 y70 w0 h0 vc0 gClick Default, 0
Gui, Add, Picture, x310 y70 +BackgroundTrans vc1 gClick, button on 1.png
Gui, Add, Picture, x310 y70 +BackgroundTrans vc2 gClick hidden, button off 1.png


Gui, Add, Text, x20 y176 +BackgroundTrans, Sound
Gui, Add, Button, x310 y160 w0 h0 vx0 gClick1, 1
Gui, Add, Picture, x310 y160 +BackgroundTrans vx1 gClick1, button on 1.png
Gui, Add, Picture, x310 y160 +BackgroundTrans vx2 gClick1 hidden, button off 1.png

Gui, Add, Text, x20 y269 +BackgroundTrans, Microphone
Gui, Add, Button, x310 y250 w0 h0 vy0 gClick2, 2
Gui, Add, Picture, x310 y250 +BackgroundTrans vy1 gClick2, button on 1.png
Gui, Add, Picture, x310 y250 +BackgroundTrans vy2 gClick2 hidden, button off 1.png

Gui, Show, w500 h340, image gui
gosub ~tab
ci := 1, xi := 1, yi := 1
Return


#IfWinActive, image gui
~tab::
sleep 100
ControlGetFocus, OutputVar,image gui


return


uiMove:
PostMessage, 0xA1, 2,,, A 
Return

close:
GuiEscape:
Exitapp

Click:
	GuiControl Hide, c%ci%
	ci := 3 - ci
	GuiControl Show, c%ci%
	ControlFocus, button1, image gui
	gosub ~tab
Return

Click1:
	GuiControl Hide, x%xi%
	xi := 3 - xi
	ControlFocus, button2, image gui
	GuiControl Show, x%xi%
	gosub ~tab
Return

Click2:
	GuiControl Hide, y%yi%
	yi := 3 - yi
	ControlFocus, button3, image gui
	GuiControl Show, y%yi%
	gosub ~tab
Return