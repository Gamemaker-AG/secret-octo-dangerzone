local ParticlePositionSyncSystem = class("ParticlePositionSyncSystem", System)

function ParticlePositionSyncSystem:update()
    for k, entity in pairs(self.targets) do
        entity:get("Particle").particle:setPosition(entity:get("Transformable").position.x, entity:get("Transformable").position.y)
        print(entity:get("Transformable").position.x .. "  " .. entity:get("Transformable").position.y)
    end
end

function ParticlePositionSyncSystem:requires()
    return {"Particle", "Transformable"}
end

return ParticlePositionSyncSystem
