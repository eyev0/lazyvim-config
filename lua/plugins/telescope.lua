return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      local mappings = {
        i = {
          ["<Esc>"] = actions.close,
          ["<C-c"] = false,
          ["<C-/>"] = actions.which_key,
          ["<C-s>"] = actions.select_horizontal + actions.center,
          ["<C-v>"] = actions.select_vertical + actions.center,
          ["<CR>"] = actions.select_default + actions.center,
          -- ["<C-s>"] = actions.toggle_selection,
          ["<C-f>"] = actions.to_fuzzy_refine,
          -- ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<C-q>"] = actions.smart_send_to_qflist,
        },
        n = {
          ["<C-q>"] = actions.smart_send_to_qflist,
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,
        },
      }
      require("telescope").setup({
        defaults = {
          mappings = mappings,
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          winblend = 0,
          path_display = { truncate = 5 },
          layout_strategy = "horizontal",
          no_ignore = true,
          hidden = true,
          layout_config = {
            mirror = false,
            prompt_position = "top",
            scroll_speed = 5,
            height = 0.8,
            width = 0.9,
            -- preview_width = 0.6,
          },
          follow = true,
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
          },
        },
        pickers = {
          find_files = {
            layout_config = {
              preview_width = 0.6,
            },
            hidden = true,
            no_ignore = true,
            no_ignore_parent = true,
          },
          live_grep = {
            hidden = true,
            no_ignore = true,
            no_ignore_parent = true,
            layout_strategy = "vertical",
            layout_config = {
              prompt_position = "top",
              preview_height = 0.55,
              scroll_speed = 5,
              height = 0.95,
              width = 0.9,
              preview_width = nil,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          },
        },
      })

      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "dap")
    end,
  },
}
