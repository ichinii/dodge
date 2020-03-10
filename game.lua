require 'vec2'
require 'keyboard'

function reset_game()
	player_pos = vec2(1.5, 1.5)
	tile_world = {}
	tile_world_size = vec2(16)
end

function love.update(dt)
	local dir = keyboard:dir():normalize()
	local speed = .1
	player_pos = player_pos + dir * speed
end
