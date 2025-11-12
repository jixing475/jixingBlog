#!/usr/bin/env Rscript
# 自动修复 image-alt 字段中的特殊字符
# 只修改 image-alt 部分，保持文件其他内容不变

# 设置工作目录
setwd("/Users/zero/Desktop/zeroverse/easyPKGs/jixingBlog")

# 读取问题文件列表
if (!file.exists("image_alt_issues.csv")) {
  cat("错误：未找到 image_alt_issues.csv 文件\n")
  cat("请先运行 check_image_alt_issues.R 生成问题文件列表\n")
  quit(status = 1)
}

issue_df <- read.csv("image_alt_issues.csv", stringsAsFactors = FALSE, fileEncoding = "UTF-8")

cat("====================================================================\n")
cat("开始修复 image-alt 字段\n")
cat("====================================================================\n\n")
cat("共需修复", nrow(issue_df), "个文件\n\n")

# 清理函数
clean_image_alt <- function(text) {
  # 1. 将双引号替换为单引号
  text <- gsub('"', "'", text, fixed = TRUE)

  # 2. 移除 Markdown 斜体标记 *text* (但保留文本)
  text <- gsub("\\*([^*]+)\\*", "\\1", text)

  # 3. 移除 Markdown 加粗标记 **text** (但保留文本)
  text <- gsub("\\*\\*([^*]+)\\*\\*", "\\1", text)

  # 4. 移除 Markdown 斜体标记 _text_ (但保留文本)
  text <- gsub("_([^_]+)_", "\\1", text)

  # 5. 替换 HTML 实体回纯文本
  text <- gsub("&quot;", "'", text, fixed = TRUE)
  text <- gsub("&amp;", "and", text, fixed = TRUE)
  text <- gsub("&#039;", "'", text, fixed = TRUE)
  text <- gsub("&lt;", "<", text, fixed = TRUE)
  text <- gsub("&gt;", ">", text, fixed = TRUE)

  # 6. 移除 HTML 标签 (如果有)
  text <- gsub("<em>([^<]+)</em>", "\\1", text)
  text <- gsub("<strong>([^<]+)</strong>", "\\1", text)
  text <- gsub("<[^>]+>", "", text)

  return(text)
}

# 修复计数
fixed_count <- 0
failed_count <- 0
failed_files <- c()

# 处理每个文件
for (i in 1:nrow(issue_df)) {
  file_path <- issue_df[i, "文件路径"]

  cat(sprintf("[%d/%d] 处理: %s\n", i, nrow(issue_df), file_path))

  tryCatch({
    # 读取文件
    content <- readLines(file_path, warn = FALSE, encoding = "UTF-8")

    # 查找 YAML front matter
    yaml_start <- which(content == "---")[1]
    yaml_end <- which(content == "---")[2]

    if (is.na(yaml_start) || is.na(yaml_end)) {
      cat("  ✗ 警告: 未找到 YAML front matter\n\n")
      failed_count <- failed_count + 1
      failed_files <- c(failed_files, file_path)
      next
    }

    # 查找 image-alt 行
    image_alt_line <- 0
    for (j in (yaml_start + 1):(yaml_end - 1)) {
      if (grepl("^image-alt:", content[j])) {
        image_alt_line <- j
        break
      }
    }

    if (image_alt_line == 0) {
      cat("  ✗ 警告: 未找到 image-alt 字段\n\n")
      failed_count <- failed_count + 1
      failed_files <- c(failed_files, file_path)
      next
    }

    # 收集 image-alt 的所有行（可能是多行）
    alt_start <- image_alt_line + 1
    alt_end <- alt_start

    for (j in alt_start:(yaml_end - 1)) {
      line <- content[j]
      # 如果遇到下一个字段或空行，停止
      if (grepl("^[a-zA-Z]", line) || line == "") {
        alt_end <- j - 1
        break
      }
      alt_end <- j
    }

    # 提取原始 image-alt 内容
    original_lines <- content[alt_start:alt_end]
    original_text <- paste(original_lines, collapse = " ")
    original_text <- trimws(original_text)

    # 清理 image-alt 内容
    cleaned_text <- clean_image_alt(original_text)

    # 显示对比
    if (original_text != cleaned_text) {
      cat("  原始内容: ", substr(original_text, 1, 60), "...\n", sep = "")
      cat("  修复内容: ", substr(cleaned_text, 1, 60), "...\n", sep = "")

      # 重新格式化为多行（保持缩进）
      max_width <- 75
      words <- strsplit(cleaned_text, " ")[[1]]
      new_lines <- c()
      current_line <- ""

      for (word in words) {
        if (nchar(current_line) + nchar(word) + 1 > max_width) {
          new_lines <- c(new_lines, paste0("  ", current_line))
          current_line <- word
        } else {
          if (current_line == "") {
            current_line <- word
          } else {
            current_line <- paste(current_line, word)
          }
        }
      }
      if (nchar(current_line) > 0) {
        new_lines <- c(new_lines, paste0("  ", current_line))
      }

      # 替换原始内容
      new_content <- c(
        content[1:image_alt_line],
        new_lines,
        content[(alt_end + 1):length(content)]
      )

      # 创建备份
      backup_file <- paste0(file_path, ".backup")
      writeLines(content, backup_file, useBytes = TRUE)

      # 写入修复后的内容
      writeLines(new_content, file_path, useBytes = TRUE)

      cat("  ✓ 修复完成 (备份: ", basename(backup_file), ")\n\n", sep = "")
      fixed_count <- fixed_count + 1
    } else {
      cat("  ℹ 内容未变化，跳过\n\n")
    }

  }, error = function(e) {
    cat("  ✗ 错误:", e$message, "\n\n")
    failed_count <- failed_count + 1
    failed_files <- c(failed_files, file_path)
  })
}

# 输出总结
cat("\n====================================================================\n")
cat("修复完成！\n")
cat("====================================================================\n\n")
cat("成功修复:", fixed_count, "个文件\n")
cat("失败/跳过:", failed_count, "个文件\n")

if (length(failed_files) > 0) {
  cat("\n失败的文件:\n")
  for (f in failed_files) {
    cat("  -", f, "\n")
  }
}

cat("\n注意事项:\n")
cat("1. 所有被修改的文件都已创建 .backup 备份\n")
cat("2. 请运行 'quarto render' 重新编译网站\n")
cat("3. 检查 _site/aidd.en.html 验证图片是否正常显示\n")
cat("4. 如果满意修复结果，可以删除 .backup 文件\n")
cat("5. 如果需要恢复，使用备份文件覆盖原文件即可\n\n")

# 提供删除备份的命令
if (fixed_count > 0) {
  cat("删除所有备份文件的命令:\n")
  cat("  find AIDD -name '*.backup' -delete\n\n")
}

cat("修复完成！\n")
