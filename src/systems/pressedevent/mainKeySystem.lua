MainKeySystem = class("MainKeySystem", System)

function MainKeySystem.fireEvent(self, event)
    -- Playercutie Jump
    if event.key == "p" or event.key == "escape" then
        local canvas = love.graphics.newScreenshot()
        local screenshot = love.graphics.newImage(canvas)
    end
end
