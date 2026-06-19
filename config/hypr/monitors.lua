-- 显示器配置
-- 高分辨率模式
hl.monitor({
    output = "",
    mode = "highres",
    position = "auto",
    scale = 2,
})

-- xwayland 配置
hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})
