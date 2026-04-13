---
name: bible
description: 中文圣经经文查询技能 - 支持按卷名、章、节、关键词检索和引用经文
version: 2.0
triggers:
  - 圣经
  - 经文
  - 查经
  - bible
---

# 中文圣经经文查询技能

基于本地 66 卷中文和合本圣经纯文本文件，提供经文查询、检索和引用功能。

---

## 安装指南（从零开始）

本技能由两部分组成：
- **数据文件**: 66 个圣经文本 .txt 文件（共约 3.3MB）
- **搜索脚本**: `bible_search.py`（Python 3 脚本，无第三方依赖）

### 安装方式一：一键安装（推荐）

适合：小白用户、想快速上手的用户。

前提：你的电脑上已有 Python 3（macOS 和大多数 Linux 自带，Windows 需单独安装）。

打开终端（macOS 按 Cmd+空格搜"终端"，Windows 搜"PowerShell"），执行：

```bash
# 1. 确认 Python 3 可用
python3 --version
# 应输出类似: Python 3.10.x 或更高版本
# 如果报错"command not found"，请先安装 Python 3

# 2. 创建 skill 目录
mkdir -p ~/.hermes/skills/creative/bible/scripts
mkdir -p ~/.hermes/skills/creative/bible/assets

# 3. 将以下文件放到对应位置：
#    - scripts/bible_search.py  → ~/.hermes/skills/creative/bible/scripts/bible_search.py
#    - scripts/install.sh       → ~/.hermes/skills/creative/bible/scripts/install.sh
#    - assets/bible-txt-file.tar.gz → ~/.hermes/skills/creative/bible/assets/bible-txt-file.tar.gz
#    - SKILL.md                 → ~/.hermes/skills/creative/bible/SKILL.md

# 4. 运行一键安装脚本
bash ~/.hermes/skills/creative/bible/scripts/install.sh

# 5. 如果想自定义数据目录（默认装到 ~/bible-data/）：
bash ~/.hermes/skills/creative/bible/scripts/install.sh /你/想/放/的/路径
```

安装脚本会自动完成：解压数据 → 创建目录 → 配置路径 → 验证安装，并在每步给出结果反馈。

---

### 安装方式二：手动安装

适合：想了解每一步细节的用户，或数据已有但格式不同的用户。

#### 第 1 步：确认环境

```bash
python3 --version
```

如果报错，请先安装 Python 3：
- macOS: 在终端运行 `brew install python3`（需先装 Homebrew），或从 python.org 下载
- Ubuntu/Debian: `sudo apt update && sudo apt install python3`
- Windows: 从 https://www.python.org/downloads/ 下载安装包，安装时勾选"Add Python to PATH"

#### 第 2 步：准备圣经文本数据

你需要 66 个中文和合本圣经的纯文本文件。这是整个安装最关键的一步。

**文件命名规则**：`编号+卷名.txt`，编号 1-66，例如：

```
1创世记.txt       2出埃及记.txt     3利未记.txt       4民数记.txt
5申命记.txt       6约书亚记.txt     7士师记.txt       8路得记.txt
9撒母耳记上.txt   10撒母耳记下.txt  11列王纪上.txt    12列王纪下.txt
...（中间省略）...
62约翰一书.txt    63约翰二书.txt    64约翰三书.txt    65犹大书.txt
66启示录.txt
```

**完整的 66 卷编号对照**：

```
旧约（39卷）：
  1创世记    2出埃及记    3利未记      4民数记      5申命记
  6约书亚记  7士师记      8路得记      9撒母耳记上  10撒母耳记下
  11列王纪上 12列王纪下   13历代志上   14历代志下   15以斯拉记
  16尼希米记 17以斯帖记   18约伯记     19诗篇      20箴言
  21传道书   22雅歌       23以赛亚书   24耶利米书   25耶利米哀歌
  26以西结书 27但以理书   28何西阿书   29约珥书    30阿摩司书
  31俄巴底亚书 32约拿书   33弥迦书     34那鸿书    35哈巴谷书
  36西番雅书 37哈该书     38撒迦利亚书 39玛拉基书

新约（27卷）：
  40马太福音   41马可福音   42路加福音   43约翰福音   44使徒行传
  45罗马书     46哥林多前书 47哥林多后书 48加拉太书   49以弗所书
  50腓立比书   51歌罗西书   52帖撒罗尼迦前书 53帖撒罗尼迦后书
  54提摩太前书 55提摩太后书 56提多书     57腓利门书   58希伯来书
  59雅各书     60彼得前书   61彼得后书   62约翰一书   63约翰二书
  64约翰三书   65犹大书     66启示录
```

