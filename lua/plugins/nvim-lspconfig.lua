local lsp = require("utils.lsp")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "hpp" },
        },
        ["*"] = {
          keys = {
            { "<C-k>", false, mode = "i" },
            { "<leader>cr", false },
            { "<leader>cR", false },
            { "<leader>ca", false },
            { "<leader>cc", false },
            { "<leader>cC", false },
            { "<leader>cA", false },
            { "<leader>cf", false },
            {
              "<M-C-k>",
              function()
                return vim.lsp.buf.signature_help()
              end,
              mode = "i",
              desc = "Signature Help",
              has = "signatureHelp",
            },
            { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "x" }, has = "codeAction" },
            { "<leader>lc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "x" }, has = "codeLens" },
            {
              "<leader>lC",
              vim.lsp.codelens.refresh,
              desc = "Refresh & Display Codelens",
              mode = { "n" },
              has = "codeLens",
            },
            {
              "<leader>lR",
              function()
                Snacks.rename.rename_file()
              end,
              desc = "Rename File",
              mode = { "n" },
              has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
            },
            { "<leader>lr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
            { "<leader>lA", LazyVim.lsp.action.source, desc = "Source Action", has = "codeAction" },
            {
              "<a-n>",
              function()
                Snacks.words.jump(vim.v.count1, true)
              end,
              has = "documentHighlight",
              desc = "Next Reference",
              enabled = function()
                return Snacks.words.is_enabled()
              end,
            },
            {
              "<a-p>",
              function()
                Snacks.words.jump(-vim.v.count1, true)
              end,
              has = "documentHighlight",
              desc = "Prev Reference",
              enabled = function()
                return Snacks.words.is_enabled()
              end,
            },
            {
              "gr",
              function()
                vim.lsp.buf.references({ includeDeclaration = false }, { on_list = lsp.on_list })
              end,
              desc = "Goto References",
            },
            {
              "gd",
              function()
                vim.lsp.buf.definition({
                  reuse_win = true,
                  on_list = function(options)
                    lsp.on_list(options, false, options.items and #options.items > 1, true)
                  end,
                })
              end,
              desc = "Goto Definition",
            },
            {
              "gD",
              function()
                vim.lsp.buf.declaration({
                  reuse_win = true,
                  on_list = function(options)
                    lsp.on_list(options, false, options.items and #options.items > 1, true)
                  end,
                })
              end,
              desc = "Goto Declaration",
            },
            {
              "gI",
              function()
                vim.lsp.buf.implementation({ on_list = lsp.on_list })
              end,
              desc = "Goto Implementation",
            },
            {
              "gT",
              function()
                vim.lsp.buf.type_definition({
                  on_list = function(options)
                    lsp.on_list(options, false, options.items and #options.items > 1, true)
                  end,
                })
              end,
              desc = "Goto Type Definition",
            },
          },
        },
      },
    },
  },
}
