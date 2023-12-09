local lspconfig = require("lspconfig")
lspconfig.rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {},
	},
})

lspconfig.lua_ls.setup({})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})
