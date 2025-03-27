# Try to detect filetypes for CLIs with shebangs but no extension.
local match_shebang = function(path, bufnr)
  local line1 = vim.api.nvim_buf_get_lines(bufnr, 0, 1, true)[1]
  if string.find(line1, "^#!/usr/bin/env %-S uv run") then
    return "python"
  end
end

local extensionless_file = "[%a%d-_]*"
vim.filetype.add({
  pattern = {
    [extensionless_file] = match_shebang,
  },
})
