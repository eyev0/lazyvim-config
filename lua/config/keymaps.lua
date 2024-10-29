-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
-- local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local qf = require("utils.qf")

-- d - delete
map({ "n", "x" }, "c", [["_c]], { noremap = true, silent = true })
map({ "n", "x" }, "d", [["_d]], { noremap = true, silent = true })
map("n", "dd", [["_dd]], { noremap = true, silent = true })
map({ "n", "x" }, "D", [["_D]], { noremap = true, silent = true })

-- x - cut
map({ "n", "x" }, "x", [[d]], { noremap = true, silent = true })
map("n", "xx", [[dd]], { noremap = true, silent = true })
map("n", "X", [[D]], { noremap = true, silent = true })

-- s - substitute
local substitute = require("substitute")
map("n", "s", substitute.operator, { noremap = true, silent = true })
map("n", "ss", substitute.line, { noremap = true, silent = true })
map("n", "S", substitute.eol, { noremap = true, silent = true })
map("x", "s", substitute.visual, { noremap = true, silent = true })

-- tmux navigation
map({ "n", "t" }, "<C-h>", function()
  cmd("TmuxNavigateLeft")
end, { noremap = true, silent = true })
map({ "n", "t" }, "<C-j>", function()
  cmd("TmuxNavigateDown")
end, { noremap = true, silent = true })
map({ "n", "t" }, "<C-k>", function()
  cmd("TmuxNavigateUp")
end, { noremap = true, silent = true })
map({ "n", "t" }, "<C-l>", function()
  cmd("TmuxNavigateRight")
end, { noremap = true, silent = true })

-- n always search forward
map({ "n", "x", "o" }, "n", function()
  if fn.getreg("/") ~= "" then
    if vim.v.searchforward == 1 then
      pcall(cmd, "normal! n")
    else
      pcall(cmd, "normal! N")
    end
    pcall(cmd, "normal! zzzv")
  end
end, { noremap = true, silent = true })
-- N always search backward
map({ "n", "x", "o" }, "N", function()
  if fn.getreg("/") ~= "" then
    if vim.v.searchforward == 1 then
      pcall(cmd, "normal! N")
    else
      pcall(cmd, "normal! n")
    end
    pcall(cmd, "normal! zzzv")
  end
end, { noremap = true, silent = true })

-- jumplist mutation
map("n", "k", [[(v:count > 5 ? "m'" . v:count : "") . 'k']], { noremap = true, silent = true, expr = true })
map("n", "j", [[(v:count > 5 ? "m'" . v:count : "") . 'j']], { noremap = true, silent = true, expr = true })

-- undo streak breakers
map("i", ",", [[,<C-g>u]], { noremap = false, silent = true })
map("i", ".", [[.<C-g>u]], { noremap = false, silent = true })
map("i", "!", [[!<C-g>u]], { noremap = false, silent = true })
map("i", "?", [[?<C-g>u]], { noremap = false, silent = true })
-- map("i", "(", [[(<C-g>u]], { noremap = false, silent = true })
-- map("i", ")", [[)<C-g>u]], { noremap = false, silent = true })
-- map("i", "[", [[[<C-g>u]], { noremap = false, silent = true })
-- map("i", "]", [[]<C-g>u]], { noremap = false, silent = true })
-- map("i", "{", [[{<C-g>u]], { noremap = false, silent = true })
-- map("i", "}", [[}<C-g>u]], { noremap = false, silent = true })
-- map("i", "<", [[<<C-g>u]], { noremap = false, silent = true })
-- map("i", ">", [[><C-g>u]], { noremap = false, silent = true })
map("i", ":", [[:<C-g>u]], { noremap = false, silent = true })

-- normal mode in terminal
map("t", "<C-]>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Move selected line / block of text in visual mode
map("x", "J", ":move '>+1<CR>gv", { noremap = true, silent = true })
map("x", "K", ":move '<-2<CR>gv", { noremap = true, silent = true })

-- quickfix stuff
-- Open quickfix list at the bottom of the screen
map("n", "<C-q><C-q>", [[:cclose<CR>]], { noremap = true, silent = true })
map("n", "<C-q><C-o>", qf.open, { noremap = true, silent = true, desc = "Open quickfix" })
map("n", "<C-q><C-n>", function()
  cmd("cnewer")
end, { noremap = true, silent = true, desc = "Next qf list" })
map("n", "<C-q><C-p>", function()
  cmd("colder")
end, { noremap = true, silent = true, desc = "Prev qf list" })
map("n", "<C-n>", function()
  if #vim.fn.getqflist() == 0 then
    return
  end
  vim.cmd("normal! m`")
  if #vim.fn.getqflist() == 1 then
    cmd("cfirst")
  elseif not pcall(cmd, "cnext") then
    pcall(cmd, "cfirst")
  end
end, { noremap = true, silent = true, desc = "Go to next item in qf" })
map("n", "<C-p>", function()
  if #vim.fn.getqflist() == 0 then
    return
  end
  vim.cmd("normal! m`")
  if #vim.fn.getqflist() == 1 then
    cmd("cfirst")
  elseif not pcall(cmd, "cprevious") then
    pcall(cmd, "clast")
  end
end, { noremap = true, silent = true, desc = "Go to prev item in qf" })
map("n", "<C-S-N>", function()
  pcall(cmd, "cbelow")
end, { noremap = true, silent = true, desc = "Go to next item in qf in this file" })
map("n", "<C-S-P>", function()
  pcall(cmd, "cabove")
end, { noremap = true, silent = true, desc = "Go to prev item in qf in this file" })

map("n", "<leader>X", [[:LazyExtras<CR>]], { noremap = true, silent = true })

-- cmdbuf
local cmdbuf = require("cmdbuf")
map({ "n", "v" }, "qo", function()
  cmdbuf.split_open(vim.o.cmdwinheight)
end, { noremap = true, silent = true, nowait = true })
-- map("c", "<C-e>", function()
--   cmdbuf.split_open(vim.o.cmdwinheight, { line = fn.getcmdline(), column = fn.getcmdpos() })
--   feedkeys("<C-c>", "n")
-- end)
-- open lua command-line window
map("n", "ql", function()
  cmdbuf.split_open(vim.o.cmdwinheight, { type = "lua/cmd" })
end, { noremap = true, silent = true, nowait = true })

map("n", "<leader>gd", ":DiffviewOpen<CR>", { noremap = true, silent = true, nowait = true, desc = "Open diffview" })
map(
  "n",
  "<leader>gD",
  ":DiffviewOpen ",
  { noremap = true, nowait = true, desc = "Open diffview against revision(prompt)" }
)
-- map("n", "<leader>gD", ":DiffviewClose<CR>", { noremap = true, silent = true, nowait = true })
