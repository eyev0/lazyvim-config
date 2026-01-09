-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

if not vim.g.vscode then
  local keymaps = require("config.keymaps")
  local map = vim.keymap.set
  local api = vim.api
  local cmd = vim.cmd
  -- cmdwin
  local cmdbuf = require("cmdbuf")
  local cmdwin_aug_enter_id = api.nvim_create_augroup("CmdwinHacks", {})
  local cmdbuf_aug_bufnew_id = api.nvim_create_augroup("cmdbuf_setting", {})
  api.nvim_create_autocmd({ "CmdwinEnter" }, {
    group = cmdwin_aug_enter_id,
    callback = function()
      -- keymaps.cmdwin_maps()
      pcall(cmd, "TSBufDisable incremental_selection")
      -- cmd("TSContextDisable")
    end,
  })
  api.nvim_create_autocmd({ "CmdwinLeave" }, {
    group = cmdwin_aug_enter_id,
    callback = function()
      -- cmd("TSContextEnable")
    end,
  })
  api.nvim_create_autocmd({ "User" }, {
    group = cmdbuf_aug_bufnew_id,
    pattern = { "CmdbufNew" },
    callback = function()
      keymaps.cmdwin_maps()
      vim.wo.winfixheight = true
      vim.bo.bufhidden = "wipe" -- if you don't need previous opened buffer state
      local sources = {
        { name = "nvim_lua", group_index = 1, priority = 3 },
        { name = "path", group_index = 2, priority = 2 },
      }
      if vim.bo.filetype == "lua" then
        table.insert(sources, { name = "vsnip", group_index = 1, priority = 10 })
      else
        table.insert(sources, { name = "cmdline", group_index = 1, priority = 4 })
      end
    end,
  })
end
