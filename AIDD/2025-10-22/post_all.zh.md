---
title: "AI 驱动的蛋白质研究新突破：从无序蛋白预测到动态构象模拟"
description: |
  本文介绍了五项前沿 AI 技术在生物制药领域的最新应用。内容涵盖：PepTron 模型首次实现对无序蛋白（IDPs）的准确预测，为药物研发开辟新路径；BiomarkerML 工具让非编程背景的生物学家也能利用机器学习发现疾病标志物；MECo 框架通过代码化编辑，让 AI 像化学家一样精准优化分子；AF-CALVADOS 模型结合 AlphaFold 与模拟技术，实现了对上万种人类蛋白质动态构象的大规模研究；ConforFold 通过主动控制二级结构，有效预测蛋白质的多种构象，为理解动态靶点提供了新工具。
date: "2025-10-22"
categories: ["蛋白质结构预测", "AI 辅助药物设计", "AlphaFold", "生物信息学", "机器学习"]
image: post_all_image/af_calvados_alpha_fo_2025_10_22_extract_paper_insights_news_rewrite_en_to_zh_image_2.jpg
image-alt: |
  AF-CALVADOS 模型工作流程示意图。图中展示了一个多结构域蛋白质，其稳定折叠的结构域被标记为刚性整体，而低置信度的本质无序区（IDRs）则被标记为柔性连接体。该图形象地说明了模型如何利用 AlphaFold 的预测置信度分数来自动化区分蛋白质的刚性与柔性部分，从而实现大规模动态构象模拟。
toc-depth: 3
---

## 目录  
1. 新基准 PeptoneBench 和数据增强模型 PepTron，首次实现了对无序蛋白结构集合的准确预测，解决了 AI 结构预测的一大难题。
2. BiomarkerML 将复杂的蛋白质组学机器学习流程打包，让不擅长编程的生物学家也能亲自上手，寻找疾病的生物标志物。
3. MECo 框架将分子优化分为「想法」和「执行」两步，用代码精确实现化学家的设计意图，使 AI 药物设计更可靠、更可控。
4. 研究者开发了 AF-CALVADOS 模型，它将 AlphaFold 的结构预测与粗粒度模拟结合，首次实现了对上万种人类蛋白质动态构象的大规模模拟。
5. ConforFold 通过主动采样二级结构来引导折叠，有效预测蛋白质的多种构象，为理解动态靶点提供了新工具。

## 1. AI 新模型 PepTron 预测无序蛋白，为药物发现开辟新路  
  
![advancing_protein_en_2025_10_22_extract_paper_insights_news_rewrite_en_to_zh_image_1](post_all_image/advancing_protein_en_2025_10_22_extract_paper_insights_news_rewrite_en_to_zh_image_1.jpg)  

AlphaFold2 改变了结构生物学，但它也有自己的「阿喀琉斯之踵」——本质无序蛋白 (Intrinsically Disordered Proteins, IDPs)。  
  
这些蛋白没有固定的三维结构，而是以一个动态的构象集合存在，像不断变换形态的分子。在真核生物蛋白质组中，IDP 约占 30%，并与癌症、神经退行性疾病等多种疾病相关。它们是极具吸引力的药物靶点，但其「善变」的特性也使其难以研究。  
  
AlphaFold2 这类模型主要在蛋白质数据库 (PDB) 上训练，其中充满了结构稳定的蛋白。用只包含稳定结构蛋白的数据训练出的模型，面对动态变化的 IDP 自然力不从心。因此，AlphaFold2 在预测 IDP 时，会给出一个低置信度的、面条状的结构。这虽然识别出了无序区域，但药物研发需要知道这团「面条」所有可能的构象及其出现概率。  
  
**第一步：建立评估标准 (PeptoneBench**)  
  
要解决问题，首先需要一个衡量好坏的标准。这项研究为此建立了 PeptoneBench 评测基准。  
  
它整合了核磁共振化学位移 (NMR chemical shifts) 和小角 X 射线散射 (SAXS) 等多种真实实验数据，全面检验模型在真实场景下的综合能力，就像在真实赛道上测试赛车一样。  
  
从性能对比图可以看到，随着蛋白无序程度的增加，AlphaFold2 和 Boltz2 等模型的性能急剧下降，而新模型 PepTron 和计算成本高昂的 BioEmu 却能保持稳健。这把尺子揭示了谁是真正的「全能选手」。  
  
**第二步：用合成数据训练新模型 (PepTron**)  
  
由于高质量的真实 IDP 结构数据稀缺，研究团队的思路是：创造数据。  
  
