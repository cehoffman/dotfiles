return {
  {
    "christoomey/vim-tmux-navigator",
    dependencies = { "sjl/vitality.vim" },
    init = function()
      vim.g.tmux_navigator_save_on_switch = 1
    end,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
    enabled = false,
  },
  {
    "numToStr/Navigator.nvim",
    event = "VeryLazy",
    opts = {
      auto_save = true,
      disable_on_zoom = true,
    },
    keys = {
      { "<C-h>",  "<cmd>NavigatorLeft<cr>" },
      { "<C-j>",  "<cmd>NavigatorDown<cr>" },
      { "<C-k>",  "<cmd>NavigatorUp<cr>" },
      { "<C-l>",  "<cmd>NavigatorRight<cr>" },
      { "<C-\\>", "<cmd>NavigatorPrevious<cr>" },
    },
  },
}
