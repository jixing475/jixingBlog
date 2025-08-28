

## 主题修改：

借鉴了 playgroud 中 website

    theme:
      - cosmo
      - assets/simon-light.scss
      - assets/simon.scss

assets 下的配置可以复制过来，后续有写布局也可以借鉴

## 字体大小调整：

- **2024-12-XX**: 将博客字体大小从 `1.2rem` 调整为 `1.0rem`
  - 修改文件：`assets/simon-light.scss`
  - 调整内容：
    - `body` 标签字体大小：`1.2rem` → `1.0rem`
    - `p` 标签字体大小：`1.2rem` → `1.0rem`
  - 目的：让博客文章字体稍微小一点，看起来更紧凑

## 项目配置调整：

- **2024-12-XX**: 添加 drafts 文件夹到项目排除列表
  - 修改文件：`_quarto.yml`
  - 调整内容：在顶级 `exclude` 属性中添加 `- drafts/`
  - 目的：渲染网站时忽略 drafts 文件夹中的草稿文件，避免发布未完成的文章

## 新增栏目：

- **2024-12-XX**: 添加 AIDD 栏目
  - 创建文件：
    - `AIDD/_metadata.yml` - AIDD 文章的元数据配置
    - `aidd.qmd` - AIDD 列表页面
  - 修改文件：`_quarto.yml` - 在导航栏添加 AIDD 链接
  - 目的：为 AIDD（AI Drug Discovery）相关文章创建专门的栏目

## 格式调整：

- **2024-12-XX**: 去掉文章自动数字标记
  - 修改文件：`posts/_metadata.yml` 和 `AIDD/_metadata.yml`
  - 调整内容：将 `number-sections: true` 改为 `number-sections: false`
  - 目的：移除文章标题前的自动数字编号（如 "1. 目录"、"2 1. GP-MOBO" 等）
