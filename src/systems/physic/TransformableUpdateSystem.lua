local TransformableUpdateSystem = class("TransformableUpdateSystem", System)

function TransformableUpdateSystem:update(dt)
    local root = stack:current().transformableRoot
    local function updatePositions(_, parent)
        table.each(parent.children, function(_, child)
            child.position = parent.position:add(child.offset)
            updatePositions(nil, child)
        end)
    end

    updatePositions(nil, root)
end

return TransformableUpdateSystem
