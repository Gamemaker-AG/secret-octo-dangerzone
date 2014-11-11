local Particle = class("Particle", Component)

function Particle:__init(image, buffer, particlelife, emitterlife)
    self.particle = love.graphics.newParticleSystem(image, buffer)
    self.particlelife = particlelife + 0.2
    self.emitterlife = emitterlife
end

return Particle
