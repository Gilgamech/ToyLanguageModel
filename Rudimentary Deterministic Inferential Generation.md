Rudimentary Deterministic Inferential Generation

In the pursuit of a "juvenile implementation" of a language model, a meta-analysis and ensuing simplification of existing techinques yielded a novel result. This system is entirely deterministic, unlike the more popular contemporary implementations, and always returns identical answers to replayed propmts, in approximately the same CPU time. This system provides timely and sometimes-relevant results from a single x86 core and several MB of RAM.

Primitive tokenization
Nested-Hash Generation
The Satin System
Attentive Generation
"Satin Strain" Significance-Based Training
Prompt Devolution
Simian (SIMIaN - SIMple INference) 

# Primitive tokenization

Unicode encoding was preferred, in line with a "juvenile implementation". Byte-level coding remains a future option. Tokenziation largely replaces symbols and reserved words with an unused concatenation, such as replacing a question mark `?` with `aQuestionMark`, which is unlikely to appear in the corpus in this concatenated form. Tokenization also lowercases all text, including these replacement tokens. Detokenization reverts these. Periods are used as the sole "EOS" (end of sentence) token. Question marks and other sentence-ending punctuation could be included, but practical research has not yet taken this step. This arrangement allows "EOS" to be an ideal token for starting random sentences. As the tokens here are mostly words, the terms "token" and "word" might occasionally be interchanged at this scope. 

The author's 2024 novel The Offgrid Office was used as the primary training corpus. It represents a highly-curated data set, with very few grammar and spelling errors, and very little "noise" or non-grammatical data. And at 64,831 unique words, it represents a "juvenile implementation" of a large data set. A version of The Bible was used as a secondary corpus. (https://openbible.com/pdfs/cpdv.pdf)

# Nested-Hash Generation

The first iteration of this Generator system was essentially an autosuggest mechanism, solely based around probabilistic next-token prediction. The corpus was indexed into a hash table, and nested within each of these was another hash table with keys as the next token in the corpus. The values for these keys were the incidences of sequence Recurrence throughout the corpus. 

R = Σ(W[n] -> W[n+1])

Inspired by commercial implementations apparently having 16 layers of Generation look-ahead, "Third" and "Trivet" systems were developed. These expand on the base Generation and "Pre" systems, by nesting another layer of tokens betwen the root layer and the top layer. "Third" being the forward looking system, where a root-layer token will be represented by a hash table with keys as next tokens, and values as hash tables, each of which holds a 3rd subsequent token as a key and sequence count as value. Likewise, the "Trivet" (Portmanteu of "TRIple" and reversed "prEV" from shortened "previous", and the final "T" suggested itself.) system has root keys whose values are hash tables of previous tokens, and the keys of those are the second-previous tokens in the corpus before the root key. The value is again the incidence of Recurrence of that sequence of tokens throughout the corpus. These provided far superior sentence Generation from the preceding iteration. 

R = Σ(W[n-1] -> W[n] -> W[n+1])

Periods ("EOS" token) made them ideal for seeding random sentence Generation. A random key from "EOS" could be chosen, then a random key from that key, et cetera. The random-choosing method in use was inspired by the concept of using a role-playing game's outcome table (and dice rolls) to form sentences from piles of poetry tiles. To choose the key, the values are summed, and system generates a random number between 1 and the sum of values. Then, the keys are "stacked", where each token gets a number of stack locations equal to its incidence of Recurrence, and the system increments through stack locations until the random number is reached. The token with this final stack location is the selected token, and the process iterates. Further research into the stack order could be performed.

