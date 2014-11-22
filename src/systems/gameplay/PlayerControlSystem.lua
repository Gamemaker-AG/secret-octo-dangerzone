local PlayerControlSystem = class("PlayerControlSystem", System)

function PlayerControlSystem:update()
    for index, entity in pairs(self.targets) do
        if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
            local accelerating = entity:get("Accelerating")
            local direction = entity:get("Transformable").direction:getUnit()
            local particle = entity:get("Particle").particle
            accelerating.acceleration:set(direction:multiply(accelerating.defaultAcceleration))
            particle:setSpeed(300,600)
            particle:setEmissionRate(2000)
            particle:setParticleLifetime(0.01, 0.1)
            particle:setAreaSpread("normal", 9,9)

        end
    end
end

function PlayerControlSystem:fireEvent(event) 
    for index, entity in pairs(self.targets) do
         if event.__name == "KeyPressed" then
            if event.key == "a" or event.key == "left" then
                local rotating = entity:get("Rotating")
                rotating.rotationSpeed = -rotating.defRotationSpeed
            elseif event.key == "d" or event.key == "right" then
                local rotating = entity:get("Rotating")
                rotating.rotationSpeed = rotating.defRotationSpeed
            elseif event.key == "h" then
                stack:current().engine:toggleSystem("StringDrawSystem")
            end
         elseif event.__name == "KeyReleased" then
            if event.key == "w" or event.key == "up" then
                entity:get("Accelerating").acceleration:set(0, 0)
                particle:setSpeed(100,100)
                particle:setEmissionRate(500)
                particle:setParticleLifetime(0.01, 0.05)
                particle:setAreaSpread("normal",7,7)
            elseif event.key == "a" or event.key == "left" then
                if not (love.keyboard.isDown("d") or love.keyboard.isDown("right")) then
                    entity:get("Rotating").rotationSpeed = 0
                end
            elseif event.key == "d" or event.key == "right" then
                if not (love.keyboard.isDown("a") or love.keyboard.isDown("left")) then
                    entity:get("Rotating").rotationSpeed = 0
                end
            end
        end
    end
end

function PlayerControlSystem:requires() 
    return {"Controllable"}
end

return PlayerControlSystem
