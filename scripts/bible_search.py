#!/usr/bin/env python3
"""圣经经文检索脚本 - 支持按卷名、章、节查询中文圣经经文"""

import sys
import re
import os

BIBLE_DIR = "/tmp/bible-test-install/bible-data"

BOOK_MAP = {
    "创世记": "1", "创": "1",
    "出埃及记": "2", "出": "2",
    "利未记": "3", "利": "3",
    "民数记": "4", "民": "4",
    "申命记": "5", "申": "5",
    "约书亚记": "6", "书": "6",
    "士师记": "7", "士": "7",
    "路得记": "8", "得": "8",
    "撒母耳记上": "9", "撒上": "9",
    "撒母耳记下": "10", "撒下": "10",
    "列王纪上": "11", "王上": "11",
    "列王纪下": "12", "王下": "12",
    "历代志上": "13", "代上": "13",
    "历代志下": "14", "代下": "14",
    "以斯拉记": "15", "拉": "15",
    "尼希米记": "16", "尼": "16",
    "以斯帖记": "17", "斯": "17",
    "约伯记": "18", "伯": "18",
    "诗篇": "19", "诗": "19",
    "箴言": "20", "箴": "20",
    "传道书": "21", "传": "21",
    "雅歌": "22", "歌": "22",
    "以赛亚书": "23", "赛": "23",
    "耶利米书": "24", "耶": "24",
    "耶利米哀歌": "25", "哀": "25",
    "以西结书": "26", "结": "26",
    "但以理书": "27", "但": "27",
    "何西阿书": "28", "何": "28",
    "约珥书": "29", "珥": "29",
    "阿摩司书": "30", "摩": "30",
    "俄巴底亚书": "31", "俄": "31",
    "约拿书": "32", "拿": "32",
    "弥迦书": "33", "弥": "33",
    "那鸿书": "34", "鸿": "34",
    "哈巴谷书": "35", "哈": "35",
    "西番雅书": "36", "番": "36",
    "哈该书": "37", "该": "37",
    "撒迦利亚书": "38", "亚": "38",
    "玛拉基书": "39", "玛": "39",
    "马太福音": "40", "太": "40",
    "马可福音": "41", "可": "41",
    "路加福音": "42", "路": "42",
    "约翰福音": "43", "约": "43",
    "使徒行传": "44", "徒": "44",
    "罗马书": "45", "罗": "45",
    "哥林多前书": "46", "林前": "46",
    "哥林多后书": "47", "林后": "47",
    "加拉太书": "48", "加": "48",
    "以弗所书": "49", "弗": "49",
    "腓立比书": "50", "腓": "50",
    "歌罗西书": "51", "西": "51",
    "帖撒罗尼迦前书": "52", "帖前": "52",
    "帖撒罗尼迦后书": "53", "帖后": "53",
    "提摩太前书": "54", "提前": "54",
    "提摩太后书": "55", "提后": "55",
    "提多书": "56", "多": "56",
    "腓利门书": "57", "门": "57",
    "希伯来书": "58", "来": "58",
    "雅各书": "59", "雅": "59",
    "彼得前书": "60", "彼前": "60",
    "彼得后书": "61", "彼后": "61",
    "约翰一书": "62", "约一": "62",
    "约翰二书": "63", "约二": "63",
    "约翰三书": "64", "约三": "64",
    "犹大书": "65", "犹": "65",
    "启示录": "66", "启": "66",
}

NUM_TO_NAME = {}
for name, num in BOOK_MAP.items():
    if num not in NUM_TO_NAME or len(name) > len(NUM_TO_NAME[num]):
        NUM_TO_NAME[num] = name


def find_file(book_name):
    """根据卷名找到对应文件"""
    num = BOOK_MAP.get(book_name)
    if not num:
        return None, None
    target_prefix = num  # 如 "1", "40"
    for f in os.listdir(BIBLE_DIR):
        if not f.endswith(".txt"):
            continue
        # 精确匹配: 编号后紧跟非数字字符（中文卷名），避免 "1" 匹配到 "10"
        m = re.match(r'^(\d+)', f)
        if m and m.group(1) == target_prefix:
            return os.path.join(BIBLE_DIR, f), NUM_TO_NAME.get(num, book_name)
    return None, None


def parse_verses(line_text):
    """将一整行文本解析为 {节号: 经文} 的字典"""
    verses = {}
    # 匹配: 数字紧跟非数字文本
    pattern = r'(\d+)([^\d]+)'
    for m in re.finditer(pattern, line_text):
        v = int(m.group(1))
        t = m.group(2).strip()
        if t:
            verses[v] = t
    return verses


