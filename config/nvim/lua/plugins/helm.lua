return {
  { "towolf/vim-helm", ft = "helm" },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "helm-ls" })
    end,
  },
  {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          helm_ls = {},
        },
      },
    },
  },
}
