Achievement = class("Achievement")

function Achievement:__init()
    if not self:loadAchievements() then
        self.achievements = {0,0,0}
    end
end

function Achievement:addAchievement(number)
    for index, value in ipairs(self.highscore) do
        if value < number then
            local i = index
            local temp = {}
            while self.highscore[i] do
                temp[i] = self.highscore[i]
                i = i+1
            end
            self.highscore[index] = number
            i = index
            while i < 10 and temp[i] do
                self.highscore[i+1] = temp[i]
                i = i + 1
            end
            break
        end
    end
end


function Achievement:saveAchievements()
    if love.filesystem.exists("achievements.lua") then
        love.filesystem.remove("achievements.lua")
    end
    love.filesystem.newFile("achievements.lua")
    success = love.filesystem.write("achievements.lua", table.show(self.achievements, "achievements"))
end

function Achievement:loadAchievements()
    if love.filesystem.exists("achievements.lua") then
        chunk = love.filesystem.load("achievements.lua")
        chunk()
        self.achievements = achievements
        return true
    else
        return false
    end
end