local Particle = class("Particle", Component)

function Particle:__init(image, maxParticles, particlelife, emitterlife)
    self.particle = love.graphics.newParticleSystem(image, maxParticles)
    self.particle:setEmitterLifetime(emitterlife)
    self.particle:setParticleLifetime(particlelife[1], particlelife[2])

    self.particlelife = particlelife[2]
    self.emitterlife = emitterlife or nil
end

return Particle
