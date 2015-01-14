local Vector = require("helper/Vector")

ClickableSystem = class("ClickableSystem", System)

function ClickableSystem:mouseReleased(event)
    for _, target in pairs(self.targets.buttons) do
        local transformable = target:get("Transformable")
        local radius = target:get("Circle").radius
        local clickable = target:get("Clickable")
        local camera = table.firstElement(self.targets.camera)
        local camPos = (camera and camera:get("Transformable").position) or 0
        local mouseWorldPosition = Vector(event.x, event.y):add(camPos)
        if transformable.position:distanceTo(mouseWorldPosition) <= radius then
            clickable.clicked()
        end
    end
end

function ClickableSystem:requires()
    return {buttons={"Clickable", "Transformable", "Circle"}, camera={"Camera", "Transformable"}}
end

return ClickableSystem
