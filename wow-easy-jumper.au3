#include <Color.au3>

Global $WinName = "World of Warcraft"

Opt("PixelCoordMode", 2) ;Отсчет координат пикселей от левого верхнего угла клиентской части окна
Opt("MouseCoordMode", 2) ;Отсчет координат мыши от левого верхнего угла клиентской части окна
$paused = false
$moving = false
HotKeySet("{F11}", "Pause")
HotKeySet("{F10}", "Kill")

;WinActivate($WinName)
$hwnd = WinGetHandle($WinName)
WinWaitActive($hwnd)
PlayFile("mapping.txt", 0)

Func PlayLine($line)
	local $command = StringSplit($line, " ", 2)
	;ToolTip(StringFormat("%s %s %s", $command[0], $command[1], $command[2]))
	Switch $command[0]
		Case "jump"
			while True
				Send("{SPACE down}")
				Sleep(30000)
				Send("{SPACE up}")
			wend
	EndSwitch
EndFunc
Func PlayFile($filename, $skip = 0)
	$hfile = FileOpen($filename, 0)
	For $i = 1 to $skip
		$line = FileReadLine($hfile)
	Next
	while True
		$line = FileReadLine($hfile)
		if @error = -1 Then ExitLoop
		PlayLine($line)
	wend
	FileClose($hfile)
	StopMoving()
EndFunc
Func StartMoving()
	if $moving then return
	$moving = true;
	WinWaitActive($hwnd)
	MouseMove(@DesktopWidth/2, @DesktopHeight/2, 0)
	MouseDown("right")
	Sleep(300)
EndFunc
Func StopMoving()
	$moving = false
	Send("{w up}{s up}{a up}{d up}")
	MouseUp("right")
	Sleep(300)
EndFunc
Func Pause()
	$paused = not $paused
	if $paused then StopMoving()
	While $Paused
		Sleep(1000)
	WEnd
EndFunc
Func Kill()
	StopMoving()
	Exit
EndFunc
