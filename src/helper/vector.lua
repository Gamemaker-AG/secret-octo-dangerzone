local Vector = class("Vector")

function Vector:__init(x, y)
    self.x = x or 0
    self.y = y or 0
end

function Vector:getUnit(vector)
    sum = vector.x + vector.y 
    unitVector = Vector()
    unitVector.x = vector.x / sum
    unitVector.y = vector.y / sum
    return unitVector
end

function Vector:sum()
    return self.x + self.y
end

function Vector:getRadian()
    return math.atan( self.y, self.x )
end

function Vector:add(vector)
    if type(vector) == "number" then
        return Vector(self.x + vector, self.y + vector)
    elseif type(vector) == "table" then
        return Vector(self.x + vectory.x, self.y + vector.y)
    end
end

function Vector:subtract(vector)
    if type(vector) == "number" then
        return Vector(self.x - vector, self.y - vector)
    elseif type(vector) == "table" then
        return Vector(self.x - vector.x, self.y - vector.y)
    end
end

function Vector:multiply(vector)
    if type(vector) == "number" then
        return Vector(self.x * vector, self.y * vector)
    elseif type(vector) == "table" then
        return Vector(self.x * vector.x, self.y * vector.y)
    end
end

function Vector:divide(vector)
    if type(vector) == "number" then
        return Vector(self.x / vector, self.y / vector)
    elseif type(vector) == "table" then
        return Vector(self.x / vector.x, self.y / vector.y)
    end
end

function Vector:rotate(radian)
    local x, y
    x = self.x * math.cos(radian) - self.y * math.sin(radian)
    y = self.x * math.sin(radian) + self.y * math.cos (radian)
    return Vector(x, y):makeUnit()
end

return Vector
