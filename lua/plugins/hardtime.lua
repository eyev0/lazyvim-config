return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  opts = {
    disabled_keys = {
       ["<Up>"] = false,
       ["<Down>"] = false,
    },
    restricted_keys = {
       ["j"] = false,
       ["k"] = false,
       ["<C-N>"] = false,
       ["<C-P>"] = false,
    }
  },
}
