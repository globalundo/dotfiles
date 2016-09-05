
--[[

     Multicolor Awesome WM config 2.0
     github.com/copycat-killer

--]]

-- {{{ Required libraries
local gears      = require("gears")
local awful      = require("awful")
awful.rules      = require("awful.rules")
require("awful.autofocus")
local wibox      = require("wibox")
local beautiful  = require("beautiful")
local naughty    = require("naughty")
local lain       = require("lain")
local tyrannical = require("tyrannical")
-- }}}


local screen_down = 1
local screen_left = 2
local screen_up   = 3

naughty.config.presets.normal.opacity   = 0.9
naughty.config.presets.low.opacity      = 0.9
naughty.config.presets.critical.opacity = 0.9

naughty.config.defaults.timeout = 20
--naughty.config.presets = {
--    normal = {
--          timeout = 0,
--             bg = "#0000ff",
--
--  },
--    low = {
--        timeout = 0,
--        bg = "#00ff00",
--    },
--    critical = {
--        bg = "#ff0000",
--        fg = "#ffffff",
--        timeout = 0,
--    }
--}


-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

awful.util.spawn_with_shell("urxvt")

-- {{{ Variable definitions
-- localization
os.setlocale(os.getenv("LANG"))

-- beautiful init
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/multicolor/theme.lua")

-- common
modkey     = "Mod4"
altkey     = "Mod1"

local layouts = {
--    awful.layout.suit.tile,
--    awful.layout.suit.tile.left,
--    awful.layout.suit.tile.bottom,
--    awful.layout.suit.tile.top,
--    awful.layout.suit.fair,
--    awful.layout.suit.fair.horizontal,
--    awful.layout.suit.spiral,
--    awful.layout.suit.spiral.dwindle,
   -- awful.layout.suit.max,
    lain.layout.uselessfair,
    awful.layout.suit.fair,
    -- treetile,
    -- lain.layout.termfair,
    -- lain.layout.centerwork,
    -- awful.layout.suit.spiral,
--    treesome
   awful.layout.suit.floating,
}
-- }}}

lain.layout.termfair.nmaster = 3
lain.layout.termfair.ncol = 1

