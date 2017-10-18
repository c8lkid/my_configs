local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")
local deb_menu = require("debian.menu")

menu = {}
function menu:init(args)
  local args = args or {}
  -- {{{ Menu
  -- Create a launcher widget and a main menu
  myawesomemenu = {
     { "hotkeys", function() return false, hotkeys_popup.show_help end},
     { "manual", args.terminal .. " -e man awesome" },
     { "edit config", args.editor_cmd .. " " .. awesome.conffile },
     { "restart", awesome.restart },
     { "quit", function() awesome.quit() end}
  }
  mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                      { "Debian", deb_menu.Debian_menu.Debian },
                                      { "open terminal", args.terminal }
                                    }
                          })

  self.mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                       menu = mymainmenu })

  -- Menubar configuration
  menubar.utils.terminal = args.terminal -- Set the terminal for applications that require it
  -- }}}
end
return menu
