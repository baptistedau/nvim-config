require("plugins")

local set = vim.opt
local let = vim.g

-- General options
set.expandtab = true
set.smarttab = true
set.shiftwidth = 4
set.tabstop = 4

set.hlsearch = true
set.incsearch = true
set.ignorecase = true
set.smartcase = true

set.wrap = false
set.scrolloff = 5
set.fileencoding = 'utf-8'
set.termguicolors = true
set.colorcolumn = {80}

set.relativenumber = true
set.number = true
set.cursorline = true
set.hidden = true


-- Keymaps
let.mapleader = " "
local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
map("n", "L", ":BufferLineCycleNext<CR>", opts)
map("n", "H", ":BufferLineCyclePrev<CR>", opts)
map("n", "<leader>x", ":bdelete<CR>", opts)
map("n", "<leader>X", ":bdelete!<CR>", opts)
map("n", "<leader>C", ":ClangFormatAutoToggle<CR>", opts)
