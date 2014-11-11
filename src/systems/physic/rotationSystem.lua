
local RotationSystem = class("RotationSystem", System)
local Vector = require("helper/vector")

function RotationSystem:update(dt)
    for index, entity in pairs(self.targets) do
        local direction = entity:get("TransformComponent").direction
        local speedComponent = entity:get("SpeedComponent")
        if speedComponent.rotSpeed ~= 0 then
            direction:set(direction:rotate(speedComponent.rotSpeed*dt):getUnit())
        end
    end
end

function RotationSystem:requires()
    return {"SpeedComponent", "TransformComponent"}
end

return RotationSystem
