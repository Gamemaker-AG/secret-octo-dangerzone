local Clickable = require("components/ui/Clickable")
local Drawable = require("components/graphic/Drawable")
local Transformable = require("components/physic/Transformable")
local Diameter = require("components/physic/Diameter")

local function createButtonComponents(fn, img, offset, diameter)
    local comps = {}

    table.insert(comps, Clickable(fn))

    local img = img or resources.images.circle
    table.insert(comps, Drawable(img, 500, nil, nil, img:getWidth()/2, img:getHeight()/2))

    table.insert(comps, Transformable(offset, nil, false))
    table.insert(comps, Diameter(diameter or img:getWidth()))

    return comps
end

return createButtonComponents
