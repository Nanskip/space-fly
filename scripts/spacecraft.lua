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
        firerateMultiplier = 1,
        upgrade = 1
    }
    if self == nil then
        error([[ERROR: Call function using ':'!]], 2)
        return
    end

    self.firerate = config.firerate or defaultConfig.firerate
    self.damage = config.damage or defaultConfig.damage
    self.damageMultiplier = config.damageMultiplier or defaultConfig.damageMultiplier
    self.firerateMultiplier = config.firerateMultiplier or defaultConfig.firerateMultiplier
    self.upgrade = config.upgrade or defaultConfig.upgrade
    self.shootTimer = 0
    
    Object:Load("nanskip.spacecraft", function(object)
        self.shape = object
        self.shape:SetParent(self)
    end)
    
    self.Position = Number3(25, 70, 45)

    self.rot = Rotation(-math.pi/2, 0, 0)
    self.Tick = function(self)
        self.rot:Slerp(self.rot, Rotation(-math.pi/2, 0, 0), 0.1)
        self.Rotation = self.rot

        self.shootTimer = self.shootTimer + 1

        if self.shootTimer >= 60/self.firerate then
            self.shootTimer = 0
            self:shoot()
        end
    end

    self:SetParent(World)
end

spacecraft.shoot = function(self)
    if self == nil then
        error([[ERROR: Call function using ':'!]], 2)
        return
    end

    local dmg = self.damage * self.damageMultiplier
    if self.upgrade == 1 then
        local pos = self.Position + Number3(0, -7, 1)
        bullets.create(dmg, pos)
    end
    if self.upgrade == 2 then
        local pos = self.Position + Number3(-4, -17, 3)
        bullets.create(dmg, pos)
        local pos = self.Position + Number3(4, -17, 3)
        bullets.create(dmg, pos)
    end
    if self.upgrade == 3 then
        local pos = self.Position + Number3(0, -7, 1)
        bullets.create(dmg, pos)
        local pos = self.Position + Number3(-4, -17, 3)
        bullets.create(dmg, pos)
        local pos = self.Position + Number3(4, -17, 3)
        bullets.create(dmg, pos)
    end
    if self.upgrade == 4 then
        local pos = self.Position + Number3(-8, -18, 3)
        bullets.create(dmg, pos)
        local pos = self.Position + Number3(8, -18, 3)
        bullets.create(dmg, pos)
        local pos = self.Position + Number3(-4, -17, 3)
        bullets.create(dmg, pos)
        local pos = self.Position + Number3(4, -17, 3)
        bullets.create(dmg, pos)
    end
    if self.upgrade == 5 then
        local pos = self.Position + Number3(0, -7, 1)
        bullets.create(dmg, pos)
        local pos = self.Position + Number3(-8, -18, 3)
        bullets.create(dmg, pos)
        local pos = self.Position + Number3(8, -18, 3)
        bullets.create(dmg, pos)
        local pos = self.Position + Number3(-4, -17, 3)
        bullets.create(dmg, pos)
        local pos = self.Position + Number3(4, -17, 3)
        bullets.create(dmg, pos)
    end
    if self.upgrade == 6 then
        local pos = self.Position + Number3(-2, -7, 1)
        bullets.create(dmg, pos)
        local pos = self.Position + Number3(2, -7, 1)
        bullets.create(dmg, pos)
        local pos = self.Position + Number3(-8, -18, 3)
        bullets.create(dmg, pos)
        local pos = self.Position + Number3(8, -18, 3)
        bullets.create(dmg, pos)
        local pos = self.Position + Number3(-4, -17, 3)
        bullets.create(dmg, pos)
        local pos = self.Position + Number3(4, -17, 3)
        bullets.create(dmg, pos)
    end
end

Pointer.Drag = function(pointerEvent)
    dx = pointerEvent.DX
    dy = pointerEvent.DY
    spacecraft.Position.X = math.max(0, math.min(spacecraft.Position.X + dx*0.1, 50))
    spacecraft.Position.Y = math.max(10, math.min(spacecraft.Position.Y + dy*0.1, 100))

    spacecraft.rot:Slerp(spacecraft.rot, Rotation(-math.pi/2, math.min(1, math.max(-1, -dx*0.1)), 0), 0.5)
end
Client.DirectionalPad = nil

return spacecraft