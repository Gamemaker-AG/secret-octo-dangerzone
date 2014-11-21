local ParticlePositionSyncSystem = class("ParticlePositionSyncSystem", System)

function ParticlePositionSyncSystem:update()
    for k, entity in pairs(self.targets) do
        local particleComponent = entity:get("Particle")
        local transformable = entity:get("Transformable")
        local rotatedOffset = particleComponent.offset:rotate(entity:get("Transformable").direction:getRadian())
        local newPosition = rotatedOffset:add(transformable:absolutePosition())

        particleComponent.particle:setPosition(transformable.position.x, transformable.position.y)
    end
end

function ParticlePositionSyncSystem:requires()
    return {"Particle", "Transformable"}
end

return ParticlePositionSyncSystem