-- {{{ Tags
-- storage_tags = '.config/awesome/tags.lua'
-- if file_exists(storage_tags)
-- then
--     tags = persistence.load(storage_tags)
-- else
  -- tags = {
  --    -- names = { "web", "term", "more terms", "messaging", "X", "X", "X", "X", "X", "X", "X", "X" },
  --   names = { "🌎", "", "", "", "⌨", "🎬", "", "" },
  --    -- layout = { layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1] }
  -- }

tyrannical.settings.block_children_focus_stealing = true --Block popups ()
tyrannical.settings.group_children = true --Force popups/dialogs to have the same tags as the parent client
tyrannical.settings.default_layout = lain.layout.uselessfair

tyrannical.tags = {
    {
        name        = "",                 -- Call the tag "Term"
        init        = true,                   -- Load the tag on startup
        exclusive   = false,                   -- Refuse any other type of clients (by classes)
        screen      = {screen_down, screen_up},                  -- Create this tag on screen 1 and screen 2
        max_clients = 4,
        class       = { --Accept the following classes, refuse everything else (because of "exclusive=true")
            "xterm" , "urxvt" , "aterm","URxvt","XTerm","konsole","terminator","gnome-terminal"
        }
    } ,
    {
        name        = "",
        init        = true,
        exclusive   = false,
        max_clients = 4,
        screen      = screen.count()>2 and screen_left or screen_down,
        class = {"nagstamon"}
    } ,
    {
        name        = "",
        init        = true,
        exclusive   = false,
        screen      = screen_down,
        class = {"skype", "pidgin"}
    } ,
    {
        name        = "⌨",
        init        = false,
        exclusive   = false,
        screen      = {screen_down, screen_up},
        max_clients = 2,
        class = {"sublime_text"}
    } ,
    {
        name        = "🌎",
        init        = false,
        exclusive   = false,
        screen      = {screen_down, screen_up},
        max_clients = 2,
        class = {"chromium-browser"}
    }
}

-- Ignore the tag "exclusive" property for the following clients (matched by classes)
-- tyrannical.properties.intrusive = {
--     "ksnapshot"     , "pinentry"       , "gtksu"     , "kcalc"        , "xcalc"               ,
--     "feh"           , "Gradient editor", "About KDE" , "Paste Special", "Background color"    ,
--     "kcolorchooser" , "plasmoidviewer" , "Xephyr"    , "kruler"       , "plasmaengineexplorer",
-- }

-- Ignore the tiled layout for the matching clients
tyrannical.properties.floating = {
    "MPlayer"      , "pinentry"        , "ksnapshot"  , "pinentry"     , "gtksu"          ,
    "xine"         , "feh"             , "kmix"       , "kcalc"        , "xcalc"          ,
    "yakuake"      , "Select Color$"   , "kruler"     , "kcolorchooser", "Paste Special"  ,
    "New Form"     , "Insert Picture"  , "kcharselect", "mythfrontend" , "plasmoidviewer",
    "pavucontrol"
}

-- Make the matching clients (by classes) on top of the default layout
tyrannical.properties.ontop = {
    "Xephyr" , "pavucontrol", "keepass2", "KeePass"
}

-- Force the matching clients (by classes) to be centered on the screen on init
tyrannical.properties.centered = {
    "pavucontrol", "keepass2", "KeePass"
}

-- {{{ Wibox
markup = lain.util.markup

-- Textclock
clockicon   = wibox.widget.imagebox(beautiful.widget_clock)
mytextclock = awful.widget.textclock(markup("#7788af", "%A %d %B ") .. markup("#343639", ">") .. markup("#de5e1e", " %H:%M "))

-- Calendar
lain.widgets.calendar:attach(mytextclock, { font_size = 11 })

-- Keyboard layout widget
kbdwidget = wibox.widget.textbox(" Eng ")
kbdwidget.border_width = 1

kbdwidget.border_color = beautiful.fg_normal
kbdwidget:set_text(" Eng ")


-- kbdd dbus
kbdstrings = {[0] = " Eng ",
              [1] = " Рус "}

dbus.request_name("session", "ru.gentoo.kbdd")
dbus.add_match("session", "interface='ru.gentoo.kbdd',member='layoutChanged'")
dbus.connect_signal("ru.gentoo.kbdd", function(...)
    local data = {...}
    local layout = data[2]
    kbdwidget:set_markup(kbdstrings[layout])
    end
)

-- CPU
cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.widget_cpu)
cpuwidget = lain.widgets.cpu({
    settings = function()
        widget:set_markup(markup("#e33a6e", cpu_now.usage .. "% "))
    end
})

-- Coretemp
tempicon = wibox.widget.imagebox(beautiful.widget_temp)
tempwidget = lain.widgets.temp({
    settings = function()
        widget:set_markup(markup("#f1af5f", coretemp_now .. "°C "))
    end
})

-- Turbo
turboicon = wibox.widget.imagebox()
function turbo_toggle()
    local turbomode = io.popen('turbo_mode')
    turboicon:set_image(nil)
    if turbomode:read() == "1" then
        turboicon:set_image(beautiful.widget_temp_turbo)
    end
end
turbo_toggle()

-- Powersave
powersaveicon = wibox.widget.imagebox()
function powersave_toggle()
    local powersavemode = io.popen('powersave')
    powersaveicon:set_image(nil)
    if powersavemode:read() == "on" then
        powersaveicon:set_image(beautiful.widget_powersave)
    end
end
powersave_toggle()

--turboicon:set_image(nil)


--turboicon:set_image(nil)
--turboicon = turboicon:set_image(beautiful.widget_temp)
--turboicon:set_image(beautiful.widget_note_on)
--if turbomode:read() == "1" then
--    turboicon:set_image(beautiful.widget_temp_turbo)
--end


-- Brightness level
-- brightness_icon = wibox.widget.imagebox(beautiful.widget_batt)
-- brightness_widget = lain.widgets.contrib.brightness({
--     backlight = 'acpi_video1',
--     settings = function()
--  widget:set_text(brightness_now .. "% ")
--     end
-- })



-- Battery
baticon = wibox.widget.imagebox(beautiful.widget_batt)
batwidget = lain.widgets.bat({
    settings = function()
        if bat_now.perc == "N/A" then
            bat_now.perc = "AC "
        else
            bat_now.perc = bat_now.perc .. "% "
        end
        widget:set_text(bat_now.perc)
    end
})

-- ALSA volume
volicon = wibox.widget.imagebox(beautiful.widget_vol)
volumewidget = lain.widgets.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end
        widget:set_markup(markup("#7493d2", volume_now.level .. "% "))
    end
})

-- Spacer
spacer = wibox.widget.textbox(" ")

-- }}}

-- {{{ Layout

-- Create a wibox for each screen and add it
mywibox = {}
-- mybottomwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({        }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({        }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({        }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({        }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )

for s = 1, screen.count() do

    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()


    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                            awful.button({ }, 1, function () awful.layout.inc(layouts,  1) end),
                            awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                            awful.button({ }, 4, function () awful.layout.inc(layouts,  1) end),
                            awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create the upper wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 20 })
    --border_width = 0, height =  20 })

    -- Widgets that are aligned to the upper left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])


    -- Widgets that are aligned to the upper right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end

    right_layout:add(kbdwidget)
    right_layout:add(volicon)
    right_layout:add(volumewidget)

    right_layout:add(cpuicon)
    right_layout:add(cpuwidget)

    right_layout:add(turboicon)
    right_layout:add(baticon)
    right_layout:add(batwidget)
    right_layout:add(powersaveicon)
    right_layout:add(clockicon)
    right_layout:add(mytextclock)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)

