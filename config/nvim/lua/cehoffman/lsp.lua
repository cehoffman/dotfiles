local nvim_lsp = require("lspconfig")
local util = require("lspconfig.util")
local configs = require("lspconfig.configs")

local on_attach = function(client, bufnr)
  local opts = {buffer = bufnr, silent = true, noremap = true}
  local nnoremap = function(lhs, rhs, ...)
    vim.keymap.set(
      "n", lhs, rhs,
      vim.tbl_extend("keep", vim.empty_dict(), ... or vim.empty_dict(), opts)
    )
  end
  local inoremap = function(lhs, rhs, ...)
    vim.keymap.set(
      "i", lhs, rhs,
      vim.tbl_extend("keep", vim.empty_dict(), ... or vim.empty_dict(), opts)
    )
  end
  local vnoremap = function(lhs, rhs, ...)
    vim.keymap.set(
      "v", lhs, rhs,
      vim.tbl_extend("keep", vim.empty_dict(), ... or vim.empty_dict(), opts)
    )
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings
  if client.server_capabilities.definitionProvider then
    nnoremap("<C-]>", vim.lsp.buf.definition)
  end
  if client.server_capabilities.implementationProvider then
    nnoremap("gi", vim.lsp.buf.implementation)
  end
  if client.server_capabilities.signatureHelpProvider then
    nnoremap("<C-s>", vim.lsp.buf.signature_help)
    inoremap("<C-s>", vim.lsp.buf.signature_help)
  end
  nnoremap("<space>wa", vim.lsp.buf.add_workspace_folder)
  nnoremap("<space>wr", vim.lsp.buf.remove_workspace_folder)
  nnoremap(
    "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>"
  )
  if client.server_capabilities.typeDefinitionProvider then
    nnoremap("<space>D", vim.lsp.buf.type_definition)
  end

  -- lsp saga
  if client.server_capabilities.referencesProvider then
    nnoremap("gh", "<cmd>Lspsaga lsp_finder<CR>")
  end
  if client.server_capabilities.codeActionProvider then
    nnoremap("<leader>a", "<cmd>Lspsaga code_action<CR>")
  end
  if client.server_capabilities.hoverProvider then
    nnoremap("K", "<cmd>Lspsaga hover_doc<CR>")
  end
  if client.server_capabilities.renameProvider then
    nnoremap("gr", "<cmd>Lspsaga rename<CR>")
  end
  if client.server_capabilities.definitionProvider then
    nnoremap("gd", "<cmd>Lspsaga peek_definition<CR>")
  end
  nnoremap("<space>d", "<cmd>Lspsaga show_line_diagnostics<CR>")
  nnoremap("[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
  nnoremap("]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    nnoremap("<space>f", "<cmd>lua vim.lsp.buf.format({async = true})<CR>")
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({async = false, timeout_ms = 1000})]]
  elseif client.server_capabilities.documentRangeFormattingProvider then
    nnoremap("<space>f", "<cmd>lua vim.lsp.buf.format({async = true})<CR>")
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({async = false, timeout_ms = 1000})]]
  end

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_exec(
      [[
      command! -buffer -nargs=0 -bar LspRename lua vim.lsp.buf.rename()
      augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]], false
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
configs.kubernetes = {
  default_config = {
    autostart = false,
    cmd = {"yaml-language-server", "--stdio"},
    filetypes = {"yaml"},
    root_dir = function(startpath, bufnr)
      if string.find(vim.fn.expand("%:t"), "kubectl-") then
        return "/"
      end
      if vim.fn.expand("%:t") == "kustomization.yaml" then
        return nil
      end
      if util.path.exists(
        util.path.join(util.path.dirname(startpath), "kustomization.yaml")
      ) then
        return util.find_git_ancestor(startpath) or vim.fn.getcwd()
      end
      return nil
    end,
    settings = {yaml = {schemas = {kubernetes = {"*.yaml", "*.yml"}}}},
    single_file_support = true,
  },
}
configs.kustomization = {
  default_config = {
    autostart = false,
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
    single_file_support = true,
  },
}
configs.lua = {
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
  gopls = {settings = {gopls = {gofumpt = true, linksInHover = false}}},
  vimls = {},
  kubernetes = {},
  kustomization = {},
  yamlls = {
    autostart = false,
    root_dir = function(startpath, bufnr)
      -- bail on helm charts
      if util.path.exists(util.path.join(vim.fn.expand("%:h:h"), "Chart.yaml")) then
        return nil
      end

      local noMatches = true
      for _, server in ipairs({"kubernetes", "kustomization"}) do
        if nvim_lsp[server] and nvim_lsp[server].get_root_dir(startpath, bufnr) == nil then
          noMatches = false
        end
      end
      if noMatches then
        return "/"
      end
      return nil
    end,
  },
  bashls = {filetypes = {"sh", "zsh", "bash"}},
  dockerls = {},
  tsserver = {
    on_attach = function(client, bufnr)
      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end
      -- disable formating because eslint will do it
      client.server_capabilities.documentFormattingProvider = false
    end,
  },
  efm = {
    cmd = {"env", "-u", "DYLD_INSERT_LIBRARIES", "efm-langserver"},
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = true
      client.server_capabilities.definitionProvider = false
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
  lua = {},
}

local blackExe = vim.fn.expand("~/.venvs/black/bin/black")
if 1 == vim.fn.executable(blackExe) then
  configs["black"] = {
    default_config = {
      cmd = {"env", "-u", "DYLD_INSERT_LIBRARIES", "efm-langserver"},
      root_dir = util.root_pattern(".git", "pyproject.toml"),
      filetypes = {"python"},
      init_options = {documentFormatting = true},
      settings = {
        languages = {python = {{formatCommand = blackExe .. " -", formatStdin = true}}},
      },
    },
  }
  servers.black = {}
end

local jedi = vim.fn.expand("~/.venvs/jedi/bin/jedi-language-server")
if 1 == vim.fn.executable(jedi) then
  servers.jedi_language_server = {
    cmd = {jedi},
    root_dir = util.root_pattern("pyproject.toml"),
  }
end

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
