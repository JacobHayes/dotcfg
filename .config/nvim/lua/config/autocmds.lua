vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    local textwidth = vim.env.MD_TEXTWIDTH and tonumber(vim.env.MD_TEXTWIDTH) or 0
    vim.opt.textwidth = textwidth
  end,
  once = true,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    -- TODO: Lookup the line-length setting from eg: ruff's pyproject config
    local textwidth = vim.env.PY_TEXTWIDTH and tonumber(vim.env.PY_TEXTWIDTH) or 120
    vim.opt.textwidth = textwidth
  end,
  once = true,
})
