local AddingGold = require("events/AddingGold")

local DestroySystem = class("DestroySystem", System)

function DestroySystem:update(dt)
    for _, entity in pairs(self.targets) do
        if entity:has("Particle") then
            local particle = Entity()
            particle:add(entity:get("Transformable"))
            particle:add(entity:get("Particle"))
            particle:get("Particle").emitterlife = 0
        end
        if entity:has("DropsGold") then
            stack:current().eventmanager:fireEvent(AddingGold(entity))
        end
        stack:current().engine:removeEntity(entity)
    end
end


function DestroySystem:requires()
    return {"Destroyed"}
end


return DestroySystem
