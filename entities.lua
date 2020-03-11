require 'vec2'
require 'iterator'
require 'graphics'

function axis_aligned_dir(dir)
	return math.abs(dir.x) < math.abs(dir.y) and vec2(0, dir.y) or vec2(dir.x, 0)
end

function stepmove_trap(pos)
	local trap = {}
	trap.pos = pos or vec2()
	local rand = math.random()
	function trap:update(dt)
		local dir = (player_pos - trap.pos):normalize()
		local aadir = axis_aligned_dir(dir)
		local angle = dir:dot(aadir)

		if angle > .95 then
			trap.pos = trap.pos + aadir * dt * 10
		end

		if (player_pos - trap.pos):length() < .8 then
			reset_game()
		end
	end
	trap.draw = draw_stepmove_trap
	return trap
end

function crossmove_trap(pos)
	local trap = {}
	trap.pos = pos or vec2()
	local move_dir = nil
	function trap:update(dt)
		local dir = (player_pos - trap.pos):normalize()
		local aadir = axis_aligned_dir(dir)
		local angle = dir:dot(aadir)

		if move_dir then
			trap.pos = trap.pos + move_dir * dt * 7
		end

		if not move_dir and angle > .9 then
			move_dir = aadir
		end

		if trap.pos.x < 1 or trap.pos.y < 1 or trap.pos.x > tile_world_size.x - 1 or trap.pos.y > tile_world_size.y - 1 then
			if move_dir then
				trap.pos = trap.pos + move_dir * dt * -16
			end
			move_dir = nil
		end

		if (player_pos - trap.pos):length() < .8 then
			reset_game()
		end
	end
	trap.draw = draw_crossmove_trap
	return trap
end
