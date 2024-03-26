local hud = {}

hud.init = function()
    hud.health = ui:createText("health", Color(255, 255, 255), "big")
end

hud.update = function()
    if Screen.Width > Screen.Height then
        screenMinimizer = Screen.Width/2 - Screen.Width/6
    else
        screenMinimizer = 0
    end

    hud.health.pos.X = 8 + screenMinimizer
    hud.health.pos.Y = Screen.Height - Screen.SafeArea.Top - hud.health.Height - 8
    hud.health.Scale.X = 1.25
    hud.health.Scale.Y = 1.25
    local gotHealth = ""
    for i=1, spacecraft.health do
        gotHealth = gotHealth .. "❤️"
    end
    hud.health.Text = gotHealth

    if hud.restartButton ~= nil then
        hud.restartButton.pos.X = Screen.Width/2 - hud.restartButton.Width/2
        hud.restartButton.pos.X = Screen.Height/2 - hud.restartButton.Height/2 - Screen.SafeArea.Top + Screen.SafeArea.Bottom
    end
end

return hud

-- ❤️