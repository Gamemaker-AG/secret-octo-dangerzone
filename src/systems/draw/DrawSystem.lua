local DrawSystem = class("DrawSystem", System)

function DrawSystem:initialize()
    self.sortedTargets = {}
end

function DrawSystem:draw()
    love.graphics.setColor(255, 255, 255)
    for index, entity in ipairs(self.sortedTargets) do
        local drawable = entity:get("Drawable")
        local pos = entity:get("Transformable")
        local sx, sy = drawable.sx, drawable.sy
        if entity:get("Circle") then
            local radius = entity:get("Circle").radius*2
            sx = radius/drawable.image:getWidth()
            sy = radius/drawable.image:getHeight()
        end
        love.graphics.draw(drawable.image, pos.position.x, pos.position.y, pos.direction:getRadian(), sx, sy, drawable.ox, drawable.oy)
    end
end

function DrawSystem:requires()
    return {"Drawable", "Transformable"}
end

function DrawSystem:addEntity(entity)
    -- Entitys are sorted by Index, therefore we had to overwrite System:addEntity
    self.targets[entity.id] = entity
    self.sortedTargets = table.resetIndice(self.targets)
    table.sort(self.sortedTargets, function(a, b) return a:get("Drawable").index < b:get("Drawable").index end)
end

function DrawSystem:removeEntity(entity)
    -- Entitys are sorted by Index, therefore we had to overwrite System:addEntity
    self.targets[entity.id] = nil
    self.sortedTargets = table.resetIndice(self.targets)
    table.sort(self.sortedTargets, function(a, b) return a:get("Drawable").index < b:get("Drawable").index end)
end

return DrawSystem
