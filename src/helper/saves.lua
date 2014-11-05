Saves = class("Saves")

function Saves:saveSettings()
    if love.filesystem.exists("settings.lua") then
        love.filesystem.remove("settings.lua")
    end
    love.filesystem.newFile("settings.lua")
    success = love.filesystem.write("settings.lua", table.show(set.settings, "settings"))
end

function Saves:loadSettings()
    if love.filesystem.exists("settings.lua") then
        chunk = love.filesystem.load("settings.lua")
        chunk()
        set.settings = settings
        self:refreshSettings()
        return true
    else
        return false
    end
end

function Saves:refreshSettings()
    love.window.setMode(set.settings.resolution[1], set.settings.resolution[2], {fullscreen=set.settings.fullscreen, resizable=false, vsync=true})
end

function Saves:saveGame()
    if love.filesystem.exists("stats.lua") then
        love.filesystem.remove("stats.lua")
    end
    love.filesystem.newFile("stats.lua")
    success = love.filesystem.write("stats.lua", table.show(gameplay.stats, "stats"))
end

function Saves:loadGame()
    if love.filesystem.exists("stats.lua") then
        chunk = love.filesystem.load("stats.lua")
        chunk()
        gameplay.stats = stats
        for i, v in pairs(gameplay.items) do
            v.owned = gameplay.stats.owned[i]
        end
        return true
    else
        return false
    end
end