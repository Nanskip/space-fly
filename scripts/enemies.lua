local enemies = {}

enemies.create = function(config)
    local defaultConfig = {
        shape = "nanskip.sphere" .. math.random(1, 3),
        position = Number3(25, 150, 45),
        rotation = Rotation(0, 0, 0),
        constantMovementAcceleration = Number3(0, -0.1, 0),
        constantRotationAcceleration = Number3(0.1, 0.1, 0.1),
        color = Color(1.0, 1.0, 1.0, 1.0),
        scale = Number3(1, 1, 1),
        health = 10
    }
    
    local enemy = Object()

    enemy.Position = config.position or defaultConfig.position
    enemy.Rotation = config.rotation or defaultConfig.rotation
    enemy.constantMovementAcceleration = config.constantMovementAcceleration or defaultConfig.constantMovementAcceleration
    enemy.constantRotationAcceleration = config.constantRotationAcceleration or defaultConfig.constantRotationAcceleration
    enemy.color = config.color or defaultConfig.color
    enemy.Scale = config.scale or defaultConfig.scale
    enemy.health = config.health or defaultConfig.health
    enemy.isEnemy = true

    enemy.load = function(self)
        Object:Load(config.shape or defaultConfig.shape, function(object)
            self.shape = object
            self.shape:SetParent(self)
            self.shape.Palette[1].Color = self.color
            self.shape.Physics = PhysicsMode.Trigger
            self.shape.CollisionGroups = {1, 2, 3}
        end)
    end
    enemy:load()
    enemy:SetParent(World)

    enemy.remove = function(self)
        if self.shape ~= nil then
            self.shape:SetParent(nil)
            self.shape = nil
        end
        self.Tick = nil
        self:SetParent(nil)
        self = nil
    end

    enemy.Tick = function(self)
        self.Position = self.Position + self.constantMovementAcceleration
        self.Rotation = self.Rotation * self.constantRotationAcceleration

        if self.Position.X < 0 then self.Position.X = 0 elseif self.Position.X > 50 then self.Position.X = 0 end
        if self.Position.Y < -30 then self:remove() end
        if self.health <= 0 then self:remove() end
    end
end

return enemies