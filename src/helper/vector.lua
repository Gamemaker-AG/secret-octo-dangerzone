local Vector = class("Vector")

function Vector:__init(x, y)
    self.x = x or 0
    self.y = y or 0
end

function Vector:set(x, y)
    if type(x) == "number" and type(y) == "number"then
        self.x = x
        self.y = y
    elseif x.__name == "Vector" then
        self.x = x.x
        self.y = x.y
    end
end

function Vector:clone()
    return Vector(self.x,self.y)
end

function Vector:getUnit()
    local sum = self:sum()
    return Vector(self.x/sum, self.y/sum)
end

function Vector:sum()
    return math.abs(self.x) + math.abs(self.y)
end

function Vector:getRadian()
    return math.atan2( self.y, self.x )
end

function Vector:add(vector)
    if type(vector) == "number" then
        return Vector(self.x + vector, self.y + vector)
    elseif vector.__name == "Vector" then
        return Vector(self.x + vector.x, self.y + vector.y)
    end
end

function Vector:subtract(vector)
    if type(vector) == "number" then
        return Vector(self.x - vector, self.y - vector)
    elseif vector.__name == "Vector" then
        return Vector(self.x - vector.x, self.y - vector.y)
    end
end

function Vector:multiply(vector)
    if type(vector) == "number" then
        return Vector(self.x * vector, self.y * vector)
    elseif vector.__name == "Vector" then
        return Vector(self.x * vector.x, self.y * vector.y)
    end
end

function Vector:divide(vector)
    if type(vector) == "number" then
        return Vector(self.x / vector, self.y / vector)
    elseif vector.__name == "Vector" then
        return Vector(self.x / vector.x, self.y / vector.y)
    end
end

function Vector:rotate(radian)
    local x, y
    x = self.x * math.cos(radian) - self.y * math.sin(radian)
    y = self.x * math.sin(radian) + self.y * math.cos (radian)
    return Vector(x, y):getUnit()
end

function Vector:eq(vector)
    if type(vector) == "table" then
        return vector.x == self.x and vector.y == self.y
    end
    return false
end

return Vector
