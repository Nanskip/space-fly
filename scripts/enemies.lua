local enemies = {}

enemies.create = function(config)
    local defaultConfig = {
        shape = "nanskip.sphere" .. math.random(1, 3),
        position = Number3(25, 100, 45),
        rotation = Rotation(0, 0, 0),
        constantMovementAcceleration = Number3(0, -0.1, 0),
        constantRotationAcceleration = Rotation(0.01, 0.01, 0.01),
        color = Color(0.5, 0.5, 0.5, 1.0),
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
    table.insert(enemiesTable, enemy)

    enemy.load = function(self)
        Object:Load(config.shape or defaultConfig.shape, function(object)
            self.shape = object
            self.shape:SetParent(self)
            self.shape.Palette[1].Color = self.color
            self.shape.Physics = PhysicsMode.Trigger
            self.shape.CollisionGroups = {1, 2, 3}

            self.shape.OnCollisionBegin = function(self, other)
                local selfparent = self:GetParent()
                local otherparent = other:GetParent()

                if otherparent.isSpacecraft then
                    if not otherparent.gotDamage then
                        otherparent:doDamage()

                        selfparent:remove()
                    end
                end
            end
        end)
    end
    enemy:load()
    enemy:SetParent(World)

    enemy.text = Text()
    enemy.text.Text = "{}"
    enemy.text.BackgroundColor = Color(0, 0, 0, 0)
    enemy.text.Color = Color(255, 255, 255)
    enemy.text:SetParent(enemy)

    enemy.remove = function(self)
        if self.shape ~= nil then
            self.shape:SetParent(nil)
            self.shape = nil
        end

        for i=1, 15 do
            particles.create({
                position = self.Position,
                rotation = Rotation(0, 0, 0),
                constantMovementAcceleration = Number3(math.random(-50, 50)/100, math.random(-50, 50)/100, 0),
                constantRotationAcceleration = Rotation(math.random(-10, 10)/300, math.random(-10, 10)/300, math.random(-10, 10)/300),
                color = Color(232-math.random(0, 20), 153+math.random(0, 20), 49+math.random(0, 10), 255),
                scale = Number3(3, 3, 3),
                timeToDestroy = 1
            })
        end

        local rand = math.random(1, 50)

        if rand == 1 or rand == 2 then
            bonus.create("damage", self.Position)
        elseif rand == 3 or rand == 4 then
            bonus.create("firerate", self.Position)
        elseif rand == 5 then
            bonus.create("upgrade", self.Position)
        end

        if self.text ~= nil then
            self.text:SetParent(nil)
            self.text = nil
        end
        self.Tick = nil
        self:SetParent(nil)
        self = nil

        globalTimer = globalTimer + 60*5
    end

    enemy.Tick = function(self)
        self.Position = self.Position + self.constantMovementAcceleration
        self.Rotation = self.Rotation * self.constantRotationAcceleration

        if self.Position.X < 0 then self.Position.X = 0 elseif self.Position.X > 50 then self.Position.X = 50 end
        if self.Position.Y < -30 then self:remove() end
        if self.health <= 0 then self:remove() end

        if self.text ~= nil then
            self.text.Position = self.Position + Number3(0, 0, -4*self.Scale.Z)
            self.text.Rotation = Rotation(0, 0, 0)
            self.text.Text = self.health
        end
    end

end

enemies.spawn = function(count)
    for i=1, count do
        enemies.create({
            position = Number3(math.random(5, 45), 110 + math.random(0, 20), 45),
            rotation = Rotation(0, 0, 0),
            constantMovementAcceleration = Number3(0, math.random(5, 15)*-0.003, 0),
            constantRotationAcceleration = Rotation(math.random(0, 20)*0.001, math.random(0, 20)*0.001, math.random(0, 20)*0.001),
            color = Color(math.random(0, 100)*0.01, math.random(0, 100)*0.01, math.random(0, 100)*0.01, 1.0),
            scale = Number3(1*randScaleMultiplier, 1*randScaleMultiplier, 1*randScaleMultiplier),
            health = 10+randHealthMultiplier
        })
    end
end

return enemies