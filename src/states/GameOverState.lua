local KeyPressed = require("events/KeyPressed")

-- State superclass
local State = require("core/State")
local GameOverState = class("GameOverState", State)

function GameOverState:load()
    self.engine = Engine()
    self.eventmanager = EventManager()
end

function GameOverState:update(dt)
    self.engine:update(dt)
end

function GameOverState:draw()
    self.engine:draw()

    love.graphics.print("Press any button to restart the game", 10, 10)
end

function GameOverState:keypressed(key, isrepeat)
    self.eventmanager:fireEvent(KeyPressed(key, isrepeat))

    -- Start the game when any key is pressed
    stack:popload()
end

return GameOverState
