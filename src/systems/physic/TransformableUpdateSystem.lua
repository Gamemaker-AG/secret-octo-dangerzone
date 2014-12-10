local TransformableUpdateSystem = class("TransformableUpdateSystem", System)

function TransformableUpdateSystem:update(dt)
    local master = stack:current().engine:getMaster()
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

return TransformableUpdateSystem
