vim.o.timeout = true
vim.o.timeoutlen = 150
vim.o.jumpoptions = 'stack'

vim.g.mapleader = ';'

--- nvim-ufo
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

require('custom/autocmd')
