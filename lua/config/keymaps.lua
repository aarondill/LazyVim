-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "

-- Change z key in normal mode to undo and Z to redo
vim.keymap.set("n", "z", "u", {
  desc = "Undo",
})
vim.keymap.set("n", "Z", "<c-r>", {
  desc = "Redo",
})

-- Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
-- which is the default
vim.keymap.set("n", "Y", "y$", {
  desc = "Yank until EOL",
})

-- Quick save and quit
vim.keymap.set("n", "<leader>wq", function()
  -- Save if possible
  if vim.o.modifiable and vim.o.bt:len() == 0 then
    vim.cmd.wq()
  else
    vim.cmd.q()
  end
end, {
  desc = "Save and exit",
})

-- Quick quit
vim.keymap.set("n", "<leader>q!", function()
  vim.cmd("q")
end, { desc = "Exit without saving" })
-- Quit without shift
vim.keymap.set("n", "<leader>q1", function()
  vim.cmd("q")
end, { desc = "Exit without saving" })

-- Terminal allow escape to exit insert
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {
  desc = "Exit insert",
})

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
vim.keymap.set("n", "0", function()
  ToggleMovement("^", "0")
end, {
  desc = "Go to start of line",
  silent = true,
})
-- Map gg to go between gg and G
vim.keymap.set({ "n", "v" }, "gg", function()
  ToggleMovement("gg", "G")
end, {
  desc = "Go to start/end of file",
  silent = true,
})
-- Map G to go between G and gg
vim.keymap.set({ "n", "v" }, "G", function()
  ToggleMovement("G", "gg")
end, {
  desc = "Go to end/start of file",
  silent = true,
})

-- Remap f9 to fold control
vim.keymap.set("i", "<F9>", "<C-O>za", {
  desc = "Toggle Fold",
})
vim.keymap.set("n", "<F9>", "za", {
  desc = "Toggle Fold",
})
vim.keymap.set("o", "<F9>", "<C-C>za", {
  desc = "Toggle Fold",
})
vim.keymap.set("v", "<F9>", "zf", {
  desc = "Create Fold",
})

local function DiffWithSaved()
  local filetype = vim.o.ft
  vim.cmd("diffthis")
  vim.cmd("vnew | r # | normal! 1Gdd")
  vim.cmd("diffthis")
  vim.cmd("setlocal bt=nofile bh=wipe nobl noswf ro ft=" .. filetype)
end
vim.keymap.set("n", "<leader>ds", DiffWithSaved, {
  desc = "Show the diff with last save",
})
vim.api.nvim_create_user_command("DiffSaved", DiffWithSaved, {})
