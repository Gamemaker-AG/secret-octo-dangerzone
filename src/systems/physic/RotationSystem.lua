
local RotationSystem = class("RotationSystem", System)
local Vector = require("helper/Vector")

function RotationSystem:update(dt)
    for index, entity in pairs(self.targets) do
        local direction = entity:get("Transformable").direction
        local rotationSpeed = entity:get("Rotating").rotationSpeed
        if rotationSpeed ~= 0 then
            direction:set(direction:rotate(rotationSpeed*dt):getUnit())
        end
    end
end

function RotationSystem:requires()
    return {"Rotating"}
end

return RotationSystem
