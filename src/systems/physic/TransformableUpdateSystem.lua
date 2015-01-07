local TransformableUpdateSystem = class("TransformableUpdateSystem", System)

function TransformableUpdateSystem:update(dt)
    local master = stack:current().engine:getRootEntity()
    local function updatePositions(_, parent)
        local parentTrans = parent:get("Transformable")
        table.each(parent.children, function(_, child)
            local childTrans = child:get("Transformable") 
            if childTrans then
                childTrans.position:set(childTrans.offset:rotate(parentTrans.direction:getRadian()):add(parentTrans.position))
                updatePositions(nil, child)
            end
        end)
    end

    updatePositions(nil, master)
end

function TransformableUpdateSystem:onDemandUpdate(event)
    local target = event.entity
    local transformable = event.entity:get("Transformable")
    local ParentTransformable = event.entity.parent:get("Transformable")
    transformable.position:set(transformable.offset:rotate(ParentTransformable.direction:getRadian()):add(ParentTransformable.position))

    local function updatePositions(_, parent)
        local parentTrans = parent:get("Transformable")
        table.each(parent.children, function(_, child)
            local childTrans = child:get("Transformable") 
            if childTrans then
                childTrans.position:set(childTrans.offset:rotate(parentTrans.direction:getRadian()):add(parentTrans.position))
                updatePositions(nil, child)
            end
        end)
    end

    updatePositions(nil, target)
end

return TransformableUpdateSystem
