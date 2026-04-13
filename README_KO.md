# 중국어 성경 검색 스킬

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.6+](https://img.shields.io/badge/Python-3.6%2B-blue.svg)](https://www.python.org/)

[中文](README.md) | [English](README_EN.md) | 한국어

로컬 오프라인 중국어 성경(화합본 / 和合本) 검색 도구입니다. 책 이름, 장, 절 또는 키워드로 구절을 검색하세요 — 의존성 제로, 바로 사용 가능합니다.

---

## 목차

- [기능](#기능)
- [요구 사항](#요구-사항)
- [설치](#설치)
  - [방법 1: 원클릭 설치 (권장)](#방법-1-원클릭-설치-권장)
  - [방법 2: 수동 설치](#방법-2-수동-설치)
  - [방법 3: 복제 후 실행](#방법-3-복제-후-실행)
- [사용법](#사용법)
  - [1. 66권 전체 목록 보기](#1-66권-전체-목록-보기)
  - [2. 책 정보 보기](#2-책-정보-보기)
  - [3. 장 전체 보기](#3-장-전체-보기)
  - [4. 단일 구절 보기](#4-단일-구절-보기)
  - [5. 구절 범위 보기](#5-구절-범위-보기)
  - [6. 전체 텍스트 검색](#6-전체-텍스트-검색)
- [책 이름 약어](#책-이름-약어)
- [데이터 형식](#데이터-형식)
- [파일 구조](#파일-구조)
- [AI 에이전트와 함께 사용하기](#ai-에이전트와-함께-사용하기)
  - [Claude Code](#claude-code)
  - [Hermes Agent](#hermes-agent)
  - [OpenClaw](#openclaw)
- [자주 묻는 질문](#자주-묻는-질문)
- [라이선스](#라이선스)

---

## 기능

- 📖 성경 66권 전체 목록 보기
- 🔍 전체 이름 또는 약어로 구절 검색 (장 전체, 단일 구절, 구절 범위)
- 🗂️ 책 정보 보기 (장 수, 절 수)
- 🔎 전체 텍스트 키워드 검색 (기본적으로 최대 20개 결과 반환)
- 📦 데이터 아카이브가 포함된 원클릭 설치 스크립트
- 🚀 타사 의존성 제로 — Python 3.6+만 필요

---

## 요구 사항

| 항목 | 요구 사항 |
|------|-----------|
| Python | 3.6 이상 |
| OS | macOS / Linux / Windows |
| 디스크 공간 | 약 5MB (데이터 + 스크립트) |
| 의존성 | 없음 |

---

## 설치

### 방법 1: 원클릭 설치 (권장)

초보자에게 가장 적합합니다. 세 개의 명령어로 완료됩니다.

**1단계: Python 3 설치 확인**

```bash
python3 --version
```

`command not found`가 표시되면 Python 3를 먼저 설치하세요:

| 시스템 | 설치 방법 |
|--------|-----------|
| macOS | `brew install python3` 또는 [python.org](https://www.python.org/downloads/)에서 다운로드 |
| Ubuntu / Debian | `sudo apt update && sudo apt install python3` |
| Windows | [python.org](https://www.python.org/downloads/)에서 다운로드 — 설치 시 "Add Python to PATH" **반드시 체크** |

**2단계: 이 저장소 복제**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

> git이 없나요? 이 페이지의 녹색 "Code" 버튼 → "Download ZIP"을 클릭한 후 압축을 푸세요.

**3단계: 설치 스크립트 실행**

```bash
bash scripts/install.sh
```

설치 스크립트는 다음 단계를 자동으로 수행합니다:

```
|[Step 1/6] Check Python 3           → Verify Python 3 is available
|[Step 2/6] Set Bible data directory  → Default: ~/bible-data/
|[Step 3/6] Extract Bible text data   → Unpack 66 .txt files from bundled archive
|[Step 4/6] Create skill directory    → Create ~/.hermes/skills/creative/bible/
|[Step 5/6] Configure search script   → Auto-update data path
|[Step 6/6] Verify installation       → Run 4 tests to confirm everything works
```

사용자 지정 데이터 디렉토리를 사용하려면:

```bash
bash scripts/install.sh /your/custom/path
```

---

### 방법 2: 수동 설치

각 단계를 직접 이해하고 싶은 사용자를 위한 방법입니다.

**1단계: 이 저장소 복제**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

**2단계: 데이터 디렉토리 생성 및 데이터 압축 해제**

```bash
mkdir -p ~/bible-data
tar xzf assets/bible-txt-file.tar.gz -C ~/bible-data --strip-components=1
```

**3단계: 파일 수 확인**

```bash
ls ~/bible-data/*.txt | wc -l
```

`66`이 출력되어야 합니다. 그렇지 않으면 이 프로젝트를 다시 다운로드하세요.

**4단계: 스크립트의 데이터 경로 수정**

`scripts/bible_search.py`를 열고 상단 근처의 다음 줄을 찾으세요:

```python
BIBLE_DIR = os.path.expanduser("~/workspace/20260413/bible-txt-file")
```

실제 데이터 경로로 변경하세요:

```python
BIBLE_DIR = os.path.expanduser("~/bible-data")
```

> 💡 절대 경로를 사용할 수도 있습니다. 예: `BIBLE_DIR = "/Users/yourname/bible-data"`

**5단계: 설치 확인**

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

4개 테스트가 모두 통과하면 설치가 성공적으로 완료된 것입니다!

---

### 방법 3: 복제 후 실행

설치 스크립트 없이 스크립트를 직접 사용하려는 개발자를 위한 방법입니다:

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

## 사용법

기본 명령어 형식:

```bash
python3 scripts/bible_search.py <command>
```

> 💡 아래 예제는 프로젝트 루트 디렉토리에 있다고 가정합니다. 그렇지 않은 경우 스크립트의 전체 경로를 사용하세요.

### 1. 66권 전체 목록 보기

```bash
python3 scripts/bible_search.py list
```

출력 예시:
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

### 2. 책 정보 보기

중국어 전체 이름 또는 약어를 지원합니다:

```bash
python3 scripts/bible_search.py info 创世记
python3 scripts/bible_search.py info 太
```

출력 예시:
```
【创世记】共 50 章，1533 节
【马太福音】共 28 章，1071 节
```

### 3. 장 전체 보기

```bash
python3 scripts/bible_search.py 创世记 1
python3 scripts/bible_search.py 太 5
python3 scripts/bible_search.py 诗 23
```

출력 예시:
```
【诗篇 第23章】
1 耶和华是我的牧者，我必不至缺乏。
2 他使我躺卧在青草地上，领我在可安歇的水边。
...
```

### 4. 단일 구절 보기

형식: `책이름 장:절`

```bash
python3 scripts/bible_search.py 创 1:1
python3 scripts/bible_search.py 约 3:16
python3 scripts/bible_search.py 诗 23:1
```

출력 예시:
```
【约翰福音 3:16】
16 "　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
```

### 5. 구절 범위 보기

형식: `책이름 장:시작절-끝절`

```bash
python3 scripts/bible_search.py 太 5:3-12
python3 scripts/bible_search.py 创 1:1-5
```

출력 예시:
```
【马太福音 5:3-12】
3 虚心的人有福了！因为天国是他们的。
4 哀恸的人有福了！因为他们必得安慰。
...
```

### 6. 전체 텍스트 검색

66권 전체에서 키워드가 포함된 구절을 검색합니다:

```bash
python3 scripts/bible_search.py search 耶和华是我的牧者
python3 scripts/bible_search.py search 神爱世人
python3 scripts/bible_search.py search 以马内利
```

출력 예시:
```
【约翰福音 3:16】"　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
【约翰一书 4:9】　神差他独生子到世间来，使我们借着他得生，　神爱我们的心在此就显明了。
...
```

> 💡 검색은 기본적으로 최대 20개 결과를 반환합니다. 변경하려면 `scripts/bible_search.py`를 열고 `search_bible(keyword, max_results=20)`을 찾아 `20`을 원하는 숫자로 변경하세요.

---

## 책 이름 약어

이 도구는 중국어 전체 이름과 일반적인 약어를 모두 지원합니다:

### 구약성경 (39권)

| 약어 | 전체 이름 (중국어) | 영어 이름 | 약어 | 전체 이름 (중국어) | 영어 이름 |
|------|---------------------|-----------|------|---------------------|-----------|
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

### 신약성경 (27권)

| 약어 | 전체 이름 (중국어) | 영어 이름 | 약어 | 전체 이름 (중국어) | 영어 이름 |
|------|---------------------|-----------|------|---------------------|-----------|
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

## 데이터 형식

이 프로젝트는 중국어 화합본(和合本, CUV) 성경 텍스트를 사용하며, 66개의 일반 텍스트 파일로 저장됩니다.

### 파일 명명 규칙

`번호+책이름.txt`, 1~66으로 번호가 매겨집니다:

```
1创世记.txt   2出埃及记.txt   3利未记.txt   ...   66启示录.txt
```

### 파일 내용 형식

각 파일 내에서 **각 줄은 하나의 장 전체를 나타냅니다**:

```
第X章1Verse one text2Verse two text3Verse three text...NLast verse text
```

규칙:
- 줄은 `第X章`으로 시작 (X는 아라비아 숫자, 예: `第1章`, `第23章`)
- 바로 뒤에 절 번호(숫자) + 절 텍스트가 따라옴
- 절 번호와 텍스트 사이에 **공백 없음**
- 한 절이 끝나면 바로 다음 절 번호가 이어짐
- 각 장은 정확히 한 줄을 차지 (장 내에 줄바꿈 없음)
- 파일 인코딩: **UTF-8**

실제 예시 (창세기 1:1-5):

```
第1章1起初　神创造天地。2地是空虚混沌，渊面黑暗；　神的灵运行在水面上。3　神说："要有光。"就有了光。4　神看光是好的，就把光暗分开了。5　神称光为"昼"，称暗为"夜"。有晚上，有早晨，这是头一日。
```

다른 형식의 성경 데이터가 있는 경우 변환 스크립트는 [SKILL.md](SKILL.md)를 참조하세요.

---

## 파일 구조

```
bible-skill/
├── README.md                     ← 중국어 문서
├── README_EN.md                  ← 영어 문서
├── README_KO.md                  ← 한국어 문서
├── LICENSE                       ← MIT 라이선스
├── SKILL.md                      ← Hermes Agent 스킬 문서 (상세 수동 설치 가이드)
├── .gitignore
├── assets/
│   └── bible-txt-file.tar.gz     ← 성경 데이터 아카이브 (66권, 약 1.2MB)
└── scripts/
    ├── bible_search.py           ← 핵심 검색 스크립트 (Python 3, 의존성 제로)
    └── install.sh                ← 원클릭 설치 스크립트
```

---

## AI 에이전트와 함께 사용하기

이 프로젝트는 AI 코딩 어시스턴트와 통합되도록 설계되어, AI가 성경 구절을 직접 검색하고 인용할 수 있습니다. 아래는 Claude Code, Hermes Agent, OpenClaw에 대한 설정 가이드입니다.

### Claude Code

Claude Code는 Anthropic의 명령줄 AI 코딩 어시스턴트입니다. CLAUDE.md 파일을 통해 성경 검색 스킬을 사용하도록 가르칠 수 있습니다.

**1단계: 성경 데이터 설치**

```bash
# Clone the repo and run the install script
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

**2단계: 프로젝트 루트에 CLAUDE.md 생성**

프로젝트 루트(또는 작업 디렉토리)에 `CLAUDE.md` 파일을 다음 내용으로 생성합니다:

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

**3단계: 사용**

자연어로 Claude Code에게 요청하세요:

```
> Look up John 3:16
> Search for Bible verses about "grace"
> List all books of the Bible
```

Claude Code는 CLAUDE.md의 지침에 따라 자동으로 검색 스크립트를 호출합니다.

> **팁**: 설치 경로가 기본 `/usr/local/share/bible-txt-file/`이 아닌 경우, CLAUDE.md의 경로를 실제 경로로 교체하세요. `python3 scripts/bible_search.py info Genesis`로 테스트하여 작동하는지 확인하세요.

---

### Hermes Agent

Hermes Agent는 내장 스킬 시스템을 갖추고 있습니다 — 이 저장소 자체가 Hermes를 위해 설계된 스킬 패키지입니다.

**방법 1: SKILL.md를 통한 자동 로드 (권장)**

1. 이 저장소를 Hermes 스킬 디렉토리에 복제합니다:

```bash
git clone https://github.com/dockercore/bible-skill.git ~/.hermes/skills/bible
```

2. Hermes Agent는 시작 시 `~/.hermes/skills/bible/SKILL.md`를 자동으로 로드합니다 — 추가 설정이 필요 없습니다.

3. 성경 데이터를 설치합니다:

```bash
cd ~/.hermes/skills/bible
bash scripts/install.sh
```

4. Hermes에게 말만 걸면 됩니다:

```
Look up Psalm 23
Search for Bible verses about "peace"
```

**방법 2: 사용자 지정 스킬 경로**

다른 위치를 선호하는 경우, Hermes 설정에 스킬 경로를 추가하세요:

```yaml
skills:
  - path: /your/custom/path/bible-skill/SKILL.md
```

그런 다음 설치 스크립트를 실행하세요:

```bash
cd /your/custom/path/bible-skill
bash scripts/install.sh
```

> **팁**: SKILL.md에는 이미 완전한 설치 및 사용 지침이 포함되어 있습니다. Hermes가 로드하면 도구 호출 방법을 자동으로 이해합니다. 설치 경로를 변경한 경우 SKILL.md의 `BIBLE_DIR` 변수도 그에 맞게 업데이트하세요.

---

### OpenClaw

OpenClaw는 MCP(모델 컨텍스트 프로토콜) 또는 사용자 지정 도구를 통해 외부 기능을 통합하는 오픈소스 AI 에이전트 프레임워크입니다.

**방법 1: 사용자 지정 도구 통합**

1. 성경 데이터와 검색 스크립트를 설치합니다:

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

2. OpenClaw 설정 파일(일반적으로 `tools.yaml` 또는 `config.yaml`)에 도구를 추가합니다:

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

3. OpenClaw를 재시작하고 사용합니다:

```
Please look up John 3:16
```

**방법 2: MCP 서버 통합**

MCP 방식을 선호하는 경우, 간단한 MCP 서버 래퍼를 생성합니다:

1. `/usr/local/share/bible-txt-file/bible_mcp_server.py`를 생성합니다:

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

2. OpenClaw 설정에 MCP 서버를 등록합니다:

```yaml
mcp_servers:
  - name: bible-search
    command: "python3"
    args: ["/usr/local/share/bible-txt-file/bible_mcp_server.py"]
    transport: stdio
```

3. OpenClaw를 재시작하면 — AI가 이제 MCP 프로토콜을 통해 성경을 검색할 수 있습니다.

> **팁**: 방법 1이 더 간단하고 빠른 설정에 적합합니다; 방법 2는 더 표준화되어 다중 에이전트 환경에 적합합니다. 필요에 따라 선택하세요.

---

## 자주 묻는 질문

### 질문: `python3: command not found`

Python 3가 설치되지 않았습니다. [요구 사항](#요구-사항)의 설치 지침을 참조하세요.

### 질문: `No such file or directory`

성경 데이터 디렉토리 경로가 올바르지 않습니다. `scripts/bible_search.py`의 `BIBLE_DIR` 변수를 확인하고 디렉토리가 존재하며 66개의 .txt 파일이 포함되어 있는지 확인하세요.

### 질문: `未找到卷名: xxx` (책 이름을 찾을 수 없음)

입력한 책 이름 또는 약어가 매핑 테이블에 없습니다. [책 이름 약어](#책-이름-약어)를 참조하거나, `scripts/bible_search.py`의 `BOOK_MAP` 사전에 사용자 지정 약어를 추가하세요.

### 질문: 절 번호가 깨지거나 내용이 불완전합니다

.txt 파일 형식이 올바르지 않습니다. [데이터 형식](#데이터-형식) 섹션을 확인하세요.

### 질문: `Permission denied`

스크립트에 실행 권한이 없습니다. 다음을 실행하세요:

```bash
chmod +x scripts/bible_search.py
```

### 질문: 검색 결과가 부족합니다

검색은 기본적으로 최대 20개 결과를 반환합니다. `scripts/bible_search.py`를 열고 `search_bible(keyword, max_results=20)`을 찾아 `20`을 원하는 숫자로 변경하세요.

---

## 라이선스

이 프로젝트는 [MIT 라이선스](LICENSE)에 따라 라이선스가 부여됩니다.

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

요약하자면: 저작권 공지와 라이선스 공지를 포함하는 조건으로 이 소프트웨어를 자유롭게 사용, 복사, 수정, 병합, 게시, 배포, 재라이선스 및/또는 판매할 수 있습니다. 이 소프트웨어는 어떠한 종류의 보증도 없이 "있는 그대로" 제공됩니다.
