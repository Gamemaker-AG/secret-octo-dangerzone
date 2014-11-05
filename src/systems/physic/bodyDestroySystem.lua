BodyDestroySystem = class("BodyDestroySystem", System)

function BodyDestroySystem:update()
    for index, entity in pairs(self.targets) do
        if entity:get("ParticleComponent") then
            local particle = Entity()
            particle:add(entity:get("ParticleComponent"))
            particle:get("ParticleComponent").particle:pause()
            local min, max = particle:get("ParticleComponent").particle:getParticleLifetime()
            local life = particle:get("ParticleComponent").particle:getEmitterLifetime()
            if life == -1 then
                life = 0
            end
            particle:add(ParticleTimerComponent(life, max))
            stack:current().engine:addEntity(particle)
        end
        stack:current().engine.entities[entity.id]:get("PhysicsComponent").body:destroy()
        stack:current().engine:removeEntity(entity)
    end
end

function BodyDestroySystem:requires()
    return {"DestroyComponent"}
end
