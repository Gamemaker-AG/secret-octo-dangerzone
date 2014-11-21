-- Main Lövetoys Library
require("lib/lovetoys/lovetoys")

-- Core and Helper Requirements
require("helper/tables")
require("core/stackhelper")
require("core/resources")

-- Events
local KeyPressed = require("events/keyPressed")
local KeyReleased = require("events/keyReleased")
local MousePressed = require("events/mousePressed")
local MouseReleased = require("events/mouseReleased")


local MenuState = require("states/menuState")

function love.load()
    resources = Resources()

    -- Add your resources here:
    resources:addImage("circle", "data/img/circle.png")
    resources:addImage("player", "data/img/player.png")
    resources:addImage("enemy", "data/img/enemy.png")
    resources:addImage("bg", "data/img/bg.png")
    resources:addFont("regular", "data/font/Audiowide-Regular.ttf")
    resources:addImage("particlemuzzle" ,"/data/img/particlemuzzle.png")
    resources:addImage("particle1" ,"/data/img/particle1.png")

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
    stack:current().eventmanager:fireEvent(KeyPressed(key, isrepeat))
end

function love.keyreleased(key, isrepeat)
    stack:current().eventmanager:fireEvent(KeyReleased(key, isrepeat))
end

function love.mousepressed(x, y, button)
    stack:current().eventmanager:fireEvent(MousePressed(x, y, button))
end

function love.mousereleased(x, y, button)
    stack:current().eventmanager:fireEvent(MouseReleased(x, y, button))
end
