local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local wk = require("which-key")

-- Flat keymap + which-key spec
local mappings = {
  -- File Explorer
  { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle File Explorer" },

  -- Telescope
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "List Buffers" },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },

  -- Buffer Management
  { "<leader>bd", ":bd<CR>", desc = "Delete Current Buffer" },
  { "<leader>bo", ":%bd|e#<CR>", desc = "Close Other Buffers" },
  { "<leader>bn", ":bnext<CR>", desc = "Next Buffer" },
  { "<leader>bp", ":bprevious<CR>", desc = "Previous Buffer" },
  { "<leader>bl", ":ls<CR>:b<Space>", desc = "List and Switch Buffers" },

  -- Diagnostic
  { "<leader>vd", vim.diagnostic.open_float, desc = "View Diagnostics" },
  { "<leader>q", vim.diagnostic.setloclist, desc = "Quickfix Diagnostics List" },

  -- Git
  { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },

  -- Trouble
  { "<leader>tt", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },

  -- Projects
  { "<leader>ps", ":Telescope projects<CR>", desc = "Search Projects" },

  -- Clear search highlight on double Esc
  { "<Esc><Esc>", ":nohlsearch<CR>", desc = "Clear search highlight" },
}

-- Register mappings
for _, map_args in ipairs(mappings) do
  map("n", map_args[1], map_args[2], opts)
end

-- Register which-key groups using new spec
wk.add({
  { "<leader>f", group = "file" },
  { "<leader>g", group = "git" },
  { "<leader>p", group = "project" },
  { "<leader>t", group = "trouble" },
  { "<leader>b", group = "buffer" },
})

