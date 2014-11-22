
local MovementSystem = class("MovementSystem", System)

function MovementSystem:update(dt)
    for index, entity in pairs(self.targets) do
        local speed = entity:get("Moving").speed
        local offset = entity:get("Transformable").offset
        offset:set(offset:add(speed:multiply(dt)))
    end
end

function MovementSystem:requires()
    return {"Moving"}
end

return MovementSystem