def read_chapter_verses(book_name, chapter_num):
    """读取某卷某章的全部经节"""
    filepath, full_name = find_file(book_name)
    if not filepath:
        return None, f"未找到卷名: {book_name}"
    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    if chapter_num < 1 or chapter_num > len(lines):
        return None, f"{full_name}没有第{chapter_num}章（共{len(lines)}章）"
    line = lines[chapter_num - 1].strip()
    line = re.sub(r'^第\d+章', '', line)
    verses = parse_verses(line)
    return verses, full_name


def get_chapter(book_name, chapter_num):
    """获取指定卷的某一章全部经文"""
    verses, name_or_err = read_chapter_verses(book_name, chapter_num)
    if verses is None:
        return name_or_err
    full_name = name_or_err
    result = f"【{full_name} 第{chapter_num}章】\n"
    for v in sorted(verses.keys()):
        result += f"{v} {verses[v]}\n"
    return result.rstrip()


def get_verse(book_name, chapter_num, verse_num):
    """获取指定卷、章、节的经文"""
    verses, name_or_err = read_chapter_verses(book_name, chapter_num)
    if verses is None:
        return name_or_err
    full_name = name_or_err
    if verse_num not in verses:
        return f"{full_name}第{chapter_num}章没有第{verse_num}节"
    return f"【{full_name} {chapter_num}:{verse_num}】\n{verse_num} {verses[verse_num]}"


def get_verses_range(book_name, chapter_num, v_start, v_end):
    """获取指定卷、章、节范围的经文"""
    verses, name_or_err = read_chapter_verses(book_name, chapter_num)
    if verses is None:
        return name_or_err
    full_name = name_or_err
    result = f"【{full_name} {chapter_num}:{v_start}-{v_end}】\n"
    for v in sorted(verses.keys()):
        if v_start <= v <= v_end:
            result += f"{v} {verses[v]}\n"
    return result.rstrip()


def search_bible(keyword, max_results=20):
    """在全部圣经中搜索关键词"""
    results = []
    for f in sorted(os.listdir(BIBLE_DIR)):
        if not f.endswith(".txt"):
            continue
        m = re.match(r'^(\d+)', f)
        if not m:
            continue
        book_name = NUM_TO_NAME.get(m.group(1), "")
        filepath = os.path.join(BIBLE_DIR, f)
        with open(filepath, 'r', encoding='utf-8') as fh:
            lines = fh.readlines()
        for i, line in enumerate(lines):
            line_clean = re.sub(r'^第\d+章', '', line.strip())
            verses = parse_verses(line_clean)
            for v_num, v_text in sorted(verses.items()):
                if keyword in v_text:
                    results.append(f"【{book_name} {i+1}:{v_num}】{v_text}")
                    if len(results) >= max_results:
                        return results
    return results


def list_books():
    """列出全部66卷"""
    result = "旧约（39卷）:\n"
    for i in range(1, 40):
        result += f"  {i:2d} {NUM_TO_NAME.get(str(i), '?')}\n"
    result += "\n新约（27卷）:\n"
    for i in range(40, 67):
        result += f"  {i:2d} {NUM_TO_NAME.get(str(i), '?')}\n"
    return result


def book_info(book_name):
    """显示某卷的基本信息"""
    filepath, full_name = find_file(book_name)
    if not filepath:
        return f"未找到卷名: {book_name}"
    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    total = 0
    for line in lines:
        line_clean = re.sub(r'^第\d+章', '', line.strip())
        total += len(parse_verses(line_clean))
    return f"【{full_name}】共 {len(lines)} 章，{total} 节"


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("用法: bible_search.py [list|info|search|<卷名> <引用>]")
        print("  list              - 列出全部66卷")
        print("  info <卷名>       - 显示某卷信息")
        print("  <卷名> <章>       - 查看整章")
        print("  <卷名> <章>:<节>  - 查看某节")
        print("  <卷名> <章>:<节>-<节> - 查看节范围")
        print("  search <关键词>   - 全文搜索")
        sys.exit(0)

    cmd = sys.argv[1]

    if cmd == "list":
        print(list_books())
    elif cmd == "search" and len(sys.argv) >= 3:
        kw = " ".join(sys.argv[2:])
        r = search_bible(kw)
        if r:
            for line in r:
                print(line)
        else:
            print(f"未找到包含「{kw}」的经文")
    elif cmd == "info" and len(sys.argv) >= 3:
        print(book_info(sys.argv[2]))
    else:
        # 解析 卷名 章:节 格式
        book = cmd
        if len(sys.argv) < 3:
            print("缺少章号参数")
            sys.exit(1)
        ref = sys.argv[2]
        if ':' in ref:
            parts = ref.split(':')
            ch = int(parts[0])
            vp = parts[1]
            if '-' in vp:
                s, e = vp.split('-')
                print(get_verses_range(book, ch, int(s), int(e)))
            else:
                print(get_verse(book, ch, int(vp)))
        else:
            print(get_chapter(book, int(ref)))
