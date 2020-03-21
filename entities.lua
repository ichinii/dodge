require 'vec2'
require 'iterator'
require 'graphics'

local function axis_aligned_dir(dir)
	return math.abs(dir.x) < math.abs(dir.y) and vec2(0, dir.y) or vec2(dir.x, 0)
end

function create_wall(pos, size)
	local wall = {}
	wall.body = physics:create_rectangle(pos, size)
	wall.draw = function() draw_rect('fill', vec2(wall.body:getPosition()), size) end
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
	trap.draw = function() draw_rect('fill', vec2(trap.body:getPosition())) end
	return trap
end
