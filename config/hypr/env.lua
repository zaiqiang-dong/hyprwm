-- 环境变量
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("XMODIFIERS", "@im=fcitx")
hl.env("QT_IM_MODULE", "fcitx")

hl.env("XCURSOR_THEME", "Adwaita")
hl.env("XCURSOR_SIZE", "24")

hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_FONT_DPI", "144")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

hl.env("GDK_SCALE", "2")

-- exec-once
hl.on("hyprland.start", function()
  hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_FONT_DPI GDK_SCALE QT_QPA_PLATFORM QT_AUTO_SCREEN_SCALE_FACTOR")
  hl.exec_cmd("systemctl --user import-environment QT_IM_MODULE XMODIFIERS")
  hl.exec_cmd("dbus-update-activation-environment --systemd --all")
end)
