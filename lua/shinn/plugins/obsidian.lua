return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  ft = "markdown",
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in the next major release
    workspaces = {
      {
        name = "algorithm",
        path = "~/Documents/algorithm/",
      },
      {
        name = "works",
        path = "~/Documents/works/",
      },
    },
    completion = {
      nvim_cmp = false,
      blink = false,
    }
  },

  config = function(_, opts)
    require("obsidian").setup(opts)

    -- 定义屏蔽函数
    local function disable_obsidian_features(client)
      if client.name == "obsidian-ls" then
        -- 禁用跳转定义
        client.server_capabilities.definitionProvider = false
        -- 禁用引用查找
        client.server_capabilities.referencesProvider = false
        -- 禁用重命名
        -- client.server_capabilities.renameProvider = false
        -- 禁用符号搜索 (Optional)
        client.server_capabilities.documentSymbolProvider = false

        -- 确认执行的通知（调试完可以删掉）
        vim.notify("Obsidian-ls features disabled, using Marksman instead.", vim.log.levels.INFO)
      end
    end

    -- 1. 针对已经 Attach 的客户端（防止插件启动过快）
    for _, client in ipairs(vim.lsp.get_clients()) do
      disable_obsidian_features(client)
    end

    -- 2. 针对后续 Attach 的客户端
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
          disable_obsidian_features(client)
        end
      end,
    })
  end,

  keys = {
    { "<leader>or", "<cmd>Obsidian rename<cr>", desc = "Obsidian: Rename" },
    {
      "<leader>ob",
      desc = "Obsidian: Find Backlinks",
      function()
        local filename = vim.fn.expand("%:t:r")

        local pattern = "\\[\\[" .. filename .. "([\\|\\]#])"

        -- 3. 调用 snacks.picker.grep
        Snacks.picker.grep({
          search = pattern,
          regexp = true, -- 开启正则模式
          title = "Backlinks: " .. filename,
        })
      end
    },
    {
      "<leader>oe",
      ":Obsidian extract_note<cr>",
      mode = "v",
      desc = "Obsidian: Extract Note"
    },
    {
      "<leader>ot",
      ":Obsidian tags<cr>",
      desc = "Obsidian: Tags"
    },
    {
      "<leader>ol",
      desc = "Obsidian: Find Links",
      function()
        Snacks.picker.grep({
          prompt = "Wiki Links",
          search = "\\[\\[.*?\\]\\]", -- 匹配 [[任何内容]]
          regex = true,
          -- 限制只在当前文件中搜索
          args = { "-g", vim.fn.expand("%:t") },
        })
      end
    },
  },

}
