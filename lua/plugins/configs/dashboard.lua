require("dashboard").setup({
	theme = "doom",
	config = {
		center = {
			{
				icon = ' ',
				desc = 'Find File',
				desc_hl = 'String',
				action = 'Telescope find_files'
			},
			{
				icon = ' ',
				desc = 'Open File Tree',
				desc_hl = 'String',
				action = 'NvimTreeToggle'
			}

		}
	},
	preview = {
		command = "~/.config/nvim/dashboard-cat.sh",
		file_path = "~/.config/nvim/dashboard.txt",
		file_height = 17,
		file_width = 84
	}
})
