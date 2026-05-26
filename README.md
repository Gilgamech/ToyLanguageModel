# Toy Language Model.

A tiny autosuggest system. Eventually meant to be similar to an AI LLM. 

## Instructions:
1. Import text files for training: 
```
$book = gc "C:\Files\OffgridOffice.md"
$isms = gc "C:\Files\Gillogisms.md"
$chill = gc "C:\Files\ChillSMP.txt"
```

2. Train weights:
````
$Weights = Get-Weights -Mode Third -clip $book
```
- If the MD file is well-structured into sentences, then it can be parsed directly. If it's free-form notes with one per line, -join " EOL " to help out the parser. (EOL ends the sentence, then gets replaced with a dot (`.`))
- This step might take several minutes, as Third Mode has to make 3 runs through the corpus, mostly to build the Merkel tree. 
```
$Weights = Get-Weights -Mode Third -clip (($chill -join " EOL ") + ($isms -join " EOL ") + $book)
```

3. Run: 
```
Get-ThirdSentence -Weights $Weights
```
Or loop for multiple sentences:
```
1..25 |%{Get-ThirdSentence -Weights $Weights}
```

4. Try out "code mode":
```
$WeightMode = "Code"
$codefile = gc "C:\Files\PSFile.ps1"
$Weights = Get-Weights -Mode Third -clip $codefile
1..25 |%{Get-ThirdSentence -Weights $Weights}
```
(Only tested with PS1 files.)

5. How it works:
- Get-Weights tokenizes input with Get-Tokenizer before building a Merkle table ($Weights) for the word list. 
  - "Both" mode uses 1-dimensional look-ahead, while "Third" mode uses 2-dimensional look-ahead. More accurate prediction but weight iteration (aka "training") takes longer.
- Get-PredictWord takes one or two words as input, plus the Merkle table, and returns the next word in the table by random selection. 
  - It works basically by choosing words from a D&D dice table. 0-1 = "this", 2-4 = "that", 5-6 = "time" on a D6. 
- Get-Sentence and Get-ThirdSentence set up and iterate Get-PredictWord until the "EOL" word is found. 
  - Sentence gets detokenized. 
  - EOL gets replaced with a dot, and the first letter of the sentence captialized. 

6. Check out the first iteration:
````
$Weights = Get-Weights -Mode Both -clip $book
1..25 |%{Get-Sentence -Weights $Weights}
````

Get-Weights has 2 main modes, assembled from 4 total modes:
- Init - Creates the first layer of Merkle tree. Used by "Both" and "Third".
- Write - Writes values to the first layer of Merke tree. Used by "Both".
- ThirdI - (Third Init) Creates the second layer of Merkle tree. Used by "Third".
- ThirdW - (Third Writ) Writes values to the second layer of Merke tree. Used by "Third".
