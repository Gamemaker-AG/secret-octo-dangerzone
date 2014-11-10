local PlayerControlSystem = class("PlayerControlSystem", System)

function PlayerControlSystem:update(dt) 
    for index, entity in pairs(self.targets) do
        if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
            entity:get("SpeedComponent").active = true
        elseif not love.keyboard.isDown("w") then
            entity:get("SpeedComponent").active = false 
        end
        if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
            entity:get("TransformComponent").direction:rotate(entity:get("SpeedComponent").rotSpeed * -dt)
        end
        if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
            entity:get("TransformComponent").direction:rotate(entity:get("SpeedComponent").rotSpeed * dt)
        end
    end
end

function PlayerControlSystem:requires() 
    return {"PlayerComponent"}
end

return PlayerControlSystem
