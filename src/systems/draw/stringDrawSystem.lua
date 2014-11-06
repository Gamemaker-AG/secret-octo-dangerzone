local StringDrawSystem = class("StringDrawSystem", System)

function StringDrawSystem:draw()
    for index, entity in pairs(self.targets) do
        local str = entity:get("StringComponent")
        local position = entity:get("PositionComponent")
        local val = {}
        for k, v in pairs(str.values) do
            table.insert(val, v[1][v[2]])
        end
        love.graphics.setColor(unpack(str.color))
        love.graphics.setFont(str.font)
        love.graphics.print(string.format(str.string, unpack(val)), position.x, position.y, 0, 1*relation(), 1*relation())
    end
end

function StringDrawSystem:requires()
    return {"PositionComponent", "StringComponent"}
end

return StringDrawSystem
