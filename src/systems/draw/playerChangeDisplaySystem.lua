PlayerChangeDisplaySystem = class("PlayerChangeDisplaySystem", System)

function PlayerChangeDisplaySystem:__init()
    self.rate = 500
end

function PlayerChangeDisplaySystem:draw()
    for index, entity in pairs(self.targets) do
        particle = entity:getComponent("ParticleComponent").particle
        particle:setEmissionRate(self.rate*entity:getComponent("PlayerChangeCountComponent").count/stack:current().size)
    end
end

function PlayerChangeDisplaySystem:getRequiredComponents()
    return {"PlayerChangeCountComponent"}
end
