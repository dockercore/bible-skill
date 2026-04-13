# Strumento di Ricerca nella Bibbia Cinese

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.6+](https://img.shields.io/badge/Python-3.6%2B-blue.svg)](https://www.python.org/)

[中文](README.md) | [English](README_EN.md) | Italiano

Uno strumento di ricerca locale e offline della Bibbia in cinese (Versione Union / 和合本). Cerca versetti per nome del libro, capitolo, versetto o parola chiave — zero dipendenze, pronto all'uso.

---

## Indice

- [Funzionalità](#funzionalità)
- [Requisiti](#requisiti)
- [Installazione](#installazione)
  - [Opzione 1: Installazione con un clic (Consigliata)](#opzione-1-installazione-con-un-clic-consigliata)
  - [Opzione 2: Installazione manuale](#opzione-2-installazione-manuale)
  - [Opzione 3: Clona ed esegui](#opzione-3-clona-ed-esegui)
- [Utilizzo](#utilizzo)
  - [1. Elencare tutti i 66 libri](#1-elencare-tutti-i-66-libri)
  - [2. Visualizzare le informazioni di un libro](#2-visualizzare-le-informazioni-di-un-libro)
  - [3. Visualizzare un intero capitolo](#3-visualizzare-un-intero-capitolo)
  - [4. Visualizzare un singolo versetto](#4-visualizzare-un-singolo-versetto)
  - [5. Visualizzare un intervallo di versetti](#5-visualizzare-un-intervallo-di-versetti)
  - [6. Ricerca full-text](#6-ricerca-full-text)
- [Abbreviazioni dei nomi dei libri](#abbreviazioni-dei-nomi-dei-libri)
- [Formato dei dati](#formato-dei-dati)
- [Struttura dei file](#struttura-dei-file)
- [Utilizzo con agenti AI](#utilizzo-con-agenti-ai)
  - [Claude Code](#claude-code)
  - [Hermes Agent](#hermes-agent)
  - [OpenClaw](#openclaw)
- [FAQ](#faq)
- [Licenza](#licenza)

---

## Funzionalità

- 📖 Elencare tutti i 66 libri della Bibbia
- 🔍 Cercare versetti per nome completo o abbreviazione (intero capitolo, singolo versetto, intervallo di versetti)
- 🗂️ Visualizzare le informazioni di un libro (numero di capitoli, numero di versetti)
- 🔎 Ricerca full-text per parola chiave (restituisce fino a 20 risultati per impostazione predefinita)
- 📦 Script di installazione con un clic con archivio dati incluso
- 🚀 Zero dipendenze di terze parti — richiede solo Python 3.6+

---

## Requisiti

| Elemento | Requisito |
|----------|-----------|
| Python | 3.6 o superiore |
| Sistema operativo | macOS / Linux / Windows |
| Spazio su disco | ~5 MB (dati + script) |
| Dipendenze | Nessuna |

---

## Installazione

### Opzione 1: Installazione con un clic (Consigliata)

Ideale per principianti. Tre comandi e hai finito.

**Passo 1: Verificare che Python 3 sia installato**

```bash
python3 --version
```

Se ottieni `command not found`, installa prima Python 3:

| Sistema | Come installare |
|---------|-----------------|
| macOS | `brew install python3` oppure scarica da [python.org](https://www.python.org/downloads/) |
| Ubuntu / Debian | `sudo apt update && sudo apt install python3` |
| Windows | Scarica da [python.org](https://www.python.org/downloads/) — **assicurati di selezionare** "Add Python to PATH" durante l'installazione |

**Passo 2: Clonare questo repository**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

> Non hai git? Clicca il pulsante verde "Code" su questa pagina → "Download ZIP", quindi estrai il file.

**Passo 3: Eseguire lo script di installazione**

```bash
bash scripts/install.sh
```

Lo script di installazione esegue automaticamente questi passaggi:

```
[Step 1/6] Check Python 3           → Verify Python 3 is available
[Step 2/6] Set Bible data directory  → Default: ~/bible-data/
[Step 3/6] Extract Bible text data   → Unpack 66 .txt files from bundled archive
[Step 4/6] Create skill directory    → Create ~/.hermes/skills/creative/bible/
[Step 5/6] Configure search script   → Auto-update data path
[Step 6/6] Verify installation       → Run 4 tests to confirm everything works
```

Per utilizzare una directory dati personalizzata:

```bash
bash scripts/install.sh /your/custom/path
```

---

### Opzione 2: Installazione manuale

Per utenti che desiderano comprendere ogni passaggio.

**Passo 1: Clonare questo repository**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

**Passo 2: Creare la directory dati ed estrarre i dati**

```bash
mkdir -p ~/bible-data
tar xzf assets/bible-txt-file.tar.gz -C ~/bible-data --strip-components=1
```

**Passo 3: Verificare il numero di file**

```bash
ls ~/bible-data/*.txt | wc -l
```

Dovrebbe restituire `66`. In caso contrario, scarica nuovamente questo progetto.

**Passo 4: Aggiornare il percorso dei dati nello script**

Apri `scripts/bible_search.py` e trova questa riga vicino all'inizio:

```python
BIBLE_DIR = os.path.expanduser("~/workspace/20260413/bible-txt-file")
```

Modificala con il tuo percorso dati effettivo:

```python
BIBLE_DIR = os.path.expanduser("~/bible-data")
```

> 💡 Puoi anche utilizzare un percorso assoluto, ad es. `BIBLE_DIR = "/Users/yourname/bible-data"`

**Passo 5: Verificare l'installazione**

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

Se tutti e 4 i test passano, l'installazione è riuscita!

---

### Opzione 3: Clona ed esegui

Per sviluppatori che desiderano utilizzare gli script direttamente senza lo script di installazione:

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

## Utilizzo

Formato base del comando:

```bash
python3 scripts/bible_search.py <command>
```

> 💡 Gli esempi seguenti presuppongono che tu sia nella directory principale del progetto. Altrimenti, utilizza il percorso completo dello script.

### 1. Elencare tutti i 66 libri

```bash
python3 scripts/bible_search.py list
```

Esempio di output:
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

### 2. Visualizzare le informazioni di un libro

Supporta nomi cinesi completi o abbreviazioni:

```bash
python3 scripts/bible_search.py info 创世记
python3 scripts/bible_search.py info 太
```

Esempio di output:
```
【创世记】共 50 章，1533 节
【马太福音】共 28 章，1071 节
```

### 3. Visualizzare un intero capitolo

```bash
python3 scripts/bible_search.py 创世记 1
python3 scripts/bible_search.py 太 5
python3 scripts/bible_search.py 诗 23
```

Esempio di output:
```
【诗篇 第23章】
1 耶和华是我的牧者，我必不至缺乏。
2 他使我躺卧在青草地上，领我在可安歇的水边。
...
```

### 4. Visualizzare un singolo versetto

Formato: `NomeLibro Capitolo:Versetto`

```bash
python3 scripts/bible_search.py 创 1:1
python3 scripts/bible_search.py 约 3:16
python3 scripts/bible_search.py 诗 23:1
```

Esempio di output:
```
【约翰福音 3:16】
16 "　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
```

### 5. Visualizzare un intervallo di versetti

Formato: `NomeLibro Capitolo:VersettoIniziale-VersettoFinale`

```bash
python3 scripts/bible_search.py 太 5:3-12
python3 scripts/bible_search.py 创 1:1-5
```

Esempio di output:
```
【马太福音 5:3-12】
3 虚心的人有福了！因为天国是他们的。
4 哀恸的人有福了！因为他们必得安慰。
...
```

### 6. Ricerca full-text

Cerca in tutti i 66 libri i versetti contenenti una parola chiave:

```bash
python3 scripts/bible_search.py search 耶和华是我的牧者
python3 scripts/bible_search.py search 神爱世人
python3 scripts/bible_search.py search 以马内利
```

Esempio di output:
```
【约翰福音 3:16】"　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
【约翰一书 4:9】　神差他独生子到世间来，使我们借着他得生，　神爱我们的心在此就显明了。
...
```

> 💡 La ricerca restituisce fino a 20 risultati per impostazione predefinita. Per modificare questo valore, apri `scripts/bible_search.py`, trova `search_bible(keyword, max_results=20)` e cambia `20` con il numero desiderato.

---

## Abbreviazioni dei nomi dei libri

Lo strumento supporta sia i nomi cinesi completi che le abbreviazioni più comuni:

### Antico Testamento (39 Libri)

| Abbr | Nome completo (Cinese) | Nome inglese | Abbr | Nome completo (Cinese) | Nome inglese |
|------|------------------------|--------------|------|------------------------|--------------|
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

### Nuovo Testamento (27 Libri)

| Abbr | Nome completo (Cinese) | Nome inglese | Abbr | Nome completo (Cinese) | Nome inglese |
|------|------------------------|--------------|------|------------------------|--------------|
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

## Formato dei dati

Questo progetto utilizza il testo della Bibbia in versione cinese Union (和合本, CUV), memorizzato in 66 file di testo semplice.

### Nomenclatura dei file

`Numero+NomeLibro.txt`, numerati da 1 a 66:

```
1创世记.txt   2出埃及记.txt   3利未记.txt   ...   66启示录.txt
```

### Formato del contenuto dei file

All'interno di ogni file, **ogni riga rappresenta un intero capitolo**:

```
第X章1Testo del versetto uno2Testo del versetto due3Testo del versetto tre...NTesto dell'ultimo versetto
```

Regole:
- La riga inizia con `第X章` (X è un numero arabo, ad es. `第1章`, `第23章`)
- Seguito immediatamente dal numero del versetto (cifre) + il testo del versetto
- **Nessuno spazio** tra il numero del versetto e il testo
- Dopo la fine di un versetto, segue immediatamente il numero del versetto successivo
- Ogni capitolo occupa esattamente una riga (nessun ritorno a capo all'interno di un capitolo)
- Codifica dei file: **UTF-8**

Esempio reale (Genesi 1:1-5):

```
第1章1起初　神创造天地。2地是空虚混沌，渊面黑暗；　神的灵运行在水面上。3　神说："要有光。"就有了光。4　神看光是好的，就把光暗分开了。5　神称光为"昼"，称暗为"夜"。有晚上，有早晨，这是头一日。
```

Se hai dati biblici in un formato diverso, consulta [SKILL.md](SKILL.md) per uno script di conversione.

---

## Struttura dei file

```
bible-skill/
├── README.md                     ← Questo file (Cinese)
├── README_EN.md                  ← Documentazione inglese
├── README_IT.md                  ← Documentazione italiana
├── LICENSE                       ← Licenza MIT
├── SKILL.md                      ← Documento skill di Hermes Agent (guida dettagliata all'installazione manuale)
├── .gitignore
├── assets/
│   └── bible-txt-file.tar.gz     ← Archivio dati biblici (66 libri, ~1.2 MB)
└── scripts/
    ├── bible_search.py           ← Script di ricerca principale (Python 3, zero dipendenze)
    └── install.sh                ← Script di installazione con un clic
```

---

## Utilizzo con agenti AI

Questo progetto è progettato per integrarsi con assistenti di codifica AI, consentendo all'IA di interrogare e citare direttamente i versetti biblici. Di seguito le guide di configurazione per Claude Code, Hermes Agent e OpenClaw.

### Claude Code

Claude Code è l'assistente di codifica AI da riga di comando di Anthropic. Puoi insegnargli a utilizzare lo strumento di ricerca biblica tramite un file CLAUDE.md.

**Passo 1: Installare i dati biblici**

```bash
# Clone the repo and run the install script
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

**Passo 2: Creare CLAUDE.md nella directory principale del progetto**

Crea un file `CLAUDE.md` nella directory principale del progetto (o in qualsiasi directory di lavoro) con il seguente contenuto:

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

**Passo 3: Utilizzare**

Chiedi a Claude Code in linguaggio naturale:

```
> Look up John 3:16
> Search for Bible verses about "grace"
> List all books of the Bible
```

Claude Code chiamerà automaticamente lo script di ricerca in base alle istruzioni in CLAUDE.md.

> **Suggerimento**: Se il percorso di installazione non è quello predefinito `/usr/local/share/bible-txt-file/`, sostituisci i percorsi in CLAUDE.md con il tuo percorso effettivo. Verifica con `python3 scripts/bible_search.py info Genesis` che funzioni correttamente.

---

### Hermes Agent

Hermes Agent dispone di un sistema di skill integrato — questo repository è esso stesso un pacchetto skill progettato per Hermes.

**Opzione 1: Caricamento automatico tramite SKILL.md (Consigliato)**

1. Clona questo repository nella directory delle skill di Hermes:

```bash
git clone https://github.com/dockercore/bible-skill.git ~/.hermes/skills/bible
```

2. Hermes Agent carica automaticamente `~/.hermes/skills/bible/SKILL.md` all'avvio — nessuna configurazione aggiuntiva necessaria.

3. Installa i dati biblici:

```bash
cd ~/.hermes/skills/bible
bash scripts/install.sh
```

4. Basta parlare con Hermes:

```
Look up Psalm 23
Search for Bible verses about "peace"
```

**Opzione 2: Percorso skill personalizzato**

Se preferisci una posizione diversa, aggiungi il percorso dello skill nella tua configurazione Hermes:

```yaml
skills:
  - path: /your/custom/path/bible-skill/SKILL.md
```

Quindi esegui lo script di installazione:

```bash
cd /your/custom/path/bible-skill
bash scripts/install.sh
```

> **Suggerimento**: SKILL.md contiene già istruzioni complete di installazione e utilizzo. Una volta che Hermes lo carica, comprende automaticamente come invocare lo strumento. Se modifichi il percorso di installazione, aggiorna la variabile `BIBLE_DIR` in SKILL.md di conseguenza.

---

### OpenClaw

OpenClaw è un framework AI Agent open-source che supporta l'integrazione di funzionalità esterne tramite MCP (Model Context Protocol) o strumenti personalizzati.

**Opzione 1: Integrazione con strumento personalizzato**

1. Installa i dati biblici e lo script di ricerca:

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

2. Aggiungi lo strumento al tuo file di configurazione OpenClaw (in genere `tools.yaml` o `config.yaml`):

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

3. Riavvia OpenClaw e utilizza:

```
Please look up John 3:16
```

**Opzione 2: Integrazione tramite MCP Server**

Se preferisci l'approccio MCP, crea un semplice wrapper MCP Server:

1. Crea `/usr/local/share/bible-txt-file/bible_mcp_server.py`:

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

2. Registra l'MCP Server nella tua configurazione OpenClaw:

```yaml
mcp_servers:
  - name: bible-search
    command: "python3"
    args: ["/usr/local/share/bible-txt-file/bible_mcp_server.py"]
    transport: stdio
```

3. Riavvia OpenClaw — l'IA può ora interrogare la Bibbia tramite il protocollo MCP.

> **Suggerimento**: L'Opzione 1 è più semplice e ideale per una configurazione rapida; l'Opzione 2 è più standardizzata e migliore per configurazioni multi-agente. Scegli in base alle tue esigenze.

---

## FAQ

### D: `python3: command not found`

Python 3 non è installato. Vedi [Requisiti](#requisiti) per le istruzioni di installazione.

### D: `No such file or directory`

Il percorso della directory dei dati biblici non è corretto. Verifica la variabile `BIBLE_DIR` in `scripts/bible_search.py` e assicurati che la directory esista e contenga 66 file .txt.

### D: `未找到卷名: xxx` (Nome del libro non trovato)

Il nome del libro o l'abbreviazione inserita non è presente nella tabella di mappatura. Vedi [Abbreviazioni dei nomi dei libri](#abbreviazioni-dei-nomi-dei-libri), oppure aggiungi un'abbreviazione personalizzata al dizionario `BOOK_MAP` in `scripts/bible_search.py`.

### D: I numeri dei versetti sono illeggibili o il contenuto è incompleto

Il formato del file .txt non è corretto. Verifica rispetto alla sezione [Formato dei dati](#formato-dei-dati).

### D: `Permission denied`

Lo script non ha i permessi di esecuzione. Esegui:

```bash
chmod +x scripts/bible_search.py
```

### D: Risultati di ricerca insufficienti

La ricerca restituisce fino a 20 risultati per impostazione predefinita. Apri `scripts/bible_search.py`, trova `search_bible(keyword, max_results=20)` e cambia `20` con il numero desiderato.

---

## Licenza

Questo progetto è distribuito con licenza [MIT License](LICENSE).

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

In breve: sei libero di utilizzare, copiare, modificare, unire, pubblicare, distribuire, concedere in licenza e/o vendere questo software, a condizione di includere l'avviso di copyright e l'avviso di licenza. Il software è fornito "così com'è", senza alcuna garanzia di alcun tipo.
