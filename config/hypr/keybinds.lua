-- 按键绑定

local mainMod = "CTRL"
local term = "neovide -- +terminal -c startinsert"

-- 显示器/窗口切换
hl.bind(mainMod .. " + period", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mainMod .. " + comma", hl.dsp.window.cycle_next("hist"))

-- 启动器
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("rofi -no-lazy-grab -show drun -modi run,drun,window"))
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- 剪贴板历史
hl.bind("CTRL + SHIFT + v", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -window-title \"🐕‍🦺\"| cliphist decode | wl-copy"))

-- 终端
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(term))

-- 截图
hl.bind("CTRL + SHIFT + a", hl.dsp.exec_cmd("bash -c \"grim -g '$(slurp -d)' -t ppm - | satty --filename -\""))
hl.bind("CTRL + SHIFT + b", hl.dsp.exec_cmd("bash -c \"slurp > /tmp/slurp-out 2>&1 &&  sleep 5 && cat /tmp/slurp-out | xargs -I {} grim -g {} - | satty --filename -\""))

-- 工作区切换
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- 窗口操作
hl.bind("CTRL + SHIFT + W", hl.dsp.window.close())
hl.bind("CTRL + SHIFT + F", hl.dsp.window.fullscreen({ state = 1 }))

-- 系统操作
hl.bind("SUPER + period", hl.dsp.exec_cmd("hypridle"))
hl.bind("SUPER + e", hl.dsp.exec_cmd("hyprctl dispatch exit"))
hl.bind("SUPER + minus", hl.dsp.exec_cmd("systemctl poweroff"))

-- 移动窗口到工作区
for i = 1, 9 do
    hl.bind("CTRL + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind("CTRL + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- 调整窗口大小 (binde = repeating)
hl.bind("CTRL + SHIFT + h", hl.dsp.window.resize({ x = 10, y = 0 }), { repeating = true })
hl.bind("CTRL + SHIFT + l", hl.dsp.window.resize({ x = -10, y = 0 }), { repeating = true })
hl.bind("CTRL + SHIFT + i", hl.dsp.window.resize({ x = 0, y = -10 }), { repeating = true })
hl.bind("CTRL + SHIFT + j", hl.dsp.window.resize({ x = 0, y = 10 }), { repeating = true })
