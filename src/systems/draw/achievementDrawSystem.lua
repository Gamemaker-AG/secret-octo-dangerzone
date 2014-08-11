AchievementDrawSystem = class("AchievementDrawSystem", System)

function AchievementDrawSystem:draw()
    for index, entity in pairs(self.targets) do
        local drawable = entity:getComponent("DrawableComponent")
        local pos = entity:getComponent("PositionComponent")

        local color
        if entity:getComponent("ColorComponent") then
            color = entity:getComponent("ColorComponent")
            love.graphics.setColor(color.r, color.b, color.g,100)
        end
        -- Draws the Picture. If Entity is near to the beginng or the end of the screen, the Entity is drawed on both sides for sideChangeSystem animation.
        love.graphics.draw(drawable.image, pos.x, pos.y, drawable.r, drawable.sx, drawable.sy, offsetX, offsetY)
    end
end

function AchievementDrawSystem:getRequiredComponents()
    return {"DrawableComponent", "PositionComponent", "AchievementComponent"}
end
