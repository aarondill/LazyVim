-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local util = require("util")
local opt = vim.opt

-- Allows you to re-use the same window and switch from an unsaved buffer
-- without saving it first. Also allows you to keep an undo history for
-- multiple files when re-using the same window in this way. Vim will complain
-- if you try to quit without saving, and swap files will keep you safe if your
-- computer crashes.
opt.hidden = true

-- Better command-line completion
opt.wildmenu = true

-- Show partial commands in the last line of the screen
opt.showcmd = true

-- Highlight searches (use <C-L> to temporarily turn off highlighting
opt.hlsearch = true

-- Use case insensitive search, except when using capital letters
opt.ignorecase = true
opt.smartcase = true

-- Allow backspacing over autoindent, line breaks and start of insert action
opt.backspace = "indent,eol,start"

-- When opening a new line and no filetype-specific indenting is enabled, keep
-- the same indent as the line you're currently on. Useful for READMEs, etc.
opt.autoindent = true

-- Stop certain movements from always going to the first character of a line.
-- While this behaviour deviates from that of Vi, it does what most users
-- coming from other editors would expect.
opt.startofline = false

-- Display the cursor position on the last line of the screen or in the status
-- line of a window
opt.ruler = true

-- Always display the status line, even if only one window is displayed
opt.laststatus = 2

-- Instead of failing a command because of unsaved changes, instead raise a
-- dialogue asking if you wish to save changed files.
opt.confirm = true

-- Use visual bell instead of beeping when doing something wrong
opt.visualbell = true

-- And reset the terminal code for the visual bell. If visualbell is set, and
-- this line is also included, vim will neither flash nor beep. If visualbell
-- is unset, this does nothing.
opt.vb = false

-- Set the command window height to 2 lines, to avoid many cases of having to press <Enter> to continue"
opt.cmdheight = 2

-- Display line numbers on the left
opt.number = true

-- Display numbers relative to the curser
opt.relativenumber = true

-- Quickly time out on keycodes, but never time out on mappings
opt.timeout = false
opt.ttimeout = true
opt.ttimeoutlen = 40

-- Use <F11> to toggle between 'paste' and 'nopaste'
opt.pastetoggle = "<F11>"

-- Set tab and >> to be 2 spaces
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

-- Decrease updatetime for vim-gitgutter. Impacts swp file delay.
opt.updatetime = 100

opt.scrolloff = 5 -- Auto-scroll up or down to keep context above/below cursor
opt.wrap = false -- turn off word-wrap
opt.sidescrolloff = 5 -- Auto-scroll L/R to keep context in view

local dir = util.env("HOME") .. "/.cache/vimtmp"
if not vim.fn.isdirectory(dir) then
  vim.fn.mkdir(dir, "p")
end
opt.directory = dir

-- Improve scrolling with nowrap
opt.sidescroll = 1

-- Set the fold method to obey comments
opt.foldmethod = "marker"

-- Turn on incremenetal search in vim
opt.incsearch = true

opt.clipboard = "" -- Set clipboard to defualt to stop copying to system clipboard on yank
opt.autowrite = false -- Disable auto write

-- If running in tty, set menu transparency to opaque
if util.is_tty() then
  require("config.tty").apply()
end
