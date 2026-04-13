# أداة البحث في الكتاب المقدس الصيني

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.6+](https://img.shields.io/badge/Python-3.6%2B-blue.svg)](https://www.python.org/)

[中文](README.md) | [English](README_EN.md) | العربية

أداة بحث محلية وغير متصلة بالإنترنت في الكتاب المقدس الصيني (نسخة الاتحاد / 和合本). ابحث عن الآيات باسم السفر أو الفصل أو الآية أو الكلمة المفتاحية — بدون أي تبعيات، جاهزة للاستخدام فوراً.

---

## جدول المحتويات

- [الميزات](#الميزات)
- [المتطلبات](#المتطلبات)
- [التثبيت](#التثبيت)
  - [الخيار 1: تثبيت بنقرة واحدة (موصى به)](#الخيار-1-تثبيت-بنقرة-واحدة-موصى-به)
  - [الخيار 2: تثبيت يدوي](#الخيار-2-تثبيت-يدوي)
  - [الخيار 3: استنساخ وتشغيل](#الخيار-3-استنساخ-وتشغيل)
- [الاستخدام](#الاستخدام)
  - [1. عرض جميع الأسفار الـ 66](#1-عرض-جميع-الأسفار-الـ-66)
  - [2. عرض معلومات السفر](#2-عرض-معلومات-السفر)
  - [3. عرض فصل كامل](#3-عرض-فصل-كامل)
  - [4. عرض آية واحدة](#4-عرض-آية-واحدة)
  - [5. عرض نطاق من الآيات](#5-عرض-نطاق-من-الآيات)
  - [6. بحث في النص الكامل](#6-بحث-في-النص-الكامل)
- [اختصارات أسماء الأسفار](#اختصارات-أسماء-الأسفار)
- [صيغة البيانات](#صيغة-البيانات)
- [هيكل الملفات](#هيكل-الملفات)
- [الاستخدام مع وكلاء الذكاء الاصطناعي](#الاستخدام-مع-وكلاء-الذكاء-الاصطناعي)
  - [Claude Code](#claude-code)
  - [Hermes Agent](#hermes-agent)
  - [OpenClaw](#openclaw)
- [الأسئلة الشائعة](#الأسئلة-الشائعة)
- [الترخيص](#الترخيص)

---

## الميزات

- 📖 عرض جميع أسفار الكتاب المقدس الـ 66
- 🔍 البحث عن آيات بالاسم الكامل أو الاختصار (فصل كامل، آية واحدة، نطاق آيات)
- 🗂️ عرض معلومات السفر (عدد الفصول، عدد الآيات)
- 🔎 بحث بالنص الكامل بالكلمة المفتاحية (يعيد حتى 20 نتيجة بشكل افتراضي)
- 📦 سكريبت تثبيت بنقرة واحدة مع أرشيف بيانات مضمّن
- 🚀 بدون أي تبعيات خارجية — يتطلب فقط Python 3.6 أو أحدث

---

## المتطلبات

| العنصر | المتطلب |
|--------|---------|
| Python | 3.6 أو أحدث |
| نظام التشغيل | macOS / Linux / Windows |
| مساحة القرص | ~5 ميغابايت (بيانات + سكريبتات) |
| التبعيات | لا يوجد |

---

## التثبيت

### الخيار 1: تثبيت بنقرة واحدة (موصى به)

الأفضل للمبتدئين. ثلاثة أوامر وانتهيت.

**الخطوة 1: التأكد من تثبيت Python 3**

```bash
python3 --version
```

إذا ظهرت لك رسالة `command not found`، قم بتثبيت Python 3 أولاً:

| النظام | طريقة التثبيت |
|--------|---------------|
| macOS | `brew install python3` أو التحميل من [python.org](https://www.python.org/downloads/) |
| Ubuntu / Debian | `sudo apt update && sudo apt install python3` |
| Windows | التحميل من [python.org](https://www.python.org/downloads/) — **تأكد من تحديد** "Add Python to PATH" أثناء التثبيت |

**الخطوة 2: استنساخ هذا المستودع**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

> لا تملك git؟ انقر على زر "Code" الأخضر في هذه الصفحة ← "Download ZIP"، ثم قم بفك الضغط.

**الخطوة 3: تشغيل سكريبت التثبيت**

```bash
bash scripts/install.sh
```

يقوم سكريبت التثبيت بتنفيذ هذه الخطوات تلقائياً:

```
[Step 1/6] Check Python 3           → Verify Python 3 is available
[Step 2/6] Set Bible data directory  → Default: ~/bible-data/
[Step 3/6] Extract Bible text data   → Unpack 66 .txt files from bundled archive
[Step 4/6] Create skill directory    → Create ~/.hermes/skills/creative/bible/
[Step 5/6] Configure search script   → Auto-update data path
[Step 6/6] Verify installation       → Run 4 tests to confirm everything works
```

لاستخدام مسار بيانات مخصص:

```bash
bash scripts/install.sh /your/custom/path
```

---

### الخيار 2: تثبيت يدوي

للمستخدمين الذين يريدون فهم كل خطوة.

**الخطوة 1: استنساخ هذا المستودع**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

**الخطوة 2: إنشاء مجلد البيانات واستخراج البيانات**

```bash
mkdir -p ~/bible-data
tar xzf assets/bible-txt-file.tar.gz -C ~/bible-data --strip-components=1
```

**الخطوة 3: التحقق من عدد الملفات**

```bash
ls ~/bible-data/*.txt | wc -l
```

يجب أن يكون الناتج `66`. إذا لم يكن كذلك، قم بإعادة تحميل هذا المشروع.

**الخطوة 4: تحديث مسار البيانات في السكريبت**

افتح `scripts/bible_search.py` وابحث عن هذا السطر بالقرب من الأعلى:

```python
BIBLE_DIR = os.path.expanduser("~/workspace/20260413/bible-txt-file")
```

قم بتغييره إلى مسار البيانات الفعلي لديك:

```python
BIBLE_DIR = os.path.expanduser("~/bible-data")
```

> 💡 يمكنك أيضاً استخدام مسار مطلق، مثلاً `BIBLE_DIR = "/Users/yourname/bible-data"`

**الخطوة 5: التحقق من التثبيت**

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

نجاح جميع الاختبارات الأربعة يعني أن التثبيت تم بنجاح!

---

### الخيار 3: استنساخ وتشغيل

للمطورين الذين يريدون استخدام السكريبتات مباشرة بدون سكريبت التثبيت:

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

## الاستخدام

صيغة الأمر الأساسية:

```bash
python3 scripts/bible_search.py <command>
```

> 💡 الأمثلة أدناه تفترض أنك في المجلد الجذري للمشروع. وإلا، استخدم المسار الكامل للسكريبت.

### 1. عرض جميع الأسفار الـ 66

```bash
python3 scripts/bible_search.py list
```

مثال على المخرجات:
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

### 2. عرض معلومات السفر

يدعم الأسماء الصينية الكاملة أو الاختصارات:

```bash
python3 scripts/bible_search.py info 创世记
python3 scripts/bible_search.py info 太
```

مثال على المخرجات:
```
【创世记】共 50 章，1533 节
【马太福音】共 28 章，1071 节
```

### 3. عرض فصل كامل

```bash
python3 scripts/bible_search.py 创世记 1
python3 scripts/bible_search.py 太 5
python3 scripts/bible_search.py 诗 23
```

مثال على المخرجات:
```
【诗篇 第23章】
1 耶和华是我的牧者，我必不至缺乏。
2 他使我躺卧在青草地上，领我在可安歇的水边。
...
```

### 4. عرض آية واحدة

الصيغة: `اسم_السفر الفصل:الآية`

```bash
python3 scripts/bible_search.py 创 1:1
python3 scripts/bible_search.py 约 3:16
python3 scripts/bible_search.py 诗 23:1
```

مثال على المخرجات:
```
【约翰福音 3:16】
16 "　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
```

### 5. عرض نطاق من الآيات

الصيغة: `اسم_السفر الفصل:آية_البداية-آية_النهاية`

```bash
python3 scripts/bible_search.py 太 5:3-12
python3 scripts/bible_search.py 创 1:1-5
```

مثال على المخرجات:
```
【马太福音 5:3-12】
3 虚心的人有福了！因为天国是他们的。
4 哀恸的人有福了！因为他们必得安慰。
...
```

### 6. بحث في النص الكامل

ابحث في جميع الأسفار الـ 66 عن آيات تحتوي على كلمة مفتاحية:

```bash
python3 scripts/bible_search.py search 耶和华是我的牧者
python3 scripts/bible_search.py search 神爱世人
python3 scripts/bible_search.py search 以马内利
```

مثال على المخرجات:
```
【约翰福音 3:16】"　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
【约翰一书 4:9】　神差他独生子到世间来，使我们借着他得生，　神爱我们的心在此就显明了。
...
```

> 💡 يعيد البحث حتى 20 نتيجة بشكل افتراضي. لتغيير ذلك، افتح `scripts/bible_search.py`، ابحث عن `search_bible(keyword, max_results=20)`، وغيّر `20` إلى الرقم المطلوب.

---

## اختصارات أسماء الأسفار

تدعم الأداة الأسماء الصينية الكاملة والاختصارات الشائعة:

### العهد القديم (39 سفراً)

| الاختصار | الاسم الكامل (الصيني) | الاسم الإنجليزي | الاختصار | الاسم الكامل (الصيني) | الاسم الإنجليزي |
|----------|----------------------|-----------------|----------|----------------------|-----------------|
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

### العهد الجديد (27 سفراً)

| الاختصار | الاسم الكامل (الصيني) | الاسم الإنجليزي | الاختصار | الاسم الكامل (الصيني) | الاسم الإنجليزي |
|----------|----------------------|-----------------|----------|----------------------|-----------------|
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

## صيغة البيانات

يستخدم هذا المشروع نص الكتاب المقدس الصيني (نسخة الاتحاد / 和合ب، CUV)، مخزّن كـ 66 ملف نصي عادي.

### تسمية الملفات

`رقم+اسم_السفر.txt`، مرقمة من 1 إلى 66:

```
1创世记.txt   2出埃及记.txt   3利未记.txt   ...   66启示录.txt
```

### صيغة محتوى الملف

داخل كل ملف، **كل سطر يمثل فصلاً كاملاً واحداً**:

```
第X章1نص الآية الأولى2نص الآية الثانية3نص الآية الثالثة...Nنص الآية الأخيرة
```

القواعد:
- يبدأ السطر بـ `第X章` (X هو رقم عربي، مثلاً `第1章`، `第23章`)
- يليه مباشرة رقم الآية (أرقام) + نص الآية
- **لا مسافة** بين رقم الآية والنص
- بعد انتهاء آية واحدة، يليها مباشرة رقم الآية التالية
- يشغل كل فصل سطراً واحداً بالضبط (لا فواصل أسطر داخل الفصل)
- ترميز الملف: **UTF-8**

مثال حقيقي (تكوين 1:1-5):

```
第1章1起初　神创造天地。2地是空虚混沌，渊面黑暗；　神的灵运行在水面上。3　神说："要有光。"就有了光。4　神看光是好的，就把光暗分开了。5　神称光为"昼"，称暗为"夜"。有晚上，有早晨，这是头一日。
```

إذا كانت بيانات الكتاب المقدس لديك بصيغة مختلفة، راجع [SKILL.md](SKILL.md) للحصول على سكريبت تحويل.

---

## هيكل الملفات

```
bible-skill/
├── README.md                     ← هذا الملف (الصينية)
├── README_EN.md                  ← التوثيق الإنجليزي
├── README_AR.md                  ← التوثيق العربي
├── LICENSE                       ← ترخيص MIT
├── SKILL.md                      ← وثيقة مهارة Hermes Agent (دليل تثبيت يدوي مفصّل)
├── .gitignore
├── assets/
│   └── bible-txt-file.tar.gz     ← أرشيف بيانات الكتاب المقدس (66 سفراً، ~1.2 ميغابايت)
└── scripts/
    ├── bible_search.py           ← سكريبت البحث الأساسي (Python 3، بدون تبعيات)
    └── install.sh                ← سكريبت التثبيت بنقرة واحدة
```

---

## الاستخدام مع وكلاء الذكاء الاصطناعي

تم تصميم هذا المشروع ليتكامل مع مساعدات البرمجة بالذكاء الاصطناعي، مما يتيح للذكاء الاصطناعي البحث عن آيات الكتاب المقدد والاستشهاد بها مباشرة. فيما يلي أدلة الإعداد لـ Claude Code و Hermes Agent و OpenClaw.

### Claude Code

Claude Code هو مساعد برمجة بالذكاء الاصطناعي من Anthropic يعمل من سطر الأوامر. يمكنك تعليمه استخدام مهارة البحث في الكتاب المقدس عبر ملف CLAUDE.md.

**الخطوة 1: تثبيت بيانات الكتاب المقدس**

```bash
# Clone the repo and run the install script
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

**الخطوة 2: إنشاء CLAUDE.md في المجلد الجذري لمشروعك**

أنشئ ملف `CLAUDE.md` في المجلد الجذري لمشروعك (أو أي مجلد عمل) بالمحتوى التالي:

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

**الخطوة 3: الاستخدام**

اسأل Claude Code بلغة طبيعية:

```
> Look up John 3:16
> Search for Bible verses about "grace"
> List all books of the Bible
```

سيقوم Claude Code تلقائياً باستدعاء سكريبت البحث بناءً على تعليمات CLAUDE.md.

> **نصيحة**: إذا كان مسار التثبيت ليس الافتراضي `/usr/local/share/bible-txt-file/`، استبدل المسارات في CLAUDE.md بمسارك الفعلي. اختبر بـ `python3 scripts/bible_search.py info Genesis` للتحقق من أنه يعمل.

---

### Hermes Agent

يملك Hermes Agent نظام مهارات مدمج — هذا المستودع بحد ذاته هو حزمة مهارات مصممة لـ Hermes.

**الخيار 1: التحميل التلقائي عبر SKILL.md (موصى به)**

1. استنسخ هذا المستودع إلى مجلد مهارات Hermes:

```bash
git clone https://github.com/dockercore/bible-skill.git ~/.hermes/skills/bible
```

2. يقوم Hermes Agent تلقائياً بتحميل `~/.hermes/skills/bible/SKILL.md` عند بدء التشغيل — لا حاجة لإعدادات إضافية.

3. ثبّت بيانات الكتاب المقدس:

```bash
cd ~/.hermes/skills/bible
bash scripts/install.sh
```

4. تحدث مع Hermes مباشرة:

```
Look up Psalm 23
Search for Bible verses about "peace"
```

**الخيار 2: مسار مهارات مخصص**

إذا كنت تفضل موقعاً مختلفاً، أضف مسار المهارة في إعدادات Hermes:

```yaml
skills:
  - path: /your/custom/path/bible-skill/SKILL.md
```

ثم شغّل سكريبت التثبيت:

```bash
cd /your/custom/path/bible-skill
bash scripts/install.sh
```

> **نصيحة**: يحتوي SKILL.md بالفعل على تعليمات التثبيت والاستخدام الكاملة. بمجرد تحميله، سيفهم Hermes تلقائياً كيفية استدعاء الأداة. إذا غيّرت مسار التثبيت، حدّث متغير `BIBLE_DIR` في SKILL.md وفقاً لذلك.

---

### OpenClaw

OpenClaw هو إطار عمل مفتوح المصدر لوكلاء الذكاء الاصطناعي يدعم دمج القدرات الخارجية عبر MCP (بروتوكول سياق النموذج) أو الأدوات المخصصة.

**الخيار 1: دمج أداة مخصصة**

1. ثبّت بيانات الكتاب المقدس وسكريبت البحث:

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

2. أضف الأداة إلى ملف إعدادات OpenClaw (عادةً `tools.yaml` أو `config.yaml`):

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

3. أعِد تشغيل OpenClaw واستخدم:

```
Please look up John 3:16
```

**الخيار 2: دمج خادم MCP**

إذا كنت تفضل نهج MCP، أنشئ غلافاً بسيطاً لخادم MCP:

1. أنشئ `/usr/local/share/bible-txt-file/bible_mcp_server.py`:

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

2. سجّل خادم MCP في إعدادات OpenClaw:

```yaml
mcp_servers:
  - name: bible-search
    command: "python3"
    args: ["/usr/local/share/bible-txt-file/bible_mcp_server.py"]
    transport: stdio
```

3. أعِد تشغيل OpenClaw — يمكن للذكاء الاصطناعي الآن البحث في الكتاب المقدس عبر بروتوكول MCP.

> **نصيحة**: الخيار 1 أبسط وممتاز للإعداد السريع؛ الخيار 2 أكثر توحيداً وأفضل لإعدادات الوكلاء المتعددين. اختر بناءً على احتياجاتك.

---

## الأسئلة الشائعة

### س: `python3: command not found`

Python 3 غير مثبت. راجع [المتطلبات](#المتطلبات) للحصول على تعليمات التثبيت.

### س: `No such file or directory`

مسار مجلد بيانات الكتاب المقدس غير صحيح. تحقق من متغير `BIBLE_DIR` في `scripts/bible_search.py` وتأكد من أن المجلد موجود ويحتوي على 66 ملف .txt.

### س: `未找到卷名: xxx` (اسم السفر غير موجود)

اسم السفر أو الاختصار الذي أدخلته غير موجود في جدول التعيين. راجع [اختصارات أسماء الأسفار](#اختصارات-أسماء-الأسفار)، أو أضف اختصاراً مخصصاً إلى قاموس `BOOK_MAP` في `scripts/bible_search.py`.

### س: أرقام الآيات مشوّهة أو المحتوى غير مكتمل

صيغة ملف .txt غير صحيحة. تحقق من قسم [صيغة البيانات](#صيغة-البيانات).

### س: `Permission denied`

السكريبت لا يملك صلاحية التنفيذ. شغّل:

```bash
chmod +x scripts/bible_search.py
```

### س: نتائج البحث غير كافية

يعيد البحث حتى 20 نتيجة بشكل افتراضي. افتح `scripts/bible_search.py`، ابحث عن `search_bible(keyword, max_results=20)`، وغيّر `20` إلى الرقم المطلوب.

---

## الترخيص

هذا المشروع مرخّص بموجب [ترخيص MIT](LICENSE).

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

باختصار: أنت حر في الاستخدام والنسخ والتعديل والدمج والنشر والتوزيع والترخيص و/أو بيع هذا البرنامج، بشرط أن تضم إشعار حقوق النشر وإشعار الترخيص. يُقدَّم البرنامج "كما هو"، دون أي ضمان من أي نوع.
