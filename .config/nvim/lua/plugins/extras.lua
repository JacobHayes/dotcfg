-- TODO: Check out:
-- supertab - use tab to rotate through completion options (instead of arrows)
--     https://www.lazyvim.org/configuration/recipes#supertab
-- legendary - legend for keymaps
--     https://github.com/mrjones2014/legendary.nvim
--
-- TODO: Look into preferring venv local binaries (eg: ruff, mypy, etc) but fall back to Mason ones if not available.
--     https://github.com/fredrikaverpil/dotfiles/blob/main/nvim-lazyvim/lua/plugins/lsp.lua#L5
--
-- Maybe
-- - dense-analysis/neural - AI Vim/Neovim code generation plugin (OpenAI, ChatGPT, and more) - seems to have chat / explain
-- - preservim/vimux - easily interact with tmux from vim
-- - rafamadriz/friendly-snippets - a bunch of snippets for all languages
-- - ray-x/navigator.lua - Code analysis & navigation plugin for Neovim (kinda like fancy IDE view ref locations, etc)
--     - or maybe just a better way to turn auto formatting off than my .envrc thing
return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "actionlint",
        "arduino-language-server",
        "biome",
        "css-lsp",
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "fish",
        "gitignore",
        "graphql",
        "http",
        "just",
        "sql",
      })
    end,
  },
}
