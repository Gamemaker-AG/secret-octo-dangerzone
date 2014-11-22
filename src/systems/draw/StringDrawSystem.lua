local lume = require("lib/lume/lume")

local StringDrawSystem = class("StringDrawSystem", System)

function StringDrawSystem:draw()
    for index, entity in pairs(self.targets) do
        local str = entity:get("DrawableText")
        local position = entity:get("Transformable").position
        local val = {}
        for k, v in pairs(str.values) do
            table.insert(val, v[1][v[2]])
        end
        love.graphics.setColor(unpack(str.color))
        love.graphics.setFont(str.font)
        local player = table.find(stack:current().engine:getEntityList("Faction"), function(i, entity)
            return entity:get("Faction").faction == "player"
        end)
        playerpos = player:get("Transformable").position
        love.graphics.print(string.format(str.string, unpack(val)), playerpos.x + position.x, playerpos.y + position.y, 0, 1, 1)
    end
end

function StringDrawSystem:requires()
    return {"Transformable", "DrawableText"}
end

return StringDrawSystem
