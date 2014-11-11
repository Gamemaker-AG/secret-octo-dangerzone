local PlayerControlSystem = class("PlayerControlSystem", System)

function PlayerControlSystem:update()
    for index, entity in pairs(self.targets) do
        if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
            local speedComponent = entity:get("SpeedComponent")
            local direction = entity:get("TransformComponent").direction
            speedComponent.acceleration:set(direction:multiply(speedComponent.defaultAcceleration))
        end
    end
end

function PlayerControlSystem:fireEvent(event) 
    for index, entity in pairs(self.targets) do
         if event.__name == "KeyPressed" then
            if event.key == "a" or event.key == "left" then
                local speed = entity:get("SpeedComponent")
                speed.rotSpeed = -speed.defRotSpeed
            elseif event.key == "d" or event.key == "right" then
                local speed = entity:get("SpeedComponent")
                speed.rotSpeed = speed.defRotSpeed
            end
         elseif event.__name == "KeyReleased" then
            if event.key == "w" or event.key == "up" then
                entity:get("SpeedComponent").acceleration:set(0, 0)
            elseif event.key == "a" or event.key == "left" then
                entity:get("SpeedComponent").rotSpeed = 0
            elseif event.key == "d" or event.key == "right" then
                entity:get("SpeedComponent").rotSpeed = 0
            end
        end
    end
end

function PlayerControlSystem:requires() 
    return {"ControllableComponent", "SpeedComponent", "TransformComponent"}
end

return PlayerControlSystem
