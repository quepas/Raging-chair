require("lib.AnAL")

local RC_Player = {}
RC_Player.__index = RC_Player

local img_walk = love.graphics.newImage("img/walk-sequence.png")

function newPlayer(x, y)
  local new = {}
  new.x = x
  new.y = y
  new.anim_walk = newAnimation(img_walk, 82, 119, 0.1, 0)
  new.img_stand = love.graphics.newImage("img/character-stand.png")
  new.img_jump = love.graphics.newImage("img/character-jump.png")
  new.look_direction = 'right'
  new.move_action = 'stand'
  new.jump_action = 'none'
  new.in_jump = false
  new.jump_start_y = y
  new.jump_factor = 2

  return setmetatable(new, RC_Player)
end

function RC_Player:move(x, y)
  self.move_action = 'walk'
  self.anim_walk:play()
  if x > 0 then
    self.look_direction = 'right'
  elseif x < 0 then
    self.look_direction = 'left'
  end

  local jump_factor = self.jump_factor
  if not self.in_jump then
    jump_factor = 1
  end

  self.x = self.x + x * jump_factor
  self.y = self.y + y * jump_factor
end

function RC_Player:jump()
  if not self.in_jump then
    self.move_action = 'jump'
    self.jump_action = 'up'
    self.in_jump = true
    self.jump_start_y = self.y
  end
end

function RC_Player:update_jump(dt)
  if self.in_jump then
    if self.jump_action == 'up' then
      self.y = self.y - 70*dt;
    elseif self.jump_action == 'down' then
      self.y = self.y + 140*dt;
    end

    if self.y <= self.jump_start_y - 30 then
      self.jump_action = 'down'
    end
    if self.jump_action == 'down' then
      if self.y >= self.jump_start_y then
        self.y = self.jump_start_y
        self.in_jump = false
      end
    end
  end
end

function RC_Player:update(dt)
  self.anim_walk:update(dt)
  self.anim_walk:stop()
  self:update_jump(dt)
  if not self.in_jump then
    self.move_action = 'stand'
  end
end

function RC_Player:draw()
  if self.move_action == 'walk' and not self.in_jump then
    if self.look_direction == 'right' then
      self.anim_walk:draw(self.x, self.y)
    elseif self.look_direction == 'left' then
      self.anim_walk:draw(self.x + 82, self.y, 0, -1, 1)
    end
  elseif self.in_jump then
    self:draw_based_on_look_direction(self.img_jump)
  elseif self.move_action == 'stand' then
    self:draw_based_on_look_direction(self.img_stand)
  end
end

function RC_Player:draw_based_on_look_direction(img)
  if self.look_direction == 'right' then
    love.graphics.draw(img, self.x, self.y)
  elseif self.look_direction == 'left' then
    love.graphics.draw(img, self.x + 82, self.y, 0, -1, 1)
  end
end