**文件内容格式**（这是最关键的，格式不对会导致解析错误）：

每个文件中，**每一行对应一整章**，格式为：
```
第X章1第一节经文2第二节经文3第三节经文...N最后一节经文
```

具体规则：
- 行首是 `第X章`（X 为章号，如 `第1章`、`第23章`）
- 紧接着是节号（纯数字，如 `1`、`2`、`31`）+ 该节经文内容
- 节号和经文之间**没有空格或其他分隔符**
- 上一节经文结束后，紧跟下一节的节号
- 每章独占一行（行内没有换行符）
- 文件编码为 **UTF-8**

**真实示例**（创世记第1章第1-5节）：
```
第1章1起初　神创造天地。2地是空虚混沌，渊面黑暗；　神的灵运行在水面上。3　神说："要有光。"就有了光。4　神看光是好的，就把光暗分开了。5　神称光为"昼"，称暗为"夜"。有晚上，有早晨，这是头一日。
```

**错误格式**（会导致解析失败）：
```
❌ 第1章
❌ 1 起初神创造天地。（节号后有空格）
❌ 1起初 神创造天地。（节号前有空格）
❌ 第一章1起初神创造天地。（用中文数字"一"而非阿拉伯数字"1"）
❌ 创世记第1章1起初神创造天地。（行首多了书名）
```

**如何获取数据**：

方法 A — 使用本 skill 自带的数据包（最简单）：
```bash
# 数据包位于 assets/bible-txt-file.tar.gz（约 1.2MB）
# 解压到指定目录：
mkdir -p ~/bible-data
tar xzf ~/.hermes/skills/creative/bible/assets/bible-txt-file.tar.gz -C ~/bible-data --strip-components=1
```

方法 B — 从网上自行下载并转换：
1. 搜索"中文和合本圣经 txt 下载"或"Chinese Union Version Bible text"
2. 下载的格式可能各不相同（XML、JSON、每节一行等），需要转换为上述格式
3. 如果你下载的数据是"每节一行"格式，可以用以下 Python 脚本转换：

```python
#!/usr/bin/env python3
"""将'每节一行'格式的圣经数据转换为本 skill 需要的格式"""
import re, os, sys

def convert_book(input_file, output_file):
    """将每节一行的文件转换为每章一行的格式"""
    chapters = {}
    with open(input_file, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            # 假设格式: 卷名 章:节 经文  或  章:节 经文
            # 请根据你的实际数据修改此处的正则表达式
            m = re.match(r'(\d+):(\d+)\s+(.*)', line)
            if m:
                ch = int(m.group(1))
                vs = int(m.group(2))
                text = m.group(3)
                if ch not in chapters:
                    chapters[ch] = {}
                chapters[ch][vs] = text
    
    with open(output_file, 'w', encoding='utf-8') as f:
        for ch in sorted(chapters.keys()):
            line = f"第{ch}章"
            for vs in sorted(chapters[ch].keys()):
                line += f"{vs}{chapters[ch][vs]}"
            f.write(line + '\n')

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("用法: python3 convert.py 输入文件 输出文件")
        sys.exit(1)
    convert_book(sys.argv[1], sys.argv[2])
```

#### 第 3 步：创建目录结构

```bash
mkdir -p ~/.hermes/skills/creative/bible/scripts
```

这一步创建 skill 的存放目录。`~/.hermes/skills/` 是 Hermes Agent 的技能目录，`creative/bible/` 是本技能的子目录。

#### 第 4 步：放置文件

