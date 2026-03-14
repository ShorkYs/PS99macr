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
#Include Modules\reconnect.ahk

global BOSS_ROOM_REGEX := "i)\bRoom\s*(3|9)\b"
global BOSS_ROOM_MOVE_DURATION := 1800

;--------------------------------------------
; HOTKEYS
;--------------------------------------------

F1::RunMacro()
F2::PauseMacro()
F3::ExitApp()
F4::reconnectClient()

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

    if PixelSearch(&GrayishX, &GrayishY, 95, 159, 162, 258, 0x88ACBF, 5) {
        Send "{Click, " GrayishX ", " GrayishY "}"
    }
    Sleep 100

    if PixelSearch(&GreenX, &GreenY, 302, 240, 401, 341, 0x84F710, 5) {
        Send "{Click, 353, 285}"
    }

    if !PixelSearch( &BlueX , &BlueY , 494, 241, 593, 341, 0x74F0FB, 5) {
        Send "{Click, 541, 290}"
        Sleep 3000
        Send "{Click, " GrayishX ", " GrayishY "}"
        Sleep 100
        Send "{Click, 353, 285}"
    }
    Sleep 2500
    Send("{d down}")
    Sleep(900)
    Send("{d up}")
    Sleep 100
    Send("{w down}")
    Sleep(240)
    Send("{w up}")
    sleep 100
    Send("{d down}")
    Sleep(600)
    Send("{d up}")
    Sleep(2000)
    Send("{w down}")
    Sleep(5600)
    Send("{w up}")
    Sleep 100
    
    If PixelSearch(&lbtnX, &lbtnY, 471, 221, 821, 300, 0x91FA15, 5) {
        updateStatus("Level button found")
        Send "{Click down, " lbtnX ", " lbtnY "}"
        updateStatus("Level button Dragging right")
        Sleep 100
        Send "{Click up, " lbtnX + 50 ", " lbtnY " }"
    }

    if PixelSearch(&BluebuttonX, &BluebuttonY, 553, 508, 745, 546, 0x77F1FB, 5) {
        updateStatus("Level button found")
        Send "{Click, " BluebuttonX ", " BluebuttonY "}"
        Sleep 100
    }
    
    Send("{w down}")
    Sleep(500)
    Send("{w up}")

    Sleep 2000
    updateStatus("Searching for Auto Raid Button")
    
    loop {
        Sleep 1200
        if PixelSearch(&AutoRaidX, &AutoRaidY, 103, 382, 153, 436, 0x419D1B, 10) {
            updateStatus("button found")
            Send "{Click, " AutoRaidX ", " AutoRaidY "}"
            break
        }
    }
   

    

    if DetectBossRoomText() {
        updateStatus("Boss room found. Entering left side.")
        Send("{a down}")
        Sleep(BOSS_ROOM_MOVE_DURATION)
        Send("{a up}")
    }

    ; Send "{Click, 127, 207}" ; TPBUTTON
    ; reconnectClient()
}


PauseMacro() {

}

DetectBossRoomText() {
    global BOSS_ROOM_REGEX
    ocrResult := OCR.FromWindow("ahk_exe RobloxPlayerBeta.exe")
    return RegExMatch(ocrResult.Text, BOSS_ROOM_REGEX)
}