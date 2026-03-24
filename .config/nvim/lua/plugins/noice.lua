return {
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			opts.routes = opts.routes or {}

			table.insert(opts.routes, {
				filter = {
					event = "msg_show",
					kind = { "shell_out", "shell_err" },
				},
				view = "split",
				opts = {
					level = "info",
					skip = false,
					replace = false,
				},
			})
		end,
	},
}
