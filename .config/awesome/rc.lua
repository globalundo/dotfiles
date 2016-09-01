
--[[

     Multicolor Awesome WM config 2.0
     github.com/copycat-killer

--]]

-- {{{ Required libraries
local gears     = require("gears")
local awful     = require("awful")
awful.rules     = require("awful.rules")
require("awful.autofocus")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local lain      = require("lain")
-- }}}

-- beautiful.border_width = 6

naughty.config.presets.normal.opacity = 0.9
naughty.config.presets.low.opacity = 0.9
naughty.config.presets.critical.opacity = 0.9

naughty.config.defaults.timeout = 20
--naughty.config.presets = {
--    normal = {
--	        timeout = 0,
--             bg = "#0000ff",
--
--	},
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

--{{{ Autostart applications
-- function run_once(cmd)
--  findme = cmd
--  firstspace = cmd:find(" ")
--  if firstspace then
--     findme = cmd:sub(0, firstspace-1)
--  end
--  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
--end
awful.util.spawn_with_shell("urxvt")
-- run_once("xflux -l 58 -g 37")
-- run_once("feh --bg-scale /usr/share/backgrounds/warty-final-ubuntu.png")
-- run_once("setxkbmap -layout 'us,ru' -option 'grp:caps_toggle, grp:alt_space_toggle ,grp_led:caps, compose:ralt'")
--run_once("compton")
--run_once("sudo turbo_mode allowusers && sudo turbo_mode off")
--run_once("light-locker")
-- run_once("awesome_kbd_fix")
-- run_once("unclutter")
-- run_once("kbdd")
-- run_once("xbindkeys")
-- run_once("nm-applet")
-- run_once("bluetooth-applet")
-- run_once("easystroke")
-- run_once("dropboxd")
-- run_once("pulseaudio -D") -- I prefer to be able to change the volume BEFORE it hits the fan
-- run_once("parcellite")
-- run_once("pcmanfm -d")
-- run_once("nagstamon ~/bin/nagstamon/")
-- }}}

-- {{{ Variable definitions
-- localization
os.setlocale(os.getenv("LANG"))

-- beautiful init
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/multicolor/theme.lua")

-- common
modkey     = "Mod4"
altkey     = "Mod1"
-- terminal   = "urxvt'" or "xterm"
-- editor     = os.getenv("EDITOR") or "vim" or "nano" or "vi"
-- editor_cmd = terminal .. " -e " .. editor

-- user defined
-- browser  = "chromium"
-- browser2 = "firefox"
-- browser    = "dwb"
-- browser2   = "iron"
-- gui_editor = "gvim"
-- graphics   = "gimp"
-- mail       = terminal/ .. " -e mutt "
-- screenshots = "~/Dropbox/Screenshots/"

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
  tags = {
     -- names = { "web", "term", "more terms", "messaging", "X", "X", "X", "X", "X", "X", "X", "X" },
    names = { "🌎", "", "", "", "⌨", "🎬", "", "" },
     -- layout = { layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1] }
  }


  for s = 1, screen.count() do
  -- Each screen has its own tag table.
     -- if s > 1 then
       -- tags[s] = awful.tag({"term",}, s, {layouts[3],})
     -- else
    tags[s] = awful.tag(tags.names, s, layouts[1])
     -- end
  end
-- end
--persistence.store(storage_tags, tags)

-- }}}

-- Opacity
-- awesome.register_xproperty("AWESOME_IGNORE_OPACITY", "boolean")
-- client.connect_signal("focus",
--     function(c)
-- 	c.opacity = 1

--     end)
-- client.connect_signal("unfocus",
-- 	function(c)
--                 --if not c.name:find("% %[OPAQUE%]") then
--                 if not client.opaque then
-- 		    --c.opacity = 0.85
-- 		    c.opacity = 1
-- 		end
-- 	end)
-- }}}


-- {{{ Wallpaper
--if beautiful.wallpaper then
--    for s = 1, screen.count() do
--        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
--    end
--end
-- }}}

-- {{{ Freedesktop Menu
--require("freedesktop/freedesktop")
-- }}}

