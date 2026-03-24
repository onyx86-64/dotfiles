return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.routes = opts.routes or {}

      table.insert(opts.routes, {
        filter = { event = "msg_show" },
        view = "notify",
        opts = {
          level = "info",
          skip = false,
          replace = false,
        },
      })
    end,
  },
}
