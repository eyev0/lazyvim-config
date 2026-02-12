return {
  "nvim-treesitter/nvim-treesitter",
  lazy = true,
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    local skip = { vim = true, vimdoc = true }
    opts.ensure_installed = vim.tbl_filter(function(lang)
      return not skip[lang]
    end, opts.ensure_installed)
  end,
}
