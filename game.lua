require 'vec2'
require 'keyboard'
require 'entities'
require 'physics'

function reset_game()
	player_pos = vec2(1.5, 1.5)
	-- tile_world = {}
	tile_world_size = vec2(16)
	traps = iterator(inext(), {
		stepmove_trap(vec2(5, 5)),
		stepmove_trap(vec2(8, 12)),
		stepmove_trap(vec2(10, 10)),
		stepmove_trap(vec2(4, 9)),
		stepmove_trap(vec2(14, 5)),
		stepmove_trap(vec2(13, 12)),
		crossmove_trap(vec2(8, 8))
	}):table()
end

function love.update(dt)
	local dir = keyboard:dir():normalize()
	local speed = .1
	player_pos = player_pos + dir * speed

	iterator(inext(), traps):each(function(trap) trap:update(dt) end)

	collisions()
end
