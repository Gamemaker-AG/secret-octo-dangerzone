local ParticleComponent = class("ParticleComponent", Component)

function ParticleComponent:__init(image, buffer)
    self.particle = love.graphics.newParticleSystem(image, buffer)
end

return ParticleComponent
