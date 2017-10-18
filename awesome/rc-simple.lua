-- Standard awesome library
local debug = require("gears.debug")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Notification library
local naughty = require("naughty")

-- My widgets
-- local mybatterybar = require("widgets.battery")
local vicious = require("vicious")

-- Timestamp for restarting awesome states
timestamp = require("simple.core.timestamp")


-- Keyboard layout
kbdwidget = wibox.widget.textbox()
kbdwidget:set_valign(true)
kbdwidget:set_markup("<span color='#FFFFFF' font='DejaVu Sans Mono 15'> ✡ </span>")
dbus.request_name("session", "ru.gentoo.kbdd")
dbus.add_match("session", "interface='ru.gentoo.kbdd',member='layoutChanged'")
dbus.connect_signal("ru.gentoo.kbdd", function(...)
    local data = {...}   
    local layout = data[2]
    lts = {[0] = "<span color='#DCDCCC' font='DejaVu Sans Mono 15'> ✡ </span>", [1] = "<span color='#FF0000' font='DejaVu Sans Mono 15'> ☭ </span>"}
    kbdwidget:set_markup(lts[layout])
    end
)

viciousbat0 = vicious.register(wibox.widget.textbox(), vicious.widgets.bat, 
    function(widget, args)
      return args[1] .. args[2] .. "% "
    end, 30, "BAT0")

viciousbat1 = vicious.register(wibox.widget.textbox(), vicious.widgets.bat, 
    function(widget, args)
      return args[1] .. args[2] .. "% "
    end, 30, "BAT1")

viciouswifi = vicious.register(wibox.widget.textbox(), vicious.widgets.wifi, 
    function(widget, args)
      return args["{ssid}"] .. args["{sign}"] .. "% "
    end, 5, "wlp58s0")

viciousvolume = vicious.register(wibox.widget.textbox(), vicious.widgets.volume, 
    function(widget, args)
      return args[2] .. args[1] .. "% "
    end, 1, "Master")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end

-- }}}
local function show_dbg_msg(msg)
	naughty.notify({ preset = naughty.config.presets.critical,
					 title = "Oops, there were errors during startup!",
					 text = msg,
					 hover_timeout = 2})
end 

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Init environment
local env = require("simple.env-config")
env:init()

-- Init menu
local menu = require("simple.menu-config")
menu:init(env)

-- Init shortcuts
local hotkeys = require("simple.keys-config")
hotkeys:init(env)

-- Init client rules
local rules = require("simple.rules-config")
rules:init(hotkeys)

-- Init signals
local signals = require("simple.signals-config")
signals:init()

-- Init layouts
local layouts = require("simple.layouts-config")
layouts:init()

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    env.set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({" I ", " II ", " III ", " IV ", " V ", " VI "}, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.noempty, hotkeys.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, hotkeys.tasklist_buttons)

    -- Create the wibox
    s.mywibar = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibar:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            menu.mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            -- viciouswifi,
            -- viciousbat0,
            -- viciousbat1,
            -- viciousvolume,
            layout = wibox.layout.fixed.horizontal,
            -- mykeyboardlayout,
            kbdwidget,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)

-- Autostart user applications
-----------------------------------------------------------------------------------------------------------------------
local autostart = require("simple.autostart-config") -- load file with autostart application list

if timestamp.is_startup() then
	autostart.run()
end
