# 修复版函数调用关系分析器

trace_calls <- function(func_name, depth = 3) {
  
  # 获取函数对象
  get_function <- function(name) {
    if (grepl(":::", name)) {
      parts <- strsplit(name, ":::")[[1]]
      pkg <- parts[1]
      fn <- parts[2]
      tryCatch({
        get(fn, envir = asNamespace(pkg))
      }, error = function(e) NULL)
    } else if (grepl("::", name)) {
      parts <- strsplit(name, "::")[[1]]  
      pkg <- parts[1]
      fn <- parts[2]
      tryCatch({
        get(fn, envir = asNamespace(pkg))
      }, error = function(e) NULL)
    } else {
      tryCatch({
        get(name)
      }, error = function(e) NULL)
    }
  }
  
  # 从函数体中提取调用
  extract_calls <- function(func, pkg_name = NULL) {
    if (is.null(func)) return(character(0))
    
    body_obj <- body(func)
    if (is.null(body_obj)) return(character(0))
    
    # 转换为字符串
    body_text <- paste(deparse(body_obj), collapse = " ")
    
    calls <- character(0)
    
    # 查找 package:::function 调用
    pkg_internal_pattern <- "[a-zA-Z][a-zA-Z0-9._]*:::[a-zA-Z][a-zA-Z0-9._]*"
    pkg_internal_calls <- regmatches(body_text, gregexpr(pkg_internal_pattern, body_text))[[1]]
    calls <- c(calls, pkg_internal_calls)
    
    # 查找 package::function 调用  
    pkg_pattern <- "[a-zA-Z][a-zA-Z0-9._]*::[a-zA-Z][a-zA-Z0-9._]*"
    pkg_calls <- regmatches(body_text, gregexpr(pkg_pattern, body_text))[[1]]
    # 排除已经包含 ::: 的
    pkg_calls <- pkg_calls[!grepl(":::", pkg_calls)]
    calls <- c(calls, pkg_calls)
    
    # 查找普通函数调用
    func_pattern <- "[a-zA-Z][a-zA-Z0-9._]*\\s*\\("
    func_matches <- regmatches(body_text, gregexpr(func_pattern, body_text))[[1]]
    func_calls <- gsub("\\s*\\(", "", func_matches)
    
    # 过滤常用函数
    exclude_funcs <- c("c", "list", "data.frame", "paste", "paste0", "print", "cat", 
                      "stop", "warning", "length", "names", "class", "typeof",
                      "is.null", "missing", "substitute", "deparse", "match.arg",
                      "rep", "seq", "which", "lapply", "sapply", "mapply", "apply",
                      "mutate", "select", "filter", "arrange", "return", "if", "for")
    
    func_calls <- func_calls[!func_calls %in% exclude_funcs]
    
    # 为普通调用添加包前缀（如果有当前包信息）
    if (!is.null(pkg_name) && length(func_calls) > 0) {
      # 只对那些可能是包内函数的调用添加前缀
      possible_internal <- func_calls[nchar(func_calls) > 2]  # 过滤太短的函数名
      if (length(possible_internal) > 0) {
        calls <- c(calls, paste0(pkg_name, ":::", possible_internal))
      }
    }
    
    return(unique(calls))
  }
  
  # 递归分析函数
  analyze_recursive <- function(name, level = 0, visited = character()) {
    # 防止无限递归
    if (level >= depth || name %in% visited) {
      return()
    }
    
    visited <- c(visited, name)
    
    # 获取函数
    func <- get_function(name)
    if (is.null(func)) {
      return()
    }
    
    # 打印当前函数
    indent <- paste(rep("  ", level), collapse = "")
    cat(indent, "├─ ", name, "\n", sep = "")
    
    # 提取包名
    pkg_name <- if (grepl(":::", name)) {
      strsplit(name, ":::")[[1]][1]
    } else if (grepl("::", name)) {
      strsplit(name, "::")[[1]][1]  
    } else {
      NULL
    }
    
    # 获取调用列表
    calls <- extract_calls(func, pkg_name)
    
    # 递归分析每个调用
    for (call in calls) {
      analyze_recursive(call, level + 1, visited)
    }
  }
  
  # 开始分析
  cat("Function Call Relationship for:", func_name, "\n")
  cat("===============================================\n")
  analyze_recursive(func_name)
  cat("===============================================\n")
}

# 使用示例
cat("Fixed version loaded! Usage: trace_calls('mall:::llm_sentiment.data.frame')\n")
