local ParticlePositionSyncSystem = class("ParticlePositionSyncSystem", System)

function ParticlePositionSyncSystem:update()
    for k, entity in pairs(self.targets) do
        local particle = entity:get("Particle")
        local transformable = entity:get("Transformable")
        local radian = transformable.direction:getRadian()

        local rotatedOffset = particle.offset:rotate(transformable.direction:getRadian()):add(entity:get("Transformable").position)
        particle.particle:setPosition(rotatedOffset.x, rotatedOffset.y)

        --local offsx = math.cos(radian)*-50
        --local offsy = math.sin(radian)*-50 
        --particle.particle:setPosition(offsx+transformable.position.x, offsy+transformable.position.y)

        particle.particle:setDirection(math.pi+radian)
    end
end

function ParticlePositionSyncSystem:requires()
    return {"Particle", "Transformable"}
end

return ParticlePositionSyncSystem
