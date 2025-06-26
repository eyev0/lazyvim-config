return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "hpp" },
        },
        -- ["markdownlint-cli2"] = {
        --   mason = false,
        -- },
      },
    },
  },
}
