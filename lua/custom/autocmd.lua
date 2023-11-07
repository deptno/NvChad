vim.api.nvim_create_autocmd("SessionLoadPost", {
  group = vim.api.nvim_create_augroup("AfterSessionLoadPost", { clear = true }),
  callback = function()
    -- vim.cmd(':clearjumps')
    --
    vim.schedule(function ()
      local bufs = vim.api.nvim_list_bufs()
      local cwd = vim.fn.getcwd()

      for _, bufnr in ipairs(bufs) do
        local name = vim.api.nvim_buf_get_name(bufnr)
        if name ~= '' then
          local in_dir = cwd == name:sub(1, #cwd)

          if not in_dir then
            vim.api.nvim_buf_delete(bufnr, { force = false })
            -- if vim.api.nvim_buf_is_loaded(bufnr) then else end
          end
        end
      end
    end)
  end,
})
