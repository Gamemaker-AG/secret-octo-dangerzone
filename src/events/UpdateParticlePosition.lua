local UpdateParticlePosition = class("UpdateParticlePosition")

function UpdateParticlePosition:initialize(target)
    self.entity = target
end

return  UpdateParticlePosition
