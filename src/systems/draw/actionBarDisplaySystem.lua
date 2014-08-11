ActionBarDisplaySystem = class("ActionBarDisplaySystem", System)

function ActionBarDisplaySystem:draw()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    love.graphics.setColor(100, 100, 100, 100)
    love.graphics.rectangle("fill", width*3/10, 0, width*4/10, height*1/40)
    love.graphics.setColor(200, 0, 0, 255)
    love.graphics.rectangle("fill", width*3/10, 0, width*4/10*stack:current().actionBar/100, height*1/40)
end