local awful = require("awful")
local debug = require("gears.debug")
require("awful.hotkeys_popup.keys.vim")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local menubar = require("menubar")

local hotkeys = {}

function hotkeys:init(args)
  local args = args or {}
  -- Create a wibox for each screen and add it
  self.taglist_buttons = awful.util.table.join(
                      awful.button({ }, 1, function(t) t:view_only() end),
                      awful.button({ args.modkey }, 1, function(t)
                                                if client.focus then
                                                    client.focus:move_to_tag(t)
                                                end
                                            end),
                      awful.button({ }, 3, awful.tag.viewtoggle),
                      awful.button({ args.modkey }, 3, function(t)
                                                if client.focus then
                                                    client.focus:toggle_tag(t)
                                                end
                                            end)
                      -- awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                      -- awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                  )

  self.tasklist_buttons = awful.util.table.join(
                       awful.button({ }, 1, function (c)
                                                if c == client.focus then
                                                    c.minimized = true
                                                else
                                                    -- Without this, the following
                                                    -- :isvisible() makes no sense
                                                    c.minimized = false
                                                    if not c:isvisible() and c.first_tag then
                                                        c.first_tag:view_only()
                                                    end
                                                    -- This will also un-minimize
                                                    -- the client, if needed
                                                    client.focus = c
                                                    c:raise()
                                                end
                                            end),
--                       awful.button({ }, 3, client_menu_toggle_fn()),
                       awful.button({ }, 4, function ()
                                                awful.client.focus.byidx(1)
                                            end),
                       awful.button({ }, 5, function ()
                                                awful.client.focus.byidx(-1)
                                            end))

  -- {{{ Mouse bindings
  root.buttons(awful.util.table.join(
      awful.button({ }, 3, function () mymainmenu:toggle() end),
      awful.button({ }, 4, awful.tag.viewnext),
      awful.button({ }, 5, awful.tag.viewprev)
  ))
  -- }}}

  -- {{{ Key bindings
  globalkeys = awful.util.table.join(
  -- [[[ Utils
      awful.key({ args.modkey,           }, "F1",      hotkeys_popup.show_help,
                {description= "show help", group="Utils"}),
      awful.key({ args.modkey,           }, "Return", function () awful.spawn(args.terminal) end,
                {description = "open a terminal", group = "Utils"}),
      awful.key({ args.modkey            }, "Print", function() awful.spawn(args.screenshooter) end,
                {description = "Take a screenshot", group = "Utils" }),
    -- ]]]
    --
    -- [[[ Awesome control
      awful.key({ args.modkey, "Control" }, "r", awesome.restart,
                {description = "reload awesome", group = "Awesome"}),
      awful.key({ args.modkey, "Shift"   }, "q", awesome.quit,
                {description = "quit awesome", group = "Awesome"}),
      awful.key({ args.modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
                {description = "run prompt", group = "Awesome"}),
      awful.key({ args.modkey }, "x",
                function ()
                    awful.prompt.run {
                      prompt       = "Run Lua code: ",
                      textbox      = awful.screen.focused().mypromptbox.widget,
                      exe_callback = awful.util.eval,
                      history_path = awful.util.get_cache_dir() .. "/history_eval"
                    }
                end,
                {description = "lua execute prompt", group = "Awesome"}),
      awful.key({ args.modkey }, "p", function() menubar.show() end,
                {description = "show the menubar", group = "Awesome"}),
      awful.key({ args.modkey,           }, "e", function () mymainmenu:show() end,
                {description = "show main menu", group = "Awesome"}),
    -- ]]]
    --
    -- [[[ Tag control
      awful.key({ args.modkey,           }, "Left",   awful.tag.viewprev,
                {description = "view previous", group = "Tag"}),
      awful.key({ args.modkey,           }, "Right",  awful.tag.viewnext,
                {description = "view next", group = "Tag"}),
      awful.key({ args.modkey,           }, "Escape", awful.tag.history.restore,
                {description = "go back", group = "Tag"}),

    -- ]]]
    --
    -- [[[ Global client control
      awful.key({ args.modkey,           }, "j",
          function ()
              awful.client.focus.byidx( 1)
          end,
          {description = "focus next by index", group = "Client"}
      ),
      awful.key({ args.modkey,           }, "k",
          function ()
              awful.client.focus.byidx(-1)
          end,
          {description = "focus previous by index", group = "Client"}
      ),
      awful.key({ args.modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
                {description = "swap with next client by index", group = "Client"}),
      awful.key({ args.modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
                {description = "swap with previous client by index", group = "Client"}),
      awful.key({ args.modkey,           }, "u", awful.client.urgent.jumpto,
                {description = "jump to urgent client", group = "Client"}),
      awful.key({ args.modkey,           }, "Tab",
          function ()
              awful.client.focus.history.previous()
              if client.focus then
                  client.focus:raise()
              end
          end,
          {description = "go back", group = "Client"}),
      awful.key({ args.modkey, "Control" }, "n",
                function ()
                    local c = awful.client.restore()
                    -- Focus restored client
                    if c then
                        client.focus = c
                        c:raise()
                    end
                end,
                {description = "restore minimized", group = "Client"}),
    -- ]]]
    --
    -- [[[ Screen control
      awful.key({ args.modkey,           }, "s", function () awful.screen.focus_relative( 1) end,
                {description = "focus the next screen", group = "Screen"}),
      awful.key({ args.modkey, "Shift"   }, "s", function () awful.screen.focus_relative(-1) end,
                {description = "focus the previous screen", group = "Screen"}),

      -- ]]]
      --
      -- [[[ Layout control
      awful.key({ args.modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
                {description = "increase master width factor", group = "Layout"}),
      awful.key({ args.modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
                {description = "decrease master width factor", group = "Layout"}),
      awful.key({ args.modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
                {description = "increase the number of master clients", group = "Layout"}),
      awful.key({ args.modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
                {description = "decrease the number of master clients", group = "Layout"}),
      awful.key({ args.modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
                {description = "increase the number of columns", group = "Layout"}),
      awful.key({ args.modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
                {description = "decrease the number of columns", group = "Layout"}),
      awful.key({ args.modkey,           }, "space", function () awful.layout.inc( 1)                end,
                {description = "select next", group = "Layout"}),
      awful.key({ args.modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
                {description = "select previous", group = "Layout"}),


    -- ]]]
    --
    -- [[[ Functional keys control
      awful.key({ }, "XF86MonBrightnessUp",
                function ()
                    awful.spawn.with_shell("xbacklight -inc 10")
                  end,
                  {description = "Up brightness by 10 %", group = "Functional keys"}),
      awful.key({ }, "XF86MonBrightnessDown",
                function ()
                    awful.spawn.with_shell("xbacklight -dec 10")
                  end,
                  {description = "Down brightness by 10 %", group = "Functional keys"})
    -- ]]]
  )

  -- }}}
  --
  -- {{ Clientkeys bindings
  self.clientkeys = awful.util.table.join(
  -- [[[ Client control
      awful.key({ args.modkey,           }, "f",
          function (c)
              c.fullscreen = not c.fullscreen
              c:raise()
          end,
          {description = "toggle fullscreen", group = "Client control"}),
      awful.key({ args.modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
                {description = "close", group = "Client control"}),
      awful.key({ args.modkey, "Shift" }, "t", awful.titlebar.toggle),
      awful.key({ args.modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
                {description = "toggle floating", group = "Client control"}),
      awful.key({ args.modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
                {description = "move to master", group = "Client control"}),
      awful.key({ args.modkey,           }, "w",      function (c) c:move_to_screen()               end,
                {description = "move to screen", group = "Client control"}),
      awful.key({ args.modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
                {description = "toggle keep on top", group = "Client control"}),
      awful.key({ args.modkey,           }, "n",
          function (c)
              -- The client currently has the input focus, so it cannot be
              -- minimized, since minimized clients can't have the focus.
              c.minimized = true
          end ,
          {description = "minimize", group = "Client control"}),
      awful.key({ args.modkey,           }, "m",
          function (c)
              c.maximized = not c.maximized
              c:raise()
          end ,
          {description = "maximize", group = "Client control"})
  )
  -- ]]]
  -- }}

  -- Bind all key numbers to tags.
  -- Be careful: we use keycodes to make it works on any keyboard layout.
  -- This should map on the top row of your keyboard, usually 1 to 9.
  for i = 1, 9 do
      globalkeys = awful.util.table.join(globalkeys,
          -- View tag only.
          awful.key({ args.modkey }, "#" .. i + 9,
                    function ()
                          local screen = awful.screen.focused()
                          local tag = screen.tags[i]
                          if tag then
                             tag:view_only()
                          end
                    end,
                    {description = "view tag #"..i, group = "tag"}),
          -- Toggle tag display.
          awful.key({ args.modkey, "Control" }, "#" .. i + 9,
                    function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           awful.tag.viewtoggle(tag)
                        end
                    end,
                    {description = "toggle tag #" .. i, group = "tag"}),
          -- Move client to tag.
          awful.key({ args.modkey, "Shift" }, "#" .. i + 9,
                    function ()
                        if client.focus then
                            local tag = client.focus.screen.tags[i]
                            if tag then
                                client.focus:move_to_tag(tag)
                            end
                       end
                    end,
                    {description = "move focused client to tag #"..i, group = "tag"}),
          -- Toggle tag on focused client.
          awful.key({ args.modkey, "Control", "Shift" }, "#" .. i + 9,
                    function ()
                        if client.focus then
                            local tag = client.focus.screen.tags[i]
                            if tag then
                                client.focus:toggle_tag(tag)
                            end
                        end
                    end,
                    {description = "toggle focused client on tag #" .. i, group = "tag"})
      )
  end

  self.clientbuttons = awful.util.table.join(
      awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
      awful.button({ args.modkey }, 1, awful.mouse.client.move),
      awful.button({ args.modkey }, 3, awful.mouse.client.resize))

  -- Set keys
  root.keys(globalkeys)
  -- }}}
end
-- debug.print_warning(hotkeys.test)
return hotkeys
