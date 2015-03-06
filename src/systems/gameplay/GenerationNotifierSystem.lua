local GenerationNotifierSystem = class("GenerationNotifierSystem", System)

function GenerationNotifierSystem:__init(x, y)
    self.x = x
    self.y = y
end

function GenerationNotifierSystem:update(dt)
    local camera = table.firstElement(self.targets)
end

function GenerationNotifierSystem:requires()
    return {player = {"Player"}, camera = {"Camera"}}
end


return GenerationNotifierSystem
