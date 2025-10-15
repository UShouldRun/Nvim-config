vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fv", vim.cmd.Ex)
vim.api.nvim_set_keymap("i", '"', '""<left>', { noremap = true })
vim.api.nvim_set_keymap("i", "'", "''<left>", { noremap = true })
vim.api.nvim_set_keymap("i", "(", "()<left>", { noremap = true })
vim.api.nvim_set_keymap("i", "[", "[]<left>", { noremap = true })
vim.api.nvim_set_keymap("i", "{", "{}<left>", { noremap = true })
vim.keymap.set('i', '<BS>', function()
    local col = vim.fn.col('.')
    local line = vim.fn.getline('.')
    local prev_char = line:sub(col - 1, col - 1)
    local next_char = line:sub(col, col)
    
    local pairs = { ['"'] = '"', ["'"] = "'", ['('] = ')', ['['] = ']', ['{'] = '}' }
    
    if pairs[prev_char] and next_char == pairs[prev_char] then
        return '<BS><Del>'
    else
        return '<BS>'
    end
end, { expr = true })
