local bind = require("utils.bind")
local map = require("utils.set_key_map")
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

map("n", "<Leader>yn", function()
  local res = vim.fn.expand("%:t")
  if res == "" then
    vim.notify(
      "Buffer has no filename",
      vim.log.levels.ERROR,
      { title = "Failed to yank filename", render = "compact" }
    )
    return
  end
  vim.fn.setreg("+", res)
  vim.notify(res, vim.log.levels.INFO, { title = "Yanked filename" })
end, { desc = "Yank the filename of current buffer" })

map("n", "<Leader>yp", function()
  local res = vim.fn.expand("%:p")
  res = res == "" and vim.loop.cwd() or res
  if res:len() then
    vim.fn.setreg("+", res)
    vim.notify(res, vim.log.levels.INFO, { title = "Yanked filepath" })
  end
end, { desc = "Yank the full filepath of current buffer" })

map("x", "<", "<gv", "Reselect visual block after indent")
map("x", ">", ">gv", "Reselect visual block after indent")

-- Magic tab thingis - see https://github.com/davidosomething/dotfiles/blob/dev/nvim/lua/dko/mappings.lua#L215

map("i", "<Tab>", function()
  -- If characters all the way back to start of line were all whitespace,
  -- insert whatever expandtab setting is set to do.
  local current_line = require("dko.utils.buffer").get_cursorline_contents()
  local all_spaces_regex = "^%s*$"
  if current_line:match(all_spaces_regex) then
    return "<Tab>"
  end

  -- Insert appropriate amount of spaces instead of real tabs
  local sts = vim.bo.softtabstop <= 0 and vim.fn.shiftwidth() or vim.bo.softtabstop
  -- How many spaces to insert after the current cursor to get to the next sts
  local spaces_from_cursor_to_next_sts = vim.fn.virtcol(".") % sts
  if spaces_from_cursor_to_next_sts == 0 then
    spaces_from_cursor_to_next_sts = sts
  end

  -- Insert whitespace to next softtabstop
  -- E.g. sts = 4, cursor at _,
  --          1234123412341234
  -- before   abc_
  -- after    abc _
  -- before   abc _
  -- after    abc     _
  -- before   abc    _
  -- after    abc     _
  return (" "):rep(1 + sts - spaces_from_cursor_to_next_sts)
end, { expr = true, desc = "Tab should insert spaces" })

map("i", "<S-Tab>", "<C-d>", {
  desc = "Tab inserts a tab, shift-tab should remove it",
})

local lazyvim_util = require("lazyvim.util")
local lazyterm = function()
  lazyvim_util.float_term(nil, { cwd = lazyvim_util.get_root() })
end
map("n", { "<C-CR>", "<Leader><CR>" }, lazyterm, "Terminal (root dir)")
map("t", { "<C-CR>" }, lazyterm, "Terminal (root dir)")
