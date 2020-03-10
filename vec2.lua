vec2 = {}
local vec2_mt = {}
vec2_mt.__index = vec2_mt

function vec2_mt:__add( v )
	return vec2(self.x + v.x, self.y + v.y)
end

function vec2_mt:__sub( v )
	return vec2(self.x - v.x, self.y - v.y)
end

function vec2_mt:__mul( v )
	if type(v) == "table"
	then return vec2(self.x * v.x, self.y * v.y)
	else return vec2(self.x * v, self.y * v) end
end

function vec2_mt:__div( v )
	if type(v) == "table"
	then return vec2(self.x / v.x, self.y / v.y)
	else return vec2(self.x / v, self.y / v) end
end

function vec2_mt:__unm()
	return vec2(-self.x, -self.y)
end

function vec2_mt:dot( v )
	return self.x * v.x + self.y * v.y
end

function vec2_mt:length()
	return math.sqrt(self.x * self.x + self.y * self.y)
end

function vec2_mt:normalize()
	local length = self:length()
	if length == 0 then
		return vec2(0, 0)
	end
	return vec2(self.x / length, self.y / length)
end

function vec2_mt:rotate(angle)
	local cs = math.cos(angle)
	local sn = math.sin(angle)
	return vec2(
			self.x * cs - self.y * sn,
			self.x * sn + self.y * cs)
end

function vec2_mt:__tostring()
	return ("(%g | %g)"):format(self.x, self.y)
end

setmetatable( vec2, {
	__call = function( V, x ,y )
		return setmetatable( {x = x or 0, y = y or 0}, vec2_mt )
	end
} )

return vec2
