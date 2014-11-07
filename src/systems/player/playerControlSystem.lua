local PlayerControlSystem = class("PlayerControlSystem", System)

function PlayerControlSystem:update(dt) 
    for index, entity in pairs(self.targets) do
        if love.keyboard.isDown("w") then
            entity:get("AccelerationComponent").active = true
        elseif not love.keyboard.isDown("w") then
            entity:get("AccelerationComponent").active = false 
        end
        
    end
end

function PlayerControlSystem:requires() 
    return {"PlayerComponent"}
end

return PlayerControlSystem
