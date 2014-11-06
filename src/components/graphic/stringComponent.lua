local StringComponent = class("StringComponent", Component)

function StringComponent:__init(font, color,string, values) 
    self.font = font
    self.string = string
    self.color = color
    self.values = values
end

return StringComponent
