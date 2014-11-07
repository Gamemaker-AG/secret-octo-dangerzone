
local MovementSystem = class("MovementSystem", System)

function MovementSystem:update(dt)
    for index, entity in pairs(self.targets) do
        local speed = entity:get("SpeedComponent")
        local position = entity:get("PositionComponent")
        position.position:add(speed.speed:multiply(dt))
    end
end

function MovementSystem:requires()
    return {"PlayerComponent"}
end

return MovementSystem
