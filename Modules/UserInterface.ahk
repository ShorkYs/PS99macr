#Requires AutoHotkey v2.0

UI_CAMERA_ICON_PIXEL := {x: 771, y: 36, colour: "0xeaecee"}
UI_SETTINGS_MENU_PIXEL := {x: 276, y: 142, colour: "0xb3816a"}
UI_BACKPACK_PIXEL := {x: 535, y: 266, colour: "0xd1d3d5"}
UI_ROD_PIXEL := {x: 118, y: 531, colour: "0x82d3ff"}

UI_CAMERA_ICON_BUTTON := {x: 766, y: 34}

hideUserInterface() {
    updateStatus("Hiding user interface.")

    if isUserInterfaceDisplayed() {
        button := UI_CAMERA_ICON_BUTTON
        Loop {
            SendEvent "{Click, " button.x ", " button.y ", 1}"
            Sleep 10
            if !isUserInterfaceDisplayed()
                break
        }
    }  
    
    updateStatus("")
}

showUserInterface() {
    if !isUserInterfaceDisplayed() {
        button := UI_CAMERA_ICON_BUTTON
        Loop {
            SendEvent "{Click, " button.x ", " button.y ", 1}"
            Sleep 10
            if isUserInterfaceDisplayed()
                break
        }
    }    
}

isUserInterfaceDisplayed() {
    pixel := UI_CAMERA_ICON_PIXEL
    activateRoblox()
    return PixelSearch(&X, &Y, pixel.x, pixel.y, pixel.x, pixel.y, pixel.colour, 2)        
}

hideSettingsMenu() {
    if isSettingsMenuDisplayed() {
        Loop {
            Send "{m}"
            Sleep 10
            if !isSettingsMenuDisplayed()
                break
        }
    }    
}

showSettingsMenu() {
    if !isSettingsMenuDisplayed() {
        Loop {
            Send "{m}"
            Sleep 10
            if isSettingsMenuDisplayed()
                break
        }
    }    
}

isSettingsMenuDisplayed() {
    pixel := UI_SETTINGS_MENU_PIXEL
    activateRoblox()
    return PixelSearch(&X, &Y, pixel.x, pixel.y, pixel.x, pixel.y, pixel.colour, 2)       
}


closeBackpack() {
    updateStatus("Closing backpack.")

    if isBackpackOpen() {
        Loop {
            Send "{~}"
            Sleep 10
            if !isBackpackOpen()
                break
        }
    }

    updateStatus("")
}

openBackpack() {
    if !isBackpackOpen() {
        Loop {
            Send "{~}"
            Sleep 10
            if isBackpackOpen()
                break
        }
    }    
}

isBackpackOpen() {
    pixel := UI_BACKPACK_PIXEL
    activateRoblox()
    return PixelSearch(&X, &Y, pixel.x, pixel.y, pixel.x, pixel.y, pixel.colour, 2)        
}

equipRod() {
    updateStatus("Equipping rod.")

    if !isRodEquipped() {
        Loop {
            Send "{1}"
            Sleep 10
            if isRodEquipped()
                break
        }
    }     

    updateStatus("")
}


isRodEquipped() {
    pixel := UI_ROD_PIXEL
    activateRoblox()
    return PixelSearch(&X, &Y, pixel.x, pixel.y, pixel.x, pixel.y, pixel.colour, 2)     
}