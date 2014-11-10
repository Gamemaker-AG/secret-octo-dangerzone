local SpeedComponent = class("SpeedComponent", Component)

function SpeedComponent:__init(speed, maxSpeed, rotSpeed, acceleration)

    self.speed = speed or Vector()
    self.maxSpeed = maxSpeed
    self.rotSpeed = rotSpeed

    self.acceleration = acceleration
    self.active = false
end

return SpeedComponent
