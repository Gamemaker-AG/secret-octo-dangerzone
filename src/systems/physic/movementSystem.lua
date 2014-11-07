
local MovementSystem = class("MovementSystem", System)

function MovementSystem:update(dt)
    for index, entity in pairs(self.targets) do
        local pos = entity:get("PositionComponent")
        local speed = entity:get("SpeedComponent")
        pos.x = pos.x + speed.speed * dt
        pos.y = pos.y + speed.speed * dt
    end
end

function MovementSystem:requires()
    return {"SpeedComponent"}
end

return MovementSystem
