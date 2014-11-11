local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()
local smallerDimension = sw < sh and sw or sh

print(sw, sh, smallerDimension)

local function pixels(percent)
    return percent * smallerDimension/100
end

local constants = {
    screenWidth = sw,
    screenHeight = sh,
    player = {
        width = pixels(20),
        height = pixels(20)
    }
}

return constants
