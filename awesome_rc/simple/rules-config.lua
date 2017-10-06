local awful = require("awful")
local beautiful = require("beautiful")
local debug = require("gears.debug")

rules = {}
function rules:init(args)
  debug.print_warning(args.clientkeys)
  debug.print_warning(args.test)
  local args = args or {}
  -- {{{ Rules
  -- Rules to apply to new clients (through the "manage" signal).
  self.rules = {
      -- All clients will match this rule.
      { rule = { },
        properties = { border_width = beautiful.border_width,
                       border_color = beautiful.border_normal,
                       focus = awful.client.focus.filter,
                       raise = true,
                       keys = args.clientkeys,
                       buttons = args.clientbuttons,
                       screen = awful.screen.preferred,
                       placement = awful.placement.no_overlap+awful.placement.no_offscreen,
             size_hints_honor = false
       }
      },

      -- Floating clients.
      { rule_any = {
          instance = {
            "DTA",  -- Firefox addon DownThemAll.
            "copyq",  -- Includes session name in class.
          },
          class = {
            "Arandr",
            "Gpick",
            "Kruler",
            "MessageWin",  -- kalarm.
            "Sxiv",
            "Wpa_gui",
            "pinentry",
            "veromix",
            "xtightvncviewer"},

          name = {
            "Event Tester",  -- xev.
          },
          role = {
            "AlarmWindow",  -- Thunderbird's calendar.
            "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
          }
        }, properties = { floating = true }},

      -- Add titlebars to normal clients and dialogs
      { rule_any = {type = { "normal", "dialog" }
        }, properties = { titlebars_enabled = false }
      },

      -- Set Firefox to always map on the tag named "2" on screen 1.
      { rule = { class = "Firefox" },
        properties = { screen = 1, tag = " β " } },
  }
  -- }}}
  awful.rules.rules = rules.rules
end
return rules