-- {{{ Wibox
markup      = lain.util.markup

-- Textclock
clockicon = wibox.widget.imagebox(beautiful.widget_clock)
mytextclock = awful.widget.textclock(markup("#7788af", "%A %d %B ") .. markup("#343639", ">") .. markup("#de5e1e", " %H:%M "))

-- Calendar
lain.widgets.calendar:attach(mytextclock, { font_size = 11 })

-- Weather
-- weathericon = wibox.widget.imagebox(beautiful.widget_weather)
-- yawn = lain.widgets.yawn(2122265, {
--     settings = function()
--         widget:set_markup(markup("#eca4c4", forecast:lower() .. " @ " .. units .. "°C "))
--     end
-- })

-- / fs
-- fsicon = wibox.widget.imagebox(beautiful.widget_fs)
-- fswidget = lain.widgets.fs({
--     settings  = function()
--         widget:set_markup(markup("#80d9d8", fs_now.used .. "% "))
--     end
-- })

--[[ Mail IMAP check
-- commented because it needs to be set before use
mailicon = wibox.widget.imagebox()
mailicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(mail) end)))
mailwidget = lain.widgets.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            mailicon:set_image(beautiful.widget_mail)
            widget:set_markup(markup("#cccccc", mailcount .. " "))
        else
            widget:set_text("")
            mailicon:set_image(nil)
        end
    end
})
]]
-- lain.util.useless_gaps_resize(20);

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
-- 	widget:set_text(brightness_now .. "% ")
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

-- Net
-- netdownicon = wibox.widget.imagebox(beautiful.widget_netdown)
--netdownicon.align = "middle"
-- netdowninfo = wibox.widget.textbox()
-- netupicon = wibox.widget.imagebox(beautiful.widget_netup)
--netupicon.align = "middle"
-- netupinfo = lain.widgets.net({
--     settings = function()
--         widget:set_markup(markup("#e54c62", net_now.sent .. " "))
--         netdowninfo:set_markup(markup("#87af5f", net_now.received .. " "))
--     end
-- })

-- MEM
-- memicon = wibox.widget.imagebox(beautiful.widget_mem)
-- memwidget = lain.widgets.mem({
--     settings = function()
--         widget:set_markup(markup("#e0da37", mem_now.used .. "M "))
--     end
-- })

-- MPD
-- mpdicon = wibox.widget.imagebox()
-- mpdwidget = lain.widgets.mpd({
--     settings = function()
--         mpd_notification_preset = {
--             text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
--                    mpd_now.album, mpd_now.date, mpd_now.title)
--         }

--         if mpd_now.state == "play" then
--             artist = mpd_now.artist .. " > "
--             title  = mpd_now.title .. " "
--             mpdicon:set_image(beautiful.widget_note_on)
--         elseif mpd_now.state == "pause" then
--             artist = "mpd "
--             title  = "paused "
--         else
--             artist = ""
--             title  = ""
--             mpdicon:set_image(nil)
--         end
--         widget:set_markup(markup("#e54c62", artist) .. markup("#b2b2b2", title))
--     end
-- })

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
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
-- mytasklist = {}
-- mytasklist.buttons = awful.util.table.join(
--                      awful.button({ }, 1, function (c)
--                                               if c == client.focus then
--                                                   c.minimized = true
--                                               else
--                                                   -- Without this, the following
--                                                   -- :isvisible() makes no sense
--                                                   c.minimized = false
--                                                   if not c:isvisible() then
--                                                       awful.tag.viewonly(c:tags()[1])
--                                                   end
--                                                   -- This will also un-minimize
--                                                   -- the client, if needed
--                                                   client.focus = c
--                                                   c:raise()
--                                               end
--                                           end),
--                      awful.button({ }, 3, function ()
--                                               if instance then
--                                                   instance:hide()
--                                                   instance = nil
--                                               else
--                                                   instance = awful.menu.clients({ width=250 })
--                                               end
--                                           end),
--                      awful.button({ }, 4, function ()
--                                               awful.client.focus.byidx(1)
--                                               if client.focus then client.focus:raise() end
--                                           end),
--                      awful.button({ }, 5, function ()
--                                               awful.client.focus.byidx(-1)
--                                               if client.focus then client.focus:raise() end
--                                           end))

