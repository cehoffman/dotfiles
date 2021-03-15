local nvim_lsp = require("lspconfig")
local util = require("lspconfig/util")
local configs = require("lspconfig/configs")

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings
  local opts = {noremap = true, silent = true}
  -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap("n", "<C-]>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- buf_set_keymap('n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('i', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap(
    "n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts
  )
  buf_set_keymap(
    "n", "<space>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts
  )
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

  -- lsp saga
  buf_set_keymap("n", "gh", "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", opts)
  buf_set_keymap(
    "n", "<leader>a", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts
  )
  buf_set_keymap(
    "v", "<leader>a",
    "<cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>", opts
  )
  buf_set_keymap(
    "n", "K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts
  )
  buf_set_keymap(
    "n", "<C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts
  )
  buf_set_keymap(
    "n", "<C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>",
    opts
  )
  buf_set_keymap(
    "n", "gs", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", opts
  )
  buf_set_keymap("n", "gr", "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
  buf_set_keymap(
    "n", "gd", "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", opts
  )
  buf_set_keymap(
    "n", "<space>e", "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>",
    opts
  )
  buf_set_keymap(
    "n", "[d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", opts
  )
  buf_set_keymap(
    "n", "]d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", opts
  )

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      command! -buffer -nargs=0 -bar LspRename lua vim.lsp.buf.rename()
      augroup lsp_document_highlight
          autocmd!
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]], true
    )
  end
end

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true,
}

--[[
  Split the yaml language server into separate servers in order to isolate the
  schemas because the LSP can only set schema based on file name matching and
  kubernetes schemas have infinite file names.
--]]
configs["kubernetes"] = {
  default_config = {
    cmd = {"yaml-language-server", "--stdio"},
    filetypes = {"yaml"},
    root_dir = function(startpath, bufnr)
      if vim.fn.expand("%:t") == "kustomization.yaml" then
        return nil
      end
      if util.path.exists(
        util.path.join(util.path.dirname(startpath), "kustomization.yaml")
      ) then
        return util.find_git_ancestor(startpath) or vim.fn.getcwd()
      end
    end,
    settings = {yaml = {schemas = {kubernetes = {"*.yaml", "*.yml"}}}},
  },
}
configs["kustomization"] = {
  default_config = {
    cmd = {"yaml-language-server", "--stdio"},
    filetypes = {"yaml"},
    root_dir = function(startpath, bufnr)
      if vim.fn.expand("%:t") == "kustomization.yaml" then
        return util.find_git_ancestor(startpath) or vim.fn.getcwd()
      end
    end,
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/kustomization"] = "*/kustomization.yaml",
        },
      },
    },
  },
}
configs["lua"] = {
  default_config = {
    cmd = {"env", "-u", "DYLD_INSERT_LIBRARIES", "efm-langserver"},
    root_dir = function()
      return "/"
    end,
    filetypes = {"lua"},
    init_options = {documentFormatting = true},
    settings = {
      languages = {
        lua = {
          {formatCommand = "lua-format -i --config ~/.lua-format", formatStdin = true},
        },
      },
    },
  },
}

local servers = {
  gopls = {
    on_attach = function(client, bufnr)
      vim.cmd [[autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()]]
    end,
    settings = {gopls = {gofumpt = true, linksInHover = false}},
  },
  vimls = {},
  kubernetes = {},
  kustomization = {},
  bashls = {filetypes = {"sh", "zsh", "bash"}},
  dockerls = {},
  tsserver = {
    on_attach = function(client, bufnr)
      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end
      -- disable formating because eslint will do it
      client.resolved_capabilities.document_formatting = false
    end,
  },
  efm = {
    cmd = {"env", "-u", "DYLD_INSERT_LIBRARIES", "efm-langserver"},
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = true
      client.resolved_capabilities.goto_definition = false
    end,
    root_dir = util.root_pattern(".git", ".eslintrc"),
    settings = {
      languages = {
        javascript = {eslint},
        javascriptreact = {eslint},
        ["javascript.jsx"] = {eslint},
        typescript = {eslint},
        ["typescript.tsx"] = {eslint},
        typescriptreact = {eslint},
      },
    },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescript.tsx",
      "typescriptreact",
    },
  },
  lua = {
    on_attach = function(client, bufnr)
      vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 100)]]
    end,
  },
}

if 1 == vim.fn.executable("terraform-ls") then
  servers.terraformls = {}
end

for lsp, opts in pairs(servers) do
  if opts.on_attach then
    opts.on_attach = util.add_hook_after(opts.on_attach, on_attach)
  else
    opts.on_attach = on_attach
  end
  nvim_lsp[lsp].setup(opts)
end

require("nlua.lsp.nvim").setup(
  require("lspconfig"), {
    cmd = {
      vim.fn.expand("~/.homebrew/Cellar/lua-language-server/HEAD/bin/lua-language-server"),
      "-E",
      vim.fn.expand("~/.homebrew/Cellar/lua-language-server/HEAD/libexec/main.lua"),
    },
    on_attach = on_attach,
  }
)
