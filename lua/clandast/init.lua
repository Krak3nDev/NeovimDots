require("clandast.remap")
require("clandast.lazy")

vim.opt.timeoutlen = 500

vim.opt.textwidth = 88

vim.opt.wrap = true

vim.opt.linebreak = true

vim.opt.autoindent = true

vim.keymap.set({ 'n', 'v', }, '<Up>', '<Nop>', { noremap = true })
vim.keymap.set({ 'n', 'v', }, '<Down>', '<Nop>', { noremap = true })
vim.keymap.set({ 'n', 'v', }, '<Left>', '<Nop>', { noremap = true })
vim.keymap.set({ 'n', 'v', }, '<Right>', '<Nop>', { noremap = true })
