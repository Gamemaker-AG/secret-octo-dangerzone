local MapGenerationSystem = class("MapGenerationSystem", System)

function MapGenerationSystem:generateMap(event)
    local position = event.position
    local results = generateTiles(position, height, width)
    for i, v in ipairs(results) do
        local bgTile = Entity()
        bg:add(Transformable(Position(results[2])))
        bg:add(Drawable(results[1]))
        bg:add(Paralax())
    end
end

function generateTiles(position, height, width)
    local direction
    local tiles
    local tileSize = 128
    local subSize = 32
    if height > width then
        tiles = height/tileSize
    else
        tiles = width/tileSize
    end

    if height == tileSize and width == tileSize then
        direction = Vector(0, 0)
    elseif  math.abs(height) == tileSize then
        if width < 0  then
            direction = Vector(-tileSize, 0)
        elseif width > 0 then
            direction = Vector(tileSize, 0)
        end
    elseif  math.abs(width) == tileSize then
        if height < 0  then
            direction = Vector(0, -tileSize)
        elseif height > 0 then
            direction = Vector(0, tileSize)
        end
    end

    local canvasHeight, canvasWidth = height+subSize, width+subSize
    local tempCanvas = love.graphics.newCanvas()
    for i=0, i < tiles*(tileSize/subSize)+2, 1 do
        for j=0, j < tiles*(tileSize/subSize)+2, 1 do
            --Populate Canvas 
        end
    end
    
    local tempImageData = tempCanvas:getImageData()
    for i=0, i < tiles, 1 do
        -- Cut Picture into tiles
        local newPicture = Cutfunction(Vector(subSize, subSize):add(Vector(tileSize, 0):multiply(i)))
        local newPosition =  position:add(direction:multiply(i))
    end
end

