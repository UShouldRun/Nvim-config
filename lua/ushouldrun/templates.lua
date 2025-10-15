local function template_cpp()
  local template_lines = {
    "#include <cstdlib>",
    "#include <cstdint>",
    "#include <cstdio>",
    "",
    "int32_t main(int32_t argc, const char* argv[]) {",
    "  ",
    "  return 0;",
    "}",
  }

  local current_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    if #current_lines == 1 and current_lines[1] == "" then
        vim.api.nvim_buf_set_lines(0, 0, -1, false, template_lines)
        vim.api.nvim_win_set_cursor(0, {6, 2})
    end
end

-- Create an Autocmd Group for organization
local cpp_group = vim.api.nvim_create_augroup("CppTemplateGroup", { clear = true })

-- Set up the Autocmd: When a new file matching the pattern is opened, call the function.
-- vim.api.nvim_create_autocmd({"BufNewFile"}, {
--     group = cpp_group,
--     pattern = "*.cpp",
--     callback = function() template_cpp() end,
--     desc = "Insert C++ template on new file creation"
-- })

vim.api.nvim_create_user_command("TemplateCpp", function()
  template_cpp()
end, {})
