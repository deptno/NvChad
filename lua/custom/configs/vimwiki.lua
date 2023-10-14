-- https://github.com/deptno/.config/blob/master/.config/nvim/lua/user/vimwiki.lua
vim.g.vimwiki_auto_chdir = 1
vim.g.vimwiki_conceallevel = 0
vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_list = {
  {
    name = "public",
    path = "~/workspace/src/github.com/deptno/public-wiki",
    ext  = ".md",
    diary_rel_path = "diary",
    diary_index = "index",
  },
  {
    name = "private",
    path = "~/workspace/src/github.com/deptno/wiki",
    ext  = ".md",
    diary_rel_path = "diary",
    diary_index = "index",
  },
}
