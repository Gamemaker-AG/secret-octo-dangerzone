DrawSystem = class("DrawSystem", System)

function DrawSystem:draw()
    local player 
    --love.graphics.setColor(255, 255, 255, 255)
    local nodeWidth = stack:current().nodeWidth
    local middleoffset = nodeWidth/2

    for index, entity in pairs(self.targets) do
        local drawable = entity:getComponent("DrawableComponent")
        local pos = entity:getComponent("PositionComponent")
        local posXnew = pos.x + middleoffset
        local posYnew = pos.y + middleoffset

        local offsetX = (drawable.image:getWidth())/2
        local offsetY = (drawable.image:getHeight())/2

        local color
        if entity:getComponent("ColorComponent") then
            local color = entity:getComponent("ColorComponent")
            love.graphics.setColor(color.r, color.g, color.b)
        end

        -- Draws the Picture. If Entity is near to the beginng or the end of the screen, the Entity is drawed on both sides for sideChangeSystem animation.
        if entity:getComponent("WobbleComponent") then
            scale = 1 + 0.1*math.sin(entity:getComponent("WobbleComponent").value)
            love.graphics.draw(drawable.image, posXnew, posYnew, drawable.r, drawable.sx*scale, drawable.sy*scale, offsetX, offsetY)
        else
            love.graphics.draw(drawable.image, posXnew, posYnew, drawable.r, drawable.sx, drawable.sy, offsetX, offsetY)
        end


--        VERSION VON SVEN         
--        color = entity:getComponent("ColorComponent")
--        love.graphics.setColor(color.r, color.g, color.b)
--        end
--
--        -- Draws the Picture. If Entity is near to the beginng or the end of the screen, the Entity is drawed on both sides for sideChangeSystem animation.
--        love.graphics.draw(drawable.image, posXnew, posYnew, drawable.r, drawable.sx, drawable.sy, offsetX, offsetY)
--        love.graphics.setColor(color.r, color.g, color.b, 100)
--        love.graphics.setBlendMode("additive")
--        love.graphics.draw(drawable.image, posXnew, posYnew, drawable.r, drawable.sx * 1.2, drawable.sy * 1.2, offsetX, offsetY)
--        love.graphics.setBlendMode("alpha")
--        love.graphics.setColor(color.r, color.g, color.b, 255)
    end
end

function DrawSystem:getRequiredComponents()
    return {"DrawableComponent", "PositionComponent"}
end
