local AccelerationComponent = class("AccelerationComponent", Component)

function AccelerationComponent:__init(acc)
    self.acc = acc
    self.active = false
end

return AccelerationComponent
