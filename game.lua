require 'vec2'
require 'keyboard'
require 'entities'
require 'physics'
require 'player'

function reset_game()
	-- constants
	tile_world_size = vec2(16)

	-- reset
	reset_physics()
	player = create_player1(keyboard)

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
		create_wall(vec2(12, 10), vec2(1, 5)),
		create_wall(vec2(8, 12), vec2(3, 1))
	}
end

function love.update(dt)
	player:update(dt)
	iterator(inext(), traps):each(function(trap) trap:update(dt) end)
	physics:update(dt)
end
