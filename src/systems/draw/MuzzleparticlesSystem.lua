MuzzleparticlesSystem = class("MuzzleparticlesSystem", System)

function MuzzleparticlesSystem:update()
    for k, entity in pairs(self.targets) do
        local particle = entity:get("Particle")
        local accelerating = entity:get("Accelerating")
        local bla = (accelerating.defaultAcceleration*(1/accelerating.acceleration))*particle.maxspeed
        particle.particle:setSpeed(((accelerating.defaultAcceleration*(1/accelerating.acceleration))*particle.maxspeed)-200, (accelerating.defaultAcceleration*(1/accelerating.acceleration))*particle.maxspeed)
        print(bla)
    end
end

function MuzzleparticlesSystem:requires()
    return {"Accelerating", "Particle", "Muzzleparticles"}
end
return MuzzleparticlesSystem
