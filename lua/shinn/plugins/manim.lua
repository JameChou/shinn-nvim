----------------------------------------------------------------
-- ManimGL REPL 调试配置 (使用 Neovim 内置 Terminal)
-- 参考 3B1B sublime_custom_commands 工作流
----------------------------------------------------------------

local M = {}

----------------------------------------------------------------
-- 辅助函数
----------------------------------------------------------------
local function lstrip(s)
  return s:match("^%s*(.*)")
end

local function startswith(s, prefix)
  return s:sub(1, #prefix) == prefix
end

----------------------------------------------------------------
-- 状态管理
----------------------------------------------------------------
local manim_state = {
  bufnr = nil,
  job_id = nil,
  started = false,
}

----------------------------------------------------------------
-- 获取当前 Scene 名 (Treesitter)
----------------------------------------------------------------
local function get_current_scene_name()
  local node = vim.treesitter.get_node()
  if not node then return nil end

  while node do
    if node:type() == "class_definition" then
      local name_field = node:field("name")
      if name_field and name_field[1] then
        return vim.treesitter.get_node_text(name_field[1], 0)
      end
    end
    node = node:parent()
  end

  return nil
end

----------------------------------------------------------------
-- 获取当前光标行号 (1-indexed)
----------------------------------------------------------------
local function get_current_line()
  return vim.api.nvim_win_get_cursor(0)[1]
end

----------------------------------------------------------------
-- 查找或创建 terminal 窗口
----------------------------------------------------------------
local function find_or_create_terminal()
  -- 如果已有 buffer 且有效
  if manim_state.bufnr and vim.api.nvim_buf_is_valid(manim_state.bufnr) then
    -- 查找是否已有窗口显示该 buffer
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == manim_state.bufnr then
        return manim_state.bufnr, win
      end
    end
    -- 没有窗口显示，创建新窗口
    local original_win = vim.api.nvim_get_current_win()
    vim.cmd("botright split | vertical resize 30")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, manim_state.bufnr)
    vim.api.nvim_set_current_win(original_win) -- 返回原窗口
    return manim_state.bufnr, win
  end

  -- 保存当前窗口引用
  local original_win = vim.api.nvim_get_current_win()

  -- 创建新的 terminal
  vim.cmd("botright split | vertical resize 30")
  local term_win = vim.api.nvim_get_current_win()
  vim.cmd("terminal")

  manim_state.bufnr = vim.api.nvim_get_current_buf()
  manim_state.job_id = vim.b[manim_state.bufnr].terminal_job_id

  -- 确保返回原窗口并保持在 normal 模式
  vim.api.nvim_set_current_win(original_win)
  vim.cmd("stopinsert")

  return manim_state.bufnr, term_win
end

----------------------------------------------------------------
-- 发送命令到 terminal
----------------------------------------------------------------
local function send_to_terminal(cmd, enter)
  find_or_create_terminal()

  if manim_state.job_id then
    local full_cmd = cmd
    if enter ~= false then
      full_cmd = cmd .. "\n"
    end
    vim.api.nvim_chan_send(manim_state.job_id, full_cmd)
  end
end

----------------------------------------------------------------
-- 运行场景 (Run Scene)
-- 类似 3B1B ManimRunScene
----------------------------------------------------------------
function M.run_scene()
  local scene = get_current_scene_name()
  local file = vim.fn.expand("%:p")
  local line = get_current_line()

  if not scene then
    vim.notify("Cursor not inside a Scene class!", vim.log.levels.WARN)
    return
  end

  -- 保存当前窗口引用
  local original_win = vim.api.nvim_get_current_win()

  -- 保存文件
  vim.cmd("write")

  -- 查找类定义行
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local scene_line = 0
  for i, l in ipairs(lines) do
    if l:match("class " .. scene .. "%s*%(") then
      scene_line = i
      break
    end
  end

  local cmd
  local enter = false

  if line ~= scene_line then
    -- 光标不在类定义行，使用 -se 参数
    cmd = string.format("manimgl %s %s -se %d", file, scene, line)
    enter = true
  else
    cmd = string.format("manimgl %s %s", file, scene)
  end

  -- 复制命令到剪贴板 (方便在外部终端使用)
  vim.fn.setreg("+", cmd .. " --prerun --finder -w")

  -- 创建或获取 terminal，并发送命令
  local _, term_win = find_or_create_terminal()
  send_to_terminal(cmd, enter)
  manim_state.started = true

  if enter then
    -- 如果是 embedded 模式，保持焦点在编辑器
    vim.api.nvim_set_current_win(original_win)
    vim.cmd("stopinsert")
    vim.notify("ManimGL started: " .. scene .. " (embedded mode)", vim.log.levels.INFO)
  else
    -- 否则跳转到 terminal
    if term_win and vim.api.nvim_win_is_valid(term_win) then
      vim.api.nvim_set_current_win(term_win)
    end
  end
end

