local Vector = require("helper/Vector")

local Transformable = class("Transformable", Component)

function Transformable:__init(offset, dir, parent)
    self.offset = offset or Vector()

    self.position = Vector()
    self.direction = dir or Vector()

    self.children = {}

    if parent then
        parent:get("Transformable"):addChild(self)
    else
        local transformableRoot = stack:current().transformableRoot
        if transformableRoot then
            transformableRoot:addChild(self)
        end
    end
end

function Transformable:addChild(child)
    table.insert(self.children, child)
end

return Transformable
