-- Core
local Vector = require("helper/Vector")
local constants = require("constants")

-- Graphic components
local Drawable = require("components/graphic/Drawable")

-- Physic components
local Moving = require("components/physic/Moving")
local Rotating = require("components/physic/Rotating")
local Accelerating = require("components/physic/Accelerating")
local Transformable = require("components/physic/Transformable")

-- Gameplay components
local Living = require("components/gameplay/Living")
local Weapon = require("components/gameplay/Weapon")
local Faction = require("components/gameplay/Faction")
local MovingTo = require("components/gameplay/MovingTo")
local LookingAt = require("components/gameplay/LookingAt")
local ExplodesOnContact = require("components/gameplay/ExplodesOnContact")
local Wave = require("components/gameplay/Wave")

local Bullet = require("models/BulletModel")
local Rocket = require("models/RocketModel")
local Player = require("models/PlayerModel")

local EnemyModel = class("EnemyModel", Entity)

function EnemyModel:__init(x, y)
    self:add(Transformable(Vector(x, y), Vector(1, 0)))
    self:add(Moving(Vector(0,0), constants.enemy.maxSpeed))
    self:add(Rotating(constants.enemy.defaultRotationSpeed))
    self:add(Accelerating(constants.enemy.defaultAcceleration, Vector(0,0)))
    self:add(LookingAt())
    self:add(Living(20))
    self:add(MovingTo())
    self:add(Faction("enemy", {player=1}))
    self:add(Wave())

    local player = table.find(stack:current().engine:getEntityList("Faction"), function(i, entity)
        return entity:get("Faction").faction == "player"
    end)
    if player then self:add(ExplodesOnContact(player, constants.player.diameter/2)) end

    local func = function(entity, target)
        -- stack:current().engine:addEntity(Bullet(entity:get("Transformable").position, target))
        stack:current().engine:addEntity(Bullet(entity:get("Transformable").position, target))
    end
    --||-- Why no constants? fire, damage, cooldown, range, target
    self:add(Weapon(func, 10, 2, 2000, nil))

    local ship = resources.images.enemy
    local sx, sy = constants.enemy.diameter/ship:getWidth(), constants.enemy.diameter/ship:getHeight()
    local ox, oy = ship:getWidth()/2, ship:getHeight()/2
    self:add(Drawable(ship, 0, sx, sy, ox, oy))
end

return EnemyModel
