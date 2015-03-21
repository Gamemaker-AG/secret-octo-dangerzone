local generateStar = require("generators/stars")

local MapGenerationSystem = class("MapGenerationSystem", System)

function MapGenerationSystem:__init()
	self.tileSize = 128
	self.tileScope = 2
end

function MapGenerationSystem:update(dt)
    if not self.player then
    	self.player = table.firstElement(self.targets)
    	self.lastTile = self:getCurrentTile()
        self:initializeMap()
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

function MapGenerationSystem:getCurrentTile()
	local playerPosition = self.player:get("Transformable").offset
	return playerPosition:subtract(playerPosition:modulo(self.tileSize)):divide(self.tileSize)
end

function MapGenerationSystem:generateRow(root, size)
    for x=0, size.x, 1 do
        for y=0, size.y, 1 do
            generateStar(root:add(Vector(x, y)):multiply(self.tileSize), self.tileSize)
        end
    end
end

function MapGenerationSystem:initializeMap()

end

function MapGenerationSystem:requires()
    return {"Player"}
end

return MapGenerationSystem
