require 'vec2'
require 'keyboard'
require 'entities'
require 'physics'

function reset_game()
	-- constants
	tile_world_size = vec2(16)

	-- reset
	reset_physics()
	player = create_player2(keyboard)

	-- init
	-- traps = iterator(inext(), {
	-- 	stepmove_trap(vec2(5, 5)),
	-- 	stepmove_trap(vec2(8, 12)),
	-- 	stepmove_trap(vec2(10, 10)),
	-- 	stepmove_trap(vec2(4, 9)),
	-- 	stepmove_trap(vec2(14, 5)),
	-- 	stepmove_trap(vec2(13, 12))
	-- }):table()

	walls = {
		create_wall(vec2(13, 10), vec2(1, 1)),
		create_wall(vec2(13, 11), vec2(1, 1)),
		create_wall(vec2(13, 9), vec2(1, 1)),
		create_wall(vec2(13, 8), vec2(1, 1)),
		create_wall(vec2(13, 7), vec2(1, 1)),
		create_wall(vec2(8, 13), vec2(1, 1)),
		create_wall(vec2(7, 13), vec2(1, 1)),
		create_wall(vec2(9, 13), vec2(1, 1))
	}
end

function love.update(dt)
	player:update(dt)
	iterator(inext(), traps):each(function(trap) trap:update(dt) end)
	physics:update(dt)
end
