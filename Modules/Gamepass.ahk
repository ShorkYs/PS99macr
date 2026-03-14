#Requires AutoHotkey v2.0

GAMEPASS_WINDOW := {x: 771, y: 363, color: "0x393b3d"}
GAMEPASS_CANCEL_BUTTON := {x: 868, y: 657}

closeGamepassWindow() {
    if isBuyGamepassWindowDisplayed() {
        button := GAMEPASS_CANCEL_BUTTON
        Loop {
            SendEvent "{Click, " button.x ", " button.y ", 1}"
            Sleep 10
            if !isBuyGamepassWindowDisplayed()
                break
        }
        Sleep 100
    }
}

isBuyGamepassWindowDisplayed() {
    pixel := GAMEPASS_WINDOW
    activateRoblox()
    return PixelSearch(&X, &Y, pixel.x, pixel.y, pixel.x, pixel.y, pixel.color, 2)
}