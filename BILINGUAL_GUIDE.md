# 双语网站使用指南 / Bilingual Website Guide

## 概述 / Overview

本网站现已支持中英文双语。所有页面右上角都有语言切换器（EN | 中文）。

## 文件命名规则 / File Naming Convention

### 文章文件 / Article Files
- 英文文章：`*.en.qmd` 或 `*.en.md`
- 中文文章：`*.zh.qmd` 或 `*.zh.md`

### 示例 / Examples
```
posts/my-article/
├── index.en.qmd    # 英文版本
└── index.zh.qmd    # 中文版本

AIDD/2025-09-01/
├── post_all.en.md  # 英文版本
└── post_all.zh.md  # 中文版本
```

## 列表页 / Listing Pages

### Blog
- 英文列表：`blog.en.qmd` - 只显示 `*.en.qmd` 和 `*.en.md` 文章
- 中文列表：`blog.zh.qmd` - 只显示 `*.zh.qmd` 和 `*.zh.md` 文章
- 访问 `blog.html` 会自动重定向到 `blog.en.html`

### AIDD
- 英文列表：`aidd.en.qmd` - 只显示 `*.en.md` 和 `*.en.qmd` 文章
- 中文列表：`aidd.zh.qmd` - 只显示 `*.zh.md` 和 `*.zh.qmd` 文章
- 访问 `aidd.html` 会自动重定向到 `aidd.en.html`

## 添加新文章 / Adding New Articles

### 方式 1：同时创建双语版本 / Create Both Languages
```bash
# 在 posts 或 AIDD 文件夹创建新文章
cd posts/2025-01-01-my-new-post/
touch index.en.qmd index.zh.qmd
```

### 方式 2：只创建一种语言 / Create Single Language
如果暂时只有英文版本，只创建 `.en.qmd` 即可：
```bash
cd AIDD/2025-11-15/
touch article.en.md
# 稍后添加中文翻译
touch article.zh.md
```

**系统会自动适应**：
- 如果某篇文章只有英文版本，它只会出现在英文列表页
- 中文列表页不会显示缺失翻译的文章
- 这样可以灵活地逐步添加翻译

## 语言切换器 / Language Switcher

语言切换器已通过 `_quarto.yml` 全局注入，**无需修改任何 .md 或 .qmd 文件的 YAML frontmatter**。

工作原理：
- 在英文页面（如 `blog.en.html`）显示：**EN** | [中文](#)
- 在中文页面（如 `blog.zh.html`）显示：[EN](#) | **中文**
- 点击链接会切换到对应语言版本

## 主要页面 / Main Pages

| 页面类型 | 英文 | 中文 |
|---------|------|------|
| 首页 | `index.qmd` | `index.zh.qmd` |
| 博客列表 | `blog.en.qmd` | `blog.zh.qmd` |
| AIDD 列表 | `aidd.en.qmd` | `aidd.zh.qmd` |
| 出版物 | `publications.qmd` | `publications.zh.qmd` |

## 渲染网站 / Render Website

```bash
# 渲染整个网站
quarto render

# 或渲染特定页面
quarto render index.qmd
quarto render AIDD/2025-09-01/post_all.en.md
```

## 注意事项 / Notes

1. **不要修改原始 md 的 YAML**：语言切换器是全局注入的，无需在每个文件中添加代码
2. **列表页过滤**：英文和中文列表页会自动过滤对应语言的文章
3. **动态支持**：可以先只创建英文版本，稍后再添加中文翻译
4. **命名规范**：必须使用 `.en` 或 `.zh` 后缀，否则文章不会出现在列表中
5. **图片路径必须使用绝对路径**：在 YAML frontmatter 中的 `image:` 字段必须使用从网站根目录开始的绝对路径

### 图片路径示例

❌ **错误**（相对路径）：
```yaml
image: "post_all_image/cover.png"
```

✅ **正确**（绝对路径）：
```yaml
image: "/AIDD/2025-09-01/post_all_image/cover.png"
```

为什么需要绝对路径？
- 文章内部的图片可以使用相对路径（如 `![](images/fig1.png)`）
- 但列表页的缩略图需要从网站根目录访问，必须使用绝对路径
- 格式：`/栏目文件夹/日期文件夹/图片文件夹/图片名`

## 目录结构 / Directory Structure

```
jixingBlog/
├── index.qmd               # 英文首页
├── index.zh.qmd           # 中文首页
├── blog.qmd               # 重定向到 blog.en.html
├── blog.en.qmd            # 英文博客列表
├── blog.zh.qmd            # 中文博客列表
├── aidd.qmd               # 重定向到 aidd.en.html
├── aidd.en.qmd            # 英文 AIDD 列表
├── aidd.zh.qmd            # 中文 AIDD 列表
├── publications.qmd        # 英文出版物
├── publications.zh.qmd     # 中文出版物
├── posts/
│   └── article/
│       ├── index.en.qmd   # 英文文章
│       └── index.zh.qmd   # 中文文章（可选）
└── AIDD/
    └── 2025-09-01/
        ├── post_all.en.md # 英文文章
        └── post_all.zh.md # 中文文章（可选）
```

## 未来扩展 / Future Extensions

如需添加其他语言（如法语 `.fr`），只需：
1. 在 `_quarto.yml` 的语言切换 JS 中添加新语言判断
2. 创建对应的列表页（如 `blog.fr.qmd`）
3. 创建对应语言的文章（如 `*.fr.qmd`）
