# Инструмент поиска по китайской Библии

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.6+](https://img.shields.io/badge/Python-3.6%2B-blue.svg)](https://www.python.org/)

[中文](README.md) | [English](README_EN.md) | Русский

Локальный, офлайн-инструмент поиска по китайской Библии (Union Version / 和合本). Запрашивайте стихи по названию книги, главе, номеру стиха или ключевому слову — нулевые зависимости, готов к использованию.

---

## Содержание

- [Возможности](#возможности)
- [Требования](#требования)
- [Установка](#установка)
  - [Вариант 1: Установка в один клик (рекомендуется)](#вариант-1-установка-в-один-клик-рекомендуется)
  - [Вариант 2: Ручная установка](#вариант-2-ручная-установка)
  - [Вариант 3: Клонирование и запуск](#вариант-3-клонирование-и-запуск)
- [Использование](#использование)
  - [1. Список всех 66 книг](#1-список-всех-66-книг)
  - [2. Просмотр информации о книге](#2-просмотр-информации-о-книге)
  - [3. Просмотр целой главы](#3-просмотр-целой-главы)
  - [4. Просмотр одного стиха](#4-просмотр-одного-стиха)
  - [5. Просмотр диапазона стихов](#5-просмотр-диапазона-стихов)
  - [6. Полнотекстовый поиск](#6-полнотекстовый-поиск)
- [Сокращения названий книг](#сокращения-названий-книг)
- [Формат данных](#формат-данных)
- [Структура файлов](#структура-файлов)
- [Использование с ИИ-агентами](#использование-с-ии-агентами)
  - [Claude Code](#claude-code)
  - [Hermes Agent](#hermes-agent)
  - [OpenClaw](#openclaw)
- [Часто задаваемые вопросы](#часто-задаваемые-вопросы)
- [Лицензия](#лицензия)

---

## Возможности

- 📖 Список всех 66 книг Библии
- 🔍 Запрос стихов по полному названию или сокращению (целая глава, один стих, диапазон стихов)
- 🗂️ Просмотр информации о книге (количество глав, количество стихов)
- 🔎 Полнотекстовый поиск по ключевому слову (возвращает до 20 результатов по умолчанию)
- 📦 Скрипт установки в один клик с вложенным архивом данных
- 🚀 Нулевые сторонние зависимости — требуется только Python 3.6+

---

## Требования

| Пункт | Требование |
|-------|------------|
| Python | 3.6 или выше |
| ОС | macOS / Linux / Windows |
| Дисковое пространство | ~5 МБ (данные + скрипты) |
| Зависимости | Нет |

---

## Установка

### Вариант 1: Установка в один клик (рекомендуется)

Лучший вариант для начинающих. Три команды — и всё готово.

**Шаг 1: Проверьте, что Python 3 установлен**

```bash
python3 --version
```

Если вы получили `command not found`, сначала установите Python 3:

| Система | Способ установки |
|---------|-----------------|
| macOS | `brew install python3` или скачайте с [python.org](https://www.python.org/downloads/) |
| Ubuntu / Debian | `sudo apt update && sudo apt install python3` |
| Windows | Скачайте с [python.org](https://www.python.org/downloads/) — **обязательно отметьте** «Add Python to PATH» при установке |

**Шаг 2: Клонируйте этот репозиторий**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

> Нет git? Нажмите зелёную кнопку «Code» на этой странице → «Download ZIP», затем распакуйте.

**Шаг 3: Запустите скрипт установки**

```bash
bash scripts/install.sh
```

Скрипт установки автоматически выполняет следующие шаги:

```
[Step 1/6] Check Python 3           → Verify Python 3 is available
[Step 2/6] Set Bible data directory  → Default: ~/bible-data/
[Step 3/6] Extract Bible text data   → Unpack 66 .txt files from bundled archive
[Step 4/6] Create skill directory    → Create ~/.hermes/skills/creative/bible/
[Step 5/6] Configure search script   → Auto-update data path
[Step 6/6] Verify installation       → Run 4 tests to confirm everything works
```

Чтобы использовать пользовательский каталог данных:

```bash
bash scripts/install.sh /your/custom/path
```

---

### Вариант 2: Ручная установка

Для пользователей, которые хотят понимать каждый шаг.

**Шаг 1: Клонируйте этот репозиторий**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

**Шаг 2: Создайте каталог данных и распакуйте данные**

```bash
mkdir -p ~/bible-data
tar xzf assets/bible-txt-file.tar.gz -C ~/bible-data --strip-components=1
```

**Шаг 3: Проверьте количество файлов**

```bash
ls ~/bible-data/*.txt | wc -l
```

Должно вывести `66`. Если нет, повторно скачайте этот проект.

**Шаг 4: Обновите путь к данным в скрипте**

Откройте `scripts/bible_search.py` и найдите эту строку в начале файла:

```python
BIBLE_DIR = os.path.expanduser("~/workspace/20260413/bible-txt-file")
```

Замените на ваш фактический путь к данным:

```python
BIBLE_DIR = os.path.expanduser("~/bible-data")
```

> 💡 Вы также можете использовать абсолютный путь, например `BIBLE_DIR = "/Users/yourname/bible-data"`

**Шаг 5: Проверьте установку**

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

Все 4 теста пройдены — установка успешна!

---

### Вариант 3: Клонирование и запуск

Для разработчиков, которые хотят использовать скрипты напрямую без скрипта установки:

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

## Использование

Базовый формат команды:

```bash
python3 scripts/bible_search.py <command>
```

> 💡 Примеры ниже предполагают, что вы находитесь в корневом каталоге проекта. В противном случае используйте полный путь к скрипту.

### 1. Список всех 66 книг

```bash
python3 scripts/bible_search.py list
```

Пример вывода:
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

### 2. Просмотр информации о книге

Поддерживаются полные китайские названия или сокращения:

```bash
python3 scripts/bible_search.py info 创世记
python3 scripts/bible_search.py info 太
```

Пример вывода:
```
【创世记】共 50 章，1533 节
【马太福音】共 28 章，1071 节
```

### 3. Просмотр целой главы

```bash
python3 scripts/bible_search.py 创世记 1
python3 scripts/bible_search.py 太 5
python3 scripts/bible_search.py 诗 23
```

Пример вывода:
```
【诗篇 第23章】
1 耶和华是我的牧者，我必不至缺乏。
2 他使我躺卧在青草地上，领我在可安歇的水边。
...
```

### 4. Просмотр одного стиха

Формат: `НазваниеКниги Глава:Стих`

```bash
python3 scripts/bible_search.py 创 1:1
python3 scripts/bible_search.py 约 3:16
python3 scripts/bible_search.py 诗 23:1
```

Пример вывода:
```
【约翰福音 3:16】
16 "　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
```

### 5. Просмотр диапазона стихов

Формат: `НазваниеКниги Глава:НачальныйСтих-КонечныйСтих`

```bash
python3 scripts/bible_search.py 太 5:3-12
python3 scripts/bible_search.py 创 1:1-5
```

Пример вывода:
```
【马太福音 5:3-12】
3 虚心的人有福了！因为天国是他们的。
4 哀恸的人有福了！因为他们必得安慰。
...
```

### 6. Полнотекстовый поиск

Поиск по всем 66 книгам стихов, содержащих ключевое слово:

```bash
python3 scripts/bible_search.py search 耶和华是我的牧者
python3 scripts/bible_search.py search 神爱世人
python3 scripts/bible_search.py search 以马内利
```

Пример вывода:
```
【约翰福音 3:16】"　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
【约翰一书 4:9】　神差他独生子到世间来，使我们借着他得生，　神爱我们的心在此就显明了。
...
```

> 💡 Поиск возвращает до 20 результатов по умолчанию. Чтобы изменить это, откройте `scripts/bible_search.py`, найдите `search_bible(keyword, max_results=20)` и замените `20` на желаемое количество.

---

## Сокращения названий книг

Инструмент поддерживает как полные китайские названия, так и общепринятые сокращения:

### Ветхий Завет (39 книг)

| Сокр. | Полное название (китайский) | Английское название | Сокр. | Полное название (китайский) | Английское название |
|-------|-----------------------------|---------------------|-------|-----------------------------|---------------------|
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

### Новый Завет (27 книг)

| Сокр. | Полное название (китайский) | Английское название | Сокр. | Полное название (китайский) | Английское название |
|-------|-----------------------------|---------------------|-------|-----------------------------|---------------------|
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

## Формат данных

Этот проект использует текст китайской Библии в версии Union Version (和合本, CUV), хранящийся в виде 66 простых текстовых файлов.

### Именование файлов

`Номер+НазваниеКниги.txt`, пронумерованные от 1 до 66:

```
1创世记.txt   2出埃及记.txt   3利未记.txt   ...   66启示录.txt
```

### Формат содержимого файлов

Внутри каждого файла **каждая строка представляет одну целую главу**:

```
第X章1Текст первого стиха2Текст второго стиха3Текст третьего стиха...NТекст последнего стиха
```

Правила:
- Строка начинается с `第X章` (X — арабская цифра, например `第1章`, `第23章`)
- Сразу за ней следует номер стиха (цифры) + текст стиха
- **Без пробела** между номером стиха и текстом
- После окончания одного стиха сразу следует номер следующего стиха
- Каждая глава занимает ровно одну строку (без разрывов строк внутри главы)
- Кодировка файла: **UTF-8**

Реальный пример (Бытие 1:1-5):

```
第1章1起初　神创造天地。2地是空虚混沌，渊面黑暗；　神的灵运行在水面上。3　神说："要有光。"就有了光。4　神看光是好的，就把光暗分开了。5　神称光为"昼"，称暗为"夜"。有晚上，有早晨，这是头一日。
```

Если у вас есть библейские данные в другом формате, см. [SKILL.md](SKILL.md) для скрипта конвертации.

---

## Структура файлов

```
bible-skill/
├── README.md                     ← Этот файл (китайский)
├── README_EN.md                  ← Документация на английском
├── README_RU.md                  ← Документация на русском
├── LICENSE                       ← Лицензия MIT
├── SKILL.md                      ← Документация навыка Hermes Agent (подробное руководство по ручной установке)
├── .gitignore
├── assets/
│   └── bible-txt-file.tar.gz     ← Архив библейских данных (66 книг, ~1.2 МБ)
└── scripts/
    ├── bible_search.py           ← Основной поисковый скрипт (Python 3, нулевые зависимости)
    └── install.sh                ← Скрипт установки в один клик
```

---

## Использование с ИИ-агентами

Этот проект предназначен для интеграции с ИИ-ассистентами для программирования, позволяя ИИ напрямую запрашивать и цитировать библейские стихи. Ниже приведены инструкции по настройке для Claude Code, Hermes Agent и OpenClaw.

### Claude Code

Claude Code — это консольный ИИ-ассистент для программирования от Anthropic. Вы можете научить его использовать навык поиска по Библии через файл CLAUDE.md.

**Шаг 1: Установите библейские данные**

```bash
# Clone the repo and run the install script
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

**Шаг 2: Создайте CLAUDE.md в корне вашего проекта**

Создайте файл `CLAUDE.md` в корне вашего проекта (или в любом рабочем каталоге) со следующим содержимым:

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

**Шаг 3: Используйте**

Спрашивайте Claude Code на естественном языке:

```
> Look up John 3:16
> Search for Bible verses about "grace"
> List all books of the Bible
```

Claude Code будет автоматически вызывать поисковый скрипт на основе инструкций в CLAUDE.md.

> **Совет**: Если путь установки отличается от значения по умолчанию `/usr/local/share/bible-txt-file/`, замените пути в CLAUDE.md на ваш фактический путь. Проверьте работоспособность командой `python3 scripts/bible_search.py info Genesis`.

---

### Hermes Agent

Hermes Agent имеет встроенную систему навыков — этот репозиторий сам по себе является пакетом навыков, разработанным для Hermes.

**Вариант 1: Автозагрузка через SKILL.md (рекомендуется)**

1. Клонируйте этот репозиторий в каталог навыков Hermes:

```bash
git clone https://github.com/dockercore/bible-skill.git ~/.hermes/skills/bible
```

2. Hermes Agent автоматически загружает `~/.hermes/skills/bible/SKILL.md` при запуске — дополнительная настройка не требуется.

3. Установите библейские данные:

```bash
cd ~/.hermes/skills/bible
bash scripts/install.sh
```

4. Просто общайтесь с Hermes:

```
Look up Psalm 23
Search for Bible verses about "peace"
```

**Вариант 2: Пользовательский путь к навыку**

Если вы предпочитаете другое расположение, добавьте путь к навыку в конфигурацию Hermes:

```yaml
skills:
  - path: /your/custom/path/bible-skill/SKILL.md
```

Затем запустите скрипт установки:

```bash
cd /your/custom/path/bible-skill
bash scripts/install.sh
```

> **Совет**: SKILL.md уже содержит полные инструкции по установке и использованию. Когда Hermes загрузит его, он автоматически поймёт, как вызывать инструмент. Если вы измените путь установки, обновите переменную `BIBLE_DIR` в SKILL.md соответствующим образом.

---

### OpenClaw

OpenClaw — это фреймворк ИИ-агента с открытым исходным кодом, поддерживающий интеграцию внешних возможностей через MCP (Model Context Protocol) или пользовательские инструменты.

**Вариант 1: Интеграция пользовательского инструмента**

1. Установите библейские данные и поисковый скрипт:

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

2. Добавьте инструмент в файл конфигурации OpenClaw (обычно `tools.yaml` или `config.yaml`):

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

3. Перезапустите OpenClaw и используйте:

```
Please look up John 3:16
```

**Вариант 2: Интеграция через MCP Server**

Если вы предпочитаете подход MCP, создайте простую обёртку MCP Server:

1. Создайте `/usr/local/share/bible-txt-file/bible_mcp_server.py`:

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

2. Зарегистрируйте MCP Server в конфигурации OpenClaw:

```yaml
mcp_servers:
  - name: bible-search
    command: "python3"
    args: ["/usr/local/share/bible-txt-file/bible_mcp_server.py"]
    transport: stdio
```

3. Перезапустите OpenClaw — теперь ИИ может запрашивать Библию через протокол MCP.

> **Совет**: Вариант 1 проще и отлично подходит для быстрой настройки; Вариант 2 более стандартизирован и лучше подходит для конфигураций с несколькими агентами. Выбирайте в зависимости от ваших потребностей.

---

## Часто задаваемые вопросы

### В: `python3: command not found`

Python 3 не установлен. См. раздел [Требования](#требования) для инструкций по установке.

### В: `No such file or directory`

Путь к каталогу библейских данных указан неверно. Проверьте переменную `BIBLE_DIR` в `scripts/bible_search.py` и убедитесь, что каталог существует и содержит 66 файлов .txt.

### В: `未找到卷名: xxx` (Название книги не найдено)

Введённое название книги или сокращение отсутствует в таблице соответствия. См. [Сокращения названий книг](#сокращения-названий-книг) или добавьте собственное сокращение в словарь `BOOK_MAP` в `scripts/bible_search.py`.

### В: Номера стихов отображаются некорректно или содержание неполное

Формат .txt файла некорректен. Проверьте в соответствии с разделом [Формат данных](#формат-данных).

### В: `Permission denied`

Скрипт не имеет права на выполнение. Выполните:

```bash
chmod +x scripts/bible_search.py
```

### В: Недостаточно результатов поиска

Поиск возвращает до 20 результатов по умолчанию. Откройте `scripts/bible_search.py`, найдите `search_bible(keyword, max_results=20)` и замените `20` на желаемое количество.

---

## Лицензия

Этот проект лицензирован по [лицензии MIT](LICENSE).

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

Кратко: вы свободно можете использовать, копировать, изменять, объединять, публиковать, распространять, предоставлять сублицензии и/или продавать данное программное обеспечение при условии включения уведомления об авторских правах и уведомления о лицензии. Программное обеспечение предоставляется «как есть», без каких-либо гарантий.
