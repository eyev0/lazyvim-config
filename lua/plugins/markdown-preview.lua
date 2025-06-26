return {
  "iamcco/markdown-preview.nvim",
  -- cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  -- ft = { "markdown", "mermaid" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown", "mermaid" }
  end,
  config = function()
    vim.g.mkdp_auto_start = 1
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_refresh_slow = 0
    vim.g.mkdp_combine_preview = 1
    vim.g.mkdp_port = 8862
    vim.g.mkdp_echo_preview_url = 1
    -- vim.g.mkdp_browser = "chrome"
  end,
}
