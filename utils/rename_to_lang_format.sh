#!/bin/bash
# 批量重命名脚本 - 将成对的中英文文章转换为语言格式

# 使用说明：
# 运行: ./utils/rename_to_lang_format.sh
# 只处理同时存在 post_all.md 和 post_all__.en.md 的目录

echo "开始批量重命名 AIDD 目录下的成对文章..."
echo "只处理同时存在 post_all.md (中文) 和 post_all__.en.md (英文) 的目录"
echo ""

count=0
skipped=0

for dir in AIDD/20*; do
  if [ -d "$dir" ]; then
    zh_file="$dir/post_all.md"
    en_file="$dir/post_all__.en.md"

    # 只有当两个文件都存在时才重命名
    if [ -f "$zh_file" ] && [ -f "$en_file" ]; then
      mv "$zh_file" "$dir/post_all.zh.md"
      mv "$en_file" "$dir/post_all.en.md"
      echo "✓ $dir:"
      echo "  post_all.md → post_all.zh.md"
      echo "  post_all__.en.md → post_all.en.md"
      ((count+=2))
    else
      if [ -f "$zh_file" ] || [ -f "$en_file" ]; then
        echo "⊘ 跳过 $dir (未成对出现)"
        ((skipped++))
      fi
    fi
  fi
done

echo ""
echo "完成！共重命名 $count 个文件"
echo "跳过 $skipped 个目录（文件未成对出现）"
echo ""
echo "下一步："
echo "1. 删除旧的 HTML 文件: rm _site/AIDD/*/post_all.html"
echo "2. 重新渲染网站: quarto render"
