return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      contrast = "hard",
      palette_overrides = {
        dark0_hard = "#1b1b1b", -- Match Ghostty's Gruvbox Dark Hard
        light0_hard = "#fbf1c7", -- Match Ghostty's Gruvbox Light (I don't like Light Hard)
      },
    },
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "gruvbox" } },
  {
    "f-person/auto-dark-mode.nvim",
    event = "VeryLazy",
    init = function()
      require("config.background")
    end,
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        os.execute("echo 'vim.go.background = \"dark\"' > ~/.config/nvim/lua/config/background.lua")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        os.execute("echo 'vim.go.background = \"light\"' > ~/.config/nvim/lua/config/background.lua")
      end,
    },
  },
}
