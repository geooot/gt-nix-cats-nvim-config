local fzf = require("fzf-lua")

vim.g.fzf_history_dir = vim.fn.stdpath("state") .. "/fzf-history"

fzf.setup({
  winopts = {
    height = 0.80,
    width = 0.87,
    preview = {
      layout = "flex",
      flip_columns = 120,
      horizontal = "right:55%",
      vertical = "down:45%",
    },
  },
  keymap = {
    builtin = {
      ["<S-Up>"] = false,
      ["<S-Down>"] = false,
      ["<C-Up>"] = "preview-page-up",
      ["<C-Down>"] = "preview-page-down",
    },
    fzf = {
      ["shift-up"] = "prev-history",
      ["shift-down"] = "next-history",
      ["ctrl-up"] = "preview-page-up",
      ["ctrl-down"] = "preview-page-down",
    },
  },
  files = {
    fd_opts = [[--color=never --type f --type l --hidden --follow ]]
      .. [[--exclude .git --exclude .jj --exclude package-lock.json]],
  },
  grep = {
    rg_glob = true,
    rg_opts = [[--column --line-number --no-heading --color=always --smart-case ]]
      .. [[--max-columns=4096 --hidden --follow ]]
      .. [[-g "!.git" -g "!package-lock.json" -e]],
  },
})

fzf.register_ui_select()

local function in_cwd(fn)
  return function()
    fn({ cwd = vim.fn.expand("%:p:h") })
  end
end

vim.keymap.set("n", "<leader><space>", fzf.files, { desc = "Find Files (Root Dir)" })
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find Files (Root Dir)" })
vim.keymap.set("n", "<leader>fF", in_cwd(fzf.files), { desc = "Find Files (cwd)" })
vim.keymap.set("n", "<leader>fr", fzf.oldfiles, { desc = "Recent" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>/", fzf.live_grep, { desc = "Grep (Root Dir)" })
vim.keymap.set("n", "<leader>sg", fzf.live_grep, { desc = "Grep (Root Dir)" })
vim.keymap.set("n", "<leader>sG", in_cwd(fzf.live_grep), { desc = "Grep (cwd)" })
vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "Word (Root Dir)" })
vim.keymap.set("v", "<leader>sw", fzf.grep_visual, { desc = "Selection (Root Dir)" })
vim.keymap.set("n", "<leader>sW", in_cwd(fzf.grep_cword), { desc = "Word (cwd)" })
vim.keymap.set("v", "<leader>sW", in_cwd(fzf.grep_visual), { desc = "Selection (cwd)" })
vim.keymap.set("n", "<leader>sc", fzf.command_history, { desc = "Command History" })
vim.keymap.set("n", "<leader>sm", fzf.marks, { desc = "Jump to Mark" })
vim.keymap.set("n", '<leader>s"', fzf.registers, { desc = "Registers" })
vim.keymap.set("n", "<leader>sa", fzf.autocmds, { desc = "Auto Commands" })
vim.keymap.set("n", "<leader>sb", fzf.blines, { desc = "Buffer" })
vim.keymap.set("n", "<leader>sC", fzf.commands, { desc = "Commands" })
vim.keymap.set("n", "<leader>sh", fzf.helptags, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>sH", fzf.highlights, { desc = "Search Highlight Groups" })
vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "Key Maps" })
vim.keymap.set("n", "<leader>sM", fzf.manpages, { desc = "Man Pages" })
vim.keymap.set("n", "<leader>so", fzf.nvim_options, { desc = "Options" })
vim.keymap.set("n", "<leader>sR", fzf.resume, { desc = "Resume" })
vim.keymap.set("n", "<leader>fg", fzf.git_status, { desc = "Find Modified Files (Git)" })
