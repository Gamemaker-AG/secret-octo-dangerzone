local UpdateParticlePosition = class("UpdateParticlePosition")

function UpdateParticlePosition:__init(target)
    self.entity = target
end

return  UpdateParticlePosition
