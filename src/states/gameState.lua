tween = require("lib/tween/tween")

require("states/pauseState")

GameState = class("GameState", State)

function GameState:__init()

    self.shaketimer = 0
    self.slowmo = 0
end

function GameState:load()
    self.engine = Engine()
    self.eventmanager = EventManager()

end

function GameState:update(dt)
    -- Camerashake
    if self.shaketimer > 0 then
        self.nextShake = self.nextShake - (dt*50)
        if self.nextShake < 0 then
            self.nextShake = 1
            self.shakeX = math.random(-self.translate, self.translate)
            self.shakeY = math.random(-self.translate, self.translate)
        end
        self.shaketimer = self.shaketimer - dt
    end

    -- Slowmo stuff
    if self.slowmo > 0 then
        self.slowmo = self.slowmo - dt
        self.engine:update(dt/3)
    else
        self.engine:update(dt)
    end
end

function GameState:draw()
    -- Screenshake
    if self.shaketimer > 0 then love.graphics.translate(self.shakeX, self.shakeY) end

    self.engine:draw()
end

function GameState:keypressed(key, isrepeat)
    self.eventmanager:fireEvent(KeyPressed(key, isrepeat))
end
