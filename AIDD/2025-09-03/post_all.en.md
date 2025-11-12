---
title: "The Frontier of AI Drug Discovery: Uncovering Protein Dynamics, Fighting Superbugs, and Solving Activity Cliffs"
description: |
  Explore the latest advances in AI for drug discovery. The CF-random method reveals proteins' hidden multiple conformations by reverse-engineering AlphaFold2. Transfer learning enables efficient screening of new antibiotics for data-scarce bacteria. The HypSeek model uses hyperbolic geometry to accurately predict and solve the "activity cliff" problem in drug discovery.
date: "2025-09-03"
categories: ["AI Drug Discovery", AlphaFold2, "Transfer Learning", "Hyperbolic Space", "Protein Conformation"]
image: "post_all_image/image_20250709_223303_1.jpg"
image-alt: |
  By borrowing models trained on big data, researchers have efficiently screened potential new antibiotics for specific bacterial strains where data is scarce, offering a new approach to the difficult problem of drug resistance.
toc-depth: 3
---

## Table of Contents
1. A new method, CF-random, cleverly "starves" AlphaFold2's input to reveal the hidden, multiple conformations of proteins, suggesting the protein world is far more dynamic than we thought.
2. By "borrowing" models trained on big data, researchers efficiently screened for potential new antibiotics for a specific bacterial strain with limited data, offering a new way to tackle the stubborn problem of drug resistance.
3. The HypSeek model learns protein-ligand interactions in hyperbolic space, using its geometric properties to effectively solve the "activity cliff" problem in virtual screening.

## 1. Reverse-Engineering AlphaFold2 to Unlock Hidden Protein Conformations

![](post_all_image/image_20250709_223323_1.jpg)

AlphaFold2 gives us a perfect static structure, but proteins in the real world aren't so still. Many proteins are like transformers, adopting multiple conformations. Capturing these dynamic changes is vital for understanding their function and designing drugs. AlphaFold2 usually just gives you the most stable conformation, leaving you to guess the rest.

Researchers developed a method called CF-random. We know AlphaFold2's power comes from massive Multiple Sequence Alignments (MSAs), where it learns the "conspiracies" between amino acids from evolutionary relationships. But these researchers did the opposite. They intentionally put AlphaFold2 on a diet, feeding it very few sequences—sometimes as few as three.

This approach bypasses the reliance on co-evolutionary signals. With insufficient information, AlphaFold2 is forced to rely more on the deep structural knowledge embedded within the model from its training. The researchers call this "sequence association." It’s a bit like a super-enhanced version of homology modeling. The model no longer rigidly assembles a structure based on sequence co-evolution. Instead, it searches its vast internal "structure library" for the most plausible folding possibilities based on the few clues you provide.

How well does it work? On a set of 92 known fold-switching proteins, older methods struggled to get 7-20% right. CF-random hit a 35% success rate with much less computation. It doesn't just find these major conformational changes. It's also 95% accurate for local fluctuations or rigid-body motions like a pair of scissors opening and closing, outperforming newer methods like AFSample2.

And there's more. The researchers used this tool to do a blind screen of 2,126 proteins from *E. coli* and uncovered 52 new proteins with potential fold-switching capabilities. If this ratio holds, as much as 5% of the entire proteome could be "master transformers." Many are linked to core functions like transcriptional regulation and structural maintenance. Imagine a drug target with two conformations: one disease-causing, one harmless. Our goal would shift from simple inhibition to designing a molecule that "locks" it in the harmless state. CF-random gives us the key to find both conformations.

Of course, it can produce false positives by misinterpreting inter-chain interactions. And if a protein's conformation is completely unseen in AlphaFold2's training data, it can't help. So, after getting a prediction, it’s still necessary to cross-verify with co-evolutionary analysis or, even better, experiments.

But this work shows that the AlphaFold2 "black box" may hold far more secrets about protein dynamics than we ever imagined.

📜Title: Large-scale predictions of alternative protein conformations by AlphaFold2-based sequence association
📜Paper: https://www.nature.com/articles/s41467-025-60759-5
💻Code: https://github.com/ncbi/CF-random_software

## 2. AI vs. Superbugs: Can New Antibiotics Be Found with Little Data?

![](post_all_image/image_20250709_223303_1.jpg)

