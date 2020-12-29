--importing the Class Library
Class =  require 'class'
--importing objects
require 'snake'
require 'grid'
require 'GUI'
--Window dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--grid informations
TILE_SIZE = 16
MAX_TILES_X = WINDOW_WIDTH / TILE_SIZE
MAX_TILES_Y = WINDOW_HEIGHT / TILE_SIZE

--Setting fonts
LARGE = love.graphics.newFont(16)
MENU = love.graphics.newFont(96)

function love.load ()
    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,
    })
    math.randomseed(os.time())
    grid = Grid()
    snake = Snake(1,1)
    gui = GUI() 
    sounds = {
    ['apple_eat'] = love.audio.newSource('assets/sounds/apple_eat.wav', 'static'),
    ['death'] = love.audio.newSource('assets/sounds/death.wav', 'static'),
    ['music'] = love.audio.newSource('assets/sounds/music.mp3', 'static')
    }
end

--update the game. This function is called every frame
function love.update(dt)
    if gui.state == 'play' then
        snake:update(dt)
        snake:increaseLevel()
    end
end

--Whenever a key is pressed, this function is called
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == 'up' or key == 'down' or key == 'left' or key == 'right' then
        snake:changeDirection(key)
    end

    if key == 'return' then
        gui:changeState()
    end
end

function love.draw()
    gui:render()
    if gui.state ~= 'menu' then
        grid:render()
    end

end


function generateApple()
    --generating the first apple of the map
    local appleX, appleY
    repeat
        appleX, appleY = math.random(MAX_TILES_X), math.random(MAX_TILES_Y)
    until tileGrid[appleY][appleX] == EMPTY_TILE
    tileGrid[appleY][appleX] = APPLE
end