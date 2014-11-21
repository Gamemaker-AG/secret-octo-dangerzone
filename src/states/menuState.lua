local GameState = require("states/gameState")

local KeyPressed = require("events/keyPressed")

-- State superclass
local State = require("core/state")
local MenuState = class("MenuState", State)

function MenuState:load()
    self.engine = Engine()
    self.eventmanager = EventManager()

    self.eventmanager:addListener("KeyPressed", {self, function(key, isrepeat)
        -- Start the game when any key is pressed
        stack:push(GameState())
    end})
end

function MenuState:update(dt)
    self.engine:update(dt)
end

function MenuState:draw()
    self.engine:draw()

    love.graphics.print("Press any button to start the game!", 10, 10)
end

return MenuState
