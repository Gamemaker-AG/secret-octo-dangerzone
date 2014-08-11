PauseState = class("PauseState", State)

function PauseState:__init()

end

function PauseState:load()
    self.engine = Engine()
    self.eventmanager = EventManager()
end

function PauseState:update(dt)
    self.engine:update(dt)
end

function PauseState:draw()
    self.engine:draw()
end

function PauseState:keypressed(key, isrepeat)
    self.eventmanager:fireEvent(KeyPressed(key, isrepeat))
end
