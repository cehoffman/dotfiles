require("cehoffman.util").au("packer_recompile", "BufWritePost plugins.lua PackerCompile")

return require("packer").startup {
  function(use)
    use "wbthomason/packer.nvim"
    use { "tjdevries/astronauta.nvim", commit = "e69d7bdc4183047c4700427922c4a3cc1e3258c6" }
    use "tpope/vim-jdaddy"
    use "tpope/vim-capslock"
    use "tpope/vim-fugitive"
    use "rhysd/committia.vim"
    use { "rhysd/git-messenger.vim", config = require("cehoffman.gitmessenger").init }
    use "tpope/vim-git"
    use {
      "airblade/vim-gitgutter",
      setup = function()
        vim.g.gitgutter_diff_args = "-w"
        vim.g.gitgutter_sign_priority = 1
      end,
    }
    use {
      "lambdalisue/suda.vim",
      cmd = { "SudaRead", "SudaWrite" },
      setup = function()
        vim.g.suda_smart_edit = false
      end,
    }
    use {
      "pwntester/octo.nvim",
      after = { "telescope.nvim" },
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require("octo").setup()
      end,
    }
    -- use "tpope/vim-endwise"
    use {
      "RRethy/nvim-treesitter-endwise",
      config = function()
        require("nvim-treesitter.configs").setup({ endwise = { enable = true } })
      end,
    }
    use { "kristijanhusak/vim-dadbod-ui", requires = { { "tpope/vim-dadbod" } } }
    use { "kristijanhusak/vim-dadbod-completion", requires = { { "tpope/vim-dadbod" } } }
    use { "tpope/vim-rails", ft = { "ruby" } }
    use { "tpope/vim-rake", ft = { "ruby" } }
    use { "ecomba/vim-ruby-refactoring", ft = { "ruby" } }
    use "ryanoasis/vim-devicons"
    use {
      "nelstrom/vim-textobj-rubyblock",
      ft = { "ruby" },
      requires = { { "kana/vim-textobj-user" } },
    }
    use "tpope/vim-surround"
    use "tpope/vim-unimpaired"
    use "tpope/vim-abolish"
    use "tpope/vim-repeat"
    use "tpope/vim-bundler"
    use "tpope/vim-commentary"
    use "tpope/vim-markdown"
    use "tpope/vim-eunuch"
    use "tpope/vim-scriptease"
    use "tpope/vim-dispatch"
    use "tpope/vim-projectionist"
    use "tpope/vim-obsession"
    use "tpope/vim-ragtag"
    use "moll/vim-bbye"
    use "dstein64/vim-startuptime"
    use { "andymass/vim-matchup", event = "VimEnter *" }
    use "hashivim/vim-terraform"
    use {
      "norcalli/nvim-terminal.lua",
      config = function()
        require("terminal").setup()
      end,
    }
    use { "jason0x43/vim-js-indent", ft = { "javascript" } }
    use { "leafgarland/typescript-vim", ft = { "typescript", "typescriptreact" } }
    use { "peitalin/vim-jsx-typescript", ft = { "typescriptreact", "jsx" } }
    use { "moll/vim-node", ft = { "javascript" } }
    -- use { "vim-scripts/Match-Bracket-for-Objective-C", ft = { "objc" } }
    use "markcornick/vim-bats"
    -- TODO: investigate if this is replaced with LSP or LSP Saga
    -- use {
    --   "mhinz/vim-mix-format",
    --   ft = { "elixir" },
    --   setup = function()
    --     vim.g.mix_format_on_save = true
    --     vim.g.mix_format_options = "--check-equivalent"
    --   end,
    -- }
    -- use { "slashmili/alchemist.vim", ft = { "elixir" } }
    -- use { "elixir-editors/vim-elixir", ft = { "elixir" } }
    -- use { "jeetsukumaran/vim-pythonsense", ft = { "python" } }
    use {
      "fatih/vim-go",
      ft = { "go" },
      run = ":GoUpdateBinaries",
      setup = function()
        vim.g.go_def_mapping_enabled = 0
        vim.g.go_doc_keywordprg_enabled = 0
        vim.g.go_gopls_enabled = 0
        vim.g.go_code_completion_enabled = 0
        vim.g.go_imports_autosave = 1
        vim.g.go_asmfmt_autosave = 1
        vim.g.go_template_use_pkg = 1
      end,
    }
    use "jodosha/vim-godebug"
    use "MarcWeber/vim-addon-local-vimrc"
    use {
      "mhinz/vim-grepper",
      cmd = { "Grepper" },
      setup = function()
        vim.g.grepper = {
          tools = { "rg", "ag", "git", "ack", "grep" },
          simple_prompt = true,
          prompt_quote = true,
          switch = false,
        }
      end,
    }
    -- use "Raimondi/delimitMate"
    use {
      "abecodes/tabout.nvim",
      require = { "nvim-treesitter" },
      after = { "nvim-cmp" },
      config = function()
        require("tabout").setup {
          tabkey = "<Tab>",             -- key to trigger tabout, set to an empty string to disable
          backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
          act_as_tab = true,            -- shift content if tab out is not possible
          act_as_shift_tab = false,     -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
          default_tab = "<C-t>",        -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
          default_shift_tab = "<C-d>",  -- reverse shift default action,
          enable_backwards = true,      -- well ...
          completion = true,            -- if the tabkey is used in a completion pum
          tabouts = {
            { open = "'",  close = "'" },
            { open = "\"", close = "\"" },
            { open = "`",  close = "`" },
            { open = "(",  close = ")" },
            { open = "[",  close = "]" },
            { open = "{",  close = "}" },
          },
          ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
          exclude = {}, -- tabout will ignore these filetypes
        }
      end,
    }
    use "SirVer/UltiSnips"
    use "honza/vim-snippets"
    use "godlygeek/tabular"
    use "jamessan/vim-gnupg"
    use "vim-scripts/scratch.vim"
    use {
      "sjl/splice.vim",
      setup = function()
        vim.g.splice_initial_mode = "grid"
        vim.g.splice_initial_diff_grid = 1
        vim.g.splice_initial_diff_compare = 1
        vim.g.splice_initial_diff_path = 4
        vim.g.splice_initial_layout_grid = 1
        vim.g.splice_initial_layout_compare = 1
        vim.g.splice_initial_layout_path = 1
        vim.g.splice_initial_scrollbind_loupe = 1
        vim.g.splice_initial_scrollbind_compare = 1
        vim.g.splice_initial_scrollbind_path = 1
      end,
    }
    use {
      "AndrewRadev/splitjoin.vim",
      setup = function()
        vim.g.splitjoin_align = 1
        vim.g.splitjoin_normalize_whitespace = 1
      end,
    }
    use {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.5",
      requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
      config = function()
        require("telescope").setup(
          { defaults = { mappings = { i = { ["<ESC>"] = require("telescope.actions").close } } } }
        )
      end,
    }
    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      after = { "telescope.nvim" },
      run = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    }
    use {
      "nvim-telescope/telescope-frecency.nvim",
      config = function()
        require("telescope").load_extension("frecency")
      end,
    }
    use "mbbill/undotree"
    use { "junegunn/goyo.vim", cmd = { "Goyo" } }
    use {
      "junegunn/limelight.vim",
      cmd = { "Limelight" },
      setup = function()
        vim.g.limelight_conceal_ctermfg = 240
      end,
    }
    use {
      "christoomey/vim-tmux-navigator",
      requires = { { "sjl/vitality.vim" } },
      setup = function()
        vim.g.tmux_navigator_save_on_switch = 1
      end,
    }
    use "ConradIrwin/vim-bracketed-paste"
    use "wellle/targets.vim"
    use {
      "machakann/vim-highlightedyank",
      setup = function()
        vim.g.highlightedyank_highlight_duration = 200
      end,
    }
    use { "rhysd/vim-clang-format", ft = { "arduino", "c", "cpp" } }
    use "psliwka/vim-smoothie"
    use "gyim/vim-boxdraw"
    use { "junegunn/fzf", run = ":call fzf#install()" }
    use {
      "liuchengxu/vista.vim",
      setup = function()
        vim.g["vista#renderer#enable_icon"] = 1
      end,
    }
    use {
      "xuhdev/vim-latex-live-preview",
      ft = { "tex" },
      setup = function()
        vim.g.livepreview_previewer = "open -a Preview"
      end,
    }
    use {
      "mhinz/vim-startify",
      config = function()
        vim.g.startify_fortune_use_unicode = 1
        vim.g.startify_custom_header = "startify#center(startify#fortune#boxed())"
        vim.cmd [[command! -nargs=? -bar -bang -complete=customlist,startify#session_list SSave  call startify#session_save(<bang>0, <f-args>) | if !empty(v:this_session) | execute "Obsession " . v:this_session | endif]]
      end,
    }
    use {
      "glacambre/firenvim",
      run = function()
        vim.fn["firenvim#install"](0)
      end,
    }
    use {
      "nvimdev/indentmini.nvim",
      event = "BufEnter",
      config = function()
        require("indentmini").setup(
          {
            -- char = "|",
            -- exclude = {
            --     "erlang",
            --     "markdown",
            -- }
          }
        )
      end,
    }
    use {
      "neovim/nvim-lspconfig",
      config = function()
        require("cehoffman.lsp")
      end,
    }
    use {
      "nvimdev/lspsaga.nvim",
      after = "nvim-lspconfig",
      config = function()
        require("lspsaga").setup(
          {
            ui = {
              expand = "",
              collaspe = "",
              preview = " ",
              diagnostic = "⚑",
              code_action = "➜ ",
              incoming = " ",
              outgoing = " ",
            },
            -- diagnostic_header = { "✖", "‼", , "➜" },
            -- code_action_icon = ,
            -- finder_icons = { def = "❃ ", ref = "❃ ", link = "❃ " },
            -- border_style = "single",
            -- code_action_keys = { quit = { "<esc>", "q" } },
            -- finder_action_keys = { quit = { "<esc>", "q" } },
            -- rename_action_quit = { "<esc>", "<C-c>" },
          }
        )
      end,
    }
    use "folke/neodev.nvim"
    use "folke/neoconf.nvim"
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "quangnguyen30192/cmp-nvim-ultisnips"
    use "hrsh7th/nvim-cmp"
    use {
      "n0v1c3/vira",
      config = function()
        vim.g.vira_serv = "https://flockfreight.atlassian.net"
        vim.g.vira_report_width = 80
      end,
    }
    use { "earthly/earthly.vim", commit = "main" }
    use "towolf/vim-helm"
    use "satabin/hocon-vim"
    use "coddingtonbear/confluencewiki.vim"
    use "mracos/mermaid.vim"
    use "github/copilot.vim"
  end,
  config = { display = { non_interactive = nil ~= os.getenv("NVIM_UPDATE") } },
}
