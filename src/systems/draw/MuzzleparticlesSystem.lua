local lume = require("lib/lume/lume")

MuzzleparticlesSystem = class("MuzzleparticlesSystem", System)

function MuzzleparticlesSystem:update()
    for k, entity in pairs(self.targets) do
        local accelerating, particle, muzzleparticles, speed = self:pickRequiredComponents(entity)
        local currentAcceleration = accelerating.acceleration:length()
        local accelerationPercentage = currentAcceleration/accelerating.defaultAcceleration

        local minspeed = lume.lerp(muzzleparticles.idlespeed, muzzleparticles.maxspeed, accelerationPercentage)
        local maxspeed = minspeed*2
        local emission = lume.lerp(muzzleparticles.idleemission, muzzleparticles.maxemission, accelerationPercentage)
        
        particle.particle:setSpeed(minspeed, maxspeed)
        particle.particle:setEmissionRate(emission)
    end
end

function MuzzleparticlesSystem:requires()
    return {"Accelerating", "Particle", "Muzzleparticles"}
end
return MuzzleparticlesSystem
