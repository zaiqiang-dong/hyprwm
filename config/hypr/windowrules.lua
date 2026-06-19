-- 窗口规则

-- clash-verge → workspace 11
hl.window_rule({
    name = "windowrule-1",
    match = { class = "^(clash-verge)$" },
    workspace = "11 silent",
})

-- Google Chrome → workspace 10
hl.window_rule({
    name = "windowrule-2",
    match = { class = "^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$" },
    workspace = "10 silent",
})

-- 飞书 → workspace 9
hl.window_rule({
    name = "windowrule-3",
    match = { class = "^(Bytedance-feishu)$" },
    workspace = "9 silent",
})

-- xdg-desktop-portal-gtk → float
hl.window_rule({
    name = "windowrule-4",
    match = { class = "^([x|X]dg-desktop-portal-gtk)$" },
    float = true,
    size = "1000 600",
    center = true,
})

-- xdg-desktop-portal-phosh → float
hl.window_rule({
    name = "windowrule-5",
    match = { class = "^(xdg-desktop-portal-phosh)$" },
    float = true,
    size = "800 600",
    center = true,
})

-- neovide → maximize
hl.window_rule({
    name = "windowrule-6",
    match = { class = "^(neovide)$" },
    maximize = true,
})

-- WPS Office → float
hl.window_rule({
    name = "windowrule-7",
    match = { title = "^(wpsoffice)$" },
    float = true,
    center = false,
})
hl.window_rule({
    name = "windowrule-7-wpp",
    match = { title = "^(wpp)$" },
    float = true,
    center = false,
})

-- 飞书会议 → float, workspace 12
hl.window_rule({
    name = "windowrule-8-0",
    match = { class = "^(飞书会议)$" },
    float = true,
    center = true,
    workspace = "12",
    no_initial_focus = true,
})

-- Meeting → float, workspace 12
hl.window_rule({
    name = "windowrule-8-1",
    match = { class = "^(Meeting)$" },
    float = true,
    center = true,
    workspace = "12",
    no_initial_focus = true,
})

-- KDE portal → float
hl.window_rule({
    name = "windowrule-9",
    match = { class = "^(org.freedesktop.impl.portal.desktop.kde)$" },
    float = true,
})

-- scrcpy → float + maximize
hl.window_rule({
    name = "windowrule-10",
    match = { class = "^(scrcpy)$" },
    float = true,
    maximize = true,
    center = true,
})

-- QualcommPackageManager3 → maximize
hl.window_rule({
    name = "windowrule-11",
    match = { class = "^(QualcommPackageManager3)$" },
    maximize = true,
})

-- PCATApp → maximize
hl.window_rule({
    name = "windowrule-12",
    match = { class = "^(PCATApp)$" },
    maximize = true,
})

-- Video Player → float
hl.window_rule({
    name = "windowrule-13",
    match = { title = "^(Video Player)$" },
    float = true,
    center = true,
    size = "(monitor_w*0.8) (monitor_h*0.8)",
})

-- 图片 → float
hl.window_rule({
    name = "windowrule-14",
    match = { title = "^(图片)$", initial_title = "^(图片)$" },
    float = true,
    center = true,
})

-- satty → float
hl.window_rule({
    name = "windowrule-15",
    match = { title = "^(satty)$" },
    float = true,
    center = true,
    size = "(monitor_w*0.6) (monitor_h*0.6)",
})

-- J-Flash → float
hl.window_rule({
    name = "windowrule-16",
    match = { title = "^(Welcome to J-Flash)$" },
    float = true,
    center = true,
    size = "(monitor_w*0.6) (monitor_h*0.6)",
})
