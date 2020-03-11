require 'vec2'
require 'keyboard'
require 'entities'
require 'physics'

function reset_game()
	player_pos = vec2(1.5, 1.5)
	-- tile_world = {}
	tile_world_size = vec2(16)
	traps = {}
	table.insert(traps, stepmove_trap(vec2(5, 5)))
	table.insert(traps, stepmove_trap(vec2(8, 6)))
	table.insert(traps, stepmove_trap(vec2(8, 12)))
	table.insert(traps, stepmove_trap(vec2(10, 10)))
	table.insert(traps, stepmove_trap(vec2(4, 9)))
	table.insert(traps, stepmove_trap(vec2(14, 5)))
	table.insert(traps, stepmove_trap(vec2(13, 12)))
	for _, trap in ipairs(traps) do
		trap.pos = trap.pos + vec2(.5)
	end
	table.insert(traps, crossmove_trap(vec2(8, 8)))
end

function love.update(dt)
	local dir = keyboard:dir():normalize()
	local speed = .1
	player_pos = player_pos + dir * speed

	iterator(inext(), traps):each(function(trap) trap:update(dt) end)
end
