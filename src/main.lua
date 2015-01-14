-- Main Lövetoys Library
require("lib/lovetoys/lovetoys")

-- Core and Helper Requirements
require("helper/tables")
require("core/Stackhelper")
require("core/Resources")

-- Events
local KeyPressed = require("events/KeyPressed")
local KeyReleased = require("events/KeyReleased")
local MousePressed = require("events/MousePressed")
local MouseReleased = require("events/MouseReleased")

local MenuState = require("states/MenuState")

function love.load()
    resources = Resources()

    -- Images
    resources:addImage("bg", "data/img/bg.png")
    resources:addImage("deepfield", "data/img/deepfield.png")
    resources:addImage("enemy", "data/img/enemy.png")
    resources:addImage("circle", "data/img/circle.png")
    resources:addImage("player", "data/img/player.png")
    resources:addImage("beam", "data/img/beam.png")
    resources:addImage("rocket", "data/img/rocket.png")
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
