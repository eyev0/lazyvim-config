return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "BufReadPre",
  config = function()
    require("treesitter-context").setup({
      enable = false,
    })
  end,
}
