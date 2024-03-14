
-- This is start function, better set everything that must be started only once here.

Camera:SetParent(World)
Camera:SetModeFree()
Camera.Position = Number3(25, 55, 0)
Camera.Rotation = Number3(0, 0, 0)
setAmbience()