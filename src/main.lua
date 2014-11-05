-- Main Lövetoys Library
require("lib/lovetoys/lovetoys")
require("helper/tables")

-- Framework Requirements
require("core/stackhelper")
require("core/state")
require("core/resources")

-- States
require("states/menuState")
require("states/gameState")

-- Events
require("events/keyPressed")

function love.load()
    resources = Resources()

    -- Add your resources here:
    resources:addImage("circle", "data/img/circle.png")

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
