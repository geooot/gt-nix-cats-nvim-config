# Agent Instructions for nixCats Neovim Configuration

This is a Neovim configuration using Nix and nixCats for reproducible plugin and dependency management.

## Build/Test/Lint Commands
- **Build config**: `nix build` (builds the nixCats neovim package)
- **Test config**: `./result/bin/nvim` (run the built neovim)
- **Format Nix**: `nixfmt flake.nix` (use nixfmt-rfc-style)
- **Format Lua**: Use conform.nvim's stylua formatter (no standalone command)
- **No test suite** - this is a personal neovim config

## Code Style Guidelines
- **Language**: Lua for config, Nix for package definition
- **Indentation**: 2 spaces (no tabs)
- **Imports**: Use `require()` for modules; avoid relative paths when possible
- **Plugin setup**: Call `require("plugin").setup({})` in `lua/plugins/*.lua` files
- **Naming**: snake_case for Lua variables/functions; use descriptive names
- **LSP integration**: Use `vim.lsp.config()` and `vim.lsp.enable()` (new 0.11+ API)
- **Keymaps**: Define in appropriate context (on_attach for LSP, setup() for plugins)
- **Error handling**: Let Lua errors propagate naturally; no explicit pcall needed for plugin configs
- **NO COMMENTS**: Do not add comments to code unless explicitly requested by user

## Architecture
- Entry: `init.lua` → `lua/config/init.lua` → individual config modules
- Plugins: Managed via Nix flake (flake.nix), configured in `lua/plugins/`
- Runtime deps: LSPs/formatters/linters declared in flake.nix categoryDefinitions
