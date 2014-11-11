local SpeedComponent = class("SpeedComponent", Component)

function SpeedComponent:__init(speed, maxSpeed, rotSpeed, acceleration)
    self.speed = speed or Vector()
    self.maxSpeed = maxSpeed

    self.rotSpeed = rotSpeed or 0

    self.acceleration = acceleration or Vector(0, 0)
end

return SpeedComponent
