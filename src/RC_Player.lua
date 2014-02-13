require("lib/AnAL")

local RC_Player = {}
RC_Player.__index = RC_Player

function newPlayer(x, y)
  local new = {}
  new.x = x
  new.y = y
  new.img = love.graphics.newImage("img/walk-sequence.png")
  new.anim = newAnimation(new.img, 82, 119, 0.1, 0)
  new.walk_direction = 'right'

  return setmetatable(new, RC_Player)
end

function RC_Player:move(x, y)
  self.anim:play()
  if x > 0 then
    self.walk_direction = 'right'
  elseif x < 0 then
    self.walk_direction = 'left'
  end

  self.x = self.x + x
  self.y = self.y + y
end

function RC_Player:update(dt)
  self.anim:update(dt)
  self.anim:stop()
end

function RC_Player:draw()
  if self.walk_direction == 'right' then
    self.anim:draw(self.x, self.y)
  elseif self.walk_direction == 'left' then
    self.anim:draw(self.x + 82, self.y, 0, -1, 1)
  end
end
