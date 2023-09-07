local registry = require'mason-registry'

local function install_package(package)
	vim.notify(("[eruizc.utils.mason] installing `%s`"):format(package.name))
	return package:install():once('closed', vim.schedule_wrap(function()
		if package:is_installed() then
			vim.notify(("[eruizc.utils.mason] `%s` was successfully installed"):format(package.name))
		else
			vim.notify(("[eruizc.utils.mason] failed to install `%s`"):format(package.name), vim.log.levels.ERROR)
		end
	end)
	)
end

local function ensure_installed(packages)
	for _, package_name in ipairs(packages) do
		local exists, package = pcall(registry.get_package, package_name)
		if not exists then
			error(('Trying to install package `%s` that does not exist'):format(package_name))
		end

		if not package:is_installed() then
			install_package(package)
		end
	end
end

return { ensure_installed = ensure_installed }
