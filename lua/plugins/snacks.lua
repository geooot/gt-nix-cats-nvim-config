local snacks = require("snacks")

snacks.setup({
  bigfile = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 3000,
  },
  quickfile = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  styles = {
    notification = {
      wo = { wrap = true },
    },
  },
})

vim.keymap.set("n", "<leader>un", function()
  snacks.notifier.hide()
end, { desc = "Dismiss All Notifications" })

vim.keymap.set("n", "<leader>nh", function()
  snacks.notifier.show_history()
end, { desc = "Notification History" })

vim.keymap.set({ "n", "t" }, "<c-/>", function()
  snacks.terminal()
end, { desc = "Terminal (cwd)" })

vim.keymap.set({ "n", "t" }, "<c-_>", function()
  snacks.terminal()
end, { desc = "which_key_ignore" })
