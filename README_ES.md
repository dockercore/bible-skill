# Herramienta de Búsqueda de la Biblia en Chino

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.6+](https://img.shields.io/badge/Python-3.6%2B-blue.svg)](https://www.python.org/)

[Español](README_ES.md) | [中文](README.md) | [English](README_EN.md)

Una herramienta local y sin conexión para buscar en la Biblia en chino (Versión Union / 和合本). Consulta versículos por nombre de libro, capítulo, versículo o palabra clave — cero dependencias, lista para usar.

---

## Tabla de Contenidos

- [Características](#características)
- [Requisitos](#requisitos)
- [Instalación](#instalación)
  - [Opción 1: Instalación con un solo clic (Recomendada)](#opción-1-instalación-con-un-solo-clic-recomendada)
  - [Opción 2: Instalación manual](#opción-2-instalación-manual)
  - [Opción 3: Clonar y ejecutar](#opción-3-clonar-y-ejecutar)
- [Uso](#uso)
  - [1. Listar los 66 libros](#1-listar-los-66-libros)
  - [2. Ver información de un libro](#2-ver-información-de-un-libro)
  - [3. Ver un capítulo completo](#3-ver-un-capítulo-completo)
  - [4. Ver un solo versículo](#4-ver-un-solo-versículo)
  - [5. Ver un rango de versículos](#5-ver-un-rango-de-versículos)
  - [6. Búsqueda de texto completo](#6-búsqueda-de-texto-completo)
- [Abreviaturas de nombres de libros](#abreviaturas-de-nombres-de-libros)
- [Formato de datos](#formato-de-datos)
- [Estructura de archivos](#estructura-de-archivos)
- [Uso con Agentes de IA](#uso-con-agentes-de-ia)
  - [Claude Code](#claude-code)
  - [Hermes Agent](#hermes-agent)
  - [OpenClaw](#openclaw)
- [Preguntas frecuentes](#preguntas-frecuentes)
- [Licencia](#licencia)

---

## Características

- 📖 Listar los 66 libros de la Biblia
- 🔍 Consultar versículos por nombre completo o abreviatura (capítulo completo, versículo individual, rango de versículos)
- 🗂️ Ver información del libro (cantidad de capítulos, cantidad de versículos)
- 🔎 Búsqueda de texto completo por palabra clave (devuelve hasta 20 resultados por defecto)
- 📦 Script de instalación con un solo clic con archivo de datos incluido
- 🚀 Cero dependencias de terceros — solo requiere Python 3.6+

---

## Requisitos

| Elemento | Requisito |
|----------|-----------|
| Python | 3.6 o superior |
| SO | macOS / Linux / Windows |
| Espacio en disco | ~5 MB (datos + scripts) |
| Dependencias | Ninguna |

---

## Instalación

### Opción 1: Instalación con un solo clic (Recomendada)

Ideal para principiantes. Tres comandos y listo.

**Paso 1: Verificar que Python 3 esté instalado**

```bash
python3 --version
```

Si obtiene `command not found`, instale Python 3 primero:

| Sistema | Cómo instalar |
|---------|--------------|
| macOS | `brew install python3` o descargue desde [python.org](https://www.python.org/downloads/) |
| Ubuntu / Debian | `sudo apt update && sudo apt install python3` |
| Windows | Descargue desde [python.org](https://www.python.org/downloads/) — **asegúrese de marcar** "Add Python to PATH" durante la instalación |

**Paso 2: Clonar este repositorio**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

> ¿No tiene git? Haga clic en el botón verde "Code" de esta página → "Download ZIP", luego extraiga el archivo.

**Paso 3: Ejecutar el script de instalación**

```bash
bash scripts/install.sh
```

El script de instalación realiza estos pasos automáticamente:

```
[Paso 1/6] Verificar Python 3           → Confirmar que Python 3 está disponible
[Paso 2/6] Configurar directorio de datos → Predeterminado: ~/bible-data/
[Paso 3/6] Extraer datos bíblicos        → Desempaquetar 66 archivos .txt del archivo incluido
[Paso 4/6] Crear directorio de skill     → Crear ~/.hermes/skills/creative/bible/
[Paso 5/6] Configurar script de búsqueda → Actualizar automáticamente la ruta de datos
[Paso 6/6] Verificar instalación         → Ejecutar 4 pruebas para confirmar que todo funciona
```

Para usar un directorio de datos personalizado:

```bash
bash scripts/install.sh /su/ruta/personalizada
```

---

### Opción 2: Instalación manual

Para usuarios que desean entender cada paso.

**Paso 1: Clonar este repositorio**

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
```

**Paso 2: Crear directorio de datos y extraer los datos**

```bash
mkdir -p ~/bible-data
tar xzf assets/bible-txt-file.tar.gz -C ~/bible-data --strip-components=1
```

**Paso 3: Verificar la cantidad de archivos**

```bash
ls ~/bible-data/*.txt | wc -l
```

Debería mostrar `66`. Si no es así, vuelva a descargar este proyecto.

**Paso 4: Actualizar la ruta de datos en el script**

Abra `scripts/bible_search.py` y busque esta línea cerca del inicio:

```python
BIBLE_DIR = os.path.expanduser("~/workspace/20260413/bible-txt-file")
```

Cámbiela a su ruta de datos real:

```python
BIBLE_DIR = os.path.expanduser("~/bible-data")
```

> 💡 También puede usar una ruta absoluta, por ejemplo `BIBLE_DIR = "/Users/sunombre/bible-data"`

**Paso 5: Verificar la instalación**

```bash
# Prueba 1: Listar los 66 libros
python3 scripts/bible_search.py list

# Prueba 2: Consultar un versículo
python3 scripts/bible_search.py 创 1:1
# Resultado esperado: 【创世记 1:1】
#           1 起初　神创造天地。

# Prueba 3: Búsqueda por palabra clave
python3 scripts/bible_search.py search 神爱世人
# Resultado esperado: Debería incluir Juan 3:16

# Prueba 4: Información del libro
python3 scripts/bible_search.py info 诗篇
# Resultado esperado: 【诗篇】共 150 章，2461 节
```

¡Las 4 pruebas exitosas significan que la instalación fue exitosa!

---

### Opción 3: Clonar y ejecutar

Para desarrolladores que desean usar los scripts directamente sin el script de instalación:

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill

# Extraer datos (necesario antes de la primera ejecución)
mkdir -p ~/bible-data
tar xzf assets/bible-txt-file.tar.gz -C ~/bible-data --strip-components=1

# Actualizar BIBLE_DIR en scripts/bible_search.py, luego:
python3 scripts/bible_search.py 创 1:1
```

---

## Uso

Formato básico del comando:

```bash
python3 scripts/bible_search.py <comando>
```

> 💡 Los ejemplos a continuación asumen que se encuentra en el directorio raíz del proyecto. De lo contrario, use la ruta completa al script.

### 1. Listar los 66 libros

```bash
python3 scripts/bible_search.py list
```

Ejemplo de salida:
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

### 2. Ver información de un libro

Soporta nombres completos en chino o abreviaturas:

```bash
python3 scripts/bible_search.py info 创世记
python3 scripts/bible_search.py info 太
```

Ejemplo de salida:
```
【创世记】共 50 章，1533 节
【马太福音】共 28 章，1071 节
```

### 3. Ver un capítulo completo

```bash
python3 scripts/bible_search.py 创世记 1
python3 scripts/bible_search.py 太 5
python3 scripts/bible_search.py 诗 23
```

Ejemplo de salida:
```
【诗篇 第23章】
1 耶和华是我的牧者，我必不至缺乏。
2 他使我躺卧在青草地上，领我在可安歇的水边。
...
```

### 4. Ver un solo versículo

Formato: `NombreLibro Capítulo:Versículo`

```bash
python3 scripts/bible_search.py 创 1:1
python3 scripts/bible_search.py 约 3:16
python3 scripts/bible_search.py 诗 23:1
```

Ejemplo de salida:
```
【约翰福音 3:16】
16 "　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
```

### 5. Ver un rango de versículos

Formato: `NombreLibro Capítulo:VersículoInicio-VersículoFin`

```bash
python3 scripts/bible_search.py 太 5:3-12
python3 scripts/bible_search.py 创 1:1-5
```

Ejemplo de salida:
```
【马太福音 5:3-12】
3 虚心的人有福了！因为天国是他们的。
4 哀恸的人有福了！因为他们必得安慰。
...
```

### 6. Búsqueda de texto completo

Buscar en los 66 libros versículos que contengan una palabra clave:

```bash
python3 scripts/bible_search.py search 耶和华是我的牧者
python3 scripts/bible_search.py search 神爱世人
python3 scripts/bible_search.py search 以马内利
```

Ejemplo de salida:
```
【约翰福音 3:16】"　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。
【约翰一书 4:9】　神差他独生子到世间来，使我们借着他得生，　神爱我们的心在此就显明了。
...
```

> 💡 La búsqueda devuelve hasta 20 resultados por defecto. Para cambiar esto, abra `scripts/bible_search.py`, busque `search_bible(keyword, max_results=20)` y cambie `20` por el número deseado.

---

## Abreviaturas de nombres de libros

La herramienta soporta tanto nombres completos en chino como abreviaturas comunes:

### Antiguo Testamento (39 libros)

| Abrev. | Nombre completo (chino) | Nombre en inglés | Abrev. | Nombre completo (chino) | Nombre en inglés |
|--------|-------------------------|-------------------|--------|-------------------------|-------------------|
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

### Nuevo Testamento (27 libros)

| Abrev. | Nombre completo (chino) | Nombre en inglés | Abrev. | Nombre completo (chino) | Nombre en inglés |
|--------|-------------------------|-------------------|--------|-------------------------|-------------------|
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

## Formato de datos

Este proyecto utiliza el texto de la Biblia en chino Versión Union (和合本, CUV), almacenado como 66 archivos de texto plano.

### Nomenclatura de archivos

`Número+NombreDelLibro.txt`, numerados del 1 al 66:

```
1创世记.txt   2出埃及记.txt   3利未记.txt   ...   66启示录.txt
```

### Formato del contenido de los archivos

Dentro de cada archivo, **cada línea representa un capítulo completo**:

```
第X章1Texto del versículo uno2Texto del versículo dos3Texto del versículo tres...NTexto del último versículo
```

Reglas:
- La línea comienza con `第X章` (X es un número arábigo, por ejemplo `第1章`, `第23章`)
- Inmediatamente seguido por el número de versículo (dígitos) + texto del versículo
- **Sin espacio** entre el número de versículo y el texto
- Después de que termina un versículo, sigue inmediatamente el número del siguiente versículo
- Cada capítulo ocupa exactamente una línea (sin saltos de línea dentro de un capítulo)
- Codificación del archivo: **UTF-8**

Ejemplo real (Génesis 1:1-5):

```
第1章1起初　神创造天地。2地是空虚混沌，渊面黑暗；　神的灵运行在水面上。3　神说："要有光。"就有了光。4　神看光是好的，就把光暗分开了。5　神称光为"昼"，称暗为"夜"。有晚上，有早晨，这是头一日。
```

Si tiene datos bíblicos en un formato diferente, consulte [SKILL.md](SKILL.md) para ver un script de conversión.

---

## Estructura de archivos

```
bible-skill/
├── README.md                     ← Este archivo (chino)
├── README_EN.md                  ← Documentación en inglés
├── README_ES.md                  ← Documentación en español
├── LICENSE                       ← Licencia MIT
├── SKILL.md                      ← Documento de skill de Hermes Agent (guía detallada de instalación manual)
├── .gitignore
├── assets/
│   └── bible-txt-file.tar.gz     ← Archivo de datos bíblicos (66 libros, ~1.2 MB)
└── scripts/
    ├── bible_search.py           ← Script de búsqueda principal (Python 3, cero dependencias)
    └── install.sh                ← Script de instalación con un solo clic
```

---

## Uso con Agentes de IA

Este proyecto está diseñado para integrarse con asistentes de programación de IA, permitiendo a la IA consultar y citar versículos bíblicos directamente. A continuación se presentan las guías de configuración para Claude Code, Hermes Agent y OpenClaw.

### Claude Code

Claude Code es el asistente de programación de IA de línea de comandos de Anthropic. Puede enseñarle a usar la habilidad de búsqueda bíblica mediante un archivo CLAUDE.md.

**Paso 1: Instalar los datos bíblicos**

```bash
# Clonar el repositorio y ejecutar el script de instalación
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

**Paso 2: Crear CLAUDE.md en la raíz de su proyecto**

Cree un archivo `CLAUDE.md` en la raíz de su proyecto (o cualquier directorio de trabajo) con el siguiente contenido:

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

**Paso 3: Usar**

Pregunte a Claude Code en lenguaje natural:

```
> Look up John 3:16
> Search for Bible verses about "grace"
> List all books of the Bible
```

Claude Code llamará automáticamente al script de búsqueda basándose en las instrucciones de CLAUDE.md.

> **Consejo**: Si la ruta de instalación no es la predeterminada `/usr/local/share/bible-txt-file/`, reemplace las rutas en CLAUDE.md con su ruta real. Pruebe con `python3 scripts/bible_search.py info Genesis` para verificar que funciona.

---

### Hermes Agent

Hermes Agent tiene un sistema de habilidades integrado — este repositorio es en sí mismo un paquete de habilidades diseñado para Hermes.

**Opción 1: Carga automática vía SKILL.md (Recomendada)**

1. Clone este repositorio en el directorio de habilidades de Hermes:

```bash
git clone https://github.com/dockercore/bible-skill.git ~/.hermes/skills/bible
```

2. Hermes Agent carga automáticamente `~/.hermes/skills/bible/SKILL.md` al inicio — no se necesita configuración adicional.

3. Instale los datos bíblicos:

```bash
cd ~/.hermes/skills/bible
bash scripts/install.sh
```

4. Simplemente hable con Hermes:

```
Look up Psalm 23
Search for Bible verses about "peace"
```

**Opción 2: Ruta de skill personalizada**

Si prefiere una ubicación diferente, agregue la ruta de la habilidad en su configuración de Hermes:

```yaml
skills:
  - path: /su/ruta/personalizada/bible-skill/SKILL.md
```

Luego ejecute el script de instalación:

```bash
cd /su/ruta/personalizada/bible-skill
bash scripts/install.sh
```

> **Consejo**: SKILL.md ya contiene instrucciones completas de instalación y uso. Una vez que Hermes lo carga, entenderá automáticamente cómo invocar la herramienta. Si cambia la ruta de instalación, actualice la variable `BIBLE_DIR` en SKILL.md en consecuencia.

---

### OpenClaw

OpenClaw es un framework de Agente de IA de código abierto que soporta la integración de capacidades externas vía MCP (Model Context Protocol) o herramientas personalizadas.

**Opción 1: Integración de herramienta personalizada**

1. Instale los datos bíblicos y el script de búsqueda:

```bash
git clone https://github.com/dockercore/bible-skill.git
cd bible-skill
bash scripts/install.sh
```

2. Agregue la herramienta a su archivo de configuración de OpenClaw (típicamente `tools.yaml` o `config.yaml`):

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

3. Reinicie OpenClaw y use:

```
Please look up John 3:16
```

**Opción 2: Integración vía MCP Server**

Si prefiere el enfoque MCP, cree un contenedor simple de MCP Server:

1. Cree `/usr/local/share/bible-txt-file/bible_mcp_server.py`:

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

2. Registre el MCP Server en su configuración de OpenClaw:

```yaml
mcp_servers:
  - name: bible-search
    command: "python3"
    args: ["/usr/local/share/bible-txt-file/bible_mcp_server.py"]
    transport: stdio
```

3. Reinicie OpenClaw — la IA ahora puede consultar la Biblia a través del protocolo MCP.

> **Consejo**: La Opción 1 es más simple y excelente para una configuración rápida; la Opción 2 es más estandarizada y mejor para configuraciones multi-agente. Elija según sus necesidades.

---

## Preguntas frecuentes

### P: `python3: command not found`

Python 3 no está instalado. Consulte [Requisitos](#requisitos) para las instrucciones de instalación.

### P: `No such file or directory`

La ruta del directorio de datos bíblicos es incorrecta. Verifique la variable `BIBLE_DIR` en `scripts/bible_search.py` y asegúrese de que el directorio exista y contenga 66 archivos .txt.

### P: `未找到卷名: xxx` (Nombre de libro no encontrado)

El nombre de libro o abreviatura que ingresó no está en la tabla de mapeo. Consulte [Abreviaturas de nombres de libros](#abreviaturas-de-nombres-de-libros), o agregue una abreviatura personalizada al diccionario `BOOK_MAP` en `scripts/bible_search.py`.

### P: Los números de versículo están distorsionados o el contenido está incompleto

El formato del archivo .txt es incorrecto. Verifique con la sección [Formato de datos](#formato-de-datos).

### P: `Permission denied`

El script no tiene permiso de ejecución. Ejecute:

```bash
chmod +x scripts/bible_search.py
```

### P: No hay suficientes resultados de búsqueda

La búsqueda devuelve hasta 20 resultados por defecto. Abra `scripts/bible_search.py`, busque `search_bible(keyword, max_results=20)` y cambie `20` por el número deseado.

---

## Licencia

Este proyecto está licenciado bajo la [Licencia MIT](LICENSE).

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

En resumen: usted es libre de usar, copiar, modificar, fusionar, publicar, distribuir, sublicenciar y/o vender este software, siempre que incluya el aviso de copyright y el aviso de licencia. El software se proporciona "tal cual", sin garantía de ningún tipo.
