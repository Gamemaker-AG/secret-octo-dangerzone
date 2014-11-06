-- State superclass
local State = require("core/state")

local MenuState = class("MenuState", State)

function MenuState:load()
    self.engine = Engine()
    self.eventmanager = EventManager()
end

function MenuState:update(dt)
    self.engine:update(dt)
end

function MenuState:draw()
    self.engine:draw()

    love.graphics.print("Press any button to start the game!", 10, 10)
end

function MenuState:keypressed(key, isrepeat)
    local KeyPressed = require("events/keyPressed")
    self.eventmanager:fireEvent(KeyPressed(key, isrepeat))

    -- Start the game when any key is pressed
    local GameState = require("states/gameState")
    stack:push(GameState())
end

return MenuState
