local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

require("telescope").setup({
  defaults = {
    layout_config = {
      preview_cutoff = 1,  -- Always show preview
      width = 0.9,
      height = 0.85,
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    winblend = 5,
    mappings = {
      i = {
        -- Insert mode preview scrolling
        ["J"] = actions.preview_scrolling_down,
        ["K"] = actions.preview_scrolling_up,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        -- Normal mode preview scrolling
        ["J"] = actions.preview_scrolling_down,
        ["K"] = actions.preview_scrolling_up,
        ["q"] = actions.close,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
  extensions = {
    -- Optional extensions can go here
  },
})

