# Chinese Bible Search Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.6+](https://img.shields.io/badge/Python-3.6%2B-blue.svg)](https://www.python.org/)

[中文文档](README.md)

A local, offline Chinese Bible (Union Version / 和合本) search tool. Query verses by book name, chapter, verse, or keyword — zero dependencies, ready to use.

---

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
  - [Option 1: One-Click Install (Recommended)](#option-1-one-click-install-recommended)
  - [Option 2: Manual Install](#option-2-manual-install)
  - [Option 3: Clone & Run](#option-3-clone--run)
- [Usage](#usage)
  - [1. List All 66 Books](#1-list-all-66-books)
  - [2. View Book Info](#2-view-book-info)
  - [3. View an Entire Chapter](#3-view-an-entire-chapter)
  - [4. View a Single Verse](#4-view-a-single-verse)
  - [5. View a Verse Range](#5-view-a-verse-range)
  - [6. Full-Text Search](#6-full-text-search)
- [Book Name Abbreviations](#book-name-abbreviations)
- [Data Format](#data-format)
- [File Structure](#file-structure)
- [Using with AI Agents](#using-with-ai-agents)
  - [Claude Code](#claude-code)
  - [Hermes Agent](#hermes-agent)
  - [OpenClaw](#openclaw)
- [FAQ](#faq)
- [License](#license)

---

## Features

- 📖 List all 66 books of the Bible
- 🔍 Query verses by full name or abbreviation (whole chapter, single verse, verse range)
- 🗂️ View book info (chapter count, verse count)
- 🔎 Full-text keyword search (returns up to 20 results by default)
- 📦 One-click install script with bundled data archive
- 🚀 Zero third-party dependencies — only Python 3.6+ required

---

## Requirements

| Item | Requirement |
|------|-------------|
| Python | 3.6 or higher |
| OS | macOS / Linux / Windows |
| Disk Space | ~5 MB (data + scripts) |
| Dependencies | None |

---

## Installation

### Option 1: One-Click Install (Recommended)

Best for beginners. Three commands and you're done.

**Step 1: Verify Python 3 is installed**

```bash
python3 --version
```

If you get `command not found`, install Python 3 first:

| System | How to Install |
|--------|---------------|
| macOS | `brew install python3` or download from [python.org](https://www.python.org/downloads/) |
| Ubuntu / Debian | `sudo apt update && sudo apt install python3` |
| Windows | Download from [python.org](https://www.python.org/downloads/) — **make sure to check** "Add Python to PATH" during installation |

**Step 2: Clone this repository**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

> No git? Click the green "Code" button on this page → "Download ZIP", then extract.

**Step 3: Run the install script**

```bash
bash scripts/install.sh
```

The install script performs these steps automatically:

```
[Step 1/6] Check Python 3           → Verify Python 3 is available
[Step 2/6] Set Bible data directory  → Default: ~/bible-data/
[Step 3/6] Extract Bible text data   → Unpack 66 .txt files from bundled archive
[Step 4/6] Create skill directory    → Create ~/.hermes/skills/creative/bible/
[Step 5/6] Configure search script   → Auto-update data path
[Step 6/6] Verify installation       → Run 4 tests to confirm everything works
```

To use a custom data directory:

```bash
bash scripts/install.sh /your/custom/path
```

---

### Option 2: Manual Install

For users who want to understand each step.

**Step 1: Clone this repository**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

**Step 2: Create data directory and extract data**

```bash
mkdir -p ~/bible-data
tar xzf assets/bible-txt-file.tar.gz -C ~/bible-data --strip-components=1
```

**Step 3: Verify file count**

```bash
ls ~/bible-data/*.txt | wc -l
```

Should output `66`. If not, re-download this project.

**Step 4: Update the data path in the script**

Open `scripts/bible_search.py` and find this line near the top:

```python
BIBLE_DIR = os.path.expanduser("~/workspace/20260413/bible-txt-file")
```

Change it to your actual data path:

```python
BIBLE_DIR = os.path.expanduser("~/bible-data")
```

> 💡 You can also use an absolute path, e.g. `BIBLE_DIR = "/Users/yourname/bible-data"`

**Step 5: Verify installation**

```bash
# Test 1: List all 66 books
python3 scripts/bible_search.py list

# Test 2: Query a verse
python3 scripts/bible_search.py 创 1:1
# Expected: 【创世记 1:1】
#           1 起初　神创造天地。

# Test 3: Keyword search
python3 scripts/bible_search.py search 神爱世人
# Expected: Should include John 3:16

# Test 4: Book info
python3 scripts/bible_search.py info 诗篇
# Expected: 【诗篇】共 150 章，2461 节
```

All 4 tests passing means installation is successful!

---

### Option 3: Clone & Run

For developers who want to use the scripts directly without the install script:

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill

# Extract data (required before first run)
mkdir -p ~/bible-data
tar xzf assets/bible-txt-file.tar.gz -C ~/bible-data --strip-components=1

# Update BIBLE_DIR in scripts/bible_search.py, then:
python3 scripts/bible_search.py 创 1:1
```

---

## Usage

Basic command format:

```bash
python3 scripts/bible_search.py <command>
```

> 💡 The examples below assume you're in the project root directory. Otherwise, use the full path to the script.

### 1. List All 66 Books

```bash
python3 scripts/bible_search.py list
```

Example output:
```
旧约（39卷）:
   1 创世记
   2 出埃及记
   3 利未记
   ...
新约（27卷）:
  40 马太福音
  41 马可福音
  ...
```

### 2. View Book Info

Supports full Chinese names or abbreviations:

```bash
python3 scripts/bible_search.py info 创世记
python3 scripts/bible_search.py info 太
```

Example output:
```
【创世记】共 50 章，1533 节
【马太福音】共 28 章，1071 节
```

### 3. View an Entire Chapter

```bash
python3 scripts/bible_search.py 创世记 1
python3 scripts/bible_search.py 太 5
python3 scripts/bible_search.py 诗 23
```

Example output:
```
【诗篇 第23章】
1 耶和华是我的牧者，我必不至缺乏。
2 他使我躺卧在青草地上，领我在可安歇的水边。
...
```

### 4. View a Single Verse

Format: `BookName Chapter:Verse`

```bash
python3 scripts/bible_search.py 创 1:1
python3 scripts/bible_search.py 约 3:16
python3 scripts/bible_search.py 诗 23:1
```

Example output:
```
【约翰福音 3:16】
16 "　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
```

### 5. View a Verse Range

Format: `BookName Chapter:StartVerse-EndVerse`

```bash
python3 scripts/bible_search.py 太 5:3-12
python3 scripts/bible_search.py 创 1:1-5
```

Example output:
```
【马太福音 5:3-12】
3 虚心的人有福了！因为天国是他们的。
4 哀恸的人有福了！因为他们必得安慰。
...
```

### 6. Full-Text Search

Search across all 66 books for verses containing a keyword:

```bash
python3 scripts/bible_search.py search 耶和华是我的牧者
python3 scripts/bible_search.py search 神爱世人
python3 scripts/bible_search.py search 以马内利
```

Example output:
```
【约翰福音 3:16】"　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
【约翰一书 4:9】　神差他独生子到世间来，使我们借着他得生，　神爱我们的心在此就显明了。
...
```

> 💡 Search returns up to 20 results by default. To change this, open `scripts/bible_search.py`, find `search_bible(keyword, max_results=20)`, and change `20` to your desired number.

---

## Book Name Abbreviations

The tool supports both full Chinese names and common abbreviations:

### Old Testament (39 Books)

| Abbr | Full Name (Chinese) | English Name | Abbr | Full Name (Chinese) | English Name |
|------|---------------------|--------------|------|---------------------|--------------|
| 创 | 创世记 | Genesis | 拿 | 约拿书 | Jonah |
| 出 | 出埃及记 | Exodus | 弥 | 弥迦书 | Micah |
| 利 | 利未记 | Leviticus | 鸿 | 那鸿书 | Nahum |
| 民 | 民数记 | Numbers | 哈 | 哈巴谷书 | Habakkuk |
| 申 | 申命记 | Deuteronomy | 番 | 西番雅书 | Zephaniah |
| 书 | 约书亚记 | Joshua | 该 | 哈该书 | Haggai |
| 士 | 士师记 | Judges | 亚 | 撒迦利亚书 | Zechariah |
| 得 | 路得记 | Ruth | 玛 | 玛拉基书 | Malachi |
| 撒上 | 撒母耳记上 | 1 Samuel | 伯 | 约伯记 | Job |
| 撒下 | 撒母耳记下 | 2 Samuel | 诗 | 诗篇 | Psalms |
| 王上 | 列王纪上 | 1 Kings | 箴 | 箴言 | Proverbs |
| 王下 | 列王纪下 | 2 Kings | 传 | 传道书 | Ecclesiastes |
| 代上 | 历代志上 | 1 Chronicles | 歌 | 雅歌 | Song of Solomon |
| 代下 | 历代志下 | 2 Chronicles | 赛 | 以赛亚书 | Isaiah |
| 拉 | 以斯拉记 | Ezra | 耶 | 耶利米书 | Jeremiah |
| 尼 | 尼希米记 | Nehemiah | 哀 | 耶利米哀歌 | Lamentations |
| 斯 | 以斯帖记 | Esther | 结 | 以西结书 | Ezekiel |
| 何 | 何西阿书 | Hosea | 但 | 但以理书 | Daniel |
| 珥 | 约珥书 | Joel | 摩 | 阿摩司书 | Amos |
| 俄 | 俄巴底亚书 | Obadiah | | | |

### New Testament (27 Books)

| Abbr | Full Name (Chinese) | English Name | Abbr | Full Name (Chinese) | English Name |
|------|---------------------|--------------|------|---------------------|--------------|
| 太 | 马太福音 | Matthew | 提前 | 提摩太前书 | 1 Timothy |
| 可 | 马可福音 | Mark | 提后 | 提摩太后书 | 2 Timothy |
| 路 | 路加福音 | Luke | 多 | 提多书 | Titus |
| 约 | 约翰福音 | John | 门 | 腓利门书 | Philemon |
| 徒 | 使徒行传 | Acts | 来 | 希伯来书 | Hebrews |
| 罗 | 罗马书 | Romans | 雅 | 雅各书 | James |
| 林前 | 哥林多前书 | 1 Corinthians | 彼前 | 彼得前书 | 1 Peter |
| 林后 | 哥林多后书 | 2 Corinthians | 彼后 | 彼得后书 | 2 Peter |
| 加 | 加拉太书 | Galatians | 约一 | 约翰一书 | 1 John |
| 弗 | 以弗所书 | Ephesians | 约二 | 约翰二书 | 2 John |
| 腓 | 腓立比书 | Philippians | 约三 | 约翰三书 | 3 John |
| 西 | 歌罗西书 | Colossians | 犹 | 犹大书 | Jude |
| 帖前 | 帖撒罗尼迦前书 | 1 Thessalonians | 启 | 启示录 | Revelation |
| 帖后 | 帖撒罗尼迦后书 | 2 Thessalonians | | | |

---

## Data Format

This project uses the Chinese Union Version (和合本, CUV) Bible text, stored as 66 plain text files.

### File Naming

`Number+BookName.txt`, numbered 1–66:

```
1创世记.txt   2出埃及记.txt   3利未记.txt   ...   66启示录.txt
```

### File Content Format

Within each file, **each line represents one entire chapter**:

```
第X章1Verse one text2Verse two text3Verse three text...NLast verse text
```

Rules:
- Line starts with `第X章` (X is an Arabic numeral, e.g. `第1章`, `第23章`)
- Immediately followed by verse number (digits) + verse text
- **No space** between verse number and text
- After one verse ends, the next verse number follows immediately
- Each chapter occupies exactly one line (no line breaks within a chapter)
- File encoding: **UTF-8**

Real example (Genesis 1:1-5):

```
第1章1起初　神创造天地。2地是空虚混沌，渊面黑暗；　神的灵运行在水面上。3　神说："要有光。"就有了光。4　神看光是好的，就把光暗分开了。5　神称光为"昼"，称暗为"夜"。有晚上，有早晨，这是头一日。
```

If you have Bible data in a different format, see [SKILL.md](SKILL.md) for a conversion script.

---

## File Structure

```
bible-skill/
├── README.md                     ← This file (Chinese)
├── README_EN.md                  ← English documentation
├── LICENSE                       ← MIT License
├── SKILL.md                      ← Hermes Agent skill doc (detailed manual install guide)
├── .gitignore
├── assets/
│   └── bible-txt-file.tar.gz     ← Bible data archive (66 books, ~1.2 MB)
└── scripts/
    ├── bible_search.py           ← Core search script (Python 3, zero dependencies)
    └── install.sh                ← One-click install script
```

---

## Using with AI Agents

This project is designed to integrate with AI coding assistants, enabling AI to directly query and cite Bible verses. Below are setup guides for Claude Code, Hermes Agent, and OpenClaw.

### Claude Code

Claude Code is Anthropic's command-line AI coding assistant. You can teach it to use the Bible search skill via a CLAUDE.md file.

**Step 1: Install Bible Data**

```bash
# Clone the repo and run the install script
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

**Step 2: Create CLAUDE.md in your project root**

Create a `CLAUDE.md` file in your project root (or any working directory) with the following content:

```markdown
# Bible Search Tool

The Bible search tool is installed at /usr/local/share/bible-txt-file/.

To query Bible verses, run:

- List all 66 books: python3 /usr/local/share/bible-txt-file/bible_search.py list
- View book info: python3 /usr/local/share/bible-txt-file/bible_search.py info Genesis
- Read a chapter: python3 /usr/local/share/bible-txt-file/bible_search.py read Genesis 1
- Read a verse: python3 /usr/local/share/bible-txt-file/bible_search.py read Genesis 1 1
- Read a verse range: python3 /usr/local/share/bible-txt-file/bible_search.py read Genesis 1 1-5
- Full-text search: python3 /usr/local/share/bible-txt-file/bible_search.py search grace

Supports Chinese book names (创世记), abbreviations (创), and English names (Genesis). Use the terminal tool to execute commands.
```

**Step 3: Use**

Ask Claude Code in natural language:

```
> Look up John 3:16
> Search for Bible verses about "grace"
> List all books of the Bible
```

Claude Code will automatically call the search script based on the CLAUDE.md instructions.

> **Tip**: If the install path is not the default `/usr/local/share/bible-txt-file/`, replace the paths in CLAUDE.md with your actual path. Test with `python3 scripts/bible_search.py info Genesis` to verify it works.

---

### Hermes Agent

Hermes Agent has a built-in skill system — this repository is itself a skill package designed for Hermes.

**Option 1: Auto-load via SKILL.md (Recommended)**

1. Clone this repo into the Hermes skills directory:

```bash
git clone https://github.com/dockercore/bible-skill.git ~/.hermes/skills/bible
```

2. Hermes Agent automatically loads `~/.hermes/skills/bible/SKILL.md` on startup — no extra configuration needed.

3. Install the Bible data:

```bash
cd ~/.hermes/skills/bible
bash scripts/install.sh
```

4. Just talk to Hermes:

```
Look up Psalm 23
Search for Bible verses about "peace"
```

**Option 2: Custom Skill Path**

If you prefer a different location, add the skill path in your Hermes config:

```yaml
skills:
  - path: /your/custom/path/bible-skill/SKILL.md
```

Then run the install script:

```bash
cd /your/custom/path/bible-skill
bash scripts/install.sh
```

> **Tip**: SKILL.md already contains complete installation and usage instructions. Once Hermes loads it, it will automatically understand how to invoke the tool. If you change the install path, update the `BIBLE_DIR` variable in SKILL.md accordingly.

---

### OpenClaw

OpenClaw is an open-source AI Agent framework that supports integrating external capabilities via MCP (Model Context Protocol) or custom tools.

**Option 1: Custom Tool Integration**

1. Install the Bible data and search script:

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

2. Add the tool to your OpenClaw config file (typically `tools.yaml` or `config.yaml`):

```yaml
tools:
  - name: bible_search
    description: "Chinese Bible (Union Version) search tool. Supports verse lookup by book name and full-text keyword search."
    command: "python3"
    args:
      - "/usr/local/share/bible-txt-file/bible_search.py"
    parameters:
      - name: action
        type: string
        description: "Action: list (list books), info (book info), read (read verses), search (keyword search)"
        required: true
      - name: book
        type: string
        description: "Book name or abbreviation (e.g.: Genesis, Gen, 创世记, 创)"
        required: false
      - name: chapter
        type: integer
        description: "Chapter number"
        required: false
      - name: verse
        type: string
        description: "Verse number or range (e.g.: 1 or 1-5)"
        required: false
      - name: keyword
        type: string
        description: "Search keyword"
        required: false
```

3. Restart OpenClaw and use:

```
Please look up John 3:16
```

**Option 2: MCP Server Integration**

If you prefer the MCP approach, create a simple MCP Server wrapper:

1. Create `/usr/local/share/bible-txt-file/bible_mcp_server.py`:

```python
#!/usr/bin/env python3
"""Bible Search MCP Server for OpenClaw"""
import json
import sys
import subprocess

def handle_request(request):
    method = request.get("method", "")
    params = request.get("params", {})

    if method == "tools/list":
        return {
            "tools": [{
                "name": "bible_search",
                "description": "Chinese Bible (Union Version) search tool",
                "inputSchema": {
                    "type": "object",
                    "properties": {
                        "action": {"type": "string", "enum": ["list", "info", "read", "search"]},
                        "book": {"type": "string"},
                        "chapter": {"type": "integer"},
                        "verse": {"type": "string"},
                        "keyword": {"type": "string"}
                    },
                    "required": ["action"]
                }
            }]
        }
    elif method == "tools/call":
        args = params.get("arguments", {})
        cmd = ["python3", "/usr/local/share/bible-txt-file/bible_search.py"]
        action = args.get("action", "")
        cmd.append(action)
        if action == "info":
            cmd.append(args.get("book", ""))
        elif action == "read":
            cmd.append(args.get("book", ""))
            cmd.append(str(args.get("chapter", "")))
            if args.get("verse"):
                cmd.append(str(args["verse"]))
        elif action == "search":
            cmd.append(args.get("keyword", ""))
        result = subprocess.run(cmd, capture_output=True, text=True)
        return {"content": [{"type": "text", "text": result.stdout or result.stderr}]}

for line in sys.stdin:
    try:
        request = json.loads(line)
        response = {"jsonrpc": "2.0", "id": request.get("id"), "result": handle_request(request)}
    except Exception as e:
        response = {"jsonrpc": "2.0", "id": None, "error": {"code": -1, "message": str(e)}}
    print(json.dumps(response), flush=True)
```

2. Register the MCP Server in your OpenClaw config:

```yaml
mcp_servers:
  - name: bible-search
    command: "python3"
    args: ["/usr/local/share/bible-txt-file/bible_mcp_server.py"]
    transport: stdio
```

3. Restart OpenClaw — the AI can now query the Bible via the MCP protocol.

> **Tip**: Option 1 is simpler and great for quick setup; Option 2 is more standardized and better for multi-agent setups. Choose based on your needs.

---

## FAQ

### Q: `python3: command not found`

Python 3 is not installed. See [Requirements](#requirements) for installation instructions.

### Q: `No such file or directory`

The Bible data directory path is incorrect. Check the `BIBLE_DIR` variable in `scripts/bible_search.py` and make sure the directory exists and contains 66 .txt files.

### Q: `未找到卷名: xxx` (Book name not found)

The book name or abbreviation you entered is not in the mapping table. See [Book Name Abbreviations](#book-name-abbreviations), or add a custom abbreviation to the `BOOK_MAP` dictionary in `scripts/bible_search.py`.

### Q: Verse numbers are garbled or content is incomplete

The .txt file format is incorrect. Check against the [Data Format](#data-format) section.

### Q: `Permission denied`

The script doesn't have execute permission. Run:

```bash
chmod +x scripts/bible_search.py
```

### Q: Not enough search results

Search returns up to 20 results by default. Open `scripts/bible_search.py`, find `search_bible(keyword, max_results=20)`, and change `20` to your desired number.

---

## License

This project is licensed under the [MIT License](LICENSE).

```
MIT License

Copyright (c) 2026 dockercore

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

In short: you are free to use, copy, modify, merge, publish, distribute, sublicense, and/or sell this software, provided you include the copyright notice and license notice. The software is provided "as is", without warranty of any kind.
