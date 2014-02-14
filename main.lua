require("src.RC_Player")

function love.load()
  love.window.setMode(600, 400, {vsync=true, centered=true})
  love.graphics.setBackgroundColor(0, 102, 102)
  player = newPlayer(0, 0)
end

function love.update(dt)
  player:update(dt)

  if love.keyboard.isDown('space') then
    player:jump()
  end

  if love.keyboard.isDown('left') then
    player:move(-50*dt, 0)
  elseif love.keyboard.isDown('right') then
    player:move(50*dt, 0)
  end

  if love.keyboard.isDown('up') then
    player:move(0, -50*dt)
  elseif love.keyboard.isDown('down') then
    player:move(0, 50*dt)
  end
end

function love.draw()
  player:draw()
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end