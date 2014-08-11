Vector = class("Vector")

function Vector:__init(x, y)
    self.x = x
    self.y = y
end

function Vector:add(vector)
    self.x = self.x + vector.x
    self.y = self.y + vector.y
end

function Vector:sub(vector)
    self.x = self.x - vector.x
    self.y = self.y - vector.y
end

function Vector:getNorm()
    local total = self.x + self.y
    return self.x/total, self.y/total
end

function table.add(table1, table2)
    for index, value in pairs(table1) do
        value = value + table[index]
    end
end
