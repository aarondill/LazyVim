local util = require("util")
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "

-- Change z key in normal mode to undo and Z to redo
util.set_key_map("n", "z", "u", "Undo")
util.set_key_map("n", "Z", "<c-r>", "Redo")

-- Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
-- which is the default
util.set_key_map("n", "Y", "y$", "Yank until EOL")

-- Quick save and quit
util.set_key_map("n", "<leader>wq", function()
  -- Save if possible
  if vim.o.modifiable and vim.o.bt:len() == 0 then
    vim.cmd.wq()
  else
    vim.cmd.q()
  end
end, "Save and exit")

-- Quick quit
util.set_key_map("n", "<leader>q!", vim.cmd.q, "Exit without saving")
-- Quit without shift
util.set_key_map("n", "<leader>q1", vim.cmd.q, "Exit without saving")

-- Terminal allow escape to exit insert
util.set_key_map("t", "<Esc>", "<C-\\><C-n>", "Exit insert")

local function ToggleMovement(firstOp, thenOp)
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd("normal! " .. firstOp)
  local newpos = vim.api.nvim_win_get_cursor(0)
  vim.cmd("normal! " .. firstOp)
  -- Compare string representations of tables. Works bc simple tables (ie {2, 3})
  if table.concat(pos) == table.concat(newpos) then
    vim.cmd("normal! " .. thenOp)
  end
end

-- Map 0 to go between 0 and ^
local silent_opt = {
  silent = true,
}
util.set_key_map({ "n", "x" }, "0", util.bind(ToggleMovement, "^", "0"), "Go to start of line", silent_opt)
util.set_key_map({ "n", "x" }, "^", util.bind(ToggleMovement, "0", "^"), "Go to start of line", silent_opt)
-- Map gg to go between gg and G
util.set_key_map({ "n", "x" }, "gg", util.bind(ToggleMovement, "gg", "G"), "Go to start/end of file", silent_opt)
-- Map G to go between G and gg
util.set_key_map({ "n", "x" }, "G", util.bind(ToggleMovement, "G", "gg"), "Go to start/end of file", silent_opt)

-- Remap f9 to fold control
util.set_key_map("i", "<F9>", "<C-O>za", "Toggle Fold")
util.set_key_map("n", "<F9>", "za", "Toggle Fold")
util.set_key_map("o", "<F9>", "<C-C>za", "Toggle Fold")
util.set_key_map("x", "<F9>", "zf", "Create Fold")

local function DiffWithSaved()
  local filetype = vim.o.ft
  vim.cmd.diffthis()

  vim.cmd.vnew()
  local orig_file = vim.fn.expand("#")
  vim.cmd.read(orig_file)
  vim.cmd("normal! 1Gdd")

  vim.cmd.diffthis()
  vim.opt.buftype = "nofile"
  vim.opt.bufhidden = "wipe"
  vim.opt.buflisted = false
  vim.opt.swapfile = false
  vim.opt.readonly = true
  vim.opt.filetype = filetype
end
util.set_key_map("n", "<leader>ds", DiffWithSaved, "Show the diff with last save")
vim.api.nvim_create_user_command("DiffSaved", DiffWithSaved, {})

local function paste_from_system_clipboard()
  ---@diagnostic disable-next-line: param-type-mismatch # this works, but the types are wrong
  vim.paste(vim.fn.getreg("+", 1, true), -1)
end

-- Paste system clipboard with Ctrl + v
util.set_key_map({ "c", "i", "n", "x" }, "<C-v>", paste_from_system_clipboard, "Paste from system clipboard")

-- Cut to system clipboard with Ctrl + x
util.set_key_map("x", "<C-x>", '"+d', "Cut to system clipboard")
util.set_key_map("n", "<C-x>", '"+dd', "Cut to system clipboard")
util.set_key_map("i", "<C-x>", '<ESC>"+ddi', "Cut to system clipboard")

-- Copy to system clipboard with Ctr + c
util.set_key_map("x", "<C-c>", '"+y', "Copy to system clipboard")
util.set_key_map("n", "<C-c>", '"+yy', "Copy to system clipboard")
util.set_key_map("i", "<C-c>", '<ESC>"+yya', "Copy to system clipboard")
