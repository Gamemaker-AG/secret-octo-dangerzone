ParticlePositionSyncSystem = class("ParticlePositionSyncSystem", System)

function ParticlePositionSyncSystem:update()
    for k, entity in pairs(self.targets) do
        entity:getComponent("ParticleComponent").particle:setPosition(
        	entity:getComponent("PositionComponent").x + (stack:current().nodeWidth/2), 
        	entity:getComponent("PositionComponent").y + (stack:current().nodeWidth/2))
    end
end

function ParticlePositionSyncSystem:getRequiredComponents()
    return {"ParticleComponent", "PositionComponent"}
end