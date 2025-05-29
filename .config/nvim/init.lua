vim.g.mapleader = " "

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins from 'lua/plugins.lua'
require("lazy").setup(require("plugins"))

-- Load your configs AFTER plugins are loaded
require("lsp")
require("cmp-config")
require("dap-config")
-- require("null-ls-config")
require("ui")
require("keymaps")
require("mini.icons").setup()

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

vim.opt.clipboard = "unnamedplus"


