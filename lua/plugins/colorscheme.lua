return {
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      vim.o.background = "light"
    end,
  },
  -- {
  --   "shaunsingh/solarized.nvim",
  --   config = function()
  --     vim.o.background = "light"
  --   end,
  -- },
  -- {
  --   "maxmx03/solarized.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   ---@type solarized.config
  --   opts = {},
  --   config = function(_, opts)
  --     vim.o.termguicolors = true
  --     vim.o.background = "light"
  --     require("solarized").setup(opts)
  --   end,
  -- },
}
