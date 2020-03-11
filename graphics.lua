require 'vec2'
require 'vec3'
require 'iterator'

function love.draw()
	-- coordinate system. if scale = 1 then (0, 0) is at center; (w/h * .5, .5) is at top right corner
	local scale = 1 / tile_world_size.y
	local aspect_ratio = vec2(love.graphics.getDimensions()):div()
	love.graphics.origin()
	love.graphics.scale(vec2(love.graphics.getHeight() * scale):tuple())
	love.graphics.translate(vec2(aspect_ratio * .5 / scale, .5 / scale):tuple())
	love.graphics.scale(1, -1)
	-- love.graphics.translate((player_pos * -1):tuple())
	love.graphics.translate((vec2(tile_world_size.y * -.5)):tuple())

	for x, y in range2(vec2(1, 1), tile_world_size) do
		love.graphics.setColor(vec3(x % 2 == 0 and y % 2 == 0 and .15 or .1):tuple())
		love.graphics.rectangle('fill', x - 1, y - 1, 1, 1)
	end

	love.graphics.setColor(vec3(.2, .4, .7):tuple())
	love.graphics.circle('fill', player_pos.x, player_pos.y, .5)

	iterator(inext(), traps):each(function(trap) trap:draw() end)
end

function draw_stepmove_trap(trap)
	love.graphics.setColor(vec3(.7, .2, .4):tuple())
	love.graphics.rectangle('fill', trap.pos.x - .5, trap.pos.y - .5, 1, 1)
end

function draw_crossmove_trap(trap)
	love.graphics.setColor(vec3(.1, .5, .4):tuple())
	love.graphics.rectangle('fill', trap.pos.x - .5, trap.pos.y - .5, 1, 1)
end
