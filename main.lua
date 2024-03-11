Modules = {
    stars = "github.com/Nanskipp/space-fly/stars"
}

Client.OnStart = function()
    debug = true
    stars.create()
end