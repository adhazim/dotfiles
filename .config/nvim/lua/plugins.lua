return {
	-- LSP Config and Installer
	{
		"neovim/nvim-lspconfig",
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup()
		end,
	},

	-- Autocompletion
	{"hrsh7th/nvim-cmp"},
	{"L3MON4D3/LuaSnip"},
	{"saadparwaiz1/cmp_luasnip"},
	{"hrsh7th/cmp-nvim-lsp"},

-- Mason integration for null-ls
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = { "eslint", "prettier", "php-css-fixer" },
        automatic_setup = true,
      })
      -- no need to call null-ls.setup() here, mason-null-ls handles it
    end,
  },

	-- LazyGit plugin
	{
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Open LazyGit" })
  end,
},
	-- Which-key plugin
	{
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup()
  end,
},
	{ "echasnovski/mini.nvim", version = false }, -- includes mini.icons

	-- Add to your plugins table (e.g., in plugins.lua or similar)
{
  "karb94/neoscroll.nvim",
  event = "WinScrolled",
  config = function()
    require('neoscroll').setup()
  end
},

	-- Formatting and linting
	-- {
	-- 	"nvimtools/none-ls.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		local none_ls = require("null-ls")
	-- 		none_ls.setup({
	-- 			sources = {
	-- 				none_ls.builtins.formatting.prettier,
	-- 				none_ls.builtins.diagnostics.eslint,
	-- 			},
	-- 		})
	-- 	end,
	-- },

	-- Debug Adapter Protocol
	{
		"mfussenegger/nvim-dap",
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-neotest/nvim-nio" },
		config = function()
			require("dapui").setup()
		end,
	},
	{
		"nvim-neotest/nvim-nio",
	},

	-- Theme and icons
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = true },
	{ "folke/tokyonight.nvim", lazy = false, priority = 1000, config = function() vim.cmd("colorscheme tokyonight") end },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

	-- File explorer
	{ "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" }, config = true },

	-- Fuzzy Finder
	{ "nvim-telescope/telescope.nvim", tag = "0.1.5", dependencies = { "nvim-lua/plenary.nvim" }, config = true },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup {
				ensure_installed = { "lua", "javascript", "typescript", "html", "css", "json", "php", "c_sharp" },
				highlight = { enable = true },
				indent = { enable = true },
			}
		end
	},
}

