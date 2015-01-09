local TransformableUpdateSystem = class("TransformableUpdateSystem", System)

function TransformableUpdateSystem:updatePositions(parent)
    local parentTrans = parent:get("Transformable")
    table.each(parent.children, function(_, child)
        local childTrans = child:get("Transformable") 
        if childTrans then
            if childTrans.rotationEnabled then
                childTrans.position:set(childTrans.offset:rotate(parentTrans.direction:getRadian()):add(parentTrans.position))
            else
                childTrans.position:set(childTrans.offset:add(parentTrans.position))
            end    
            self:updatePositions(child)
        end
    end)
end

function TransformableUpdateSystem:update(dt)
    local master = stack:current().engine:getRootEntity()
    self:updatePositions(master)
end

function TransformableUpdateSystem:onDemandUpdate(event)
    local target = event.entity
    local transformable = event.entity:get("Transformable")
    local ParentTransformable = event.entity.parent:get("Transformable")
    if transformable.rotationEnabled then
        transformable.position:set(transformable.offset:rotate(ParentTransformable.direction:getRadian()):add(ParentTransformable.position))
    else
        transformable.position:set(transformable.offset:add(ParentTransformable.position))
    end

    self:updatePositions(target)
end

return TransformableUpdateSystem
