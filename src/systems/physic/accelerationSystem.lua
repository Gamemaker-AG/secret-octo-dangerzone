
local AccelerationSystem = class("AccelerationSystem", System)

function AccelerationSystem:update(dt)
    for index, entity in pairs(self.targets) do
        local speed = entity:get("SpeedComponent")
        local position = entity:get("TransformComponent")
        if speed.active == true then
            speed.speed:add(position.direction:multiply(speed.acc*dt))
            if speed.speed:sum() > speed.maxSpeed then
                speed.speed:makeUnit():multiply(speed.maxSpeed)
            end
        else
            speed.speed = speed.speed:subtract( speed.speed:multiply(-1/3 * dt))
            if math.abs(speed.speed.x) < 1 then speed.speed.x = 0 end
            if math.abs(speed.speed.y) < 1 then speed.speed.y = 0 end
        end
    end
end

function AccelerationSystem:requires()
    return {"AccelerationComponent", "TransformComponent"}
end

return AccelerationSystem
