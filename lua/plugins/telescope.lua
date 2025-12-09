local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    path_display = { "smart" },
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    cache_picker = {
      num_pickers = 10,
    },
    mappings = {
      i = {
        ["<S-Up>"] = require("telescope.actions").cycle_history_prev,
        ["<S-Down>"] = require("telescope.actions").cycle_history_next,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--glob", "!**/package-lock.json", "--follow" },
      no_ignore = false,
    },
  },
})

telescope.load_extension("fzf")

vim.keymap.set("n", "<leader><space>", builtin.find_files, { desc = "Find Files (Root Dir)" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files (Root Dir)" })
vim.keymap.set("n", "<leader>fF", function()
  builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
end, { desc = "Find Files (cwd)" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Grep (Root Dir)" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Grep (Root Dir)" })
vim.keymap.set("n", "<leader>sG", function()
  builtin.live_grep({ cwd = vim.fn.expand("%:p:h") })
end, { desc = "Grep (cwd)" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Word (Root Dir)" })
vim.keymap.set("v", "<leader>sw", builtin.grep_string, { desc = "Selection (Root Dir)" })
vim.keymap.set("n", "<leader>sW", function()
  builtin.grep_string({ cwd = vim.fn.expand("%:p:h") })
end, { desc = "Word (cwd)" })
vim.keymap.set("v", "<leader>sW", function()
  builtin.grep_string({ cwd = vim.fn.expand("%:p:h") })
end, { desc = "Selection (cwd)" })
vim.keymap.set("n", "<leader>sc", builtin.command_history, { desc = "Command History" })
vim.keymap.set("n", "<leader>sm", builtin.marks, { desc = "Jump to Mark" })
vim.keymap.set("n", '<leader>s"', builtin.registers, { desc = "Registers" })
vim.keymap.set("n", "<leader>sa", builtin.autocommands, { desc = "Auto Commands" })
vim.keymap.set("n", "<leader>sb", builtin.current_buffer_fuzzy_find, { desc = "Buffer" })
vim.keymap.set("n", "<leader>sC", builtin.commands, { desc = "Commands" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>sH", builtin.highlights, { desc = "Search Highlight Groups" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Key Maps" })
vim.keymap.set("n", "<leader>sM", builtin.man_pages, { desc = "Man Pages" })
vim.keymap.set("n", "<leader>so", builtin.vim_options, { desc = "Options" })
vim.keymap.set("n", "<leader>sR", builtin.resume, { desc = "Resume" })
