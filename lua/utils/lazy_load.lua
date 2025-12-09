local M = {}

function M.on_event(plugin_name, events, setup_fn)
  vim.api.nvim_create_autocmd(events, {
    once = true,
    group = vim.api.nvim_create_augroup("lazy_" .. plugin_name:gsub("[.-]", "_"), { clear = true }),
    callback = function()
      vim.cmd("packadd " .. plugin_name)
      if setup_fn then
        setup_fn()
      end
    end,
  })
end

function M.on_keys(plugin_name, keys, setup_fn)
  local loaded = false
  
  local function load_and_exec(key_config)
    if not loaded then
      vim.cmd("packadd " .. plugin_name)
      if setup_fn then
        setup_fn()
      end
      loaded = true
    end
    
    local typed_key = vim.api.nvim_replace_termcodes(key_config[1], true, true, true)
    vim.api.nvim_feedkeys(typed_key, "m", false)
  end
  
  for _, key in ipairs(keys) do
    vim.keymap.set(key.mode or "n", key[1], function()
      load_and_exec(key)
    end, { desc = key.desc })
  end
end

function M.on_cmd(plugin_name, cmds, setup_fn)
  local loaded = false
  
  for _, cmd in ipairs(cmds) do
    vim.api.nvim_create_user_command(cmd, function(args)
      if not loaded then
        vim.cmd("packadd " .. plugin_name)
        if setup_fn then
          setup_fn()
        end
        loaded = true
      end
      vim.cmd(cmd .. " " .. args.args)
    end, { nargs = "*", complete = "file" })
  end
end

return M
