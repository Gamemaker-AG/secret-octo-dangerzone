

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
local ExplodesOnContact = require("components/gameplay/ExplodesOnContact")
local Damaging = require("components/gameplay/Damaging")
-- Gameplay components
local Weapon = require("components/gameplay/Weapon")
local Controllable = require("components/gameplay/Controllable")
local Faction = require("components/gameplay/Faction")
local Camera = require("components/gameplay/Camera")

local Rocket = class("Rocket", Entity)

function Rocket:__init(pos, target, damage)
    self:add(Damaging(damage))
    self:add(ExplodesOnContact(target, 100))
    self:add(Transformable(pos:clone()))

    local particleComponent = Particle(resources.images.particle1, 5000, Vector(-10, 0), {0.2, 1.2}, nil)
    self:add(particleComponent)
    local particle = particleComponent.particle
    -- transform
    local transformable = self:get("Transformable")
    local radian = transformable.direction:getRadian()
    local rotatedOffset = particleComponent.offset:rotate(transformable.direction:getRadian()):add(transformable.position)
    local image = resources.images.rocket
    local sx, sy = constants.rocket.diameter/image:getWidth(), constants.rocket.diameter/image:getHeight()
    local ox, oy = image:getWidth()/2, image:getHeight()/2
    self:add(Drawable(image, 0, sx, sy, ox, oy))
    local direction = target:get("Transformable").position:subtract(pos):getUnit()
    self:add(Moving(direction:multiply(constants.rocket.speed)))
    self:get("Transformable").direction:set(direction)

    --particles
    particle:setPosition(rotatedOffset.x, rotatedOffset.y)
    particle:setEmissionRate(1000)
    particle:setAreaSpread("normal",3,3)
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
    self:add(Muzzleparticles(100 ,500, 500, 3000))
end

return Rocket
