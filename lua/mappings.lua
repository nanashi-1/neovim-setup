local map = vim.keymap.set
local api = vim.api
local lsp = vim.lsp.buf
local diagnostic = vim.diagnostic

map("n", "<C-h>", "<cmd>wincmd h<cr>")
map("n", "<C-j>", "<cmd>wincmd j<cr>")
map("n", "<C-k>", "<cmd>wincmd k<cr>")
map("n", "<C-l>", "<cmd>wincmd l<cr>")
map("n", "<C-w>", "<cmd>q<cr>")

map("n", "<tab>", "<cmd>bnext<cr>")
map("n", "<leader>x", "<cmd>bdelete<cr><cmd>bnext<cr>")

map({ "n", "v", "i" }, "<C-s>", "<cmd>w<cr><esc>")

map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")

map("n", "<leader>pf", "<cmd>Telescope find_files<cr>")
map("n", "<leader>pb", "<cmd>Telescope buffers<cr>")
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
map("n", "<leader>pg", "<cmd>LazyGit<cr>")

map("n", "<leader>fm", function()
	lsp.format({ async = true })
end)


map('n', '<space>cd', diagnostic.open_float)
map('n', '[d', diagnostic.goto_prev)
map('n', ']d', diagnostic.goto_next)
map('n', '<space>q', diagnostic.setloclist)

api.nvim_create_autocmd('LspAttach', {
	group = api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		local opts = { buffer = ev.buf }
		map('n', 'gD', lsp.declaration, opts)
		map('n', 'gd', lsp.definition, opts)
		map('n', 'K', lsp.hover, opts)
		map('n', 'gi', lsp.implementation, opts)
		map('n', '<C-k>', lsp.signature_help, opts)
		map('n', '<space>wa', lsp.add_workspace_folder, opts)
		map('n', '<space>wr', lsp.remove_workspace_folder, opts)
		map('n', '<space>wl', function()
			print(vim.inspect(lsp.list_workspace_folders()))
		end, opts)
		map('n', '<space>D', lsp.type_definition, opts)
		map('n', '<space>rn', lsp.rename, opts)
		map({ 'n', 'v' }, '<space>ca', lsp.code_action, opts)
		map('n', 'gr', lsp.references, opts)
		map('n', '<space>f', function()
			lsp.format { async = true }
		end, opts)
	end,
})
