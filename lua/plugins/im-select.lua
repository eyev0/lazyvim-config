return {
  "keaising/im-select.nvim",
  config = function()
    require("im_select").setup({
      default_command = "/opt/homebrew/bin/im-select",
      set_default_events = { "TermLeave", "InsertLeave", "CmdlineLeave" },
      set_previous_events = { "TermEnter", "InsertEnter" }
    })
  end,
  -- enabled = false,
}
