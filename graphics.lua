require 'vec2'
require 'vec3'
require 'iterator'

function love.draw()
	-- coordinate system. if scale = 1 then (0, 0) is at center; (w/h * .5, .5) is at top right corner
	local scale = 1 / tile_world_size.y
	local aspect_ratio = vec2(love.graphics.getDimensions()):div()
	love.graphics.origin()
	love.graphics.scale(vec2(love.graphics.getHeight() * scale):tuple())
	love.graphics.translate(vec2(aspect_ratio * .5 / scale + .5, .5 / scale + .5):tuple())
	love.graphics.scale(1, -1)
	-- love.graphics.translate((player_pos * -1):tuple())
	love.graphics.translate((vec2(tile_world_size.y * -.5)):tuple())

	for x, y in range2(vec2(1, 1), tile_world_size) do
		love.graphics.setColor(vec3(x % 2 == 0 and y % 2 == 0 and .15 or .1):tuple())
		love.graphics.rectangle('fill', x - 1 + .5, y - 1 + .5, 1, 1)
	end

	local i = 0
	love.graphics.setColor(vec3(.2, .4, .7):tuple())
	iterator(inext(), player.tail):each(function(body)
		local body_pos = vec2(body:getPosition())
		love.graphics.setColor(.2, .3, i * .3)
		love.graphics.circle('fill', body_pos.x, body_pos.y, .5)
		i = i + 1
	end)

	iterator(inext(), walls):each(function(wall) wall:draw() end)
	iterator(inext(), traps):each(function(trap) trap:draw() end)
end

function draw_rect(style, pos, size)
	size = size or vec2(1)
	love.graphics.rectangle(style, pos.x - size.x * .5, pos.y - size.y * .5, size.x, size.y)
end
