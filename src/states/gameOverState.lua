GameOverState = class("GameOverState", State)

function GameOverState:__init(score)
    self.score = score
end

function GameOverState:load()
    self.engine = Engine()
    self.eventmanager = EventManager()
end

function GameOverState:update(dt)
    self.engine:update(dt)
end

function GameOverState:draw()
    self.engine:draw()
end

function GameOverState:keypressed(key, isrepeat)
    self.eventmanager:fireEvent(KeyPressed(key, isrepeat))
end