S[n+1] = Σ(R(W[n-1] -> W[n] -> W[n+1]) > rng

Previous-word prediction was also a Target for experimentation. Similar to Generation, the "Pre" system starts by indexing the corpus into a hash table. Unlike standard Generation,  the hash table nested within a given value would hold the tokens preceding the matching key in the corpus. The values for these second-order keys were still the incidences of sequence Recurrence throughout the corpus. Generation here would start with a random key of "EOS" being the last word in the sentence. Performing the same "stacking" process as described above allowed moving backwards through sentences, until reaching the preceding "EOS" token to start the sentence. This set of words would be returned in reverse order to compensate for the reverse Generation. A random sampling of previous and subsequent Generated sentences led to the determination that output appeared equivalent, but further research could be performed here as well.  

S[n-1] = Σ(R(Pre[n+1] <- Pre[n] <- Pre[n-1]) > rng

While Generation here wasn't quite capable of replying logically, it did have the capability of randomly-generating functional PowerShell code, when trained on a similarly-curated set of the author's open-source PowerShell modules. Generally, these functions took the form of one set of parameters, and a non-overlapping set of operational variables and constants, causing these functions to usually have no output. But some did develop (frequently destructive) capabilities, with the the second attempt deleting the working directory while loading the module. The first module merely displayed informational messages.

# The "Satin" System

Satin ("SAttn" or Short Attention, to indicate a "juvenile implementation") originates with the description of vectorized training being the process where each word is indexed to an n-vector database row, then words trained through the process of vector alignment. In one example, n = 768. This system is much too complex for a "juvenile implementation", so the physics technique of Vector Addition was used to summarize these vectors into a single integer. An index of these integers becomes an Idea Index, where similar ideas are proximal and disparate ideas are numerically separated. Training here involved iterating through the corpus, incrementing or decrementing Idea Index locations to cluster corpus-proximal tokens. Particles and other low-entropy words should experience higher amounts of motion with this training method than higher-entropy words. 

Ix(C[n]) =  v[1] + v[2] . . . v[768]

Satin training wasn't strictly necessary, as the system could be functional without it, able to return inferior results. Some level of training improved results, but training beyond this point led to a numerical convergence. A flaw in the technique of moving Idea Index locations together is that it leads to the eventual convergence of all Idea Indices to the same location, given sufficient training. All ideas appear alike then, and Generation effectively results in a word salad.

# Attentive Generation

Attentive Generation uses the Idea Index Relevance from the Target Word to determine next word, taking the word closest to the Target. Relevance is the absolute value betweeen the Target word's Idea Index location and the current word's Idea Index location. 

Rel = | Ix[Tw] - Ix[n] | 

This replaces Generation's random walk, effectively creating a form of heat map navigation through the graph effectively generated by next-word prediction. While the system frequently reaches "EOS" before the Target word, if given a large enough response window, the Target Word very frequently shows up in the results. And if the window is too large, Generation has a habit of looping through the graph's local minima, when viewed from the perspective of the given Idea Index location.

// Go deeper into the way that each word is picked, and the sentence drifts towards the target word.


# "Satin Strain" Significance-Based Training

As mentioned earlier, a flaw in the original training technique of moving Idea Index locations together involves the eventual convergence of all Idea Indices to the same location, given sufficient training. What was needed was a way to anchor some words, while allowing others to move freely. Word Significance suggested itself again as an ideal tool.

Satin Strain ("SAttn STrain" as Simple Attention Simple Train) multiplies the Movement by the inverse of the Significance. This anchors in place highly Significant words, while promoting the motion of particles and other less-Significant words. For example, the word "would" has 117 incoming and 113 outgoing possible next word combinations in the corpus, and so has a Significance of only approximately 0.0043478. While the word "Easton" (from Lake Easton) only has 7 incoming and 8 outgoing pssible next words, giving it a Significance of approximately 0.0667. 

Sig = 1 / Σ(Pre(n))+Σ(W(n))

These scores are normaized to one, weighting Significance towards less-connected words. 

To further expedie training, epoch fast-forwarding was implemented. this techinque multiplies the Movement value by several orders of magnitude. Bulk Satin Straining refers to this with "Strain Movement" terminology. "Strain 100" indicates that 100 is the current Movement value. The initial value of 100,000 seems ideal for the above-described corups of 64,831 words, as the Satin system gives this corups an Idea Index space of nearly 6.5 million locations. A random assortment of words are chosen for tracking during training. if the Movement value foreach of those words falls below 1% of the Movement value, it becomes demoted by an order of magnitude. This continues until the Movement factor is sub-rounding.

Ix(C[n])[i+1] =  Ix(C[n])[i] + Strain / Sig

This process is deterministic, causing identical prompts on subsequent training runs to return identical responses. Total training time for this epochal training process was consistently around 20 to 23 minutes for this small corpus. For the larger Bible corpus, it was closer to 12 hours.

# "SIMIaN" SIMple INference

Bringing back Recurrence allows us to build tension between Significance, Relevance, Recurrence, and Instance. This tension is a suitable replacement for a random number generator as a Generation driver. As with Attentive Generation, performing these steps during Generation is highly efficient. 

Word Likelihood is adjusted Significance times adjusted probability.
L = σ * P

Where
Adjusted Significance is Relevance multiplied by Significance, so Insignificant words from farther away aren't as unlikely. This was originally meant to offset their greater movement capabilities.
σ = Rel * Sig

Adjusted probability is Recurrence divided by Instance. This allows repetitious words (i.e. "again and again") to reappear, while preventing repeats of more-singular words.
P = R / I

And
Instance is the number of times that the word already occurs in the sentence-as-calculated:
I = Σ(S(n))

In full: 
`L = | Ix[Tw] - Ix[n] | / Σ(Pre[n])) + Σ(W[n]) * Σ(C[n] -> C[n+1]) / Σ(S[n])`

This couples more-Significant words more-tightly to the Target Word, while allowing more freedom from less-Significant words. And also allowing more repititious words to appear with greater frequency. 

# Prompt verification against Weights

The tokenized prompt is split into n-word sequences and replayed against the corpus - this gives the system a rudimentary way of checking or verifying the prompt against the corpus. Then, these sentences were knit back together, based on the "veracity" of the sequence - the extance of the sequence within the weights.  Because the next-word or previous-word incicdence doesn't just indicate the presence of the finalmost child key, but of the entire n-word sequence. 

This effectively maps the prompt terms against the Weights. The output of which is reduced through minimization of Relevance distance from the prompt terms. Because the prompt tells us what the user wants, so the set of closest matches should be the best match. Adjusted Relevance is the sum of the minimum Relevances, dvided by the number of zeroes (exact matches):

Σ(Min(Rel(C[n], Tw))) / Σ(NumZeroes(Rel(C[n], Tw)))

Words which are non-extant in the corpus are returned immediately with no other output, to indicate no knowledge of these terms. Matching sequences are returned directly, to confirm. And non-matching sequences composed of extant words are used to seed and Target Generation, with the intent of returning sequences composed of those terms, as well as terms with proximal Idea Index locations. The Extant sequences were emitted directly, as well as used to generate a Related Words list based on Idea Index proximity. The Non-Extant sequences were used to seed another round of sentence Generation, using the Related Words for the Targets. Note that any words in the prompt but missing from the corpus have become omitted by this point, so the concern here is ordinal. A separate object array was built and stored specifically for this purpose. 

# Inferred Results

Inference can be initiated through using both Generation Seed and Target words which exist in the same corpus sentence, but not the same order. This is especially effective when the Target Word has several tightly-coupled neighbors and is numerically distant from other concepts. 

# Compute Efficiency

A key feature of a "juvenile implementation" is reduced compute needs. The implementation consists of 930 LOC of PowerShell, running on a single core of an Intel i7-8550U laptop CPU running at an unrecorded frequency between 1.80 GHz and 4.0 GHz. This system provides many answers in under a second, with long-running prompts taking at most 30 seconds. As mentioned above, training on the given corpus consistently takes under 30 minutes. The corpus consists of approximately 346 KB of data. The weight set, consists of approximately 23.9 MB of uncompressed XML, and compresses to 1.12 MB. This level of compute efficiency implies that the system could function on an incredible array of devices, including the majority of embedded and portable devices. Given the proliferation of this level of proessor, the technology here described could inform innumerable robots, smart devices, and even greeting cards in the future. 

# Inspiration

The "juvenile implementation" sought here was inspired by the Easy Bake Oven, which is capable of converting small quantities some doughs into individual baked goods, using a single 60 watt light bulb as the sole heating element. Beginning with trying to design a Generator based on social media descriptions. Additional inspiration came from interactions with Chaotic mathematics, and an understanding that while these systems are highly non-linear, they are also quite deterministic. Which meant a deterministic language model should be quite feasible. 

C = Corpus
C[n] = Current Word
C[n+1] = Subsequent Word
Tw = Target Word (Has to be in the corpus or the system simply doesn't know.)
Ix = Idea Index
T = Word Count
W = Forward-looking weight set
Pre = Backwards-looking weight set
Sig = Significance
Rel = Relevance betweeen the Target word's Idea Index location and the current word's Idea Index location. 
S = Sentence
R = Next word Recurrence in corupus.
L = Word Recurrence in Sentence.
M = Prompt
rng = Random Number Generator output
v = vector


