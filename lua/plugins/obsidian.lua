return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  config = true,
  enabled = false,
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/vaults/personal",
      },
      {
        name = "work",
        path = "~/vaults/work",
        overrides = {
          daily_notes = {
            -- Optional, if you keep daily notes in a separate directory.
            folder = "dailies",
            -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
            -- template = "daily.md",
          },
        },
      },
    },
  },
  -- lazy = true,
  -- ft = "markdown",
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre "
  --     .. vim.fn.expand("~")
  --     .. "/vaults/**/*.md",
  --   "BufNewFile " .. vim.fn.expand("~") .. "/vaults/**/*.md",
  -- },
}
