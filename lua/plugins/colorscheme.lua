require("tokyonight").setup({
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  },
  plugins = {
    all = true,
  },
})

require("gruvbox").setup({
  transparent_mode = true,
})

vim.cmd.colorscheme("gruvbox")

-- if vim.o.background == "light" then
--   vim.cmd.colorscheme("tokyonight-day")
-- else
--   vim.cmd.colorscheme("tokyonight")
-- end
