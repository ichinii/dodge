require 'vec2'
require 'iterator'

local physics_mt = {}
physics_mt.__index = physics_mt

local function begin_contact(f1, f2, contact)
	-- local enum1 = f1:getUserData()
	-- local enum2 = f2:getUserData()
	-- if enum1 and enum2 then
	-- 	if enum1 == 'player' and enum2 == 'enemy'
	-- 	or enum2 == 'player' and enum1 == 'enemy'
	-- 	then reset_game() end
	-- end
	-- print('begin_contact', f1, f2, contact)
end

local function end_contact(f1, f2, contact)
	-- print('end_contact', f1, f2, contact)
end

local function pre_solve_contact(f1, f2, contact)
	-- print('pre_solve_contact', f1, f2, contact)
end

local function post_solve_contact(f1, f2, contact, n1, t1)
	-- print('post_solve_contact', f1, f2, contact, n1, t1)
end

function reset_physics()
	physics = {}
	physics.world = love.physics.newWorld(0, 0)
	physics.world:setCallbacks(begin_contact, end_contact, pre_solve_contact, post_solve_contact)

	setmetatable(physics, physics_mt)
end

function physics_mt:create_rectangle(pos, size, kind, enum)
	size = size or vec2(1)
	kind = kind or 'static'
	local body = love.physics.newBody(self.world, pos.x, pos.y, kind)
	local shape = love.physics.newRectangleShape(size.x, size.y)
	local fixture = love.physics.newFixture(body, shape, 1)
	fixture:setUserData(enum)
	return body
end

function physics_mt:create_circle(pos, radius, kind, enum)
	kind = kind or 'static'
	local body = love.physics.newBody(self.world, pos.x, pos.y, kind)
	local shape = love.physics.newCircleShape(radius)
	local fixture = love.physics.newFixture(body, shape, 1)
	fixture:setUserData(enum)
	return body
end

function physics_mt:update(dt)
	self.world:update(dt)
end