他们开发了片段生成器 IDP-o，创建了一个庞大的合成数据集 IDRome-o，其中包含各种无序蛋白的构象。然后，他们用这个合成数据集和 PDB 中的有序蛋白结构一起训练新模型 PepTron。  
  
这种「数据增强」策略在蛋白结构预测领域，尤其是在 IDP 研究中，是一个有效的应用。它为 AI 模型补充了大量关于「无序世界」的知识，让它不再偏科。  
  
PepTron 采用「流匹配」(flow-matching) 的生成模型架构。可以将其理解成一个学习雕刻路径的大师，它学习的不是凭空创造，而是从一块随机的石头（随机噪声）到最终成品（真实的蛋白构象集合）的完整生成路径。通过在有序和无序两种数据上训练，PepTron 学会了准确预测从有序到无序的各类蛋白结构。  
  
**PepTron 对药物发现的价值**  
  
IDP 常常是细胞信号网络中的关键枢纽，其灵活性使其能与多个伴侣蛋白结合。传统的药物设计思路是在蛋白上寻找稳定的「口袋」让小分子药物嵌入，这条路在 IDP 这里基本走不通。  
  
PROTACs 或分子胶这类新技术，其作用机制不完全依赖于固定的口袋，但同样需要了解靶蛋白的动态构象。PepTron 提供的，正是一幅高分辨率的动态构象地图，为计算辅助药物发现 (CADD) 提供了新起点。  
  
当然，这项工作仍有提升空间。合成数据的真实性可以进一步提高，细胞环境对 IDP 构象的影响也需要更精确的建模。但它向解决 IDP 预测难题迈出了一步，为针对这类靶点的药物研发开辟了新方向。  
  
📜Title: Advancing Protein Ensemble Predictions Across the Order–Disorder Continuum  
🌐Paper: https://doi.org/10.1101/2025.10.18.680935  
💻Code: https://www.biorxiv.org/content/10.1101/2025.10.18.680935v2  

## 2. BiomarkerML: AI 赋能蛋白质组学，小白也能找靶点  
  
![biomarker_ml_a_cloud_2025_10_22_extract_paper_insights_news_rewrite_en_to_zh_image_1](post_all_image/biomarker_ml_a_cloud_2025_10_22_extract_paper_insights_news_rewrite_en_to_zh_image_1.jpg)  

药物研发领域每天产生海量蛋白质组学数据。仪器高速运转，数据堆积如山，但能有效分析、从中发掘价值的人才却很稀缺。许多湿实验生物学家面对这些数据，如同手握密码待解的藏宝图，感到头疼。  
  
一个名为 BiomarkerML 的新工具，旨在解决这一难题。它是一个「蛋白质组学分析流水线」，将复杂的机器学习操作打包成一个半自动化的流程。  
  
这个工具如何工作？  
  
首先，它内置多种机器学习模型，包括深度学习中的变分自编码器 (Variational Autoencoder, VAE)。蛋白质组学数据充满噪音和非线性关系，传统统计方法常常受限，而这些模型更适合处理这类数据。它还将调参 (hyperparameter tuning) 和交叉验证 (cross-validation) 等繁琐步骤自动化，以避免模型过拟合，保证结果可靠。  
  
BiomarkerML 的亮点在于解释模型预测结果的方式。它使用 SHAP (SHapley Additive exPlanations) 技术，就像一个侦探在分析线索。SHAP 值能指出在最终判断（如诊断疾病）时，哪个「蛋白质证人」提供了关键信息。这样找到的候选生物标志物便有据可依。  
  
仅关注最重要的「证人」还不够。BiomarkerML 还会分析这些关键蛋白质的「社交网络」，即蛋白质相互作用网络。蛋白质很少单独起作用，通常与其他蛋白质协同工作。通过分析这个网络，一些 SHAP 值不高但与关键蛋白联系紧密的蛋白质也被识别出来。最终的候选标志物列表因此呈现出完整的生物学叙事。  
  
该工具使用 Python、R 和 WDL (Workflow Description Language) 搭建。WDL 是构建可重复、可移植分析流程的关键。借助 WDL，分析流程在亚马逊云或公司内部集群等不同计算环境中，只要配置正确，就能得到完全相同的结果。在药物研发中，可重复性就是生命线。  
  
研究团队在乙肝相关肝病的尿液蛋白质组数据上测试了该工具，获得了很高的 AUC 分数，并找到了一些有潜力的候选分子，验证了流程的有效性。  
  
BiomarkerML 的价值在于降低了生物信息分析的门槛。它让实验室里懂生物学的科学家，无需学习复杂的调参和脚本编写，就能利用前沿的 AI 方法挖掘数据。这有望加速许多早期项目的进展，让有价值的生物标志物被更快发现。  
  
