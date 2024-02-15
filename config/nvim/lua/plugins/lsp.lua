-- if true then
--   return {}
-- end
return {
  { "folke/neoconf.nvim", opts = { import = { vscode = false } } },
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      -- disable a keymap
      keys[#keys + 1] = { "K", false }
      -- add a keymap
      -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
    end,
    -- config = function(_, opts)
    --   -- Update configuration for change of where gofumpt lives in gopls. At some
    --   -- point in time the upstream will reflect this change.
    --   -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/go.lua#L24
    --   opts.servers.gopls.settings.gopls.formatting = { gofumpt = true }
    --   opts.servers.gopls.settings.gopls.gofumpt = nil
    -- end,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        ui = {
          expand = "",
          collaspe = "",
          preview = " ",
          diagnostic = "⚑",
          code_action = "➜ ",
          incoming = " ",
          outgoing = " ",
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons",  -- optional
    },
  },
}
