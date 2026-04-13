# Chinesische Bibelsuch-Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.6+](https://img.shields.io/badge/Python-3.6%2B-blue.svg)](https://www.python.org/)

[中文](README.md) | [English](README_EN.md) | Deutsch

Ein lokales, Offline-Chinesische-Bibel-Suchwerkzeug (Union-Version / 和合本). Abfrage von Versen nach Buchname, Kapitel, Vers oder Schlüsselwort — null Abhängigkeiten, sofort einsatzbereit.

---

## Inhaltsverzeichnis

- [Funktionen](#funktionen)
- [Voraussetzungen](#voraussetzungen)
- [Installation](#installation)
  - [Option 1: Ein-Klick-Installation (Empfohlen)](#option-1-ein-klick-installation-empfohlen)
  - [Option 2: Manuelle Installation](#option-2-manuelle-installation)
  - [Option 3: Klonen & Ausführen](#option-3-klonen--ausführen)
- [Verwendung](#verwendung)
  - [1. Alle 66 Bücher auflisten](#1-alle-66-bücher-auflisten)
  - [2. Buchinformationen anzeigen](#2-buchinformationen-anzeigen)
  - [3. Ein ganzes Kapitel anzeigen](#3-ein-ganzes-kapitel-anzeigen)
  - [4. Einen einzelnen Vers anzeigen](#4-einen-einzelnen-vers-anzeigen)
  - [5. Einen Versbereich anzeigen](#5-einen-versbereich-anzeigen)
  - [6. Volltextsuche](#6-volltextsuche)
- [Buchnamen-Abkürzungen](#buchnamen-abkürzungen)
- [Datenformat](#datenformat)
- [Dateistruktur](#dateistruktur)
- [Verwendung mit KI-Agenten](#verwendung-mit-ki-agenten)
  - [Claude Code](#claude-code)
  - [Hermes Agent](#hermes-agent)
  - [OpenClaw](#openclaw)
- [FAQ](#faq)
- [Lizenz](#lizenz)

---

## Funktionen

- 📖 Alle 66 Bücher der Bibel auflisten
- 🔍 Verse nach vollem Namen oder Abkürzung abfragen (ganzes Kapitel, einzelner Vers, Versbereich)
- 🗂️ Buchinformationen anzeigen (Kapitelanzahl, Versanzahl)
- 🔎 Volltext-Schlüsselwortsuche (liefert standardmäßig bis zu 20 Ergebnisse)
- 📦 Ein-Klick-Installationsskript mit integriertem Datenarchiv
- 🚀 Keine Drittanbieter-Abhängigkeiten — nur Python 3.6+ erforderlich

---

## Voraussetzungen

| Element | Anforderung |
|---------|-------------|
| Python | 3.6 oder höher |
| Betriebssystem | macOS / Linux / Windows |
| Speicherplatz | ~5 MB (Daten + Skripte) |
| Abhängigkeiten | Keine |

---

## Installation

### Option 1: Ein-Klick-Installation (Empfohlen)

Am besten für Einsteiger. Drei Befehle und Sie sind fertig.

**Schritt 1: Überprüfen Sie, ob Python 3 installiert ist**

```bash
python3 --version
```

Wenn Sie `command not found` erhalten, installieren Sie zuerst Python 3:

| System | Installationsmethode |
|--------|----------------------|
| macOS | `brew install python3` oder Download von [python.org](https://www.python.org/downloads/) |
| Ubuntu / Debian | `sudo apt update && sudo apt install python3` |
| Windows | Download von [python.org](https://www.python.org/downloads/) — **achten Sie darauf**, während der Installation „Add Python to PATH" zu aktivieren |

**Schritt 2: Dieses Repository klonen**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

> Kein git? Klicken Sie auf den grünen „Code"-Button auf dieser Seite → „Download ZIP", dann entpacken.

**Schritt 3: Das Installationsskript ausführen**

```bash
bash scripts/install.sh
```

Das Installationsskript führt folgende Schritte automatisch aus:

```
[Schritt 1/6] Python 3 prüfen           → Überprüfen, ob Python 3 verfügbar ist
[Schritt 2/6] Bibeldatenverzeichnis setzen  → Standard: ~/bible-data/
[Schritt 3/6] Bibeltextdaten entpacken   → 66 .txt-Dateien aus dem integrierten Archiv entpacken
[Schritt 4/6] Skill-Verzeichnis erstellen    → ~/.hermes/skills/creative/bible/ erstellen
[Schritt 5/6] Suchskript konfigurieren   → Datenpfad automatisch aktualisieren
[Schritt 6/6] Installation überprüfen       → 4 Tests ausführen, um alles zu bestätigen
```

Um ein benutzerdefiniertes Datenverzeichnis zu verwenden:

```bash
bash scripts/install.sh /ihr/benutzerdefinierter/pfad
```

---

### Option 2: Manuelle Installation

Für Benutzer, die jeden Schritt verstehen möchten.

**Schritt 1: Dieses Repository klonen**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

**Schritt 2: Datenverzeichnis erstellen und Daten entpacken**

```bash
mkdir -p ~/bible-data
tar xzf assets/bible-txt-file.tar.gz -C ~/bible-data --strip-components=1
```

**Schritt 3: Dateianzahl überprüfen**

```bash
ls ~/bible-data/*.txt | wc -l
```

Sollte `66` ausgeben. Wenn nicht, laden Sie dieses Projekt erneut herunter.

**Schritt 4: Den Datenpfad im Skript aktualisieren**

Öffnen Sie `scripts/bible_search.py` und finden Sie diese Zeile near dem Anfang:

```python
BIBLE_DIR = os.path.expanduser("~/workspace/20260413/bible-txt-file")
```

Ändern Sie sie in Ihren tatsächlichen Datenpfad:

```python
BIBLE_DIR = os.path.expanduser("~/bible-data")
```

> 💡 Sie können auch einen absoluten Pfad verwenden, z. B. `BIBLE_DIR = "/Users/ihrname/bible-data"`

**Schritt 5: Installation überprüfen**

```bash
# Test 1: Alle 66 Bücher auflisten
python3 scripts/bible_search.py list

# Test 2: Einen Vers abfragen
python3 scripts/bible_search.py 创 1:1
# Erwartet: 【创世记 1:1】
#           1 起初　神创造天地。

# Test 3: Schlüsselwortsuche
python3 scripts/bible_search.py search 神爱世人
# Erwartet: Sollte Johannes 3:16 enthalten

# Test 4: Buchinformationen
python3 scripts/bible_search.py info 诗篇
# Erwartet: 【诗篇】共 150 章，2461 节
```

Alle 4 Tests bestanden bedeutet, dass die Installation erfolgreich war!

---

### Option 3: Klonen & Ausführen

Für Entwickler, die die Skripte direkt ohne das Installationsskript verwenden möchten:

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill

# Daten entpacken (vor dem ersten Start erforderlich)
mkdir -p ~/bible-data
tar xzf assets/bible-txt-file.tar.gz -C ~/bible-data --strip-components=1

# BIBLE_DIR in scripts/bible_search.py aktualisieren, dann:
python3 scripts/bible_search.py 创 1:1
```

---

## Verwendung

Grundlegendes Befehlsformat:

```bash
python3 scripts/bible_search.py <Befehl>
```

> 💡 Die folgenden Beispiele gehen davon aus, dass Sie sich im Projekt-Stammverzeichnis befinden. Andernfalls verwenden Sie den vollständigen Pfad zum Skript.

### 1. Alle 66 Bücher auflisten

```bash
python3 scripts/bible_search.py list
```

Beispielausgabe:
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

### 2. Buchinformationen anzeigen

Unterstützt volle chinesische Namen oder Abkürzungen:

```bash
python3 scripts/bible_search.py info 创世记
python3 scripts/bible_search.py info 太
```

Beispielausgabe:
```
【创世记】共 50 章，1533 节
【马太福音】共 28 章，1071 节
```

### 3. Ein ganzes Kapitel anzeigen

```bash
python3 scripts/bible_search.py 创世记 1
python3 scripts/bible_search.py 太 5
python3 scripts/bible_search.py 诗 23
```

Beispielausgabe:
```
【诗篇 第23章】
1 耶和华是我的牧者，我必不至缺乏。
2 他使我躺卧在青草地上，领我在可安歇的水边。
...
```

### 4. Einen einzelnen Vers anzeigen

Format: `Buchname Kapitel:Vers`

```bash
python3 scripts/bible_search.py 创 1:1
python3 scripts/bible_search.py 约 3:16
python3 scripts/bible_search.py 诗 23:1
```

Beispielausgabe:
```
【约翰福音 3:16】
16 "　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
```

### 5. Einen Versbereich anzeigen

Format: `Buchname Kapitel:StartVers-EndVers`

```bash
python3 scripts/bible_search.py 太 5:3-12
python3 scripts/bible_search.py 创 1:1-5
```

Beispielausgabe:
```
【马太福音 5:3-12】
3 虚心的人有福了！因为天国是他们的。
4 哀恸的人有福了！因为他们必得安慰。
...
```

### 6. Volltextsuche

Durchsuchen Sie alle 66 Bücher nach Versen, die ein Schlüsselwort enthalten:

```bash
python3 scripts/bible_search.py search 耶和华是我的牧者
python3 scripts/bible_search.py search 神爱世人
python3 scripts/bible_search.py search 以马内利
```

Beispielausgabe:
```
【约翰福音 3:16】"　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
【约翰一书 4:9】　神差他独生子到世间来，使我们借着他得生，　神爱我们的心在此就显明了。
...
```

> 💡 Die Suche liefert standardmäßig bis zu 20 Ergebnisse. Um dies zu ändern, öffnen Sie `scripts/bible_search.py`, finden Sie `search_bible(keyword, max_results=20)` und ändern Sie `20` in die gewünschte Anzahl.

---

## Buchnamen-Abkürzungen

Das Werkzeug unterstützt sowohl volle chinesische Namen als auch gängige Abkürzungen:

### Altes Testament (39 Bücher)

| Abk. | Vollständiger Name (Chinesisch) | Englischer Name | Abk. | Vollständiger Name (Chinesisch) | Englischer Name |
|------|--------------------------------|-----------------|------|--------------------------------|-----------------|
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

### Neues Testament (27 Bücher)

| Abk. | Vollständiger Name (Chinesisch) | Englischer Name | Abk. | Vollständiger Name (Chinesisch) | Englischer Name |
|------|--------------------------------|-----------------|------|--------------------------------|-----------------|
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

## Datenformat

Dieses Projekt verwendet den Bibeltext der Chinesischen Union-Version (和合本, CUV), gespeichert als 66 einfache Textdateien.

### Dateibenennung

`Nummer+Buchname.txt`, nummeriert 1–66:

```
1创世记.txt   2出埃及记.txt   3利未记.txt   ...   66启示录.txt
```

### Dateiinhaltsformat

In jeder Datei stellt **jede Zeile ein ganzes Kapitel dar**:

```
第X章1Vers eins Text2Vers zwei Text3Vers drei Text...NLetzter Vers Text
```

Regeln:
- Zeile beginnt mit `第X章` (X ist eine arabische Ziffer, z. B. `第1章`, `第23章`)
- Unmittelbar gefolgt von Versnummer (Ziffern) + Vers Text
- **Kein Leerzeichen** zwischen Versnummer und Text
- Nach dem Ende eines Verses folgt unmittelbar die nächste Versnummer
- Jedes Kapitel belegt genau eine Zeile (keine Zeilenumbrüche innerhalb eines Kapitels)
- Dateikodierung: **UTF-8**

Reales Beispiel (Genesis 1:1-5):

```
第1章1起初　神创造天地。2地是空虚混沌，渊面黑暗；　神的灵运行在水面上。3　神说："要有光。"就有了光。4　神看光是好的，就把光暗分开了。5　神称光为"昼"，称暗为"夜"。有晚上，有早晨，这是头一日。
```

Wenn Sie Bibeldaten in einem anderen Format haben, finden Sie in [SKILL.md](SKILL.md) ein Konvertierungsskript.

---

## Dateistruktur

```
bible-skill/
├── README.md                     ← Diese Datei (Chinesisch)
├── README_EN.md                  ← Englische Dokumentation
├── README_DE.md                  ← Deutsche Dokumentation
├── LICENSE                       ← MIT-Lizenz
├── SKILL.md                      ← Hermes Agent Skill-Dokumentation (detaillierte manuelle Installationsanleitung)
├── .gitignore
├── assets/
│   └── bible-txt-file.tar.gz     ← Bibeldatenarchiv (66 Bücher, ~1,2 MB)
└── scripts/
    ├── bible_search.py           ← Kern-Suchskript (Python 3, null Abhängigkeiten)
    └── install.sh                ← Ein-Klick-Installationsskript
```

---

## Verwendung mit KI-Agenten

Dieses Projekt ist für die Integration mit KI-Coding-Assistenten konzipiert, sodass KI Bibelverse direkt abfragen und zitieren kann. Nachfolgend finden Sie Einrichtungsanleitungen für Claude Code, Hermes Agent und OpenClaw.

### Claude Code

Claude Code ist Anthropics Befehlszeilen-KI-Coding-Assistent. Sie können ihm über eine CLAUDE.md-Datei beibringen, die Bibelsuch-Skill zu verwenden.

**Schritt 1: Bibeldaten installieren**

```bash
# Repository klonen und Installationsskript ausführen
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

**Schritt 2: CLAUDE.md im Projekt-Stammverzeichnis erstellen**

Erstellen Sie eine `CLAUDE.md`-Datei in Ihrem Projekt-Stammverzeichnis (oder einem beliebigen Arbeitsverzeichnis) mit folgendem Inhalt:

```markdown
# Bible Search Tool

Das Bibelsuchwerkzeug ist installiert unter /usr/local/share/bible-txt-file/.

Um Bibelverse abzufragen, führen Sie aus:

- Alle 66 Bücher auflisten: python3 /usr/local/share/bible-txt-file/bible_search.py list
- Buchinformationen: python3 /usr/local/share/bible-txt-file/bible_search.py info Genesis
- Kapitel lesen: python3 /usr/local/share/bible-txt-file/bible_search.py read Genesis 1
- Vers lesen: python3 /usr/local/share/bible-txt-file/bible_search.py read Genesis 1 1
- Versbereich lesen: python3 /usr/local/share/bible-txt-file/bible_search.py read Genesis 1 1-5
- Volltextsuche: python3 /usr/local/share/bible-txt-file/bible_search.py search grace

Unterstützt chinesische Buchnamen (创世记), Abkürzungen (创) und englische Namen (Genesis). Verwenden Sie das Terminal-Werkzeug zur Ausführung.
```

**Schritt 3: Verwenden**

Fragen Sie Claude Code in natürlicher Sprache:

```
> Look up John 3:16
> Search for Bible verses about "grace"
> List all books of the Bible
```

Claude Code ruft das Suchskript automatisch basierend auf den CLAUDE.md-Anweisungen auf.

> **Tipp**: Wenn der Installationspfad nicht der Standardpfad `/usr/local/share/bible-txt-file/` ist, ersetzen Sie die Pfade in CLAUDE.md durch Ihren tatsächlichen Pfad. Testen Sie mit `python3 scripts/bible_search.py info Genesis`, um zu überprüfen, ob es funktioniert.

---

### Hermes Agent

Hermes Agent verfügt über ein integriertes Skill-System — dieses Repository ist selbst ein Skill-Paket, das für Hermes entwickelt wurde.

**Option 1: Automatisches Laden über SKILL.md (Empfohlen)**

1. Klonen Sie dieses Repository in das Hermes-Skills-Verzeichnis:

```bash
git clone https://github.com/dockercore/bible-skill.git ~/.hermes/skills/bible
```

2. Hermes Agent lädt `~/.hermes/skills/bible/SKILL.md` beim Start automatisch — keine zusätzliche Konfiguration erforderlich.

3. Bibeldaten installieren:

```bash
cd ~/.hermes/skills/bible
bash scripts/install.sh
```

4. Sprechen Sie einfach mit Hermes:

```
Look up Psalm 23
Search for Bible verses about "peace"
```

**Option 2: Benutzerdefinierter Skill-Pfad**

Wenn Sie einen anderen Speicherort bevorzugen, fügen Sie den Skill-Pfad in Ihrer Hermes-Konfiguration hinzu:

```yaml
skills:
  - path: /your/custom/path/bible-skill/SKILL.md
```

Führen Sie dann das Installationsskript aus:

```bash
cd /your/custom/path/bible-skill
bash scripts/install.sh
```

> **Tipp**: SKILL.md enthält bereits vollständige Installations- und Verwendungsanweisungen. Sobald Hermes sie lädt, versteht es automatisch, wie das Werkzeug aufzurufen ist. Wenn Sie den Installationspfad ändern, aktualisieren Sie die Variable `BIBLE_DIR` in SKILL.md entsprechend.

---

### OpenClaw

OpenClaw ist ein Open-Source-KI-Agent-Framework, das die Integration externer Fähigkeiten über MCP (Model Context Protocol) oder benutzerdefinierte Werkzeuge unterstützt.

**Option 1: Benutzerdefinierte Werkzeug-Integration**

1. Bibeldaten und Suchskript installieren:

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

2. Das Werkzeug zur OpenClaw-Konfigurationsdatei hinzufügen (typischerweise `tools.yaml` oder `config.yaml`):

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

3. OpenClaw neu starten und verwenden:

```
Please look up John 3:16
```

**Option 2: MCP-Server-Integration**

Wenn Sie den MCP-Ansatz bevorzugen, erstellen Sie einen einfachen MCP-Server-Wrapper:

1. Erstellen Sie `/usr/local/share/bible-txt-file/bible_mcp_server.py`:

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

2. Registrieren Sie den MCP-Server in Ihrer OpenClaw-Konfiguration:

```yaml
mcp_servers:
  - name: bible-search
    command: "python3"
    args: ["/usr/local/share/bible-txt-file/bible_mcp_server.py"]
    transport: stdio
```

3. OpenClaw neu starten — die KI kann nun die Bibel über das MCP-Protokoll abfragen.

> **Tipp**: Option 1 ist einfacher und eignet sich gut für eine schnelle Einrichtung; Option 2 ist standardisierter und besser für Multi-Agenten-Setups. Wählen Sie je nach Ihren Anforderungen.

---

## FAQ

### F: `python3: command not found`

Python 3 ist nicht installiert. Siehe [Voraussetzungen](#voraussetzungen) für Installationsanweisungen.

### F: `No such file or directory`

Der Pfad zum Bibeldatenverzeichnis ist falsch. Überprüfen Sie die Variable `BIBLE_DIR` in `scripts/bible_search.py` und stellen Sie sicher, dass das Verzeichnis existiert und 66 .txt-Dateien enthält.

### F: `未找到卷名: xxx` (Buchname nicht gefunden)

Der eingegebene Buchname oder die Abkürzung ist nicht in der Zuordnungstabelle enthalten. Siehe [Buchnamen-Abkürzungen](#buchnamen-abkürzungen) oder fügen Sie eine benutzerdefinierte Abkürzung zum `BOOK_MAP`-Wörterbuch in `scripts/bible_search.py` hinzu.

### F: Versnummern sind unleserlich oder Inhalt ist unvollständig

Das .txt-Dateiformat ist falsch. Überprüfen Sie es anhand des Abschnitts [Datenformat](#datenformat).

### F: `Permission denied`

Das Skript hat keine Ausführungsberechtigung. Führen Sie aus:

```bash
chmod +x scripts/bible_search.py
```

### F: Nicht genug Suchergebnisse

Die Suche liefert standardmäßig bis zu 20 Ergebnisse. Öffnen Sie `scripts/bible_search.py`, finden Sie `search_bible(keyword, max_results=20)` und ändern Sie `20` in die gewünschte Anzahl.

---

## Lizenz

Dieses Projekt ist unter der [MIT-Lizenz](LICENSE) lizenziert.

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

Kurz gesagt: Sie dürfen diese Software frei verwenden, kopieren, modifizieren, zusammenführen, veröffentlichen, verteilen, unterlizenzieren und/oder verkaufen, sofern Sie den Urheberrechtshinweis und den Lizenzhinweis beifügen. Die Software wird „wie besehen" bereitgestellt, ohne jegliche Gewährleistung.
