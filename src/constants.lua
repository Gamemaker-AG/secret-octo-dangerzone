local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()
local smallerDimension = sw < sh and sw or sh

function percentToPixels(percent)
    return percent * smallerDimension/100
end

local constants = {
    screenWidth = sw,
    screenHeight = sh,
    player = {
        diameter = percentToPixels(20),
        defaultAcceleration = percentToPixels(100),
        defaultRotationSpeed = math.pi*3/2,
        maxSpeed = percentToPixels(60)
    },
    enemy = {
        diameter = percentToPixels(4),
        defaultAcceleration = percentToPixels(30),
        defaultRotationSpeed = math.pi,
    },
    turret = {
        diameter = percentToPixels(4),
        defaultRotationSpeed = math.pi*2,
    },
    bullet = {
        diameter = percentToPixels(3),
        speed = percentToPixels(100)
    },
    rocket = {
        diameter = percentToPixels(2),
        speed = percentToPixels(50),
        traillength = percentToPixels(50)
    },
    camera = {
        -- between 0 and 1
        speed = 0.15
    },
    waves = {
        -- time between waves in seconds
        timer = 5
    },
    gameplay = {
        --distance to player at which projectiles get deleted automatically
        debrisMaxDistance = 2000
    }
}

constants.enemy.maxSpeed = constants.player.maxSpeed / 5

return constants
