local get_buf_content = function ()
  local current_buffer = vim.api.nvim_get_current_buf()
  local buffer_content = vim.api.nvim_buf_get_lines(current_buffer, 0, -1, false)

  return table.concat(buffer_content)
end
local run_fx = function ()
  local content = get_buf_content()
  local command = string.format([[
tmux display-popup \
-d "#{pane_current_path}" \
-w 70%% \
-h 100%% \
-x 100%% \
-e FX_THEME=6 \
-EE 'cat <<EOF | fx . | fx
%s
EOF']], content)

  vim.fn.system(command)
end

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("JsonFiletype", { clear = true }),
  callback = function(ev)
    local opts = {
      buffer = ev.buf
    }

    vim.keymap.set('n', '.', run_fx, opts)
  end
})
