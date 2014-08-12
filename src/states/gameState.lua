require("systems/draw/drawSystem")

require("models/playerModel")

GameState = class("GameState", State)

function GameState:load()
    self.engine = Engine()
    self.eventmanager = EventManager()

    self.engine:addSystem(DrawSystem(), "draw", 1)

    self.player = PlayerModel()
    self.engine:addEntity(self.player)
end

function GameState:update(dt)
    self.engine:update(dt)
end

function GameState:draw()
    self.engine:draw()
end

function GameState:keypressed(key, isrepeat)
    self.eventmanager:fireEvent(KeyPressed(key, isrepeat))
end
