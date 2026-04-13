# Chinees Bijbel Zoekhulpmiddel

[中文](README.md) | [English](README_EN.md) | Nederlands

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.6+](https://img.shields.io/badge/Python-3.6%2B-blue.svg)](https://www.python.org/)

Een lokale, offline Chinees Bijbel (Union Version / 和合本) zoekhulpmiddel. Zoek verzen op boeknaam, hoofdstuk, vers of trefwoord — geen afhankelijkheden, direct klaar voor gebruik.

---

## Inhoudsopgave

- [Functies](#functies)
- [Vereisten](#vereisten)
- [Installatie](#installatie)
  - [Optie 1: Één-klik installatie (Aanbevolen)](#optie-1-één-klik-installatie-aanbevolen)
  - [Optie 2: Handmatige installatie](#optie-2-handmatige-installatie)
  - [Optie 3: Klonen & uitvoeren](#optie-3-klonen--uitvoeren)
- [Gebruik](#gebruik)
  - [1. Alle 66 boeken weergeven](#1-alle-66-boeken-weergeven)
  - [2. Boekinformatie bekijken](#2-boekinformatie-bekijken)
  - [3. Een heel hoofdstuk bekijken](#3-een-heel-hoofdstuk-bekijken)
  - [4. Eén vers bekijken](#4-één-vers-bekijken)
  - [5. Een versbereik bekijken](#5-een-versbereik-bekijken)
  - [6. Volledige tekst doorzoeken](#6-volledige-tekst-doorzoeken)
- [Boeknaam-afkortingen](#boeknaam-afkortingen)
- [Gegevensformaat](#gegevensformaat)
- [Bestandsstructuur](#bestandsstructuur)
- [Gebruik met AI-agents](#gebruik-met-ai-agents)
  - [Claude Code](#claude-code)
  - [Hermes Agent](#hermes-agent)
  - [OpenClaw](#openclaw)
- [FAQ](#faq)
- [Licentie](#licentie)

---

## Functies

- 📖 Alle 66 boeken van de Bijbel weergeven
- 🔍 Verzen opzoeken op volledige naam of afkorting (heel hoofdstuk, één vers, versbereik)
- 🗂️ Boekinformatie bekijken (aantal hoofdstukken, aantal verzen)
- 🔎 Volledige tekst doorzoeken op trefwoord (geeft standaard maximaal 20 resultaten)
- 📦 Één-klik installatiescript met ingepakt gegevensarchief
- 🚀 Geen externe afhankelijkheden — alleen Python 3.6+ vereist

---

## Vereisten

| Item | Vereiste |
|------|----------|
| Python | 3.6 of hoger |
| Besturingssysteem | macOS / Linux / Windows |
| Schijfruimte | ~5 MB (gegevens + scripts) |
| Afhankelijkheden | Geen |

---

## Installatie

### Optie 1: Één-klik installatie (Aanbevolen)

Het beste voor beginners. Drie commando's en je bent klaar.

**Stap 1: Controleer of Python 3 is geïnstalleerd**

```bash
python3 --version
```

Als je `command not found` krijgt, installeer dan eerst Python 3:

| Systeem | Installatiemethode |
|----------|-------------------|
| macOS | `brew install python3` of download via [python.org](https://www.python.org/downloads/) |
| Ubuntu / Debian | `sudo apt update && sudo apt install python3` |
| Windows | Download via [python.org](https://www.python.org/downloads/) — **zorg ervoor dat je** "Add Python to PATH" aanvinkt tijdens de installatie |

**Stap 2: Kloon deze repository**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

> Geen git? Klik op de groene "Code"-knop op deze pagina → "Download ZIP", en pak het bestand uit.

**Stap 3: Voer het installatiescript uit**

```bash
bash scripts/install.sh
```

Het installatiescript voert automatisch de volgende stappen uit:

```
|[Step 1/6] Check Python 3           → Verify Python 3 is available
|[Step 2/6] Set Bible data directory  → Default: ~/bible-data/
|[Step 3/6] Extract Bible text data   → Unpack 66 .txt files from bundled archive
|[Step 4/6] Create skill directory    → Create ~/.hermes/skills/creative/bible/
|[Step 5/6] Configure search script   → Auto-update data path
|[Step 6/6] Verify installation       → Run 4 tests to confirm everything works
```

Om een aangepaste gegevensmap te gebruiken:

```bash
bash scripts/install.sh /your/custom/path
```

---

### Optie 2: Handmatige installatie

Voor gebruikers die elke stap willen begrijpen.

**Stap 1: Kloon deze repository**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

**Stap 2: Maak een gegevensmap aan en pak de gegevens uit**

```bash
mkdir -p ~/bible-data
tar xzf assets/bible-txt-file.tar.gz -C ~/bible-data --strip-components=1
```

**Stap 3: Controleer het aantal bestanden**

```bash
ls ~/bible-data/*.txt | wc -l
```

Dit moet `66` als uitvoer geven. Zo niet, download dit project opnieuw.

**Stap 4: Werk het gegevenspad in het script bij**

Open `scripts/bible_search.py` en zoek deze regel bovenaan:

```python
BIBLE_DIR = os.path.expanduser("~/workspace/20260413/bible-txt-file")
```

Wijzig dit in je werkelijke gegevenspad:

```python
BIBLE_DIR = os.path.expanduser("~/bible-data")
```

> 💡 Je kunt ook een absoluut pad gebruiken, bijv. `BIBLE_DIR = "/Users/yourname/bible-data"`

**Stap 5: Controleer de installatie**

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

Als alle 4 tests slagen, is de installatie succesvol!

---

### Optie 3: Klonen & uitvoeren

Voor ontwikkelaars die de scripts direct willen gebruiken zonder het installatiescript:

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

## Gebruik

Basiscommandoformaat:

```bash
python3 scripts/bible_search.py <command>
```

> 💡 De onderstaande voorbeelden gaan ervan uit dat je in de hoofdmap van het project staat. Gebruik anders het volledige pad naar het script.

### 1. Alle 66 boeken weergeven

```bash
python3 scripts/bible_search.py list
```

Voorbeelduitvoer:
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

### 2. Boekinformatie bekijken

Ondersteunt volledige Chinese namen of afkortingen:

```bash
python3 scripts/bible_search.py info 创世记
python3 scripts/bible_search.py info 太
```

Voorbeelduitvoer:
```
【创世记】共 50 章，1533 节
【马太福音】共 28 章，1071 节
```

### 3. Een heel hoofdstuk bekijken

```bash
python3 scripts/bible_search.py 创世记 1
python3 scripts/bible_search.py 太 5
python3 scripts/bible_search.py 诗 23
```

Voorbeelduitvoer:
```
【诗篇 第23章】
1 耶和华是我的牧者，我必不至缺乏。
2 他使我躺卧在青草地上，领我在可安歇的水边。
...
```

### 4. Eén vers bekijken

Formaat: `Boeknaam Hoofdstuk:Vers`

```bash
python3 scripts/bible_search.py 创 1:1
python3 scripts/bible_search.py 约 3:16
python3 scripts/bible_search.py 诗 23:1
```

Voorbeelduitvoer:
```
【约翰福音 3:16】
16 "　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
```

### 5. Een versbereik bekijken

Formaat: `Boeknaam Hoofdstuk:Beginvers-Eindvers`

```bash
python3 scripts/bible_search.py 太 5:3-12
python3 scripts/bible_search.py 创 1:1-5
```

Voorbeelduitvoer:
```
【马太福音 5:3-12】
3 虚心的人有福了！因为天国是他们的。
4 哀恸的人有福了！因为他们必得安慰。
...
```

### 6. Volledige tekst doorzoeken

Doorzoek alle 66 boeken naar verzen die een trefwoord bevatten:

```bash
python3 scripts/bible_search.py search 耶和华是我的牧者
python3 scripts/bible_search.py search 神爱世人
python3 scripts/bible_search.py search 以马内利
```

Voorbeelduitvoer:
```
【约翰福音 3:16】"　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
【约翰一书 4:9】　神差他独生子到世间来，使我们借着他得生，　神爱我们的心在此就显明了。
...
```

> 💡 De zoekfunctie geeft standaard maximaal 20 resultaten. Om dit te wijzigen, open `scripts/bible_search.py`, zoek `search_bible(keyword, max_results=20)`, en wijzig `20` in het gewenste aantal.

---

## Boeknaam-afkortingen

Het hulpmiddel ondersteunt zowel volledige Chinese namen als gangbare afkortingen:

### Oude Testament (39 boeken)

| Afk. | Volledige naam (Chinees) | Engelse naam | Afk. | Volledige naam (Chinees) | Engelse naam |
|------|--------------------------|--------------|------|--------------------------|--------------|
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

### Nieuwe Testament (27 boeken)

| Afk. | Volledige naam (Chinees) | Engelse naam | Afk. | Volledige naam (Chinees) | Engelse naam |
|------|--------------------------|--------------|------|--------------------------|--------------|
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

## Gegevensformaat

Dit project gebruikt de Chinese Union Version (和合本, CUV) Bijbeltekst, opgeslagen als 66 platte-tekstbestanden.

### Bestandsnaamgeving

`Nummer+Boeknaam.txt`, genummerd 1–66:

```
1创世记.txt   2出埃及记.txt   3利未记.txt   ...   66启示录.txt
```

### Bestandsinhoudformaat

Binnen elk bestand vertegenwoordigt **elke regel één compleet hoofdstuk**:

```
第X章1Verse one text2Verse two text3Verse three text...NLast verse text
```

Regels:
- Regel begint met `第X章` (X is een Arabisch cijfer, bijv. `第1章`, `第23章`)
- Direct gevolgd door versnummer (cijfers) + verstekst
- **Geen spatie** tussen versnummer en tekst
- Nadat één vers eindigt, volgt het volgende versnummer direct
- Elk hoofdstuk beslaat precies één regel (geen regeleinden binnen een hoofdstuk)
- Bestandscodering: **UTF-8**

Werkelijk voorbeeld (Genesis 1:1-5):

```
第1章1起初　神创造天地。2地是空虚混沌，渊面黑暗；　神的灵运行在水面上。3　神说："要有光。"就有了光。4　神看光是好的，就把光暗分开了。5　神称光为"昼"，称暗为"夜"。有晚上，有早晨，这是头一日。
```

Als je Bijbelgegevens in een ander formaat hebt, zie [SKILL.md](SKILL.md) voor een conversiescript.

---

## Bestandsstructuur

```
bible-skill/
├── README.md                     ← Dit bestand (Chinees)
├── README_EN.md                  ← Engelse documentatie
├── README_NL.md                  ← Nederlandse documentatie
├── LICENSE                       ← MIT-licentie
├── SKILL.md                      ← Hermes Agent skill-document (gedetailleerde handleiding voor handmatige installatie)
├── .gitignore
├── assets/
│   └── bible-txt-file.tar.gz     ← Bijbelgegevensarchief (66 boeken, ~1,2 MB)
└── scripts/
    ├── bible_search.py           ← Kernzoekscript (Python 3, geen afhankelijkheden)
    └── install.sh                ← Één-klik installatiescript
```

---

## Gebruik met AI-agents

Dit project is ontworpen om te integreren met AI-codeerassistants, zodat AI direct Bijbelverzen kan opzoeken en citeren. Hieronder staan installatiehandleidingen voor Claude Code, Hermes Agent en OpenClaw.

### Claude Code

Claude Code is de opdrachtregel-AI-codeerassistent van Anthropic. Je kunt het leren de Bijbelzoekfunctie te gebruiken via een CLAUDE.md-bestand.

**Stap 1: Installeer Bijbelgegevens**

```bash
# Clone the repo and run the install script
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

**Stap 2: Maak CLAUDE.md aan in de hoofdmap van je project**

Maak een `CLAUDE.md`-bestand aan in de hoofdmap van je project (of een andere werkmap) met de volgende inhoud:

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

**Stap 3: Gebruik**

Vraag Claude Code in natuurlijke taal:

```
> Look up John 3:16
> Search for Bible verses about "grace"
> List all books of the Bible
```

Claude Code zal automatisch het zoekscript aanroepen op basis van de instructies in CLAUDE.md.

> **Tip**: Als het installatiepad niet het standaardpad `/usr/local/share/bible-txt-file/` is, vervang dan de paden in CLAUDE.md door je werkelijke pad. Test met `python3 scripts/bible_search.py info Genesis` om te verifiëren dat het werkt.

---

### Hermes Agent

Hermes Agent heeft een ingebouwd vaardighedensysteem — deze repository is zelf een vaardigheidspakket ontworpen voor Hermes.

**Optie 1: Automatisch laden via SKILL.md (Aanbevolen)**

1. Kloon deze repository in de Hermes-vaardighedensmap:

```bash
git clone https://github.com/dockercore/bible-skill.git ~/.hermes/skills/bible
```

2. Hermes Agent laadt automatisch `~/.hermes/skills/bible/SKILL.md` bij het opstarten — geen extra configuratie nodig.

3. Installeer de Bijbelgegevens:

```bash
cd ~/.hermes/skills/bible
bash scripts/install.sh
```

4. Praat gewoon met Hermes:

```
Look up Psalm 23
Search for Bible verses about "peace"
```

**Optie 2: Aangepast vaardigheidspad**

Als je een andere locatie prefereert, voeg dan het vaardigheidspad toe in je Hermes-configuratie:

```yaml
skills:
  - path: /your/custom/path/bible-skill/SKILL.md
```

Voer vervolgens het installatiescript uit:

```bash
cd /your/custom/path/bible-skill
bash scripts/install.sh
```

> **Tip**: SKILL.md bevat al volledige installatie- en gebruiks instructies. Zodra Hermes het laadt, begrijpt het automatisch hoe het hulpmiddel aan te roepen. Als je het installatiepad wijzigt, werk dan de variabele `BIBLE_DIR` in SKILL.md dienovereenkomstig bij.

---

### OpenClaw

OpenClaw is een opensource AI Agent-framework dat het integreren van externe mogelijkheden via MCP (Model Context Protocol) of aangepaste hulpmiddelen ondersteunt.

**Optie 1: Aangepaste hulpmiddelintegratie**

1. Installeer de Bijbelgegevens en het zoekscript:

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

2. Voeg het hulpmiddel toe aan je OpenClaw-configuratiebestand (meestal `tools.yaml` of `config.yaml`):

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

3. Herstart OpenClaw en gebruik:

```
Please look up John 3:16
```

**Optie 2: MCP-serverintegratie**

Als je de MCP-aanpak prefereert, maak dan een eenvoudige MCP-serverwrapper:

1. Maak `/usr/local/share/bible-txt-file/bible_mcp_server.py` aan:

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

2. Registreer de MCP-server in je OpenClaw-configuratie:

```yaml
mcp_servers:
  - name: bible-search
    command: "python3"
    args: ["/usr/local/share/bible-txt-file/bible_mcp_server.py"]
    transport: stdio
```

3. Herstart OpenClaw — de AI kan nu de Bijbel doorzoeken via het MCP-protocol.

> **Tip**: Optie 1 is eenvoudiger en ideaal voor snelle installatie; Optie 2 is meer gestandaardiseerd en beter voor multi-agent-opstellingen. Kies op basis van je behoeften.

---

## FAQ

### V: `python3: command not found`

Python 3 is niet geïnstalleerd. Zie [Vereisten](#vereisten) voor installatie-instructies.

### V: `No such file or directory`

Het pad naar de Bijbelgegevensmap is onjuist. Controleer de variabele `BIBLE_DIR` in `scripts/bible_search.py` en zorg ervoor dat de map bestaat en 66 .txt-bestanden bevat.

### V: `未找到卷名: xxx` (Boeknaam niet gevonden)

De ingevoerde boeknaam of afkorting bevindt zich niet in de toewijzingstabel. Zie [Boeknaam-afkortingen](#boeknaam-afkortingen), of voeg een aangepaste afkorting toe aan het `BOOK_MAP`-woordenboek in `scripts/bible_search.py`.

### V: Versnummers zijn onleesbaar of de inhoud is onvolledig

Het .txt-bestandsformaat is onjuist. Controleer dit aan de hand van de sectie [Gegevensformaat](#gegevensformaat).

### V: `Permission denied`

Het script heeft geen uitvoerrechten. Voer uit:

```bash
chmod +x scripts/bible_search.py
```

### V: Niet genoeg zoekresultaten

De zoekfunctie geeft standaard maximaal 20 resultaten. Open `scripts/bible_search.py`, zoek `search_bible(keyword, max_results=20)`, en wijzig `20` in het gewenste aantal.

---

## Licentie

Dit project is gelicentieerd onder de [MIT-licentie](LICENSE).

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

Kort samengevat: je bent vrij om deze software te gebruiken, kopiëren, wijzigen, samenvoegen, publiceren, distribueren, in sublicentie te geven en/of te verkopen, op voorwaarde dat je de copyrightvermelding en licentievermelding opneemt. De software wordt geleverd "zoals het is", zonder enige garantie.
