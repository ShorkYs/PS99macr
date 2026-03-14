#Requires AutoHotkey v2.0
global MACRO_TITLE := "PS99 Clan Battle Macro"

;--------------------------------------------
; INCLUDES
;--------------------------------------------

#include Modules\RandomFunctions.ahk
#include Modules\UserInterface.ahk
#Include Modules\Gamepass.ahk
#Include Modules\ChatMenu.ahk
#Include Modules\StatusUpdates.ahk
#Include Lib\OCR.ahk

global BOSS_ROOM_REGEX := "i)\bRoom\s*(3|9)\b"
global BOSS_ROOM_MOVE_DURATION := 1800

;--------------------------------------------
; HOTKEYS
;--------------------------------------------

F1::RunMacro()
F2::PauseMacro()
F3::ExitApp()

CoordMode("Mouse", "Window")
CoordMode("Pixel", "Window")


;--------------------------------------------
; GUI
;--------------------------------------------
VaultGUI := Gui()
VaultGUI.Add("Button", "x5 y383 w102 h31", "RunMacro")
VaultGUI.Add("CheckBox", "x144 y38 w120 h23", "open P2W key")
VaultGUI.Add("Text", "x144 y5 w120 h23 +0x200", "Event Controls")
VaultGUI.Add("CheckBox", "x144 y65 w120 h23", "Open Free key")
VaultGUI.Add("CheckBox", "x144 y93 w120 h23", "Possible Check")
VaultGUI.Add("CheckBox", "x145 y120 w120 h23", "Possible Check")
VaultGUI.Add("Text", "x10 y5 w120 h23 +0x200", "F1 = Start Macro")
VaultGUI.Add("Text", "x9 y31 w120 h23 +0x200", "F2 = Pause Macro")
VaultGUI.Add("Text", "x9 y57 w120 h23 +0x200", "F3 = Exit Macro")
VaultGUI.show()

RunMacro() {
    global BOSS_ROOM_MOVE_DURATION
    updateStatus("Macro Starting Pre-Setup")
    Sleep(500)
    resizeRobloxWindow()

    Send "{Click, 128, 240}"
    Sleep 100

    if PixelSearch(&GreenX, &GreenY, 302, 240, 401, 341, 0x84F710, 5) {
        Send "{Click, 353, 285}"
    }

    if !PixelSearch( &BlueX , &BlueY , 494, 241, 593, 341, 0x74F0FB, 5) {
        Send "{Click, 541, 290}"
        Sleep 3000
        Send "{Click, 128, 240}"
        Sleep 100
        Send "{Click, 353, 285}"
    }
    
    
    Sleep 1200

    Send("{W}")

    if DetectBossRoomText() {
        updateStatus("Boss room found. Entering left side.")
        Send("{a down}")
        Sleep(BOSS_ROOM_MOVE_DURATION)
        Send("{a up}")
    }

    ; Send "{Click, 127, 207}" ; TPBUTTON
}


PauseMacro() {

}

DetectBossRoomText() {
    global BOSS_ROOM_REGEX
    ocrResult := OCR.FromWindow("ahk_exe RobloxPlayerBeta.exe")
    return RegExMatch(ocrResult.Text, BOSS_ROOM_REGEX)
}
