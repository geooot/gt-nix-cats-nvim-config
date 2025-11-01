local wk = require("which-key")

wk.setup({
  plugins = {
    spelling = {
      enabled = true,
      suggestions = 20,
    },
  },
  win = {
    border = "single",
  },
})

wk.add({
  { "<leader>b", group = "buffer" },
  { "<leader>c", group = "code" },
  { "<leader>f", group = "file/find" },
  { "<leader>g", group = "git" },
  { "<leader>gh", group = "hunks" },
  { "<leader>n", group = "notifications" },
  { "<leader>q", group = "quit/session" },
  { "<leader>s", group = "search" },
  { "<leader>u", group = "ui" },
  { "<leader>w", group = "windows" },
  { "<leader>x", group = "diagnostics/quickfix" },
  { "<leader><tab>", group = "tabs" },
  { "[", group = "prev" },
  { "]", group = "next" },
  { "g", group = "goto" },
  { "z", group = "fold" },
})
