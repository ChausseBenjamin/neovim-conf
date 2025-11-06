require('core.tools')

-- Utility for my plugin development workflow
function DevPack(repo)
	local name = repo:match('.+/(.+)$')
	local local_path = vim.fn.expand('~/Workspace/plugins/' .. name)

	if vim.fn.isdirectory(local_path) == 1 then
		vim.opt.runtimepath:prepend(local_path)
	else
		vim.pack.add({ { src = GH .. repo } })
	end
end

function P(v)
	print(vim.inspect(v))
	return v
end

function R(name)
	require('plenary.reload').reload_module(name)
	return require(name)
end
