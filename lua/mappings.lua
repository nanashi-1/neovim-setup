local map = vim.keymap.set

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
	vim.lsp.buf.format({ async = true })
end)