📜论文：BiomarkerML: A cloud-based proteomics ML workflow for biomarker discovery  
🌐链接：<https://www.biorxiv.org/content/10.1101/2025.10.16.682839v1>  

## 3. MECo：用代码编辑分子，让 AI 像化学家一样思考  
  
![coder_as_editor_cod_2025_10_22_extract_paper_insights_news_rewrite_en_to_zh_image_1](post_all_image/coder_as_editor_cod_2025_10_22_extract_paper_insights_news_rewrite_en_to_zh_image_1.jpg)  

药物发现的一大挑战，是让 AI 像化学家一样有条理、有逻辑地优化分子。许多 AI 模型直接操作简化分子线性输入规范（SMILES）字符串，就像编辑图片的原始像素，稍有不慎就会产生化学上无效的「怪物分子」。  
  
MECo 框架换了一种思路，更贴近化学家的工作方式。它将分子优化流程拆分为两步。  
  
第一步，AI 扮演「编辑」角色。它分析起始分子和优化目标（例如提高活性或降低毒性），然后提出一个人类可读的修改方案。这个方案就像化学家在组会上的讨论：「把这个苯环上的甲基换成三氟甲基，看能否增强脂溶性。」  
  
第二步，AI 切换为「程序员」角色，将「编辑意图」翻译成可执行的 Python 代码。这段代码调用化学信息学工具包（如 RDKit），对分子结构进行原子级的精确操作，例如定位特定原子、断开旧键、连接新官能团。  
  
这种做法解决了分子生成的有效性问题。代码是严谨的，要么成功执行得到一个化学上有效的分子，要么直接报错，不会产生化学键乱连的无效结构。其报告的准确率超过 98%，这在基于 SMILES 的方法中难以想象。传统方法像不懂语法的人修改句子，容易写出病句；MECo 则是先理解句意，再用语法工具修改。  
  
同时，优化过程变得透明可控。AI 不再只给出一个结果，而是展示了完整的「思考路径」：它的编辑意图和执行代码。药物化学家可以审查 AI 的每一步决策，甚至修改代码再执行。AI 从一个「黑盒」变成了可交流、可调试的合作工具。  
  
为训练模型，研究者采用了混合数据策略，结合了理论化学编辑操作（合成数据）与来自真实化学反应和药物优化案例的数据。这让模型不仅掌握了化学规则，也学到了化学家实践中的「手感」和「技巧」。  
  
MECo 的「编码即编辑」模式，让 AI 在分子设计上「说人话，办人事」，把模糊的生成任务转变为清晰、可验证的工程问题，可能推动 AI 辅助药物设计走向更实用、更可靠的阶段。  
  
📜Title: Coder as Editor: Code-Driven Interpretable Molecular Optimization  
🌐Paper: https://arxiv.org/abs/2510.14455v1  

## 4. AlphaFold 新玩法：模拟上万种蛋白的动态构象  
  
![af_calvados_alpha_fo_2025_10_22_extract_paper_insights_news_rewrite_en_to_zh_image_2](post_all_image/af_calvados_alpha_fo_2025_10_22_extract_paper_insights_news_rewrite_en_to_zh_image_2.jpg)  

蛋白质不是僵硬的石头，它们会呼吸、摆动和变形。AlphaFold 2 给了我们蛋白质结构的高清「快照」，但这还不够，我们更想看一部「电影」，了解蛋白质如何动态变化。特别是那些包含固有无序区 (Intrinsically Disordered Regions, IDRs) 的多结构域蛋白，它们就像由几个坚固模块通过柔性绳索连接起来的装置，模拟其整体运动一直是个难题。  
  
问题在于，如何告诉计算机哪部分是「坚固模块」，哪部分是「柔性绳索」？过去这需要研究者手动定义，费时费力，无法大规模应用。  
  
AF-CALVADOS 模型提供了一个解决方案。  
  
它的工作原理是：先用 AlphaFold 2 预测整个蛋白质的结构，然后模型会查看 AlphaFold 自己给出的置信度分数——也就是 pLDDT 和 PAE。如果一个区域的 pLDDT 分数高，且 PAE 显示它是一个稳定的独立单元，模型就判定它是一个折叠良好的结构域。在后续模拟中，这个「模块」就被当作一个刚性整体处理。反之，如果一个区域的 pLDDT 分数低，那它就是「柔性绳索」，模型会让它在模拟中自由摆动。  
  
这个自动化流程是整个工作的核心，它让大规模模拟成为可能。研究者用这个方法，一口气模拟了 12,483 种人类细胞质蛋白的动态构象。  
  
