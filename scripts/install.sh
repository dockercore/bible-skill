#!/usr/bin/env bash
# ============================================================
# 中文圣经经文查询技能 - 一键安装脚本
# ============================================================
# 用法: bash install.sh [数据目录路径]
# 默认数据目录: ~/bible-data
# ============================================================

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 默认圣经数据目录
BIBLE_DATA_DIR="${1:-$HOME/bible-data}"
SKILL_DIR="$HOME/.hermes/skills/creative/bible"
SCRIPT_DIR="$SKILL_DIR/scripts"

echo ""
echo -e "${BLUE}============================================================${NC}"
echo -e "${BLUE}       中文圣经经文查询技能 (Bible Skill) 安装程序${NC}"
echo -e "${BLUE}============================================================${NC}"
echo ""

# ============================================================
# 步骤 1: 检查 Python 3
# ============================================================
echo -e "${YELLOW}[步骤 1/6] 检查 Python 3 ...${NC}"

if ! command -v python3 &> /dev/null; then
    echo -e "${RED}错误: 未找到 python3！${NC}"
    echo ""
    echo "请先安装 Python 3："
    echo "  macOS:   brew install python3"
    echo "  Ubuntu:  sudo apt install python3"
    echo "  Windows: 从 https://www.python.org/downloads/ 下载安装"
    echo ""
    exit 1
fi

PYTHON_VERSION=$(python3 --version 2>&1)
echo -e "${GREEN}✓ 已找到 $PYTHON_VERSION${NC}"
echo ""

# ============================================================
# 步骤 2: 设置圣经数据目录
# ============================================================
echo -e "${YELLOW}[步骤 2/6] 设置圣经数据目录 ...${NC}"
echo "数据将安装到: $BIBLE_DATA_DIR"
echo ""

# 如果目录已存在且有数据，询问是否覆盖
if [ -d "$BIBLE_DATA_DIR" ] && [ "$(ls -A "$BIBLE_DATA_DIR" 2>/dev/null | wc -l)" -gt 0 ]; then
    echo -e "${YELLOW}警告: 目录 $BIBLE_DATA_DIR 已存在且有文件。${NC}"
    read -p "是否覆盖？(y/N): " overwrite
    if [ "$overwrite" != "y" ] && [ "$overwrite" != "Y" ]; then
        echo "保留现有数据，跳过数据解压。"
    else
        rm -rf "$BIBLE_DATA_DIR"
        mkdir -p "$BIBLE_DATA_DIR"
    fi
else
    mkdir -p "$BIBLE_DATA_DIR"
fi

# ============================================================
# 步骤 3: 解压圣经数据
# ============================================================
echo -e "${YELLOW}[步骤 3/6] 解压圣经文本数据 ...${NC}"

# 尝试从 skill 自带的 assets 中解压
ASSETS_ARCHIVE="$SKILL_DIR/assets/bible-txt-file.tar.gz"

if [ -f "$ASSETS_ARCHIVE" ]; then
    echo "从自带数据包解压 ..."
    tar xzf "$ASSETS_ARCHIVE" -C "$BIBLE_DATA_DIR" --strip-components=1
    echo -e "${GREEN}✓ 数据解压完成${NC}"
else
    echo -e "${RED}错误: 未找到自带数据包 $ASSETS_ARCHIVE${NC}"
    echo ""
    echo "请手动准备圣经数据文件，放入 $BIBLE_DATA_DIR/"
    echo "要求："
    echo "  - 66 个 .txt 文件"
    echo "  - 文件名格式: 编号+卷名.txt （如 1创世记.txt、40马太福音.txt）"
    echo "  - 文件内容: 每行一整章，格式: 第X章1经文内容2经文内容..."
    echo "  - 编码: UTF-8"
    echo ""
    echo "准备好后重新运行此脚本即可。"
    exit 1
fi

