return {
  -- TODO: These don't seem to always run (properly) - indent-o-matic doesn't check on start but guess-indent does, but either way they seem to be overriddent by something else.
  --     https://github.com/NMAC427/guess-indent.nvim/issues/3
  -- { "Darazaki/indent-o-matic", opts = {} }, -- Detect indents (shiftwidth, tabstop, etc)
  { "NMAC427/guess-indent.nvim", opts = {} }, -- Detect indents (shiftwidth, tabstop, etc)
  {
    -- Highlights trailing spaces + deletes on write
    --
    -- TODO: Simplify after this is released: https://github.com/kaplanz/retrail.nvim/pull/11
    -- { "kaplanz/retrail.nvim", opts = { hlgroup = "errorMsg" } },
    "kaplanz/retrail.nvim",
    opts = function(_, opts)
      local opts = require("retrail.config").parse(opts)

      opts.hlgroup = "errorMsg"
      opts.enabled.filetype.dashboard = false -- This is the primary
      vim.list_extend(opts.filetype.exclude, { "dashboard" })
      return opts
    end,
  },
}
