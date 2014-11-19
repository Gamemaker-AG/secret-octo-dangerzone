local ParticleUpdateSystem = class("ParticleUpdateSystem", System)

function ParticleUpdateSystem:update(dt)
    for index, entity in pairs(self.targets) do
        -- Updates Particles. If timer is below 0 the entity will be removed
        entity.components.Particle.particle:update(dt)
        -- if entity:get("Particle") then
        --     entity.components.Particle.emitterlife = entity.components.Particle.emitterlife - dt
        --     if entity.components.Particle.emitterlife <= 0 then
        --         entity.components.Particle.particlelife = entity.components.Particle.particlelife - dt
        --         if entity.components.Particle.particle:isActive() then
        --             entity.components.Particle.particle:pause()
        --         end
        --         if entity.components.Particle.particlelife < 0 then
        --             stack:current().engine:removeEntity(entity)
        --         end
        --     end
        -- end
    end
end

function ParticleUpdateSystem:requires(dt)
    return {"Particle"}
end

return ParticleUpdateSystem
