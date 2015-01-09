local WavesSystem = class("WavesSystem", System)
local constants = require("constants")
local PirateModel = require("models/PirateModel")
local timer = constants.waves.timer

function WavesSystem:update(dt)
    if table.count(self.targets) == 0 then
        if timer <= 0 then
            self:spawnWave(10)
            timer = constants.waves.timer
        end 
        timer = timer - 1*dt
    end
end

function WavesSystem:spawnWave(enemies)
    local player = table.firstElement(stack:current().engine:getEntitiesWithComponent("Player"))
    if player then
        for i=0, enemies-1 do
            local enemy = PirateModel(math.random(player:get("Transformable").position.x + -1200, 
                                                    player:get("Transformable").position.x + 1200),
                                        math.random(player:get("Transformable").position.y + -1200, 
                                                    player:get("Transformable").position.y + 700))
            stack:current().engine:addEntity(enemy)
        end
    end
end

function WavesSystem:requires()
    return {"Wave"}
end

return WavesSystem
