return {
  "sindrets/diffview.nvim",
  opts = {
    diff_binaries = false, -- Show diffs for binaries
    enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
    use_icons = true, -- Requires nvim-web-devicons
    icons = { -- Only applies when use_icons is true.
      folder_closed = "",
      folder_open = "",
    },
    view = {
      merge_tool = {
        -- Config for conflicted files in diff views during a merge or rebase.
        layout = "diff3_mixed",
        disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
        winbar_info = true, -- See |diffview-config-view.x.winbar_info|
      },
    },
    signs = {
      fold_closed = "",
      fold_open = "",
    },
    file_panel = {
      win_config = {
        position = "top",
        height = 10,
      },
      listing_style = "tree", -- One of 'list' or 'tree'
      tree_options = { -- Only applies when listing_style is 'tree'
        flatten_dirs = true, -- Flatten dirs that only contain one single dir
        folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
      },
    },
    file_history_panel = {
      win_config = {
        position = "bottom",
        width = 35,
        height = 16,
      },
      log_options = {
        git = {
          single_file = {
            max_count = 100, -- Limit the number of commits
            follow = false, -- Follow renames (only for single file)
            all = false, -- Include all refs under 'refs/' including HEAD
            merges = false, -- List only merge commits
            no_merges = false, -- List no merge commits
            reverse = false, -- List commits in reverse order
          },
          multi_file = {
            max_count = 100, -- Limit the number of commits
            follow = false, -- Follow renames (only for single file)
            all = false, -- Include all refs under 'refs/' including HEAD
            merges = false, -- List only merge commits
            no_merges = false, -- List no merge commits
            reverse = false, -- List commits in reverse order
          },
        },
      },
    },
    default_args = { -- Default args prepended to the arg-list for the listed commands
      DiffviewOpen = {},
      DiffviewFileHistory = {},
    },
    hooks = {}, -- See ':h diffview-config-hooks'
  },
}
