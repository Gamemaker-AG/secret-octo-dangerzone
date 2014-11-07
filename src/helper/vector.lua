Vector = class("Vector")

function Vector:__init(x, y)
    self.x = x 
    self.y = y
end

function Vector:getUnit(vector)
    sum = vector.x + vector.y 
    unitVector = Vector()
    unitVector.x = vector.x / sum
    unitVector.y = vector.y / sum
    return unitVector
end

function Vector:makeUnit(vector)
    sum = self.x + self.y 
    self.x = self.x / sum
    self.y = self.y / sum
end

function Vector:sum()
    return self.x + self.y
end

function Vector:getRadian()
    return math.atan( self.y, self.x )
end

function Vector:add(vector)
    if type(operator) == "number" then
        self.x = self.x + operator
        self.y = self.y + operator
    elseif type(operator) == "table" then
        self.x = self.x + operator.x
        self.y = self.y + operator.y
    end
end

function Vector:subtract(vector)
    if type(operator) == "number" then
        self.x = self.x - operator
        self.y = self.y - operator
    elseif type(operator) == "table" then
        self.x = self.x - operator.x
        self.y = self.y - operator.y
    end
end

function Vector:multiply(operator)
    if type(operator) == "number" then
        self.x = self.x * operator
        self.y = self.y * operator
    elseif type(operator) == "table" then
        self.x = self.x * operator.x
        self.y = self.y * operator.y
    end
end

function Vector:divide(operator)
    if type(operator) == "number" then
        self.x = self.x / operator
        self.y = self.y / operator
    elseif type(operator) == "table" then
        self.x = self.x / operator.x
        self.y = self.y / operator.y
    end
end

function Vector:rotate(radian)
    local x, y
    x = self.x * math.cos(radian) - self.y * math.sin(radian)
    y = self.x * math.sin(radian) + self.y * math.cos (radian)
    self.x = x 
    self.y = y 
    self:makeUnit()
end

return Vector
