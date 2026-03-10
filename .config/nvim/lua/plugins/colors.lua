return {
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl)
        hl.Normal = { fg = "#9f999b", bg = "#1d2021" }
        hl.NormalFloat = { fg = "#9f999b", bg = "#1d2021" }
        hl.Visual = { bg = "#2f2d2e" }

        hl.Identifier = { fg = "#d79921" }
        hl["@variable"] = { fg = "#d79921" }
      end,
    },
  },
}
