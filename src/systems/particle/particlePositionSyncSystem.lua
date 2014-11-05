ParticlePositionSyncSystem = class("ParticlePositionSyncSystem", System)

function ParticlePositionSyncSystem:update()
    for k, entity in pairs(self.targets) do
        entity:get("ParticleComponent").particle:setPosition(entity:get("PositionComponent").x, entity:get("PositionComponent").y)
    end
end

function ParticlePositionSyncSystem:requires()
    return {"ParticleComponent", "PositionComponent"}
end