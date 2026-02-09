return {
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      cmake_dap_configuration = { -- debug settings for cmake
        name = "cpp",
        type = "codelldb",
        request = "launch",
        stopOnEntry = false,
        runInTerminal = true,
        console = "integratedTerminal",
      },
    },
    keys = {
      {
        "<leader>cm",
        function()
          local items = {
            { text = "󰔚 Generate Project", cmd = "CMakeGenerate" },
            { text = "󰐊 Build", cmd = "CMakeBuild" },
            { text = "󱌣 Build Current File", cmd = "CMakeBuildCurrentFile" },
            { text = "󱓞 Run", cmd = "CMakeRun" },
            { text = "󰙨 Debug", cmd = "CMakeDebug" },
            { text = " Debug Current File", cmd = "CMakeDebugCurrentFile" },
            { text = "󱗼 Select Target", cmd = "CMakeSelectTarget" },
            { text = "󱘝 Select Kit", cmd = "CMakeSelectKit" },
            { text = "󰒓 Select Build Type", cmd = "CMakeSelectBuildType" },
            { text = "󰚰 Clean", cmd = "CMakeClean" },
            { text = "󰪑 Stop", cmd = "CMakeStop" },
          }

          Snacks.picker.select(items, {
            prompt = " CMake Tools ",
            format_item = function(item)
              return item.text
            end,
          }, function(item)
            if item then
              vim.cmd(item.cmd)
            end
          end)
        end,
        desc = "CMake Menu (Snacks)",
      },
    },
  },
}