for s = 1, screen.count() do

    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()


    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                            awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                            awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                            awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                            awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    -- mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the upper wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 20 })
    --border_width = 0, height =  20 })

    -- Widgets that are aligned to the upper left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])
    -- left_layout:add(mpdicon)
    -- left_layout:add(mpdwidget)
    --left_layout:add(mylayoutbox[s])

    -- Widgets that are aligned to the upper right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    --right_layout:add(mailicon)
    --right_layout:add(mailwidget)
    -- right_layout:add(netdownicon)
    -- right_layout:add(netdowninfo)
    -- right_layout:add(netupicon)
    -- right_layout:add(netupinfo)
    right_layout:add(kbdwidget)
    right_layout:add(volicon)
    right_layout:add(volumewidget)
    -- right_layout:add(brightness_icon)
    -- right_layout:add(brightness_widget)
    -- right_layout:add(memicon)
    -- right_layout:add(memwidget)
    right_layout:add(cpuicon)
    right_layout:add(cpuwidget)
    --right_layout:add(fsicon)
    --right_layout:add(fswidget)
    --right_layout:add(weathericon)
    --right_layout:add(yawn.widget)
    --right_layout:add(tempicon)
    --right_layout:add(tempwidget)
    right_layout:add(turboicon)
    right_layout:add(baticon)
    right_layout:add(batwidget)
    right_layout:add(powersaveicon)
    right_layout:add(clockicon)
    right_layout:add(mytextclock)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    -- layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)

    -- Create the bottom wibox
    -- mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s, border_width = 0, height = 20 })
    -- mybottomwibox[s].visible = false

    -- -- Widgets that are aligned to the bottom left
    -- bottom_left_layout = wibox.layout.fixed.horizontal()

    -- -- Widgets that are aligned to the bottom right
    -- bottom_right_layout = wibox.layout.fixed.horizontal()
    -- --bottom_right_layout:add(mylayoutbox[s])
    -- bottom_right_layout:add(mylayoutbox[s])

    -- -- Now bring it all together (with the tasklist in the middle)
    -- bottom_layout = wibox.layout.align.horizontal()
    -- bottom_layout:set_left(bottom_left_layout)
    -- bottom_layout:set_middle(mytasklist[s])
    -- bottom_layout:set_right(bottom_right_layout)
    -- mybottomwibox[s]:set_widget(bottom_layout)
end
-- }}}

-- {{{ Mouse Bindings
root.buttons(awful.util.table.join(
    --awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- Take a screenshot
    -- https://github.com/copycat-killer/dots/blob/master/bin/screenshot
    -- awful.key({ altkey }, "p", function() os.execute("screenshot") end),

    -- Tag browsing
    awful.key({ modkey }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey }, "Escape", awful.tag.history.restore),

    -- Non-empty tag browsing
    awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end),
    awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end),

    --  dynamic tagging
    --awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag(layouts[3]) end),
    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag(mypromptbox,layouts[1]) end),
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end),  -- move to next tag
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end), -- move to previous tag
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

