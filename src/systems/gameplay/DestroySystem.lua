local DestroySystem = class("DestroySystem", System)

function DestroySystem:update()
    for _, entity in pairs(self.targets) do
        if entity:has("Particle") then
            local particle = Entity()
            particle:add(entity:get("Transformable"))
            particle:add(entity:get("Particle"))
            particle:get("Particle").emitterlife = 0
        end
        stack:current().engine:removeEntity(entity)
    end
end


function DestroySystem:requires()
    return {"Destroyed"}
end


return DestroySystem
