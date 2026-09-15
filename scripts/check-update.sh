#!/usr/bin/env bash
# 对比各安装脚本中固定的 tag 与上游仓库最新 tag, 检查是否有新版本
# 用法: ./check-update.sh [脚本名 ...]   不带参数则检查目录下全部脚本

set -u
shopt -s nullglob

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

if [ -t 1 ]; then
    GREEN=$'\033[32m'; YELLOW=$'\033[33m'; RED=$'\033[31m'; DIM=$'\033[2m'; RESET=$'\033[0m'
else
    GREEN=''; YELLOW=''; RED=''; DIM=''; RESET=''
fi

command -v git >/dev/null 2>&1 || { echo "错误: 需要 git 命令" >&2; exit 1; }

# 从安装脚本中提取固定版本号: tag=vX.Y / rofi_tag="..." / VERSION="${1:-X.Y}"
get_script_tag() {
    local t
    t=$(grep -m1 -oE '^[[:space:]]*(rofi_)?tag=[^[:space:]#]+' "$1" | head -1 | cut -d= -f2- | tr -d "\"'")
    if [ -z "$t" ]; then
        t=$(grep -m1 -oE '\$\{1:-[^}" ]+\}' "$1" | sed -E 's/^\$\{1:-(.*)\}$/\1/')
    fi
    printf '%s' "$t"
}

# 从 git clone 行中提取仓库地址; 没有时尝试从其它 URL(如 wget/curl)中提取 github 仓库
get_script_repo() {
    local line url
    line=$(grep -m1 'git clone' "$1" 2>/dev/null) || line=""
    url=$(printf '%s\n' "$line" | grep -oE 'https?://[^ ]+' | head -1 | sed -E "s/[\"')]+\$//")
    if [ -z "$url" ]; then
        url=$(grep -oE 'https?://[^ ]+' "$1" | grep -oE 'github\.com/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+' | head -1)
        [ -n "$url" ] && url="https://${url}.git"
    fi
    printf '%s' "$url"
}

# 查询仓库最新的版本 tag(过滤预发布标签), 需要 git 网络访问
get_latest_tag() {
    timeout 30 git ls-remote --tags --refs "$1" 2>/dev/null \
        | awk '{print $2}' | sed 's|^refs/tags/||' \
        | grep -E '^v?[0-9][0-9A-Za-z.+_-]*$' \
        | grep -viE '(alpha|beta|rc[0-9]|pre|dev|\.9[0-9]$)' \
        | sort -V | tail -1
}

norm_ver() { printf '%s' "$1" | sed -E 's/^[vV]//'; }

# 收集要检查的脚本(跳过自身)
SELF_NAME=$(basename "${BASH_SOURCE[0]}")
is_self() { [ "$(basename "$1")" = "$SELF_NAME" ]; }
scripts=()
if [ $# -gt 0 ]; then
    for arg in "$@"; do
        found=""
        for f in "$SCRIPT_DIR"/*.sh; do
            is_self "$f" && continue
            b=$(basename "$f")
            if [ "$b" = "$arg" ] || [ "${b%.sh}" = "$arg" ]; then
                scripts+=("$f"); found=1
            fi
        done
        [ -z "$found" ] && echo "未找到脚本: $arg" >&2
    done
else
    for f in "$SCRIPT_DIR"/*.sh; do
        is_self "$f" || scripts+=("$f")
    done
fi
[ ${#scripts[@]} -eq 0 ] && { echo "没有可检查的脚本"; exit 1; }

names=(); repos=(); tags=(); skipped=()
for f in "${scripts[@]}"; do
    b=$(basename "$f")
    t=$(get_script_tag "$f")
    r=$(get_script_repo "$f")
    if [ -z "$t" ]; then
        skipped+=("$b")
    elif [ -z "$r" ]; then
        skipped+=("$b(无仓库地址)")
    else
        names+=("$b"); repos+=("$r"); tags+=("$t")
    fi
done
[ ${#names[@]} -eq 0 ] && { echo "没有固定版本号(tag)的脚本, 无需检查"; exit 0; }

echo "正在查询 ${#names[@]} 个仓库的最新版本 ..."
for i in "${!names[@]}"; do
    get_latest_tag "${repos[$i]}" > "$TMP_DIR/$i.tag" &
done
wait

latests=()
for i in "${!names[@]}"; do latests+=("$(cat "$TMP_DIR/$i.tag")"); done

NAME_W=10; CUR_W=8; LAT_W=8
for n in "${names[@]}"; do [ ${#n} -gt $NAME_W ] && NAME_W=${#n}; done
for t in "${tags[@]}"; do [ ${#t} -gt $CUR_W ] && CUR_W=${#t}; done
for l in "${latests[@]}"; do [ ${#l} -gt $LAT_W ] && LAT_W=${#l}; done
NAME_W=$((NAME_W + 2)); CUR_W=$((CUR_W + 2)); LAT_W=$((LAT_W + 2))

SEP="  "
printf '脚本%*s'"$SEP"'当前版本%*s'"$SEP"'最新版本%*s'"$SEP"'状态\n' \
    $((NAME_W - 4)) '' $((CUR_W - 8)) '' $((LAT_W - 8)) ''
printf '%*s\n' $((NAME_W + CUR_W + LAT_W + 14)) '' | tr ' ' '-'

update=0; uptodate=0; failed=0
for i in "${!names[@]}"; do
    cur=${tags[$i]}; lat=${latests[$i]}
    cur_n=$(norm_ver "$cur"); lat_n=$(norm_ver "$lat")
    if [ -z "$lat" ]; then
        st="${RED}× 获取失败${RESET}"; failed=$((failed + 1))
    elif [ "$cur_n" = "$lat_n" ]; then
        st="${GREEN}✓ 已是最新${RESET}"; uptodate=$((uptodate + 1))
    elif [ "$(printf '%s\n%s\n' "$cur_n" "$lat_n" | sort -V | tail -1)" = "$lat_n" ]; then
        st="${YELLOW}↑ 有新版本${RESET}"; update=$((update + 1))
    else
        st="${DIM}？脚本较新${RESET}"
    fi
    printf "%-${NAME_W}s$SEP%-${CUR_W}s$SEP%-${LAT_W}s$SEP%s\n" "${names[$i]}" "$cur" "$lat" "$st"
done

echo
echo "共 ${#names[@]} 项: ${update} 项有新版本, ${uptodate} 项已是最新, ${failed} 项获取失败"
if [ ${#skipped[@]} -gt 0 ]; then
    echo "${DIM}跳过(未固定 tag, 安装的是 master/最新 release): ${skipped[*]}${RESET}"
fi
