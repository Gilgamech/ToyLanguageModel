Rudimentary Deterministic Inferential Generation


Primitive tokenization
Nested-Hash Generation
The Satin System
Attentive Generation
Inference from Word Significance
"Satin Strain" Significance-Based Training
Prompt Devolution
Simian (SIMIaN - SIMple INference) 

In the pursuit of a "juvenile implementation" of a language model, a meta-analysis and ensuing simplification of existing techinques yielded a novel result. This system is entirely deterministic, unlike the more popular contemporary implementations, and always returns identical answers to replayed propmts, in approximately the same CPU time. This system provides timely and sometimes-relevant results from a single x86 core and several MB of RAM.







Primitive tokenization

Unicode encoding was preferred, in line with a "juvenile implementation". Byte-level coding remains a future option. Tokenziation largely replaces symbols and reserved words with an unused concatenation, such as replacing a question mark `?` with `aQuestionMark`, which is unlikely to appear in the corpus in this concatenated form. Tokenization also lowercases all text, including these replacement tokens. 

// Extract the to-do and future optimization parts. Talk about these parts as though they're perfect. Because your theory is perfect, but your implementation is not quite yet.
Periods are used as the sole "EOS" (end of sentence) token. Question marks and other sentence-ending punctuation could be included, possibly by changing ""EOS" to "ESP" (end sentence period), leaving room for "ESQ" (end sentence question mark) and similar tokens. But practical research has not yet taken this step. This arrangement allows "EOS" to be an ideal token for starting random sentences.

Detokenization replaces tokens with their original symbol. It also capitalizes the first letter of the sentence and ensures a period is at the end. Better handling is needed for other punctuation, including those requiring asymmetric escaping. This partial tokenization process is not as obfuscatory as byte-level tokenization, which may have lead to efficiency gains during research. 

The author's 2024 novel The Offgrid Office was used as the primary training corpus. It represents a highly-curated data set, with very few grammar and spelling errors, and very little "noise" or non-grammatical data. And at 64,831 unique words, it represents a "juvenile implementation" of a large data set.
// A version of The Bible was used as a secondary corpus. (Find which version, to reference.)

Nested-Hash Generation

Inspired by commercial implementations depending on probabilistic generation, the first iteration of this Generator system was essentially an autosuggest mechanism, solely based around probabilistic next-token prediction. The corpus was indexed into a hash table, and nested within each of these was another hash table with keys as the next token in the corpus. The values for these keys were the incidences of sequence recurrence throughout the corpus. 

Periods were replaced with "EOS" during tokenization, as mentioned before, and this makes them ideal for seeding sentence generation. For "word salad" generation, a random key from "EOS" could be chosen, then a random key from that key, et cetera. The random-choosing method in use was inspired by the concept of using a role-playing game's outcome table (and dice rolls) to form sentences from piles of poetry tiles. To choose the key, the values are summed, and system generates a random number between 1 and the sum of values. Then, the keys are "stacked", where each token gets a number of stack locations equal to its incidence of recurrence, and the system increments through stack locations until the random number is reached. The token with this final stack location is the selected token, and the process iterates. Further research into the stack order could be performed. 

Previous-word prediction was also a target for experimentation. Similar to Generation, the "Pre" system starts by indexing the corpus into a hash table. Unlike standard Generation,  the hash table nested within a given value would hold the tokens preceding the matching key in the corpus. The values for these second-order keys were still the incidences of sequence recurrence throughout the corpus. Generation here would start with a random key of "EOS" being the last word in the sentence. Performing the same "stacking" process as described above allowed moving backwards through sentences, until reaching the preceding "EOS" token to start the sentence. This set of words would be returned in reverse order to compensate for the reverse generation. A random sampling of previous and subsequent Generated sentences led to the determination that output appeared equivalent, but further research could be performed here as well.  

