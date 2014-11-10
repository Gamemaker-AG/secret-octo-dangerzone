
local AccelerationSystem = class("AccelerationSystem", System)

function AccelerationSystem:update(dt)
    for index, entity in pairs(self.targets) do
        local speedcomp = entity:get("SpeedComponent")
        local speed = entity:get("SpeedComponent")
        local position = entity:get("TransformComponent")
        if speedcomp.active == true then
            speed:set(speed:add(position.direction:multiply(speed.acc*dt)))
            if speed:sum() > maxSpeed then
                speed:set(speed:getUnit():multiply(speed.maxSpeed))
            end
        else
            speed:set(speed:subtract(speed:multiply(-1/3 * dt)))
            if math.abs(speed.x) < 1 then speed.x = 0 end
            if math.abs(speed.y) < 1 then speed.y = 0 end
        end
    end
end

function AccelerationSystem:requires()
    return {"AccelerationComponent", "TransformComponent"}
end

return AccelerationSystem