--    -- Show Menu
--    awful.key({ modkey }, "w",
--        function ()
--            mymainmenu:show({ keygrabber = true })
--        end),

    -- Show/Hide Wibox
    --awful.key({ modkey }, "b", function ()
        -- mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
    --    mybottomwibox[mouse.screen].visible = not mybottomwibox[mouse.screen].visible
    --end),

    -- Switch tag between screens
    awful.key({ modkey, "Shift"   }, "Down", function ()
            local screen = mouse.screen
            local tag = awful.tag.selected(screen)
            awful.tag.setscreen(tag, awful.screen.focus_relative( 1))
            awful.tag.viewonly(tag)
    end),

    awful.key({ modkey, "Shift"   }, "Up", function ()
            local screen = mouse.screen
            local tag = awful.tag.selected(screen)
            awful.tag.setscreen(tag, awful.screen.focus_relative( 1))
            awful.tag.viewonly(tag)
    end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    --awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    --awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey, }, "Up", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, }, "Down", function () awful.screen.focus_relative(-1) end),

    -- awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
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
    awful.key({ modkey, "Shift"   }, "space",  function () awful.layout.inc(layouts, -1)  end),
    -- awful.key({ modkey, "Control" }, "n",      awful.client.restore),

    -- Standard program
    -- awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    -- awful.key({ modkey, "Shift"   }, "Return", function () awful.util.spawn("/usr/local/bin/dmenu_raise.sh") end),
    -- awful.key({ modkey,           }, "Return", function () awful.util.spawn("dm-tool switch-to-greeter") end),
    --awful.key({ modkey, "Control" }, "r",      awesome.restart),
    awful.key({ modkey, "Control" }, "r",      awful.util.restart)
    -- ,
    --awful.key({ modkey, "Shift"   }, "q",      awesome.quit),

    -- Dropdown terminal
    --awful.key({ modkey,	          }, "z",      function () drop(terminal) end),

    -- Widgets popups
    --awful.key({ altkey,           }, "c",      function () lain.widgets.calendar:show(7) end),
    --awful.key({ altkey,           }, "h",      function () fswidget.show(7) end),
    -- awful.key({ altkey,           }, "w",      function () yawn.show(7) end),
    -- Lock the desktop
    -- awful.key({ modkey, "Shift"}, "l",	function () awful.util.spawn("dm-tool switch-to-greeter") end),
    -- als
    -- awful.key({ }, "#248",	function () awful.util.spawn("sudo als enable") end)
    -- ,
    --awful.key({ }, "XF86Launch1",	function () awful.util.spawn("dm-tool switch-to-greeter") end),


-- Escape from keyboard focus trap (eg Flash plugin in Firefox)
  -- awful.key({ modkey, "Control" }, "Escape", function ()
  -- awful.util.spawn("xdotool getactivewindow mousemove --window %1 0 0 click --clearmodifiers 2")
  --                end),


    -- ALSA volume control
    -- awful.key({ }, "XF86AudioRaiseVolume",
    --     function ()
    --         awful.util.spawn("amixer -q set Master 1%+")
    --         volumewidget.update()
    --     end),
    -- awful.key({ }, "XF86AudioLowerVolume",
    --     function ()
    --         awful.util.spawn("amixer -q set Master 1%-")
    --         volumewidget.update()
    --     end),
    -- awful.key({ }, "XF86AudioMute",
    --     function ()
    --         awful.util.spawn("amixer -q set Master playback toggle")
    --         volumewidget.update()
    --     end),

    -- -- Touchpad toggle
    -- awful.key({ }, "XF86TouchpadToggle",
    --     function ()
    --         awful.util.spawn("/usr/local/bin/touchpad_toggle")
    --     end),

    -- -- Turbo mode toggle
    -- awful.key({ }, "XF86Launch1",
    --     function ()
    --         awful.util.spawn("/usr/local/bin/turbo_mode toggle")
	   --  turbo_toggle()
	   --  --tempwidget.update()
    --     end),

    -- Brightness control
    -- awful.key({ }, "XF86KbdBrightnessUp",
    --     function ()
    --         awful.util.spawn("/usr/bin/asus-kbd-backlight up")
    --     end),
    -- awful.key({ }, "XF86KbdBrightnessDown",
    --     function ()
    --         awful.util.spawn("/usr/bin/asus-kbd-backlight down")
    --     end),

    -- Power control
    -- awful.key({ }, "XF86Launch6",
    --     function ()
    --         awful.util.spawn("sudo /usr/local/bin/powersave toggle")
	   --  powersave_toggle()
    --     end),

    -- Copy to clipboard
    -- awful.key({ modkey }, "c", function () os.execute("xsel -p -o | xsel -i -b") end),
    -- awful.key({ modkey }, "p", function () os.execute("xsel -o") end),
    --awful.key({ modkey }, "p", function () awful.util.spawn("pavucontrol") end),

    -- User programs
    -- awful.key({ modkey }, "q", function () awful.util.spawn(browser) end),
    -- awful.key({ modkey }, "i", function () awful.util.spawn(browser2) end),
    -- awful.key({ modkey }, "s", function () awful.util.spawn(gui_editor) end),
    -- awful.key({ modkey }, "g", function () awful.util.spawn(graphics) end),

    -- Prompt
    -- awful.key({ modkey }, "r", function () mypromptbox[mouse.screen]:run() end),