Inspired by commercial implementations apparently having 16 layers of generation look-ahead, "Third" and "Trivet" systems were developed. These expand on the base Generation and "Pre" systems, by nesting another layer of tokens betwen the root layer and the top layer. Third being the forward looking system, where a root-layer token will be represented by a hash table with keys as next tokens, and values as hash tables, each of which holds a 3rd subsequent token as a key and sequence count as value. Likewise, the "Trivet" (Portmanteu of "TRIple" and reversed "prEV" from shortened "previous", and the final "T" suggested itself.) system has root keys whose values are hash tables of previous tokens, and the keys of those are the second-previous tokens in the corpus before the root key. The value is again the incidence of recurrence of that sequence of tokens throughout the corpus. These provided far superior sentence generation from the preceding iteration. 

While Generation here wasn't quite capable of replying logically, it did have the capability of randomly-generating functional PowerShell code, when trained on a similarly-curated set of the author's open-source PowerShell modules. Generally, these functions took the form of one set of parameters, and a non-overlapping set of operational variables and constants, causing these functions to have no output. But some did develop (frequently destructive) capabilities, with the the second deleting the working directory while loading the module. The first module merely displayed informational messages.

The Satin System

Satin ("SAttn" or Short Attention, to indicate a "juvenile implementation") originates with the description of vectorized training being the process where each word is indexed to an n-vector database row, then words trained through the process of vector alignment. In one example, n=768. This system is much too complex for a "juvenile implementation", so the physics technique of Vector Addition was used to summarize these vectors into a single integer. An index of these integers becomes an Idea Index, where similar ideas are proximal and disparate ideas are numerically separated. Training here involved iterating through the corpus, incrementing or decrementing Idea Index locations to cluster corpus-proximal tokens. Particles and other low-entropy words should experience higher amounts of motion with this training method than higher-entropy words. 

Satin training wasn't strictly necessary, as the system could be functional without it, able to return inferior results. Some level of training improved results, but training beyond this point led to a numerical convergence. A flaw in the technique of moving Idea Index locations together is that it leads to the eventual convergence of all Idea Indices to the same location, given sufficient training. All ideas appear alike then, and Generation effectively results in a word salad.

Attentive Generation

// Probabilistic Generation is a bane of modern AI, leading to a consistent level of inconsistency in results. The current solution involves a long next-word prediction window. But if this window is longer than average response length, the system might just be performing traditional data storage and retrieval. The current state of the art leads to sometimes the majority of prompts to require cyclic reprompting. 

Attentive Generation uses the Idea Index Relevance from the target word to determine next word, taking the word closest to the target. This replaces Generation's random walk, effectively creating a form of heat map navigation through the graph effectively generated by next-word prediction. While the system frequently reaches "EOS" before the target word, if given a large enough response window, the target word very frequently shows up in the results. And if the window is too large, Generation has a habit of looping through the graph's local minima, when viewed from the perspective of the given Idea Index location.

Inference tuned by Word Significance

While Attentive Generation can generate informative sentences from a corpus, a full model needs Inference as well. The challenge here is determining which words are significant, after which its Idea Index location can be used to target Attentive Generation. Word Significance here is determined solely by the inverse quantity of previous and next word options. While only the Weights system was used at first, the Pre system was later invoked for bidirectional Significance.

Significance is really about entropy. Frequently-used terms, such as particles, should have innumerable connections to words across the corpus, and so have a high number (high entropy) of both next-word suggestions and previous-word suggestions. Likewise, uncommon terms with few connections (low entropy) tend to be main ideas or important concepts. 

"Satin Strain" Significance-Based Training

As mentioned earlier, a flaw in the original training technique of moving Idea Index locations together involves the eventual convergence of all Idea Indices to the same location, given sufficient training. What was needed was a way to anchor some words, while allowing others to move freely. Word Significance suggested itself again as an ideal tool.

Satin Strain (SAttn STrain as Simple Attention Simple Train) multiplies the Movement by the inverse of the Significance. This anchors in place highly significant words, while promoting the motion of particles and other less-significant words. For example, the word "would" has 117 incoming and 113 outgoing possible next word combinations in the corpus, and so has a Significance of only approximately 0.0043478. While the word "Easton" (from Lake Easton) only has 7 incoming and 8 outgoing pssible next words, giving it a Significance of approximately 0.0667. 

