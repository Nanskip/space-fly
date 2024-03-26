local bonus = {}

bonus.create = function(type, pos)
    if type == nil then
        error('bonus.create(): 1st argument must be text.')

        return
    elseif pos == nil then
        error('bonus.create(): 2nd argument must be Number3.')

        return
    end

    if type == "upgrade" then
        Object:Load("nanskip.spacecraft_upgrade", function(object)
            object:SetParent(World)
            object.Position = pos

            object.Tick = function(self)
                self.Position = self.Position + Number3(0, -0.1, 0)
                self.Rotation.Y = self.Rotation.Y + 0.01
            end

            object.remove = function(self)
                self.Tick = nil
                self:SetParent(nil)
                self = nil
            end

            object.OnCollisionBegin = function(self, other)
                local otherparent = other:GetParent()

                if otherparent.isSpacecraft then
                    otherparent.upgrade = otherparent.upgrade + 1
                    self:remove()
                end
            end
        end)
    end
    if type == "damage" then
        Object:Load("nanskip.spacecraft_damage", function(object)
            object:SetParent(World)
            object.Position = pos

            object.Tick = function(self)
                self.Position = self.Position + Number3(0, -0.1, 0)
                self.Rotation.Y = self.Rotation.Y + 0.01
            end

            object.remove = function(self)
                self.Tick = nil
                self:SetParent(nil)
                self = nil
            end

            object.OnCollisionBegin = function(self, other)
                local otherparent = other:GetParent()

                if otherparent.isSpacecraft then
                    otherparent.damage = otherparent.damage + 1
                    self:remove()
                end
            end
        end)
    end
    if type == "firerate" then
        Object:Load("nanskip.spacecraft_firerate", function(object)
            object:SetParent(World)
            object.Position = pos

            object.Tick = function(self)
                self.Position = self.Position + Number3(0, -0.1, 0)
                self.Rotation.Y = self.Rotation.Y + 0.01
            end

            object.remove = function(self)
                self.Tick = nil
                self:SetParent(nil)
                self = nil
            end

            object.OnCollisionBegin = function(self, other)
                local otherparent = other:GetParent()

                if otherparent.isSpacecraft then
                    otherparent.firerate = otherparent.firerate + 1
                    self:remove()
                end
            end
        end)
    end
end

return bonus