MuzzleparticlesSystem = class("MuzzleparticlesSystem", System)

function MuzzleparticlesSystem:update()
    for k, entity in pairs(self.targets) do
        local muzzleparticles = entity:get("Muzzleparticles")
        local particle = entity:get("Particle")
        local accelerating = entity:get("Accelerating")
        local speed = entity:get("Moving")
        local currentAcceleration = accelerating.acceleration:length()
        local currentSpeed = speed.speed:length()
        local moving = math.ceil(currentAcceleration * 0.001) --wahrscheinlich weirde loesung damit aus der acceleration 1 oder 0 gemacht wird
        local speedpercentage = (1/accelerating.defaultAcceleration)*currentSpeed*10/6 --prozent der max geschwindigkeit
        particle.particle:setSpeed(moving*speedpercentage*muzzleparticles.maxspeed+muzzleparticles.idlespeed, moving*speedpercentage*2*muzzleparticles.maxspeed+(2*muzzleparticles.idlespeed))
        particle.particle:setEmissionRate(muzzleparticles.emission*speedpercentage*moving+muzzleparticles.idleemission)
    end
end

function MuzzleparticlesSystem:requires()
    return {"Accelerating", "Particle", "Muzzleparticles", "Moving"}
end
return MuzzleparticlesSystem
