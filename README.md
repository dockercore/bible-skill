# 中文圣经经文查询技能 (Bible Skill)

基于本地 66 卷中文和合本圣经纯文本文件，提供经文查询、检索和引用功能。

## 功能

- 📖 列出全部 66 卷圣经书卷
- 🔍 按卷名/简称查询经文（支持整章、单节、节范围）
- 🗂️ 查看某卷信息（章数、节数）
- 🔎 全文关键词搜索
- 📦 一键安装脚本

## 快速开始

### 一键安装

```bash
bash scripts/install.sh
```

### 手动安装

详见 [SKILL.md](SKILL.md) 中的安装指南。

## 使用示例

```bash
# 列出66卷
python3 scripts/bible_search.py list

# 查询经文
python3 scripts/bible_search.py 创 1:1
python3 scripts/bible_search.py 约 3:16

# 查看整章
python3 scripts/bible_search.py 诗 23

# 节范围
python3 scripts/bible_search.py 太 5:3-12

# 关键词搜索
python3 scripts/bible_search.py search 神爱世人
```

## 卷名简称

支持中文全名和常见简称：创/创世记、出/出埃及记、诗/诗篇、太/马太福音、约/约翰福音、启/启示录 等。

## 文件结构

```
├── SKILL.md                    # 技能文档（含详细安装指南）
├── README.md                   # 本文件
├── assets/
│   └── bible-txt-file.tar.gz   # 圣经数据压缩包（66卷，1.2MB）
└── scripts/
    ├── bible_search.py         # 核心搜索脚本
    └── install.sh              # 一键安装脚本
```

## 系统要求

- Python 3.6+（无第三方依赖）
- macOS / Linux / Windows

## 数据来源

中文和合本（Chinese Union Version, CUV）
