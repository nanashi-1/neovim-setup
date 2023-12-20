local map = vim.keymap.set

map("n", "<C-h>", ":wincmd h<CR>")
map("n", "<C-j>", ":wincmd j<CR>")
map("n", "<C-k>", ":wincmd k<CR>")
map("n", "<C-l>", ":wincmd l<CR>")
map("n", "<C-w>", ":q<CR>")

map("n", "<tab>", ":bnext<CR>")
map("n", "<leader>x", ":bdelete<CR>:bnext<CR>")

map({ "n", "i", "v" }, "<C-s>", ":w<CR>")
map("n", "<leader>pf", ":Telescope find_files<CR>")
map("n", "<leader>pb", ":Telescope buffers<CR>")
map("n", "<leader>e", ":NvimTreeToggle<CR>")
map("n", "<leader>pg", ":LazyGit<CR>")
map({ "n" }, "<leader>fm", function()
	vim.lsp.buf.format({ async = true })
end)
