---
title: "From Protein Puzzles to Topological Networks and RAG-Powered Pharmacy"
description: |
  A clever "protein sequence puzzle" pre-training method significantly improves an AI's ability to make zero-shot predictions on new targets and drugs. Another model, GLDPI, finds rare "active" signals in a sea of "inactive" data by forcing the AI to respect the chemical "social network" of molecules. Finally, research shows that general-purpose large models are all show and no substance in pharmacy until they are "fed" high-quality, specialized databases using a RAG architecture.
date: "2025-08-10"
categories: ["AI Drug Discovery", "Computational Chemistry", "Large Language Models", "Cheminformatics"]
image: "post_all_image/validating_pharmacog_2025_07_31_image_1.png"
image-alt: |
  General-purpose large models are all show in specialized fields. To make AI truly useful in pharmacy, you have to feed it high-quality, specialized databases using a RAG architecture.
toc-depth: 3
---

## Table of Contents
1. By forcing a model to play a "protein sequence puzzle" game, researchers developed an efficient pre-training method that shows impressive potential in "double-blind" predictions for brand-new drugs and targets.
2. The smartest thing about this AI model isn't its predictions. It’s that during training, it's forced to respect the "common sense" of chemistry and biology, allowing it to accurately find rare "active" signals in a vast sea of "inactive" data.
3. General-purpose large models are all show in specialized fields. To make AI truly useful in pharmacy, you have to feed it high-quality, specialized databases using a RAG architecture.

## 1. Protein Sequence Puzzles: A New Way for AI to Predict Drug Targets

![](post_all_image/zero_shot_learning_w_2025_07_31_image_1.jpg)

Every day, we face a massive number of possibilities. On one side, countless chemical compounds. On the other, a seemingly endless list of potential protein targets. How do you find the right match in this haystack? AI has given us a lot of hope over the years, but it's also produced a lot of "black box" models. Everyone is competing on data volume and model size, but this paper offers a different approach.

The PSRP-CPI model proposed by these researchers isn't about how much data you feed it, but how you teach it. They designed a clever pre-training game: **subsequence reordering**.

Think of it as teaching a machine to understand protein "grammar." Instead of just having it read amino acid by amino acid, you take a full protein sequence (a sentence), chop it into several pieces, shuffle them, and then ask the model to put them back in the original order. It sounds simple, but to do it, the model has to understand which fragments are likely to be near each other in 3D space and which ones work together functionally, even if they're far apart in the sequence. This is exactly what drug developers think about all day: allosteric sites and long-range regulation. This method forces the model to learn the long-range dependencies within a protein, not just memorize local information like "B usually follows A."

Where does this power show up? In the toughest test case: **zero-shot learning**.

This is especially true for the "Unseen-Both" scenario, where both the compound and the protein are complete strangers the model has never seen during training. This perfectly mimics our real-world challenge of exploring new targets or new chemical scaffolds. Most models are just guessing in this situation, but PSRP-CPI's performance is exceptional. Its AUROC and AUPRC scores, two key metrics, leave competitors behind.

The paper's data shows that it can be trained on a much smaller dataset than large models like ESM-2 or ProtBert and still achieve better results on downstream compound-protein interaction (CPI) prediction tasks. In an era where compute is money, what that means is obvious. It tells us that a smart learning strategy can sometimes be more important than just throwing more computing power at a problem.

Of course, an *in silico* prediction is a long way from a real drug. A high-scoring pair from the algorithm might not be a match in a wet lab experiment. But as a filtering tool before high-throughput screening, this "sequence puzzle" approach is undoubtedly efficient and clever. It suggests the model might actually be learning some underlying logic about protein folding and function, rather than just doing advanced pattern matching. The next step is to see how its predicted "new combinations" perform in a test tube. If it can help us find a few promising lead compounds that traditional methods missed, its value would be significant.

📜Title: Zero-Shot Learning with Subsequence Reordering Pretraining for Compound-Protein Interaction
📜Paper: https://arxiv.org/abs/2507.20925

## 2. AI Predicts Drug Targets by Maintaining Molecular Social Networks

![](post_all_image/accurate_prediction_2025_08_10_image_1.jpg)

Most models are like students who only know how to answer multiple-choice questions. When 99.9% of the answers are "C" (does not bind), they learn to mindlessly pick C and then claim a 99.9% accuracy rate. In real-world drug discovery, that's useless. We care about the 0.1% of answers that are *not* C. We're looking for a needle in a haystack, and these models just tell you "there are no needles here."

This paper's model, called GLDPI, finally does something different. It doesn't focus on boosting that fake "accuracy." Instead, it directly attacks the most fundamental problem: data imbalance.

