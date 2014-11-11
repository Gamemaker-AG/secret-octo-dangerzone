local PlayerControlSystem = class("PlayerControlSystem", System)

function PlayerControlSystem:update(dt) 
    for index, entity in pairs(self.targets) do
        if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
            local speedComponent = entity:get("SpeedComponent")
            local direction = entity:get("TransformComponent").direction
            speedComponent.acceleration:set(direction:multiply(speedComponent.defaultAcceleration))
        elseif not love.keyboard.isDown("w") then
            entity:get("SpeedComponent").acceleration:set(0, 0)
        end
        if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
            local direction = entity:get("TransformComponent").direction
            direction:set(direction:rotate(entity:get("SpeedComponent").rotSpeed*-dt):getUnit())
        end
        if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
            local direction = entity:get("TransformComponent").direction
            direction:set(direction:rotate(entity:get("SpeedComponent").rotSpeed*dt):getUnit())
        end
    end
end

function PlayerControlSystem:fireEvent(event) 
    for index, entity in pairs(self.targets) do
         if event.__name == "KeyPressed" then
            if event.key == "w" then
                local speedComponent = entity:get("SpeedComponent")
                local direction = entity:get("TransformComponent").direction
                speedComponent.acceleration:set(direction:multiply(speedComponent.defaultAcceleration))
            end
         elseif event.__name == "KeyReleased" then
            if event.key == "w" then
                entity:get("SpeedComponent").acceleration:set(0, 0)
            end
         end
    end
end

function PlayerControlSystem:requires() 
    return {"ControllableComponent", "SpeedComponent", "TransformComponent"}
end

return PlayerControlSystem
