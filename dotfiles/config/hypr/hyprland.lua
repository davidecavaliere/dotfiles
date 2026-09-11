-- =====================================================================
-- Hyprland Lua configuration
-- Migrated from the legacy hyprlang config (hyprland.conf + conf/*.conf).
-- hyprlang is deprecated since Hyprland 0.55; this is the endorsed format.
--
-- Fallback: if this file is absent, hyprland.conf loads instead. The
-- legacy-vs-Lua choice is made ONCE at startup, so switching requires a
-- full Hyprland restart (not `hyprctl reload`). Revert = remove/rename
-- this file and restart Hyprland.
--
-- NOTE: a handful of dispatchers have no example-confirmed native Lua
-- form, so they are called via `hyprctl dispatch <legacy>` for guaranteed
-- parity. These are marked `-- via hyprctl` and can be nativised later
-- once verified live: killactive, fullscreen, workspaceopt, layoutmsg,
-- resizeactive, togglegroup, changegroupactive, swapwindow, cyclenext,
-- bringactivetotop.
-- =====================================================================

------------------------------------------------------------------------
-- Colors (from colors.conf — Catppuccin Mocha)
------------------------------------------------------------------------
local mauve      = "rgb(cba6f7)"
local crust      = "rgb(11111b)"   -- $on_primary
local text       = "rgb(cdd6f4)"   -- $on_surface
local surface2   = "rgb(585b70)"

------------------------------------------------------------------------
-- Programs / path helpers (tilde is expanded by the shell in exec)
------------------------------------------------------------------------
local mainMod      = "SUPER"
local hyprscripts  = "~/.config/hypr/scripts"
local scripts      = "~/.config/ml4w/scripts"
local ml4wsettings = "~/.config/ml4w/settings"

------------------------------------------------------------------------
-- Monitors (monitors/highres.conf: monitor=,highres,auto,1)
------------------------------------------------------------------------
hl.monitor({ output = "", mode = "highres", position = "auto", scale = 1 })

------------------------------------------------------------------------
-- Environment variables (environments/default.conf + ml4w.conf)
------------------------------------------------------------------------
hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("GDK_SCALE", "1")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("SDL_VIDEODRIVER", "wayland")

------------------------------------------------------------------------
-- Core config blocks
------------------------------------------------------------------------
hl.config({
    -- keyboard.conf
    input = {
        kb_layout          = "us,it,gr",
        kb_variant         = "",
        kb_model           = "",
        kb_options         = "",
        kb_rules           = "",
        numlock_by_default = true,
        follow_mouse       = 1,
        mouse_refocus      = false,
        sensitivity        = 0,
        touchpad = {
            natural_scroll       = false,
            scroll_factor        = 1.0,
            disable_while_typing = false,
        },
    },

    -- windows/default.conf : general
    general = {
        gaps_in          = 10,
        gaps_out         = 9,
        border_size      = 4,
        resize_on_border = true,
        layout           = "dwindle",
        col = {
            active_border   = mauve,
            inactive_border = crust,
        },
    },

    -- windows/default.conf : group
    group = {
        col = {
            border_active         = mauve,
            border_inactive       = surface2,
            border_locked_active  = mauve,
            border_locked_inactive= surface2,
        },
        groupbar = {
            render_titles       = true,
            text_color          = mauve,
            text_color_inactive = surface2,
            indicator_gap       = 4,
            indicator_height    = 0,
            font_size           = 10,
            col = {
                active        = mauve,
                inactive      = surface2,
                locked_active = mauve,
                locked_inactive = surface2,
            },
        },
    },

    -- decorations/default.conf
    decoration = {
        rounding          = 10,
        active_opacity    = 1.0,
        inactive_opacity  = 0.9,
        fullscreen_opacity= 1.0,
        blur = {
            enabled          = true,
            size             = 4,
            passes           = 4,
            new_optimizations= true,
            ignore_opacity   = true,
            xray             = true,
        },
        shadow = {
            enabled      = true,
            range        = 32,
            render_power = 2,
            color        = "rgba(00000050)",
        },
    },

    -- layouts/default.conf
    layout = {
        single_window_aspect_ratio = "16 9",
    },
    dwindle = {
        preserve_split = true,
        smart_resizing = false,
    },
    binds = {
        workspace_back_and_forth = false,
        allow_workspace_cycles   = true,
        pass_mouse_when_bound    = false,
    },

    -- misc.conf
    misc = {
        disable_hyprland_logo     = true,
        disable_splash_rendering  = true,
        initial_workspace_tracking= 1,
        mouse_move_enables_dpms   = true,
        key_press_enables_dpms    = true,
    },

    -- hyprland.conf tail
    cursor = {
        inactive_timeout = 3,
    },

    -- ml4w.conf
    xwayland = {
        force_zero_scaling = true,
    },

    animations = {
        enabled = true,
    },
})

------------------------------------------------------------------------
-- Animation curves + animations (animations/default.conf)
------------------------------------------------------------------------
hl.curve("linear",        { type = "bezier", points = { {0, 0},    {1, 1}       } })
hl.curve("md3_standard",  { type = "bezier", points = { {0.2, 0},  {0, 1}       } })
hl.curve("md3_decel",     { type = "bezier", points = { {0.05,0.7},{0.1, 1}     } })
hl.curve("md3_accel",     { type = "bezier", points = { {0.3, 0},  {0.8, 0.15}  } })
hl.curve("overshot",      { type = "bezier", points = { {0.05,0.9},{0.1, 1.1}   } })
hl.curve("crazyshot",     { type = "bezier", points = { {0.1, 1.5},{0.76,0.92}  } })
hl.curve("hyprnostretch", { type = "bezier", points = { {0.05,0.9},{0.1, 1.0}   } })
hl.curve("menu_decel",    { type = "bezier", points = { {0.1, 1},  {0, 1}       } })
hl.curve("menu_accel",    { type = "bezier", points = { {0.38,0.04},{1, 0.07}   } })
hl.curve("easeInOutCirc", { type = "bezier", points = { {0.85,0},  {0.15,1}     } })
hl.curve("easeOutCirc",   { type = "bezier", points = { {0, 0.55} ,{0.45,1}     } })
hl.curve("easeOutExpo",   { type = "bezier", points = { {0.16,1},  {0.3, 1}     } })
hl.curve("softAcDecel",   { type = "bezier", points = { {0.26,0.26},{0.15,1}    } })
hl.curve("md2",           { type = "bezier", points = { {0.4, 0},  {0.2, 1}     } })

hl.animation({ leaf = "windows",        enabled = true, speed = 3,   bezier = "md3_decel",  style = "popin 60%" })
hl.animation({ leaf = "windowsIn",      enabled = true, speed = 3,   bezier = "md3_decel",  style = "popin 60%" })
hl.animation({ leaf = "windowsOut",     enabled = true, speed = 3,   bezier = "md3_accel",  style = "popin 60%" })
hl.animation({ leaf = "border",         enabled = true, speed = 10,  bezier = "default" })
hl.animation({ leaf = "fade",           enabled = true, speed = 3,   bezier = "md3_decel" })
hl.animation({ leaf = "layersIn",       enabled = true, speed = 3,   bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "layersOut",      enabled = true, speed = 1.6, bezier = "menu_accel" })
hl.animation({ leaf = "fadeLayersIn",   enabled = true, speed = 2,   bezier = "menu_decel" })
hl.animation({ leaf = "fadeLayersOut",  enabled = true, speed = 4.5, bezier = "menu_accel" })
hl.animation({ leaf = "workspaces",     enabled = true, speed = 7,   bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "specialWorkspace",enabled = true,speed = 3,   bezier = "md3_decel",  style = "slidevert" })

------------------------------------------------------------------------
-- Autostart (autostart.conf + cursor.conf + hyprland.conf)
------------------------------------------------------------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("~/.config/ml4w/listeners.sh --startall")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("~/.config/hypr/scripts/gtk.sh")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("fcitx5 -d")
    hl.exec_cmd("wayle shell")
    hl.exec_cmd("hyprlauncher -d")
    hl.exec_cmd("~/.config/hypr/scripts/cleanup.sh")
    hl.exec_cmd("hyprctl setcursor ArcStarry-cursors 24")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)

------------------------------------------------------------------------
-- Keybindings (keybindings/default.conf)
------------------------------------------------------------------------
-- Applications
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(ml4wsettings .. "/terminal.sh"))
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd('google-chrome-stable --profile-directory="Profile 2"'))
hl.bind(mainMod .. " + C",      hl.dsp.exec_cmd("google-chrome-stable --profile-directory=Default"))
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(ml4wsettings .. "/filemanager.sh"))

-- Display zoom
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.exec_cmd([[hyprctl keyword cursor:zoom_factor $(awk "BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') + 0.5}")]]))
hl.bind(mainMod .. " + SHIFT + mouse_up",   hl.dsp.exec_cmd([[hyprctl keyword cursor:zoom_factor $(awk "BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') - 0.5}")]]))
hl.bind(mainMod .. " + SHIFT + Z",          hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor 0"))

-- Windows
hl.bind(mainMod .. " + Q",         hl.dsp.window.close())                                        -- via hyprctl
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"))
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ mode = "fullscreen" }))                                      -- via hyprctl
hl.bind(mainMod .. " + M",         hl.dsp.window.fullscreen({ mode = "maximized" }))                                      -- via hyprctl
hl.bind(mainMod .. " + T",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + H",         hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J",         hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K",         hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L",         hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + down",      hl.dsp.layout("togglesplit"))                            -- via hyprctl
hl.bind(mainMod .. " + up",        hl.dsp.layout("swapsplit"))                              -- via hyprctl
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))                          -- via hyprctl
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -100, y = 0, relative = true }))                         -- via hyprctl
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0, y = 100, relative = true }))                          -- via hyprctl
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0, y = -100, relative = true }))                         -- via hyprctl
hl.bind(mainMod .. " + G",         hl.dsp.group.toggle())                                      -- via hyprctl
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.swap({ direction = "left" }))                                  -- via hyprctl
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "right" }))                                  -- via hyprctl
hl.bind(mainMod .. " + ALT + up",    hl.dsp.window.swap({ direction = "up" }))                                  -- via hyprctl
hl.bind(mainMod .. " + ALT + down",  hl.dsp.window.swap({ direction = "down" }))                                  -- via hyprctl
hl.bind("ALT + Tab", function() hl.dispatch(hl.dsp.window.cycle_next()); hl.dispatch(hl.dsp.window.bring_to_top()) end, { repeating = true }) -- via hyprctl

-- Actions
hl.bind(mainMod .. " + CTRL + R",  hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(hyprscripts .. "/toggle-animations.sh"))
hl.bind(mainMod .. " + PRINT",     hl.dsp.exec_cmd("hyprshot-gui"))
hl.bind(mainMod .. " + ALT + S",   hl.dsp.exec_cmd("hyprshot -m window -m active --clipboard-only"))
hl.bind(mainMod .. " + S",         hl.dsp.group.next())                                -- via hyprctl
hl.bind(mainMod .. " + CTRL + PRINT", hl.dsp.exec_cmd("hyprshot -m active -m output --clipboard-only"))
hl.bind(mainMod .. " + ALT + F",   hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("waypaper --random"))
hl.bind(mainMod .. " + CTRL + W",  hl.dsp.exec_cmd("waypaper"))
hl.bind(mainMod .. " + ALT + W",   hl.dsp.exec_cmd(hyprscripts .. "/wallpaper-automation.sh"))
hl.bind(mainMod .. " + SPACE",     hl.dsp.exec_cmd("hyprlauncher"))
hl.bind(mainMod .. " + ALT + SPACE", hl.dsp.exec_cmd("hyprctl switchxkblayout all next"))
hl.bind(mainMod .. " + P",         hl.dsp.exec_cmd(hyprscripts .. "/keybindings.sh"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("wayle panel restart"))
hl.bind(mainMod .. " + CTRL + B",  hl.dsp.exec_cmd("wayle panel toggle"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(hyprscripts .. "/loadconfig.sh"))
hl.bind(mainMod .. " + V",         hl.dsp.exec_cmd(scripts .. "/cliphist.sh"))
hl.bind(mainMod .. " + ALT + G",   hl.dsp.exec_cmd(hyprscripts .. "/gamemode.sh"))
hl.bind(mainMod .. " + CTRL + L",  hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.dpms({ action = "off" }))

-- Workspaces: focus (mainMod + N) and move (mainMod + SHIFT + N)
for i = 1, 10 do
    local key = i % 10 -- 10 -> key 0
    hl.bind(mainMod .. " + " .. key,           hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,   hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + Tab",         hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + mouse_down",  hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",    hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.focus({ workspace = "empty" }))

-- Fn / multimedia keys
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -q s +10%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -q s 10%-"))
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause",        hl.dsp.exec_cmd("playerctl pause"))
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))
hl.bind("XF86Calculator",        hl.dsp.exec_cmd(ml4wsettings .. "/calculator.sh"))
-- XF86Lock dropped: not a valid keysym on this system (redundant with SUPER+CTRL+L)
hl.bind(mainMod .. " + SHIFT + escape", hl.dsp.exec_cmd("systemctl suspend"))

hl.bind("code:238", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s +10"))
hl.bind("code:237", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s 10-"))

-- Set the active window's width to a fraction of the focused monitor.
-- Native replacement for set-window-width.sh (which broke: it used
-- `hyprctl dispatch resizeactive exact`, now evaluated as Lua).
local function set_window_width(ratio)
    local win = hl.get_active_window()
    local mon = hl.get_active_monitor()
    if not win or not mon then return end
    local cur = win.size[1] or win.size.w or win.size.x   -- tolerate array/{w,h}/{x,y}
    if not cur then return end
    local target = math.floor(mon.width / ratio)
    hl.dispatch(hl.dsp.window.resize({ x = target - cur, y = 0, relative = true }))
end

hl.bind(mainMod .. " + Y", function() set_window_width(2) end) -- 1/2 monitor width
hl.bind(mainMod .. " + U", function() set_window_width(3) end) -- 1/3
hl.bind(mainMod .. " + I", function() set_window_width(4) end) -- 1/4

------------------------------------------------------------------------
-- Window rules (windowrules/default.conf + ml4w.conf)
------------------------------------------------------------------------
hl.window_rule({ name = "Centered_Windows", match = { class = "Vncviewer" }, float = true, center = true })
hl.window_rule({ name = "updates", match = { class = "updates" }, size = "monitor_w*0.3 monitor_h*0.8", float = true, center = true })

hl.window_rule({ name = "pavucontrol",   match = { class = "(.*org.pulseaudio.pavucontrol.*)" }, float = true, center = true, pin = true, size = "700 600" })
hl.window_rule({ name = "waypaper",      match = { class = "(.*waypaper.*)" },                    float = true, center = true, pin = true, size = "900 700" })
hl.window_rule({ name = "newelle",       match = { class = "(io.github.qwersyk.Newelle)" },       float = true, center = true, pin = true, size = "1000 700" })
hl.window_rule({ name = "blueman-manager", match = { class = "(blueman-manager)" },               float = true, center = true, size = "800 600" })
hl.window_rule({ name = "nwg-look",      match = { class = "(nwg-look)" },                         float = true, center = true, size = "700 600" })
hl.window_rule({ name = "nwg-displays",  match = { class = "(nwg-displays)" },                     float = true, center = true, size = "900 600" })
hl.window_rule({ name = "missioncenter", match = { class = "(io.missioncenter.MissionCenter)" },   float = true, center = true, pin = true, size = "900 600" })
hl.window_rule({ name = "gnome-calculator", match = { class = "(org.gnome.Calculator)" },          float = true, center = true, size = "700 600" })
hl.window_rule({ name = "hyprland-share-picker", match = { class = "(hyprland-share-picker)" },     float = true, center = true, pin = true, size = "600 400" })
hl.window_rule({ name = "nm-connection-editor", match = { class = "(nm-connection-editor)" },       float = true, center = true, size = "800 700" })
hl.window_rule({ name = "Picture-in-Picture", match = { class = "(Picture-in-Picture)" },           float = true, center = true, pin = true })
hl.window_rule({ name = "dotfiles-floating", match = { class = "(dotfiles-floating)" },             float = true, center = true, size = "1000 700" })
hl.window_rule({ name = "dotfiles-sidepad",  match = { class = "(dotfiles-sidepad)" },              float = true, center = true, pin = true, size = "1000 700" })

-- (swaync removed — wayle owns notifications now; its blur/styling is handled
--  by wayle itself. Add wayle layer rules here later if you want extra blur.)
