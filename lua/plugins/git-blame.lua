-- Not working! idk!
return {
  "aarondill/GitBlame.nvim",
  opts = {},
}
-- return {
--   "kessejones/git-blame-line.nvim",
--   main = "git-blame-line",
--   opts = {
--     git = {
--       default_message = "No commit",
--       blame_format = "%an - %ar - %s", -- see https://git-scm.com/docs/pretty-formats
--     },
--     view = {
--       left_padding_size = 5,
--       enable_cursor_hold = true,
--     },
--   },
-- }

-- return {
--   {
--     "f-person/git-blame.nvim",
--     config = function()
--       -- vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
--       vim.g.gitblame_message_when_not_committed = "No Commit"
--       vim.g.gitblame_message_template = "  <author> • <date> • <summary>"
--       vim.g.gitblame_date_format = "%r"
--       vim.g.gitblame_delay = 1500 -- 1.5 second
--     end,
--   },
-- }
