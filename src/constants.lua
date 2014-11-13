local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()
local smallerDimension = sw < sh and sw or sh


local function pixels(percent)
    return percent * smallerDimension/100
end

local constants = {
    screenWidth = sw,
    screenHeight = sh,
    player = {
        width = pixels(20),
        height = pixels(20),
        defaultAcceleration = pixels(130),
        defaultRotationSpeed = math.pi*3/2,
        maxSpeed = pixels(50)
    },
    enemy = {
        width = pixels(15),
        height = pixels(15),
        defaultAcceleration = pixels(30),
        defaultRotationSpeed = math.pi,
        maxSpeed = pixels(50)
    }
}

return constants
