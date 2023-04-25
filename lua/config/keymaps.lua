local bind = require("utils.bind")
local map = require("utils.set_key_map")
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "

-- Change U to redo for symetry with u
map("n", "U", "<c-r>", "Redo")

-- Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
-- which is the default
map("n", "Y", "y$", "Yank until EOL")

-- Quick save and quit
map("n", "<leader>wq", function()
  -- Save if possible
  if vim.o.modifiable and vim.o.bt:len() == 0 then
    vim.cmd.wq()
  else
    vim.cmd.q()
  end
end, "Save and exit")

-- Quick quit
map("n", "<leader>q!", vim.cmd.q, "Exit without saving")
-- Quit without shift
map("n", "<leader>q1", vim.cmd.q, "Exit without saving")

-- Terminal allow escape to exit insert
map("t", "<Esc>", "<C-\\><C-n>", "Exit insert")

-- Map 0 to go between 0 and ^
map({ "n", "x" }, "0", bind(require("utils.toggle_movement"), "^", "0"), "Go to start of line", { silent = true })
map({ "n", "x" }, "^", bind(require("utils.toggle_movement"), "0", "^"), "Go to start of line", { silent = true })
-- Map gg to go between gg and G
map({ "n", "x" }, "gg", bind(require("utils.toggle_movement"), "gg", "G"), "Go to start/end of file", { silent = true })
-- Map G to go between G and gg
map({ "n", "x" }, "G", bind(require("utils.toggle_movement"), "G", "gg"), "Go to start/end of file", { silent = true })

-- Remap f9 to fold control
map("i", "<F9>", "<C-O>za", "Toggle Fold")
map("n", "<F9>", "za", "Toggle Fold")
map("o", "<F9>", "<C-C>za", "Toggle Fold")
map("x", "<F9>", "zf", "Create Fold")

map("n", "<leader>ds", require("utils.diff_with_saved"), "Show the [d]iff with last [s]ave")

-- Paste system clipboard with Ctrl + v
map({ "c", "i", "n", "x" }, "<C-v>", function()
  ---@diagnostic disable-next-line: param-type-mismatch # this works, but the types are wrong
  vim.paste(vim.fn.getreg("+", 1, true), -1)
end, "Paste from system clipboard")

-- Cut to system clipboard with Ctrl + x
map("x", "<C-x>", '"+d', "Cut to system clipboard")
map("n", "<C-x>", '"+dd', "Cut to system clipboard")
map("i", "<C-x>", '<ESC>"+ddi', "Cut to system clipboard")

-- Copy to system clipboard with Ctr + c
map("x", "<C-c>", '"+y', "[C]opy to system clipboard")
map("n", "<C-c>", '"+yy', "[C]opy to system clipboard")
map("i", "<C-c>", '<ESC>"+yya', "[C]opy to system clipboard")

-- Cd shortcuts
map("n", "<Leader>cc", "<Cmd>cd! %:h<CR>", { desc = "[c]d to [c]urrent buffer path" })
map("n", "<Leader>..", "<Cmd>cd! ..<CR>", { desc = "cd up a level [..]" })

-- Edit closest
map("n", "<Leader>erm", function()
  require("utils.edit_closest")("README.md")
end, { desc = "[E]dit closest [R]EAD[M]E.md" })

map("n", "<Leader>epj", function()
  require("utils.edit_closest")("package.json")
end, { desc = "[E]dit closest [p]ackage.[j]son" })

map({ "i", "n" }, "<F1>", "<NOP>", { desc = "Disable help shortcut key" })

