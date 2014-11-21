local Vector = require("helper/vector")

ClickableSystem = class("ClickableSystem", System)

function ClickableSystem:onClick(event)
    self:eachTarget(function(target)
        local clickable, transformable, diameter = self:pickRequiredComponents(target)
        if transformable.position:distanceTo(Vector(event.x, event.y)) <= diameter.diameter then
            clickable.clicked()
        end
    end)
end

function ClickableSystem:requires()
    return {"Clickable", "Transformable", "Diameter"}
end

return ClickableSystem
