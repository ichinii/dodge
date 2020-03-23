require 'vec2'
require 'iterator'
require 'graphics'

local function axis_aligned_dir(dir)
	return math.abs(dir.x) < math.abs(dir.y) and vec2(0, dir.y) or vec2(dir.x, 0)
end

function create_player1(controller)
	local player = {}
	player.controller = controller
	player.body = physics:create_circle(vec2(4, 4), .75, 'dynamic')
	player.tail = {player.body}
	range(1, 2):each(function(i)
		local body = physics:create_circle(vec2(5.25 + i * 2 - i * i, 4), .5, 'dynamic')
		local x1, y1 = player.tail[i]:getPosition()
		local x2, y2 = body:getPosition()
		love.physics.newDistanceJoint(player.tail[i], body, x1, y1, x2, y2)
		table.insert(player.tail, body)
	end)

	function player:update(dt)
		local speed = .3
		local dir = self.controller:dir():normalize() * speed
		self.body:setLinearVelocity((dir + vec2(self.body:getLinearVelocity())):tuple())
		-- self.body:setLinearVelocity((vec2(1 / .3 * 7) * dir):tuple())
	end

	player.draw = function(self)
		iterator(inext(), self.tail):each(function(body) draw_body(body) end)
	end
	return player
end

function create_player2(controller)
	local player = {}
	player.controller = controller
	player.body = physics:create_circle(vec2(4, 4), .5, 'dynamic')
	player.tail = {
		player.body,
		physics:create_rectangle(vec2(6, 4), vec2(1), 'dynamic', 1)
	}

	function player:update(dt)
		local speed = .3
		local dir = self.controller:dir():normalize() * speed
		self.body:setLinearVelocity((dir + vec2(self.body:getLinearVelocity())):tuple())
		-- self.body:setLinearVelocity((vec2(1 / .3 * 7) * dir):tuple())
	end

	player.draw = function(self)
		iterator(inext(), self.tail):each(function(body) draw_body(body) end)
	end
	return player
end

function create_wall(pos, size)
	local wall = {}
	wall.body = physics:create_rectangle(pos, size)
	wall.draw = function() draw_rectangle(vec2(wall.body:getPosition()), size * .5) end
	return wall
end

function stepmove_trap(pos)
	local trap = {}
	trap.body = physics:create_rectangle(pos, vec2(.5), 'dynamic', 'enemy')
	trap.body:setFixedRotation(true)
	local rand = math.random()
	function trap:update(dt)
		local trap_pos = vec2(trap.body:getPosition())
		local player_pos = vec2(player:getPosition())
		local dir = (player_pos - trap_pos):normalize()
		local aadir = axis_aligned_dir(dir)
		local angle = dir:dot(aadir)
		aadir = aadir * dt * 300

		if angle > .95 then
			trap.body:setLinearVelocity(aadir.x, aadir.y)
			-- trap.body:applyForce(aadir.x, aadir.y)
		else
			trap.body:setLinearVelocity(0, 0)
		end

		trap.angle = trap.body:getAngle()
	end
	trap.draw = function() draw_rectangle(vec2(trap.body:getPosition())) end
	return trap
end
