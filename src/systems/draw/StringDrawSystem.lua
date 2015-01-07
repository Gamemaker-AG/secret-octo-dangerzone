local lume = require("lib/lume/lume")

local StringDrawSystem = class("StringDrawSystem", System)

function StringDrawSystem:draw()
    for index, entity in pairs(self.targets) do
        local str = entity:get("DrawableText")
        if str.visible then
            local position = entity:get("Transformable").position
            local val = {}
            for k, v in pairs(str.values) do
                table.insert(val, v[1][v[2]])
            end
            love.graphics.setColor(unpack(str.color))
            love.graphics.setFont(str.font)
            love.graphics.print(string.format(str.string, unpack(val)), position.x, position.y, 0, 1, 1)
        end
    end
end

function StringDrawSystem:requires()
    return {"Transformable", "DrawableText"}
end


return StringDrawSystem
