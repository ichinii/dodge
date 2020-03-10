require 'vec2'

local it_mt = {}
it_mt.__index = it_mt

function it_mt:__call()
	return self:f()
end

function it_mt:filter(f)
	
end

function it_mt:map(f)

end

function iterator(f)
	it = it or {}
	it.f = f or function() end
	return setmetatable(it, it_mt)
end

function range(from, to, step)
	step = step or 1
	from = from - 1
	return iterator(function()
		from = from + step
		if from <= to then return from end
	end)
end

function range2(corner1, corner2, step)
	step = step or 1
	local min_x, min_y = corner1:min(corner2):tuple()
	local max_x, max_y = corner1:max(corner2):tuple()
	local x = min_x
	local y = min_y - 1
	return iterator(function()
		y = y + 1
		if max_y < y then
			x = x + 1
			y = min_y
		end
		if x <= max_x then return x, y end
	end)
end
