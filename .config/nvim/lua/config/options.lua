vim.go.background = "dark" -- Set statically to provide fast startup without flickering (updated in ../plugins/colorscheme.lua)

-- Create an isolated venv for neovim:
-- - ~/.pyenv/versions/3.12.3/bin/python -m venv ~/.local/share/nvim/.venv
-- - ~/.local/share/nvim/.venv/bin/pip install --upgrade pynvim
-- vim.g.python3_host_prog = vim.fn.expand("~/.local/share/nvim/.venv/bin/python3")

-- Disabled:
--     vim.opt.lazyredraw = true -- don't redraw the screen when executing non typed commands (so eg: macros run faster)
--         This isn't compatible with noice.nvim...
vim.opt.autowrite = false -- Disable auto write (LazyVim default is true)
vim.opt.breakindent = true -- Indent wrapped text, rather than start at the beginning of the line
vim.opt.hidden = false -- Don't hide buffers (and leave swap files around) when `:q` them but actually close them
vim.opt.linebreak = true -- Break lines at word boundaries, rather than in the middle of words
vim.opt.modelines = 0 -- Modelines auto loads vim commands in files. Security vuln and don't need
vim.opt.shell = "bash"
vim.opt.showbreak = "> " -- Flag wrapped text and align with the starting text, not the `- `, `* `, etc
vim.opt.showmatch = true -- Jump to the corresponding enclosing char when inserting new ones (ex paren, bracket, etc)
vim.opt.spell = true -- Enable spell checking
vim.opt.spelllang = "en_us" -- ... w/ US English
vim.opt.termsync = false -- scroll faster, at the expense of some "jumps"
vim.opt.textwidth = 100 -- Start new lines after or re-wrap lines (gw) at 100 characters (may be overridden by autocmds.lua)

if os.getenv("VIM_AUTOFORMAT") == "false" then
  vim.g.autoformat = false
end
