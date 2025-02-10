vim.g.mapleader = " "

-- telescope
do
  local builtin = require("telescope.builtin")
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find file" })
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
end

-- neotree
vim.keymap.set('n', '<leader>n', ':Neotree filesystem reveal left<cr>', { desc = "open neotree" })

-- lsp
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "code action" })
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { desc = "code format" })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "code action" })

vim.keymap.set('n', '<C-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')
