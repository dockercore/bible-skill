# 中文圣经经文查询技能 (Bible Skill)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.6+](https://img.shields.io/badge/Python-3.6%2B-blue.svg)](https://www.python.org/)

[English](README_EN.md) | [Español](README_ES.md) | [Français](README_FR.md) | [Deutsch](README_DE.md) | [日本語](README_JA.md) | [한국어](README_KO.md) | [Português](README_PT.md) | [Русский](README_RU.md) | [العربية](README_AR.md) | [Italiano](README_IT.md) | [Nederlands](README_NL.md)

基于本地 66 卷中文和合本圣经纯文本文件，提供经文查询、检索和引用功能。零依赖，开箱即用。

---

## 目录

- [功能特性](#功能特性)
- [系统要求](#系统要求)
- [安装指南](#安装指南)
  - [方式一：一键安装（推荐）](#方式一一键安装推荐)
  - [方式二：手动安装](#方式二手动安装)
  - [方式三：克隆本仓库](#方式三克隆本仓库)
  - [方式四：通过 skills.sh 安装](#方式四通过-skillssh-安装)
- [使用方法](#使用方法)
  - [列出全部 66 卷](#1-列出全部-66-卷)
  - [查看某卷信息](#2-查看某卷信息章数节数)
  - [查看整章](#3-查看整章)
  - [查看某一节](#4-查看某一节)
  - [查看节范围](#5-查看节范围)
  - [全文搜索](#6-全文搜索关键词)
- [卷名简称对照表](#卷名简称对照表)
- [数据格式说明](#数据格式说明)
- [文件结构](#文件结构)
- [在 AI Agent 中使用](#在-ai-agent-中使用)
  - [Claude Code](#claude-code)
  - [Hermes Agent](#hermes-agent)
  - [OpenClaw](#openclaw)
- [常见问题](#常见问题)
- [⭐ Star History](#-star-history)
- [开源协议](#开源协议)

---

## 功能特性

- 📖 列出全部 66 卷圣经书卷
- 🔍 按卷名/简称查询经文（支持整章、单节、节范围）
- 🗂️ 查看某卷信息（章数、节数）
- 🔎 全文关键词搜索（默认最多返回 20 条）
- 📦 一键安装脚本，自带圣经数据压缩包
- 🚀 零第三方依赖，仅需 Python 3.6+

---

## 系统要求

| 项目 | 要求 |
|------|------|
| Python | 3.6 或更高版本 |
| 操作系统 | macOS / Linux / Windows |
| 磁盘空间 | 约 5MB（数据 + 脚本） |
| 第三方依赖 | 无 |

---

## 安装指南

### 方式一：一键安装（推荐）

适合小白用户，3 条命令搞定。

**第 1 步：确认 Python 3 已安装**

```bash
python3 --version
```

如果报错 `command not found`，请先安装 Python 3：

| 系统 | 安装命令 |
|------|---------|
| macOS | `brew install python3` 或从 [python.org](https://www.python.org/downloads/) 下载 |
| Ubuntu / Debian | `sudo apt update && sudo apt install python3` |
| Windows | 从 [python.org](https://www.python.org/downloads/) 下载，安装时 **务必勾选** "Add Python to PATH" |

**第 2 步：下载本项目**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

> 如果你没有 git，也可以点击本页面绿色的 "Code" 按钮 → "Download ZIP"，下载后解压。

**第 3 步：运行安装脚本**

```bash
bash scripts/install.sh
```

安装脚本会自动完成以下操作：

```
[步骤 1/6] 检查 Python 3           → 确认 Python 3 可用
[步骤 2/6] 设置圣经数据目录         → 默认 ~/bible-data/
[步骤 3/6] 解压圣经文本数据         → 从自带数据包解压 66 个 .txt 文件
[步骤 4/6] 创建 skill 目录结构      → 创建 ~/.hermes/skills/creative/bible/
[步骤 5/6] 配置搜索脚本             → 自动更新数据路径
[步骤 6/6] 验证安装                 → 运行 4 项测试确认正常
```

如果想自定义数据存放路径：

```bash
bash scripts/install.sh /你/想/放/的/路径
```

---

### 方式二：手动安装

适合想了解每一步细节的用户。

**第 1 步：下载本项目**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

**第 2 步：创建数据目录并解压数据**

```bash
mkdir -p ~/bible-data
tar xzf assets/bible-txt-file.tar.gz -C ~/bible-data --strip-components=1
```

**第 3 步：确认数据文件数量**

```bash
ls ~/bible-data/*.txt | wc -l
```

应输出 `66`。如果不是 66，说明解压有问题，请重新下载本项目。

**第 4 步：修改脚本中的数据路径**

打开 `scripts/bible_search.py`，找到文件开头附近的这一行：

```python
BIBLE_DIR = os.path.expanduser("~/workspace/20260413/bible-txt-file")
```

改为你的实际数据路径：

```python
BIBLE_DIR = os.path.expanduser("~/bible-data")
```

> 💡 提示：也可以使用绝对路径，如 `BIBLE_DIR = "/Users/你的用户名/bible-data"`

**第 5 步：验证安装**

```bash
# 测试 1：列出66卷
python3 scripts/bible_search.py list

# 测试 2：查询经文
python3 scripts/bible_search.py 创 1:1
# 预期输出：【创世记 1:1】
#           1 起初　神创造天地。

# 测试 3：关键词搜索
python3 scripts/bible_search.py search 神爱世人
# 预期输出：应包含约翰福音3:16的经文

# 测试 4：查看卷信息
python3 scripts/bible_search.py info 诗篇
# 预期输出：【诗篇】共 150 章，2461 节
```

4 个测试全部通过，说明安装成功！

---

### 方式三：克隆本仓库

如果你是开发者，想直接使用仓库中的脚本（不使用安装脚本）：

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill

# 直接运行（数据包在 assets/ 目录下，需先解压）
mkdir -p ~/bible-data
tar xzf assets/bible-txt-file.tar.gz -C ~/bible-data --strip-components=1

# 修改 scripts/bible_search.py 中的 BIBLE_DIR 路径后即可使用
python3 scripts/bible_search.py 创 1:1
```

---

### 方式四：通过 skills.sh 安装

如果你使用支持 [skills.sh](https://skills.sh) 的 AI Agent（如 Claude Code、Cline、Cursor 等），可以通过一条命令安装：

```bash
npx skills add dockercore/bible-skill
```

安装完成后，AI Agent 会自动识别圣经查询技能，你可以直接用自然语言提问：

```
帮我查一下约翰福音3章16节
搜索圣经中关于"恩典"的经文
```

> **提示**：此方式需要先确保 Python 3 已安装，且安装后需运行 `bash scripts/install.sh` 解压圣经数据。详见 [skills.sh](https://skills.sh) 文档。

---

## 使用方法

所有命令的基本格式：

```bash
python3 scripts/bible_search.py <命令>
```

> 💡 以下示例假设你在项目根目录下运行。如果不在，请使用脚本的完整路径。

### 1. 列出全部 66 卷

```bash
python3 scripts/bible_search.py list
```

输出示例：
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

### 2. 查看某卷信息（章数、节数）

支持中文全名或简称：

```bash
python3 scripts/bible_search.py info 创世记
python3 scripts/bible_search.py info 太
```

输出示例：
```
【创世记】共 50 章，1533 节
【马太福音】共 28 章，1071 节
```

### 3. 查看整章

```bash
python3 scripts/bible_search.py 创世记 1
python3 scripts/bible_search.py 太 5
python3 scripts/bible_search.py 诗 23
```

输出示例：
```
【诗篇 第23章】
1 耶和华是我的牧者，我必不至缺乏。
2 他使我躺卧在青草地上，领我在可安歇的水边。
...
```

### 4. 查看某一节

格式：`卷名 章号:节号`

```bash
python3 scripts/bible_search.py 创 1:1
python3 scripts/bible_search.py 约 3:16
python3 scripts/bible_search.py 诗 23:1
```

输出示例：
```
【约翰福音 3:16】
16 "　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
```

### 5. 查看节范围

格式：`卷名 章号:起始节-结束节`

```bash
python3 scripts/bible_search.py 太 5:3-12
python3 scripts/bible_search.py 创 1:1-5
```

输出示例：
```
【马太福音 5:3-12】
3 虚心的人有福了！因为天国是他们的。
4 哀恸的人有福了！因为他们必得安慰。
...
```

### 6. 全文搜索关键词

在整个圣经 66 卷中搜索包含指定关键词的经文：

```bash
python3 scripts/bible_search.py search 耶和华是我的牧者
python3 scripts/bible_search.py search 神爱世人
python3 scripts/bible_search.py search 以马内利
```

输出示例：
```
【约翰福音 3:16】"　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
【约翰一书 4:9】　神差他独生子到世间来，使我们借着他得生，　神爱我们的心在此就显明了。
...
```

> 💡 搜索默认最多返回 20 条结果。如需更多，打开 `scripts/bible_search.py`，找到 `search_bible(keyword, max_results=20)` 这行，将 `20` 改为你需要的数字。

---

## 卷名简称对照表

支持中文全名和常见简称查询：

### 旧约（39卷）

| 简称 | 全名 | 简称 | 全名 | 简称 | 全名 |
|------|------|------|------|------|------|
| 创 | 创世记 | 撒上 | 撒母耳记上 | 传 | 传道书 |
| 出 | 出埃及记 | 撒下 | 撒母耳记下 | 歌 | 雅歌 |
| 利 | 利未记 | 王上 | 列王纪上 | 赛 | 以赛亚书 |
| 民 | 民数记 | 王下 | 列王纪下 | 耶 | 耶利米书 |
| 申 | 申命记 | 代上 | 历代志上 | 哀 | 耶利米哀歌 |
| 书 | 约书亚记 | 代下 | 历代志下 | 结 | 以西结书 |
| 士 | 士师记 | 拉 | 以斯拉记 | 但 | 但以理书 |
| 得 | 路得记 | 尼 | 尼希米记 | 何 | 何西阿书 |
| | | 斯 | 以斯帖记 | 珥 | 约珥书 |
| | | 伯 | 约伯记 | 摩 | 阿摩司书 |
| | | 诗 | 诗篇 | 俄 | 俄巴底亚书 |
| | | 箴 | 箴言 | 拿 | 约拿书 |
| | | | | 弥 | 弥迦书 |
| | | | | 鸿 | 那鸿书 |
| | | | | 哈 | 哈巴谷书 |
| | | | | 番 | 西番雅书 |
| | | | | 该 | 哈该书 |
| | | | | 亚 | 撒迦利亚书 |
| | | | | 玛 | 玛拉基书 |

### 新约（27卷）

| 简称 | 全名 | 简称 | 全名 | 简称 | 全名 |
|------|------|------|------|------|------|
| 太 | 马太福音 | 罗 | 罗马书 | 帖前 | 帖撒罗尼迦前书 |
| 可 | 马可福音 | 林前 | 哥林多前书 | 帖后 | 帖撒罗尼迦后书 |
| 路 | 路加福音 | 林后 | 哥林多后书 | 提前 | 提摩太前书 |
| 约 | 约翰福音 | 加 | 加拉太书 | 提后 | 提摩太后书 |
| 徒 | 使徒行传 | 弗 | 以弗所书 | 多 | 提多书 |
| | | 腓 | 腓立比书 | 门 | 腓利门书 |
| | | 西 | 歌罗西书 | 来 | 希伯来书 |
| | | | | 雅 | 雅各书 |
| | | | | 彼前 | 彼得前书 |
| | | | | 彼后 | 彼得后书 |
| | | | | 约一 | 约翰一书 |
| | | | | 约二 | 约翰二书 |
| | | | | 约三 | 约翰三书 |
| | | | | 犹 | 犹大书 |
| | | | | 启 | 启示录 |

---

## 数据格式说明

本项目使用的圣经数据为中文和合本（Chinese Union Version, CUV），存储为 66 个纯文本文件。

### 文件命名

`编号+卷名.txt`，编号 1-66：

```
1创世记.txt   2出埃及记.txt   3利未记.txt   ...   66启示录.txt
```

### 文件内容格式

每个文件中，**每一行对应一整章**，格式为：

```
第X章1第一节经文2第二节经文3第三节经文...N最后一节经文
```

规则：
- 行首 `第X章`（X 为阿拉伯数字，如 `第1章`、`第23章`）
- 紧跟节号（纯数字）+ 该节经文内容
- 节号与经文之间**无空格**
- 上一节经文结束后，紧跟下一节节号
- 每章独占一行
- 文件编码 **UTF-8**

真实示例（创世记第1章第1-5节）：

```
第1章1起初　神创造天地。2地是空虚混沌，渊面黑暗；　神的灵运行在水面上。3　神说："要有光。"就有了光。4　神看光是好的，就把光暗分开了。5　神称光为"昼"，称暗为"夜"。有晚上，有早晨，这是头一日。
```

如果你有自己的圣经数据但格式不同，可以使用本项目提供的转换脚本（见 [SKILL.md](SKILL.md) 中的详细说明）。

---

## 文件结构

```
bible-skill/
├── README.md                     ← 本文件（中文安装 + 使用文档）
├── README_EN.md                  ← English documentation
├── README_ES.md                  ← Documentación en Español
├── README_FR.md                  ← Documentation en Français
├── README_DE.md                  ← Dokumentation auf Deutsch
├── README_JA.md                  ← 日本語ドキュメント
├── README_KO.md                  ← 한국어 문서
├── README_PT.md                  ← Documentação em Português
├── README_RU.md                  ← Документация на Русском
├── README_AR.md                  ← التوثيق بالعربية
├── README_IT.md                  ← Documentazione in Italiano
├── README_NL.md                  ← Nederlandse documentatie
├── LICENSE                       ← MIT 开源协议
├── SKILL.md                      ← Hermes Agent 技能文档（含详细手动安装指南）
├── .gitignore
├── assets/
│   └── bible-txt-file.tar.gz     ← 圣经数据压缩包（66卷，约1.2MB）
└── scripts/
    ├── bible_search.py           ← 核心搜索脚本（Python 3，零依赖）
    └── install.sh                ← 一键安装脚本
```

---

## 在 AI Agent 中使用

本项目特别适合与 AI 编程助手集成，让 AI 能直接查询和引用圣经经文。以下分别介绍在 Claude Code、Hermes Agent 和 OpenClaw 中的使用方式。

### Claude Code

Claude Code 是 Anthropic 推出的命令行 AI 编程助手。通过 CLAUDE.md 文件可以让 Claude Code 了解如何使用圣经查询技能。

**步骤 1：安装圣经数据**

```bash
# 克隆仓库并运行安装脚本
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

**步骤 2：在项目根目录创建 CLAUDE.md**

在你的项目根目录（或任意工作目录）创建 `CLAUDE.md` 文件，写入以下内容：

```markdown
# Bible Search Tool

圣经查询工具已安装在 /usr/local/share/bible-txt-file/ 目录下。

查询经文时，运行以下命令：

- 列出全部66卷: python3 /usr/local/share/bible-txt-file/bible_search.py list
- 查看某卷信息: python3 /usr/local/share/bible-txt-file/bible_search.py info 创世记
- 查看整章: python3 /usr/local/share/bible-txt-file/bible_search.py read 创世记 1
- 查看某一节: python3 /usr/local/share/bible-txt-file/bible_search.py read 创世记 1 1
- 查看节范围: python3 /usr/local/share/bible-txt-file/bible_search.py read 创世记 1 1-5
- 全文搜索: python3 /usr/local/share/bible-txt-file/bible_search.py search 爱

支持中文卷名(创世记)和简称(创、创世记、Genesis)。使用 terminal 工具执行命令。
```

**步骤 3：使用**

在 Claude Code 中直接用自然语言提问：

```
> 帮我查一下约翰福音3章16节
> 搜索圣经中关于"恩典"的经文
> 列出圣经的所有书卷
```

Claude Code 会根据 CLAUDE.md 中的指引自动调用搜索脚本。

> **提示**：如果安装路径不是默认的 `/usr/local/share/bible-txt-file/`，请将 CLAUDE.md 中的路径替换为实际路径。可通过 `python3 scripts/bible_search.py info 创世记` 测试是否正常工作。

---

### Hermes Agent

Hermes Agent 内置技能系统（Skills），本仓库本身就是为 Hermes 设计的技能包。

**方式一：通过 SKILL.md 自动加载（推荐）**

1. 将本仓库克隆到 Hermes 技能目录：

```bash
git clone https://github.com/dockercore/bible-skill.git ~/.hermes/skills/bible
```

2. Hermes Agent 启动后会自动加载 `~/.hermes/skills/bible/SKILL.md`，无需额外配置。

3. 安装圣经数据：

```bash
cd ~/.hermes/skills/bible
bash scripts/install.sh
```

4. 直接对 Hermes 说：

```
查一下诗篇23篇
搜索圣经中"平安"相关的经文
```

**方式二：手动指定技能路径**

如果不想放在默认技能目录，可以在 Hermes 配置文件中添加技能路径：

```yaml
skills:
  - path: /your/custom/path/bible-skill/SKILL.md
```

然后运行安装脚本：

```bash
cd /your/custom/path/bible-skill
bash scripts/install.sh
```

> **提示**：SKILL.md 中已包含完整的安装指引和使用方法，Hermes 加载后即可自动理解如何调用。如果修改了安装路径，请同步更新 SKILL.md 中的 `BIBLE_DIR` 变量。

---

### OpenClaw

OpenClaw 是一个开源的 AI Agent 框架，支持通过 MCP (Model Context Protocol) 或自定义工具集成外部能力。

**方式一：作为自定义工具集成**

1. 安装圣经数据和搜索脚本：

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

2. 在 OpenClaw 的工具配置文件（通常为 `tools.yaml` 或 `config.yaml`）中添加：

```yaml
tools:
  - name: bible_search
    description: "中文圣经和合本查询工具。支持按卷名查询经文、全文关键词搜索。"
    command: "python3"
    args:
      - "/usr/local/share/bible-txt-file/bible_search.py"
    parameters:
      - name: action
        type: string
        description: "操作类型：list(列书卷), info(卷信息), read(读经文), search(搜索)"
        required: true
      - name: book
        type: string
        description: "书卷名或简称（如：创世记、创、Genesis）"
        required: false
      - name: chapter
        type: integer
        description: "章号"
        required: false
      - name: verse
        type: string
        description: "节号或节范围（如：1 或 1-5）"
        required: false
      - name: keyword
        type: string
        description: "搜索关键词"
        required: false
```

3. 重启 OpenClaw 后即可使用：

```
请帮我查约翰福音3章16节的经文
```

**方式二：通过 MCP Server 集成**

如果你更倾向于 MCP 方式，可以创建一个简单的 MCP Server 包装器：

1. 创建文件 `/usr/local/share/bible-txt-file/bible_mcp_server.py`：

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
                "description": "中文圣经和合本查询工具",
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

2. 在 OpenClaw 配置中注册 MCP Server：

```yaml
mcp_servers:
  - name: bible-search
    command: "python3"
    args: ["/usr/local/share/bible-txt-file/bible_mcp_server.py"]
    transport: stdio
```

3. 重启 OpenClaw，AI 即可通过 MCP 协议调用圣经查询功能。

> **提示**：方式一配置更简单，适合快速上手；方式二更规范，适合需要多 Agent 共享工具的场景。请根据实际需求选择。

---

## 常见问题

### Q: 运行脚本报 `python3: command not found`

你的系统没有安装 Python 3。请参考 [系统要求](#系统要求) 中的安装方法。

### Q: 运行脚本报 `No such file or directory`

圣经数据目录路径不对。检查 `scripts/bible_search.py` 中的 `BIBLE_DIR` 变量，确保指向的目录存在且包含 66 个 .txt 文件。

### Q: 报 `未找到卷名: xxx`

你输入的卷名或简称不在映射表中。查看 [卷名简称对照表](#卷名简称对照表)，或打开 `scripts/bible_search.py` 中的 `BOOK_MAP` 字典添加自定义简称。

### Q: 经文节号错乱

.txt 文件格式不对。请对照 [数据格式说明](#数据格式说明) 检查。

### Q: 报 `Permission denied`

脚本没有执行权限，运行：

```bash
chmod +x scripts/bible_search.py
```

### Q: 搜索结果不够多

搜索默认最多返回 20 条。打开 `scripts/bible_search.py`，找到 `search_bible(keyword, max_results=20)`，将 `20` 改为你需要的数字。

---

## ⭐ Star History

[![Star History Chart](https://api.star-history.com/svg?repos=dockercore/bible-skill&type=Date)](https://star-history.com/#dockercore/bible-skill&Date)

---

## 开源协议

本项目基于 [MIT 协议](LICENSE) 开源。

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

简而言之：你可以自由使用、复制、修改、合并、发布、分发、再授权和/或销售本软件，只需保留版权声明和许可声明。本软件按"原样"提供，不作任何担保。
