-- Hyper Key defined with Karabiner (Caps)
local hyper = {"cmd", "alt", "shift", "ctrl"}
local hyperFn = {"cmd", "alt", "shift", "ctrl", "fn"}
local smallHyper = {"cmd", "alt", "shift"}

-- Light ID Constants
local tableLightsID = "eb2adf5bf464095041agjf"
local lampTopID = "eb44972f916fe8985b1svr"
local lampBottomID = "eb66f16039cecd428cuhoy"

-------------------
-- Config Reload --
-------------------

hs.hotkey.bind(hyper, "r", function() hs.reload() end)
hs.alert.show("Config loaded")

-------------------
-- Spotify Stuff --
-------------------
function showCurrentSong() hs.itunes.displayCurrentTrack() end
hs.hotkey.bind(hyper, "\\", showCurrentSong)

hs.hotkey.bind(hyper, "down", function()
    if hs.itunes.isPlaying then
        hs.itunes.volumeDown()
    end
end)

hs.hotkey.bind(hyper, "up", function()
    if hs.itunes.isPlaying then
        hs.itunes.volumeUp()
    end
end)

-------------------
-- Window Moving --
-------------------
function moveWindowToDisplay(d)
    return function()
        local displays = hs.screen.allScreens()
        local win = hs.window.focusedWindow()
        win:moveToScreen(displays[d], false, true, 0)
    end
end

hs.hotkey.bind(hyper, "1", moveWindowToDisplay(1))
hs.hotkey.bind(hyper, "2", moveWindowToDisplay(2))
hs.hotkey.bind(hyper, "3", moveWindowToDisplay(3))

-- Moving mouse
function moveMouseToDisplay(d)
    return function()
        local displays = hs.screen.allScreens()
        local screen = displays[d]
        local frame = screen:frame()
        hs.mouse.setAbsolutePosition({x = frame.x + frame.w / 2, y = frame.y + frame.h / 2})
    end
end

hs.hotkey.bind(hyperFn, "f16", moveMouseToDisplay(1))
hs.hotkey.bind(hyperFn, "f17", moveMouseToDisplay(2))
hs.hotkey.bind(hyperFn, "f18", moveMouseToDisplay(3))

-----------------
-- App Opening --
-----------------
function openApp(name)
    local app = hs.application.get(name)
    if app then
        if app:isFrontmost() then
            app:hide()
        else
            app:mainWindow():focus()
        end
    else
        hs.application.launchOrFocus(name)
    end
end

function vscode() openApp("Visual Studio Code") end
function teams() openApp("Microsoft Teams") end
function iterm() openApp("iTerm2") end
function brave() openApp("Brave Browser") end
function music() openApp("Music") end
function calendar() openApp("Calendar") end
function outlook() openApp("Microsoft Outlook") end
function safari() openApp("Safari") end


local isSafari = false

function toggleTabApp()
    if isSafari then
        iterm()
    else
        safari()
    end
    isSafari = not isSafari
end

-- hs.hotkey.bind(hyperFn, "f2", toggleTabApp)
hs.hotkey.bind(hyperFn, "f2", iterm)

-- * Commented because seems like waste of shortcuts *
-- hs.hotkey.bind(hyper, "v", vscode)
-- hs.hotkey.bind(hyper, "b", brave)
-- hs.hotkey.bind(hyper, "t", teams)
-- hs.hotkey.bind(hyper, "t", iterm)
-- hs.hotkey.bind(hyper, "a", music)
-- hs.hotkey.bind(hyper, "c", calendar)
-- hs.hotkey.bind(hyper, "o", outlook)
-- * Mapped to F1 through F4 on Karabiner
-- hs.hotkey.bind({}, "pad1", iterm)
-- hs.hotkey.bind({}, "pad2", vscode)
-- hs.hotkey.bind({}, "pad3", teams)
-- hs.hotkey.bind({}, "pad4", brave)

-----------------
-- Light Stuff --
-----------------

function toggleLight(id)
    hs.http.asyncPost("http://blackberrypi.local:1234/control/toggle/" .. id,
                      nil, nil, function() end)
end

function toggleTableLight() toggleLight(tableLightsID) end

function toggleLampBottom() toggleLight(lampBottomID) end

function toggleLampTop() toggleLight(lampTopID) end

function toggleLights()
    toggleTableLight()
    toggleLampBottom()
    toggleLampTop()
end

-- hs.hotkey.bind({}, "pad4", toggleLights)
-- hs.hotkey.bind(hyper, "pad1", toggleTableLight)
-- hs.hotkey.bind(hyper, "pad2", toggleLampBottom)
-- hs.hotkey.bind(hyper, "pad3", toggleLampTop)

---------------
-- Mic Stuff --
---------------
-- micMuteStatusMenu = hs.menubar.new()

-- function displayMicMuteStatus()
--     local currentAudioInput = hs.audiodevice.current(true)
--     local currentAudioInputObject = hs.audiodevice.findInputByUID(
--                                         currentAudioInput.uid)
--     muted = currentAudioInputObject:inputMuted()
--     if muted then
--         micMuteStatusMenu:setIcon(hs.image.imageFromPath(
--                                       os.getenv("HOME") ..
--                                           "/.hammerspoon/muted.png"):setSize({
--             h = 18,
--             w = 18
--         }, true))
--     else
--         micMuteStatusMenu:setIcon(hs.image.imageFromPath(
--                                       os.getenv("HOME") ..
--                                           "/.hammerspoon/unmuted.png"):setSize(
--                                       {h = 18, w = 18}, false))
--     end
-- end

-- for i, dev in ipairs(hs.audiodevice.allInputDevices()) do
--     dev:watcherCallback(displayMicMuteStatus):watcherStart()
-- end

-- function toggleMicMuteStatus()
--     local currentAudioInput = hs.audiodevice.current(true)
--     local currentAudioInputObject = hs.audiodevice.findInputByUID(
--                                         currentAudioInput.uid)
--     currentAudioInputObject:setInputMuted(not muted)
--     if muted then
--         hs.alert.show("Unmuted", 0.3)
--     else
--         hs.alert.show("Muted", 0.3)
--     end
--     displayMicMuteStatus()
-- end

-- function toggleMuteApp()
--     local zoom = hs.application.find("us.zoom.xos")
--     local teams = hs.application.find("com.microsoft.teams")
--     if not (zoom == nil) then
--         hs.eventtap.keyStroke({"cmd", "shift"}, "a", 0, zoom)
--     end
--     if not (teams == null) then
--         hs.eventtap.keyStroke({"cmd", "shift"}, "m", 0, teams)
--     end
-- end

-- displayMicMuteStatus()
-- hs.hotkey.bind(hyper, "m", toggleMuteApp)
-- hs.hotkey.bind(smallHyper, "pageup", toggleMicMuteStatus)

-- function toggleMicMuteStatusAlert()
--     if micMuteStatusAlert then
--         micMuteStatusAlert = false
--     else
--         micMuteStatusAlert = true
--         displayMicMuteStatus()
--     end
-- end

-- micMuteStatusMenu:setClickCallback(toggleMicMuteStatus)

-- hs.hotkey.bind(hyper, "0", toggleMute)
