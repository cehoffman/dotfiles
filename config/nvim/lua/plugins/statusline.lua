return {
	"nvim-lualine/lualine.nvim",
	opts = function(_, opts)
		local colors = require("tokyonight.colors").setup()
		local exts

		opts.sections.lualine_a = {
			{
				"mode",
				fmt = function(str)
					return str:sub(1, 1):lower()
				end,
				color = { gui = "bold" },
			},
		}
		-- vim.list_extend(opts.sections.lualine_c[#opts.sections.lualine_c], { separator = "" })
		-- vim.list_extend(
		--   opts.sections.lualine_c,
		--   { "%M", separator = "", color = { fg = colors.red1, bg = colors.bg_dark } }
		-- )

		-- Remove unwanted sections from lualine_c
		for i, section in ipairs(opts.sections.lualine_c) do
			-- The Aerial symbol outline extra adds the heirarchy to the statusline
			-- Lspsaga puts this in the winbar, so prefer that
			if section[1] == "aerial" then
				table.remove(opts.sections.lualine_c, i)
			end

			-- Remove the file type icon, it is moved to the right side of statusline
			if section[1] == "filetype" then
				table.remove(opts.sections.lualine_c, i)
				-- table.remove(opts.sections.lualine_c, 3)
				table.insert(opts.sections.lualine_c, i, {
					"%{&readonly ? '' : ''}",
					separator = "",
					colors = { fg = colors.red1 },
					padding = { left = 1, right = 0 },
				})
			end
		end

		-- Remove an extra space after the icon
		opts.sections.lualine_c[1] = require("lazyvim.util").lualine.root_dir({ icon = "󱉭" })

		opts.sections.lualine_c[#opts.sections.lualine_c].separator = ""
		vim.list_extend(opts.sections.lualine_c, {
			{ "%(%H%W%)", colors = { gui = "bold" } },
		})
		vim.list_extend(opts.sections.lualine_x, {
			{ "%{&fileformat} %{WebDevIconsGetFileFormatSymbol()} %{(&fenc == '' ? &enc : &fenc)}" },
			{
				"filetype",
				-- Leave this here if want the n/a output
				-- "%{WebDevIconsGetFileTypeSymbol()} %{strlen(&ft) ? &ft : 'n/a'}",
				padding = { left = 1, right = 1 },
			},
		})
		opts.sections.lualine_y = {
			{ "progress", separator = "", padding = { left = 1, right = 1 } },
		}
		opts.sections.lualine_z = {
			{
				function()
					return ""
				end,
				separator = "",
				padding = { left = 1, right = 0 },
			},
			{ "%l", separator = ":", padding = { left = 1, right = 0 }, color = { gui = "bold" } },
			{ "%c", separator = "", padding = { left = 0, right = 1 } },
			-- { "location", padding = { left = 0, right = 1 } },
		}

		exts = {
			{
				sections = {
					lualine_a = opts.sections.lualine_a,
					lualine_b = {
						function()
							return "HELP"
						end,
					},
					lualine_y = opts.sections.lualine_y,
					lualine_z = opts.sections.lualine_z,
				},
				filetypes = { "help" },
			},
			{
				sections = {
					lualine_a = opts.sections.lualine_a,
					lualine_b = {
						function()
							return "SCRATCH"
						end,
					},
					lualine_y = opts.sections.lualine_y,
					lualine_z = opts.sections.lualine_z,
				},
				filetypes = { "scratch" },
			},
			{
				sections = {
					lualine_a = opts.sections.lualine_a,
					lualine_b = {
						function()
							return "COMMIT MESSAGE"
						end,
					},
					lualine_y = opts.sections.lualine_y,
					lualine_z = opts.sections.lualine_z,
				},
				filetypes = { "gitcommit" },
			},
		}

		vim.list_extend(opts.extensions, exts)
		return opts
	end,
}
