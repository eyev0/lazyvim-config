local M = {}
local qf = require("utils.qf")
local fn = vim.fn
local cmd = vim.cmd
local api = vim.api

local function win_has_item(item, win)
  ---@diagnostic disable-next-line: param-type-mismatch
  local bufinfo = vim.fn.getbufinfo(api.nvim_win_get_buf(win))[1]
  return bufinfo and bufinfo.name == item.filename
end

---@param options vim.lsp.LocationOpts.OnList
---@param loclist boolean if true, use location list instead of quickfix
---@param open boolean
---@param jump boolean
function M.on_list(options, loclist, open, jump)
  if options.items == nil or #options.items == 0 then
    vim.notify("No items")
    return
  end
  local n_items = #options.items
  local entry = options.items[1]
  open = vim.F.if_nil(open, true)
  jump = vim.F.if_nil(jump, true)
  -- create new quickfix/location list with options.items
  qf.set_list(options, loclist)
  if jump then
    vim.cmd("normal! m`")
    -- Here we try to reuse open window containing first item
    -- Find window containing first item
    -- if such window exists, open first item there (could be another tab),
    -- then open qf window and return to prev window position.
    -- If such window doesn't exist, use cfirst to jump
    local win
    while true do
      -- current window contains buffer containing first item?
      if win_has_item(entry, api.nvim_get_current_win()) then
        win = api.nvim_get_current_win()
        break
      end
      -- check all open windows
      for _, open_win in ipairs(api.nvim_list_wins()) do
        if win_has_item(entry, open_win) then
          win = open_win
          break
        end
      end
      break
    end
    if win ~= nil then
      -- found window containing first item
      -- go to window, open qf, refocus window, set cursor position
      fn.win_gotoid(win)
    else
      win = api.nvim_get_current_win()
    end
    if open then
      qf.open({ loclist = loclist, height = n_items })
    end
    if entry.filename:find("jdt://") ~= nil then
      -- for java
      -- filename is a jdt:// link which gets processed by jdt when opening qf entry
      qf.first(loclist)
    else
      if entry.filename ~= api.nvim_buf_get_name(api.nvim_win_get_buf(win)) then
        cmd("edit " .. entry.filename)
      end
      api.nvim_win_set_cursor(win, { entry.lnum, entry.col - 1 })
      vim.cmd("normal! m`")
    end
    if n_items == 1 then
      qf.close(loclist)
    end
    return
  end
  if open then
    qf.open({ loclist = loclist, height = n_items })
  end
end

return M
