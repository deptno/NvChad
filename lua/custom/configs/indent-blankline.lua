-- @ref https://github.com/lukas-reineke/indent-blankline.nvim/blob/b7aa0aed55887edfaece23f7b46ab22232fc8741/README.md
-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

-- -50% contrast
-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E0A096 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5A23E gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98A87A gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56908E gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#6197C7 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C6AADF gui=nocombine]]

-- -50%^2 contrast
-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#A94656 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#A8841E gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#75834E gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#487678 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#527BB9 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#A986C9 gui=nocombine]]
--
-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#A94656 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#A8841E gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#75834E gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#487678 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#527BB9 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#A986C9 gui=nocombine]]

vim.cmd[[
highlight IndentBlanklineIndent1 guifg=#1E1E1E gui=nocombine
highlight IndentBlanklineIndent2 guifg=#3A3A3A gui=nocombine
highlight IndentBlanklineIndent3 guifg=#555555 gui=nocombine
highlight IndentBlanklineIndent4 guifg=#707070 gui=nocombine
highlight IndentBlanklineIndent5 guifg=#8C8C8C gui=nocombine
highlight IndentBlanklineIndent6 guifg=#B0B0B0 gui=nocombine
highlight IndentBlanklineIndent7 guifg=#A986C9 gui=nocombine
]]

return {
  space_char_blankline = " ",
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
    "IndentBlanklineIndent7",
  },
}