Sig = 1 / Σ(Pre(n))+Σ(W(n))

These scores are normaized to one, weighting Significance towards less-connected words. 

To further expedie training, epoch fast-forwarding was implemented. this techinque multiplies the Movement value by several orders of magnitude. Bulk Satin Straining refers to this with "Strain Movement" terminology. "Strain 100" indicates that 100 is the current Movement value. The initial value of 100,000 seems ideal for the above-described corups of 64,831 words, as the Satin system gives this corups an Idea Index space of nearly 6.5 million locations. A random assortment of words are chosen for tracking during training. if the Movement value foreach of those words falls below 1% of the Movement value, it becomes demoted by an order of magnitude. This continues until the Movement factor is sub-rounding.

This process is deterministic, causing identical prompts on subsequent experiments to return identical responses. Total training time for this epochal training process was consistently around 20 to 23 minutes for this small corpus. 

Prompt Devolution


Prompts are tokenized, then split by spaces, to be used for Attentive Generation targets. Instead of starting at "EOS" as above, here each combination of the prompt tokens are used to seed Generation, and each token in each sentence has its Idea Index location evaluated against each of the words in the Prompt. 


Simian (SIMIaN - SIMple INference) 

Bringing back recurrence allows us to build tension between Significance, Relevance, Recurrence, and Incidence. As with Attentive Generation, perform



Take the prompt, tokenize and add EOS. 
Foreach p/q, next-word until EOS.
Take these sentences, and compare each word's idea index to the idea index of each word in the prompt.
Because the prompt tells us what the user wants.
So the set of closest matches should be the best match. 
Match a p with all q, keep the lowest Relevance. Do this foreach p, sum the resuts. Then foreach sentence. Keep the sentences with the lowest sums.

Do it during generation so it's faster.

C = Corpus
C[n] = Current Word
C[n+1] = Subsequent Word
Tw = Target word (Has to be in the corpus or the system simply doesn't know.)
Ix = Idea Index
T = Word Count
W = Forward-looking weight set
Pre = Backwards-looking weight set
Rel = Relevance betweeen the target word's Idea Index location and the current word's Idea Index location. 
S = Sentence
R = Next word recurrence in corupus.
L = Word recurrence in Sentence.
M = Prompt

Word Likelihood is adjusted significance times adjusted probability.
L = σ * P

Where
Adjusted significance is Relevance multiplied by significance, so insignificant words from farther away aren't as unlikely. 
σ = Rel * Sig

Relevance is the absolute value betweeen the target word's Idea Index location and the current word's Idea Index location. 
Rel = | Ix[Tw] - Ix[n] | 

Significance is the inverse of the counts of forward-looking next words and backwards-looking next words. 
Sig = 1 / Σ(Pre(n))+Σ(W(n))

Adjusted probability is Recurrence divided by instance to see if it should be in the sentence. 
P = R / I

Where
Recurrence is the number of times that the next word follows the current word in the corpus. 
R = Σ(C[n] -> C[n+1])

Instance is the number of times that the word occurs in the sentence-as-calculated:
I = Σ(S(n))


L = σ * P
L = Rel * Sig * R / I

`L = | Ix[Tw] - Ix[n] | / Σ(Pre[n])) + Σ(W[n]) * Σ(C[n] -> C[n+1]) / Σ(S[n])`

S = S + L(M)







Compute Efficiency

A key feature of a "juvenile implementation" is reduced compute needs. The implementation consists of 930 LOC of PowerShell, running on a single core of an Intel i7-8550U laptop CPU running at an unrecorded frequency between 1.80 GHz and 4.0 GHz. This system provides many answers in under a second, with long-running prompts taking at most 30 seconds. As mentioned above, training on the given corpus consistently takes under 30 minutes. The corpus consists of approximately 346 KB of data. The weight set, consists of approximately 23.9 MB of uncompressed XML, and compresses to 1.12 MB. This level of compute efficiency implies that the system could function on an incredible array of devices, including the majority of embedded and portable devices. Given the proliferation of this level of proessor, the technology here described could inform innumerable robots, smart devices, and even greeting cards in the future. 
