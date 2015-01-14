local KeyPressed = require("events/KeyPressed")

-- State superclass
local State = require("core/State")
local GameOverState = class("GameOverState", State)

function GameOverState:load()
    self.engine = Engine()
    self.eventmanager = EventManager()
    self.eventmanager:addListener("KeyPressed", {self, self.keypressed})
end

function GameOverState:update(dt)
    self.engine:update(dt)
end

function GameOverState:draw()
    self.engine:draw()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("Press any button to restart the game", 10, 10)
end

function GameOverState:keypressed()
    stack:popload()
end

return GameOverState
