BallObject = class('BallObject', Base):include(Stateful)
BallObject.static.RADIUS_RATIO = 40
BallObject.static.MASS = 0.1
BallObject.static.LINEAR_DAMPING = 0.8
BallObject.static.instances = {}

function BallObject:initialize(x, y)
  Base.initialize(self)

  self.image = game.preloaded_images["ball.png"]
  local radius = g.getHeight() / BallObject.RADIUS_RATIO
  self.width, self.height = radius * 2, radius * 2

  self.controlled_objects_touching = {}

  self.body = love.physics.newBody(World, x, y, "dynamic")
  self.shape = love.physics.newCircleShape(radius)
  self.fixture = love.physics.newFixture(self.body, self.shape)

  self.fixture:setUserData(self)
  self.fixture:setRestitution(0.1)
  self.fixture:setFriction(1)

  self.body:setLinearDamping(BallObject.LINEAR_DAMPING)
  self.body:setAngularDamping(100)
  self.body:setMass(BallObject.MASS)

  BallObject.instances[self.id] = self
end

function BallObject:destroy()
  BallObject.instances[self.id] = nil
  self.body:destroy()
end

function BallObject:update(dt)
end

function BallObject:render()
  local x, y = self.body:getPosition()
  local w, h = self.width, self.height
  local iw, ih = self.image:getWidth(), self.image:getHeight()
  local sx, sy = w / iw, h / ih

  g.setColor(COLORS.blue:rgb())
  g.circle("fill", x, y, self.shape:getRadius())
  g.setColor(COLORS.black:rgb())
  g.circle("line", x, y, self.shape:getRadius())

  g.setColor(COLORS.white:rgb())
  g.draw(self.image, x, y, 0, sx, sy, iw / 2, ih / 2)
end

function BallObject:mousepressed(x, y, button)
end

function BallObject:mousereleased(x, y, button)
end

function BallObject:keypressed(key, unicode)
end

function BallObject:keyreleased(key, unicode)
end

function BallObject:joystickpressed(joystick, button)
end

function BallObject:joystickreleased(joystick, button)
end
