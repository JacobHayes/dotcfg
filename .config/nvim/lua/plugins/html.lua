return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      html = {
        settings = {
          html = {
            format = {
              wrapLineLength = "0", -- disable line wrapping
            },
          },
        },
      },
    },
  },
}
