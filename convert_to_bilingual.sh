#!/bin/bash

# 双语文章转换脚本
# 用于将现有的单语言文章转换为双语命名格式

echo "=== AIDD 文章双语转换工具 ==="
echo ""
echo "此脚本会将 AIDD 文件夹中的 .md 文件转换为 .en.md 格式"
echo "使用方法："
echo "  ./convert_to_bilingual.sh <folder>"
echo ""
echo "示例："
echo "  ./convert_to_bilingual.sh AIDD/2025-10-01"
echo ""

# 检查参数
if [ -z "$1" ]; then
    echo "错误：请指定要转换的文件夹"
    echo "用法: $0 <folder>"
    exit 1
fi

FOLDER=$1

# 检查文件夹是否存在
if [ ! -d "$FOLDER" ]; then
    echo "错误：文件夹 $FOLDER 不存在"
    exit 1
fi

echo "处理文件夹: $FOLDER"
echo ""

# 查找所有不带语言后缀的 .md 文件
FILES=$(find "$FOLDER" -maxdepth 1 -name "*.md" ! -name "*.en.md" ! -name "*.zh.md")

if [ -z "$FILES" ]; then
    echo "没有找到需要转换的文件"
    exit 0
fi

# 转换文件
for file in $FILES; do
    # 获取文件名（不含路径）
    filename=$(basename "$file")
    # 获取不含扩展名的文件名
    basename_no_ext="${filename%.md}"
    # 获取目录路径
    dirpath=$(dirname "$file")

    # 新的英文文件名
    new_en_file="$dirpath/${basename_no_ext}.en.md"

    echo "转换: $filename -> ${basename_no_ext}.en.md"
    mv "$file" "$new_en_file"

    # 可选：创建中文版本占位符（注释掉，因为用户说后续手动添加）
    # new_zh_file="$dirpath/${basename_no_ext}.zh.md"
    # if [ ! -f "$new_zh_file" ]; then
    #     echo "创建中文占位符: ${basename_no_ext}.zh.md"
    #     cp "$new_en_file" "$new_zh_file"
    # fi
done

echo ""
echo "转换完成！"
echo ""
echo "注意事项："
echo "1. 请检查文件中的 image: 路径，确保使用绝对路径（如 /AIDD/2025-10-01/...）"
echo "2. 如需添加中文翻译，创建对应的 .zh.md 文件即可"
