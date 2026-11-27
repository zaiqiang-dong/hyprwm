#!/usr/bin/env bash
# 配置同步脚本: 在仓库与 ~/.config 之间双向同步
#   deploy  部署仓库配置到 ~/.config (按主机适配)
#   backup  备份 ~/.config 配置回仓库

set -u

# 切换到仓库根目录, 支持从任意路径调用
cd "$(dirname "${BASH_SOURCE[0]}")"

usage() {
    cat <<EOF
用法: $(basename "$0") <命令> [参数]

命令:
  deploy [NBJT|NBGT|NBGB]  部署: 按主机(默认自动识别)适配配置后复制到 ~/.config
  backup                   备份: 将 ~/.config 中的配置复制回仓库
  -h, --help               显示本帮助
EOF
}

deploy() {
    local host=${1:-$(uname -a | cut -d " " -f 2)}

    if [[ $host == "NBJT" ]]; then
        echo "config host NBJT"
        sed -i '/hl\.monitor({/,/})/c\hl.monitor({\n  output = "DP-1",\n  mode = "3840x2160@60",\n  position = "0x0",\n  scale = 2,\n})\n\nhl.monitor({\n  output = "HDMI-A-1",\n  mode = "3840x2160@60",\n  position = "1920x0",\n  scale = 2,\n})' ./config/hypr/monitors.lua

        sed -i 's|"DP-5"\: \[1, 2, 3, 4, 5\]|"DP-1"\: \[1, 2, 3, 4, 5\]|g' ./config/waybar/config.jsonc
        sed -i 's|"DP-6"\: \[6, 7, 8, 9, 10, 11\]|"HDMI-A-1"\: \[6, 7, 8, 9, 10, 11\]|g' ./config/waybar/config.jsonc

        cp ./workspace/NBJT/workspace.lua ./config/hypr/workspace.lua

    elif [[ $host == "NBGT" ]]; then
        echo "config host NBGT"
        cp ./workspace/NBGT/workspace.lua ./config/hypr/workspace.lua

    elif [[ $host == "NBGB" ]]; then
        echo "config host NBGB"

        sed -i 's|scale = 2|scale = 1|g' ./config/hypr/monitors.lua
        sed -i '/hl\.env("GDK_SCALE", "2")/d;/hl\.env("QT_FONT_DPI", "144")/d' ./config/hypr/env.lua

        sed -i '/\"DP-5\"\: \[1, 2, 3, 4, 5\]/d' ./config/waybar/config.jsonc
        sed -i '/\"DP-6\"\: \[6, 7, 8, 9, 10, 11\]/d' ./config/waybar/config.jsonc
        if ! sed -n '/"modules-right": \[/,/]/p' ./config/waybar/config.jsonc | grep -q '^[[:space:]]*"backlight",'; then
            sed -i '/^[[:space:]]*"pulseaudio",/a\    "backlight",' ./config/waybar/config.jsonc
        fi

        cp ./workspace/NBGB/workspace.lua ./config/hypr/workspace.lua
    else
        echo "未知主机: $host"
        if [[ -n ${1:-} ]]; then
            echo "可用主机: NBJT NBGT NBGB" >&2
            exit 1
        fi
        echo "跳过主机适配"
    fi

    # 部署配置文件到 ~/.config
    cp -r ./config/* ~/.config/
    cp ./config/gtk-2.0/gtkrc-2.0 ~/.gtkrc-2.0

    # 链接主题目录
    if [[ ! -e ~/.local/share/themes ]]; then
        ln -s "$(realpath themes)" ~/.local/share/themes
    fi

    if [[ -e ~/.config/gtk-4.0 ]]; then
        rm -rf ~/.config/gtk-4.0
    fi
    ln -s ~/.local/share/themes/Catppuccin-Green-Dark/gtk-4.0 ~/.config/gtk-4.0

    # 还原工作区改动
    git checkout .
    git clean -df

    echo "部署完成"
}

backup() {
    cp -r ~/.config/hypr ./config/

    if lsmod | grep -q "nvidia"; then
        # gpu.conf 是部署时由 nvidia.conf 复制生成的, 备份为 nvidia.conf 后移除
        cp ./config/hypr/gpu.conf ./config/hypr/nvidia.conf
        rm -f ./config/hypr/gpu.conf
    fi

    # workspace.conf 为主机运行状态, 不备份
    git checkout ./config/hypr/workspace.conf
    cp -r ~/.config/waybar ./config/
    cp -r ~/.config/rofi ./config/
    cp -r ~/.config/satty ./config/
    cp -r ~/.config/swaync ./config/
    cp -r ~/.config/gtk-3.0 ./config/
    rm -f ./config/gtk-3.0/bookmarks
    cp -r ~/.config/gtk-4.0 ./config/
    cp -r ~/.gtkrc-2.0 ./config/gtk-2.0/gtkrc-2.0

    echo "备份完成, 可用 git diff 查看改动"
}

case ${1:-} in
    deploy)
        shift
        deploy "$@"
        ;;
    backup)
        backup
        ;;
    -h|--help)
        usage
        ;;
    *)
        usage >&2
        exit 1
        ;;
esac
