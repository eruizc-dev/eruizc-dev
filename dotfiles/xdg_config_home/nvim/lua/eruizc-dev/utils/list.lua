-- Joins two or more lists into one list, also accepts items that are not lists
local function join(...)
	local result = {}
	for i = 1, select("#", ...) do
		local arg = select(i, ...)
		if type(arg) ~= "table" then
			arg = { arg }
		end

		vim.list_extend(result, arg)
	end
	return result

end

return { join = join }