当然，新方法需要验证其可靠性。研究者将模拟结果与已有的实验数据（比如蛋白质的回旋半径 Rg）比较，发现两者吻合得很好。这表明 AF-CALVADOS 模拟出的动态过程与物理现实基本相符。  
  
有了这个工具和海量数据，一些规律也浮现出来。  
  
一个重要发现是，上下文环境会改变 IDR 的行为。一个单独的 IDR 在溶液里可能像一根松散、伸展的绳子。但当它被夹在两个折叠良好的结构域之间时，情况就变了。这两个「大块头」的协同运动会限制它的活动空间，把它「挤」得更紧凑。这就像一根耳机线，如果两端的耳机头靠得很近，中间的线自然就没法伸展得太开。  
  
研究者还发现，即使在整个蛋白质的复杂环境中，IDR 序列本身的化学性质，比如电荷分布 (NCPR) 和疏水性模式 (SHD)，依然在微妙地影响着它的构象。蛋白质的动态行为，是其自身序列特性和周围结构域物理限制共同作用的结果。  
  
这项工作提供了一个巨大的、公开的蛋白质动态构象数据库。计算领域的同行可以拿它来训练新的机器学习模型，预测蛋白质的动态特性。而像我们这样做药物发现的，可以深入挖掘这个数据库，去研究某个特定的靶点家族，比如转录因子。它们的 IDR 区域往往在与 DNA 或其他蛋白结合时起着关键作用，了解其动态变化，也许就能为设计新的调控药物提供灵感。  
  
📜Title: AF-CALVADOS: AlphaFold-guided simulations of multi-domain proteins at the proteome level  
🌐Paper: https://www.biorxiv.org/content/10.1101/2025.10.19.683306v1  

## 5. ConforFold: 用二级结构解锁蛋白动态构象  
  
![confor_fold_recovers_2025_10_22_extract_paper_insights_news_rewrite_en_to_zh_image_1](post_all_image/confor_fold_recovers_2025_10_22_extract_paper_insights_news_rewrite_en_to_zh_image_1.jpg)  

蛋白质并非静止的积木，而是一直在运动和变形。例如，激酶激活环（activation loop）的 DFG-in 和 DFG-out 构象，就决定了抑制剂是 I 型还是 II 型。AlphaFold 预测蛋白质的静态结构很准，但捕捉这些动态变化却很困难。  
  
过去，获取不同构象的常用方法是处理多序列比对（MSA, Multiple Sequence Alignment），例如亚采样（subsampling）。这好比给一位画家看同一个人的许多生活照，希望他画出不同表情。这种方法有时有效，但模型常常还是会生成最「标准」的结构，难以捕捉到细微的构象变化。  
  
ConforFold 改变了思路，直接控制蛋白质折叠的「蓝图」——二级结构。  
  
它的工作原理分为两步。第一步，训练一个名为 ConforPSSP 的模型，用来预测蛋白质的多种可能二级结构。例如，模型可能预测某段序列有 60% 的概率是 α-螺旋（α-helix），30% 的概率是无规卷曲（coil）。  
  
第二步，将这些不同的二级结构「指令」输入给一个重训练过的 OpenFold 模型。这就像直接告诉画家：「这次，把嘴角画成上扬的。」通过给出明确的局部结构指令，模型被迫探索不同的折叠路径，生成多样的三维构象。  
  
这种方法主动引导构象搜索，而不是被动依赖 MSA 数据中微弱的信号。  
  
在一个包含两种构象的蛋白测试集上，ConforFold 成功复现两种构象的比例达到 84%（TM-score ≥0.8），优于标准的 AlphaFold 及其他依赖 MSA 采样的方法。  
  
这个工具有两点应用价值：  
  
1.  **解决 MSA 信息不足的难题**：对于进化上保守、MSA 信息贫乏的靶点，依赖 MSA 的方法通常会失效。ConforFold 对 MSA 依赖较小，为这类靶点提供了解决方案。  
2.  **形成方法互补**：ConforFold 能与 AlphaFlow 等方法互补。我们可以构建一个工具箱，针对不同靶点选用或组合最合适的工具，描绘出蛋白质完整的构象全景。  
  
项目代码已经开源，计算团队可以下载并在自己的靶点上测试。这种从更基础层面干预预测过程的思路，值得借鉴。  
  
📜Title: ConforFold Recovers Alternative Protein Conformations Beyond MSA Subsampling  
🌐Paper: https://www.biorxiv.org/content/10.1101/2025.10.14.682366v1  
💻Code: https://github.com/strauchlab/Confor-PSSP
