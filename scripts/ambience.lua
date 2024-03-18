require("ambience"):set({
	sky = {
		skyColor = Color(0,0,0),
		horizonColor = Color(0,0,0),
		abyssColor = Color(0,0,0),
		lightColor = Color(152,152,161),
		lightIntensity = 1.000000,
	},
	fog = {
		color = Color(0,0,0),
		near = 1100,
		far = 0,
		lightAbsorbtion = 0.400000,
	},
	sun = {
		color = Color(255,255,255),
		intensity = 0.010000,
		rotation = Number3(1.061162, 3.089219, 0.000000),
	},
	ambient = {
		skyLightFactor = 0.350000,
		dirLightFactor = 0.200000,
	}
})

if stars == nil then
	stars = {}
end

for i=1, #stars do
	stars[i].Tick = nil
	stars[i]:SetParent(nil)
	stars[i] = nil
end

for i=1, 200 do
    local star = Quad()
	star.colors = {
		Color(255, 255, 255), Color(247, 250, 60), Color(144, 252, 245), Color(255, 228, 194), Color(255, 255, 255), Color(255, 255, 255), Color(255, 255, 255)
	}
    star.Color = star.colors[math.random(1, #star.colors)]
	star.Scale = math.random(5, 15)/30
	star.speed = math.random(5, 8)/200
    star.Position = Number3(math.random(-30, 80), math.random(0, 160), 50)

    star:SetParent(World)
    table.insert(stars, star)

    star.Tick = function(self)
        self.Position.Y = self.Position.Y - self.speed
        if self.Position.Y < -20 then
            self.Position.Y = 110 + math.random(0, 50)
            self.Position.X = math.random(-30, 80)

            self.Color = self.colors[math.random(1, #self.colors)]
            self.Scale = math.random(5, 15)/30
            self.speed = math.random(5, 8)/200
        end
    end
end

for i=1, 50 do
	local partScale = math.random(100, 1000)/10
	local partColors = {Color(150, 0, 150, 2), Color(0, 0, 0, 5), Color(0, 0, 150, 5)}
	local particle = particles.create({
        position = Number3(math.random(-30, 80)- partScale/2, math.random(0, 150), 200),
        rotation = Rotation(math.random(-10, 10)/10, math.random(-10, 10)/10, math.random(-10, 10)/10),
        constantMovementAcceleration = Number3(0, -math.random(1, 10)/20, 0),
        constantRotationAcceleration = Number3(math.random(-10, 10)/50, math.random(-10, 10)/50, math.random(-10, 10)/50),
        color = partColors[math.random(1, 3)],
        scale = Number3(partScale, partScale, partScale),
        timeToDestroy = math.huge,
        makesmaller = false,
        makeinvisible = false,
        isUnlit = true,
		isQuad = true,
		tick = function(self)
			if self.Position.Y < -100 then
				self.Position = Number3(math.random(-30, 80)- partScale/2, 200+math.random(0, 100), 200)
			end
		end
    })
end