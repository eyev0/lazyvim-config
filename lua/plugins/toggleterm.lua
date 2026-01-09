return {
  "akinsho/toggleterm.nvim",
  config = true,
  cmd = "ToggleTerm",
  build = ":ToggleTerm",
  -- keys = { { "<F1>", "<cmd>ToggleTerm<cr>", desc = "Toggle floating terminal" } },
  opts = {
    -- open_mapping = [[<F1>]],
    -- direction = "horizontal",
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    hide_numbers = false,
    insert_mappings = true,
    terminal_mappings = true,
    start_in_insert = true,
    close_on_exit = true,
  },
}