--    awful.key({ modkey }, "r", function () awful.util.spawn("dmenu_run -i -p 'Run: ' -fn 'xft:Dejavu Sans Mono:pixelsize=14'") end),
    --awful.key({ modkey }, "r", function () awful.util.spawn("dmenu_run -name 'dmenu' -class 'dmenu' -l 20 -dim 0.30 -i -p 'Run: ' -fn 'xft:Sans Serif:size=12' -nb '" ..
 --		beautiful.bg_normal .. "' -nf '" .. beautiful.fg_normal ..
--		"' -sb '" .. beautiful.bg_focus ..
--		"' -sf '" .. beautiful.fg_focus .. "'")
--	end),
    -- awful.key({ modkey,   }, "r", function () awful.util.spawn("/usr/local/bin/dmenu_run.sh") end),
    -- awful.key({ modkey }, "x",
    --           function ()
    --               awful.prompt.run({ prompt = "Run Lua code: " },
    --               mypromptbox[mouse.screen].widget,
    --               awful.util.eval, nil,
    --               awful.util.getdir("cache") .. "/history_eval")
    --           end)
)

-- clientkeys = awful.util.table.join(
    -- awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    -- awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    -- awful.key({ modkey, "Control" }, "f",  awful.client.floating.toggle                     ),
    -- awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    --awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    -- awful.key({ modkey, "Control" }, "t",      function (c) c.ontop = not c.ontop            end),
    -- awful.key({ modkey, "Control" }, "s",      function (c) c.sticky = not c.sticky            end),
--     awful.key({ modkey, "Control" }, "o",      function (c)
-- 	    				         --if c.name:find("% %[OPAQUE%]") then
-- 				  		    --c.name = c.name:gsub("% %[OPAQUE%]",'')
-- 				  		    --c.name = c.name:gsub("% %[OPAQUE%]",'')
-- 						c.opaque = not c.opaque
-- 						c.opaque = true
-- naughty.notify({ preset = naughty.config.presets.critical,
--                       title = "Debug",
--                       text = c.opaque })
-- 						-- end
-- 					        end)
    -- ,
    -- awful.key({ modkey,           }, "n",
    --     function (c)
    --         -- The client currently has the input focus, so it cannot be
    --         -- minimized, since minimized clients can't have the focus.
    --         c.minimized = true
    --     end)--,
--    awful.key({ modkey,           }, "m",
--        function (c)
--	    --c.maximized_horizontal = not c.maximized_horizontal
--            --c.maximized_vertical   = not c.maximized_vertical
--	    c.maximized = not c.maximized
--            c.ontop = not c.ontop
--        end)
-- )

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
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons,
	                 size_hints_honor = false,
	     	     -- opacity = 0.85,
	   	             opaque = false} },

--    { rule = { class = "URxvt" },
--          properties = { opacity = 0.80,
--			 tag = tags[1][2] } },

--     { rule = { class = "Pcmanfm" },
--           properties = {
--			 tag = tags[1][6] } },

--    { rule = { class = "MPlayer" },
--          properties = { floating = true } },

--    { rule_any = { class = { "Firefox", "Chromium" } },
--          properties = { tag = tags[1][1]} },

    -- { rule_any = { class = { "Skype", "DummyJabber" } },
    --       properties = { tag = tags[1][4]} },

    -- { rule_any = { class = { "deadbeef", "cmplayer", "qbittorrent" } },
          -- properties = { tag = tags[1][5]} },

  -- { rule = { class = "pidgin" },
  --         properties = { floating = false } },

    -- { rule = { class = "Iron" },
    --       properties = { tag = tags[1][1] } },

    { rule = { class = "jetbrains-pycharm" },
          properties = { floating = true,}
--			 fullscreen = true,}
--			 tag = tags[1][1] }
},

    { rule = { class = "plugin-container" },
          properties = { floating = true,
			 fullscreen = true}
--			 tag = tags[1][1] }
},
    { rule = { class = "rofi" },
          properties = { floating = false
			 }
--			 tag = tags[1][1] }
},

