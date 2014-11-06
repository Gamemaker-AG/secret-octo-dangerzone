-- Components
require("components/physic/positionComponent")
require("components/graphic/drawableComponent")
require("components/graphic/zIndex")

-- Models
require("models/playerModel")

-- Systems
require("systems/draw/drawSystem")
require("systems/player/playerControlSystem")

GameState = class("GameState", State)

function GameState:load()
    self.engine = Engine()
    self.eventmanager = EventManager()

    self.engine:addSystem(PlayerControlSystem(), "logic", 1)

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
