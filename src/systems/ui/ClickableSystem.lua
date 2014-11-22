local Vector = require("helper/Vector")

ClickableSystem = class("ClickableSystem", System)

function ClickableSystem:mouseReleased(event)
    for _, target in pairs(self.targets.buttons) do
        local transformable = target:get("Transformable")
        local diameter = target:get("Diameter")
        local clickable = target:get("Clickable")
        local camPos = table.firstElement(self.targets.camera):get("Camera").position
        local mouseWorldPosition = Vector(event.x, event.y):add(camPos)
        if transformable.position:distanceTo(mouseWorldPosition) <= diameter.diameter/2 then
            clickable.clicked()
        end
    end
end

function ClickableSystem:requires()
    return {buttons={"Clickable", "Transformable", "Diameter"}, camera={"Camera"}}
end

return ClickableSystem
