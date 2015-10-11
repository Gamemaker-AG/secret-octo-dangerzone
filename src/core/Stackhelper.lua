StackHelper = class("StackHelper")

function StackHelper:initialize()
    self.states = {}
    self.backCounter = 0
end


function StackHelper:current()
    if #self.states == 0 then return nil
    
    elseif #self.states > 0 then
        return self.states[#self.states]
    end
end


function StackHelper:push(element)
    table.insert(self.states, element)
    self:current():load()   
end


function StackHelper:pop()
    if self:current() then 
        table.remove(self.states, #self.states)
    end
end

function StackHelper:popload()
    if self:current() then
        table.remove(self.states, #self.states)
    end
    self:current():load()
end
 

function StackHelper:draw()
    for i = 0, #self.states-1 , 1 do
        if self.states[#self.states-i].renderBelow == false then
            break
        elseif self.states[#self.states-i].renderBelow == true then
            self.backCounter = i
        end
    end
    for i = self.backCounter, 0 , -1 do
        self.states[#self.states-i]:draw() 
    end 
end


function StackHelper:update(dt)
    if self:current() then self:current():update(dt) end
end