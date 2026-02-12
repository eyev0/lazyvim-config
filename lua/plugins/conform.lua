return {
  "stevearc/conform.nvim",
  optional = true,
  opts = function(_, opts)
    opts.formatters_by_ft["sql"] = { "sqlfmt" }
  end,
  keys = {
    {
      "<leader>cF",
      false,
    },
    {
      "<leader>lF",
      function()
        require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
      end,
      mode = { "n", "x" },
      desc = "Format Injected Langs",
    }
  }
}
