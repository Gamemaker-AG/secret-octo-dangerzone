local AccelerationComponent = class("AccelerationComponent", Component)

function AccelerationComponent:__init(acc)
    self.acc = acc
end

return AccelerationComponent
