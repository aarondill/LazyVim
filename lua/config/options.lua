-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local util = require("util")
local set = vim.opt

-- Allows you to re-use the same window and switch from an unsaved buffer
-- without saving it first. Also allows you to keep an undo history for
-- multiple files when re-using the same window in this way. Vim will complain
-- if you try to quit without saving, and swap files will keep you safe if your
-- computer crashes.
set.hidden = true

-- Better command-line completion
set.wildmenu = true

-- Show partial commands in the last line of the screen
set.showcmd = true

-- Highlight searches (use <C-L> to temporarily turn off highlighting
set.hlsearch = true

-- Use case insensitive search, except when using capital letters
set.ignorecase = true
set.smartcase = true

-- Allow backspacing over autoindent, line breaks and start of insert action
set.backspace = "indent,eol,start"

-- When opening a new line and no filetype-specific indenting is enabled, keep
-- the same indent as the line you're currently on. Useful for READMEs, etc.
set.autoindent = true

-- Stop certain movements from always going to the first character of a line.
-- While this behaviour deviates from that of Vi, it does what most users
-- coming from other editors would expect.
set.startofline = false

-- Display the cursor position on the last line of the screen or in the status
-- line of a window
set.ruler = true

-- Always display the status line, even if only one window is displayed
set.laststatus = 2

-- Instead of failing a command because of unsaved changes, instead raise a
-- dialogue asking if you wish to save changed files.
set.confirm = true

-- Use visual bell instead of beeping when doing something wrong
set.visualbell = true

-- And reset the terminal code for the visual bell. If visualbell is set, and
-- this line is also included, vim will neither flash nor beep. If visualbell
-- is unset, this does nothing.
set.vb = false

-- Set the command window height to 2 lines, to avoid many cases of having to press <Enter> to continue"
set.cmdheight = 2

-- Display line numbers on the left
set.number = true

-- Display numbers relative to the curser
set.relativenumber = true

-- Quickly time out on keycodes, but never time out on mappings
set.timeout = false
set.ttimeout = true
set.ttimeoutlen = 40

-- Use <F11> to toggle between 'paste' and 'nopaste'
set.pastetoggle = "<F11>"

-- Set tab and >> to be 2 spaces
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true

-- Decrease updatetime for vim-gitgutter. Impacts swp file delay.
set.updatetime = 100

set.scrolloff = 5 -- Auto-scroll up or down to keep context above/below cursor
set.wrap = false -- turn off word-wrap
set.sidescrolloff = 5 -- Auto-scroll L/R to keep context in view

local dir = util.env("HOME") .. "/.cache/vimtmp"
if not vim.fn.isdirectory(dir) then
  vim.fn.mkdir(dir, "p")
end
set.directory = dir

-- Improve scrolling with nowrap
set.sidescroll = 1

-- Set the fold method to obey comments
set.foldmethod = "marker"

-- Turn on incremenetal search in vim
set.incsearch = true
-- If running in tty, set menu transparency to opaque
if util.is_tty() then
  require("config.tty").apply()
end
