local Drawable = require("components/graphic/Drawable")
local Clickable = require("components/ui/Clickable")
local Transformable = require("components/physic/Transformable")
local Diameter = require("components/physic/Diameter")

local Vector = require("helper/Vector")

local createButtonComponents = require("models/ui/createButtonComponents")

local TurretMenu = class("TurretMenu")

function TurretMenu:__init(turret)
    self.buttons = {}
    self.turret = turret
    self.visible = false

    local button_diameter = turret:get("Diameter").diameter*1.5
    local distance_to_center = turret:get("Diameter").diameter*2

    local button_count = 4
    for i = 0, button_count-1, 1 do
        local button = Entity()
        button:setParent(turret)

        local offset = Vector(distance_to_center):rotate(i*(2*math.pi/button_count))

        local comps = createButtonComponents(function() print("Turret Button was clicked!") end,
            resources.images.circle,
            offset,
            button_diameter)
        button:addMultiple(comps)

        table.insert(self.buttons, button)
    end
end

function TurretMenu:toggle()
    local engine = stack:current().engine
    if self.visible then
        print("removing buttons")
        for _, button in pairs(self.buttons) do engine:removeEntity(button) end
    else
        print("adding buttons")
        for _, button in pairs(self.buttons) do engine:addEntity(button) end
    end
    self.visible = not self.visible
end

return TurretMenu