During training, it must maintain the "topological relationships" between the original molecules. What does that mean? Simply put, "birds of a feather flock together." If two drug molecules are chemical twins, they must also be next-door neighbors in the AI's "brain" (the embedding space). Likewise, if two proteins both belong to the kinase family, they should be mapped to the same neighborhood on the AI's map.

GLDPI uses a clever "a priori loss function" to enforce this rule. You can think of it as a strict librarian. When the AI tries to put a book on "quantum physics" (a drug molecule) on the "children's picture books" shelf (a totally unrelated protein family), the librarian steps in and forces it to put the book back in the right place. This way, the AI isn't just memorizing isolated facts like "this drug binds to this protein." It's learning the internal structure and logic of the entire chemical and biological space. It's drawing a meaningful map that respects physical reality.

What's the result? When you test it in a real-world scenario where "only one in a hundred thousand molecules binds," its performance (measured by AUPR, a more honest metric) blows all other methods out of the water, with an improvement of over 100%. This isn't a small tweak; it means its learning method is fundamentally correct.

Even more impressive is its speed. It can predict about 12 billion drug-protein interactions in less than 10 hours. What does this number mean? It means you can take a virtual compound library like Enamine REAL, which contains tens of billions of molecules, and cross-screen it against the entire proteome you care about. This used to be something only a supercomputing cluster at a large pharmaceutical company could consider. Now, it's a task that can be completed over a weekend.

We need to stay realistic. The model only predicts a *potential* interaction. It can't tell you if the molecule is an agonist or an inhibitor, nor can it give you details about the binding pocket. Taking an AI prediction straight to clinical trials would be insane. But as a tool that can screen for the first batch of "candidates" worth looking at from an endless sea of chemical possibilities, with unprecedented scale and accuracy, it is a breakthrough. It won't replace medicinal chemists, but it will give us a much better starting point, allowing us to focus our precious time and resources on the most promising needles, instead of digging through the entire haystack.

📜Title: Accurate prediction of drug-protein interactions by maintaining the original topological relationships among embeddings
📜Paper: https://bmcbiol.biomedcentral.com/articles/10.1186/s12915-025-02338-0

## 3. To Be Useful, AI in Pharmacy Needs to Be Fed Expert Data via RAG

![](post_all_image/validating_pharmacog_2025_07_31_image_1.png)

Everyone is praising the versatility of general-purpose large models, as if AI will be writing prescriptions tomorrow. But in a clinical setting where lives are on the line, would you really trust a "jack-of-all-trades, master-of-none" to make decisions? This new paper gives us an important warning and points to a clear path forward.

Pharmacogenomics (PGx) is an extremely complex field, involving genetics, pharmacology, and clinical practice. The related guidelines (like CPIC) are numerous and dense, and a small mistake can lead to errors. Asking a general-purpose Large Language Model (LLM), raised on the ocean of internet information, to handle these issues is like asking a well-read history professor to fix your car engine. He might be able to discuss the history of the internal combustion engine with you, but he definitely won't understand why your car is making a rattling noise. The result is the model confidently stating false information, which is what we call a "hallucination."

The authors of this study were clear-headed. They didn't try to build a "god of pharmacy" model from scratch. Instead, they took a smarter approach: **Retrieval-Augmented Generation (RAG**).

RAG is basically an open-book exam for a large model. When you ask it a question, it doesn't just guess based on its vast but mixed-quality memory. It first looks up the most relevant chapters in designated, authoritative textbooks (in this case, the CPIC and PharmGKB gold-standard databases). Then it organizes and summarizes what it finds before giving you an answer. This way, the answers have a clear, traceable source, and the chance of it talking nonsense is much lower.

The researchers used this method to build an AI assistant called Sherpa Rx. They then designed 260 realistic pharmacogenomics questions for a head-to-head comparison. And the result?

In accuracy (4.9/5) and completeness (4.8/5), Sherpa Rx, "fed" with a specialized knowledge base, completely outperformed the well-known general-purpose model, ChatGPT-4o mini.

This is more than just a win in numbers. It proves a point that people in the industry have known for a while: in serious scientific and medical fields, the **quality of data is far more important than the quantity**. Training a model on all the noise of the entire internet is less effective than using a small but rigorously validated, gold-standard dataset for retrieval augmentation.

Of course, this doesn't mean we can start using it in clinics tomorrow. The study's sample size is small, and the 260 test questions were designed by the researchers themselves, which could introduce bias. The real test will be to throw it into a chaotic, noisy, real-world clinical environment and see if it can handle the variety of strange questions doctors ask, all while consistently providing reliable advice.

📜Title: Validating Pharmacogenomics Generative Artificial Intelligence Query Prompts Using Retrieval-Augmented Generation (RAG)
📜Paper: <https://arxiv.org/abs/2507.21453>
