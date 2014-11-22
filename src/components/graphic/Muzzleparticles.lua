Muzzleparticles = class("Muzzleparticles", Component)

function Muzzleparticles:__init(idlespeed, maxspeed, idlecount, maxcount, idlespread, maxspread)
    self.idlespeed = idlespeed
    self.maxspeed = maxspeed
    self.idlecount = idlecount
    self.maxcount = maxcount
    self.idlespread = idlespread
    self.maxspread = maxspread
end

return Muzzleparticles
