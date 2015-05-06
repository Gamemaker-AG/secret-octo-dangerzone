-- Core
local Vector = require("helper/Vector")
local constants = require("constants")

-- Graphic components
local Drawable = require("components/graphic/Drawable")
local Particle = require("components/particle/Particle")
local Muzzleparticles = require("components/graphic/Muzzleparticles")

-- Physic components
local Moving = require("components/physic/Moving")
local Rotating = require("components/physic/Rotating")
local Accelerating = require("components/physic/Accelerating")
local Transformable = require("components/physic/Transformable")
local Circle = require("components/physic/Circle")

-- Gameplay components
local Weapon = require("components/gameplay/Weapon")
local Controllable = require("components/gameplay/Controllable")
local Attitude = require("components/gameplay/Attitude")
local HasGold = require("components/gameplay/HasGold")
local Shield = require("components/gameplay/Shield")
local Hull = require("components/gameplay/Hull")
local Player = require("components/meta/Player")
local Inventory = require("components/gameplay/Inventory")
local createTurretCollection = require("collections/createTurretCollection")

function createPlayerCollection(entity)
    -- Physical components
    entity:add(Transformable(Vector(100, 100), Vector(1, 0)))
    entity:add(Moving(Vector(0,0), constants.player.maxSpeed))
    entity:add(Rotating(constants.player.defaultRotationSpeed))
    entity:add(Accelerating(constants.player.defaultAcceleration, Vector(0,0)))
    entity:add(Circle(constants.player.diameter/2))

    -- Meta components
    entity:add(Player())
    entity:add(Controllable())
    entity:add(Attitude({Pirate=1}))

    -- GamePlay components
    entity:add(Hull(200))
    entity:add(HasGold(0))
    entity:add(Shield(200, 5))
    entity:add(Inventory(createTurretCollection(Entity())))

    -- Graphic components
    entity:add(Muzzleparticles(100 ,500, 500, 3000))

        local ship = resources.images.player
        local ox, oy = ship:getWidth()*(2/3), ship:getHeight()/2
    entity:add(Drawable(ship, 1, sx, sy, ox, oy))

    -- Creating particle system
    entity:add(Particle(resources.images.particle1, 5000, Vector(-50, 0), {0.2, 1.2}, nil))

    -- Local variables for particle position calculation
    local particleComponent = entity:get("Particle")
    local particle = entity:get("Particle").particle
    local transformable = entity:get("Transformable")
    local radian = transformable.direction:getRadian()
    local rotatedOffset = particleComponent.offset:rotate(transformable.direction:getRadian()):add(transformable.position)

    -- Particle properties
    particle:setPosition(rotatedOffset.x, rotatedOffset.y)
    particle:setEmissionRate(1000)
    particle:setAreaSpread("normal",9,9)
    particle:setSpread(math.pi/40)
    particle:setParticleLifetime(0.01, 0.1)
    particle:setColors(--250,160,30,20,  --orange
                       --240,80,35,50,  --redish orange
                        --240,35,40,50,  --red
                        216,30,60,50, --greeeenish
                        --255,255,255,50, --white
                        200,0,255,50, --blueish purple
                        70,0,92,50, --dark purple
                        --0,0,0,100, --black
                        --255,255,255,20, --white
                        --20,20,150,50,  --blue
                        --2,125,200,50,  --light blue
                        --0,170,185,50,  --greenish blue
                        0,0,0,100 --black
                        --0,166,84,50   --light green
                        )    --light green
    particle:setSizes(1.5, 0.8, 0.1)
    particle:start()

    return entity
end

return createPlayerCollection
