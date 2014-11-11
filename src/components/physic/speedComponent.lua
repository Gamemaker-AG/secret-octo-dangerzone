local Vector = require("helper/vector")

local SpeedComponent = class("SpeedComponent", Component)

function SpeedComponent:__init(speed, maxSpeed, rotSpeed, defaultAcceleration, acceleration)
    self.speed = speed or Vector()
    self.maxSpeed = maxSpeed

    self.rotSpeed = rotSpeed or 0

    self.defaultAcceleration = defaultAcceleration
    self.acceleration = acceleration or Vector(0, 0)
end

return SpeedComponent
