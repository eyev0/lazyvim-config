-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local map = vim.keymap.set
local api = vim.api
local cmd = vim.cmd

vim.api.nvim_create_user_command("CodeiumEnable", "echo 'Enabled Codeium'", {})

-- cmdwin
local cmdbuf = require("cmdbuf")
local cmdwin_aug_id = api.nvim_create_augroup("CmdwinHacks", {})
local function cmdwin_maps()
  map("n", "<Esc>", [[<Cmd>quit<CR>]], { noremap = true, silent = true, buffer = true })
  map("n", "q", [[<Cmd>quit<CR>]], { nowait = true, buffer = true })
  map("n", "<C-k>", [[<Cmd>quit<CR>]], { nowait = true, buffer = true })
  map(
    { "n", "i" },
    "<C-t>",
    function()
      local cursor = api.nvim_win_get_cursor(0)
      local line = api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], false)[1]
      local command = vim.bo.filetype == "lua" and ("lua " .. line) or line
      vim.notify(command)
      cmd("stopinsert")
      cmd("wincmd p")
      require("noice").redirect(command, { { filter = { event = "msg_show" }, view = "popup" } })
      cmd("wincmd p")
    end,
    { noremap = true, silent = true, desc = "Execute command under cursor in previous buffer", buffer = true }
  )
end
api.nvim_create_autocmd({ "CmdwinEnter" }, {
  group = cmdwin_aug_id,
  callback = function()
    cmdwin_maps()
    cmd("TSBufDisable incremental_selection")
    -- cmd("TSContextDisable")
  end,
})
api.nvim_create_autocmd({ "CmdwinLeave" }, {
  group = cmdwin_aug_id,
  callback = function()
    -- cmd("TSContextEnable")
  end,
})
api.nvim_create_autocmd({ "User" }, {
  group = api.nvim_create_augroup("cmdbuf_setting", {}),
  pattern = { "CmdbufNew" },
  callback = function()
    cmdwin_maps()
    map("n", "dd", cmdbuf.delete, { buffer = true })
    vim.wo.winfixheight = true
    local sources = {
      { name = "nvim_lua", group_index = 1, priority = 3 },
      { name = "path", group_index = 2, priority = 2 },
    }
    if vim.bo.filetype == "lua" then
      table.insert(sources, { name = "vsnip", group_index = 1, priority = 10 })
    else
      table.insert(sources, { name = "cmdline", group_index = 1, priority = 4 })
    end
    require("cmp").setup.buffer({
      sources = sources,
    })
  end,
})