将以下文件放到对应位置：

```
~/.hermes/skills/creative/bible/
├── SKILL.md                          ← 技能说明文档（本文件）
├── assets/
│   └── bible-txt-file.tar.gz         ← 圣经数据压缩包（1.2MB，含66个txt文件）
└── scripts/
    ├── bible_search.py               ← 核心搜索脚本
    └── install.sh                    ← 一键安装脚本
```

#### 第 5 步：修改脚本中的数据路径

打开 `bible_search.py`，找到这一行（在文件开头附近）：

```python
BIBLE_DIR = os.path.expanduser("~/workspace/20260413/bible-txt-file")
```

将其改为你的圣经数据实际路径，例如：

```python
BIBLE_DIR = os.path.expanduser("~/bible-data")
```

或者使用绝对路径：

```python
BIBLE_DIR = "/Users/你的用户名/bible-data"
```

> 如果用一键安装脚本，这一步会自动完成。

#### 第 6 步：设置脚本可执行权限

```bash
chmod +x ~/.hermes/skills/creative/bible/scripts/bible_search.py
chmod +x ~/.hermes/skills/creative/bible/scripts/install.sh
```

这一步让脚本文件可以被执行。如果没有执行权限，运行时会报"Permission denied"。

#### 第 7 步：验证安装

**逐一测试以下命令**，确保每一步都能正常输出：

```bash
# 测试 1: 列出66卷（应显示旧约39卷和新约27卷）
python3 ~/.hermes/skills/creative/bible/scripts/bible_search.py list
```
预期输出：
```
旧约（39卷）:
   1 创世记
   2 出埃及记
   ...
新约（27卷）:
  40 马太福音
  ...
```

```bash
# 测试 2: 查询创世记1:1（应输出"起初　神创造天地。"）
python3 ~/.hermes/skills/creative/bible/scripts/bible_search.py 创 1:1
```
预期输出：
```
【创世记 1:1】
1 起初　神创造天地。
```

```bash
# 测试 3: 查看卷信息（应显示章数和节数）
python3 ~/.hermes/skills/creative/bible/scripts/bible_search.py info 诗篇
```
预期输出：
```
【诗篇】共 150 章，2461 节
```

```bash
# 测试 4: 关键词搜索（应返回包含该关键词的经文）
python3 ~/.hermes/skills/creative/bible/scripts/bible_search.py search 神爱世人
```
预期输出（类似）：
```
【约翰福音 3:16】"　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
```

如果以上 4 个测试都通过，说明安装成功！

---

### 常见问题排查

**Q: 运行脚本报 `python3: command not found`**

A: 你的系统没有安装 Python 3，或者没有加入 PATH。请参考第 1 步安装 Python 3。

**Q: 运行脚本报 `No such file or directory: ...bible-txt-file/`**

A: 圣经数据目录路径不对。打开 `bible_search.py`，检查 `BIBLE_DIR` 变量指向的目录是否存在：
```bash
ls ~/bible-data/   # 或你在脚本中设置的路径
```
应看到 66 个 .txt 文件。如果目录为空或不存在，请重新执行第 2 步。

**Q: 报 `未找到卷名: xxx`**

A: 你输入的卷名或简称不在脚本的映射表中。打开 `bible_search.py`，查看 `BOOK_MAP` 字典，确认你要查的卷名或简称在其中。如需添加自定义简称，在 `BOOK_MAP` 中添加一行：
```python
"自定义简称": "对应编号",
```

**Q: 查询出的经文节号错乱，或经文内容不完整**

A: 你的 .txt 文件格式不对。请对照第 2 步中的格式要求检查：
1. 每行是否以 `第X章` 开头（X 为阿拉伯数字）
2. 节号是否紧跟在上一节经文后面，中间无空格
3. 文件编码是否为 UTF-8（可用 `file -I 文件名.txt` 检查）

**Q: 脚本报 `Permission denied`**

A: 脚本没有执行权限。运行：
```bash
chmod +x ~/.hermes/skills/creative/bible/scripts/bible_search.py
```

**Q: 搜索结果太多或太少**

