Modules = {
    stars = "https://github.com/Nanskipp/space-fly"
}

Client.OnStart = function()
    debug = true
    stars.create()
end