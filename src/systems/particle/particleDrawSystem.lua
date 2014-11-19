local ParticleDrawSystem = class("ParticleDrawSystem", System)

function ParticleDrawSystem:draw()
    for index, entity in pairs(self.targets) do
        print("motherfucker")
        love.graphics.draw(entity.components.Particle.particle, 0, 0)
    end
end

function ParticleDrawSystem:requires()
    return {"Particle"}
end

return ParticleDrawSystem
