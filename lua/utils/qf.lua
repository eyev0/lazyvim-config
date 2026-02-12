local cmd = vim.cmd

local feedkeys = function(keys, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), mode, false)
end

-- local function get_qf_height(n_items)
--   return math.min(math.max(n_items, 1), qf_max_height)
-- end
-- ---@param opts quicker.OpenOpts
-- ---@param jump boolean
-- local open_list_cmd = function(opts, jump)
-- if opts.loclist then
--   cmd("horizontal bo lopen " .. height)
-- else
--   cmd("horizontal bo copen " .. height)
-- end
--   if not focus then
--     if jump then
--       feedkeys("<CR>", "")
--     else
--       cmd("wincmd p")
--     end
--   end
-- end

---@param opts quicker.OpenOpts
---@param jump boolean go to first entry aka cfirst
local open_list_cmd = function(opts, jump)
  require("quicker").open(opts)
  -- if jump then
  --   -- cmd("wincmd p")
  --   feedkeys("<CR>", "")
  -- end
end

---@class qf.Qf
local M = {}

local ll_open = false
local qf_open = false

---@param opts qf.OpenOpts
local function switch_state(opts)
  if opts.loclist then
    ll_open = not ll_open
  else
    qf_open = not qf_open
  end
end

---@param loclist boolean
---@return boolean
function M.is_open(loclist)
  if loclist then
    return ll_open
  else
    return qf_open
  end
end

---@class qf.OpenOpts
---@field loclist? boolean if true, use location list instead of quickfix (default = false)
---@field height? number number of entries in quickfix (default = #vim.fn.getqflist())
---@field max_height? number maximum height of window (default = 10)
---@field jump? boolean Open first entry aka cfirst (default = true)
---@field focus? boolean Keep qf window focused (default = false)
---@field set_mark? boolean Before jump, add cursor position to jump list (default = true)

---@param opts? qf.OpenOpts
---@return qf.OpenOpts
local function set_default_opts(opts)
  opts = opts or {}
  local h
  if opts.loclist then
    h = #vim.fn.getloclist(0)
  else
    h = #vim.fn.getqflist()
  end
  local max_height = 16
  opts = vim.tbl_deep_extend("keep", opts, {
    loclist = false,
    height = h < max_height and h or max_height,
    max_height = max_height,
    goto_first = true,
    focus = false,
    set_mark = true,
  })
  return opts or {}
end

---@param opts qf.OpenOpts
local function _open(opts)
  if opts.height > 0 then
    if opts.jump and opts.set_mark then
      vim.cmd("normal! m`")
    end
    if open_list_cmd then
      local success, _, error = pcall(open_list_cmd, opts, opts.jump)
      if not success then
        vim.notify("qf.open error: " .. error, vim.log.levels.ERROR)
      end
      switch_state(opts)
    end
  end
end

---@param opts? qf.OpenOpts
function M.open(opts)
  opts = set_default_opts(opts)
  _open(opts)
end

---@param opts? qf.OpenOpts
function M.toggle_quickfix(opts)
  if M.is_open(false) then
    M.close(false)
  else
    opts = set_default_opts(opts)
    opts.loclist = false
    _open(opts)
  end
end

---@param opts? qf.OpenOpts
function M.toggle_loclist(opts)
  if M.is_open(true) then
    M.close(true)
  else
    opts = set_default_opts(opts)
    opts.loclist = true
    _open(opts)
  end
end

---@param options vim.lsp.LocationOpts.OnList
---@param loclist boolean
function M.set_list(options, loclist)
  if loclist then
    vim.fn.setloclist(0, {}, " ", options)
  else
    vim.fn.setqflist({}, " ", options)
  end
end

---@param loclist boolean
function M.first(loclist)
  if loclist then
    cmd("lfirst")
  else
    cmd("cfirst")
  end
end

---@param loclist boolean
function M.close(loclist)
  if loclist then
    cmd("lclose")
  else
    cmd("cclose")
  end
  switch_state({ loclist = loclist })
end

return M
