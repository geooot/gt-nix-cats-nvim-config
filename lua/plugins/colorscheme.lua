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

vim.cmd.colorscheme("tokyonight")
