# Outil de recherche dans la Bible chinoise

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.6+](https://img.shields.io/badge/Python-3.6%2B-blue.svg)](https://www.python.org/)

[Français](README_FR.md) | [中文](README.md) | [English](README_EN.md)

Un outil local hors ligne de recherche dans la Bible chinoise (Version Union / 和合本). Recherchez des versets par nom de livre, chapitre, verset ou mot-clé — zéro dépendance, prêt à l'emploi.

---

## Table des matières

- [Fonctionnalités](#fonctionnalités)
- [Prérequis](#prérequis)
- [Installation](#installation)
  - [Option 1 : Installation en un clic (Recommandée)](#option-1--installation-en-un-clic-recommandée)
  - [Option 2 : Installation manuelle](#option-2--installation-manuelle)
  - [Option 3 : Cloner et exécuter](#option-3--cloner-et-exécuter)
- [Utilisation](#utilisation)
  - [1. Lister les 66 livres](#1-lister-les-66-livres)
  - [2. Afficher les informations d'un livre](#2-afficher-les-informations-dun-livre)
  - [3. Afficher un chapitre entier](#3-afficher-un-chapitre-entier)
  - [4. Afficher un verset unique](#4-afficher-un-verset-unique)
  - [5. Afficher une plage de versets](#5-afficher-une-plage-de-versets)
  - [6. Recherche en texte intégral](#6-recherche-en-texte-intégral)
- [Abréviations des noms de livres](#abréviations-des-noms-de-livres)
- [Format des données](#format-des-données)
- [Structure des fichiers](#structure-des-fichiers)
- [Utilisation avec des agents IA](#utilisation-avec-des-agents-ia)
  - [Claude Code](#claude-code)
  - [Hermes Agent](#hermes-agent)
  - [OpenClaw](#openclaw)
- [FAQ](#faq)
- [Licence](#licence)

---

## Fonctionnalités

- 📖 Lister les 66 livres de la Bible
- 🔍 Rechercher des versets par nom complet ou abréviation (chapitre entier, verset unique, plage de versets)
- 🗂️ Afficher les informations d'un livre (nombre de chapitres, nombre de versets)
- 🔎 Recherche en texte intégral par mot-clé (renvoie jusqu'à 20 résultats par défaut)
- 📦 Script d'installation en un clic avec archive de données intégrée
- 🚀 Zéro dépendance tierce — seul Python 3.6+ est requis

---

## Prérequis

| Élément | Prérequis |
|---------|-----------|
| Python | 3.6 ou supérieur |
| OS | macOS / Linux / Windows |
| Espace disque | ~5 Mo (données + scripts) |
| Dépendances | Aucune |

---

## Installation

### Option 1 : Installation en un clic (Recommandée)

Idéal pour les débutants. Trois commandes et c'est terminé.

**Étape 1 : Vérifier que Python 3 est installé**

```bash
python3 --version
```

Si vous obtenez `command not found`, installez d'abord Python 3 :

| Système | Comment installer |
|---------|-------------------|
| macOS | `brew install python3` ou télécharger depuis [python.org](https://www.python.org/downloads/) |
| Ubuntu / Debian | `sudo apt update && sudo apt install python3` |
| Windows | Télécharger depuis [python.org](https://www.python.org/downloads/) — **assurez-vous de cocher** « Add Python to PATH » lors de l'installation |

**Étape 2 : Cloner ce dépôt**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

> Pas de git ? Cliquez sur le bouton vert « Code » sur cette page → « Download ZIP », puis décompressez.

**Étape 3 : Exécuter le script d'installation**

```bash
bash scripts/install.sh
```

Le script d'installation effectue automatiquement les étapes suivantes :

```
|[Step 1/6] Check Python 3           → Verify Python 3 is available
|[Step 2/6] Set Bible data directory  → Default: ~/bible-data/
|[Step 3/6] Extract Bible text data   → Unpack 66 .txt files from bundled archive
|[Step 4/6] Create skill directory    → Create ~/.hermes/skills/creative/bible/
|[Step 5/6] Configure search script   → Auto-update data path
|[Step 6/6] Verify installation       → Run 4 tests to confirm everything works
```

Pour utiliser un répertoire de données personnalisé :

```bash
bash scripts/install.sh /your/custom/path
```

---

### Option 2 : Installation manuelle

Pour les utilisateurs qui souhaitent comprendre chaque étape.

**Étape 1 : Cloner ce dépôt**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

**Étape 2 : Créer le répertoire de données et extraire les données**

```bash
mkdir -p ~/bible-data
tar xzf assets/bible-txt-file.tar.gz -C ~/bible-data --strip-components=1
```

**Étape 3 : Vérifier le nombre de fichiers**

```bash
ls ~/bible-data/*.txt | wc -l
```

Le résultat devrait être `66`. Si ce n'est pas le cas, re-téléchargez ce projet.

**Étape 4 : Mettre à jour le chemin des données dans le script**

Ouvrez `scripts/bible_search.py` et trouvez cette ligne vers le début :

```python
BIBLE_DIR = os.path.expanduser("~/workspace/20260413/bible-txt-file")
```

Modifiez-la avec votre chemin de données réel :

```python
BIBLE_DIR = os.path.expanduser("~/bible-data")
```

> 💡 Vous pouvez aussi utiliser un chemin absolu, par ex. `BIBLE_DIR = "/Users/yourname/bible-data"`

**Étape 5 : Vérifier l'installation**

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

Les 4 tests réussis signifient que l'installation est réussie !

---

### Option 3 : Cloner et exécuter

Pour les développeurs qui souhaitent utiliser les scripts directement sans le script d'installation :

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

## Utilisation

Format de commande de base :

```bash
python3 scripts/bible_search.py <command>
```

> 💡 Les exemples ci-dessous supposent que vous êtes dans le répertoire racine du projet. Sinon, utilisez le chemin complet vers le script.

### 1. Lister les 66 livres

```bash
python3 scripts/bible_search.py list
```

Exemple de sortie :
```
旧约（39卷）：
   1 创世记
   2 出埃及记
   3 利未记
   ...
新约（27卷）：
  40 马太福音
  41 马可福音
  ...
```

### 2. Afficher les informations d'un livre

Prend en charge les noms chinois complets ou les abréviations :

```bash
python3 scripts/bible_search.py info 创世记
python3 scripts/bible_search.py info 太
```

Exemple de sortie :
```
【创世记】共 50 章，1533 节
【马太福音】共 28 章，1071 节
```

### 3. Afficher un chapitre entier

```bash
python3 scripts/bible_search.py 创世记 1
python3 scripts/bible_search.py 太 5
python3 scripts/bible_search.py 诗 23
```

Exemple de sortie :
```
【诗篇 第23章】
1 耶和华是我的牧者，我必不至缺乏。
2 他使我躺卧在青草地上，领我在可安歇的水边。
...
```

### 4. Afficher un verset unique

Format : `NomDuLivre Chapitre:Verset`

```bash
python3 scripts/bible_search.py 创 1:1
python3 scripts/bible_search.py 约 3:16
python3 scripts/bible_search.py 诗 23:1
```

Exemple de sortie :
```
【约翰福音 3:16】
16 "　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
```

### 5. Afficher une plage de versets

Format : `NomDuLivre Chapitre:VersetDébut-VersetFin`

```bash
python3 scripts/bible_search.py 太 5:3-12
python3 scripts/bible_search.py 创 1:1-5
```

Exemple de sortie :
```
【马太福音 5:3-12】
3 虚心的人有福了！因为天国是他们的。
4 哀恸的人有福了！因为他们必得安慰。
...
```

### 6. Recherche en texte intégral

Recherchez dans les 66 livres les versets contenant un mot-clé :

```bash
python3 scripts/bible_search.py search 耶和华是我的牧者
python3 scripts/bible_search.py search 神爱世人
python3 scripts/bible_search.py search 以马内利
```

Exemple de sortie :
```
【约翰福音 3:16】"　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
【约翰一书 4:9】　神差他独生子到世间来，使我们借着他得生，　神爱我们的心在此就显明了。
...
```

> 💡 La recherche renvoie jusqu'à 20 résultats par défaut. Pour modifier cela, ouvrez `scripts/bible_search.py`, trouvez `search_bible(keyword, max_results=20)`, et remplacez `20` par le nombre souhaité.

---

## Abréviations des noms de livres

L'outil prend en charge les noms chinois complets et les abréviations courantes :

### Ancien Testament (39 livres)

| Abrév | Nom complet (chinois) | Nom anglais | Abrév | Nom complet (chinois) | Nom anglais |
|-------|----------------------|-------------|-------|----------------------|-------------|
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

### Nouveau Testament (27 livres)

| Abrév | Nom complet (chinois) | Nom anglais | Abrév | Nom complet (chinois) | Nom anglais |
|-------|----------------------|-------------|-------|----------------------|-------------|
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

## Format des données

Ce projet utilise le texte de la Bible en chinois Version Union (和合本, CUV), stocké sous forme de 66 fichiers texte brut.

### Nommage des fichiers

`Numéro+NomDuLivre.txt`, numérotés de 1 à 66 :

```
1创世记.txt   2出埃及记.txt   3利未记.txt   ...   66启示录.txt
```

### Format du contenu des fichiers

Dans chaque fichier, **chaque ligne représente un chapitre entier** :

```
第X章1Texte du premier verset2Texte du deuxième verset3Texte du troisième verset...NTexte du dernier verset
```

Règles :
- La ligne commence par `第X章` (X est un chiffre arabe, par ex. `第1章`, `第23章`)
- Suivi immédiatement du numéro du verset (chiffres) + texte du verset
- **Aucun espace** entre le numéro du verset et le texte
- Après la fin d'un verset, le numéro du verset suivant suit immédiatement
- Chaque chapitre occupe exactement une ligne (aucun saut de ligne dans un chapitre)
- Encodage du fichier : **UTF-8**

Exemple réel (Genèse 1:1-5) :

```
第1章1起初　神创造天地。2地是空虚混沌，渊面黑暗；　神的灵运行在水面上。3　神说："要有光。"就有了光。4　神看光是好的，就把光暗分开了。5　神称光为"昼"，称暗为"夜"。有晚上，有早晨，这是头一日。
```

Si vous disposez de données bibliques dans un format différent, consultez [SKILL.md](SKILL.md) pour un script de conversion.

---

## Structure des fichiers

```
bible-skill/
├── README.md                     ← Ce fichier (chinois)
├── README_EN.md                  ← Documentation en anglais
├── README_FR.md                  ← Documentation en français
├── LICENSE                       ← Licence MIT
├── SKILL.md                      ← Doc du skill Hermes Agent (guide d'installation manuelle détaillé)
├── .gitignore
├── assets/
│   └── bible-txt-file.tar.gz     ← Archive des données bibliques (66 livres, ~1,2 Mo)
└── scripts/
    ├── bible_search.py           ← Script de recherche principal (Python 3, zéro dépendance)
    └── install.sh                ← Script d'installation en un clic
```

---

## Utilisation avec des agents IA

Ce projet est conçu pour s'intégrer aux assistants de codage IA, permettant à l'IA de rechercher et de citer directement des versets bibliques. Ci-dessous, les guides de configuration pour Claude Code, Hermes Agent et OpenClaw.

### Claude Code

Claude Code est l'assistant de codage IA en ligne de commande d'Anthropic. Vous pouvez lui apprendre à utiliser l'outil de recherche biblique via un fichier CLAUDE.md.

**Étape 1 : Installer les données bibliques**

```bash
# Clone the repo and run the install script
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

**Étape 2 : Créer CLAUDE.md à la racine de votre projet**

Créez un fichier `CLAUDE.md` à la racine de votre projet (ou dans tout répertoire de travail) avec le contenu suivant :

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

**Étape 3 : Utiliser**

Posez vos questions à Claude Code en langage naturel :

```
> Look up John 3:16
> Search for Bible verses about "grace"
> List all books of the Bible
```

Claude Code appellera automatiquement le script de recherche en fonction des instructions du fichier CLAUDE.md.

> **Astuce** : Si le chemin d'installation n'est pas le chemin par défaut `/usr/local/share/bible-txt-file/`, remplacez les chemins dans CLAUDE.md par votre chemin réel. Testez avec `python3 scripts/bible_search.py info Genesis` pour vérifier que cela fonctionne.

---

### Hermes Agent

Hermes Agent dispose d'un système de skills intégré — ce dépôt est lui-même un paquet de skill conçu pour Hermes.

**Option 1 : Chargement automatique via SKILL.md (Recommandé)**

1. Clonez ce dépôt dans le répertoire des skills de Hermes :

```bash
git clone https://github.com/dockercore/bible-skill.git ~/.hermes/skills/bible
```

2. Hermes Agent charge automatiquement `~/.hermes/skills/bible/SKILL.md` au démarrage — aucune configuration supplémentaire n'est nécessaire.

3. Installez les données bibliques :

```bash
cd ~/.hermes/skills/bible
bash scripts/install.sh
```

4. Parlez simplement à Hermes :

```
Look up Psalm 23
Search for Bible verses about "peace"
```

**Option 2 : Chemin de skill personnalisé**

Si vous préférez un emplacement différent, ajoutez le chemin du skill dans votre configuration Hermes :

```yaml
skills:
  - path: /your/custom/path/bible-skill/SKILL.md
```

Puis exécutez le script d'installation :

```bash
cd /your/custom/path/bible-skill
bash scripts/install.sh
```

> **Astuce** : SKILL.md contient déjà des instructions complètes d'installation et d'utilisation. Une fois que Hermes le charge, il comprendra automatiquement comment invoquer l'outil. Si vous modifiez le chemin d'installation, mettez à jour la variable `BIBLE_DIR` dans SKILL.md en conséquence.

---

### OpenClaw

OpenClaw est un framework d'agent IA open source qui prend en charge l'intégration de capacités externes via MCP (Model Context Protocol) ou des outils personnalisés.

**Option 1 : Intégration d'outil personnalisé**

1. Installez les données bibliques et le script de recherche :

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

2. Ajoutez l'outil à votre fichier de configuration OpenClaw (généralement `tools.yaml` ou `config.yaml`) :

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

3. Redémarrez OpenClaw et utilisez :

```
Please look up John 3:16
```

**Option 2 : Intégration via serveur MCP**

Si vous préférez l'approche MCP, créez un simple encapsuleur de serveur MCP :

1. Créez `/usr/local/share/bible-txt-file/bible_mcp_server.py` :

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

2. Enregistrez le serveur MCP dans votre configuration OpenClaw :

```yaml
mcp_servers:
  - name: bible-search
    command: "python3"
    args: ["/usr/local/share/bible-txt-file/bible_mcp_server.py"]
    transport: stdio
```

3. Redémarrez OpenClaw — l'IA peut maintenant interroger la Bible via le protocole MCP.

> **Astuce** : L'Option 1 est plus simple et idéale pour une configuration rapide ; l'Option 2 est plus standardisée et mieux adaptée aux configurations multi-agents. Choisissez selon vos besoins.

---

## FAQ

### Q : `python3: command not found`

Python 3 n'est pas installé. Consultez [Prérequis](#prérequis) pour les instructions d'installation.

### Q : `No such file or directory`

Le chemin du répertoire des données bibliques est incorrect. Vérifiez la variable `BIBLE_DIR` dans `scripts/bible_search.py` et assurez-vous que le répertoire existe et contient 66 fichiers .txt.

### Q : `未找到卷名: xxx` (Nom de livre non trouvé)

Le nom de livre ou l'abréviation que vous avez saisi n'est pas dans la table de correspondance. Consultez [Abréviations des noms de livres](#abréviations-des-noms-de-livres), ou ajoutez une abréviation personnalisée au dictionnaire `BOOK_MAP` dans `scripts/bible_search.py`.

### Q : Les numéros de versets sont illisibles ou le contenu est incomplet

Le format du fichier .txt est incorrect. Vérifiez par rapport à la section [Format des données](#format-des-données).

### Q : `Permission denied`

Le script n'a pas la permission d'exécution. Exécutez :

```bash
chmod +x scripts/bible_search.py
```

### Q : Pas assez de résultats de recherche

La recherche renvoie jusqu'à 20 résultats par défaut. Ouvrez `scripts/bible_search.py`, trouvez `search_bible(keyword, max_results=20)`, et remplacez `20` par le nombre souhaité.

---

## Licence

Ce projet est sous licence [MIT License](LICENSE).

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

En résumé : vous êtes libre d'utiliser, copier, modifier, fusionner, publier, distribuer, concéder sous licence et/ou vendre ce logiciel, à condition d'inclure l'avis de copyright et l'avis de licence. Le logiciel est fourni « en l'état », sans aucune garantie d'aucune sorte.
