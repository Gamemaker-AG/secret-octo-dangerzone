local ParticlePositionSyncSystem = class("ParticlePositionSyncSystem", System)

function ParticlePositionSyncSystem:update()
    for k, entity in pairs(self.targets) do
        entity:get("Particle").particle:setPosition(entity:get("Transformable").x, entity:get("Transformable").y)
    end
end

function ParticlePositionSyncSystem:requires()
    return {"Particle", "Transformable"}
end

return ParticlePositionSyncSystem
