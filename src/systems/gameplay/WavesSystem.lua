local WavesSystem = class("WavesSystem", System)
local constants = require("constants")
local createPirateCollection = require("collections/createPirateCollection")
local timer = constants.waves.timer

function WavesSystem:update(dt)
    if table.count(self.targets) == 0 then
        if timer <= 0 then
            self:spawnWave(10)
            timer = constants.waves.timer
        end 
        timer = timer - dt
    end
end

function WavesSystem:spawnWave(enemies)
    local player = table.firstElement(stack:current().engine:getEntitiesWithComponent("Player"))
    if player then
        for i=1, enemies do
            local enemy = Entity()
            enemy:addMultiple(createPirateCollection(
            -- Random Positions for enemies in vicinity of Player
                math.random(player:get("Transformable").position.x + -1200, 
                            player:get("Transformable").position.x + 1200),
                math.random(player:get("Transformable").position.y + -1200, 
                            player:get("Transformable").position.y + 700)))
            stack:current().engine:addEntity(enemy)
        end
    end
end

function WavesSystem:requires()
    return {"Wave"}
end

return WavesSystem
