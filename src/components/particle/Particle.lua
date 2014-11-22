local Particle = class("Particle", Component)

function Particle:__init(image, maxParticles, offset, particlelife, emitterlife)
    self.particle = love.graphics.newParticleSystem(image, maxParticles)
    self.particle:setParticleLifetime(particlelife[1], particlelife[2])

    self.offset = offset

    self.particlelife = particlelife[2]
    if emitterlife then
        self.particle:setEmitterLifetime(emitterlife)
        self.emitterlife = emitterlife
    end
end

return Particle
