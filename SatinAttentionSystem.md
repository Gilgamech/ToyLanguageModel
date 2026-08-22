Attentive Generation And The Satin System

In the pursuit of a toy language model, a meta-analysis and ensuing simplification of existing techinques yielded a novel artificial intelligence result. This system is entirely deterministic, unlike the more popular contemporary implementations. Originally meant to be a fully-working "juvenile implementation", this system provides timely and sometimes-relevant results from a single x86 core.

Several challenges plague modern AI systems, from high usage costs to inscrutable data sets to probabilistic results. This system has the potential to alleviate or even obviate these problems and more. But a key feature of Chaotic systems is that while they are highly dynamic, they are entirely deterministic. And so an entirely deterministic artificial intellgence should be quite feasible. 

Primitive tokenization

Unicode encoding was preferred, in line with a "juvenile implementation". Byte-level coding remains a future option. Tokenziation largely replaces symbols and reserved words with an unused concatenation, such as replacing a question mark `?` with `aQuestionMark`, which is unlikely to appear in the corpus in this concatenated form. Tokenization also lowercases all text. 

Periods are used as the sole "EOS" (end of sentence) token. Question marks and other sentence-ending punctuation could be included, possibly by changing ""EOS" to "ESP" (end sentence period), leaving room for "ESQ" (end sentence question mark) and similar tokens. But practical research has not yet taken this step. This arrangement allows "EOS" to be an ideal token for starting random sentences.

Detokenization replaces tokens with their original symbol. It also capitalizes the first letter of the sentence and ensures a period is at the end. Better handling is needed for other punctuation, including those requiring asymmetric escaping. 

Nested-Hash Generation

The first iteration of this Weights system was essentially an autosuggest mechanism, solely based around probabilistic next-word prediction. Training involved indexing the corpus into a hash table, and nested within each of these was another hash table, keys populated with the next word in the corpus. The values for these keys were the next word's incidence of recurrence throughout the corpus. 

The author's 2024 novel The Offgrid Office was used as the primary training corpus. It represents a highly-curated data set, with very few grammar and spelling errors, and very little "noise" or non-grammatical data. And at 64,831 words, it represents a "juvenile implementation" of a large data set.

Periods were replaced with "EOS" during tokenization, as mentioned before, and this makes them ideal for seeding sentence generation. For "word salad" generation, a random key from "EOS" could be chosen, then a random key from that key, et cetera. The random-choosing method in use was inspired by the concept of using a role-playing game's outcome table (and dice rolls) to form sentences from piles of poetry tiles. To choose the key, the values are summed, and system generates a random number between 1 and the sum of values. Then, the keys are "stacked", where each word gets a number of stacks equal to its incidence of recurrence, and the system iterates through stack locations until the random number is reached. The word with this final stack location is the selected word, and the process iterates. Further research into the stack order could be performed. 

Previous-word prediction was also a target for experimentation. Similar to Generation, the Pre system starts by indexing the corpus into a hash table. Unlike Generation, the previous word in the corpus is added as a key to a given word's nested hash table, instead of the subsequent word. Generation here would start with a random key of "EOS" being the last word in the sentence. Performing the same "stacking" process as described above allowed moving backwards through sentences, until reaching the preceding "EOS" token to start the sentence. This set of words would be returned in reverse order to compensate for the reverse generation. A random sampling of previous and subsequent Generated sentences led to the determination that output appeared equivalent, but further research could be performed here as well.  

While Generation here wasn't capable of replying logically, it did have the capability of randomly-generating functional PowerShell code. Generally, these functions took the form of one set of parameters, and a non-overlapping set of operational variables and constants, causing these functions to have no output. But some did develop (frequently destructive) capabilities. 

The Satin Sysstem

Satin (SAttn or Short Attention, to indicate a "juvenile implementation") originates with the description of vectorized training being the process where each word is indexed to an n-vector database row, then words trained through the process of vector alignment. In one example, n=768. This system is much too complex for a "juvenile implementation", so the physics technique of Vector Addition was used to summarize these vectors into a single integer. 

Satin begins much like Generation above, by indexing the corpus into a hash table. But the values were incremental instead of being nested and incidence-based. And the "EOS" token added +100 to the increment. This resulted in an "Idea Index", where each word has a location. This makes it possible to lookup and reference that location. 

Training here involves iterating through the corpus, taking the current word and the next, and incrementing their Idea Index locations closer together. Particles and other low-entropy words experience higher amounts of motion in this system than higher-entropy words. 

Satin training wasn't strictly necessary, as the system can be functional without it, able to poorly infer meaning and return inferior results.Some level of training improved results, but training beyond this point (overtraining) led to a numerical convergence. A flaw in the technique of moving Idea Index locations together is that it leads to the eventual convergence of all Idea Indices to the same location, given sufficient training. All ideas appear alike then, and Generation effectively results 

Attentive Generation

