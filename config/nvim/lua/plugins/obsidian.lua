return {
  "epwalsh/obsidian.nvim",
  version = "*",
  ft = "markdown",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    workspaces = {
      {
        name = "world",
        path = "/Users/christopherhoffman/Library/Mobile Documents/com~apple~CloudDocs/World",
      },
    },
    notes_subdir = "3 - Resources/notes",
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true, desc = "Follow link" },
      },
    },
  },
}
