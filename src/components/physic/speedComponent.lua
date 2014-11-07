local SpeedComponent = class("SpeedComponent", Component)

function SpeedComponent:__init(speed, maxSpeed, rotSpeed, acc)

    self.speed = speed or Vector()
    self.maxSpeed = maxSpeed
    self.rotSpeed = rotSpeed

    self.acc = acc
    self.active = false
end

return SpeedComponent
