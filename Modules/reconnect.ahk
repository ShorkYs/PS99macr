#Requires AutoHotkey v2.0

reconnectClient(*) {

    deeplink :=   "roblox://placeId=8737899170"

    try 
        Run deeplink
    catch
        return
    
    updateStatus("Reconnecting client")

    activateRoblox()

    updateStatus("")
}