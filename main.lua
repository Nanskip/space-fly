Config.Map = "nanskip.red_voxel"

Client.OnStart = function()
    githubScriptsCount = 0
    loadGitHub()
end

Client.Tick = function(dt)
    deltaTime = 62/(1/dt)
    if githubScriptsCount == 2 then
        githubScriptsCount = nil

        start()
    elseif githubScriptsCount == nil then
        tick()
    end
end

-- load everything
loadGitHub = function()
    loadFromGitHub("https://raw.githubusercontent.com/Nanskipp/space-fly/main/scripts/start.lua",
    function(obj)
        start = obj -- set this as start function
        start()
    end)
    loadFromGitHub("https://raw.githubusercontent.com/Nanskipp/space-fly/main/scripts/tick.lua",
    function(obj)
        tick = obj -- set this as tick function
    end)
end

-- loading function
loadFromGitHub = function(url, callback)
    HTTP:Get(url, function(res)
        if res.StatusCode ~= 200 then
            print("Error on github loading. Code: " .. res.StatusCode)
            return
        end
        local obj = load(res.Body:ToString(), nil, "bt", _ENV)

        githubScriptsCount = githubScriptsCount + 1
        callback(obj)
        end)
end