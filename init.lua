-- bootstrap lazy.nvim, LazyVim and your plugins

---@alias ColorschemeOption "gruvbox-material" | "catppuccin"

--- options
---@class Options
---@field git_worktree_open_file_on_switch string | nil
---@field git_worktree_post_switch_hook function
O = {
  scrolloff = 9,
  sidescrolloff = 15,
  signcolumn = "auto:1-2",
  -- keep this many lines in terminal buffer
  scrollback = 20000,
  ---@type ColorschemeOption
  colorscheme = "gruvbox-material",
  background = "dark",
  lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
  pluginspath = vim.fn.stdpath("data") .. "/lazy",
  devpath = vim.env.HOME .. "/dev/personal/neovim-plugins",
  inlay_hints = true,
  git_rev = "master",
  git_worktree_pre_create_hook = function(_, _, _)
    -- vim.cmd.tabnew()
  end,
  git_worktree_pre_switch_hook = function(_)
    -- vim.cmd.tabnew()
  end,
  git_worktree_post_create_hook = nil,
  git_worktree_post_switch_hook = function(_)
    -- vim.cmd("vsplit +enew")
    -- vim.cmd("NvimTreeClose")
  end,
  -- copilot = true,
  ft = {
    go = {
      expandtab = false,
      shiftwidth = 4,
      tabstop = 4,
      softtabstop = 4,
    },
  },
  python_module = "app",
  vis_modes = { "v", "V", "vs", "Vs", "CTRL-V", "CTRL-Vs" },
  ins_modes = { "i", "ic", "ix" },
}
require("config.lazy")
