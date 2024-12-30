return {
  "epwalsh/obsidian.nvim",
  version = "*", -- use latest release instead of latest commit
  lazy = true,
  ft = "markdown", -- even if not working on Obsidian files, this plugin looks nice
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    workspaces = {
      {
        name = "Personal",
        path = "~/Obsidian/Personal/",
        overrides = {
          daily_notes = {
            folder = "Calendar",
            template = "Calendar/_daily.md",
          },
        },
      },
      {
        name = "Shared",
        path = "~/Obsidian/Shared/",
      },
    },
  },
}
