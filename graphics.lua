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
		draw_body(body)
		-- local body_pos = vec2(body:getPosition())
		-- love.graphics.setColor(.2, .3, i * .3)
		-- love.graphics.circle('fill', body_pos.x, body_pos.y, .5)
		-- i = i + 1
	end)

	iterator(inext(), walls):each(function(wall) wall:draw() end)
	iterator(inext(), traps):each(function(trap) trap:draw() end)
	player:draw()
end

local function create_circle_shape(point_count, angle, color, radius, radius2)
	color = color or vec3(1)
	radius = radius or 1
	radius2 = radius2 or vec2(1)
	local radians = angle and angle * math.pi * 2 or 0
	local vertices = {}
	range(1, point_count):each(function(i)
		table.insert(vertices, {
			-- position
			math.cos(radians) * (
				type(radius) == 'number' and radius or
				type(radius) == 'function' and radius(radians).x or
				radius[i]
				) * radius2.x,
			math.sin(radians) * (
				type(radius) == 'number' and radius or
				type(radius) == 'function' and radius(radians).y or
				radius[i]
				) * radius2.y,

			-- uv
			0,
			0,

			-- color (rgba)
			color.x,
			color.y,
			color.z,
			1
		})
		radians = radians + math.pi * 2. / point_count
	end)
	return vertices
end

function draw_rectangle(pos, radius, angle)
	radius = radius or vec2(.5)
	angle = angle or 0
	if not mesh then
		local vertices = create_circle_shape(4, 1 / 8, nil, math.sqrt(2))
		mesh = love.graphics.newMesh(vertices)
	end

	love.graphics.draw(mesh, pos.x, pos.y, angle, radius.x, radius.y)
end

function draw_circle(pos, radius, angle)
	pos = pos or vec2(0)
	radius = radius or .5
	angle = angle or 0

	love.graphics.setColor(.5, .5, .5)
	love.graphics.circle('fill', pos.x, pos.y, radius)
	love.graphics.setColor(.2, .2, .3)
	draw_rectangle(pos, vec2(.2), angle)
end

function draw_polygon(polygon, pos, angle, scale, color)
	pos = pos or vec2(0)
	angle = angle or 0
	scale = scale or vec2(1)
	color = color or vec3(1)

	local triangles = love.math.triangulate(polygon:getPoints())
	local vertices = {}
	iterator(inext(), triangles):each(function(t)
		local points = {vec2(t[1], t[2]), vec2(t[3], t[4]), vec2(t[5], t[6])}
		iterator(inext(), points):each(function(position)
			table.insert(vertices, {
				-- position
				position.x,
				position.y,

				-- uv
				0,
				0,

				-- color (rgba)
				color.x,
				color.y,
				color.z,
				1
			})
		end)
	end)

	local mesh = love.graphics.newMesh(vertices)
	love.graphics.draw(mesh, pos.x, pos.y, angle, scale.x, scale.y)
end

function draw_body(body)
	local body_pos = vec2(body:getPosition())
	iterator(inext(), body:getFixtures())
		:map(function(fixture) return fixture:getShape() end)
		:each(function(shape)
			local kind = shape:getType()

			if kind == 'circle' then
				local pos = body_pos + vec2(shape:getPoint())
				draw_circle(pos, shape:getRadius(), body:getAngle())

			elseif kind == 'polygon' then
				local pos = body_pos
				local angle = body:getAngle()
				draw_polygon(shape, pos, angle)

			else
				print('draw_body(): unknown shape')
			end
		end)
end
