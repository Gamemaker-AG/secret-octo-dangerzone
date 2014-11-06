PlayerControlSystem = class("PlayerControlSystem", System)

function PlayerControlSystem:update(dt) 
    for index, entity in pairs(self.targets) do
        entity:get("PositionComponent").x = entity:get("PositionComponent").x + dt * 90
        entity:get("PositionComponent").y = entity:get("PositionComponent").y + dt * 90
    end
end

function PlayerControlSystem:requires() 
    return {"PositionComponent"}
end
