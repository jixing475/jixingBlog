#!/usr/bin/env Rscript
# 检查所有 AIDD 文章的 image-alt 字段中是否包含可能导致 HTML 转义的特殊字符
# 使用纯 base R，不依赖额外包

# 设置工作目录
setwd("/Users/zero/Desktop/zeroverse/easyPKGs/jixingBlog")

# 查找所有英文和中文 markdown 文件
en_files <- list.files("AIDD", pattern = "\\.en\\.md$", recursive = TRUE, full.names = TRUE)
zh_files <- list.files("AIDD", pattern = "\\.zh\\.md$", recursive = TRUE, full.names = TRUE)
files <- c(en_files, zh_files)

cat("找到", length(en_files), "个英文 markdown 文件\n")
cat("找到", length(zh_files), "个中文 markdown 文件\n")
cat("共计", length(files), "个文件需要检查\n\n")

# 存储问题文件的列表
issue_files <- list()

# 检查每个文件
for (file in files) {
  tryCatch({
    # 读取文件内容
    content <- readLines(file, warn = FALSE, encoding = "UTF-8")

    # 查找 YAML front matter
    yaml_start <- which(content == "---")[1]
    yaml_end <- which(content == "---")[2]

    if (is.na(yaml_start) || is.na(yaml_end)) {
      next
    }

    # 提取 image-alt 字段（简单方法）
    yaml_lines <- content[(yaml_start + 1):(yaml_end - 1)]

    # 查找 image-alt 行
    image_alt_start <- grep("^image-alt:", yaml_lines)

    if (length(image_alt_start) == 0) {
      next
    }

    # 提取 image-alt 的值（可能是多行）
    image_alt_lines <- c()
    for (i in (image_alt_start + 1):length(yaml_lines)) {
      line <- yaml_lines[i]
      # 如果遇到下一个字段（不以空格开头），停止
      if (grepl("^[a-zA-Z]", line) || line == "") {
        break
      }
      image_alt_lines <- c(image_alt_lines, line)
    }

    image_alt <- paste(image_alt_lines, collapse = " ")
    image_alt <- trimws(image_alt)

    if (nchar(image_alt) == 0) {
      next
    }

    # 检查是否包含问题字符
    issues <- c()

    # 1. 检查 Markdown 斜体 *text*
    if (grepl("\\*[^*]+\\*", image_alt)) {
      issues <- c(issues, "Markdown斜体(*)")
    }

    # 2. 检查 Markdown 加粗 **text**
    if (grepl("\\*\\*[^*]+\\*\\*", image_alt)) {
      issues <- c(issues, "Markdown加粗(**)")
    }

    # 3. 检查 Markdown 斜体 _text_
    if (grepl("_[^_]+_", image_alt)) {
      issues <- c(issues, "Markdown斜体(_)")
    }

    # 4. 检查 HTML 标签
    if (grepl("<[^>]+>", image_alt)) {
      issues <- c(issues, "HTML标签")
    }

    # 5. 检查直接的双引号
    if (grepl('"', image_alt, fixed = TRUE)) {
      issues <- c(issues, '双引号(")')
    }

    # 6. 检查 &quot; 实体
    if (grepl("&quot;", image_alt, fixed = TRUE)) {
      issues <- c(issues, "HTML实体(&quot;)")
    }

    # 7. 检查 &amp; 实体
    if (grepl("&amp;", image_alt, fixed = TRUE)) {
      issues <- c(issues, "HTML实体(&amp;)")
    }

    # 8. 检查 &#039; 实体（单引号）
    if (grepl("&#039;", image_alt, fixed = TRUE)) {
      issues <- c(issues, "HTML实体(&#039;)")
    }

    # 如果发现问题，记录
    if (length(issues) > 0) {
      issue_files[[file]] <- list(
        issues = issues,
        image_alt = image_alt
      )
    }

  }, error = function(e) {
    cat("处理文件出错:", file, "\n")
    cat("错误信息:", e$message, "\n\n")
  })
}

# 输出结果
cat(paste(rep("=", 80), collapse = ""), "\n")
cat("发现", length(issue_files), "个包含特殊字符的文件\n")
cat(paste(rep("=", 80), collapse = ""), "\n\n")

if (length(issue_files) > 0) {
  for (i in seq_along(issue_files)) {
    file <- names(issue_files)[i]
    info <- issue_files[[file]]

    cat(sprintf("[%d] %s\n", i, file))
    cat("问题类型:", paste(info$issues, collapse = ", "), "\n")
    cat("image-alt 内容:\n")

    # 手动实现 word wrap
    alt_text <- info$image_alt
    max_width <- 75
    words <- strsplit(alt_text, " ")[[1]]
    current_line <- "  "

    for (word in words) {
      if (nchar(current_line) + nchar(word) + 1 > max_width) {
        cat(current_line, "\n")
        current_line <- paste0("  ", word)
      } else {
        if (current_line == "  ") {
          current_line <- paste0("  ", word)
        } else {
          current_line <- paste(current_line, word)
        }
      }
    }
    if (nchar(current_line) > 2) {
      cat(current_line, "\n")
    }

    cat("\n", paste(rep("-", 80), collapse = ""), "\n\n")
  }

  # 生成修复建议
  cat("\n", paste(rep("=", 80), collapse = ""), "\n")
  cat("修复建议：\n")
  cat(paste(rep("=", 80), collapse = ""), "\n\n")

  cat("1. 对于 Markdown 格式符号 (*斜体*, **加粗**, _斜体_):\n")
  cat("   - 建议移除格式符号，使用纯文本\n")
  cat("   - 或替换为 HTML 标签: <em>斜体</em>, <strong>加粗</strong>\n\n")

  cat("2. 对于双引号 (\"):\n")
  cat("   - 建议替换为单引号 (')\n")
  cat("   - 或完全移除引号\n\n")

  cat("3. 对于已经包含 HTML 实体 (&quot;, &amp;, &#039; 等):\n")
  cat("   - 这可能是被 Quarto 二次转义的结果\n")
  cat("   - 建议替换回原始字符或单引号\n\n")

  # 输出文件列表到 CSV
  issue_df <- data.frame(
    文件路径 = names(issue_files),
    问题类型 = sapply(issue_files, function(x) paste(x$issues, collapse = "; ")),
    image_alt = sapply(issue_files, function(x) x$image_alt),
    stringsAsFactors = FALSE
  )

  csv_file <- "image_alt_issues.csv"
  write.csv(issue_df, csv_file, row.names = FALSE, fileEncoding = "UTF-8")
  cat("\n详细列表已保存到:", csv_file, "\n")

} else {
  cat("所有文件的 image-alt 字段都没有发现问题！\n")
}

cat("\n完成检查！\n")
