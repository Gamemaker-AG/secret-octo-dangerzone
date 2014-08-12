DrawSystem = class("DrawSystem", System)

function DrawSystem:draw()
    --love.graphics.setColor(255, 255, 255, 255)

    for index, entity in pairs(self.targets) do
        local drawable = entity:get("DrawableComponent")
        local pos = entity:get("PositionComponent")

        love.graphics.draw(drawable.image, pos.x, pos.y, drawable.r, drawable.width/drawable.image:getWidth(), drawable.height/drawable.image:getHeight())
    end
end

function DrawSystem:requires()
    return {"DrawableComponent", "PositionComponent"}
end
