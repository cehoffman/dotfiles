return {
	"RRethy/vim-illuminate",
	opts = function(_, opts)
		vim.list_extend(opts.filetypes_denylist or {}, { "help", "man" })
	end,
}
