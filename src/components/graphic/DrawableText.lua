local DrawableText = class("DrawableText", Component)

function DrawableText:__init(font, color, string, values)
    self.font = font or resources.fonts.regular
    self.string = string
    self.color = color or {255, 255, 255}
    self.values = values or {}
    self.visible = true
end

return DrawableText
