GUI = Class {}

function GUI:init()
    self.state = 'menu'
end

function GUI:render()
    if self.state == 'menu' then
        self:menurender()
        sounds['music']:setLooping(true)
        sounds['music']:play()
    elseif self.state == 'play' then
        love.audio.stop(sounds['music'])
        self:renderScore()
    elseif self.state == 'gameover' then
        self:rendergameOver()
    end
end

--render score in the screen
function GUI:renderScore()
    love.graphics.setColor(1,1,1,1)
    love.graphics.setFont(LARGE)
    love.graphics.print("Score: " ..tostring(snake.score), WINDOW_WIDTH - 100, 10)
end


function GUI:menurender()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(MENU)
    love.graphics.print('SNAKE',WINDOW_WIDTH / 2 - 180, WINDOW_HEIGHT / 2 -98)
    love.graphics.setFont(LARGE)
    love.graphics.print('Developed by Gabriel Pina',10,10)
    if math.floor(love.timer.getTime()) % 2 == 1 then
        love.graphics.print('PRESS ENTER TO START',WINDOW_WIDTH / 2 - 110, WINDOW_HEIGHT / 2)
    end
end

function GUI:rendergameOver()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(MENU)
    love.graphics.print('GAME OVER',WINDOW_WIDTH / 2 - 280, WINDOW_HEIGHT / 2 -98)
    love.graphics.setFont(LARGE)
    love.graphics.print('PRESS ENTER TO RESTART',WINDOW_WIDTH / 2 - 110, WINDOW_HEIGHT / 2)
end

function GUI:changeState()
    if self.state == 'menu' then
        self.state = 'play'
    elseif self.state == 'gameover' then
        self.state = 'menu'
    end
end
