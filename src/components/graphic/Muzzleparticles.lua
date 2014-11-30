Muzzleparticles = class("Muzzleparticles", Component)

function Muzzleparticles:__init(idlespeed, maxspeed, idleemission, maxemission)
    self.idlespeed = idlespeed
    self.maxspeed = maxspeed
    self.idleemission = idleemission
    self.maxemission = maxemission
end 

return Muzzleparticles
