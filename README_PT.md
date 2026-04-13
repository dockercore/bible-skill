# Ferramenta de Busca na Bíblia Chinesa

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.6+](https://img.shields.io/badge/Python-3.6%2B-blue.svg)](https://www.python.org/)

[中文](README.md) | [English](README_EN.md) | Português

Uma ferramenta local e offline de busca na Bíblia Chinesa (Versão Union / 和合本). Consulte versículos por nome do livro, capítulo, versículo ou palavra-chave — zero dependências, pronta para uso.

---

## Sumário

- [Funcionalidades](#funcionalidades)
- [Requisitos](#requisitos)
- [Instalação](#instalação)
  - [Opção 1: Instalação com Um Clique (Recomendada)](#opção-1-instalação-com-um-clique-recomendada)
  - [Opção 2: Instalação Manual](#opção-2-instalação-manual)
  - [Opção 3: Clonar e Executar](#opção-3-clonar-e-executar)
- [Uso](#uso)
  - [1. Listar Todos os 66 Livros](#1-listar-todos-os-66-livros)
  - [2. Ver Informações do Livro](#2-ver-informações-do-livro)
  - [3. Ver um Capítulo Inteiro](#3-ver-um-capítulo-inteiro)
  - [4. Ver um Único Versículo](#4-ver-um-único-versículo)
  - [5. Ver um Intervalo de Versículos](#5-ver-um-intervalo-de-versículos)
  - [6. Busca de Texto Completo](#6-busca-de-texto-completo)
- [Abreviações dos Nomes dos Livros](#abreviações-dos-nomes-dos-livros)
- [Formato dos Dados](#formato-dos-dados)
- [Estrutura de Arquivos](#estrutura-de-arquivos)
- [Uso com Agentes de IA](#uso-com-agentes-de-ia)
  - [Claude Code](#claude-code)
  - [Hermes Agent](#hermes-agent)
  - [OpenClaw](#openclaw)
- [FAQ](#faq)
- [Licença](#licença)

---

## Funcionalidades

- 📖 Listar todos os 66 livros da Bíblia
- 🔍 Consultar versículos por nome completo ou abreviação (capítulo inteiro, versículo único, intervalo de versículos)
- 🗂️ Ver informações do livro (quantidade de capítulos, quantidade de versículos)
- 🔎 Busca por palavra-chave de texto completo (retorna até 20 resultados por padrão)
- 📦 Script de instalação com um clique com arquivo de dados incluído
- 🚀 Zero dependências de terceiros — apenas Python 3.6+ é necessário

---

## Requisitos

| Item | Requisito |
|------|-----------|
| Python | 3.6 ou superior |
| SO | macOS / Linux / Windows |
| Espaço em Disco | ~5 MB (dados + scripts) |
| Dependências | Nenhuma |

---

## Instalação

### Opção 1: Instalação com Um Clique (Recomendada)

Ideal para iniciantes. Três comandos e pronto.

**Passo 1: Verifique se o Python 3 está instalado**

```bash
python3 --version
```

Se você receber `command not found`, instale o Python 3 primeiro:

| Sistema | Como Instalar |
|---------|---------------|
| macOS | `brew install python3` ou baixe de [python.org](https://www.python.org/downloads/) |
| Ubuntu / Debian | `sudo apt update && sudo apt install python3` |
| Windows | Baixe de [python.org](https://www.python.org/downloads/) — **certifique-se de marcar** "Add Python to PATH" durante a instalação |

**Passo 2: Clone este repositório**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

> Não tem git? Clique no botão verde "Code" nesta página → "Download ZIP", e depois extraia.

**Passo 3: Execute o script de instalação**

```bash
bash scripts/install.sh
```

O script de instalação executa estes passos automaticamente:

```
|[Step 1/6] Check Python 3           → Verify Python 3 is available
|[Step 2/6] Set Bible data directory  → Default: ~/bible-data/
|[Step 3/6] Extract Bible text data   → Unpack 66 .txt files from bundled archive
|[Step 4/6] Create skill directory    → Create ~/.hermes/skills/creative/bible/
|[Step 5/6] Configure search script   → Auto-update data path
|[Step 6/6] Verify installation       → Run 4 tests to confirm everything works
```

Para usar um diretório de dados personalizado:

```bash
bash scripts/install.sh /your/custom/path
```

---

### Opção 2: Instalação Manual

Para usuários que desejam entender cada passo.

**Passo 1: Clone este repositório**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

**Passo 2: Crie o diretório de dados e extraia os dados**

```bash
mkdir -p ~/bible-data
tar xzf assets/bible-txt-file.tar.gz -C ~/bible-data --strip-components=1
```

**Passo 3: Verifique a quantidade de arquivos**

```bash
ls ~/bible-data/*.txt | wc -l
```

Deve exibir `66`. Se não, baixe este projeto novamente.

**Passo 4: Atualize o caminho dos dados no script**

Abra `scripts/bible_search.py` e encontre esta linha próximo ao topo:

```python
BIBLE_DIR = os.path.expanduser("~/workspace/20260413/bible-txt-file")
```

Altere para o caminho real dos seus dados:

```python
BIBLE_DIR = os.path.expanduser("~/bible-data")
```

> 💡 Você também pode usar um caminho absoluto, ex.: `BIBLE_DIR = "/Users/yourname/bible-data"`

**Passo 5: Verifique a instalação**

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

Todos os 4 testes passando significa que a instalação foi bem-sucedida!

---

### Opção 3: Clonar e Executar

Para desenvolvedores que desejam usar os scripts diretamente sem o script de instalação:

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

## Uso

Formato básico do comando:

```bash
python3 scripts/bible_search.py <command>
```

> 💡 Os exemplos abaixo assumem que você está no diretório raiz do projeto. Caso contrário, use o caminho completo para o script.

### 1. Listar Todos os 66 Livros

```bash
python3 scripts/bible_search.py list
```

Exemplo de saída:
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

### 2. Ver Informações do Livro

Suporta nomes completos em chinês ou abreviações:

```bash
python3 scripts/bible_search.py info 创世记
python3 scripts/bible_search.py info 太
```

Exemplo de saída:
```
【创世记】共 50 章，1533 节
【马太福音】共 28 章，1071 节
```

### 3. Ver um Capítulo Inteiro

```bash
python3 scripts/bible_search.py 创世记 1
python3 scripts/bible_search.py 太 5
python3 scripts/bible_search.py 诗 23
```

Exemplo de saída:
```
【诗篇 第23章】
1 耶和华是我的牧者，我必不至缺乏。
2 他使我躺卧在青草地上，领我在可安歇的水边。
...
```

### 4. Ver um Único Versículo

Formato: `NomeDoLivro Capítulo:Versículo`

```bash
python3 scripts/bible_search.py 创 1:1
python3 scripts/bible_search.py 约 3:16
python3 scripts/bible_search.py 诗 23:1
```

Exemplo de saída:
```
【约翰福音 3:16】
16 "　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
```

### 5. Ver um Intervalo de Versículos

Formato: `NomeDoLivro Capítulo:VersículoInício-VersículoFim`

```bash
python3 scripts/bible_search.py 太 5:3-12
python3 scripts/bible_search.py 创 1:1-5
```

Exemplo de saída:
```
【马太福音 5:3-12】
3 虚心的人有福了！因为天国是他们的。
4 哀恸的人有福了！因为他们必得安慰。
...
```

### 6. Busca de Texto Completo

Busque em todos os 66 livros por versículos que contenham uma palavra-chave:

```bash
python3 scripts/bible_search.py search 耶和华是我的牧者
python3 scripts/bible_search.py search 神爱世人
python3 scripts/bible_search.py search 以马内利
```

Exemplo de saída:
```
【约翰福音 3:16】"　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
【约翰一书 4:9】　神差他独生子到世间来，使我们借着他得生，　神爱我们的心在此就显明了。
...
```

> 💡 A busca retorna até 20 resultados por padrão. Para alterar isso, abra `scripts/bible_search.py`, encontre `search_bible(keyword, max_results=20)`, e altere `20` para o número desejado.

---

## Abreviações dos Nomes dos Livros

A ferramenta suporta tanto nomes completos em chinês quanto abreviações comuns:

### Antigo Testamento (39 Livros)

| Abrev | Nome Completo (Chinês) | Nome em Inglês | Abrev | Nome Completo (Chinês) | Nome em Inglês |
|-------|------------------------|-----------------|-------|------------------------|-----------------|
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

### Novo Testamento (27 Livros)

| Abrev | Nome Completo (Chinês) | Nome em Inglês | Abrev | Nome Completo (Chinês) | Nome em Inglês |
|-------|------------------------|-----------------|-------|------------------------|-----------------|
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

## Formato dos Dados

Este projeto utiliza o texto da Bíblia em Chinês Versão Union (和合本, CUV), armazenado como 66 arquivos de texto puro.

### Nomenclatura dos Arquivos

`Número+NomeDoLivro.txt`, numerados de 1 a 66:

```
1创世记.txt   2出埃及记.txt   3利未记.txt   ...   66启示录.txt
```

### Formato do Conteúdo dos Arquivos

Dentro de cada arquivo, **cada linha representa um capítulo inteiro**:

```
第X章1Texto do versículo um2Texto do versículo dois3Texto do versículo três...NTexto do último versículo
```

Regras:
- A linha começa com `第X章` (X é um numeral arábico, ex.: `第1章`, `第23章`)
- Imediatamente seguido pelo número do versículo (dígitos) + texto do versículo
- **Sem espaço** entre o número do versículo e o texto
- Após o término de um versículo, o número do próximo versículo segue imediatamente
- Cada capítulo ocupa exatamente uma linha (sem quebras de linha dentro de um capítulo)
- Codificação do arquivo: **UTF-8**

Exemplo real (Gênesis 1:1-5):

```
第1章1起初　神创造天地。2地是空虚混沌，渊面黑暗；　神的灵运行在水面上。3　神说："要有光。"就有了光。4　神看光是好的，就把光暗分开了。5　神称光为"昼"，称暗为"夜"。有晚上，有早晨，这是头一日。
```

Se você tiver dados da Bíblia em um formato diferente, consulte [SKILL.md](SKILL.md) para um script de conversão.

---

## Estrutura de Arquivos

```
bible-skill/
├── README.md                     ← Este arquivo (Chinês)
├── README_EN.md                  ← Documentação em Inglês
├── README_PT.md                  ← Documentação em Português
├── LICENSE                       ← Licença MIT
├── SKILL.md                      ← Documento de skill do Hermes Agent (guia detalhado de instalação manual)
├── .gitignore
├── assets/
│   └── bible-txt-file.tar.gz     ← Arquivo de dados da Bíblia (66 livros, ~1.2 MB)
└── scripts/
    ├── bible_search.py           ← Script de busca principal (Python 3, zero dependências)
    └── install.sh                ← Script de instalação com um clique
```

---

## Uso com Agentes de IA

Este projeto foi projetado para se integrar com assistentes de codificação por IA, permitindo que a IA consulte e cite versículos bíblicos diretamente. Abaixo estão os guias de configuração para Claude Code, Hermes Agent e OpenClaw.

### Claude Code

Claude Code é o assistente de codificação por IA de linha de comando da Anthropic. Você pode ensiná-lo a usar a ferramenta de busca bíblica através de um arquivo CLAUDE.md.

**Passo 1: Instale os Dados da Bíblia**

```bash
# Clone the repo and run the install script
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

**Passo 2: Crie o CLAUDE.md na raiz do seu projeto**

Crie um arquivo `CLAUDE.md` na raiz do seu projeto (ou qualquer diretório de trabalho) com o seguinte conteúdo:

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

**Passo 3: Use**

Pergunte ao Claude Code em linguagem natural:

```
> Look up John 3:16
> Search for Bible verses about "grace"
> List all books of the Bible
```

Claude Code chamará automaticamente o script de busca com base nas instruções do CLAUDE.md.

> **Dica**: Se o caminho de instalação não for o padrão `/usr/local/share/bible-txt-file/`, substitua os caminhos no CLAUDE.md pelo seu caminho real. Teste com `python3 scripts/bible_search.py info Genesis` para verificar se funciona.

---

### Hermes Agent

O Hermes Agent possui um sistema de skills integrado — este repositório é, em si, um pacote de skill projetado para o Hermes.

**Opção 1: Carregamento automático via SKILL.md (Recomendado)**

1. Clone este repositório no diretório de skills do Hermes:

```bash
git clone https://github.com/dockercore/bible-skill.git ~/.hermes/skills/bible
```

2. O Hermes Agent carrega automaticamente `~/.hermes/skills/bible/SKILL.md` na inicialização — nenhuma configuração extra é necessária.

3. Instale os dados da Bíblia:

```bash
cd ~/.hermes/skills/bible
bash scripts/install.sh
```

4. Basta conversar com o Hermes:

```
Look up Psalm 23
Search for Bible verses about "peace"
```

**Opção 2: Caminho de Skill Personalizado**

Se você preferir um local diferente, adicione o caminho do skill na sua configuração do Hermes:

```yaml
skills:
  - path: /your/custom/path/bible-skill/SKILL.md
```

Então execute o script de instalação:

```bash
cd /your/custom/path/bible-skill
bash scripts/install.sh
```

> **Dica**: O SKILL.md já contém instruções completas de instalação e uso. Assim que o Hermes carregá-lo, ele entenderá automaticamente como invocar a ferramenta. Se você alterar o caminho de instalação, atualize a variável `BIBLE_DIR` no SKILL.md de acordo.

---

### OpenClaw

OpenClaw é um framework de Agente de IA de código aberto que suporta a integração de capacidades externas via MCP (Model Context Protocol) ou ferramentas personalizadas.

**Opção 1: Integração de Ferramenta Personalizada**

1. Instale os dados da Bíblia e o script de busca:

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

2. Adicione a ferramenta ao seu arquivo de configuração do OpenClaw (tipicamente `tools.yaml` ou `config.yaml`):

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

3. Reinicie o OpenClaw e use:

```
Please look up John 3:16
```

**Opção 2: Integração via MCP Server**

Se você preferir a abordagem MCP, crie um wrapper simples de MCP Server:

1. Crie `/usr/local/share/bible-txt-file/bible_mcp_server.py`:

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

2. Registre o MCP Server na sua configuração do OpenClaw:

```yaml
mcp_servers:
  - name: bible-search
    command: "python3"
    args: ["/usr/local/share/bible-txt-file/bible_mcp_server.py"]
    transport: stdio
```

3. Reinicie o OpenClaw — a IA agora pode consultar a Bíblia via protocolo MCP.

> **Dica**: A Opção 1 é mais simples e ótima para uma configuração rápida; a Opção 2 é mais padronizada e melhor para configurações multi-agente. Escolha com base nas suas necessidades.

---

## FAQ

### P: `python3: command not found`

O Python 3 não está instalado. Consulte [Requisitos](#requisitos) para instruções de instalação.

### P: `No such file or directory`

O caminho do diretório de dados da Bíblia está incorreto. Verifique a variável `BIBLE_DIR` em `scripts/bible_search.py` e certifique-se de que o diretório existe e contém 66 arquivos .txt.

### P: `未找到卷名: xxx` (Nome do livro não encontrado)

O nome do livro ou abreviação que você digitou não está na tabela de mapeamento. Consulte [Abreviações dos Nomes dos Livros](#abreviações-dos-nomes-dos-livros), ou adicione uma abreviação personalizada ao dicionário `BOOK_MAP` em `scripts/bible_search.py`.

### P: Os números dos versículos estão embaralhados ou o conteúdo está incompleto

O formato do arquivo .txt está incorreto. Verifique de acordo com a seção [Formato dos Dados](#formato-dos-dados).

### P: `Permission denied`

O script não tem permissão de execução. Execute:

```bash
chmod +x scripts/bible_search.py
```

### P: Resultados de busca insuficientes

A busca retorna até 20 resultados por padrão. Abra `scripts/bible_search.py`, encontre `search_bible(keyword, max_results=20)`, e altere `20` para o número desejado.

---

## Licença

Este projeto está licenciado sob a [Licença MIT](LICENSE).

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

Em resumo: você é livre para usar, copiar, modificar, mesclar, publicar, distribuir, sublicenciar e/ou vender este software, desde que inclua o aviso de direitos autorais e o aviso de licença. O software é fornecido "como está", sem qualquer tipo de garantia.
