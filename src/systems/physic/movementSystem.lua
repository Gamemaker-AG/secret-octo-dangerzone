
local MovementSystem = class("MovementSystem", System)

function MovementSystem:update(dt)
    for index, entity in pairs(self.targets) do
        local speed = entity:get("SpeedComponent").speed
        local position = entity:get("TransformComponent").position
        position:add(speed:multiply(dt))
    end
end

function MovementSystem:requires()
    return {"PlayerComponent"}
end

return MovementSystem
