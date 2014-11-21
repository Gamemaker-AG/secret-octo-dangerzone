local ParticleUpdateSystem = class("ParticleUpdateSystem", System)

function ParticleUpdateSystem:update(dt)
    for index, entity in pairs(self.targets) do
        local particle = entity:get("Particle")
        --Updates Particles. 
        particle.particle:update(dt)
        -- If emittertimer is below 0 the entity will be removed
        if particle.emitterlife ~= nil then
            particle.emitterlife = particle.emitterlife - dt
            if particle.emitterlife <= 0 then
                if particle.particle:isActive() then
                    particle.particle:pause()
                end
                particle.particlelife = particle.particlelife - dt
                if particle.particlelife < 0 then
                    stack:current().engine:removeEntity(entity)
                end
            end
        end
    end
end

function ParticleUpdateSystem:requires(dt)
    return {"Particle"}
end

return ParticleUpdateSystem
