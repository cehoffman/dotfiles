return require("packer").startup {
  function(use)
    use "wbthomason/packer.nvim"
    use "tjdevries/astronauta.nvim"
    use "tpope/vim-jdaddy"
    use "tpope/vim-capslock"
    use "tpope/vim-fugitive"
    use {"rhysd/git-messenger.vim", config = require("cehoffman.gitmessenger").init}
    use "tpope/vim-git"
    use {
      "airblade/vim-gitgutter",
      setup = function()
        vim.g.gitgutter_diff_args = "-w"
        vim.g.gitgutter_sign_priority = 1
      end,
    }
    use {"pwntester/octo.nvim", after = {"telescope.nvim"}}
    use {
      "tpope/vim-endwise",
      setup = function()
        -- Compe will call delimitMate and EndWise
        vim.g.endwise_no_mappings = true
      end,
    }
    use "tpope/vim-dadbod"
    use {"kristijanhusak/vim-dadbod-ui", after = {"vim-dadbod"}}
    use {"kristijanhusak/vim-dadbod-completion", after = {"vim-dadbod"}}
    use {"tpope/vim-rails", ft = {"ruby"}}
    use {"tpope/vim-rake", ft = {"ruby"}}
    use {"ecomba/vim-ruby-refactoring", ft = {"ruby"}}
    use {"nelstrom/vim-textobj-rubyblock", ft = {"ruby"}, after = {"vim-textobj-user"}}
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
    use {"andymass/vim-matchup", event = "VimEnter *"}
    use "hashivim/vim-terraform"
    use "norcalli/nvim-terminal.lua"
    use {"jason0x43/vim-js-indent", ft = {"javascript"}}
    use {"leafgarland/typescript-vim", ft = {"typescript", "typescriptreact"}}
    use {"peitalin/vim-jsx-typescript", ft = {"typescriptreact", "jsx"}}
    use {"moll/vim-node", ft = {"javascript"}}
    use {"vim-scripts/Match-Bracket-for-Objective-C", ft = {"objc"}}
    use "markcornick/vim-bats"
    use {
      "mhinz/vim-mix-format",
      ft = {"elixir"},
      setup = function()
        vim.g.mix_format_on_save = true
        vim.g.mix_format_options = "--check-equivalent"
      end,
    }
    use {"slashmili/alchemist.vim", ft = {"elixir"}}
    use {"elixir-editors/vim-elixir", ft = {"elixir"}}
    use {
      "fatih/vim-go",
      ft = {"go"},
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
      cmd = {"Grepper"},
      setup = function()
        vim.g.grepper = {
          tools = {"rg", "ag", "git", "ack", "grep"},
          simple_prompt = true,
          prompt_quote = true,
          switch = false,
        }
      end,
    }
    use "Raimondi/delimitMate"
    use "SirVer/UltiSnips"
    use "honza/vim-snippets"
    use "godlygeek/tabular"
    use "kana/vim-textobj-user"
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
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use {
      "nvim-telescope/telescope.nvim",
      after = {"plenary.nvim", "popup.nvim"},
      config = function()
        require("telescope").setup(
          {defaults = {mappings = {i = {["<ESC>"] = require("telescope.actions").close}}}}
        )
      end,
    }
    use {
      "nvim-telescope/telescope-fzy-native.nvim",
      after = {"telescope.nvim"},
      config = function()
        require("telescope").load_extension("fzy_native")
      end,
    }
    use "mbbill/undotree"
    use {"junegunn/goyo.vim", cmd = {"Goyo"}}
    use {
      "junegunn/limelight.vim",
      cmd = {"Limelight"},
      setup = function()
        vim.g.limelight_conceal_ctermfg = 240
      end,
    }
    use "sjl/vitality.vim"
    use {
      "christoomey/vim-tmux-navigator",
      after = {"vitality.vim"},
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
    use {"rhysd/vim-clang-format", ft = {"arduino", "c", "cpp"}}
    use "psliwka/vim-smoothie"
    use "gyim/vim-boxdraw"
    use "liuchengxu/vista.vim"
    use {
      "xuhdev/vim-latex-live-preview",
      ft = {"tex"},
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
      "neovim/nvim-lspconfig",
      config = function()
        require("cehoffman.lsp")
      end,
    }
    use {
      "glepnir/lspsaga.nvim",
      config = function()
        require("lspsaga").init_lsp_saga(
          {
            error_sign = "✖",
            warn_sign = "‼",
            hint_sign = "➜",
            infor_sign = "⚑",
            dianostic_header_icon = " ‼️  ",
            code_action_icon = "➜ ",
            finder_definition_icon = "❃ ",
            finder_reference_icon = "❃ ",
            definition_preview_icon = "❃ ",
            border_style = 2,
            code_action_keys = {quit = {"<esc>", "q"}},
            finder_action_keys = {quit = {"<esc>", "q"}},
            rename_action_keys = {quit = {"<esc>", "<C-c>"}},
          }
        )
      end,
    }
    use "tjdevries/nlua.nvim"
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use "hrsh7th/nvim-compe"
  end,
}
