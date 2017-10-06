-------------------------------
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
-------------------------------

-- Alternative icon sets and widget icons:
--  * http://awesome.naquadah.org/wiki/Nice_Icons

-- {{{ Main
theme = {}
theme.wallpaper = "/home/can4ez/.config/awesome/themes/zenburn/background-2.jpg"
-- }}}

-- {{{ Styles
theme.font      = "DejaVu Sans Mono 10"
-- theme.font      = "Inconsolata LGC 10"
 
-- Naughty config
-----------------------------------------------------------------------------------------------------------------------
theme.naughty = {}

theme.naughty.base = {
	timeout      = 10,
	margin       = 12,
	icon_size    = 80,
	border_width = 4,
}
theme.naughty.normal = {}
theme.naughty.critical = { timeout = 0, border_color = "#00FF00"}
theme.naughty.low = { timeout = 5 }
-----------------------------------------------------------------------------------------------------------------------

-- {{{ Colors
theme.fg_normal  = "#DCDCCC"
theme.fg_focus   = "#F0DFAF"
theme.fg_urgent  = "#CC9393"
theme.bg_normal  = "#313131"
theme.bg_focus   = "#1E2320"
theme.bg_urgent  = "#3F3F3F"
theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.border_width  = 2
theme.border_normal = "#3F3F3F"
--theme.border_focus  = "#6F6F6F"
theme.border_focus  = "#7F000000"
theme.border_marked = "#CC9393"
theme.useless_gap   = 3  -- useless gap
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}
theme.tooltip_border_width = 1
theme.tooltip_border_color = "#00FF00"
theme.tooltip_opacity = 0.5

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = 15
theme.menu_width  = 100
-- }}}

-- {{{ Icons
-- {{{ Taglist
-- theme.taglist_squares_sel   = "/home/can4ez/.config/awesome/themes/zenburn/taglist/squarefz.png"
-- theme.taglist_squares_unsel = "/home/can4ez/.config/awesome/themes/zenburn/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = "/home/can4ez/.config/awesome/themes/zenburn/awesome-icon.png"
theme.menu_submenu_icon      = "/home/can4ez/.config/awesome/themes/default/submenu.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = "/home/can4ez/.config/awesome/themes/zenburn/layouts/tile.png"
theme.layout_tileleft   = "/home/can4ez/.config/awesome/themes/zenburn/layouts/tileleft.png"
theme.layout_tilebottom = "/home/can4ez/.config/awesome/themes/zenburn/layouts/tilebottom.png"
theme.layout_tiletop    = "/home/can4ez/.config/awesome/themes/zenburn/layouts/tiletop.png"
theme.layout_fairv      = "/home/can4ez/.config/awesome/themes/zenburn/layouts/fairv.png"
theme.layout_fairh      = "/home/can4ez/.config/awesome/themes/zenburn/layouts/fairh.png"
theme.layout_spiral     = "/home/can4ez/.config/awesome/themes/zenburn/layouts/spiral.png"
theme.layout_dwindle    = "/home/can4ez/.config/awesome/themes/zenburn/layouts/dwindle.png"
theme.layout_max        = "/home/can4ez/.config/awesome/themes/zenburn/layouts/max.png"
theme.layout_fullscreen = "/home/can4ez/.config/awesome/themes/zenburn/layouts/fullscreen.png"
theme.layout_magnifier  = "/home/can4ez/.config/awesome/themes/zenburn/layouts/magnifier.png"
theme.layout_floating   = "/home/can4ez/.config/awesome/themes/zenburn/layouts/floating.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = "/home/can4ez/.config/awesome/themes/zenburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal = "/home/can4ez/.config/awesome/themes/zenburn/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active  = "/home/can4ez/.config/awesome/themes/zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = "/home/can4ez/.config/awesome/themes/zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = "/home/can4ez/.config/awesome/themes/zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = "/home/can4ez/.config/awesome/themes/zenburn/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = "/home/can4ez/.config/awesome/themes/zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = "/home/can4ez/.config/awesome/themes/zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = "/home/can4ez/.config/awesome/themes/zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = "/home/can4ez/.config/awesome/themes/zenburn/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = "/home/can4ez/.config/awesome/themes/zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = "/home/can4ez/.config/awesome/themes/zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = "/home/can4ez/.config/awesome/themes/zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = "/home/can4ez/.config/awesome/themes/zenburn/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = "/home/can4ez/.config/awesome/themes/zenburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = "/home/can4ez/.config/awesome/themes/zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = "/home/can4ez/.config/awesome/themes/zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = "/home/can4ez/.config/awesome/themes/zenburn/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme
