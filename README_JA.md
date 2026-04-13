# 中国語聖書検索ツール

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.6+](https://img.shields.io/badge/Python-3.6%2B-blue.svg)](https://www.python.org/)

[中文](README.md) | [English](README_EN.md) | 日本語

ローカル・オフラインで動作する中国語聖書（和合本 / Union Version）検索ツール。書名、章、節、キーワードで聖句を検索 — 外部依存なし、すぐに使えます。

---

## 目次

- [機能](#機能)
- [要件](#要件)
- [インストール](#インストール)
  - [方法1：ワンクリックインストール（推奨）](#方法1ワンクリックインストール推奨)
  - [方法2：手動インストール](#方法2手動インストール)
  - [方法3：クローンして実行](#方法3クローンして実行)
- [使い方](#使い方)
  - [1. 66書の一覧表示](#1-66書の一覧表示)
  - [2. 書物情報の表示](#2-書物情報の表示)
  - [3. 章全体の表示](#3-章全体の表示)
  - [4. 単一の節の表示](#4-単一の節の表示)
  - [5. 節の範囲表示](#5-節の範囲表示)
  - [6. 全文検索](#6-全文検索)
- [書名の略称](#書名の略称)
- [データ形式](#データ形式)
- [ファイル構成](#ファイル構成)
- [AIエージェントとの連携](#aiエージェントとの連携)
  - [Claude Code](#claude-code)
  - [Hermes Agent](#hermes-agent)
  - [OpenClaw](#openclaw)
- [FAQ](#faq)
- [ライセンス](#ライセンス)

---

## 機能

- 📖 聖書全66書の一覧表示
- 🔍 書名（正式名称・略称）で聖句を検索（章全体、単一の節、節の範囲）
- 🗂️ 書物情報の表示（章数、節数）
- 🔎 全文キーワード検索（デフォルトで最大20件の結果を返す）
- 📦 データアーカイブ同梱のワンクリックインストールスクリプト
- 🚀 サードパーティ依存なし — Python 3.6+ のみ必要

---

## 要件

| 項目 | 要件 |
|------|------|
| Python | 3.6 以上 |
| OS | macOS / Linux / Windows |
| ディスク容量 | 約5 MB（データ＋スクリプト） |
| 依存パッケージ | なし |

---

## インストール

### 方法1：ワンクリックインストール（推奨）

初心者向け。3つのコマンドで完了します。

**ステップ1：Python 3がインストールされていることを確認**

```bash
python3 --version
```

`command not found` と表示された場合、先にPython 3をインストールしてください：

| システム | インストール方法 |
|----------|------------------|
| macOS | `brew install python3` または [python.org](https://www.python.org/downloads/) からダウンロード |
| Ubuntu / Debian | `sudo apt update && sudo apt install python3` |
| Windows | [python.org](https://www.python.org/downloads/) からダウンロード — インストール時に「Add Python to PATH」に**必ずチェック**を入れてください |

**ステップ2：このリポジトリをクローン**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

> gitがない場合？このページの緑色の「Code」ボタン → 「Download ZIP」をクリックし、解凍してください。

**ステップ3：インストールスクリプトを実行**

```bash
bash scripts/install.sh
```

インストールスクリプトは以下のステップを自動的に実行します：

```
[Step 1/6] Check Python 3           → Python 3が利用可能か確認
[Step 2/6] Set Bible data directory  → デフォルト: ~/bible-data/
[Step 3/6] Extract Bible text data   → 同梱アーカイブから66の.txtファイルを展開
[Step 4/6] Create skill directory    → ~/.hermes/skills/creative/bible/ を作成
[Step 5/6] Configure search script   → データパスを自動更新
[Step 6/6] Verify installation       → 4つのテストを実行して動作確認
```

カスタムデータディレクトリを使用する場合：

```bash
bash scripts/install.sh /your/custom/path
```

---

### 方法2：手動インストール

各ステップを理解したいユーザー向け。

**ステップ1：このリポジトリをクローン**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

**ステップ2：データディレクトリを作成してデータを展開**

```bash
mkdir -p ~/bible-data
tar xzf assets/bible-txt-file.tar.gz -C ~/bible-data --strip-components=1
```

**ステップ3：ファイル数を確認**

```bash
ls ~/bible-data/*.txt | wc -l
```

`66` と出力されるはずです。そうでない場合は、このプロジェクトを再ダウンロードしてください。

**ステップ4：スクリプト内のデータパスを更新**

`scripts/bible_search.py` を開き、先頭付近の以下の行を見つけてください：

```python
BIBLE_DIR = os.path.expanduser("~/workspace/20260413/bible-txt-file")
```

実際のデータパスに変更してください：

```python
BIBLE_DIR = os.path.expanduser("~/bible-data")
```

> 💡 絶対パスも使用できます（例：`BIBLE_DIR = "/Users/yourname/bible-data"`）

**ステップ5：インストールの確認**

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

4つのテストすべてが通れば、インストールは成功です！

---

### 方法3：クローンして実行

インストールスクリプトを使わずにスクリプトを直接使いたい開発者向け：

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

## 使い方

基本的なコマンド形式：

```bash
python3 scripts/bible_search.py <command>
```

> 💡 以下の例はプロジェクトのルートディレクトリにいることを前提としています。そうでない場合は、スクリプトへのフルパスを使用してください。

### 1. 66書の一覧表示

```bash
python3 scripts/bible_search.py list
```

出力例：
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

### 2. 書物情報の表示

中国語の正式名称または略称に対応：

```bash
python3 scripts/bible_search.py info 创世记
python3 scripts/bible_search.py info 太
```

出力例：
```
【创世记】共 50 章，1533 节
【马太福音】共 28 章，1071 节
```

### 3. 章全体の表示

```bash
python3 scripts/bible_search.py 创世记 1
python3 scripts/bible_search.py 太 5
python3 scripts/bible_search.py 诗 23
```

出力例：
```
【诗篇 第23章】
1 耶和华是我的牧者，我必不至缺乏。
2 他使我躺卧在青草地上，领我在可安歇的水边。
...
```

### 4. 単一の節の表示

形式：`書名 章:節`

```bash
python3 scripts/bible_search.py 创 1:1
python3 scripts/bible_search.py 约 3:16
python3 scripts/bible_search.py 诗 23:1
```

出力例：
```
【约翰福音 3:16】
16 "　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
```

### 5. 節の範囲表示

形式：`書名 章:開始節-終了節`

```bash
python3 scripts/bible_search.py 太 5:3-12
python3 scripts/bible_search.py 创 1:1-5
```

出力例：
```
【马太福音 5:3-12】
3 虚心的人有福了！因为天国是他们的。
4 哀恸的人有福了！因为他们必得安慰。
...
```

### 6. 全文検索

全66書からキーワードを含む聖句を検索：

```bash
python3 scripts/bible_search.py search 耶和华是我的牧者
python3 scripts/bible_search.py search 神爱世人
python3 scripts/bible_search.py search 以马内利
```

出力例：
```
【约翰福音 3:16】"　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
【约翰一书 4:9】　神差他独生子到世间来，使我们借着他得生，　神爱我们的心在此就显明了。
...
```

> 💡 検索はデフォルトで最大20件の結果を返します。変更するには、`scripts/bible_search.py` を開き、`search_bible(keyword, max_results=20)` の `20` を希望の数に変更してください。

---

## 書名の略称

このツールは中国語の正式名称と一般的な略称の両方に対応しています：

### 旧約聖書（39書）

| 略称 | 正式名称（中国語） | 英語名 | 略称 | 正式名称（中国語） | 英語名 |
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

### 新約聖書（27書）

| 略称 | 正式名称（中国語） | 英語名 | 略称 | 正式名称（中国語） | 英語名 |
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

## データ形式

このプロジェクトは中国語和合本（CUV）の聖書テキストを使用し、66のプレーンテキストファイルとして保存されています。

### ファイル命名

`番号+書名.txt`、1〜66の番号付き：

```
1创世记.txt   2出埃及记.txt   3利未记.txt   ...   66启示录.txt
```

### ファイル内容の形式

各ファイル内で、**1行が1つの章全体**を表します：

```
第X章1Verse one text2Verse two text3Verse three text...NLast verse text
```

ルール：
- 行は `第X章` で始まる（Xはアラビア数字、例：`第1章`、`第23章`）
- その直後に節番号（数字）+ 節のテキストが続く
- 節番号とテキストの間に**スペースなし**
- 1つの節が終わると、すぐに次の節番号が続く
- 各章は正確に1行（章内に改行なし）
- ファイルエンコーディング：**UTF-8**

実際の例（創世記 1:1-5）：

```
第1章1起初　神创造天地。2地是空虚混沌，渊面黑暗；　神的灵运行在水面上。3　神说："要有光。"就有了光。4　神看光是好的，就把光暗分开了。5　神称光为"昼"，称暗为"夜"。有晚上，有早晨，这是头一日。
```

異なる形式の聖書データをお持ちの場合は、[SKILL.md](SKILL.md) の変換スクリプトを参照してください。

---

## ファイル構成

```
bible-skill/
├── README.md                     ← このファイル（中国語）
├── README_EN.md                  ← 英語ドキュメント
├── README_JA.md                  ← 日本語ドキュメント
├── LICENSE                       ← MIT License
├── SKILL.md                      ← Hermes Agentスキルドキュメント（手動インストールの詳細ガイド）
├── .gitignore
├── assets/
│   └── bible-txt-file.tar.gz     ← 聖書データアーカイブ（66書、約1.2 MB）
└── scripts/
    ├── bible_search.py           ← コア検索スクリプト（Python 3、依存なし）
    └── install.sh                ← ワンクリックインストールスクリプト
```

---

## AIエージェントとの連携

このプロジェクトはAIコーディングアシスタントとの統合を想定して設計されており、AIが聖句を直接検索・引用できるようにします。以下にClaude Code、Hermes Agent、OpenClawのセットアップガイドを示します。

### Claude Code

Claude CodeはAnthropicのCLI AIコーディングアシスタントです。CLAUDE.mdファイルを使って聖書検索スキルを教えることができます。

**ステップ1：聖書データをインストール**

```bash
# Clone the repo and run the install script
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

**ステップ2：プロジェクトルートにCLAUDE.mdを作成**

プロジェクトルート（または任意の作業ディレクトリ）に `CLAUDE.md` ファイルを作成し、以下の内容を記述します：

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

**ステップ3：使用する**

自然言語でClaude Codeに質問します：

```
> Look up John 3:16
> Search for Bible verses about "grace"
> List all books of the Bible
```

Claude CodeはCLAUDE.mdの指示に基づいて自動的に検索スクリプトを呼び出します。

> **ヒント**: インストールパスがデフォルトの `/usr/local/share/bible-txt-file/` でない場合、CLAUDE.md内のパスを実際のパスに置き換えてください。`python3 scripts/bible_search.py info Genesis` で動作確認できます。

---

### Hermes Agent

Hermes Agentにはビルトインのスキルシステムがあり、このリポジトリ自体がHermes向けに設計されたスキルパッケージです。

**方法1：SKILL.mdによる自動ロード（推奨）**

1. このリポジトリをHermesスキルディレクトリにクローン：

```bash
git clone https://github.com/dockercore/bible-skill.git ~/.hermes/skills/bible
```

2. Hermes Agentは起動時に自動的に `~/.hermes/skills/bible/SKILL.md` をロードします — 追加の設定は不要です。

3. 聖書データをインストール：

```bash
cd ~/.hermes/skills/bible
bash scripts/install.sh
```

4. Hermesに話しかけるだけ：

```
Look up Psalm 23
Search for Bible verses about "peace"
```

**方法2：カスタムスキルパス**

別の場所を使用したい場合、Hermes設定にスキルパスを追加します：

```yaml
skills:
  - path: /your/custom/path/bible-skill/SKILL.md
```

その後、インストールスクリプトを実行：

```bash
cd /your/custom/path/bible-skill
bash scripts/install.sh
```

> **ヒント**: SKILL.mdにはインストールと使用方法の完全な手順が既に含まれています。Hermesがロードすると、ツールの呼び出し方を自動的に理解します。インストールパスを変更した場合は、SKILL.md内の `BIBLE_DIR` 変数も適宜更新してください。

---

### OpenClaw

OpenClawは、MCP（Model Context Protocol）またはカスタムツールを通じて外部機能の統合をサポートするオープンソースAIエージェントフレームワークです。

**方法1：カスタムツール統合**

1. 聖書データと検索スクリプトをインストール：

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

2. OpenClawの設定ファイル（通常は `tools.yaml` または `config.yaml`）にツールを追加：

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

3. OpenClawを再起動して使用：

```
Please look up John 3:16
```

**方法2：MCPサーバー統合**

MCPアプローチを好む場合は、シンプルなMCPサーバーラッパーを作成します：

1. `/usr/local/share/bible-txt-file/bible_mcp_server.py` を作成：

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

2. OpenClawの設定にMCPサーバーを登録：

```yaml
mcp_servers:
  - name: bible-search
    command: "python3"
    args: ["/usr/local/share/bible-txt-file/bible_mcp_server.py"]
    transport: stdio
```

3. OpenClawを再起動 — AIがMCPプロトコル経由で聖書を検索できるようになります。

> **ヒント**: 方法1はシンプルで迅速なセットアップに適しています。方法2はより標準化されており、マルチエージェント構成に適しています。用途に応じて選択してください。

---

## FAQ

### Q: `python3: command not found`

Python 3がインストールされていません。[要件](#要件)のインストール手順を参照してください。

### Q: `No such file or directory`

聖書データディレクトリのパスが正しくありません。`scripts/bible_search.py` の `BIBLE_DIR` 変数を確認し、ディレクトリが存在し、66の.txtファイルが含まれていることを確認してください。

### Q: `未找到卷名: xxx`（書名が見つかりません）

入力した書名または略称がマッピングテーブルにありません。[書名の略称](#書名の略称)を参照するか、`scripts/bible_search.py` の `BOOK_MAP` 辞書にカスタム略称を追加してください。

### Q: 節番号が文字化けする、または内容が不完全

.txtファイルの形式が正しくありません。[データ形式](#データ形式)のセクションに照らして確認してください。

### Q: `Permission denied`

スクリプトに実行権限がありません。以下を実行してください：

```bash
chmod +x scripts/bible_search.py
```

### Q: 検索結果が足りない

検索はデフォルトで最大20件の結果を返します。`scripts/bible_search.py` を開き、`search_bible(keyword, max_results=20)` の `20` を希望の数に変更してください。

---

## ライセンス

このプロジェクトは[MIT License](LICENSE)の下でライセンスされています。

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

要するに：著作権表示とライセンス表示を含める条件で、このソフトウェアの使用、複製、変更、統合、公開、配布、サブライセンス、販売を自由に行うことができます。本ソフトウェアは「現状のまま」提供され、いかなる種類の保証も伴いません。
