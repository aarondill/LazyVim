return {
  "f-person/git-blame.nvim",
  config = function()
    -- Enables git-blame.nvim on load. You can toggle git blame messages on/off with the :GitBlameToggle command.
    vim.g.gitblame_enabled = 1
    -- The template for the blame message that will be shown.
    vim.g.gitblame_message_template = "  <author> • <date> • <summary>"
    -- The blame message that will be shown when the current modification hasn't been committed yet.
    vim.g.gitblame_message_when_not_committed = "No commit."
    -- The format of the date fields.
    vim.g.gitblame_date_format = "%r"
    -- The highlight group for virtual text.
    vim.g.gitblame_highlight_group = "Comment"
    -- If the blame message should be displayed as virtual text.
    -- You may want to disable this if you display the blame message in statusline.
    vim.g.gitblame_display_virtual_text = 1
    -- A list of filetypes for which gitblame information will not be displayed.
    -- Empty for now
    vim.g.gitblame_ignored_filetypes = {}
    -- The delay in milliseconds after which the blame info will be displayed.
    -- Note that this doesn't affect the performance of the plugin.
    vim.g.gitblame_delay = 1000 -- 1 second
  end,
  event = { "LazyFile" },
  cmd = {
    "GitBlameOpenCommitURL",
    "GitBlameToggle",
    "GitBlameEnable",
    "GitBlameDisable",
    "GitBlameCopySHA",
    "GitBlameCopyCommitURL",
    "GitBlameOpenFileURL",
    "GitBlameCopyFileURL",
  },
}
