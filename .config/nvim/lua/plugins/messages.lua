return {
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d fewer lines" },
              { find = "%d lines yanked" },
              { find = "%d more lines" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          opts = { skip = true },
        },
      },
      presets = { bottom_search = false },
    },
  },
}
