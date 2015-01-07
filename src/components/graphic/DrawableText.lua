local DrawableText = class("DrawableText", Component)

function DrawableText:__init(font, color,string, values) 
    self.font = font
    self.string = string
    self.color = color
    self.values = values
    self.visible = true
end

return DrawableText
