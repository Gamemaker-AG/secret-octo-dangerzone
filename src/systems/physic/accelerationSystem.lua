
local AccelerationSystem = class("AccelerationSystem", System)
local Vector = require("helper/vector")

function AccelerationSystem:update(dt)
    for index, entity in pairs(self.targets) do
        local speedComponent = entity:get("SpeedComponent")
        local speed = speedComponent.speed
        if not speedComponent.acceleration:eq(Vector(0, 0)) then
            speed:set(speed:add(speedComponent.acceleration:multiply(dt)))
            if speed:sum() > speedComponent.maxSpeed then
                speed:set(speed:getUnit():multiply(speedComponent.maxSpeed))
            end
        else
            speed:set(speed:subtract(speed:multiply(1/3 * dt)))
            if math.abs(speed.x) < 1 then speed.x = 0 end
            if math.abs(speed.y) < 1 then speed.y = 0 end
        end
    end
end

function AccelerationSystem:requires()
    return {"SpeedComponent", "TransformComponent"}
end

return AccelerationSystem