A: 搜索默认最多返回 20 条结果。如需修改，打开 `bible_search.py`，找到 `search_bible(keyword, max_results=20)` 这行，将 `20` 改为你需要的数字。

**Q: 想在其他机器上安装，但不想从头配置**

A: 将整个 skill 目录复制到新机器即可：
```bash
# 打包
tar czf bible-skill.tar.gz -C ~/.hermes/skills/creative bible

# 传输到新机器后解压
tar xzf bible-skill.tar.gz -C ~/.hermes/skills/creative/

# 然后在新机器上运行安装脚本
bash ~/.hermes/skills/creative/bible/scripts/install.sh
```

---

## 使用方法

### 基本命令格式

```bash
python3 ~/.hermes/skills/creative/bible/scripts/bible_search.py <命令>
```

### 1. 列出全部 66 卷

```bash
python3 ~/.hermes/skills/creative/bible/scripts/bible_search.py list
```

### 2. 查看某卷信息（章数、节数）

```bash
python3 ~/.hermes/skills/creative/bible/scripts/bible_search.py info 创世记
python3 ~/.hermes/skills/creative/bible/scripts/bible_search.py info 太
```

### 3. 查看整章

```bash
python3 ~/.hermes/skills/creative/bible/scripts/bible_search.py 创世记 1
python3 ~/.hermes/skills/creative/bible/scripts/bible_search.py 太 5
```

### 4. 查看某一节

```bash
python3 ~/.hermes/skills/creative/bible/scripts/bible_search.py 创 1:1
python3 ~/.hermes/skills/creative/bible/scripts/bible_search.py 约 3:16
python3 ~/.hermes/skills/creative/bible/scripts/bible_search.py 诗 23:1
```

### 5. 查看节范围

```bash
python3 ~/.hermes/skills/creative/bible/scripts/bible_search.py 太 5:3-12
python3 ~/.hermes/skills/creative/bible/scripts/bible_search.py 创 1:1-5
```

### 6. 全文搜索关键词

```bash
python3 ~/.hermes/skills/creative/bible/scripts/bible_search.py search 耶和华是我的牧者
python3 ~/.hermes/skills/creative/bible/scripts/bible_search.py search 神爱世人
```

## 卷名简称对照

支持中文全名和常见简称，例如：

| 旧约简称 | 全名 | 新约简称 | 全名 |
|---------|------|---------|------|
| 创 | 创世记 | 太 | 马太福音 |
| 出 | 出埃及记 | 可 | 马可福音 |
| 利 | 利未记 | 路 | 路加福音 |
| 民 | 民数记 | 约 | 约翰福音 |
| 申 | 申命记 | 徒 | 使徒行传 |
| 书 | 约书亚记 | 罗 | 罗马书 |
| 撒上 | 撒母耳记上 | 林前 | 哥林多前书 |
| 撒下 | 撒母耳记下 | 林后 | 哥林多后书 |
| 王上 | 列王纪上 | 加 | 加拉太书 |
| 王下 | 列王纪下 | 弗 | 以弗所书 |
| 诗 | 诗篇 | 腓 | 腓立比书 |
| 箴 | 箴言 | 来 | 希伯来书 |
| 赛 | 以赛亚书 | 雅 | 雅各书 |
| 耶 | 耶利米书 | 彼前 | 彼得前书 |
| 结 | 以西结书 | 启 | 启示录 |

## 注意事项

- 搜索功能默认返回最多 20 条结果
- 所有经文为中文和合本（CUV）
- 约翰福音简称"约"与约翰一二三书简称"约一""约二""约三"不冲突
- "哈"同时匹配哈巴谷书和哈该书，优先匹配更长的全名

## 文件结构

```
~/.hermes/skills/creative/bible/
├── SKILL.md                          # 本文档
├── assets/
│   └── bible-txt-file.tar.gz         # 圣经数据压缩包（66卷，约1.2MB）
└── scripts/
    ├── bible_search.py               # 核心搜索脚本（Python 3，无第三方依赖）
    └── install.sh                    # 一键安装脚本
```
