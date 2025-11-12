# Image-Alt 字段图片显示问题修复指南

## 问题描述

在 `_site/aidd.en.html` 等 listing 页面中，部分博文的图片无法正常显示，HTML 代码被转义：

**异常（图片不显示）**：
```html
<p>&lt;img loading='lazy' data-src="/AIDD/..." class="thumbnail-image" alt="..."&gt;</p>
```

**正常（图片显示）**：
```html
<p><img loading="lazy" class="thumbnail-image" alt="..." src="./AIDD/..."></p>
```

## 根本原因

**Quarto 在处理 listing 时，如果 front matter 中的 `image-alt` 字段包含以下特殊字符，会将整个图片标签识别为 HTML 内容并进行转义：**

1. **双引号 `"`** - 最常见的问题
2. **Markdown 格式符号** - 如 `*斜体*`、`**加粗**`、`_斜体_`
3. **HTML 标签** - 如 `<em>`、`<strong>`
4. **HTML 实体** - 如 `&quot;`、`&amp;`

## 受影响的文件列表

根据 `check_image_alt_issues.R` 脚本的检查结果，共发现 **13 个文件**存在问题：

| 序号 | 文件路径 | 问题类型 |
|------|---------|---------|
| 1 | AIDD/2025-08-07/post_all.en.md | 双引号(") |
| 2 | AIDD/2025-08-08_b/post_all.en.md | 双引号(") |
| 3 | AIDD/2025-08-14_a/post_all.en.md | 双引号(") |
| 4 | AIDD/2025-08-14_b/post_all.en.md | 双引号(") |
| 5 | AIDD/2025-08-17_a/post_all.en.md | 双引号(") |
| 6 | AIDD/2025-08-18/post_all.en.md | 双引号(") |
| 7 | AIDD/2025-08-23_a/post_all.en.md | 双引号(") |
| 8 | AIDD/2025-08-23_b/post_all.en.md | 双引号(") |
| 9 | AIDD/2025-09-03/post_all.en.md | 双引号(") |
| 10 | AIDD/2025-09-06/post_all.en.md | 双引号(") |
| 11 | AIDD/2025-09-07/post_all.en.md | 双引号(") |
| 12 | AIDD/2025-09-08/post_all.en.md | Markdown斜体(*), 双引号(") |
| 13 | AIDD/2025-09-09/post_all.en.md | 双引号(") |

详细信息请查看 `image_alt_issues.csv` 文件。

## 修复方案

### 方案 1：替换双引号为单引号（推荐）

将 `image-alt` 中的所有双引号 `"` 替换为单引号 `'`。

**示例**：

修复前：
```yaml
image-alt: |
  generating a physically impossible "stitched-together monster" and revealing...
```

修复后：
```yaml
image-alt: |
  generating a physically impossible 'stitched-together monster' and revealing...
```

### 方案 2：完全移除引号

如果引号不是必需的，可以直接移除。

**示例**：

修复前：
```yaml
image-alt: |
  By modeling molecular docking as a "game" where...
```

修复后：
```yaml
image-alt: |
  By modeling molecular docking as a game where...
```

### 方案 3：移除 Markdown 格式符号

对于包含 Markdown 格式的文本，移除格式符号或替换为普通文本。

**示例**（针对 AIDD/2025-09-08/post_all.en.md）：

修复前：
```yaml
image-alt: |
  By learning a "Chain-of-Thought," PepThink-R1 not only provides results when optimizing cyclic peptides but also explains *why* it made those changes, making the AI's decision process transparent.
```

修复后：
```yaml
image-alt: |
  By learning a 'Chain-of-Thought,' PepThink-R1 not only provides results when optimizing cyclic peptides but also explains why it made those changes, making the AI's decision process transparent.
```

## 修复步骤

1. **运行检查脚本**（已完成）：
   ```bash
   cd /Users/zero/Desktop/zeroverse/easyPKGs/jixingBlog
   Rscript check_image_alt_issues.R
   ```

2. **查看问题文件列表**：
   - 控制台输出
   - `image_alt_issues.csv` 文件

3. **手动修复每个文件**：
   - 打开文件
   - 定位到 `image-alt:` 字段
   - 根据上述方案修复
   - 保存文件

4. **重新编译网站**：
   ```bash
   quarto render
   ```

5. **验证修复**：
   检查 `_site/aidd.en.html` 中对应文章的图片是否正常显示。

## 预防措施

在编写新文章时，请遵循以下规则：

1. ✅ **使用单引号** `'` 代替双引号 `"`
2. ✅ **避免使用 Markdown 格式符号**（`*`、`**`、`_`）
3. ✅ **使用纯文本描述**，不要包含 HTML 标签
4. ✅ **image-alt 应简洁明了**，只描述图片内容

## 脚本说明

`check_image_alt_issues.R` 脚本的功能：
- 扫描所有 `AIDD/**/*.en.md` 文件
- 检查 `image-alt` 字段是否包含特殊字符
- 生成详细报告和 CSV 文件
- 提供修复建议

**使用方法**：
```bash
Rscript check_image_alt_issues.R
```

**输出文件**：
- `image_alt_issues.csv` - 详细的问题文件列表

## 总结

这个问题的核心是 **Quarto 的 HTML 转义机制**。当 `image-alt` 字段包含可能被误认为 HTML 内容的字符（如双引号）时，Quarto 为了安全会将其转义。

最简单的解决方案就是：**在所有 image-alt 字段中使用单引号代替双引号**。

---

**创建时间**: 2025-11-11  
**最后更新**: 2025-11-11
