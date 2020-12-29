Grid = Class {}

--setting the tiles for the grid
EMPTY_TILE = 0
SNAKE_TILE = 1
BODY_TILE = 2
APPLE = 3

function Grid:init()
    --create the tileGrid structure
    tileGrid = {}
    self:initialize()
end 

function Grid:render()
    for y = 1, MAX_TILES_Y do
        for x = 1, MAX_TILES_X do
            if tileGrid[y][x] == APPLE then
                --setting the color of the apple to red and drawing it
                love.graphics.setColor(1, 0, 0 ,1)
                love.graphics.rectangle('fill', (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE, TILE_SIZE, TILE_SIZE)
            elseif tileGrid[y][x] == SNAKE_TILE then 
                --setting a green color for the snake head and drawing it
                love.graphics.setColor(0, 1, 0.5 ,1)
                love.graphics.rectangle('fill', (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE, TILE_SIZE, TILE_SIZE)
            elseif tileGrid[y][x] == BODY_TILE then 
                --setting a dark green color for the snake body and drawing it
                love.graphics.setColor(0, 0.5, 0 ,1)
                love.graphics.rectangle('fill', (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE, TILE_SIZE, TILE_SIZE)
            elseif tileGrid[y][x] == EMPTY_TILE then
                --setting the white color to the Grid and drawing it
                --love.graphics.setColor(1, 1, 1,1)
                --love.graphics.rectangle('line', (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE, TILE_SIZE, TILE_SIZE)
            end

        end
    end
end

function Grid:initialize()
    --initialize all the grid tiles with empty cells
    for y = 1, MAX_TILES_Y do

        table.insert(tileGrid, {})
        for x = 1, MAX_TILES_X do
            table.insert(tileGrid[y], EMPTY_TILE)
        end
    end
    generateApple()
end