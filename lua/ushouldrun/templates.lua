local function template_cpp()
  local template_lines = {
    "#include <iostream>",
    "#include <vector>",
    "#include <queue>",
    "",
    "#include <cstdio>",
    "#include <cstdint>",
    "#include <cstring>",
    "#include <climits>",
    "",
    "typedef uint8_t  u8;",
    "typedef uint16_t u16;",
    "typedef uint32_t u32;",
    "typedef uint64_t u64;",
    "typedef int8_t   i8;",
    "typedef int16_t  i16;",
    "typedef int32_t  i32;",
    "typedef int64_t  i64;",
    "typedef float    f32;",
    "typedef double   f64;",
    "",
    "i32 main(const i32 argc, const char* argv[]) {",
    "  ",
    "  return 0;",
    "}",
  }

  local current_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    if #current_lines == 1 and current_lines[1] == "" then
        vim.api.nvim_buf_set_lines(0, 0, -1, false, template_lines)
        vim.api.nvim_win_set_cursor(0, {22, 2})
    end
end

local function template_c()
  local template_lines = {
    "#include <stdio.h>",
    "#include <stdint.h>",
    "#include <stdlib.h>",
    "",
    "typedef uint8_t  u8;",
    "typedef uint16_t u16;",
    "typedef uint32_t u32;",
    "typedef uint64_t u64;",
    "typedef int8_t   i8;",
    "typedef int16_t  i16;",
    "typedef int32_t  i32;",
    "typedef int64_t  i64;",
    "typedef float    f32;",
    "typedef double   f64;",
    "",
    "#define nullptr NULL",
    "",
    "i32 main(const i32 argc, const char* argv[]) {",
    "  ",
    "  return 0;",
    "}",
  }

  local current_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    if #current_lines == 1 and current_lines[1] == "" then
        vim.api.nvim_buf_set_lines(0, 0, -1, false, template_lines)
        vim.api.nvim_win_set_cursor(0, {19, 2})
    end
end

local function template_typst()
  local template_lines = {
    "#set page(margin: 2.5cm)",
    "#set text(size: 11pt)",
    "",
    "= Heading",
    "",
    "Your content here."
  }

  local current_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    if #current_lines == 1 and current_lines[1] == "" then
        vim.api.nvim_buf_set_lines(0, 0, -1, false, template_lines)
        vim.api.nvim_win_set_cursor(0, {6, 0})
    end
end

-- Create an Autocmd Group for organization
local cpp_group   = vim.api.nvim_create_augroup("CppTemplateGroup", { clear = true })
local c_group     = vim.api.nvim_create_augroup("CTemplateGroup", { clear = true })
local typst_group = vim.api.nvim_create_augroup("TypstTemplateGroup", { clear = true })

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

vim.api.nvim_create_user_command("TemplateC", function()
  template_c()
end, {})

vim.api.nvim_create_user_command("TemplateTypst", function()
  template_typst()
end, {})
