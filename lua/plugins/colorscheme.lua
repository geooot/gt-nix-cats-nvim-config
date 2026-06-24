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

if vim.o.background == "light" then
  vim.cmd.colorscheme("tokyonight-day")
else
  vim.cmd.colorscheme("tokyonight")
end
