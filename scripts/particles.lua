local particles = {}

particles.create = function(config)
    local defaultConfig = {
        position = Number3(0, 0, 0),
        rotation = Rotation(0, 0, 0),
        constantMovementAcceleration = Number3(0, 0.1, 0),
        constantRotationAcceleration = Number3(0.1, 0.1, 0.1),
        color = Color(1.0, 1.0, 1.0, 1.0),
        scale = Number3(1, 1, 1),
        timeToDestroy = 1,
        makesmaller = true,
        makeinvisible = true
    }

    local particle = Object()

    particle.Position = config.position or defaultConfig.position
    particle.Rotation = config.rotation or defaultConfig.rotation
    particle.color = config.color or defaultConfig.color
    particle.baseScale = config.scale or defaultConfig.scale
    particle.Scale = config.scale or defaultConfig.scale
    particle.constantMovementAcceleration = config.constantMovementAcceleration or defaultConfig.constantMovementAcceleration
    particle.constantRotationAcceleration = config.constantRotationAcceleration or defaultConfig.constantRotationAcceleration
    particle.timeToDestroy = config.timeToDestroy or defaultConfig.timeToDestroy
    particle.makesmaller = config.makesmaller or defaultConfig.makesmaller
    particle.makeinvisible = config.makeinvisible or defaultConfig.makeinvisible
    particle.timer = 0

    particle.load = function(self)
        Object:Load("nanskip.red_voxel", function(object)
            self.shape = object
            self.shape:SetParent(self)
            self.shape.Palette[1].Color = self.color
        end)
    end

    particle.remove = function(self)
        for i=1, #self.shape.Palette do
            print("Found color #" .. i .. ":")
            print(self.shape.Palette[i].Color)
        end

        self.shape:SetParent(nil)
        self.shape = nil
        self.Tick = nil
        self:SetParent(nil)
        self = nil
    end

    particle.Tick = function(self, dt)
        self.timer = self.timer + 1

        if self.makesmaller == true then
            self.Scale = self.Scale - Number3(0.0166/self.timeToDestroy*self.baseScale.X, 0.0166/self.timeToDestroy*self.baseScale.Y, 0.0166/self.timeToDestroy*self.baseScale.Z)
        end
        if self.makeinvisible == true then
            if self.shape ~= nil then
                self.shape.Palette[1].Color.A = self.shape.Palette[1].Color.A - math.ceil(0.0166/self.timeToDestroy*255)
            end
        end

        self.Position = self.Position + self.constantMovementAcceleration
        self.Rotation = self.Rotation * self.constantRotationAcceleration

        if self.timer >= self.timeToDestroy*60 then
            self:remove()
        end
    end
    
    particle:load()
    particle:SetParent(World)
end

return particles