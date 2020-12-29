Snake = Class {}

function Snake:init(x,y)
    --getting all the information of the snake
    self.x = x
    self.y = y

    --initializating the direction and the timer of the snake
    self.direction = 'right'
    self.speed = 0.1
    self.timer = 0
    self.score = 0
    self.level = 1
    self.count = 5

    --initializating the snake head
    snakeTiles = {
        {self.x, self.y}
    }
    self:render()
end

function Snake:update(dt)
    self:checkTimer(dt)
end

--change the snake direction when an arrow key is pressed 
function Snake:changeDirection(key)
    if key == 'left' and self.direction ~= 'right' then
        self.direction = 'left'
    elseif key == 'right' and self.direction ~= 'left' then
        self.direction = 'right'
    elseif key == 'up' and self.direction ~= 'down' then
        self.direction = 'up'
    elseif key == 'down' and self.direction ~= 'up' then
        self.direction = 'down'
    end
end

--move the snake tiles when the time passes
function Snake:checkTimer(dt)
    self.timer = self.timer + dt
    if self.timer >= self.speed then
        self:move()
        self.timer = 0
    end
end

--function to move the snake
function Snake:move()
    local priorX, priorY = self.x, self.y
    self:newPosition()

    --push a new head element onto the snake data structure
    table.insert(snakeTiles, 1, {self.x, self.y})
    if not self:collides() then
        if self:checkEat() then
            sounds['apple_eat']:play()
            generateApple()
            self.score = self.score + 1
        else
            local tail = snakeTiles[#snakeTiles]
            tileGrid[tail[2]][tail[1]] = TILE_EMPTY
            table.remove(snakeTiles)
        end
        if #snakeTiles > 1 then

        -- set the prior head value to a body value
        tileGrid[priorY][priorX] = BODY_TILE
        end
        -- update the view with the next snake head location
        tileGrid[self.y][self.x] = SNAKE_TILE
    else
        sounds['death']:play()
        gui.state = 'gameover'
    end
end

--move the Snake Head
function Snake:newPosition()
    if self.direction == 'up' then
        if self.y <= 1 then
            self.y = MAX_TILES_Y
        else
            self.y = self.y - 1
        end
    elseif self.direction == 'down' then
        if self.y >= MAX_TILES_Y then
            self.y = 1
        else
            self.y = self.y + 1
        end
    elseif self.direction == 'left' then
        if self.x <= 1 then
            self.x = MAX_TILES_X
        else
            self.x = self.x - 1
        end
    elseif self.direction == 'right' then
        if self.x >= MAX_TILES_X then
            self.x = 1
        else
            self.x = self.x + 1
        end
    end
end

function Snake:render()
    tileGrid[self.y][self.x] = SNAKE_TILE
end

function Snake:checkEat()
    if tileGrid[self.y][self.x] == APPLE then
        return true
    else
        return false
    end
end

function Snake:collides()
    if tileGrid[self.y][self.x] == BODY_TILE then
        return true
    else
        return false
    end
end

function Snake:increaseLevel()
    if self.score == self.count then
        self.speed = self.speed * 0.8
        self.level = self.level + 1
        self.count = self.count * 2 + self.level
    end
end