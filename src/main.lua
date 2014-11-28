-- Main Lövetoys Library
require("lib/lovetoys/lovetoys")

-- Core and Helper Requirements
require("helper/tables")
require("core/Stackhelper")
require("core/Resources")

local MenuState = require("states/MenuState")

function love.load()
    resources = Resources()

    -- Images
    resources:addImage("bg", "data/img/bg.png")
    resources:addImage("enemy", "data/img/enemy.png")
    resources:addImage("circle", "data/img/circle.png")
    resources:addImage("player", "data/img/player.png")
    resources:addImage("beam", "data/img/beam.png")
    -- Turret
    resources:addImage("particlemuzzle" ,"/data/img/particlemuzzle.png")
    resources:addImage("particle1" ,"/data/img/particle1.png")
    -- Fonts
    resources:addFont("regular", "data/font/Audiowide-Regular.ttf")

    resources:load()

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
