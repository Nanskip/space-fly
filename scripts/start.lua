
-- This is start function, better set everything that must be started only once here.

Camera:SetParent(World)
Camera:SetModeFree()
Camera.Position = Number3(25, 55, -100)
Camera.Rotation = Number3(0, 0, 0)
setAmbience()

Screen.DidResize = function()
    Camera.FOV = math.max(math.min(40*((Screen.Width/Screen.Height+0.45)/0.9), 100), 60)*0.4
end

Screen.DidResize() -- just to fit camera to screen on start
spacecraft:create()
ui = require("uikit")
hud.init()