return {
  "notomo/cmdbuf.nvim",
  config = function()
    vim.api.nvim_create_autocmd({ "User" }, {
      group = vim.api.nvim_create_augroup("CmdbufWipeOnHide", {}),
      pattern = "CmdbufNew",
      callback = function(opts)
        vim.bo[opts.buf].bufhidden = "wipe"
      end,
    })
  end,
}
