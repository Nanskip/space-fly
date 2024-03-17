local bullets = {}

bullets.create = function(dmg, pos)
    local bullet = Object()

    Object:Load("nanskip.spacecraft", function(object)
        bullet.shape = object
        bullet.shape:SetParent(self)
    end)

    bullet.destroy = function(self)
        self.Tick = nil
        self.shape = nil
        self:SetParent(nil)
        self = nil
    end

    bullet.Tick = function(self)

        self.Position.Y = self.Position.Y + 3

        if self.Position.Y >= 150 then
            self:destroy()
        end

    end
    
    bullet:SetParent(World)
end

return bullets