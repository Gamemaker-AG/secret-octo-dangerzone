Muzzleparticles = class("Muzzleparticles", Component)

function Muzzleparticles:__init(idlespeed, maxspeed, idleemission, emission)
    self.maxspeed = maxspeed
    self.emission = emission
    self.idlespeed = idlespeed
    self.idleemission = idleemission
end

return Muzzleparticles
