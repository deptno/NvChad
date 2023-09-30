# neovim-config-for-nvchad

1. setup [nvchad](https://nvchad.com/docs/quickstart/install)
2. git clone
  - git clone https://github.com/deptno/neovim-config-for-nvchad.git ~/.config/nvim/lua/custom --depth 1 && nvim
  **or**
  - git clone git@github.com:deptno/neovim-config-for-nvchad.git ~/.config/nvim/lua/custom --depth 1 && nvim
3. modify `~/.config/nvim/lua/core/default_config.lua`
```lua
M.plugins = "custom.plugins" -- path i.e "custom.plugins", so make custom/plugins.lua file
```
