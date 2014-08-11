Save = class("Save")

function Save:__init()
    if not self:loadHighscore() then
        self.highscore = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
    end
end

function Save:addHighscore(number)
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

function Save:saveHighscore(val)
    self:addHighscore(val)
    if love.filesystem.exists("highscore.lua") then
        love.filesystem.remove("highscore.lua")
    end
    love.filesystem.newFile("highscore.lua")
    success = love.filesystem.write("highscore.lua", table.show(self.highscore, "highscore"))
end

function Save:loadHighscore()
    if love.filesystem.exists("highscore.lua") then
        chunk = love.filesystem.load("highscore.lua")
        chunk()
        self.highscore = highscore
        return true
    else
        return false
    end
end