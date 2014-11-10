local ParticlePositionSyncSystem = class("ParticlePositionSyncSystem", System)

function ParticlePositionSyncSystem:update()
    for k, entity in pairs(self.targets) do
        entity:get("ParticleComponent").particle:setPosition(entity:get("TransformComponent").x, entity:get("TransformComponent").y)
    end
end

function ParticlePositionSyncSystem:requires()
    return {"ParticleComponent", "TransformComponent"}
end

return ParticlePositionSyncSystem
