StringDrawSystem = class("StringDrawSystem", System)

function StringDrawSystem:draw()
    for index, entity in pairs(self.targets) do
        local str = entity:getComponent("StringComponent")
        local position = entity:getComponent("PositionComponent")
        local val = {}
        for k, v in pairs(str.values) do
            table.insert(val, v[1][v[2]])
        end
        love.graphics.setColor(unpack(str.color))
        love.graphics.setFont(str.font)
        love.graphics.print(string.format(str.string, unpack(val)), position.x, position.y, 0, 1, 1)
    end
end

function StringDrawSystem:getRequiredComponents()
    return {"PositionComponent", "StringComponent"}
end