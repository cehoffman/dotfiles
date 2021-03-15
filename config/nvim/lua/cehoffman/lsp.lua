local nvim_lsp = require("lspconfig")
local util = require("lspconfig/util")
local configs = require("lspconfig/configs")

local on_attach = function(client, bufnr)
  local opts = {buffer = bufnr, silent = true}
  local nnoremap = function(args)
    vim.keymap.nnoremap(vim.tbl_extend("keep", vim.empty_dict(), args, opts))
  end
  local inoremap = function(args)
    vim.keymap.inoremap(vim.tbl_extend("keep", args, opts))
  end
  local vnoremap = function(args)
    vim.keymap.vnoremap(vim.tbl_extend("keep", args, opts))
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings
  -- nnoremap{'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>'}
  -- nnoremap{'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>'}
  if client.resolved_capabilities.goto_definition then
    nnoremap {"<C-]>", "<Cmd>lua vim.lsp.buf.definition()<CR>"}
  end
  -- nnoremap{'K', '<Cmd>lua vim.lsp.buf.hover()<CR>'}
  if client.resolved_capabilities.implementation then
    nnoremap {"gi", "<cmd>lua vim.lsp.buf.implementation()<CR>"}
  end
  if client.resolved_capabilities.signature_help then
    -- nnoremap{'<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>'}
    inoremap {"<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>"}
  end
  nnoremap {"<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>"}
  nnoremap {"<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>"}
  nnoremap {
    "<space>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
  }
  if client.resolved_capabilities.type_definition then
    nnoremap {"<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>"}
  end
  nnoremap {"<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>"}

  -- lsp saga
  if client.resolved_capabilities.find_references then
    nnoremap {"gh", "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>"}
  end
  if client.resolved_capabilities.code_action then
    nnoremap {"<leader>a", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>"}
    vnoremap {
      "<leader>a",
      "<cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>",
    }
  end
  if client.resolved_capabilities.hover then
    nnoremap {"K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>"}
    nnoremap {"<C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>"}
    nnoremap {
      "<C-b>",
      "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>",
    }
  end
  if client.resolved_capabilities.signature_help then
    nnoremap {"gs", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>"}
  end
  if client.resolved_capabilities.rename then
    nnoremap {"gr", "<cmd>lua require('lspsaga.rename').rename()<CR>"}
  end
  nnoremap {"gd", "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>"}
  nnoremap {
    "<space>e",
    "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>",
  }
  nnoremap {"[d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>"}
  nnoremap {"]d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>"}

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    nnoremap {"<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>"}
  elseif client.resolved_capabilities.document_range_formatting then
    nnoremap {"<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>"}
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
  servers.black = {
    on_attach = function(client, bufnr)
      vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
    end,
  }
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
