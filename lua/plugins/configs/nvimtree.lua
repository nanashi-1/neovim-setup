vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
	vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
end

require("nvim-tree").setup({
	on_attach = on_attach,
	sort_by = "case_sensitive",
	view = {
		width = 30
	},
	renderer = {
		group_empty = true,
	}
})
