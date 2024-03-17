local bullets = {}

bullets.create = function(dmg, pos)
    local bullet = Object()

    Object:Load("nanskip.red_voxel", function(object)
        bullet.shape = object
        bullet.shape:SetParent(bullet)
    end)

    bullet.destroy = function(self)
        self.Tick = nil
        self.shape = nil
        self:SetParent(nil)
        self = nil
    end

    bullet.damage = dmg
    bullet.Position = pos

    bullet.Tick = function(self)

        self.Position.Y = self.Position.Y + 3
        print(self.shape.Position)

        if self.Position.Y >= 150 then
            self:destroy()
        end

    end
    
    bullet:SetParent(World)
end

return bullets