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
  picker = {
    enabled = true,
    ui_select = true,
    layout = {
      cycle = true,
      preset = function()
        return vim.o.columns >= 120 and "telescope" or "vertical"
      end,
    },
    matcher = {
      fuzzy = true,
      smartcase = true,
      ignorecase = true,
      filename_bonus = true,
      file_pos = true,
    },
    win = {
      input = {
        keys = {
          ["<S-Up>"] = { "history_back", mode = { "i", "n" } },
          ["<S-Down>"] = { "history_forward", mode = { "i", "n" } },
        },
      },
    },
    sources = {
      files = {
        hidden = true,
        follow = true,
        exclude = { ".git", "package-lock.json" },
      },
      grep = {
        hidden = true,
        follow = true,
        exclude = { ".git", "package-lock.json" },
      },
    },
  },
})

local picker = snacks.picker

local function in_cwd(fn)
  return function()
    fn({ cwd = vim.fn.expand("%:p:h") })
  end
end

vim.keymap.set("n", "<leader><space>", picker.files, { desc = "Find Files (Root Dir)" })
vim.keymap.set("n", "<leader>ff", picker.files, { desc = "Find Files (Root Dir)" })
vim.keymap.set("n", "<leader>fF", in_cwd(picker.files), { desc = "Find Files (cwd)" })
vim.keymap.set("n", "<leader>fr", picker.recent, { desc = "Recent" })
vim.keymap.set("n", "<leader>fb", picker.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>/", picker.grep, { desc = "Grep (Root Dir)" })
vim.keymap.set("n", "<leader>sg", picker.grep, { desc = "Grep (Root Dir)" })
vim.keymap.set("n", "<leader>sG", in_cwd(picker.grep), { desc = "Grep (cwd)" })
vim.keymap.set("n", "<leader>sw", picker.grep_word, { desc = "Word (Root Dir)" })
vim.keymap.set("v", "<leader>sw", picker.grep_word, { desc = "Selection (Root Dir)" })
vim.keymap.set("n", "<leader>sW", in_cwd(picker.grep_word), { desc = "Word (cwd)" })
vim.keymap.set("v", "<leader>sW", in_cwd(picker.grep_word), { desc = "Selection (cwd)" })
vim.keymap.set("n", "<leader>sc", picker.command_history, { desc = "Command History" })
vim.keymap.set("n", "<leader>sm", picker.marks, { desc = "Jump to Mark" })
vim.keymap.set("n", '<leader>s"', picker.registers, { desc = "Registers" })
vim.keymap.set("n", "<leader>sa", picker.autocmds, { desc = "Auto Commands" })
vim.keymap.set("n", "<leader>sb", picker.lines, { desc = "Buffer" })
vim.keymap.set("n", "<leader>sC", picker.commands, { desc = "Commands" })
vim.keymap.set("n", "<leader>sh", picker.help, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>sH", picker.highlights, { desc = "Search Highlight Groups" })
vim.keymap.set("n", "<leader>sk", picker.keymaps, { desc = "Key Maps" })
vim.keymap.set("n", "<leader>sM", picker.man, { desc = "Man Pages" })
vim.keymap.set("n", "<leader>so", function()
  local items = {}
  for name, info in pairs(vim.api.nvim_get_all_options_info()) do
    local ok, value = pcall(vim.api.nvim_get_option_value, name, {})
    items[#items + 1] = {
      text = name,
      option = name,
      value = ok and value or info.default,
      scope = info.scope,
    }
  end
  table.sort(items, function(a, b)
    return a.option < b.option
  end)
  picker.pick({
    title = "Options",
    items = items,
    format = function(item)
      return {
        { item.option, "SnacksPickerLabel" },
        { " " },
        { vim.inspect(item.value), "SnacksPickerComment" },
      }
    end,
    confirm = function(p, item)
      p:close()
      if item then
        vim.api.nvim_feedkeys(":set " .. item.option .. "?", "n", false)
      end
    end,
  })
end, { desc = "Options" })
vim.keymap.set("n", "<leader>sR", picker.resume, { desc = "Resume" })
vim.keymap.set("n", "<leader>fg", picker.git_status, { desc = "Find Modified Files (Git)" })

snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>ul")

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
