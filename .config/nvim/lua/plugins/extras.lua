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
  -- { import = "lazyvim.plugins.extras.editor.symbols-outline" }, -- TODO: Look into this / learn
  { import = "lazyvim.plugins.extras.ai.copilot" },
  { import = "lazyvim.plugins.extras.ai.copilot-chat" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  { import = "lazyvim.plugins.extras.editor.dial" },
  { import = "lazyvim.plugins.extras.lang.angular" },
  { import = "lazyvim.plugins.extras.lang.clangd" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.nix" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.sql" },
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  { import = "lazyvim.plugins.extras.lang.terraform" },
  { import = "lazyvim.plugins.extras.lang.toml" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.ui.treesitter-context" },
  { import = "lazyvim.plugins.extras.util.dot" },
  -- Install extra language servers not included above
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
