local generateStar = require("generators/stars")
local generateSpaceStation = require("generators/spaceStations")
local Debris = require("components/gameplay/Debris")
local Transformable = require("components/physic/Transformable")

-- Creates a weak entity for garbage collection 
local function createWeakTable()
    local table = {}
    setmetatable(table, {__mode = "v"})
    return table
end

local MapGenerationSystem = class("MapGenerationSystem", System)

function MapGenerationSystem:initialize()
    System.initialize(self)

	self.tileSize = 128
	self.tileScope = 2
    self.generatedTiles = {}
    self.firstRun = true
end

function MapGenerationSystem:update(dt)
    if self.firstRun then
    	self.lastTile = self:getCurrentTile()
        self:initializeMap()
        self.firstRun = false
    end
   	local currentTile = self:getCurrentTile()

   	if not self.lastTile:eq(currentTile) then
        local direction = currentTile:subtract(self.lastTile)
    	self.lastTile = currentTile
        local rowPositions = currentTile:add(direction:multiply(self.tileScope))
        if math.abs(direction.y) > 0 then
            local x = currentTile.x - self.tileScope
            self:generateRow(Vector(x, rowPositions.y), Vector(self.tileScope*2, 1))
        end
        if math.abs(direction.x) > 0 then
            local y = currentTile.y - self.tileScope
            self:generateRow(Vector(rowPositions.x, y), Vector(1, self.tileScope*2))
        end
    end
end

-- Gets the current tile the player is on
function MapGenerationSystem:getCurrentTile()
	local playerPosition = player:get("Transformable").offset
	return playerPosition:subtract(playerPosition:modulo(self.tileSize)):divide(self.tileSize)
end

-- 
function MapGenerationSystem:generateRow(root, size)
    for x=0, size.x, 1 do
        for y=0, size.y, 1 do
            local position = root:add(Vector(x, y))

            if not self.generatedTiles[position.x] then self.generatedTiles[position.x] = createWeakTable() end

            if not self.generatedTiles[position.x][position.y] then
                local absPosition = position:multiply(self.tileSize)
                generateStar(absPosition, self.tileSize)
                generateSpaceStation(absPosition, self.tileSize)

                -- Dummy entity to check wether we should regenerate this tile
                local debris = Entity()
                debris:add(Debris())
                debris:add(Transformable(absPosition))
                stack:current().engine:addEntity(debris)
                self.generatedTiles[position.x][position.y] = debris
            end
        end
    end
end

function MapGenerationSystem:initializeMap()
    -- TODO
end

return MapGenerationSystem
