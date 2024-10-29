return {
  {
    "christoomey/vim-tmux-navigator",
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },
  { "tmux-plugins/vim-tmux" }, -- syntax highlighting for .tmux.conf
}
