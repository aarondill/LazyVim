return {
  -- Rebuild spell files on file open
  "micarmst/vim-spellsync",
  event = { "BufReadPre", "BufNewFile" },
}
