ParticleDrawSystem = class("ParticleDrawSystem", System)

function ParticleDrawSystem:draw()
    for index, entity in pairs(self.targets) do
        love.graphics.draw(entity.components.ParticleComponent.particle, 0, 0)
        love.graphics.draw(entity.components.ParticleComponent.particle, -love.graphics.getWidth(), 0)
        love.graphics.draw(entity.components.ParticleComponent.particle, love.graphics.getWidth(), 0)
    end
end

function ParticleDrawSystem:requires()
    return {"ParticleComponent"}
end
