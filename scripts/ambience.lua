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

stars = {}

for i=1, 50 do
    star = Quad()
    star.Color = Color(255, 255, 255)
    star.Scale = math.random(10, 30)/10
    star.speed = math.random(10, 30)/10
    star.Position = Number3(math.random(0, 50), 50 + math.random(0, 50), 0)

    star:SetParent(World)
    table.insert(stars, star)

    star.Tick = function(self)
        self.Position.Y = self.Position.Y - self.speed
        if self.Position.Y < -20 then
            self.Position.Y = 50 + math.random(0, 50)
            self.Position.X = math.random(0, 50)
        end
    end
end