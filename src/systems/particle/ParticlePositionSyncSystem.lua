local ParticlePositionSyncSystem = class("ParticlePositionSyncSystem", System)

function ParticlePositionSyncSystem:update()
    for k, entity in pairs(self.targets) do
        local particleComponent = entity:get("Particle")
        local transformable = entity:get("Transformable")
        local rotatedOffset = particleComponent.offset:rotate(entity:get("Transformable").direction:getRadian())
        local newPosition = rotatedOffset:add(transformable:absolutePosition())
        local a = 20
        local w = transformable.direction:getRadian()
        local offsx = math.cos(w)*-50
        local offsy = math.sin(w)*-50 
        particleComponent.particle:setPosition(offsx+transformable.position.x, offsy+transformable.position.y)
        particleComponent.particle:setDirection(math.pi+w)
    end
end

function ParticlePositionSyncSystem:requires()
    return {"Particle", "Transformable"}
end

return ParticlePositionSyncSystem
