vim.lsp.enable 'lua_ls'
vim.lsp.enable 'clangd'
vim.lsp.enable 'pylsp'
vim.lsp.enable 'java_language_server'
vim.lsp.enable 'marksman'

vim.lsp.config("vtsls", {
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  settings = {
    vtsls = { tsserver = { globalPlugins = {} } },
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
  before_init = function(_, config)
    table.insert(config.settings.vtsls.tsserver.globalPlugins, {
      name = "@vue/typescript-plugin",
      location = vim.fn.expand(
        "$MASON/packages/vue-language-server/node_modules/@vue/language-server"
      ),
      languages = { "vue" },
      configNamespace = "typescript",
      enableForWorkspaceTypeScriptVersions = true,
    })
  end,
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
})

-- Define LSP-related keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = event.buf, desc = 'LSP: Rename' })

    -- Diagnostics
    vim.keymap.set('n', 'gl', function()
      vim.diagnostic.open_float { source = true }
    end, { buffer = event.buf, desc = 'LSP: Show Diagnostic' })

    -- folding
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.supports_method 'textDocument/foldingRange' then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end

    -- Highlight words under cursor
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) and vim.bo.filetype ~= 'bigfile' then
      local highlight_augroup = vim.api.nvim_create_augroup('shinn-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('shinn-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'shinn-lsp-highlight', buffer = event2.buf }
          -- vim.cmd 'setl foldexpr <'
        end,
      })
    end
  end,
})

-- diagnostic UI touches
-- local icons = require 'mini.icons'
vim.diagnostic.config {
  -- virtual_lines = { current_line = true },
  virtual_text = {
    spacing = 5,
    prefix = '◍ ',
  },
  float = { severity_sort = true },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
}

local api, lsp = vim.api, vim.lsp
api.nvim_create_user_command('LspInfo', ':checkhealth vim.lsp', { desc = 'Alias to `:checkhealth vim.lsp`' })
api.nvim_create_user_command('LspLog', function()
  vim.cmd(string.format('tabnew %s', lsp.get_log_path()))
end, {
  desc = 'Opens the Nvim LSP client log.',
})
local complete_client = function(arg)
  return vim
      .iter(vim.lsp.get_clients())
      :map(function(client)
        return client.name
      end)
      :filter(function(name)
        return name:sub(1, #arg) == arg
      end)
      :totable()
end
api.nvim_create_user_command('LspRestart', function(info)
  for _, name in ipairs(info.fargs) do
    if vim.lsp.config[name] == nil then
      vim.notify(("Invalid server name '%s'"):format(info.args))
    else
      vim.lsp.enable(name, false)
    end
  end

  local timer = assert(vim.uv.new_timer())
  timer:start(500, 0, function()
    for _, name in ipairs(info.fargs) do
      vim.schedule_wrap(function(x)
        vim.lsp.enable(x)
      end)(name)
    end
  end)
end, {
  desc = 'Restart the given client(s)',
  nargs = '+',
  complete = complete_client,
})
