vec3 = {}
local vec3_mt = {}
vec3_mt.__index = vec3_mt

function vec3_mt:__add( v )
	return vec3(self.x + v.x, self.y + v.y, self.z + self.z)
end

function vec3_mt:__sub( v )
	return vec3(self.x - v.x, self.y - v.y, self.z - self.z)
end

function vec3_mt:__mul( v )
	if type(v) == "table"
	then return vec3(self.x * v.x, self.y * v.y, self.z * v.z)
	else return vec3(self.x * v, self.y * v, self.z * v) end
end

function vec3_mt:__div( v )
	if type(v) == "table"
	then return vec3(self.x / v.x, self.y / v.y, self.z / v.z)
	else return vec3(self.x / v, self.y / v, self.z / v) end
end

function vec3_mt:__unm()
	return vec3(-self.x, -self.y, -self.z)
end

function vec3_mt:dot( v )
	return self.x * v.x + self.y * v.y + self.z * v.z
end

function vec3_mt:length()
	return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
end

function vec3_mt:normalize()
	local length = self:length()
	if length == 0 then
		return vec3(0, 0)
	end
	return vec3(self.x / length, self.y / length, self.z / length)
end

function vec3_mt:min(v)
	if type(v) == "table"
	then return vec3(math.min(self.x, v.x), math.min(self.y, v.y), math.min(self.z, v.z))
	else return math.min(self.x, math.min(self.y, self.z)) end
end

function vec3_mt:max(v)
	if type(v) == "table"
	then return vec3(math.max(self.x, v.x), math.max(self.y, v.y), math.max(self.z, v.z))
	else return math.max(self.x, math.max(self.y, self.z)) end
end

function vec3_mt:__tostring()
	return ("(%g | %g | %g)"):format(self:tuple())
end

function vec3_mt:tuple()
	return self.x, self.y, self.z
end

setmetatable( vec3, {
	__call = function( V, x, y, z )
		return setmetatable( {x = x or 0, y = y or x or 0, z = z or y or x or 0}, vec3_mt )
	end
} )

return vec3
