local ParticlePositionSyncSystem = class("ParticlePositionSyncSystem", System)

function ParticlePositionSyncSystem:update()
    for k, entity in pairs(self.targets) do
        self:syncPosition(entity)
    end
end

function ParticlePositionSyncSystem:updatePosition(event)
    self:syncPosition(event.entity)
end

function ParticlePositionSyncSystem:syncPosition(entity)
    local particle = entity:get("Particle")
    local transformable = entity:get("Transformable")
    local radian = transformable.direction:getRadian()
    local rotatedOffset = particle.offset:rotate(transformable.direction:getRadian()):add(entity:get("Transformable").position)

    particle.particle:setPosition(rotatedOffset.x, rotatedOffset.y)
    particle.particle:setDirection(math.pi+radian)
end

function ParticlePositionSyncSystem:requires()
    return {"Particle", "Transformable"}
end

return ParticlePositionSyncSystem
