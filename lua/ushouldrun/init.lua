require("ushouldrun.remap")
require("ushouldrun.set")

local wallpaper_config = {
  nvim_wallpaper = "/usr/share/backgrounds/linkin_park_wallpaper.png",
  normal_wallpaper = "/usr/share/backgrounds/landscape1.jpg",
}

-- Function to change wallpaper based on desktop environment
local function change_wallpaper(image_path)
  local display = os.getenv("DISPLAY") or ":0"
  
  local commands = {
    feh = string.format("DISPLAY=%s feh --bg-scale '%s'", display, image_path),
    nitrogen = string.format("DISPLAY=%s nitrogen --set-zoom-fill '%s' --save", display, image_path),
    xwallpaper = string.format("DISPLAY=%s xwallpaper --stretch '%s'", display, image_path),
  }
  
  if vim.fn.executable("feh") == 1 then
    -- print("Attempting to change wallpaper to: " .. image_path)
    -- print("Running command: " .. commands.feh)
    
    local handle = io.popen(commands.feh .. " 2>&1")
    local output = handle:read("*a")
    local success, exit_type, exit_code = handle:close()
    
    -- print("Command output: " .. (output or "no output"))
    -- print("Exit code: " .. tostring(exit_code))
    
    if not success then
      print("feh command failed when changing wallpaper")
    end
  elseif vim.fn.executable("nitrogen") == 1 then
    os.execute(commands.nitrogen)
    print("Wallpaper changed using nitrogen")
  elseif vim.fn.executable("xwallpaper") == 1 then
    os.execute(commands.xwallpaper)
    print("Wallpaper changed using xwallpaper")
  else
    print("No wallpaper tool found. Please install feh, nitrogen, or xwallpaper")
    print("Install with: sudo apt install feh")
  end
end

local wallpaper_group = vim.api.nvim_create_augroup("WallpaperChanger", { clear = true })

-- Change to coding wallpaper when entering Neovim
vim.api.nvim_create_autocmd("VimEnter", {
  group = wallpaper_group,
  callback = function()
    change_wallpaper(wallpaper_config.nvim_wallpaper)
  end,
})

-- Restore normal wallpaper when exiting Neovim
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = wallpaper_group,
  callback = function()
    change_wallpaper(wallpaper_config.normal_wallpaper)
  end,
})

-- Optional: Manual commands to change wallpaper
vim.api.nvim_create_user_command("CodingWallpaper", function()
  change_wallpaper(wallpaper_config.nvim_wallpaper)
end, {})

vim.api.nvim_create_user_command("NormalWallpaper", function()
  change_wallpaper(wallpaper_config.normal_wallpaper)
end, {})