Probabilistic Generation is a bane of modern AI, leading to a consistent level of inconsistency in results. The current solution involves a long next-word prediction window. But if this window is longer than average response length, the system might just be performing traditional data storage. The current state of the art leads to sometimes the majority of prompts to require cyclic reprompting. 

Attentive Generation uses the Idea Index distance from the target word to determine next word, taking the word closest to the target. This replaces Generation's random walk, effectively creating a form of heat map navigation through the graph. While the system frequently reaches "EOS" before the target word, if given a large enough response window, the target word very frequently shows up in the results. And if the window is too large, Generation has a habit of looping through the graph's local minima, when viewed from the perspective of the given Idea Index location.

The incidence of recurrence could still be retained and utilized as a future option to improve this method.

Inference from Word Significance

While Attentive Generation can generate informative sentences from a corpus, a full model needs Inference as well. The challenge here is determining which words is significant, after which its Idea Index locaiton can be used to target Attentive Generation. Word Significance here is determined solely by the inverse quantity of connections between words. Multiplied by the corpus size, to prefer data-conservative integers.

At first, only the Weights system was used, giving next-word significance. The Pre system was later invoked, to add previous-word significance. 

Significance is really about entropy. Frequently-used terms, such as particles, should have innumerable connections to words across the corpus, and so have a high number (high entropy) of both next-word suggestions and previous-word suggestions. Likewise, uncommon terms with few connections (low entropy) tend to be main ideas or important concepts. 

"Satin Strain" Significance-Based Training

As mentioned earlier, 
A flaw in the original training technique of moving Idea Index locations together involves the eventual convergence of all Idea Indices to the same location, given sufficient training. What was needed was a way to anchor some words, while allowing others to move freely. Word Significance suggested itself again as an ideal tool.

Satin Strain (SAttn STrain as Simple Attention Simple Train) multiplies the Movement by the inverse of the significance. This anchors in place highly significant words, while promoting the motion of particles and other less-significant words. For example, 

To further expedie training, epoch fast-forwarding was implemented. this techinque multiplies the Movement value by several orders of magnitude. Bulk Satin Straining refers to this with "Strain Movement" terminology. "Strain 100" indicates that 100 is the current Movement value. The value of 100,000 seems ideal for the above-described corups of 64,831 words, as the Satin system gives this corups an Idea Index space of nearly 6.5 million locations. A random assortment of words are chosen for tracking during training. if the Movement value foreach of those words falls below 1% of the Movement value, it becomes demoted by an order of magnitude. This continues until the Movement value is fractional. 

This process is deterministic, causing identical prompts on subsequent experiments to return identical responses. Total training time for this epochal training process was consistently around 20 to 23 minutes for this small corpus. 

Prompt devolution

Prompts are tokenized, then split by spaces. Each word is evaluated for significance, and the most significant half have their Idea Index location used for Attentive Generation targets. Instead of starting at "EOS" as above, here each combination of the prompt tokens are used to seed Generation, and each word in each sentence has its Idea Index location evaluated against each of the significant words in the Prompt. The closest matches are returned.

Response Engineering 

A crucial part of a learning system is the ability to retain and respond with new information. For the Satin system, this means ensuring that the desired answer term not only has an Idea Index location and Pre & post Weights, but also that the preceding words have each of these populated. 

While the above-mentioned corpus of nearly 65k words has an Idea Index of nearly 6.5 million locations, this is just a fraction of the possible Idea Index space. Choosing the Idea Index location allows for both selecting locations far from the corpus, and also the distance between these new ideas. But choosing new locations has the potential to clobber existing knowledge, by moving key words far from their associations. In the example, random values between 1 and 2^30 were used for new ideas. This meant the corpus's 6.5 million locations represent just 0.6037% of the total Idea Index space. 

System Automation

Given a carefully-chosen Engineered Response and some filtering of the prompt response, it's possible to demonstrate rudimentary system administration capabilities purely from natural language input. The term "directory listing" was used with the command "ls" as these have no overlap with the existing corpus, allowing the system to match them, while knowing to disregard supporting natural language terms. 

Prompt response was split by periods, filtered to match the input term and then replace the input term, deduplicated, and trimmed of whitespace before execution. Several prompts were tested, including: "Can you run a directory listing?" "Generate a directory listing." and "Run a directory listing." These all resulted in a valid directory listing. 

Compute Efficiency

A key feature of a "juvenile implementation" is reduced compute needs. The implementation consists of 930 LOC of PowerShell, running on a single core of an Intel i7-8550U laptop CPU running at an unrecorded frequency between 1.80 GHz and 4.0 GHz. This system provides many answers in under a second, with long-running prompts taking at most 30 seconds. As mentioned above, training on the given corpus consistently takes under 30 minutes. The corpus consists of approximately 346 KB of data. The weight set, consists of approximately 23.9 MB of uncompressed XML, and compresses to 1.12 MB. This level of compute efficiency implies that the system could function on an incredible array of devices, including the majority of embedded and portable devices. Given the proliferation of this level of proessor, the technology here described could inform innumerable robots, smart devices, and even greeting cards in the future. 
