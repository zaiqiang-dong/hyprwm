#!/usr/bin/env bash
# 对比各安装脚本中固定的 tag 与上游仓库最新 tag, 检查是否有新版本
# 用法: ./check-update.sh [-u] [脚本名 ...]
#   -u, --update  检查到新版本时, 直接把脚本中的固定版本号改成最新版本
#   脚本名可省略 .sh 后缀; 不带脚本名则检查目录下全部脚本

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

usage() {
    cat <<EOF
用法: $(basename "$0") [-u] [脚本名 ...]
  -u, --update   有新版本时直接修改安装脚本, 把固定版本号更新为最新版本
  脚本名可省略 .sh 后缀; 不带脚本名则检查目录下全部脚本
EOF
}

# 参数解析: -u/--update 开启自动更新, 其余作为脚本名
UPDATE=0
name_args=()
while [ $# -gt 0 ]; do
    case $1 in
        -u|--update) UPDATE=1 ;;
        -h|--help) usage; exit 0 ;;
        -*) echo "未知参数: $1" >&2; usage >&2; exit 1 ;;
        *) name_args+=("$1") ;;
    esac
    shift
done

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

# 把脚本中出现的旧版本号全部替换为新版本号(含 URL 编码形式, 如 rofi 下载链接中的 %2B)
update_script_tag() {
    local file=$1 old=$2 new=$3
    local pat_old repl_old pat_enc repl_enc
    pat_old=$(printf '%s' "$old" | sed -e 's/[.\^$*/[]/\\&/g')
    repl_old=$(printf '%s' "$new" | sed -e 's/[\/&\\]/\\&/g')
    sed -i "s/\\<${pat_old}\\>/${repl_old}/g" "$file"
    if [[ $old == *+* ]]; then
        pat_enc=$(printf '%s' "${old//+/%2B}" | sed -e 's/[.\^$*/[]/\\&/g')
        repl_enc=$(printf '%s' "${new//+/%2B}" | sed -e 's/[\/&\\]/\\&/g')
        sed -i "s/\\<${pat_enc}\\>/${repl_enc}/g" "$file"
    fi
}

# 收集要检查的脚本(跳过自身)
SELF_NAME=$(basename "${BASH_SOURCE[0]}")
is_self() { [ "$(basename "$1")" = "$SELF_NAME" ]; }
scripts=()
if [ ${#name_args[@]} -gt 0 ]; then
    for arg in "${name_args[@]}"; do
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

names=(); files=(); repos=(); tags=(); skipped=()
for f in "${scripts[@]}"; do
    b=$(basename "$f")
    t=$(get_script_tag "$f")
    r=$(get_script_repo "$f")
    if [ -z "$t" ]; then
        skipped+=("$b")
    elif [ -z "$r" ]; then
        skipped+=("$b(无仓库地址)")
    else
        names+=("$b"); files+=("$f"); repos+=("$r"); tags+=("$t")
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

update=0; uptodate=0; failed=0; updated=0
for i in "${!names[@]}"; do
    cur=${tags[$i]}; lat=${latests[$i]}
    cur_n=$(norm_ver "$cur"); lat_n=$(norm_ver "$lat")
    if [ -z "$lat" ]; then
        st="${RED}× 获取失败${RESET}"; failed=$((failed + 1))
    elif [ "$cur_n" = "$lat_n" ]; then
        st="${GREEN}✓ 已是最新${RESET}"; uptodate=$((uptodate + 1))
    elif [ "$(printf '%s\n%s\n' "$cur_n" "$lat_n" | sort -V | tail -1)" = "$lat_n" ]; then
        update=$((update + 1))
        if [ "$UPDATE" -eq 1 ]; then
            update_script_tag "${files[$i]}" "$cur" "$lat"
            if [ "$(get_script_tag "${files[$i]}")" = "$lat" ]; then
                st="${GREEN}✎ 已更新${RESET}"; updated=$((updated + 1))
            else
                st="${RED}× 更新失败${RESET}"
            fi
        else
            st="${YELLOW}↑ 有新版本${RESET}"
        fi
    else
        st="${DIM}？脚本较新${RESET}"
    fi
    printf "%-${NAME_W}s$SEP%-${CUR_W}s$SEP%-${LAT_W}s$SEP%s\n" "${names[$i]}" "$cur" "$lat" "$st"
done

echo
echo "共 ${#names[@]} 项: ${update} 项有新版本, ${uptodate} 项已是最新, ${failed} 项获取失败"
if [ "$UPDATE" -eq 1 ]; then
    echo "已更新 ${updated} 个脚本, 可用 git diff 查看改动"
fi
if [ ${#skipped[@]} -gt 0 ]; then
    echo "${DIM}跳过(未固定 tag, 安装的是 master/最新 release): ${skipped[*]}${RESET}"
fi
