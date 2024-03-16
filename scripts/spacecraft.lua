local spacecraft = Object()

spacecraft.firerate = 1
spacecraft.damage = 1
spacecraft.damageMultiplier = 1
spacecraft.firerateMultiplier = 1

spacecraft.create = function(self, config)
    local defaultConfig = {
        firerate = 1,
        damage = 1,
        damageMultiplier = 1,
        firerateMultiplier = 1
    }

    self.firerate = config.firerate or defaultConfig.firerate
    self.damage = config.damage or defaultConfig.damage
    self.damageMultiplier = config.damageMultiplier or defaultConfig.damageMultiplier
    self.firerateMultiplier = config.firerateMultiplier or defaultConfig.firerateMultiplier
    
    Object:Load("nanskip.spacecraft", function(object)
        self.shape = object
        self.shape:SetParent(self)
    end)
    
    self.Position = Number3(25, 70, 45)

    self.rot = Rotation(-math.pi/2, 0, 0)
    self.Tick = function(self)
        self.rot:Slerp(self.rot, Rotation(-math.pi/2, 0, 0), 0.1)
        self.Rotation = self.rot
        print(self.rotY)
    end

    self:SetParent(World)
end

Client.AnalogPad = function(dx, dy)
    spacecraft.Position.X = math.max(0, math.min(spacecraft.Position.X + dx*0.1, 50))
    spacecraft.Position.Y = math.max(10, math.min(spacecraft.Position.Y + dy*0.1, 100))

    spacecraft.rot:Slerp(spacecraft.rot, Rotation(-math.pi/2, math.min(1, math.max(-1, -dx*0.1)), 0), 0.5)
end
Client.DirectionalPad = nil

return spacecraft