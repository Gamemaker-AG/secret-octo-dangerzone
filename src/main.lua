-- Main Library
require("lib/lua-lovetoys/lovetoys/engine")
-- Helper
require("helper/tables")
-- All Events
require("events/keyPressed")
-- Core Stuff
require("core/stackhelper")
require("core/state")
require("core/resources")
require("core/save")
require("core/achievement")
-- States
require("states/menuState")
require("states/gameState")
require("states/gameOverState")

function love.load()
    resources = Resources()

    resources:addImage("triangle", "data/img/triangle.png")
    resources:addImage("circle", "data/img/circle.png")
    resources:addImage("square", "data/img/square.png")
    resources:addImage("clock", "data/img/timer.png")
    
    resources:addImage("bombTriangle", "data/img/bombTriangle.png")
    resources:addImage("bombCircle", "data/img/bombCircle.png")
    resources:addImage("bombSquare", "data/img/bombSquare.png")

    resources:addImage("changeTriangle", "data/img/changeTriangle.png")
    resources:addImage("changeCircle", "data/img/changeCircle.png")
    resources:addImage("changeSquare", "data/img/changeSquare.png")

    resources:addFont("CoolFont100", "data/font/Audiowide-Regular.ttf", 100)
    resources:addFont("CoolFont40", "data/font/Audiowide-Regular.ttf", 40)
    resources:addFont("CoolFont", "data/font/Audiowide-Regular.ttf", 20)

    resources:addSound("pling", "data/audio/pling.wav", "static")
    resources:addSound("plinglo", "data/audio/pling-lo.wav", "static")
    resources:addSound("plinghi", "data/audio/pling-hi.wav", "static")

    resources:load()

    resources.sounds.pling:setVolume(0.9)
    resources.sounds.pling:setPitch(0.1)
    resources.sounds.plinglo:setVolume(0.9)
    resources.sounds.plinghi:setVolume(0.9)
    resources.sounds.plinghi:setPitch(0.4)

    save = Save()
    save:loadHighscore()
    achievement = Achievement()
    achievement:loadAchievements()
    stack = StackHelper()
    stack:push(MenuState())
end


function love.update(dt)
    stack:current():update(dt)
    
end

function love.draw()
    stack:current():draw()
end 

function love.keypressed(key, isrepeat)
    stack:current():keypressed(key, isrepeat)
end

function love.keyreleased(key, isrepeat)
    stack:current():keyreleased(key, isrepeat)
end

function love.mousepressed(x, y, button)
    stack:current():mousepressed(x, y, button)
end
