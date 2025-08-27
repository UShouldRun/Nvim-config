local wallpaper_config = {
  nvim_wallpaper = "linkin_park_wallpaper.png",
  normal_wallpaper = "landscape1.jpg",
}

local function change_wallpaper(image_path)
  local is_wsl_env = os.getenv("WSLENV")

  if not is_wsl_env then
    image_path = "/usr/share/backgrounds/" .. image_path

    local display = os.getenv("display") or ":0"
    
    local commands = {
      feh = string.format("display=%s feh --bg-scale '%s'", display, image_path),
      nitrogen = string.format("display=%s nitrogen --set-zoom-fill '%s' --save", display, image_path),
      xwallpaper = string.format("display=%s xwallpaper --stretch '%s'", display, image_path),
    }
    
    if vim.fn.executable("feh") == 1 then
      -- print("attempting to change wallpaper to: " .. image_path)
      -- print("running command: " .. commands.feh)
      
      local handle = io.popen(commands.feh .. " 2>&1")
      local output = handle:read("*a")
      local success, exit_type, exit_code = handle:close()
      
      -- print("command output: " .. (output or "no output"))
      -- print("exit code: " .. tostring(exit_code))
      
      if not success then
        print("feh command failed when changing wallpaper")
      end
    elseif vim.fn.executable("nitrogen") == 1 then
      os.execute(commands.nitrogen)
      print("wallpaper changed using nitrogen")
    elseif vim.fn.executable("xwallpaper") == 1 then
      os.execute(commands.xwallpaper)
      print("wallpaper changed using xwallpaper")
    else
      print("no wallpaper tool found. please install feh, nitrogen, or xwallpaper")
    end
  end

end

local wallpaper_group = vim.api.nvim_create_augroup("wallpaperchanger", { clear = true })

-- change to coding wallpaper when entering neovim
vim.api.nvim_create_autocmd("UIEnter", {
  group = wallpaper_group,
  callback = function()
    change_wallpaper(wallpaper_config.nvim_wallpaper)
  end,
})

-- restore normal wallpaper when exiting neovim
vim.api.nvim_create_autocmd("VimLeave", {
  group = wallpaper_group,
  callback = function()
    change_wallpaper(wallpaper_config.normal_wallpaper)
  end,
})

-- optional: manual commands to change wallpaper
vim.api.nvim_create_user_command("CodingWallpaper", function()
  change_wallpaper(wallpaper_config.nvim_wallpaper)
end, {})

vim.api.nvim_create_user_command("NormalWallpaper", function()
  change_wallpaper(wallpaper_config.normal_wallpaper)
end, {})
