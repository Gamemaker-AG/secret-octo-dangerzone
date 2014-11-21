
local AccelerationSystem = class("AccelerationSystem", System)
local Vector = require("helper/Vector")

function AccelerationSystem:update(dt)
    for index, entity in pairs(self.targets) do
        local speed = entity:get("Moving").speed
        local maxSpeed = entity:get("Moving").maxSpeed
        local acceleration = entity:get("Accelerating").acceleration
        if not acceleration:eq(Vector(0, 0)) then
            speed:set(speed:add(acceleration:multiply(dt)))
            if speed:length() > maxSpeed then
                speed:set(speed:getUnit():multiply(maxSpeed))
            end
        else
            speed:set(speed:subtract(speed:multiply(1/3 * dt)))
            if math.abs(speed.x) < 1 then speed.x = 0 end
            if math.abs(speed.y) < 1 then speed.y = 0 end
        end
    end
end

function AccelerationSystem:requires()
    return {"Accelerating"}
end

return AccelerationSystem
