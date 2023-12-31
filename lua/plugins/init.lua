require("lazy").setup({
	{
		"folke/tokyonight.nvim",
		lazy = false,
		init = function()
			vim.cmd("colorscheme tokyonight")
		end,
		opts = {
			style = "night",
		}
	},
	"nvim-lua/plenary.nvim",
	{
		"feline-nvim/feline.nvim",
		branch = "0.5-compat",
		lazy = false,
		config = function()
			require("plugins.configs.feline")
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"tree-sitter/tree-sitter-regex"
		},
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		config = function()
			require("plugins.configs.nvim-treesitter")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		ft = { "gitcommit", "diff" },
		init = function()
			vim.api.nvim_create_autocmd({ "BufRead" }, {
				group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
				callback = function()
					vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
					if vim.v.shell_error == 0 then
						vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
						vim.schedule(function()
							require("lazy").load({ plugins = { "gitsigns.nvim" } })
						end)
					end
				end,
			})
		end,
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
		config = function()
			require("mason").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("null-ls").setup()
				end
			},
			{
				"williamboman/mason-lspconfig.nvim" }
		},
		config = function()
			require("plugins.configs.lspconfig")
		end
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("luasnip").config.set_config(opts)
				end,
			},
			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)

					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},

			{
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
		},
		config = function()
			require("plugins.configs.cmp")
		end,
	},
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gcc", mode = "n",          desc = "Comment toggle current line" },
			{ "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
			{ "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
			{ "gbc", mode = "n",          desc = "Comment toggle current block" },
			{ "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
			{ "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" },
		},
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		config = function()
			require("plugins.configs.nvimtree")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		cmd = "Telescope",
		config = function()
			require("telescope").setup()
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		lazy = false,
	},
	{
		"saecki/crates.nvim",
		tag = "stable",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		dependencies = "neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.rust-tools")
		end,
	},
	{

		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim"
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"rust_analyzer"
				}
			})
		end
	},
	{
		'nvimdev/dashboard-nvim',
		event = 'VimEnter',
		config = function()
			require("plugins.configs.dashboard")
		end,
		dependencies = { { 'nvim-tree/nvim-web-devicons' } }
	},
	{
		"stevearc/dressing.nvim",
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	{

		"rcarriga/nvim-notify",
		init = function()
			vim.notify = require("notify")
		end
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{ "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
			{ "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
			{ "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
			{ "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"lazy",
					"mason",
					"notify",
					"nvim-tree"
				},
			},
		},
		config = function(_, opts)
			require("ibl").setup(opts)
		end
	},
	{
		'echasnovski/mini.indentscope',
		version = '*',
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"nvim-tree",
					"lazy",
					"mason",
					"notify",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		config = function(_, opts)
			require('mini.indentscope').setup(opts)
		end
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true,
				lsp_doc_border = false,
			}
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		}
	}
})
