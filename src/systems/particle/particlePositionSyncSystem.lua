local ParticlePositionSyncSystem = class("ParticlePositionSyncSystem", System)

function ParticlePositionSyncSystem:update()
    for k, entity in pairs(self.targets) do
        local particleComponent = entity:get("Particle")
        local transformable = entity:get("Transformable")
        local rotatedOffset = particleComponent.offset:rotate(entity:get("Transformable").direction:getRadian())
        local newPosition = rotatedOffset:add(transformable:absolutePosition())
        local a = 20
        local w = transformable.direction:getRadian()
        local offsx = math.cos(w)*-30
        local offsy = math.sin(w)*-30
        print(offsx)  

        particleComponent.particle:setPosition(offsx+transformable.position.x, offsy+transformable.position.y)
    end
end

function ParticlePositionSyncSystem:requires()
    return {"Particle", "Transformable"}
end

return ParticlePositionSyncSystem
