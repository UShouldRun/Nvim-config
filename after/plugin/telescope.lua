local ok, builtin = pcall(require, 'telescope.builtin')
if not ok then return end
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-f>', builtin.git_files, { desc = 'Telescope find git files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
