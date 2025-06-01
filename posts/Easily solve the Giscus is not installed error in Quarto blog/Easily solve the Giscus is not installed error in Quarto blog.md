---
title: "轻松解决 Quarto 博客中的 'Giscus is not installed' 报错"
description: |
  当你为 Quarto 博客切换新主题时遇到 "Giscus is not installed" 错误？本教程详细介绍了问题原因，
  并提供两种解决方案：正确配置 Giscus 评论系统或完全禁用评论功能。
date: "2025-06-01"
categories: [Quarto, Giscus, Comments, Blog, Tutorial, "GitHub Discussions", Troubleshooting]
image: featured.png
image-alt: |
  Quarto 博客界面显示 Giscus 评论系统配置，背景为代码编辑器和 GitHub Discussions 界面。
toc-depth: 3
---

> 轻松解决 Quarto 博客中的 "Giscus is not installed" 报错

当你好不容易地为你的 Quarto 博客切换了一个新主题，却突然看到一个恼人的错误信息："An error occurred: giscus is not installed on this repository"，这确实会让人有些沮丧。

别担心，这个问题很常见，而且通常有明确的解决方案。本教程将带你了解问题的原因，并提供两种主要的解决路径：正确配置 Giscus 或完全禁用它。

## 理解报错原因

Giscus 是一个基于 GitHub Discussions 的评论系统。当你的 Quarto 博客（或特定主题）尝试加载 Giscus 时，如果以下任一条件未满足，就会出现上述错误：

1.  **Giscus 应用未安装**：你没有在你的 GitHub 仓库上安装 Giscus 应用并授权其访问。
2.  **GitHub Discussions 未启用**：你的目标 GitHub 仓库没有启用 "Discussions" 功能。
3.  **配置不正确**：`_quarto.yml` 文件中的 Giscus 配置（如仓库名、repo-id、category-id 等）不正确或不完整。

新主题往往默认启用了 Giscus，如果你之前没有使用过或配置过，这个报错就会浮现。

## 解决方案一：正确配置并使用 Giscus 评论系统

如果你希望在博客中使用评论功能，并且 Giscus 是你的选择，请按照以下步骤操作：

**前提条件：**

*   你拥有一个 GitHub 仓库（通常是你博客的源文件仓库）。
*   在该仓库的 "Settings" -> "General" -> "Features" 中，确保 "Discussions" 功能已勾选启用。
*   在仓库的 "Discussions" 标签页下，创建一个或选择一个已有的 "Category" (分类) 来存放评论，例如 "Blog Comments" 或 "General"。

**步骤：**

1.  **访问 Giscus 官网**：[https://giscus.app/](https://giscus.app/)
2.  **配置 Giscus**：
    *   **Repository**: 输入你的 GitHub 仓库名，格式为 `your-username/your-repo-name` (例如：`jixing475/jixingBlog`)。
    *   **Page ↔️ Discussion Mapping**: 选择一个映射方式，"pathname" 是常用选项。
    *   **Discussion Category**: 选择你在 GitHub Discussions 中创建的那个分类 (例如：`General`)。
    *   **Features (可选)**: 根据需要勾选 Reactions, Emit discussion metadata 等。
    *   **Theme**: 选择一个你喜欢的主题 (例如：`dark_dimmed`)。
    *   **Lang (可选)**: 选择语言 (例如：`en`)。
3.  **获取配置参数**：完成上述配置后，Giscus 网站会生成一段 `<script>` 标签。仔细查看这段代码，你需要从中提取以下 `data-*` 属性的值：
    *   `data-repo`
    *   `data-repo-id`
    *   `data-category`
    *   `data-category-id`
    *   以及你选择的其他配置如 `data-mapping`, `data-theme`, `data-lang` 等。
4.  **更新 `_quarto.yml` 文件**：
    打开你 Quarto 项目根目录下的 `_quarto.yml` 文件，找到或添加 `comments` 配置块，并填入你从 Giscus 获取的信息。示例如下：

    ```yaml
    project:
      type: website
    
    website:
      title: "你的博客标题"
      # ... 其他网站配置 ...
    
      comments:
        giscus:
          repo: "jixing475/jixingBlog"         # 对应 data-repo
          repo-id: "R_kgDOOkm1fA"             # 对应 data-repo-id
          category: "General"                 # 对应 data-category
          category-id: "DIC_kwDOOkm1fM4Cq4Dm" # 对应 data-category-id
          mapping: "pathname"                 # 对应 data-mapping
          strict: "0"                         # 对应 data-strict
          reactions-enabled: "1"              # 对应 data-reactions-enabled
          emit-metadata: "0"                  # 对应 data-emit-metadata
          input-position: "bottom"            # 对应 data-input-position
          theme: "dark_dimmed"                # 对应 data-theme
          lang: "en"                          # 对应 data-lang
    # ... 其他配置 ...
    ```

5.  **重新渲染博客**：保存 `_quarto.yml` 文件，然后在终端运行 `quarto render` (或 `quarto preview` 刷新预览)。

现在，你的博客页面应该能正确加载 Giscus 评论区了。

## 解决方案二：禁用评论功能（如果评论对你可有可无）

如果你只是想使用新主题的样式，对评论功能没有需求，或者暂时不想配置它，最简单的办法就是禁用评论。

1.  **编辑 `_quarto.yml` 文件**：
    打开 `_quarto.yml`，找到 `website:` (或 `book:`) 配置部分。
2.  **禁用评论**：
    添加或修改 `comments` 选项为 `false`。

    ```yaml
    project:
      type: website
    
    website:
      title: "你的博客标题"
      # ... 其他网站配置 ...
      comments: false  # <--- 确保这一行存在且设置为 false
      # ... 其他配置，例如 page-footer, navbar ...
    ```

    或者，如果你之前有 `giscus:` 配置块，也可以将其整个注释掉或删除，但 `comments: false` 是更明确和全局的禁用方式。

3.  **重新渲染博客**：保存文件并运行 `quarto render`。

这样，Giscus 的加载尝试将被禁止，报错信息自然也就消失了。

## 疑难解答：如果 `comments: false` 仍然报错怎么办？

如果你设置了 `comments: false` 但错误依旧，请检查：

1.  **页面级配置覆盖**：检查报错页面的 `.qmd` 文件顶部的 YAML Front Matter (两个 `---` 之间的部分)。如果这里有 `comments: true` 或单独的 Giscus 配置，它会覆盖全局设置。请将其删除或也改为 `comments: false`。
2.  **主题强制行为**：极少数情况下，主题可能在其模板中硬编码了评论加载逻辑，或者有独立于 Quarto 标准 `comments` 选项的主题特定评论开关。查阅该主题的文档可能会有所帮助。
3.  **缓存问题**：
    *   删除项目中的 `_site` 文件夹。
    *   删除项目中的 `.quarto` 文件夹 (它可能是隐藏的)。
    *   清除浏览器缓存或使用无痕模式访问。
    *   然后再次运行 `quarto render`。

## 总结

处理 Quarto 中的 Giscus 报错通常不复杂。明确你是否需要评论功能是第一步。如果需要，仔细按照 giscus.app 的指引获取配置并填入 `_quarto.yml`；如果不需要，简单地设置 `comments: false` 就能解决问题。

希望这篇教程能帮你顺利美化并运行你的 Quarto 博客！
