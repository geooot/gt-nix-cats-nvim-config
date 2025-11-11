require("oil").setup({
  default_file_explorer = true,
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, _)
      return name == ".." or name == ".git"
    end,
  },
  float = {
    padding = 2,
    max_width = 90,
    max_height = 0,
  },
  keymaps = {
    ["<C-h>"] = false,
    ["<C-l>"] = false,
    ["<C-s>"] = false,
    ["<C-v>"] = { "actions.select", opts = { vertical = true } },
    ["<C-x>"] = { "actions.select", opts = { horizontal = true } },
  },
})

vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>-", function()
  require("oil").toggle_float()
end, { desc = "Open parent directory (float)" })
