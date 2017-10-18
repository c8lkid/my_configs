local beautiful = require("beautiful")
local gears = require("gears")

env = {}
function env:init(args)

  local args = args or {}
  -- {{{ Variable definitions
  -- Themes define colours, icons, font and wallpapers.
  beautiful.init("/home/algvozdev/.config/awesome/themes/zenburn/theme.lua")
  -- beautiful.init(awful.util.get_themes_dir() .. "zenburn/theme.lua")

  -- This is used later as the default terminal and editor to run.
  self.terminal = args.terminal or "urxvt -bc"
  self.editor = os.getenv("EDITOR") or "editor"
  self.editor_cmd = self.terminal .. " -e " .. self.editor
  self.screenshooter = args.screenshooter or "xfce4-screenshooter"

  -- Default modkey.
  -- Usually, Mod4 is the key with a logo between Control and Alt.
  -- If you do not like this or do not have such a key,
  -- I suggest you to remap Mod4 to another key using xmodmap or other tools.
  -- However, you can use another modifier like Mod1, but it may interact with others.
  self.modkey = "Mod4"

  self.set_wallpaper = function(s)
      -- Wallpaper
      if beautiful.wallpaper then
          local wallpaper = beautiful.wallpaper
          -- If wallpaper is a function, call it with the screen
          if type(wallpaper) == "function" then
              wallpaper = wallpaper(s)
          end
          gears.wallpaper.maximized(wallpaper, s, true)
      end
  end

  -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
  screen.connect_signal("property::geometry", self.set_wallpaper)
end
return env
