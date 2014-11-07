local SpeedComponent = class("SpeedComponent", Component)

function SpeedComponent:__init(speed, maxSpeed)
    self.speed = speed
    self.maxSpeed = maxSpeed
end

return SpeedComponent
