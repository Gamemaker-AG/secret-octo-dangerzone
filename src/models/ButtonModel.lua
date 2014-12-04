local Clickable = require("components/ui/Clickable")
local Drawable = require("components/graphic/Drawable")
local Transformable = require("components/physic/Transformable")
local Diameter = require("components/physic/Diameter")

local ButtonModel = class("ButtonModel", Entity)

function ButtonModel:__init(offset, parent)
    self:add(Clickable(function() print("click") end))
    local img = resources.images.circle
    local sx,sy = 40/img:getWidth(), 40/img:getHeight()
    self:add(Drawable(img, 500, sx, sy, img:getWidth()/2, img:getHeight()/2))
    self:add(Transformable(offset, nil, parent))
    self:add(Diameter(40))
end

return ButtonModel
