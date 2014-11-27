local WavesSystem = class("WavesSystem", System)
-- local enemycount
-- local enemy
-- local EnemyModel
 local EnemyModel = require("models/EnemyModel")
 function WavesSystem:__init()
     self.enemycount = 0
 end

function WavesSystem:update(dt)
    print(self.enemycount)

    if self.enemycount == 0 then
        self:spawnWave(50)
    end
end

function WavesSystem:spawnWave(enemies)
    for i=0, enemies-1 do
        local enemy = EnemyModel(math.random(100, 1200),math.random(100, 700))
            stack:current().engine:addEntity(enemy)
            self.enemycount = self.enemycount + 1
    end
end

function WavesSystem:deleteEnemy()
    
    self.enemycount = self.enemycount -1
end

function WavesSystem:requires()
    return {""}
end

return WavesSystem