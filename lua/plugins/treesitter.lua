local group = vim.api.nvim_create_augroup("treesitter_config", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "*",
  callback = function(args)
    local buf = args.buf

    if not pcall(vim.treesitter.start, buf) then
      return
    end

    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

local function init_selection()
  local node = vim.treesitter.get_node()
  if not node then return end
  local start_row, start_col, end_row, end_col = node:range()
  vim.api.nvim_buf_set_mark(0, "<", start_row + 1, start_col, {})
  vim.api.nvim_buf_set_mark(0, ">", end_row + 1, end_col, {})
  vim.cmd("normal! gv")
end

local function node_incremental()
  local node = vim.treesitter.get_node()
  if not node then return end
  node = node:parent()
  if not node then return end
  local start_row, start_col, end_row, end_col = node:range()
  vim.api.nvim_buf_set_mark(0, "<", start_row + 1, start_col, {})
  vim.api.nvim_buf_set_mark(0, ">", end_row + 1, end_col, {})
  vim.cmd("normal! gv")
end

vim.keymap.set({ "n", "v" }, "<C-space>", function()
  if vim.fn.mode() == "n" then
    init_selection()
  else
    node_incremental()
  end
end, { desc = "Init/increment treesitter selection" })

vim.keymap.set("v", "<bs>", init_selection, { desc = "Reset treesitter selection" })

require("nvim-treesitter-textobjects").setup({
  move = {
    set_jumps = true,
  },
})

local move = require("nvim-treesitter-textobjects.move")

vim.keymap.set({ "n", "x", "o" }, "]f", function()
  move.goto_next_start("@function.outer", "textobjects")
end, { desc = "Next function start" })

vim.keymap.set({ "n", "x", "o" }, "[f", function()
  move.goto_previous_start("@function.outer", "textobjects")
end, { desc = "Previous function start" })

vim.keymap.set({ "n", "x", "o" }, "]c", function()
  move.goto_next_start("@class.outer", "textobjects")
end, { desc = "Next class start" })

vim.keymap.set({ "n", "x", "o" }, "[c", function()
  move.goto_previous_start("@class.outer", "textobjects")
end, { desc = "Previous class start" })

vim.keymap.set({ "n", "x", "o" }, "]a", function()
  move.goto_next_start("@parameter.inner", "textobjects")
end, { desc = "Next parameter" })

vim.keymap.set({ "n", "x", "o" }, "[a", function()
  move.goto_previous_start("@parameter.inner", "textobjects")
end, { desc = "Previous parameter" })

vim.keymap.set({ "n", "x", "o" }, "]F", function()
  move.goto_next_end("@function.outer", "textobjects")
end, { desc = "Next function end" })

vim.keymap.set({ "n", "x", "o" }, "[F", function()
  move.goto_previous_end("@function.outer", "textobjects")
end, { desc = "Previous function end" })

vim.keymap.set({ "n", "x", "o" }, "]C", function()
  move.goto_next_end("@class.outer", "textobjects")
end, { desc = "Next class end" })

vim.keymap.set({ "n", "x", "o" }, "[C", function()
  move.goto_previous_end("@class.outer", "textobjects")
end, { desc = "Previous class end" })

vim.keymap.set({ "n", "x", "o" }, "]A", function()
  move.goto_next_end("@parameter.inner", "textobjects")
end, { desc = "Next parameter end" })

vim.keymap.set({ "n", "x", "o" }, "[A", function()
  move.goto_previous_end("@parameter.inner", "textobjects")
end, { desc = "Previous parameter end" })