----------------------------------------------------------------
-- Checkpoint Paste
-- 类似 3B1B ManimCheckpointPaste
----------------------------------------------------------------
function M.checkpoint_paste(opts)
  opts = opts or {}

  -- 获取选中的文本
  local sel_lines
  local start_line

  -- 保存当前模式
  local current_mode = vim.fn.mode()

  if current_mode == "v" or current_mode == "V" or current_mode == "\22" then
    -- 视觉模式
    vim.cmd("normal! \27") -- 退出视觉模式
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    start_line = start_pos[2]
    sel_lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
  else
    -- 普通模式：发送当前行
    start_line = get_current_line()
    sel_lines = { vim.api.nvim_get_current_line() }
  end

  if #sel_lines == 0 then return end

  local first_line = lstrip(sel_lines[1])
  local starts_with_comment = startswith(first_line, "#")
  local arg_str = opts.arg_str or ""

  local cmd
  if #sel_lines == 1 and not starts_with_comment then
    -- 单行非注释：直接发送
    cmd = sel_lines[1]
  else
    -- 多行或注释：使用 checkpoint_paste
    local comment = starts_with_comment and first_line or "#"
    cmd = string.format("checkpoint_paste(%s) %s (%d lines)", arg_str, comment, #sel_lines)
  end

  -- 复制选中内容到剪贴板
  vim.fn.setreg("+", table.concat(sel_lines, "\n"))

  send_to_terminal(cmd)
end

----------------------------------------------------------------
-- Checkpoint Paste with record=True
----------------------------------------------------------------
function M.checkpoint_paste_recorded()
  M.checkpoint_paste({ arg_str = "record=True" })
end

----------------------------------------------------------------
-- Checkpoint Paste with skip=True
----------------------------------------------------------------
function M.checkpoint_paste_skipped()
  M.checkpoint_paste({ arg_str = "skip=True" })
end

----------------------------------------------------------------
-- 单独执行 checkpoint_paste()
----------------------------------------------------------------
function M.checkpoint()
  send_to_terminal("checkpoint_paste()")
end

----------------------------------------------------------------
-- 退出 Manim
-- 类似 3B1B ManimExit
----------------------------------------------------------------
function M.exit_manim()
  if manim_state.job_id then
    -- 发送 Ctrl+C 然后 quit
    vim.api.nvim_chan_send(manim_state.job_id, "\003")
    vim.defer_fn(function()
      vim.api.nvim_chan_send(manim_state.job_id, "quit\n")
    end, 100)
  end
  manim_state.started = false
  vim.notify("ManimGL exited", vim.log.levels.INFO)
end

----------------------------------------------------------------
-- 聚焦到 Terminal
----------------------------------------------------------------
function M.focus_terminal()
  if manim_state.bufnr and vim.api.nvim_buf_is_valid(manim_state.bufnr) then
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == manim_state.bufnr then
        vim.api.nvim_set_current_win(win)
        return
      end
    end
  end
  vim.notify("No ManimGL terminal found", vim.log.levels.WARN)
end

----------------------------------------------------------------
-- 隐藏/显示 Terminal
----------------------------------------------------------------
function M.toggle_terminal()
  if manim_state.bufnr and vim.api.nvim_buf_is_valid(manim_state.bufnr) then
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == manim_state.bufnr then
        vim.api.nvim_win_close(win, false)
        return
      end
    end
  end
  find_or_create_terminal()
end

----------------------------------------------------------------
-- 发送选中的代码到 terminal (不使用 checkpoint)
----------------------------------------------------------------
function M.send_selection()
  local sel_lines
  local current_mode = vim.fn.mode()

  if current_mode == "v" or current_mode == "V" or current_mode == "\22" then
    vim.cmd("normal! \27")
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    sel_lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
  else
    sel_lines = { vim.api.nvim_get_current_line() }
  end

  if #sel_lines > 0 then
    send_to_terminal(table.concat(sel_lines, "\n"))
  end
end

----------------------------------------------------------------
-- 快捷键配置
----------------------------------------------------------------
local function setup_keymaps()
  -- 运行场景
  vim.keymap.set("n", "<leader>mr", M.run_scene,
    { noremap = true, silent = true, desc = "ManimGL: Run Scene" })

  -- 视觉模式发送代码 + checkpoint_paste
  vim.keymap.set("v", "<leader>mc", M.checkpoint_paste,
    { noremap = true, silent = true, desc = "ManimGL: Checkpoint Paste" })

  -- 普通模式发送当前行 + checkpoint_paste
  vim.keymap.set("n", "<leader>mc", M.checkpoint_paste,
    { noremap = true, silent = true, desc = "ManimGL: Checkpoint Paste" })

  -- Checkpoint paste with record=True
  vim.keymap.set("v", "<leader>mR", M.checkpoint_paste_recorded,
    { noremap = true, silent = true, desc = "ManimGL: Recorded Checkpoint Paste" })

  -- Checkpoint paste with skip=True
  vim.keymap.set("v", "<leader>ms", M.checkpoint_paste_skipped,
    { noremap = true, silent = true, desc = "ManimGL: Skipped Checkpoint Paste" })

  -- 单独 checkpoint
  vim.keymap.set("n", "<leader>mp", M.checkpoint,
    { noremap = true, silent = true, desc = "ManimGL: Checkpoint" })

  -- 退出
  vim.keymap.set("n", "<leader>me", M.exit_manim,
    { noremap = true, silent = true, desc = "ManimGL: Exit" })

  -- 聚焦 Terminal
  vim.keymap.set("n", "<leader>mf", M.focus_terminal,
    { noremap = true, silent = true, desc = "ManimGL: Focus Terminal" })

  -- 切换 Terminal 显示
  vim.keymap.set("n", "<leader>mt", M.toggle_terminal,
    { noremap = true, silent = true, desc = "ManimGL: Toggle Terminal" })

  -- 直接发送选中代码 (不使用 checkpoint)
  vim.keymap.set("v", "<leader>mv", M.send_selection,
    { noremap = true, silent = true, desc = "ManimGL: Send Selection" })
end

----------------------------------------------------------------
-- 插件配置
----------------------------------------------------------------
return {
  "Vigemus/iron.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    setup_keymaps()
  end,
}