end
-- }}}

-- {{{ Mouse Bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey }, "Escape", awful.tag.history.restore),

    -- Non-empty tag browsing
    awful.key({ altkey          }, "Left",  awful.tag.viewprev ),
    awful.key({ altkey          }, "Right", awful.tag.viewnext ),
    awful.key({ modkey, "Shift" }, "d", function () lain.util.remove_tag() end),



    awful.key({ modkey, "Shift" }, "r",
        function ()
            lain.util.rename_tag(mypromptbox)
        end),


    -- Default client focus
    awful.key({ altkey }, "k",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ altkey }, "j",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- By direction client focus
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),


    -- Switch tag between screens
    awful.key({ modkey, "Shift"   }, "Down", function ()
            local screen = mouse.screen
            local tag = awful.tag.selected(screen)
            awful.tag.history.restore()
            awful.tag.setscreen(tag, awful.screen.focus_bydirection('down', mouse.screen))
            awful.tag.viewonly(tag)
    end),

    awful.key({ modkey, "Shift"   }, "Up", function ()
            local screen = mouse.screen
            local tag = awful.tag.selected(screen)
            awful.tag.history.restore()
            awful.tag.setscreen(tag, awful.screen.focus_bydirection('up', mouse.screen))
            awful.tag.viewonly(tag)
    end),

    awful.key({ modkey, "Shift"   }, "Left", function ()
            local screen = mouse.screen
            local tag = awful.tag.selected(screen)
            awful.tag.history.restore()
            awful.tag.setscreen(tag, awful.screen.focus_bydirection('left', mouse.screen))
            awful.tag.viewonly(tag)
    end),

    awful.key({ modkey, "Shift"   }, "Right", function ()
            local screen = mouse.screen
            local tag = awful.tag.selected(screen)
            awful.tag.history.restore()
            awful.tag.setscreen(tag, awful.screen.focus_bydirection('right', mouse.screen))
            awful.tag.viewonly(tag)
    end),
    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),

    awful.key({ modkey, }, "=", function () lain.util.useless_gaps_resize(5) end),
    awful.key({ modkey, }, "-", function () lain.util.useless_gaps_resize(-5) end),
    --awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    --awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey, }, "Up",   function () awful.screen.focus(screen_up)   end),
    awful.key({ modkey, }, "Down", function () awful.screen.focus(screen_down) end),
    awful.key({ modkey, }, "Left", function () awful.screen.focus(screen_left) end),

    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
    awful.key({ altkey, "Shift"   }, "l",      function () awful.tag.incmwfact( 0.05)     end),
    awful.key({ altkey, "Shift"   }, "h",      function () awful.tag.incmwfact(-0.05)     end),
    awful.key({ modkey, "Shift"   }, "l",      function () awful.tag.incnmaster(-1)       end),
    awful.key({ modkey, "Shift"   }, "h",      function () awful.tag.incnmaster( 1)       end),
    awful.key({ modkey, "Control" }, "l",      function () awful.tag.incncol(-1)          end),
    awful.key({ modkey, "Control" }, "h",      function () awful.tag.incncol( 1)          end),
    awful.key({ modkey,           }, "space",  function () awful.layout.inc(layouts,  1)  end),
    awful.key({ modkey, "Control" }, "r",      awful.util.restart),
    awful.key({ modkey, "Shift" }, "n",
        function ()
            local tag = awful.tag.add(awful.tag.selected(mouse.screen).name,{onetimer=true,volatile=true,exclusive=true,screen=mouse.screen or 1,layout=tyrannical.settings.layout or tyrannical.settings.default_layout or awful.layout.suit.max})
            awful.client.movetotag(tag)
            awful.tag.viewonly(tag)
            end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.movetotag(tag)
                          awful.tag.viewonly(tag)
                     end
                  end)
        -- awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
        --           function ()
        --               local tag = awful.tag.gettags(client.focus.screen)[i]
        --               if client.focus and tag then
        --                   awful.client.toggletag(tag)
        --               end
        --           end)
        )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = {
       border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     size_hints_honor = false,

                     opaque = false} },

}
-- }}}

client.connect_signal("manage", function (c, startup)

    -- enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup and not c.size_hints.user_position
       and not c.size_hints.program_position then
        awful.placement.no_overlap(c)
        awful.placement.no_offscreen(c)
    end
end)

-- No border for maximized clients
client.connect_signal("focus",
    function(c)
        c.border_color = beautiful.border_focus
    end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
    end)
-- }}}
