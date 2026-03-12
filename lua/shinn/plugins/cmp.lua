return {
  'hrsh7th/nvim-cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
    'hrsh7th/cmp-cmdline',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    require('luasnip.loaders.from_vscode').lazy_load()

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<Tab>'] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
            return
          end
          fallback()
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
            return
          end
          fallback()
        end, { 'i', 's' }),
        ['<A-/>'] = cmp.mapping(function(fallback)
          if not cmp.visible() then
            cmp.complete()
            return
          end

          if type(cmp.visible_docs) == 'function' and cmp.visible_docs() then
            if type(cmp.close_docs) == 'function' then
              cmp.close_docs()
            else
              fallback()
            end
            return
          end

          if type(cmp.open_docs) == 'function' then
            cmp.open_docs()
          else
            fallback()
          end
        end, { 'i' }),
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<CR>'] = cmp.mapping.confirm { select = false },
      },
      formatting = {
        format = function(_, vim_item)
          local kind_icon, hl, _ = require('mini.icons').get('lsp', vim_item.kind)
          vim_item.kind = string.format('%s %s', kind_icon, vim_item.kind)
          vim_item.kind_hl_group = hl
          return vim_item
        end,
      },
      sources = cmp.config.sources {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' },
      },
      experimental = {
        ghost_text = false,
      },
      view = {
        docs = {
          auto_open = false,
        },
      },
    }

    local cmdline_mapping = cmp.mapping.preset.cmdline {
      ['<C-y>'] = cmp.mapping(function()
        if cmp.visible() then
          cmp.confirm { select = true }
        else
          cmp.complete()
        end
      end, { 'c' }),
    }

    cmp.setup.cmdline('/', {
      mapping = cmdline_mapping,
      sources = {
        { name = 'buffer' },
      },
    })

    cmp.setup.cmdline('?', {
      mapping = cmdline_mapping,
      sources = {
        { name = 'buffer' },
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmdline_mapping,
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })
  end,
}
