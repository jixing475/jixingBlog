好的，这是一篇根据 Wes McKinney 和 Hadley Wickham 的对谈视频重写的阅读版本。

***

### **Metadata**

*   **Title**: Wes McKinney & Hadley Wickham on cross-language collaboration, Positron, career beginnings, & more (Wes McKinney 与 Hadley Wickham 谈跨语言协作、Positron、职业生涯开端及更多)
*   **Author**: Wes McKinney & Hadley Wickham (hosted by Rachael Dempsey from Posit)
*   **URL**: [https://www.youtube.com/watch?v=D-xmvFY_i7U](https://www.youtube.com/watch?v=D-xmvFY_i7U)

### **Overview**

在这场由 Posit 主办的非正式对谈中，开源界的两位巨擘——Pandas 的共同创造者 Wes McKinney 和 Tidyverse 的创造者 Hadley Wickham——深入探讨了数据科学领域中 R 和 Python 两大生态系统的协作、竞争与未来。他们从各自投身开源的初心谈起，剖析了像 Pandas 这样的成熟项目在创新中所面临的"历史包袱"，以及 Polars 等新兴工具的崛起之道。对谈的核心聚焦于如何通过共享工具、统一的开发环境（如 Positron）以及共同的数据格式（如 Parquet）来降低跨语言工作的认知摩擦。最终，他们得出结论：尽管 R 和 Python 的社区文化和工具哲学存在显著差异，但通过构建共享的词汇、工具集和协作精神，可以打造一个更统一、更高效的多语言数据科学生态，而 AI 将在这个过程中扮演越来越重要的"催化剂"角色。

### **按照主题来梳理**

#### **开端：两位开源巨擘的"意外"之旅 (The Beginning: An "Accidental" Journey into Open Source) [06:03]**

在对谈的开篇，主持人引导 Wes McKinney 和 Hadley Wickham 回顾了他们各自是如何踏入开源世界的。这段分享不仅揭示了他们职业生涯的起点，也从侧面反映了数据科学领域在过去二十年间的巨大变迁。

Wes McKinney 的开源之路始于一种"意外的闯入"（stumbling into it）。时间回到 2007 年，他在一家对冲基金工作，那是一个代码被视为最高机密、严格禁止使用开源工具的环境。即便是在这种"一切都被严格审查"（everything was really scrutinized）的氛围中，他还是了解到了当时正在兴起的科学计算 Python 社区（Scientific Python community），并开始对 NumPy、SciPy 这些项目产生了浓厚兴趣。他研究了这些项目是如何成为开源项目的，并在 2009 年中，萌生了一个大胆的想法：将他自己为了解决金融数据分析问题而开发的工具——也就是 Pandas 的早期雏形——开源出去。经过努力，他最终获得了公司的许可。2010 年，他参加了自己的第一届 PyCon（Python 开发者大会），这成为他正式进入 Python 社区的"首次涉足"（first foray）。在那里，他结识了科学计算社区的元老级人物，这些人不仅指导他如何做开源、如何建立开源社区，更让他深刻体会到"在公共领域工作"（working in public）并构建能产生巨大影响力的免费工具的乐趣。从那时起，开源对他而言，就变成了一种"瘾"（addiction）。

Hadley Wickham 的故事则与 R 语言的发源地紧密相连。他在高中时就对编程和统计学都抱有极大的热情，这在当时是一个看起来"有点奇怪的组合"（weird combination）。他顺理成章地在奥克兰大学（University of Auckland）攻读了计算机科学和统计学的双学位，而这所大学正是 R 语言的诞生地。早在 2003 年，他便开始使用 R 语言，当时的版本是 R 1.6。他对自己已经使用 R 长达 21 年感到有些"震惊"（horrifying）。因为 R 本身就是开源的，所以对他来说，开发 R 包并将其开源感觉是一件"非常自然"（felt natural）的事情。他最初的职业规划是走学术道路，成为一名教授。在他看来，开源是一种向世界传播思想的绝佳方式。它不仅仅是提供一份描述你工作的"文本描述"（text description），而是直接提供"人们可以实际用来实现你工作的代码"（code that people could actually use to implement your work）。这种能对世界产生直接、实用影响的方式，深深地吸引了他，并最终塑造了他整个职业生涯的方向。

这两段经历虽然路径不同，却共同指向了一个核心：开源不仅仅是一种软件分发模式，更是一种价值观和一种高效的协作与传播思想的方式。它吸引著那些渴望创造有影响力工具、并乐于在开放社区中与他人协作的开发者。

---

#### **生态演进：Pandas 的"创新者困境"与 Polars 的崛起 (Ecosystem Evolution: The "Innovator's Dilemma" of Pandas and the Rise of Polars) [09:12]**

对谈的一个核心技术话题，围绕著 Python 数据处理库 Pandas 的演进，以及 Polars、DuckDB 等新兴高性能框架的崛起展开。Wes McKinney 作为 Pandas 的创始人，对此进行了深刻的剖析，揭示了成熟开源项目在创新道路上所面临的普遍挑战，这可以被视为一种"创新者困境"。

Wes 指出，Pandas 拥有数以百万计的用户，这使得对其进行"大规模的彻底变革"（large sweeping changes）变得异常困难。早在多年前，当他和团队开始创建 Apache Arrow 项目时，就曾讨论过是否可以对 Pandas 进行重大改造，以使其更快、更高效。Arrow 提供了一个更高效的内存数据管理层，理论上可以极大地提升 Pandas 的性能。然而，他们最终发现，任何显著的改动都会"给那些依赖 Pandas 进行所有业务应用的用户带来太大的干扰"（cause too much disruption）。许多生产环境中的代码缺乏足够的测试，任何 API 的破坏性变更都可能导致灾难性后果。因此，在过去的十年里，Pandas 的发展策略一直是**谨慎地引入新组件、优化内部实现**，但核心目标始终是"保护其 API"（preserve its API），避免过快地做出改变。其中一个重要的进展是引入了更健壮的"扩展数组系统"（extension arrays system），允许用户在 Pandas 数据框中使用 Arrow 的数组，从而获得更高效的字符串处理和分析性能。

然而，真正意义上的高性能数据框计算，主要发生在了像 DuckDB 和 Polars 这样的新项目中。这些项目的巨大优势在于它们"没有支持超过十年遗留代码和现有 API 的负担"（without the burden of supporting over a decade worth of legacy code and an existing API）。这使得它们可以从零开始，重新思考数据框的 API 设计，并将性能和可扩展性作为首要目标。

Wes 将 Polars 描述为一个拥有"更小、更简单 API"（much smaller, simpler API）的库。例如，Polars 中没有 Pandas 那样复杂的行标签（row labels），这使得它的 API 设计更加简洁。他认为，Polars 在设计哲学上可能更接近 R 语言的数据框，特别是与 Tidyverse 中的 `dplyr` 包非常相似。对于习惯了 `dplyr` 工作流的 R 用户来说，Polars 的 API 会感觉非常亲切。

这个讨论揭示了开源生态系统演进的一个关键动态：
*   **成熟项目的稳定性优先**：像 Pandas 这样成功的项目，其首要责任是保护庞大的用户群体，确保稳定性和向后兼容性。这在无形中限制了其进行颠覆性创新的能力。
*   **新兴项目的颠覆性潜力**：没有历史包袱的新项目，可以采用最新的技术和设计理念，专注于解决现有工具的痛点（如性能），从而开辟新的市场和用户群。
*   **生态系统的共存与协作**：这并不是一场零和游戏。用户可以将 Pandas 数据框无缝地传递给 DuckDB 或 Polars 进行高性能计算，形成一种协作互补的关系。成熟项目提供了广泛的生态和用户基础，而新兴项目则提供了前沿的性能和创新的思路。

---

#### **跨语言协作：弥合 R 与 Python 之间的鸿沟 (Cross-Language Collaboration: Bridging the Gap Between R and Python) [12:55]**

在当今的数据科学团队中，R 和 Python 用户并存已是常态。如何让这两个群体高效协作，消除语言壁垒带来的摩擦，成为了本次对谈的另一个核心。Hadley 和 Wes 从工具、文档、API 设计和社区文化等多个维度，探讨了弥合鸿沟的挑战与策略。

**1. 统一的开发与部署环境**

*   **Positron IDE**：Wes 详细介绍了 Positron 的设计理念。它的核心是将 RStudio 经过十五年验证的经典"四窗格数据科学布局"（classic four-pane data science layout）——即代码编辑器、控制台、变量/环境窗格和绘图窗格——带给 Python 用户，并创建一个真正的"多语言优先"（polyglot first）的 IDE。Positron 基于开源的 VS Code 构建，通过大量的定制开发，实现了在同一个 IDE 中同时运行 R 和 Python 会话。当用户在 R 和 Python 的标签页之间切换时，IDE 的所有组件（变量视图、图形等）都会自动更新以匹配当前的语言上下文。Hadley 补充说，这种多语言策略的目标是面向未来，无论下一个流行的数据科学语言是什么，Positron 都能为其提供支持。
*   **Posit Workbench & Connect**：Hadley 指出，这两款专业产品的目标是将 R 和 Python 置于"平等的地位"（on equal footing）。无论用户使用哪种语言，都可以在相同的环境中开发脚本，并使用相同的工具将其发布到同一个平台上。这为 100% 的 R 团队、100% 的 Python 团队以及混合团队提供了统一的工作流。

**2. 共享的工具与数据格式**

*   **数据交换**：Hadley 强调，真正的协作发生在开源层面。核心是建立"共享的词汇和工具集"（shared vocabulary and a shared tool set）。一个关键的实践是使用 **Parquet** 文件格式。R 用户可以通过 `arrow` 包读写 Parquet 文件，Python 用户也可以轻松处理，这成为了跨语言数据共享的绝佳方式。
*   **共享的库**：Posit 正在积极开发同时支持 R 和 Python 的库，例如用于数据版本控制和共享的 `pins` 包，用于模型监控的 `vetiver` 包，以及用于制作精美表格的 `Great Tables (gt)` 包。这些工具旨在围绕数据的存储和使用建立"共享的约定"（shared conventions），从而降低沟通成本。
*   **数据库的"解耦"**：Hadley 提出了一个深刻的趋势，即"数据存储与计算的解耦"（unbundling of data storage and compute）。过去，像 MySQL 和 Postgres 这样的数据库，其存储格式和计算引擎是紧密耦合的。而现在，你可以将数据存储为一个 Parquet 文件目录，然后使用 DuckDB、Arrow、Polars、Spark 或 Athena 等多种不同的引擎来对其进行计算。这赋予了数据科学家极大的灵活性，而 DuckDB 和 Polars 这样的工具，更是将这种强大的能力带到了你的笔记本电脑上。

**3. 统一的语言人体工程学 (Language Ergonomics)**

一位听众提出了关于"语言人体工程学"（ergonomics of the language）的尖锐问题：习惯了 Tidyverse 流畅工作流的 R 用户，在切换到 Python 时常常感到"大脑崩溃"（brain breaks）。Posit 是否在努力统一两种语言的 API 风格？

*   **社区驱动的努力**：Wes 承认这种认知摩擦的存在，并介绍了一些社区驱动的项目。例如，`plotnine` 是 `ggplot2` 的一个 Pythonic 移植版本，旨在提供语义上一致的绘图体验。他自己发起的 `Ibis` 项目，是一个受 `dplyr` 启发的可移植数据框 API，可以在多种后端（如 DuckDB、BigQuery、Snowflake）上运行。另一个名为 `Narwhals` 的项目，则试图将 Polars 的 API 变得可移植。
*   **社区文化的差异**：然而，他们也坦诚，实现完全的 API 统一非常困难。这源于 R 和 Python 社区文化的根本差异。Wes 形容 Python 生态系统是"狂野的西部"（wild west），非常庞大且"分散"（federated）。而 R 社区则更小、更"中心化"（centralized）。Hadley 进一步阐释，这种中心化体现在包管理系统上。**CRAN**（R 的包存档库）对包开发者要求极为严格，你必须确保你的包不会破坏其他现有包的兼容性。而 **PyPI**（Python 的包索引）则更加宽松，将解决依赖冲突的责任更多地转移给了用户。
*   **Tidyverse 的"引力井"**：Wes 认为，Tidyverse 在 R 社区中扮演了一个"引力井"（gravity well）的角色。它形成了一种强大的文化凝聚力，鼓励社区开发者创建能与之良好协作、风格一致的工具，从而为用户提供了端到端的高效体验。这种"意识形态上的一致性"（ideological consistency）在更为分散的 Python 世界中较为罕见。

---

#### **AI 的角色：作为催化剂而非魔法棒 (The Role of AI: A Catalyst, Not a Magic Wand) [24:58]**

在对谈的后半部分，话题自然地转向了当前最热门的技术——人工智能（AI）和大型语言模型（LLM）。Hadley 和 Wes 分享了他们作为顶级开发者如何实际使用 AI，并展望了 Posit 在这一领域的探索方向。他们传递出一个清晰的信息：AI 不是解决所有问题的魔法棒，而是一个强大的"催化剂"，能够在特定场景下极大地提升生产力。

**1. 当前 AI 的实际用例**

Hadley 和 Wes 的 AI 使用经验惊人地相似，他们都强调 AI 在以下几个方面的巨大价值：
*   **探索不熟悉的领域**：这是他们提到的最主要的应用场景。Hadley 表示，他可以"读懂"为他写好的 JavaScript，但自己写起来却"痛苦地缓慢"（painfully slow）。AI 能帮他完成 90% 的工作，极大地提高了效率。同样，Wes 发现当他需要处理不熟悉的 JavaScript 或 TypeScript 代码库时，AI 能帮他解决"空白页问题"（blank slate problem）。过去需要花费一小时在 Google 和 Stack Overflow 上搜索，现在 AI 可以直接生成模板代码作为起点。
*   **代码重构**：Wes 发现 AI 在代码重构方面"非常出色"（really good at refactoring）。当他开始手动重构时，AI 的自动补全功能常常能"魔法般地"（kind of like magic）预测到他的意图，并通过几次 Tab 键的敲击就完成他想做的事情。
*   **头脑风暴与非精确任务**：Hadley 用 DALL-E 来进行他为 R 包设计的六边形 logo 的头脑风暴，先生成大量概念，再与设计师合作完善。他和 Wes 都用 ChatGPT 来规划旅行，例如创建一个避开游客的京都徒步路线。他们总结道，AI 在这类"头脑风暴"（brainstorming）或"不需要 100% 准确答案"（getting a hundred percent correct answer is not that important）的任务上，体验远超传统搜索引擎，因为后者常常充满了广告和无关的个人故事。

**2. 未来 AI 助手的进化方向**

尽管 Posit 目前还没有一个完全成型的 AI"路线图"（roadmap），但他们正在进行大量的内部"地下项目"（skunkworks projects）来探索 AI 对数据科学家的真正意义。
*   **增强上下文感知**：Wes 提出了一个极具洞察力的方向。当前的 AI 编程助手（如 Copilot 或 Continue）主要只看代码编辑器中的文本。然而，在数据科学场景中，存在大量宝贵的上下文信息。他们正在探索如何"用数据科学环境中的信息来增强通用软件工程 AI 助手的上下文"（augment the context with information from the data science environment）。这些信息包括：
    *   数据框中的**列名** (column names)。
    *   关于活动数据环境的**其他元数据**。
    如果 AI 能够"深入观察数据"（looking deeply at the data），它提供的提示和建议将会更加贴切和有用。这是一个重大的工程挑战，但也是提升 AI 助手价值的关键。
*   **弥补生态系统短板**：一位听众提到，在 R 语言中进行 RAG（检索增强生成）和使用向量数据库仍然比 Python 困难。Hadley 坦诚地承认了这一点，并透露他计划在明年开发一个用于 RAG 的 R 包。这表明，AI 的发展也驱动著他们去思考和弥补现有工具生态中的不足。

**3. 对 AI 炒作的冷静看法**

在对谈的最后，Wes 表达了他对未来的期待："我期待一些炒作能够平息下来"（I'm excited for some of the hype to settle down）。他希望看到 AI 工具领域出现更多的整合，而不是每周都有十个新工具出现。这样，像他们这样的工具开发者就可以"专注于更少的事情"（focus on fewer things），真正地为用户提升生产力。这反映了一种成熟的工程师心态：在技术的狂热浪潮中保持冷静，专注于创造长期、可持续的价值。

### **框架 & 心智模型 (Framework & Mindset)**

#### **框架：构建跨语言数据科学生态系统的"三层模型" (Framework: A "Three-Layer Model" for Building a Cross-Language Data Science Ecosystem)**

从 Hadley Wickham 和 Wes McKinney 的对谈中，我们可以抽象出一个用于构建高效、协作的跨语言（特别是 R 和 Python）数据科学生态系统的"三层模型"。这个模型不是一个僵化的流程，而是一个指导思想，旨在从不同层面解决跨语言工作流中的摩擦和挑战。

**第一层：基础设施层 (The Infrastructure Layer) - 统一与平等**

这一层的目标是为不同语言的使用者提供一个统一、平等且无缝的开发和部署环境。它是所有高效协作的基石。如果基础设施是割裂的，上层的努力将事倍功半。

*   **统一的开发环境 (Unified Development Environment)**：
    *   **核心理念**：消除"我的工具 vs 你的工具"的隔阂。团队成员应该能够在同一个界面中工作，即使他们使用不同的语言。
    *   **实践案例**：Positron IDE。它并非简单地将 R 和 Python 的功能堆砌在一起，而是基于一个经过验证的、符合数据科学家心智模型的布局（经典四窗格），并将其扩展到多语言场景。关键在于"上下文感知"（context-aware），当用户切换语言时，整个环境（变量、绘图、控制台）都能智能地随之切换。这是从底层设计上实现的统一。
*   **统一的部署平台 (Unified Deployment Platform)**：
    *   **核心理念**：无论分析产品（如报告、仪表板、API）是用哪种语言构建的，都应该有一个统一的发布、管理和分享渠道。
    *   **实践案例**：Posit Connect。它支持发布用 R (Shiny) 或 Python (Shiny, Streamlit, Dash) 创建的应用。这意味著，最终的消费者或业务部门，无需关心这个产品背后是用什么技术栈实现的。这从组织层面消除了语言偏好带来的壁垒。
*   **面向未来的架构 (Future-Proof Architecture)**：
    *   **核心理念**：今天关注的是 R 和 Python，但明天可能是 Julia、Rust 或其他新兴语言。基础设施层的设计应该是可扩展的，能够容纳未来的数据科学语言。
    *   **实践案例**：Positron 选择基于 VS Code 的开源代码库进行构建，正是看中了其强大的可扩展性和庞大的插件生态，这为未来集成新语言提供了坚实的基础。

**第二层：工具与约定层 (The Tooling & Convention Layer) - 共享与互通**

在统一的基础设施之上，这一层的目标是通过共享的工具、数据格式和编程范式，来降低日常工作中的认知摩擦和技术转换成本。

*   **共享的数据格式 (Shared Data Format)**：
    *   **核心理念**：数据是协作的通用语言。必须选择一种高性能、跨语言的标准格式作为数据交换的"通用货币"。
    *   **实践案例**：Apache Parquet。它已经成为事实上的标准。R 和 Python 社区都有成熟的库（如 `arrow`）来高效读写 Parquet 文件，这消除了数据共享中最常见的瓶颈。这也推动了"数据存储与计算解耦"的趋势。
*   **共享的工具集 (Shared Toolset)**：
    *   **核心理念**：为常见的数据科学任务（如数据可视化、表格制作、模型部署）提供在 R 和 Python 中 API 风格尽可能一致的库。
    *   **实践案例**：Posit 正在大力投资开发 `Great Tables (gt)`、`pins`、`vetiver` 等库的 R 和 Python 版本。这不仅是代码的移植，更是"共享词汇"（shared vocabulary）的建立。当团队成员都在讨论如何用 `gt` 制作表格时，他们使用的是同一套概念，即使具体的语法有差异。
*   **共享的编程范式 (Shared Programming Paradigm)**：
    *   **核心理念**：鼓励在不同语言中借鉴和移植成功的编程范式，以降低用户在语言间切换时的学习曲线。
    *   **实践案例**：`dplyr` 的管道操作符和声明式语法，深刻影响了 Python 生态中的 `Ibis` 和 `Polars`。`ggplot2` 的图形语法，也被 `plotnine` 移植到了 Python 中。这种跨语言的"思想传播"，是比简单的代码共享更深层次的协同。

**第三层：文化与社区层 (The Culture & Community Layer) - 对话与凝聚**

这是最顶层、也是最"软"的一层，但它对生态系统的健康发展至关重要。它关乎开发者和用户之间的互动方式。

*   **积极的对话与协作 (Active Dialogue and Collaboration)**：
    *   **核心理念**：鼓励不同语言社区的核心开发者进行持续的对话。一个生态系统的凝聚力，很大程度上源于其领导者是否愿意合作。
    *   **实践案例**：Hadley 和 Wes 本人长达近十年的合作，就是最好的例子。他们共同推进了 Arrow 项目，使得 R 和 Python 能够在底层数据交换上实现统一。这种顶层的协作，会像涟漪一样扩散到整个社区。
*   **建立"引力井" (Creating "Gravity Wells")**：
    *   **核心理念**：在生态系统中，需要有一个或多个"杀手级"的项目（如 Tidyverse），它不仅自身优秀，更能形成一种文化向心力，吸引其他开发者围绕它构建兼容、一致的工具。
    *   **实践案例**：Tidyverse 的成功，不仅在于其自身的工具质量，更在于它建立了一套设计哲学和"意识形态上的一致性"，这使得 R 社区的工具生态比分散的 Python 世界显得更有条理。
*   **包容性的文档与教育 (Inclusive Documentation and Education)**：
    *   **核心理念**：文档和教程是新人进入一个生态系统的门户。它们的设计必须考虑到不同背景的用户。
    *   **实践案例**：使用 Quarto 创建可以动态切换 R 和 Python 代码示例的文档。这不仅是技术实现，更是一种姿态，表明社区欢迎并尊重不同语言的使用者。

---

#### **心智模型："新手之心"与拥抱"空白页" (Mindset: The "Beginner's Mind" and Embracing the "Blank Slate")**

在整场对谈中，Hadley Wickham 和 Wes McKinney 不仅分享了技术见解，更展现了一种深刻的、值得所有科技从业者学习的"心智模型"。这个心智模型的核心是**拥抱"新手之心"（Beginner's Mind）**，并将其作为持续成长和创新的源动力。它体现在如何看待学习、如何使用新工具（特别是 AI），以及如何评价他人和自己的成就上。

**1. 学习与成长：敢于在精通后重返"新手村"**

这个心智模型最动人的体现，是 Hadley 对 Posit 创始人 JJ Allaire 的评价。他最敬佩 JJ 的，并非其技术成就，而是"他愿意从一个他是专家的领域，转移到一个他一无所知的新领域"（his willingness to move from an area where he is an expert... to a new area where he knows nothing）。

*   **打破专家陷阱 (Avoiding the Expert Trap)**：许多人在一个领域达到顶峰后，会倾向于待在自己的舒适区，因为"专家"的身份能带来安全感和荣誉感。然而，这也可能成为创新的最大障碍。真正的成长，恰恰发生在你走出舒适区，重新体验作为一个"新手"（novice）的笨拙和不确定性时。
*   **同理心的来源 (The Source of Empathy)**：当你敢于去学习新东西时，你会重新体会到初学者的痛苦和困惑。这种经历，会让你作为一个工具的创造者，更能理解你的用户所面临的挑战。你会思考如何让入门曲线更平缓，如何让文档更清晰，如何让工具的设计更符合直觉。Wes 和 Hadley 在讨论 R 和 Python 的"语言人体工程学"时，正是站在这种同理心的角度。
*   **谦逊与勇气 (Humility and Courage)**：承认自己在某个领域"一无所知"需要巨大的谦逊。而决定去改变这一现状，则需要非凡的勇气。这种"我现在是大师，但我愿意去那边重新做回学徒"的心态，是顶级人才与优秀人才的根本区别。

**2. 使用新工具（AI）：拥抱"空白页"，接受不完美**

当谈到如何使用 AI 时，他们的心态再次印证了"新手之心"的模式。他们并未将 AI 视为一个无所不能的、替代自己的"专家"，而是将其定位为一个**帮助自己克服"新手"状态的辅助工具**。

*   **解决"空白页问题" (Solving the "Blank Slate Problem")**：无论是 Hadley 学习 JavaScript，还是 Wes 接触新的代码库，他们都将 AI 的最大价值归结为解决"空白页问题"。开始一项新任务时，最困难的往往是第一步。AI 能够快速生成一个不完美的、但可以作为起点的模板代码。它就像一个经验丰富的学长，在你不知所措时，给了你一份可以参考的草稿。
*   **接受 90% 的方案 (Accepting the 90% Solution)**：他们反复强调，你"永远不会 100% 信任它"（never really trust it a hundred percent），但它常常能"把你带到 90% 的位置"（gets you ninety percent of the way there）。这是一种极其务实的心态。它放弃了对工具的完美主义幻想，而是专注于如何利用工具的优势来最大化自己的效率。人类的价值，体现在完成那最后 10% 的批判性思考、编辑和精炼上。
*   **AI 作为头脑风暴的伙伴 (AI as a Brainstorming Partner)**：在旅行规划或 logo 设计这类探索性任务中，AI 成为了一个不知疲倦的、能提供大量想法的伙伴。在这里，"正确答案"并不重要，重要的是获得足够多的可能性作为灵感的来源。这同样是一种将自己置于"新手"位置，寻求外部启发的心态。

**3. 评价与协作：欣赏他人"从零到一"的勇气**

在对谈的结尾，当被问及他们的"数据英雄"时，他们的选择再次强化了这一心智模型。
*   **欣赏创业者精神 (Appreciating the Founder's Spirit)**：Wes 选择了 DuckDB 的创始人。他钦佩的，是他们作为一个小团队，"毫不畏惧地"（unfazed）去解决任何难题，其成就"让那些拥有一百名工程师的许多创业公司相形见绌"（run circles around many startups that have a hundred engineers）。Hadley 选择了 Typst 的开发团队，同样是因为他们以极小的人力，去挑战 LaTeX 这样一个看似"太大太复杂"而无法被替代的系统。
*   **价值判断的转变 (A Shift in Value Judgment)**：他们所敬佩的，并非那些维护庞大、成熟系统的"守护者"，而是那些敢于从零开始，挑战不可能的"开拓者"。这与他们对自己职业生涯的选择（投身开源）和对学习的态度（拥抱新手之心）一脉相承。他们深知，从 0 到 1 的创造，远比从 1 到 N 的维护需要更大的勇气和远见。

总结而言，"新手之心"与拥抱"空白页"的心智模型，是一种关于持续学习、谦逊、勇气和务实主义的哲学。它鼓励我们在任何时候都保持好奇心，不畏惧暴露自己的无知，并善于利用所有工具（包括不完美的 AI）来帮助我们跨越从"不知道"到"知道一点"的鸿沟。这正是驱动个人成长和技术创新的核心引擎。
