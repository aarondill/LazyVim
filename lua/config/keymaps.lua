local bind = require("utils.bind")
local get_vtext = require("utils.vtext")
local handle_error = require("utils.handle_error")
local map = require("utils.set_key_map")
local text = require("utils.text")
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function line_not_empty(input)
  if type(input) ~= "string" then error("input is not a string") end
  local key = vim.api.nvim_replace_termcodes(input, true, false, true)
  local f = bind.with(vim.api.nvim_feedkeys, key, "n", false)

  return function()
    local vtext = get_vtext()
    if vtext and not vtext:find("^%s*$") then
      return f() -- not empty
    elseif vtext then -- visual mode
      return
    end

    local line = tostring(vim.fn.getline("."))
    if not line:find("^%s*$") then -- insert and normal mode
      return f()
    end
  end
end

map({ "i", "n" }, "<F3>", function()
  local cmd = vim.fn.getreg(":", 1) --[[@as string]]
  if not cmd or cmd == "" then return vim.notify("No previous command line", vim.log.levels.ERROR) end
  local parsed = vim.api.nvim_parse_cmd(cmd, {})
  local res = vim.api.nvim_cmd(parsed, { output = true })
  return text.insert(res, true)
end, "Insert last command output into buffer")

-- Change U to redo for symetry with u
map("n", "U", "<c-r>", "Redo")

--- Map Ctrl+Shift+A to decrement, since Ctrl+A is increment (and Ctrl+X is remapped later)
map("n", "<c-s-a>", "<c-x>", "Decrement")

-- Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
-- which is the default
map("n", "Y", "y$", "Yank until EOL")

-- Quick save and quit
map("n", "<leader>wq", function()
  -- Save if possible
  local cmd = (vim.o.bt:len() == 0 and vim.o.modifiable and not vim.readonly) and vim.cmd.wq or vim.cmd.q
  handle_error(cmd)()
end, "Save and exit")

-- Quick quit
map("n", "<leader>q!", vim.cmd.q, "Exit without saving")
-- Quit without shift
map("n", "<leader>q1", vim.cmd.q, "Exit without saving")

-- Terminal allow escape to exit insert
map("t", "<Esc>", "<C-\\><C-n>", "Exit insert")

-- Map 0 to go between 0 and ^
map({ "n", "x" }, "0", bind.with(require("utils.toggle_movement"), "^", "0"), "Go to start of line", { silent = true })
map({ "n", "x" }, "^", bind.with(require("utils.toggle_movement"), "0", "^"), "Go to start of line", { silent = true })
-- Map gg to go between gg and G
map(
  { "n", "x" },
  "gg",
  bind.with(require("utils.toggle_movement"), "gg", "G"),
  "Go to start/end of file",
  { silent = true }
)
-- Map G to go between G and gg
map(
  { "n", "x" },
  "G",
  bind.with(require("utils.toggle_movement"), "G", "gg"),
  "Go to start/end of file",
  { silent = true }
)

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
map("x", "<C-x>", line_not_empty('"+d'), "Cut to system clipboard")
map("n", "<C-x>", line_not_empty('"+dd'), "Cut to system clipboard")
map("i", "<C-x>", line_not_empty('<ESC>"+ddi'), "Cut to system clipboard")

-- Copy to system clipboard with Ctr + c
map("x", "<C-c>", line_not_empty('"+y'), "[C]opy to system clipboard")
map("n", "<C-c>", line_not_empty('"+yy'), "[C]opy to system clipboard")
map("i", "<C-c>", line_not_empty('<ESC>"+yya'), "[C]opy to system clipboard")

-- Cd shortcuts
map("n", "<Leader>cc", "<Cmd>cd! %:h<CR>", "[c]d to [c]urrent buffer path")
map("n", "<Leader>..", "<Cmd>cd! ..<CR>", "cd up a level [..]")

-- Edit closest
map("n", "<Leader>erm", function() require("utils.edit_closest")("README.md") end, "[E]dit closest [R]EAD[M]E.md")

map("n", "<Leader>epj", function() require("utils.edit_closest")("package.json") end, "[E]dit closest [p]ackage.[j]son")

map({ "i", "n" }, "<F1>", "<NOP>", "Disable help shortcut key")

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
end, "Yank the filename of current buffer")

map("n", "<Leader>yp", function()
  local res = vim.fn.expand("%:p")
  res = res == "" and vim.loop.cwd() or res
  if res == "" then return end
  vim.fn.setreg("+", res)
  vim.notify(res, vim.log.levels.INFO, { title = "Yanked filepath" })
end, "Yank the full filepath of current buffer")

map("x", "<", "<gv", "Reselect visual block after indent")
map("x", ">", ">gv", "Reselect visual block after indent")

-- Magic tab thingis - see https://github.com/davidosomething/dotfiles/blob/dev/nvim/lua/dko/mappings.lua#L215

local function get_cursorline_contents()
  local linenr = vim.api.nvim_win_get_cursor(0)[1]
  return vim.api.nvim_buf_get_lines(0, linenr - 1, linenr, false)[1]
end

map("i", "<Tab>", function()
  -- If characters all the way back to start of line were all whitespace,
  -- insert whatever expandtab setting is set to do.
  local current_line = get_cursorline_contents()
  local all_spaces_regex = "^%s*$"
  if current_line:match(all_spaces_regex) then return "<Tab>" end

  -- Insert appropriate amount of spaces instead of real tabs
  local sts = vim.bo.softtabstop <= 0 and vim.fn.shiftwidth() or vim.bo.softtabstop
  -- How many spaces to insert after the current cursor to get to the next sts
  local spaces_from_cursor_to_next_sts = vim.fn.virtcol(".") % sts
  if spaces_from_cursor_to_next_sts == 0 then spaces_from_cursor_to_next_sts = sts end

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
end, "Tab should insert spaces", { expr = true })

map("i", "<S-Tab>", "<C-d>", "Tab inserts a tab, shift-tab should remove it")

map({ "n", "x" }, "\\", "@:", "Backslash redoes the last command")

local lazyterm = function()
  local root = require("lazyvim.util.root")
  local terminal = require("lazyvim.util.terminal")
  return terminal.open(nil, { cwd = root.get() })
end
map("n", { "<C-CR>", "<Leader><CR>" }, lazyterm, "Terminal (root dir)")
map("t", "<C-CR>", lazyterm, "Terminal (root dir)")

map("v", "<C-/>", "<Cmd>Telescope grep_string<Cr>", "Grep for the selected string")

map("n", "<bs>", function()
  if vim.fn.getreg("#") == "" then return "<cmd>bn<cr>" end
  return "<c-^>"
end, { silent = true, noremap = true, expr = true })

-- Allow scrolling through autocomplete with up and down arrows!
map("c", "<c-p>", "<up>")
map("c", "<c-n>", "<down>")
map("c", "<up>", "<c-p>")
map("c", "<down>", "<c-n>")

-- Use Ctrl+hjkl to move in insert mode!
map("i", "<c-h>", "<left>")
map("i", "<c-j>", "<down>")
map("i", "<c-k>", "<up>")
map("i", "<c-l>", "<right>")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  once = true,
  callback = function() -- Undo LazyVim things I don't like
    vim.keymap.del("n", "<leader>ub") -- Don't blind me on a typo
  end,
})

map("i", "<c-a>", "<c-o>^", "Beginning of line")
map("i", "<c-e>", "<End>", "End of line")
map("c", "<c-a>", "<Home>", "Beginning of line")
map("c", "<c-e>", "<End>", "End of line")
