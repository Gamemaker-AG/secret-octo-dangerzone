local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()
local smallerDimension = sw < sh and sw or sh

function percentToPixels(percent)
    return percent * smallerDimension/100
end

constants = {
    screenWidth = sw,
    screenHeight = sh,
    player = {
        diameter = percentToPixels(15),
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
        name = "Basic Turret",
        description = "Might as well be your grandpas weapon. Fires bullets.",
        diameter = percentToPixels(4),
        defaultRotationSpeed = math.pi*2,
    },
    collectible = {
        diameter = percentToPixels(20),
        defaultAcceleration = percentToPixels(200),
        maxSpeed = percentToPixels(60)
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
    spaceStation = {
        radius = percentToPixels(10), 
    },
    camera = {
        -- between 0 and 1
        speed = 0.15
    },
    waves = {
        -- time between waves in seconds
        timer = 1
    },
    gameplay = {
        --distance to player at which projectiles get deleted automatically
        debrisMaxDistance = 2000
    }
}

constants.enemy.maxSpeed = constants.player.maxSpeed / 5
