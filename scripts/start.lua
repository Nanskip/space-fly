
-- This is start function, better set everything that must be started only once here.

Camera:SetParent(World)
Camera:SetModeFree()
Camera.Position = Number3(25, 55, -100)
Camera.Rotation = Number3(0, 0, 0)
globalTimer = 0
setAmbience()
enemyCount = 0
roundCount = 1
randScaleMultiplier = 1
randHealthMultiplier = 0
enemiesTable = {}

ui = require("uikit")
hud.init()
hud.update()

Screen.DidResize = function()
    Camera.FOV = math.max(math.min(40*((Screen.Width/Screen.Height+0.45)/0.9), 100), 60)*0.4
    hud.update()
end
Screen.DidResize() -- just to fit camera to screen on start

restart = function()
    hud.restartButton = ui:createButton("Start game")
    gameOn = false

    hud.restartButton.pos.X = Screen.Width/2 - hud.restartButton.Width/2
    hud.restartButton.pos.Y = Screen.Height/2 - hud.restartButton.Height/2 - Screen.SafeArea.Top + Screen.SafeArea.Bottom
    hud.restartButton.onPress = function()
        hud.restartButton:setParent(nil)
        hud.restartButton = nil

        gameOn = true

        roundCount = 1
        randScaleMultiplier = 1
        randHealthMultiplier = 0
        spacecraft.firerate = 1
        spacecraft.damage = 1
        spacecraft.damageMultiplier = 1
        spacecraft.firerateMultiplier = 1
        spacecraft.isSpacecraft = true
        spacecraft.dmgTimer = 0
        spacecraft.dmgTimer2 = 0
        spacecraft.gotDamage = false
        spacecraft.health = 3
        spacecraft:create()

        for i=1, #enemiesTable do
            enemiesTable[i]:remove()
            enemiesTable[i] = nil

            table.sort(enemiesTable)
        end
    end
end