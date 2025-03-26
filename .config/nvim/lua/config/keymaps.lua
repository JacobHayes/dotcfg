-- TODO: Add back "space + x", "space + q", "space + w" (instead of LazyVim's ctrl+x, ctrl+q, ctrl+s)
--     - Review what this would override w/ the default LazyVim keymaps (can check with which.nvim by hitting the key OR :WhichKey <leader>q)
-- TODO: Adjust the Alt+{s,m} regex replace to use an easier to type key (alt is harder to type)
-- TODO: Debug "shift line(s) up/down" with Glove80 - it's too easy to accidentally move lines after adding quotes (that get sent as shift?)
-- TODO: Add " bn" and " bp" to navigate between buffers - LazyVim has " bb" for "go back to last buffer", but I often want to navigate left/right
-- TODO: Remap " w|" to " w=" to "split window right" match my tmux (keeping things on thumbs w/ Glove80)
--           Apparently, " -" and " |" are also set (ie: w/o the `w`) - remap those similarly too

-- Alt+s (ß) shortcut for `:s/<cursor>`
vim.keymap.set("n", "ß", [[:%s/]], { desc = "Replace in file", noremap = true })
vim.keymap.set("x", "ß", [[:s/]], { desc = "Replace in file", noremap = true })

-- Alt+m (µ) shortcut for `:s/<last match>/<cursor>/g` - <C-r>/ pastes the search register
vim.keymap.set("n", "µ", [[n:%s/<C-r>///g<Left><Left>]], { desc = "Replace previous search", noremap = true })
vim.keymap.set("x", "µ", [[n:s/<C-r>///g<Left><Left>]], { desc = "Replace previous search", noremap = true })

-- configure tmux<->vim navigation
vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")
vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")

-- faster quit and exit
vim.keymap.set({ "n", "t" }, "<C-q>", ":q<CR>", { silent = true })
vim.keymap.set({ "n", "t" }, "<C-s>", ":w<CR>", { silent = true })
vim.keymap.set({ "n", "t" }, "<C-x>", ":x<CR>", { silent = true })

-- H/L for faster ^/$
vim.keymap.set({ "n", "x" }, "H", "<home>", { desc = "Jump to ^", noremap = true })
vim.keymap.set({ "n", "x" }, "L", "<end>", { desc = "Jump to $", noremap = true })

-- move up/down within wrapped lines (leaving arrow keys for \n nav - override the LazyVim binding)
vim.keymap.set({ "n", "x" }, "<Down>", "j", { silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "k", { silent = true })
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- NOTE: This is buggy - when the buffer is longer than the window, it is a bit jumpy and will
-- occasionally center on the wrong line (especially with repeated searches) or get interrupted by
-- other key presses (eg: `dd`) in the middle of the movement and affect the wrong line.
--
-- -- position search results in center of the page (except when in command mode, which would move down to the next line)a
-- vim.keymap.set("n", "N", "'nN'[v:searchforward].'zz'", { desc = "Prev search result", expr = true, silent = true })
-- vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zz'", { desc = "Next search result", expr = true, silent = true })
-- vim.keymap.set("o", "N", "'nN'[v:searchforward]", { desc = "Prev search result", expr = true, silent = true })
-- vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { desc = "Next search result", expr = true, silent = true })
-- vim.keymap.set("x", "N", "'nN'[v:searchforward].'zz'", { desc = "Prev search result", expr = true, silent = true })
-- vim.keymap.set("x", "n", "'Nn'[v:searchforward].'zz'", { desc = "Next search result", expr = true, silent = true })

-- shift line(s) up/down
vim.keymap.set("n", "<S-Down>", ":move +<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Up>", ":move -2<CR>", { noremap = true, silent = true })
vim.keymap.set("x", "<S-Down>", ":move '>+1<CR>gv", { noremap = true, silent = true })
vim.keymap.set("x", "<S-Up>", ":move '<-2<CR>gv", { noremap = true, silent = true })

-- toggle between buffers/tabs/etc with tab/TAB
vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next tab", silent = true })
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev tab", silent = true })

-- undo history
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", { desc = "Open undo history", silent = true })
