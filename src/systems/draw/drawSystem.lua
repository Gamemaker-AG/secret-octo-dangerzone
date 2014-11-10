local DrawSystem = class("DrawSystem", System)

function DrawSystem:__init()
    self.sortedTargets = {}
end

function DrawSystem:draw()
    love.graphics.setColor(255, 255, 255)
    for index, entity in ipairs(self.sortedTargets) do
        local drawable = entity:get("DrawableComponent")
        local pos = entity:get("TransformComponent")
        love.graphics.draw(drawable.image, pos.position.x, pos.position.y, pos.direction:getRadian(), drawable.sx, drawable.sy, drawable.ox, drawable.oy)
    end
end

function DrawSystem:requires()
    return {"DrawableComponent", "TransformComponent", "ZIndex"}
end

function DrawSystem:addEntity(entity)
    -- Entitys are sorted by ZIndex, therefore we had to overwrite System:addEntity
    self.targets[entity.id] = entity
    self.sortedTargets = table.resetIndice(self.targets)
    table.sort(self.sortedTargets, function(a, b) return a:get("ZIndex").index < b:get("ZIndex").index end)
end

function DrawSystem:removeEntity(entity)
    -- Entitys are sorted by ZIndex, therefore we had to overwrite System:addEntity
    self.targets[entity.id] = nil
    self.sortedTargets = table.resetIndice(self.targets)
    table.sort(self.sortedTargets, function(a, b) return a:get("ZIndex").index < b:get("ZIndex").index end)
end

return DrawSystem