--     { rule = { instance = "feh" },
--           properties = { floating = true,
-- 			 fullscreen = true,}
-- },

    { rule = { instance = "pavucontrol" },
          properties = { floating = true},
          callback = function (c)
            awful.placement.centered(c, nil)
          end
},

{ rule = { name = "bar" },
  properties = {
      floating = true,
      sticky = true,
      ontop = false,
      focusable = false
  } },

--    { rule = { role = "conversation" },
--        properties = { floating = true},
--          callback = function (c)
--            awful.placement.centered(c, nil)
--          end
-- },


--    { rule = { class = "keepass2" },
--          properties = { floating = true,
--                         fullscreen = false},
--          callback = function (c)
--            awful.placement.centered(c, nil)
--          end
--},

--     { rule = { class = "Plugin-container" },
--           properties = { floation = true,
-- 			  fullscreen = true,
-- 			  tag = tags[1][1] } },

--	  { rule = { class = "Gimp" },
--     	    properties = { tag = tags[1][4] } },

--    { rule = { class = "Gimp", role = "gimp-image-window" },
--        properties = { maximized_horizontal = true,
--                       maximized_vertical = true } },
}
-- }}}

-- {{{ Signals
-- signal function to execute when a new client appears.
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

    -- local titlebars_enabled = false
    -- if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
    --     -- buttons for the titlebar
    --     local buttons = awful.util.table.join(
    --             awful.button({ }, 1, function()
    --                 client.focus = c
    --                 c:raise()
    --                 awful.mouse.client.move(c)
    --             end),
    --             awful.button({ }, 3, function()
    --                 client.focus = c
    --                 c:raise()
    --                 awful.mouse.client.resize(c)
    --             end)
    --             )

    --     -- widgets that are aligned to the right
    --     local right_layout = wibox.layout.fixed.horizontal()
    --     right_layout:add(awful.titlebar.widget.floatingbutton(c))
    --     right_layout:add(awful.titlebar.widget.maximizedbutton(c))
    --     right_layout:add(awful.titlebar.widget.stickybutton(c))
    --     right_layout:add(awful.titlebar.widget.ontopbutton(c))
    --     right_layout:add(awful.titlebar.widget.closebutton(c))

    --     -- the title goes in the middle
    --     local middle_layout = wibox.layout.flex.horizontal()
    --     local title = awful.titlebar.widget.titlewidget(c)
    --     title:set_align("center")
    --     middle_layout:add(title)
    --     middle_layout:buttons(buttons)

    --     -- now bring it all together
    --     local layout = wibox.layout.align.horizontal()
    --     layout:set_right(right_layout)
    --     layout:set_middle(middle_layout)

    --     awful.titlebar(c,{size=16}):set_widget(layout)
    -- end
end)

-- No border for maximized clients
client.connect_signal("focus",
    function(c)
        -- if c.maximized_horizontal == true and c.maximized_vertical == true then
            -- c.border_color = beautiful.border_normal
        -- else
        c.border_color = beautiful.border_focus
        -- c.border_width = "0"
        -- end
    end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
        -- c.border_width = "10"

    end)
-- }}}

-- {{{ Arrange signal handler
for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
        local clients = awful.client.visible(s)
        local layout  = awful.layout.getname(awful.layout.get(s))

        if #clients > 0 then -- Fine grained borders and floaters control
            for _, c in pairs(clients) do -- Floaters always have borders
                -- No borders with only one humanly visible client
                -- if layout == "max" or c.maximized then
                --     c.border_width = 0
                if awful.client.floating.get(c) or layout == "floating" then
                    c.border_width = beautiful.border_width
                elseif #clients == 1 then
                    -- clients[1].border_width = 0
                    if layout ~= "max" then
                        awful.client.moveresize(0, 0, 2, 0, clients[1])
                    end
                else
                    c.border_width = beautiful.border_width
                end
            end
        end
      end)
end
-- }}}