Most of the time, AI models are like hungry beasts that you have to feed massive amounts of data to get anything useful back. But what if you're targeting a less common but equally deadly bacterium, like the AIEC LF82 strain that contributes to Crohn's disease? Where do you get enough data?

The answer: transfer learning.

You wouldn't send a medical student straight into surgery; you'd have them learn basic anatomy first. Similarly, researchers first trained their deep learning models—a base model called CL-MFAP and a Graph Neural Network (GNN) called D-MPNN—on a large, general database of antimicrobial activity. This turned the models into "generalists" with a basic understanding of what an "antibiotic-like molecule" looks like.

Then, they used their small, specialized dataset for AIEC LF82 to "fine-tune" and "calibrate" the models. This process turned the "generalists" into "specialists" focused on AIEC LF82.

How did this one-two punch perform? They used this system to screen nearly 11 million commercially available compounds. This wasn't just a simple scoring exercise. A true expert would appreciate the thoroughness of their screening process.

First, they used the CL-MFAP model, which is multi-modal. This means the model doesn't just look at one aspect of a molecule. It considers SMILES strings, Morgan fingerprints, and molecular graphs all at once to get a 360-degree understanding. This is like a seasoned chemist examining a molecule from different angles.

Next came the tough filtering stage.

Finally, using Butina clustering, they selected the 100 most structurally diverse candidates from the survivors. The results showed that these 100 molecules belonged to 82 different Bemis-Murcko scaffolds.

Of course, all of this is still in the computer. These 100 molecules now have to be tested in a wet lab. MIC experiments, kill curves, animal models... the real challenge is just beginning.

📜Paper: https://openreview.net/forum?id=QI0Wx8LY8D

## 3. Drug Discovery in Hyperbolic Space: An AI That Understands "Activity Cliffs"

![](post_all_image/learning_protein_lig_2025_08_24_image_2.jpg)

In drug discovery, especially during lead optimization, one of the most frustrating problems is the "activity cliff."

What does that mean?

It’s when you work hard to make a tiny change to a molecule—say, swapping a methyl group for an ethyl group—only to find the new molecule's activity doesn't just increase or decrease slightly, but plummets by a factor of a thousand. This phenomenon is a huge headache for predicting structure-activity relationships (SAR).

Traditional machine learning models, especially those that operate in Euclidean space (the three-dimensional space we're familiar with), often fail here. In their view, two structurally similar molecules should be close together and have similar properties. They struggle to understand how a tiny change can lead to a massive difference.

The HypSeek model from this paper offers a new perspective to solve this problem.

#### Upgrading the Toolkit: From Euclidean to Hyperbolic Space

The authors argue that the problem isn't the model, but the "space" we use to represent molecules. They boldly embedded molecules, protein pockets, and sequences into a non-Euclidean geometric space called "hyperbolic space."

What's so special about hyperbolic space?

You can think of it as a bowl whose edges stretch out to infinity. In this space, distance is calculated differently than we're used to.

What does this mean? Two points that are structurally very similar (like that activity cliff pair) can be placed very far apart in hyperbolic space. This space naturally has the ability to "magnify" small differences.

This gives the model a powerful "inductive bias." The model no longer needs to struggle to learn how to distinguish activity cliffs; the geometry of hyperbolic space itself does most of the work.

#### How Does It Perform? Let's See the Results

HypSeek showed significant improvements across several benchmarks:
1.  **Virtual Screening**: On the classic DUD-E dataset, the early enrichment factor increased from 42.63% to 51.44%. This means a higher probability of finding true active molecules among the top-ranked screening hits.
2.  **Affinity Ranking**: In an affinity ranking task, the correlation coefficient improved from 0.5774 to 0.7239. This shows it predicts changes in affinity more accurately.
3.  **Confronting Activity Cliffs**: When tested specifically on activity cliff pairs, the score difference produced by HypSeek was an order of magnitude larger than that of Euclidean-based models. This proves it can more clearly separate the "good" molecules from the "bad" ones.

The paper notes that in cases where even computationally expensive Free Energy Perturbation (FEP) methods predicted the wrong direction of affinity change, HypSeek's hyperbolic scores still provided the correct ranking consistent with experimental results.

Sometimes, solving a hard problem doesn't require a more complex model, but a more suitable mathematical framework. Introducing hyperbolic geometry to drug discovery opens a new door for understanding and predicting complex protein-ligand interactions.

📜Paper: https://arxiv.org/abs/2508.15480