# 验证文件数量
FILE_COUNT=$(ls "$BIBLE_DATA_DIR"/*.txt 2>/dev/null | wc -l | tr -d ' ')
if [ "$FILE_COUNT" -ne 66 ]; then
    echo -e "${RED}错误: 预期 66 个 .txt 文件，实际找到 $FILE_COUNT 个${NC}"
    exit 1
fi
echo -e "${GREEN}✓ 已找到 $FILE_COUNT 个圣经文本文件${NC}"
echo ""

# ============================================================
# 步骤 4: 创建 skill 目录结构
# ============================================================
echo -e "${YELLOW}[步骤 4/6] 创建 skill 目录结构 ...${NC}"

mkdir -p "$SCRIPT_DIR"
echo -e "${GREEN}✓ 目录已创建: $SKILL_DIR/${NC}"
echo -e "${GREEN}✓ 脚本目录:   $SCRIPT_DIR/${NC}"
echo ""

# ============================================================
# 步骤 5: 复制搜索脚本并更新数据路径
# ============================================================
echo -e "${YELLOW}[步骤 5/6] 配置搜索脚本 ...${NC}"

SEARCH_SCRIPT="$SCRIPT_DIR/bible_search.py"

if [ -f "$SEARCH_SCRIPT" ]; then
    echo "搜索脚本已存在，更新数据路径 ..."
else
    echo "搜索脚本不存在，请确保 bible_search.py 已放入 $SCRIPT_DIR/"
    exit 1
fi

# 将 BIBLE_DIR 替换为实际路径
# 展开 ~ 为 $HOME，因为 Python 的 os.path.expanduser 可以处理 ~
# 但为了更可靠，我们使用绝对路径
ABS_BIBLE_DATA_DIR=$(cd "$BIBLE_DATA_DIR" && pwd)

# 使用 Python 替换 BIBLE_DIR 路径（比 sed 更可靠，避免特殊字符问题）
python3 -c "
import re, sys
path = '$ABS_BIBLE_DATA_DIR'
script = '$SEARCH_SCRIPT'
with open(script, 'r', encoding='utf-8') as f:
    content = f.read()
new_content = re.sub(r'BIBLE_DIR = .*', 'BIBLE_DIR = \"' + path + '\"', content)
if new_content != content:
    with open(script, 'w', encoding='utf-8') as f:
        f.write(new_content)
    print('PATH_UPDATED')
else:
    print('PATH_UNCHANGED')
" | while read -r line; do
    if [ "$line" = "PATH_UPDATED" ]; then
        echo -e "${GREEN}✓ 数据路径已更新为: $ABS_BIBLE_DATA_DIR${NC}"
    else
        echo "数据路径已正确，无需修改。"
    fi
done

chmod +x "$SEARCH_SCRIPT"
echo -e "${GREEN}✓ 搜索脚本已配置${NC}"
echo ""

# ============================================================
# 步骤 6: 验证安装
# ============================================================
echo -e "${YELLOW}[步骤 6/6] 验证安装 ...${NC}"
echo ""

echo "测试 1: 列出 66 卷 ..."
LIST_OUTPUT=$("$SEARCH_SCRIPT" list 2>&1 | head -5)
if echo "$LIST_OUTPUT" | grep -q "创世记"; then
    echo -e "${GREEN}✓ 列出卷名正常${NC}"
else
    echo -e "${RED}✗ 列出卷名失败: $LIST_OUTPUT${NC}"
fi

echo ""
echo "测试 2: 查询创世记 1:1 ..."
VERSE_OUTPUT=$("$SEARCH_SCRIPT" 创 1:1 2>&1)
if echo "$VERSE_OUTPUT" | grep -q "起初"; then
    echo -e "${GREEN}✓ 经文查询正常${NC}"
    echo "  输出: $VERSE_OUTPUT"
else
    echo -e "${RED}✗ 经文查询失败: $VERSE_OUTPUT${NC}"
fi

echo ""
echo "测试 3: 搜索关键词 ..."
SEARCH_OUTPUT=$("$SEARCH_SCRIPT" search 神爱世人 2>&1 | head -3)
if echo "$SEARCH_OUTPUT" | grep -q "神爱世人"; then
    echo -e "${GREEN}✓ 关键词搜索正常${NC}"
else
    echo -e "${RED}✗ 关键词搜索失败: $SEARCH_OUTPUT${NC}"
fi

echo ""
echo "测试 4: 查看卷信息 ..."
INFO_OUTPUT=$("$SEARCH_SCRIPT" info 诗篇 2>&1)
if echo "$INFO_OUTPUT" | grep -q "150"; then
    echo -e "${GREEN}✓ 卷信息查询正常${NC}"
    echo "  输出: $INFO_OUTPUT"
else
    echo -e "${RED}✗ 卷信息查询失败: $INFO_OUTPUT${NC}"
fi

echo ""
echo -e "${BLUE}============================================================${NC}"
echo -e "${GREEN}  安装完成！${NC}"
echo -e "${BLUE}============================================================${NC}"
echo ""
echo "使用方法:"
echo ""
echo "  列出全部66卷:"
echo "    python3 $SCRIPT_DIR/bible_search.py list"
echo ""
echo "  查看某卷信息:"
echo "    python3 $SCRIPT_DIR/bible_search.py info 创世记"
echo ""
echo "  查看整章:"
echo "    python3 $SCRIPT_DIR/bible_search.py 创世记 1"
echo ""
echo "  查看某一节:"
echo "    python3 $SCRIPT_DIR/bible_search.py 约 3:16"
echo ""
echo "  查看节范围:"
echo "    python3 $SCRIPT_DIR/bible_search.py 太 5:3-12"
echo ""
echo "  全文搜索:"
echo "    python3 $SCRIPT_DIR/bible_search.py search 神爱世人"
echo ""
echo "数据目录: $ABS_BIBLE_DATA_DIR"
echo "脚本目录: $SCRIPT_DIR"
echo ""
