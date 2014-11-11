local Vector = require("helper/vector")

local SpeedComponent = class("SpeedComponent", Component)

function SpeedComponent:__init(speed, maxSpeed, defaultRotSpeed, defaultAcceleration, acceleration)
    self.speed = speed or Vector()
    self.maxSpeed = maxSpeed

    self.defRotSpeed = defaultRotSpeed
    self.rotSpeed = 0

    self.defaultAcceleration = defaultAcceleration
    self.acceleration = acceleration or Vector(0, 0)
end

return SpeedComponent
