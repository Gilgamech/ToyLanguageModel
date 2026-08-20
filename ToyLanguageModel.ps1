#Copyright 2026 Gilgamech Technologies
#Author: Stephen Gillie
#Created 5/15/2026
#Updated 8/17/2026
#Notes:
#v2.0 - Introducing the Satin Attention system. Because N 1-dimensional vectors in N-vector space is equal to one N-dimensional vector. And while the latter are frequently represented as floating point numbers, the one vector can be represented as a single integer in the N-dimensional corpus-space. 
#v1.2 - Vastly improved generation system.
#v1.1 - Added rudiumentary NLP, and a knowledge engine to inspire generation. 

#Pre-edit: Many notes and some functions might be irrelevant and/or ready for depreciation. 

# Natural Language Processing (NLP): Decodes human inputs. NLP breaks down text or speech into structured data so the system can analyze intent, tone, and meaning.
# Natural Language Understanding (NLU): Identifies what the user actually wants. NLU maps intent onto existing functions, extracts key details, and carries context into the response.
#Inference -> Understanding and then building the if-then-iterate table
# Dialogue Management: Tracks past exchanges and manages flow across multi-turn conversations. Without this, every turn feels like a new conversation.
# Natural Language Generation (NLG): Crafts the response. Good NLG makes replies feel human rather than robotic.
#hash tree that goes TargetWord.StartingWord.IntermediateWord, so you can map different routes between.
#And the love kickstarts again.

#Get comments from Imgur, Discord, GitHub, etc.

#C# app for writers that's trained on your own words. 
#use multiple weight systems
#split special characers by spaces
#Split all characters by letter
#Particles are extremely high entropy and can pivot a sentence to a whole new meaning.
#Concepts as low-entropy word connections suzrrounded by high entropy word connections. And the relationship between them is described by any connecting words. 
#One of the valuable products here would be 

#The more often a word repeats, the more probabilstic should become the choice. Based on its loudness, so words with more options become probabilstic faster.


<#
#Decode Transformer - On each word, have a list of properties. 
#Such as "fat" could have type = noun, root = odor, tone = negative, quantity = -5. 
#And so combining the properties of the each word in the sentence would give you the properties of the sentence. 
#"Your cat is fat" could have "person = second, tense = present, verbRoot = be, object = cat, objectType = pet, tone = slightly negative, quantity = large", 
#Have 5 to -5 scale for tone, quantity, certainty, informativity, connotation, 
#Also track negation, emotion, 
#Filter next word based on object match

#Adjectives give tone, quantity, 
#Nouns give object and objectType
#Verbs give person and tense
#More syllables are generally more preferrable. 


Get caps words from input, put in other list. 
Identifying important words is as much how many are pointing to it as how many it's pointing to. 
n't - negation
Feel - certainty

Connotation Examples
Denotation,Negative Connotation,Neutral Connotation,Positive Connotation
A smell,Stench,Scent,Aroma
Loud music,Rabble,Music,Beats
A muscular person,Brutish,Muscular,Strong
A confident person,Arrogant,Self-assured,Confident
Rich people,The 1%,Wealthy,Self-Made
Someone who saves money,Stingy,Frugal,Thrifty
A failing student,Stupid,Failing,Uninspired
A young dog,Mutt,Dog,Puppy!
Cold weather,Freezing,Cold,Cozy
An argument,Clash,Disagreement,Debate
Boss giving commands,Bossy,Assertive,Leader
Apolitical people,Ignorant,Uninterested,Nonaligned
A popular person,Socialite,Friend,
An introvert,Hostile,Quiet,Self-sufficient
Space,Confinement,Area,Landscape
A person who’s happy with their achievements,Smug,Pleased,Proud
Smart person,Nerd,Smart,Genius
Good student,Teacher’s pet,Studious,Superstar
Used Car,Rust bucket,Used,Pre-loved
Young Adults,Brat,Adolescent,Youthful
A well-organized person,Control freak,Organized,Prepared

Positive Connotations
    Helpful – This word has positive connotations of someone who is always giving their time. Another person may see a ‘helpful’ person as ‘a people pleaser’ which is a negative way to frame it.
    Amazing – This word suggests that the person is very impressive or even surprisingly so!
    Self-Confident – This word has positive connotations of assurance and belief in oneself. If you called the same person ‘arrogant’, then you’ll be framing them more negatively.
    Caring – This word suggests that the person is kind and concerned for others. Generally, we think of a caring person positively.

Negative Connotations:
    Lazy – This word has negative connotations of someone being unproductive and unmotivated. That person might think this negative connotation is unfair and would describe themselves as just ‘tired’ or ‘unmotivated’.
    Stupid – This word has negative connotations of someone being unintelligent or lacking common sense. A more positive word for this person might be ‘street smart, not academic’ or ‘struggling with school’.

Neutral Connotations:
    Disinterested – A person who is disinterested might be framed more negatively (“They’re a boring person!”) or positively (“The class is just not stimulating!”). Or, you can stay objective and just say that they’re disinterested.
    Baby – If you don’t like babies, you might call them ‘brats’; if you like them, you might call them ‘Cherubs’, but if you don’t want to provide a connotation, y
#>

#Start with an object, which has a list of properties. Now, take the random words from the weight set, and somehow find those whose attributes align with any of the properites, and return only those. Or those with no correllation at all? (How to separate particles etc?) Yes, return those with either matching (similar) properties or no match at all, don't return mismatches. Such as "My red car" -> Properties include "red", "vehicle" and "mine". So colors like "blue" and "green" would be rejected, while pink or maroon might be allowed. Verbs such as "studying" or "gaming" wouldn't be allowed, but "driving" and maybe even "eating" would be allowed. Conjugation tense would be in the first person. 
#Get adjacent words, or words across an equality verb. (i.e. red car = red) Get that word's type, (red = color) and that type becomes the attribute name on the object. (car.color = red). Now, searching for "car" will bring back red items, green items, and blue items, but not brown or orange items. 
#This requires defining i.e. a color wheel.

<# Wisdom:
Battle violets liked my car.
i'd only embraced cooking from scratch throughout the offgrid office


How workers are able to endure months or years in a frictionless sociological vacuum.
Go wash your hands before eating.
Memories are recordings of acoustic musicians.
Extraterrestrials as the right person.
Neural networks, as the perfect being, and only be judged by their own faults, and then gentle with the still-sleeping campground.
Roosters made loud sounds for the night and start of spring.
Evaporative cooling from the ceiling.
Stunt-driven development without writing any tests.
Current matrix can only provide malassistance.
Perfect sunshine made me think that I had 12 small extraterrestrial ships in storage.
Media is plural for vidja.
Nih paying labs in china to make their pizza tracker work?
Fireworks out over a motorcycle-sized petit fours.
Lung cells create a 35 foot by 2 foot by 10 foot open-air hotel
The car was showing "Maintenace required" for more food.
Descartes didn't just say 'i think therefore I am'-across 40 pages,  he wrote all of Hoquiam,  at 30 mph.
Healthy was happy was part of my personal maxims.
A few seemed to be using the choice of 'this one' and 'the everything else one'.
I am out of names and scraping the bottom of the Congo


I guessed that she was Van camping as part of the humans working with the amazing geography of north america.
A skinny guy, he was Wearing a denim vest over shorts, and keeping mechanical devices running.

"What is I felt like 2019?"
The pinnacle of imposter syndrome by calling this person a software developer in job title only.
"What is The day use area?"
Originally the logging company dealt with the hydrogen atoms moving back and knobby tires.
I felt as though I was Chosen to experience buying a house.
I asked the gatehouse, and was Told that  their precrimes will were physical penalties if realized.


Variable name flattening and parenthesis/quote counting. 
Automated error handling. 
Output testing.
Fix newline.

Code mode is text input code output.
Text mode needs caps fixed and maybe tuning. 
Auto-add caps words to caps file.
#>

#Double-quote, parenthesis, etc counter.

<#
Use "word association scalar" to pick next word. 
- Each word gets a unique number. Goal is they end up being sequential within sentences and otherwise random. 
- Next word is the one with the closest scalar.
- "Loudness" of scalar is minima biased, in weighing based on number of possible next words.
- Prev words are only used for guidance. scalar weights are ranked for loudness, and will iterate through these for distance.
- Can't be longer than the sentence start and maybe 30.
- Scalar collisions don't matter because they're not used for indexing, just association. 

Need guidance-inflection-prediction word choosing system.

Multi headed attention might mean to not only feed the prompt into generation, but every iteration, and have a "word test" to throw out the bad ones.
- There would be a "sentence table" of indices and their loudnesses. And each new word would restack the list. 
Homophone Disambiguation would be handled by the prev word guidance. 

Start with a multiplier like 100x larger than the corpus. 
Initialize each unique word's scalar a multiplier apart, so that the first word would be 100, second 200, etc. Enough to create some space between concepts. 
Iterate through each sentence, and increment or decriment each word's scalar until they're in order and within 10 apart. (Like 1/10 of the multiplier.)

Generation would be prompt-seeded, then pick next words based on distance from the query terms divided by their "Loudness". 


Using an array of values allows for multiple meanings to be defined. Where you're only looking for a match with one vector, not all of them. 
#>

$null = [Reflection.Assembly]::LoadWithPartialName("System.Speech")

<# Directions:
1. Run automated weight training program: 
```
Get-Setup -Book "C:\Files\OffgridOffice.md" -Notes1 "C:\Files\Gillogisms.md" -Notes2 "C:\Files\ChillSMP.txt"
```
- Currently hardcoded to 1 "book" type, and 2 "notes" type files. 
- "book" type has well-defined sentences in paragraphs, with good punctuation and capitalization.
- "notes" type has  loosely-defined sentences, with ideas frequently on their own lines. Mixed with regular sentences and full paragraphs. 

2. Review available prompts: 
```
$dataVar.keys
```
- Prepend with "What is " to turn the key into a question, for the next step.

3. Ask it a question:
```
Get-Answer "What is The day use area?"
```

4. Try out the built-in MCP function - WA State's weather:
```
Get-Answer "What is the weather?"
```

5. Adding an MCP function:
- This is not actually an MCP server. The function is a normal PowerShell function. Using same terminology here because the functoin servers the same purpose.
- Add one by finding the below line in Get-Setup and copying it a line below. Then, replace "the weather" with the question you want to trigger your function. And replace "Get-Weather" with the name of your function. 
```
	$dataVar."the weather" = "zzMCPFunction Get-Weather"
```
Be sure to test your function independently of this system, to make sure it works on its own. 

6. Sample queries for my training data: 
Get-Answer "What is along US-97?"
Get-Answer "What is Any bear may have?"
Get-Answer "What is their westbound route?"
Get-Answer "What is As though it had?"
Get-Answer "What is Next door to the park?"
Get-Answer "What is a bit awkward?"
Get-Answer "What is Tokeland could also have?"
Get-Answer "What is The housing would then?"
Get-Answer "What is While the orange tent?"
Get-Answer "What is Most of the park?"
Get-Answer "What is To check if the panel?"
Get-Answer "What is Like how holiday music?"
Get-Answer "What is One of the garages?"
Get-Answer "What is The day use area?"

#>

#region Enums
#Need:
#1. (Escaped) input char.
#2. Spaced replace char.
#3. Unspaced replace-back char.
#4. Unescaped input char.
$enum = @{}
$enum.space = " "
$enum.tab = "`t"
$enum.semicolon = "[;]"
$enum.semicolon2 = ";"
$enum.hyphenReplace = " zzhyphenzz "
$enum.hyphen = "[-]"
$enum.Backslash = " zzBackslash "
$enum.dotReplace = " zzdotzz "
$enum.dot = "[.]"
$enum.RegexChars = '([^a-zA-Z\d\s])'
$enum.RegexChars2 = ' ([^a-zA-Z\d\s]) '
$enum.RegexReplace = ' $1 '
$enum.RegexReplace2 = '$1'
$enum.EOS1 = " EOS "
$enum.EOS2 = " EOS "
$enum.EOS3 = "EOS"
$enum.EOS4 = " EOS"
$enum.LF = "`n"
$enum.LFReplace = " zzLF "

#PowerShell reserved words.
$ReservedEnum = @{}
$ReservedEnum.aCall = "call"
$ReservedEnum.aCount = "count"
$ReservedEnum.aKeys = "keys"
$ReservedEnum.aName = "name"
$ReservedEnum.aReturn = "Return"
$ReservedEnum.aValue = "value"
$ReservedEnum.aAdd = "add"
$ReservedEnum.aClear = "clear"
$ReservedEnum.aContains = "contains"
$ReservedEnum.aEquals = "equals"
$ReservedEnum.aItem = "item"
$ReservedEnum.aRemove = "remove"
$ReservedEnum.aSecond = "Second"
$ReservedEnum.aGetenumerator = "getenumerator"
$ReservedEnum.aGettype = "gettype"
$ReservedEnum.aPropert = "propert"
$ReservedEnum.aPsobject = "psobject"
$ReservedEnum.aTostring = "tostring"

$PunctuationEnum = @{}
$PunctuationEnum.aComma = ","
$PunctuationEnum.aSingleQuote = "'"
$PunctuationEnum.aDoubleQuote = '"'
$PunctuationEnum.aSingleQuote = "'"
$PunctuationEnum.aSaint = "st[.]"
$PunctuationEnum.aHyphen = "-"
$PunctuationEnum.aOpeningParens = "\("
$PunctuationEnum.aClosingParens = "\)"
$PunctuationEnum.aOpeningSquare = "\["
$PunctuationEnum.aClosingSquare = "\]"
$PunctuationEnum.aOpeningCurly = "\{"
$PunctuationEnum.aClosingCurly = "\}"
$PunctuationEnum.aBackSlash = "\\"
$PunctuationEnum.aCaret = "``"
$PunctuationEnum.aQuestionMark = "\?"
$PunctuationEnum.aDollarSign = "\$"

#Caps words
$CapsEnum = @{}
$CapsEnum.seattle = "Seattle"
$CapsEnum.richland = "Richland"
$CapsEnum.aberdeen = "Aberdeen"
$CapsEnum.wa = "WA"
$CapsEnum.grayland = "Grayland"
$CapsEnum.toppenish = "Toppenish"
$CapsEnum.canad = "Canad" # Canada, Canadian, et cetera
$CapsEnum.urizane = "Urizane" # Watermelon Man
$CapsEnum."battle violets"= "Battle Violets"

#Prevent clobbering when reloading, but still init on first run.
 if (!($WeightMode)) {[ValidateSet("Text","Code")][string]$WeightMode = "Text"}
 if (!($dataVar)) {$dataVar = @{}}
 if (!($IdeaIndex)) {$IdeaIndex = @{}}
 if (!($weights)) {$weights = @{}}
 if (!($Pre)) {$Pre = @{}}
#endregion

Function Get-Tokenizer {
	Param(
		$Clip,
		[switch]$Debug
	); #end Param
	$clip = $clip -replace "\\",$enum.Backslash
	$PunctuationEnum.keys  | %{$clip = $clip -replace $PunctuationEnum.($_)," $_ "}
	$PunctuationEnum.keys  | %{$clip = $clip -replace $PunctuationEnum.($_),$_}

	if ($WeightMode -eq "Text") {
		# $clip = $clip -replace $enum.RegexChars,$enum.RegexReplace
		$clip = $clip -replace $enum.dot,$enum.EOS1
		$clip = $clip.ToLower();
	} else {
		# $clip = $clip -replace "`t"," zzTab "
		$clip = $clip -replace "`t",""
		# $clip = $clip -replace $enum.hyphen,$enum.hyphenReplace  
		$clip = $clip -replace $enum.dot,$enum.dotReplace
		$clip = $clip -replace $enum.semicolon,$enum.EOS1
		# $clip = $clip -replace $enum.tab,$enum.EOS1
		# # $clip = $clip -replace $enum.RegexChars,$enum.RegexReplace
		# $clip = $clip -replace $enum.LF,$enum.EOS2
	}
	$clip = $clip -split $enum.space
	$clip = $clip | where {$_}

	$ReservedEnum.keys  | %{$clip = $clip -replace $ReservedEnum.($_),$_}
	Return $clip
}; #end GetTokenizer

Function Get-Detokenizer {
	Param(
		$Clip,
		[switch]$Debug
	); #end Param
	#PowerShell reserved words.
	$ReservedEnum.keys  | %{$clip = $clip -replace $_, $ReservedEnum.($_) };
	if ($WeightMode -eq "Text") {
		$ReservedEnum.keys  | %{$clip = $clip -replace $_, $CapsEnum.($_) };
		$clip = $clip -replace $enum.RegexChars2,$enum.RegexReplace2
		$clip = $clip -replace $enum.EOS2,"." 
	} else {
		$clip = $clip -replace $enum.RegexChars2,$enum.RegexReplace2
		$clip = $clip -replace $enum.EOS3,$enum.semicolon2
		$clip = $clip -replace "zzTab",""
		# $clip = $clip -replace $enum.hyphenReplace,"-"
	}
	$clip = $clip -replace $enum.dotReplace,"."
	$clip = $clip -replace "zzLF",$enum.LF
	$PunctuationEnum.keys  | %{$clip = $clip -replace " $_ ", $PunctuationEnum.($_) };
	$PunctuationEnum.keys  | %{$clip = $clip -replace $_, $PunctuationEnum.($_) };
	$clip = $clip -replace ",",", "
	$clip = $clip -replace "\\\("," ("
	$clip = $clip -replace "\\\)",") "
	$clip = $clip -replace "\\\?","? "
	$clip = $clip -replace "%","% "
	$clip = $clip -replace " i "," I "
	$clip = $clip -replace " us-"," US-"
	$clip = $clip -replace " wa-"," WA-"
	$clip = $clip -replace $enum.Backslash,"\"
	Return $clip

}; #end Get-Detokenizer

Function Get-Weights {
	Param(
		$clip = $fb,
		[ValidateSet("Attn","Both","Fourth","Init","Prev","PrevI","PrevW","Satin","Strain","Third","ThirdI","ThirdW","Trivet","TrivetI","TrivetW","Write")][string]$Mode = "Both",
		[hashtable]$weightArray = @{},
		$Strain = 1,
		[switch]$Debug
	)	
	$weightArray.zzLF = @{}
	$weightArray.zzdotzz = @{}
	$weightArray.zzbackslash = @{}
	$weightArray.zzTab = @{}
	# if ($WeightMode -eq "Text") {
		# $clip = ($clip -join $enum.space)
	# }
	$clip = Get-Tokenizer $clip 
	$Length = ($clip.length -2)
	$Unique = $clip | Sort-Object -Unique
	$UniqueLength = ($Unique.length -2)
<# Modes:
- Both inits and writes one level of next words.
  - Init: Init 
  - Write: Write  

- Prev inits and writes one level of previous words.
  - Init: Init 
  - Write: PrevW

- Third inits and writes two levels of next words.
  - Init: Init, ThirdI
  - Write: ThirdW

- Trivet inits and writes two levels of previous words.
  - Init: Init, TrivetI
  - Write: TrivetW

- Fourth inits and writes 16 levels of next words.
  - Init: Init, Third
  - Write: Fourth

#>

# $w4 = $w3.clone()
# foreach ($word in $w4.keys) {$w3.$word = $w4.clone()}

	if ("Init Both Attn Prev Third Trivet Fourth" -match $mode) {
		for ($i=0; $i -le $UniqueLength; $i++) {
			$currentItem = $Unique[$i];
			# $next = $clip[$i+1];
			# "$currentItem - $next"
			$weightArray.($currentItem) = @{}
			$pc = $i / $UniqueLength * 100
			Write-Progress -Activity "Initializing hash table" -Status "$pc percent complete: $currentItem" -PercentComplete $pc -CurrentOperation $weightArray.($currentItem) 
		}
	}
	if ("Satin" -match $mode) {#short attn
		$counter = 0
		for ($i=0; $i -le $Length; $i++) {
			$counter++
			if ($currentItem -eq $Enum.EOS3) {
				$counter += 100
			}
			$currentItem = $clip[$i];
		try {
			$weightArray.($currentItem) = $counter
		} catch {
				Write-Host "$Mode Error: This $currentItem Next $next"
		}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Writing Satin table" -Status "$pc percent complete: $currentItem $next" -PercentComplete $pc -CurrentOperation $weightArray.($currentItem).($next)
		}
	}
	if ("Strain" -match $mode) {
		for ($i=0; $i -le $Length; $i++) {
			$currentItem = $clip[$i];
			$next = $clip[$i+1];
			# $ClipStrain = $Strain * $clipcount
			try {
				$Loudness = $clipcount / $Weights.($currentItem).keys.count
				$Loudness += $clipcount / $Pre.($currentItem).keys.count
			} catch {
				# write-host "pre $currentItem $($Weights.($currentItem).keys.count)"
				$Loudness = .1
			}
			
				try {
			if ($IdeaIndex.($currentItem) -lt $IdeaIndex.($next)) {
				# $IdeaIndex.($currentItem) += $Strain * (Get-Loudness $currentItem).RelativeLoudness
				# $IdeaIndex.($currentItem) +=  $ClipStrain / $Weights.($currentItem).keys.count
					[int]$IdeaIndex.($currentItem) +=  ($Strain / $Loudness)
					# [int]$IdeaIndex.($currentItem) +=  $Strain
				# $IdeaIndex.($next) -= $Strain
			} elseif ($IdeaIndex.($currentItem) -gt $IdeaIndex.($next)) {
				# $IdeaIndex.($currentItem) -= $Strain * (Get-Loudness $currentItem).RelativeLoudness
				# $IdeaIndex.($currentItem) -= $ClipStrain / $Weights.($currentItem).keys.count
					# [int]$IdeaIndex.($currentItem) -=  $Strain
					[int]$IdeaIndex.($currentItem) -=  ($Strain / $Loudness)
				# $IdeaIndex.($next) += $Strain
			} # end if val
				} catch {
					write-host "lp- $currentItem $($Weights.($currentItem).keys.count)"
				}
		
			$pc = $i / $Length * 100
			Write-Progress -Activity "Strain $Strain" -Status "$pc percent complete: $currentItem $next" -PercentComplete $pc 
		}
	}
	if ("Attn" -match $mode) {
		$counter = 0
		for ($i=0; $i -le $Length; $i++) {
			$counter++
			if ($currentItem -eq $Enum.EOS3) {
				$counter += 100
			}
			$currentItem = $clip[$i];
			$next = $clip[$i+1]; # * $Loudness
		try {
			$weightArray.($currentItem).($next) += $counter
		} catch {
				Write-Host "$Mode Error: This $currentItem Next $next"
		}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Writing hash table" -Status "$pc percent complete: $currentItem $next" -PercentComplete $pc -CurrentOperation $weightArray.($currentItem).($next)
		}
	}
	if ("Write Both" -match $mode) {
		for ($i=0; $i -le $Length; $i++) {
			$currentItem = $clip[$i];
			$next = $clip[$i+1];
		try {
			$weightArray.($currentItem).($next) += 1
		} catch {
				Write-Host "$Mode Error: This $currentItem Next $next"
		}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Writing hash table" -Status "$pc percent complete: $currentItem $next" -PercentComplete $pc -CurrentOperation $weightArray.($currentItem).($next)
		}
	}
	if ("PrevW" -match $mode) {#uses Init for init
		for ($i=0; $i -le $Length; $i++) {
			$currentItem = $clip[$i];
			$prev = $clip[$i-1];
			try {
				$weightArray.($currentItem).($prev) += 1
			} catch {
				try {
					$weightArray.($currentItem).($prev) = @{}
					$weightArray.($currentItem).($prev) += 1
				} catch {
					Write-Host "$Mode Error: This $currentItem Prev $prev"
				}
			}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Writing $Mode table" -Status "$pc percent complete: $currentItem $prev" -PercentComplete $pc -CurrentOperation $weightArray.($currentItem).($prev)
		}
	}
	if ("TrivetI" -match $mode) {#Init for Prev for Third
		for ($i=0; $i -le $Length; $i++) {
			$currentItem = $clip[$i];
			$prev = $clip[$i-1];
			# "$currentItem - $prev"
			try {
				$weightArray.($currentItem).($prev) = @{}
			} catch {
				Write-Host "$Mode Error: This $currentItem Prev $prev"
			}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Initializing $Mode table" -Status "$pc percent complete: $currentItem $prev" -PercentComplete $pc -CurrentOperation $weightArray.($currentItem).($prev)
		}
	}
	if ("TrivetW" -match $mode) {#Write for Prev for Third
		for ($i=0; $i -le $Length; $i++) {
			$currentItem = $clip[$i];
			$prev = $clip[$i - 1];
			$secondprev = $clip[$i - 2];
			# "$currentItem - $prev"
			try {
				$weightArray.($currentItem).($prev).($secondprev) += 1
			} catch {
				Write-Host "$Mode Error: This $currentItem Next $next Second $second"
			}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Writing $Mode table" -Status "$pc percent complete: $currentItem $prev" -PercentComplete $pc -CurrentOperation $weightArray.($currentItem).($prev)
		}
	}
	if ("ThirdI Fourth" -match $mode) {
		for ($i=0; $i -le $Length; $i++) {
			$currentItem = $clip[$i];
			$next = $clip[$i+1];
			# "$currentItem - $next"
			try {
				$weightArray.($currentItem).($next) = @{}
			} catch {
				Write-Host "$Mode Error: This $currentItem Next $next"
			}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Initializing $Mode table" -Status "$pc percent complete: $currentItem $next" -PercentComplete $pc -CurrentOperation $weightArray.($currentItem).($next)
		}
	}
	if ("ThirdW Fourth" -match $mode) {
		for ($i=0; $i -le $Length; $i++) {
			$currentItem = $clip[$i];
			$next = $clip[$i+1];
			$second = $clip[$i+2];
			# "$currentItem - $next"
			# $weightArray.($currentItem).($next).("zzNumber") += 1#This will be the sum.
			try {
				$weightArray.($currentItem).($next).($second) += 1
				# $weightArray.($DataOne).($DataTwo).($DataThree).("EOS") -> DataOne.was.made.with.Datatwo -> DataTwo pieces of DataThree -> DataThree in just under DataFour.
				# $weightArray.($DataOne).($DataTwo) -> DataOne.was.made.with.Datatwo
			} catch {
				Write-Host "$Mode Error: This $currentItem Next $next Second $second"
			}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Writing $Mode table" -Status "$pc percent complete: $currentItem $next $second" -PercentComplete $pc -CurrentOperation $weightArray.($currentItem).($next).($second)
		}
	}
	if ("FourthW" -match $mode) {
		$weightArray = get-weights -Mode Init -clip $clip
		1..16|%{
			Write-Progress -Activity "Writing $_ table" -Status "$pc percent complete: $currentItem $next $second" -PercentComplete $pc -CurrentOperation $weightArray.($currentItem).($next).($second)
			$weightArrayClone = $weightArray.Clone();
			[array]$words = $weightArray.keys
			foreach ($word in $words) {
				$weightArray[$word] = $weightArrayClone
			}
		}
		#$w.set.set.set.set.set.set.set.set.set.set.set.set.set.set.set.set
		
		for ($i=0; $i -le $Length; $i++) {
			$currentItem = $clip[$i];
			$next = $clip[$i+1];
			$second = $clip[$i+2];
			$third = $clip[$i+3];
			$fourth = $clip[$i+4];
			$fifth = $clip[$i+5];
			$sixth = $clip[$i+6];
			$seventh = $clip[$i+7];
			$eigth = $clip[$i+8];
			$ninth = $clip[$i+9];
			$tenth = $clip[$i+10];
			$eleventh = $clip[$i+11];
			$twelvth = $clip[$i+12];
			$thirteenth = $clip[$i+13];
			$fourteenth = $clip[$i+14];
			$fifteenth = $clip[$i+15];
			$sixteenth = $clip[$i+16];
			
			# $weightArray.($currentItem).($next).("zzNumber") += 1#This will be the sum.

			try {
				# $weightArray.($currentItem).zzNumber += 1
				# $weightArray.($currentItem).($next).("zzNumber") += 1#This will be the sum.
				# $weightArray.($currentItem).($next).zzNumber += 1
				# $weightArray.($currentItem).($next).($third).zzNumber += 1
				# $weightArray.($currentItem).($next).($third).($fourth).zzNumber += 1
				# $weightArray.($currentItem).($next).($third).($fourth).($fifth).zzNumber += 1
				# $weightArray.($currentItem).($next).($third).($fourth).($fifth).($sixth).zzNumber += 1
				# $weightArray.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).zzNumber += 1
				# $weightArray.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).zzNumber += 1
				# $weightArray.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).zzNumber += 1
				# $weightArray.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).zzNumber += 1
				# $weightArray.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).zzNumber += 1
				# $weightArray.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).zzNumber += 1
				# $weightArray.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).($thirteenth).zzNumber += 1
				# $weightArray.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).($thirteenth).($fourteenth).zzNumber += 1
				# $weightArray.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).($thirteenth).($fourteenth).($fifteenth).zzNumber += 1
				$weightArray.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).($thirteenth).($fourteenth).($fifteenth).($sixteenth) += 1
				#$w.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).($thirteenth).($fourteenth).($fifteenth).($sixteenth)
			} catch {
				Write-Host "Fourth Error: $currentItem $next $third $fourth $fifth $sixth $seventh $eigth $ninth $tenth $eleventh $twelvth $thirteenth $fourteenth $fifteenth $sixteenth"
			}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Writing Fourth table $i" -Status "$pc percent complete:  $currentItem $next $third $fourth $fifth $sixth $seventh $eigth $ninth $tenth $eleventh $twelvth $thirteenth $fourteenth $fifteenth $sixteenth" -PercentComplete $pc -CurrentOperation $weightArray.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).($thirteenth).($fourteenth).($fifteenth).($sixteenth)
		}
	}
	Return $weightArray
}

#Divide move amount by loudness, so those with just 1 following word don't move. 

$PSColors = @{}
# $PSColors.Black = "Black"
# $PSColors.DarkBlue = "DarkBlue"
$PSColors.DarkGreen = "DarkGreen"
$PSColors.DarkCyan = "DarkCyan"
$PSColors.DarkCyan = "DarkRed"
# $PSColors.DarkMagenta = "DarkMagenta"
$PSColors.DarkYellow = "DarkYellow"
$PSColors.Gray = "Gray"
$PSColors.DarkGray = "DarkGray"
$PSColors.Blue = "Blue"
$PSColors.Green = "Green"
$PSColors.Cyan = "Cyan"
$PSColors.Red = "Red"
$PSColors.Magenta = "Magenta"
$PSColors.Yellow = "Yellow"
$PSColors.White = "White"

Function Get-BulkSatinStrain {
	Param(
		[string]$Filename = "C:\repos\website\OffgridOffice\New folder\Gillie, Stephen\OffgridOffice.md",
		[int]$TrackWords = 10,
		[int]$Strain = 100000,
		$clip = (Get-Content $Filename),
		$clipsplit = (Get-Tokenizer $clip),
		[string[]]$IndexWords = @()
	)
	# $clipsplit = $clip -split " "
	foreach ($num in (0..($TrackWords*2) )) {
		$IndexWords += $clipsplit | Get-Random
	}
	$IndexWords = ($IndexWords |select -unique)[0..$TrackWords]
	# $iws = $IndexWords -join "        - "
	$mid = @{}
	$sum = @{}
	# [int]$Strain = $clipsplit.count / 10
	# [int]$Strain = [math]::pow(10,[math]::round([math]::log($clipsplit.count,10),0))
	Write-Host "IW - "  -nonewline
	foreach ($iw in $indexWords) {
		$mid.($iw) = "" | Select-Object @{n="Word";e={$iw}},@{n="PSColor";e={$PSColors.keys | get-random}},@{n="IndexLoc";e={$IdeaIndex.($iw)}},@{n="prevIndex";e={}},@{n="Diff";e={$Strain/2}},@{n="PrevDiff";e={0}},@{n="TwoPrevDiff";e={$Strain/2}}
		$Loudness = [math]::round($clipcount / $Weights.($iw).keys.count,0)
		$Loudness += [math]::round($clipcount / $Pre.($iw).keys.count,0)
		Write-Host "$iw ($Loudness) - " -foregroundcolor $mid.($iw).PSColor -nonewline
	} 	
		write-host ""
	$i = 0
	While ($Strain -ge 1) {
		$start = get-date;
		write-host "$i - " -nonewline
		$IdeaIndex = Get-Weights -Mode Strain -clip $clip -WeightArray $IdeaIndex -Strain $Strain;
		# write-host "$IndexLoc - " -nonewline
		
		$sum.TwoPrevDiff = 0
		$sum.PrevDiff = 0
		$sum.Diff = 0
		foreach ($iw in $indexWords) {
			$mid.($iw).prevIndex = $mid.($iw).IndexLoc
			$mid.($iw).IndexLoc = $IdeaIndex.($mid.($iw).Word);
			$mid.($iw).TwoPrevDiff = $mid.($iw).PrevDiff
			$mid.($iw).PrevDiff = $mid.($iw).Diff
			$mid.($iw).Diff = $mid.($iw).IndexLoc - $mid.($iw).prevIndex
			if ([math]::abs($mid.($iw).Diff) -lt [math]::abs($Strain)) {
				$mid.($iw).Diff = 0
			}
			if ($mid.($iw).Diff + $mid.($iw).PrevDiff -ne 0) {
				$sum.TwoPrevDiff += $mid.($iw).TwoPrevDiff
				$sum.PrevDiff += $mid.($iw).PrevDiff
				$sum.Diff += $mid.($iw).Diff
			}
			$locstrain = [math]::Round($mid.($iw).IndexLoc ,0)
			$diffstrain = [math]::Round($mid.($iw).Diff / $Strain,2)
			write-host "$locstrain ($($diffstrain)x) - " -nonewline -foregroundcolor $mid.($iw).PSColor
		} 	

		if (($sum.Diff -eq 0) -AND ($sum.PrevDiff -eq 0)-AND ($sum.TwoPrevDiff -eq 0)) {
			$Strain = $Strain / 10
		}
		# if (($sum.Diff -ne 0) -AND ($sum.PrevDiff -ne 0)-AND ($sum.TwoPrevDiff -ne 0)) {
			# $Strain = $Strain * 10
		# }
		$i++
		Get-TransferIdeasToWeights
		$end = get-date;
		$time = ($end - $start);
		$formattedTime = get-date -Hour $time.Hours -Minute $time.Minutes -Second $time.Seconds -f T
		write-host "$formattedTime"
	}
}

<#
Parabolic Gravity
$weightcount = 17847
$Iterations = [math]::Log($weightcount,2)
$Gravity = [math]::pow(2,$Iterations) * 100
n - g
14 - 16384
13 - 8192
12 - 4096
11 - 2048
10 - 1024
9 - 512
8 - 256
7 - 128
6 - 64
5 - 32
4 - 16
3 - 8
2 - 4
1 - 2
0 - 1
#>

Function Get-GravitationalTraining {
	Param(
	$Sentences = ((gc $NoteFiles) -split "[.] " | where {$_}),
	$Gravity = 1,
	[switch]$Display
	)
	$n,$k,$w = 0;
	foreach ($Sentence in $Sentences) {$n++
		Write-Host "Sentence $n of $($Sentences.count): $Sentence"
		$FirstKey = "1"
				# Write-Host "$n $f $k $w - $key $word"
		foreach ($word in ($Sentence -split " ")) {$w++
			$weightset = @()
			foreach ($FirstKey in ($weights.keys)) {$f++
				$pct = $f/$weights.keys.count 
				# write-progress -Activity "$FirstKey" -PercentComplete $pct -CurrentOperation $FirstKey -id 1
				try {
				foreach ($key in ($weights.($FirstKey).keys)) {$k++
					# $pct2 = $k/($weights.($FirstKey).keys.count) / 100
				# write-host "$key $k / $($weights.($FirstKey).keys.count) = $pct"
					# write-progress -Activity "Keys" -PercentComplete $pct2 -CurrentOperation $key -id 2 -parentid 1
					if ($key -eq $word) {
						$weightset += "" | select @{n="key";e={$key}},@{n="FirstKey";e={$FirstKey}},@{n="weight";e={$weights.($FirstKey).($key)}}
						If ($Display) {Write-Host "$n $f $k $w - $word"}
					} # end if key
				} # end foreach key
				} catch {
					write-host "error: $FirstKey"
				}
			} # end foreach FirstKey
		} # end foreach word
		$avg = ($weightset.weight | Measure-Object -Average).Average
		$ky = $weightset.key | select -unique
		$count = $weightset.count
		Write-Host "$ky - Avg: $avg - Count $count"
		If ($Display) {Write-Host "avg: $avg - ints $($weightset.FirstKey)"}
		foreach ($setitem in $weightset) {
			foreach ($FirstKey in ($weights.keys)) {$f++
				foreach ($key in ($weights.($FirstKey).keys)) {$k++
					if ($weights.($setitem.FirstKey).($setitem.key) -lt $avg) {
						$weights.($setitem.FirstKey).($setitem.key) = $weights.($setitem.FirstKey).($setitem.key) + $Gravity
					# Write-Host "+$Gravity " -nonewline -foregroundcolor "green"
					} elseif ($weights.($setitem.FirstKey).($setitem.key) -gt $avg) {
						$weights.($setitem.FirstKey).($setitem.key) = $weights.($setitem.FirstKey).($setitem.key) - $Gravity
					# Write-Host "-$Gravity " -nonewline -foregroundcolor "red"
					} # end if val
					# $val = [math]::round($avg - $weights.($setitem.FirstKey).($setitem.key),0)
					# Write-Host "$val " -nonewline
					# Write-Host "FirstKey $($setitem.FirstKey) - key $($setitem.key) - weight $($setitem.weight) - val: $val"
				} # end foreach key
			} # end foreach FirstKey
		} # end foreach setitem
		# $fk = $weightset.FirstKey | select -unique
		# $wt = $weightset.weight | select -unique
		
		# Write-Host "FirstKey $fk - key $ky - weight $wt - avg: $avg"
		Write-Host ""
	} # end foreach sentence
} # end Function

#Scale gravity by loudness. So that loudness 1 words gravitate faster. 
#Scale gravity by distance. 
#NEed to readd EOS to training set. 

# Average-slamming, then logarithmic epoching.

#No that's dumb
#Make another single-dimension hash table with just the index. 
#Train by moving 2 words closer to each other. (This can be epochal)
#Run by doing $weights.($WordOne).($WordTwo) decision from $Index.($WordTwo)

#Train until "EOF".

Function Get-PredictWord {
	Param(
		$WordOne,
		$WordTwo,
		$Weights = $fb,
		# $InputWeights = (Get-Weights),
		[switch]$Debug
	); #end Param
	# $Weights = $InputWeights.Clone()
	
	if ($WordTwo) {
		$WeightSet = $Weights.($WordOne).($WordTwo)
	} else {
		$WeightSet = $Weights.($WordOne)
	}
	try {
		$sum = 0
		($WeightSet.values | %{$sum += $_})
		if ($sum) {
			$rng = (Get-Random -Maximum $sum) + 1
			if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) sum: $sum - rng: $rng"}
			$sum2 = 0;
			foreach ($key in $WeightSet.keys) {#Reserved words get clobbered.
				if ($key -eq $WordOne) {$WeightSet.$key = $WeightSet.$key / $TuningValue}
				if ($key -eq $WordTwo) {$WeightSet.$key = $WeightSet.$key / $TuningValue}
				$sum2 += $WeightSet.$key;
				if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) key: $key sum2: $sum2"}
				if($sum2 -eq $rng) {
					if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) Selected key: $key"}
					return $key;
					break
				}
			};
		}
	} catch {}
}; #end Get-PredictWord

Function Get-PredictAttnWord { #Attn mode
	Param(
		$newword = "thrift",
		$weightOne = "thrift",
		$weightTwo= "store",
		$ix = ($weights[$weightOne][$weightTwo]),
		[switch]$Display
	)
	$PassThruWord = $newword
	$Sentence = "";
	$n = 0;
	while ($Sentence -notmatch "EOS") {
		$n++
		$word = $newword;
		$Sentence += "$word ";
		[string[]]$keys = $weights[$word].keys;
		[int[]]$values = $weights[$word].values
		$newword="";
		$newdist = 10000000000;
		for ($k = 0 ; $k -lt $keys.count ; $k++) { 
			$key = $keys[$k]
			$value = $values[$k]
			# $dist = $value - $IdeaIndexList[$ix]
			$dist = $value - $ix
			#write-host "$key - $value - $dist"
			if ([math]::Abs($dist) -lt [math]::Abs($newdist)) {
				$newdist = $dist;
				$newword = $key
			}
		}
		if ($Display) {$Sentence}
		if ($Display) {Write-Host "(A)"}
		if ($n -gt 25) {
		if ($Display) {Write-Host "(B)"}
			if (($Sentence -like ($PassThruWord + " eos")) -OR ($PassThruWord -eq ($Sentence  -replace "\s"))) {
		if ($Display) {Write-Host "(C)"}
				Return "I don't know about $($PassThruWord)."
			} else {
		if ($Display) {Write-Host "(D)"}
				$Sentence = Get-Detokenizer ($Sentence)
				$Sentence = $Sentence.substring(0,1).toupper() + $Sentence.substring(1,$Sentence.length-1)
				Return $Sentence
			}
		if ($Display) {Write-Host "(E)"}
			}
		if ($Display) {Write-Host "(F) $($Sentence.length)"}
	}
	if (($Sentence -like ($PassThruWord + " eos")) -OR ($PassThruWord -eq ($Sentence  -replace "\s"))) {
		if ($Display) {Write-Host "(G)"}
		Return "I don't know about $($PassThruWord)."
	} else {
		if ($Display) {Write-Host "(H)"}
		$Sentence = Get-Detokenizer ($Sentence)
		$Sentence = $Sentence.substring(0,1).toupper() + $Sentence.substring(1,$Sentence.length-1)
		Return $Sentence
	}
}

Function Get-PredictSatinWord { #Satin mode
	Param(
		$weightOne = "thrift",
		$weightTwo= ($weights.($weightOne).keys | get-random),
		$ix = ($IdeaIndex[$weightOne]),
		$MaxLength = 25,
		[switch]$Display
	)
	$PassThruWord = $weightOne
	$Sentence = "";
	$n = 0;
	while ($Sentence -notmatch "EOS") {
		$n++
		$word = $weightOne;
		$Sentence += "$word ";
		[string[]]$keys = $weights[$word].keys;
		[int[]]$values = $weights[$word].values
		$weightOne="";
		$newdist = 10000000000;
		for ($k = 0 ; $k -lt $keys.count ; $k++) { 
			$key = $keys[$k]
			$value = $values[$k]
			try {
				# $value = [math]::pow($value,(($Sentence | select-string $word -AllMatches).Matches.count + 1)) #Prevents repeating words.
				$value = $value / (($Sentence | select-string $word -AllMatches).Matches.count + 1) #Prevents repeating words.
				$dist = $value - $ix
			} catch {
				write-host "$word $k $key $value $Sentence"
			}
			# write-host "$key - $value - $dist"
			if ([math]::Abs($dist) -lt [math]::Abs($newdist)) {
				$newdist = $dist;
				$weightOne = $key
			}
		};#$Sentence
		if ($Display) {$Sentence}
		if ($Display) {Write-Host "(A)"}
		if ($n -gt $MaxLength) {
		if ($Display) {Write-Host "(B)"}
			if (($Sentence -like ($PassThruWord + " eos")) -OR ($PassThruWord -eq ($Sentence  -replace "\s"))) {
		if ($Display) {Write-Host "(C)"}
				Return "I don't know about $($PassThruWord)."
			} else {
		if ($Display) {Write-Host "(D)"}
				$Sentence = Get-Detokenizer ($Sentence + " eos ")
				$Sentence = $Sentence.substring(0,1).toupper() + $Sentence.substring(1,$Sentence.length-1)
				Return $Sentence
			}
		if ($Display) {Write-Host "(E)"}
			}
		if ($Display) {Write-Host "(F) $($Sentence.length)"}
	}
	if (($Sentence -like ($PassThruWord + " eos")) -OR ($PassThruWord -eq ($Sentence  -replace "\s"))) {
		if ($Display) {Write-Host "(G)"}
		Return "I don't know about $($PassThruWord)."
	} else {
		if ($Display) {Write-Host "(H)"}
		$Sentence = Get-Detokenizer ($Sentence)
		$Sentence = $Sentence.substring(0,1).toupper() + $Sentence.substring(1,$Sentence.length-1)
		Return $Sentence
	}
}

#Quote parens bracket etc counter, to track completion and prefer this when available. 

#Values aren't held in words, but in the connections between words. 

#Autoindexing: Give each word a number, out of 100x the corpus size or greater. Run word pairs - foreach word, modify their numbers to be closer if they're frequently seen in the text together. Such as if they're 2 apart, modify the numbers to each be 5 closer to each other. 10 apart, move them 1 closer to each other. Based on 1/n modification. It creates its own concept Index by making the words close to each other in the vast numberspace. So you ould take the distance between word and possible nextword as the probability. So that if you have "red" has 10018, and you have "car" with 10038 and "apple" with 10058, it would bring back "car". (And/or make an inverse of this the probabilty, and RNG anyway.)

#Oscillate loud and quiet words by having a sentence volume, and 
#Loudness here is basically next-word entropy

#$Prompt = "What color is the car" -split " "
#Get values -> $weightlist = $weights.eos.what, $weights.what.color, $weights.color.is, $weights.is.the, $weights.the.car
#
#1x1 1x2 1x3 1x4 1x5
#2x2 2x3 2x4 2x5
#3x3 3x4 3x5
#4x4 4x5
#5x5

Function Get-InterPrompt {
	Param(
		$Prompt,
		[switch]$Display
	)
	$weightlist = @()
	$Sentences = @()
	$PromptSplit = $Prompt -split " "
	$PromptLoudness = Get-Loudness $Prompt
	if ($Display) {$PromptLoudness}
	# for ($q = ($p +1) ; $q -lt ($PromptSplit.length) ; $q++) { This only tries the latter half of the prompt as first words, so the first word of the prompt is half-dropped.
	# for ($p = 0 ; $p -lt ($PromptSplit.length) ; $p++) {
		# for ($q = 0 ; $q -lt ($PromptSplit.length) ; $q++) {
			# $weightlist += $weights.($PromptSplit[$p]).($PromptSplit[$q])
		# }
	# }
	# $weightlist = $weightlist | where {$_}
	# $weightlist = $weightlist[0..(($weightlist.count /2)-1)]
	$UnknownIdeas = $PromptLoudness | where {$null -match $_.IdeaIndex}
	if ($UnknownIdeas) {
		$IdkJoin = $UnknownIdeas.word -join " "
		$Sentences += "I don't know about $IdkJoin eos "
	} else {
		$PromptLoudness = $PromptLoudness[0..(($weightlist.count /2)-1)]
		for ($p = 0 ; $p -lt ($PromptSplit.length) ; $p++) {
			for ($q = 0 ; $q -lt ($PromptSplit.length) ; $q++) {
				# $Sentences += $weightlist | %{Get-PredictSatinWord ($weights.($Pro).keys | get-random) -ix $_}
				# $Sentences += Get-PredictSatinWord ($weights.($Pro).keys | get-random) -ix $PromptLoudness[0].IdeaIndex
				# $Sentences += Get-PredictSatinWord -weightOne $PromptSplit[$p] -weightTwo $PromptSplit[$q] -ix $PromptLoudness[0].IdeaIndex
				$Sentences += $PromptLoudness.IdeaIndex | %{
					Get-PredictSatinWord -weightOne $PromptSplit[$p] -weightTwo $PromptSplit[$q] -ix $_
				}
				if ($Display) {$Sentences}
			}
		}
	}
	$Sentences = ($Sentences | select -unique) -join " "
	Return $Sentences
}

# Foreach key in $weights, cycle through every sentence in the corpus. Gather all words in the sentence that are in the key, find their average, and increment those lower than it and decrement those higher than it. 

# "Locked Atttention" - specify a character whose number won't move. So other stuff is drawn to it, and other things are drawn to other items. For items that shoulnd't overlap, like error codes.

<#
$Clip = ""
$NoteFiles ="c:\repos\website\OffgridOffice\New folder\Gillie, Stephen\OffgridOffice.md","C:\repos\website\www\Gillogisms.md","C:\AbductionPalace\ChillSMP.txt"
Foreach ($NoteFile in $NoteFiles) {
	$clip += (gc $NoteFile)
}; #end Foreach NoteFile

$c2 = Get-Tokenizer  $clip | group | sort count -Descending  -Unique
$clipcount = $c2[0].count
#All 3:
$clipcount = 7684 #100%
# $clipcount = 688 #90%
#Just 1:
#>
[int]$clipcount = 4205 #100%
# $clipcount = 572 #90%

Function Get-Loudness {
	Param(
		[string]$Prompt
	)
	$Prompt = Get-Tokenizer $Prompt
	$PromptSplit = $Prompt -split " ";
	$mid = @()
	foreach ($Word in $PromptSplit) {
		# $mid += $Word | Select-Object @{n="Word";e={$_}},@{n="Loudness";e={$IdeaIndex.keys.count / $Weights.($_).keys.count}},@{n="IdeaIndex";e={$IdeaIndex.($_)}} 
		$WordLoudness = $clipcount / $Weights.($Word).keys.count
		$WordLoudness += $clipcount / $Pre.($Word).keys.count
		$mid += $Word | Select-Object @{n="Word";e={$_}},@{n="Loudness";e={$WordLoudness}},@{n="IdeaIndex";e={$IdeaIndex.($_)}}#,@{n="Weight";e={$Weights.($_)}} 
	}
	$ml = ($mid.Loudness | Measure-Object -sum).sum;
	# $ml = 1; #Might give better results.

	$out = $mid| select Word, @{n="RelativeLoudness";e={$_.Loudness / $ml}}, IdeaIndex | sort RelativeLoudness -Descending
	return $out
}

Function Get-WordScore {
	Param(
		[string]$Sentence,
		[string]$Prompt
	)
	$PromptLoudness = Get-Loudness (Get-Tokenizer $Prompt)# | where {$_.RelativeLoudness -gt .2}
	
	$Loudness = Get-Loudness ($Sentence -split " "| sort -Unique) 
	# $Loudness = $Loudness | where {$_.RelativeLoudness -gt .01}  
	$Loudness = $Loudness | select *, @{n="IndexDistanceA";e={[math]::abs($_.IdeaIndex - $PromptLoudness.IdeaIndex[0])}} 
	if ($Loudness.IndexDistanceA -ne 0) {
		$Loudness = $Loudness| select *, @{n="WordScore";e={10 / ($_.RelativeLoudness * $_.IndexDistanceA)}} 
	} else {
		$Loudness = $Loudness| select *, @{n="WordScore";e={0}} 
	}
	$Loudness | %{
		if ($_.WordScore -eq "infinity") {
			$_.WordScore = 0
		}
	}
	$Loudness = $Loudness.WordScore |sort -Descending
	Return $Loudness[0]
}

Function Ask-Enkida {
	Param(
		[string]$Prompt,
		$Start = (Get-Date),
		[switch]$SayPrompt,
		[switch]$Display,
		[switch]$debug,
		[string]$PromptData = (Get-InterPrompt (Get-Tokenizer $Prompt)),
		[string[]]$Sentences = ($PromptData -join " " -split "eos"),
		# [string[]]$Sentences = ((Get-Tokenizer  $PromptData) -join " " -split "eos"), 
		$out = @()
	)
	# $Loudness = Get-Loudness (Get-Tokenizer $Prompt) #| where {$_.RelativeLoudness -gt .2}
	#Return the sentence with the highest word score.
		
	foreach ($Sentence in $Sentences) {
		if ($Sentence) {
			$WordScore = "" | Select-Object @{n="Sentence";e={$Sentence}},@{n="WordScore";e={Get-WordScore $Sentence $Prompt}};
			$out+=$WordScore
		}
	}
	if ($SayPrompt) {
		Say-This $Prompt
	}
	$end = get-date
	$sec = ((get-date $end) - (get-date $start)).TotalSeconds
	if ($debug) {
		$read = ($out | sort wordscore -Descending)
		$read += "`n($sec)"
		write-host $read
	} else {
		if ($Display) {
			# (($out | sort wordscore -Descending))
			$read = Get-Detokenizer ((($out | sort wordscore -Descending)[0].sentence + " eos ") -replace "  "," ")
			$read += "`n($sec)"
			write-host $read
		} else {
			$read = Get-Detokenizer ((($out | sort wordscore -Descending)[0].sentence + " eos ") -replace "  "," ")
			$read += "`n($sec)"
			Say-This $Read
		}
	}
}

Function Say-This {
	#Rename to Out-Speech?
	Param(
		[Array]$Text = "Type something for me to say",
		[String]$Gender = "female",
		[String]$Age = "adult"
	); #end Param
	Add-Type -AssemblyName System.Speech
	$synthesizer = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
	$synthesizer.SelectVoiceByHints($Gender, $Age) 
	$synthesizer.Speak($Text)
}; #end Say-This

Function Get-FourthSentence {
	Param(
		$Weights = $fb,
		$WordOne = ($Weights.($enum.EOS).keys | Get-random),
		$WordTwo = ($Weights.($WordOne).keys | Get-random),
		$MaxLength = 25,
		[switch]$Debug
	)
	$out = "$WordOne $WordTwo "
	$out += (Get-PredictWord $WordOne $WordTwo $Weights) + $enum.space
	$i = 0
	While (($out -notmatch $enum.EOS3) -AND ($i -lt $MaxLength)) {
	# for ($i = 0; $i -lt $MaxLength; $i++) {
		$i++
		[array]$mid = ($out -split $enum.space | where {$_.length -gt 0})
		if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) i: $i mid $mid"}
		
		$pc = $i / $MaxLength * 100
		# $pc = 0
		$NewWord = Get-PredictWord $mid[-2] $mid[-1] $Weights
		Write-Progress -Activity "Getting word $i of $MaxLength" -Status "$pc percent complete: $($mid[-2]) $($mid[-1]) - $NewWord" -PercentComplete $pc -CurrentOperation $mid[-1]
		if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) mid $($mid[-1]) $($mid[-2])"}
		if ($NewWord) {
			$out +=  "$NewWord "
		}
		if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) NewWord $NewWord"}
	}

	$out = Get-Detokenizer $out 
	$out = $out.substring(0,1).toupper() + $out.substring(1,$out.length-1)
	Return $out
}; #end Get-FourthSentence

Function Get-ThirdSentence {
	Param(
		$Weights = $fb,
		$WordOne = ($Weights.($enum.EOS3).keys | Get-random),
		$WordTwo = ($Weights.($WordOne).keys | Get-random),
		$MaxLength = 25,
		[switch]$Reverse,
		[switch]$Debug
	)
	$MidWeights = $Weights.Clone()

	$out = "$WordOne $WordTwo "
	$out += (Get-PredictWord $WordOne $WordTwo $MidWeights) + $enum.space
	$i = 0
	if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) i: $i out $out"}
	While (($out -notmatch $enum.EOS3) -AND ($i -lt $MaxLength)) {
#If it doesn't get to $enum.EOS3 before $MaxLength, dump it and start over?
	# for ($i = 0; $i -lt $MaxLength; $i++) {
		$i++
		[array]$mid = ($out -split $enum.space | where {$_.length -gt 0})
		if ($mid) {
			if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) i: $i mid $mid"}
			
			$pc = $i / $MaxLength * 100
			# $pc = 0
			$NewWord = Get-PredictWord $mid[-2] $mid[-1] $MidWeights
			Write-Progress -Activity "Getting word $i of $MaxLength" -Status "$pc percent complete: $($mid[-2]) $($mid[-1]) - $NewWord" -PercentComplete $pc -CurrentOperation $mid[-1]
			if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) mid $($mid[-1]) $($mid[-2])"}
			if ($NewWord) {
				$out +=  "$NewWord "
			}
			if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) NewWord $NewWord"}
		}
	}

	
	If ($Reverse) {
		$out = $out -split " ";
		$out = $out[($out.count -1)..0];
		$out = $out -join " "
		$out = $out -replace $enum.EOS3,""
		$out = $out +$enum.EOS2
	} else {
	}
	
	$out = Get-Detokenizer $out 
	$out = $out.trim()
	# $out = $out -replace $enum.LFReplace,$enum.LF

	Return $out
}; #end Get-ThirdSentence

Function Get-CapsAndDot {
	Param(
		$out
	)
	$out = $out.substring(0,1).ToUpper() + $out.substring(1,$out.length-1)
}

Function Get-SentenceOld {
	Param(
		$Weights = $fb,
		$WordOne = ($Weights.($enum.EOS3).keys | Get-random),
		$MaxLength = 25,
		[switch]$Debug
	)
	$out = "$WordOne ";
	$out += (Get-PredictWord $WordOne -Weights $Weights) + $enum.space;
	$word = ($out -split $enum.space | where {$_.length -gt 0});
	if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) word: $word"}
	$out += (Get-PredictWord $word  -Weights $Weights) + $enum.space;
	if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) out $out"}
	While (($out -notmatch $enum.EOS3) -AND ($i -lt $MaxLength)) {
		[array]$mid = ($out -split $enum.space | where {$_.length -gt 0})
		if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) mid $mid"}
		
		$pc = 0
		Write-Progress -Activity "Getting word $i of $Words" -Status "$pc percent complete" -PercentComplete $pc -CurrentOperation $w
		if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) mid $mid i: $i - w: $word"}
		$out += (Get-PredictWord $mid[-1]  -Weights $Weights) + $enum.space;
		if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) out $out"}
	}
	$out = Get-Detokenizer $out 
	$out = $out.substring(0,1).toupper() + $out.substring(1,$out.length-1)
	Return $out
}

Function Get-Deconjugate2 {
	Param(
		$ConjugatedVerb
	)
	$Root = ""
	$Person = ""
	$Tense = ""
	$conj = Get-Conjugate

	$Persons = @{}
	$Persons.have = @{}
	$Persons.have.First = "have"
	$Persons.have.Plural = "have"
	$Persons.have.Singular = "has"
	$Persons.Present = @{}
	$Persons.Present.First = "am"
	$Persons.Present.Plural = "are"
	$Persons.Present.Singular = "is"
	$Persons.Past = @{}
	$Persons.Past.First = "was"
	$Persons.Past.Plural = "were"
	$Persons.Past.Singular = "was"
	
		switch  -wildcard ($ConjugatedVerb) {
			("*ed") {#Past 
				$Root = $ConjugatedVerb -replace "ed",""
				$Person = "First"
				$Tense = "Past"
			}
			default {
			}
		}#end switch 
	if ($ConjugatedVerb -match "asked") { write-host "Root $Root"}
	if ($Root) {
		$out = "" | Select-Object @{n="Root";e={$Root}}, @{n="Person";e={$Person}}, @{n="Tense";e={$Tense}}
	}
	Return $out
}

Function Get-Deconjugate {
	Param(
		$ConjugatedVerb
	)
	$Root = ""
	$Person = ""
	$Tense = ""
	$conj = Get-Conjugate

	$Persons = @{}
	$Persons.have = @{}
	$Persons.have.First = "have"
	$Persons.have.Plural = "have"
	$Persons.have.Singular = "has"
	$Persons.Present = @{}
	$Persons.Present.First = "am"
	$Persons.Present.Plural = "are"
	$Persons.Present.Singular = "is"
	$Persons.Past = @{}
	$Persons.Past.First = "was"
	$Persons.Past.Plural = "were"
	$Persons.Past.Singular = "was"
	
	
		switch  -wildcard ($ConjugatedVerb) {
			$conj.Imperative {
				$Root = $conj.Imperative
				$Person = "First"
				$Tense = "Imperative"
			}
			("to *") {
				$Root = $ConjugatedVerb -replace "to ",""
				$Person = "First"
				$Tense = "Infinitive"
			}
			$Persons.Present.First {
				$Root = $conj.Imperative
				$Person = "First"
				$Tense = "Present"
			}
			$Persons.Past.First {
				$Root = $conj.Imperative
				$Person = "First"
				$Tense = "Past"
			}
			$Persons.have.First {
				$Root = $conj.Imperative
				$Person = "First"
				$Tense = "have"
			}
			$Persons.Present.Singular {
				$Root = $conj.Imperative
				$Person = "Singular"
				$Tense = "Present"
			}
			$Persons.Past.Singular {
				$Root = $conj.Imperative
				$Person = "Singular"
				$Tense = "Past"
			}
			$Persons.have.Singular {
				$Root = $conj.Imperative
				$Person = "Singular"
				$Tense = "have"
			}
			$Persons.Present.Plural {
				$Root = $conj.Imperative
				$Person = "Plural"
				$Tense = "Present"
			}
			$Persons.Past.Plural {
				$Root = $conj.Imperative
				$Person = "Plural"
				$Tense = "Past"
			}
			$Persons.have.Plural {
				$Root = $conj.Imperative
				$Person = "Plural"
				$Tense = "have"
			}
			("will *") {
				$Root = $ConjugatedVerb -replace "will ",""
				$Person = "First"
				$Tense = "Future"
			}
			("*ed") {#Past 
				$Root = $ConjugatedVerb -replace "ed$",""
				$Person = "First"
				$Tense = "Past"
			}
			("will " + $Persons.have.First + " *") {
				$Root = $ConjugatedVerb -replace ("will" + " " + $Persons.have.First + " "),""
				$Person = "First"
				$Tense = "FuturePerfect"
			}
			("will " + $Persons.have.First + " *ed") {
				$Root = $ConjugatedVerb -replace ("will" + " " + $Persons.have.First + " "),"" -replace "ed",""
				$Person = "First"
				$Tense = "FuturePerfect"
			}
			("having *") {
				$Root = $ConjugatedVerb -replace "having ",""
				$Person = "First"
				$Tense = "PerfectParticiple"
			}
			# ($Persons.have.First + " " + $conj.PastParticiple + " " + $conj.PerfectParticiple) {#have been having been
			# ($Persons.have.First + " " + $conj.PastParticiple + " " + $conj.PresentParticiple) {#have been being
			($Persons.have.First + " " + $conj.PastParticiple) {#have been 
				$Root = $conj.Imperative
				$Person = "First"
				$Tense = "PresentPerfectContinuous"
			}
			($Persons.have.First + " *") {#have *
				$Root = $ConjugatedVerb -replace ($Persons.have.First + " "),""
				$Person = "First"
				$Tense = "PresentPerfect"
			}
			("had *") {
				$Root = $ConjugatedVerb -replace "had ","" -replace "ed",""
				$Person = "First"
				$Tense = "PastPerfect"
			}

			"being" {
				$Root = $conj.Imperative
				$Person = "First"
				$Tense = "PresentParticiple"
			}
			"been" {
				$Root = $conj.Imperative
				$Person = "First"
				$Tense = "PastParticiple"
	# $conj.PastParticiple = $conj.Past
			}
			"action" {
				$Root = $conj.Imperative
				$Person = "First"
				$Tense = "Noun"
			}
			($conj.Present + " " + $conj.PerfectParticiple) {#am having been
				$Root = $conj.Imperative
				$Person = "First"
				$Tense = "PresentContinuous"
	# $conj.PresentContinuous = $Persons.Present +" " +  $conj.PresentParticiple #am being
			}
			# ($conj.Past + " " + $conj.PerfectParticiple) {#was having been
			($conj.Past + " " + $conj.PresentParticiple) {#was being
				$Root = $conj.Imperative
				$Person = "First"
				$Tense = "PastContinuous"
	# $conj.PastContinuous = $Persons.Past + " " + $conj.PresentParticiple #was being 
			}
			# ($conj.Future + " " + $conj.PerfectParticiple) {#will be having been
			($conj.Future + " " + $conj.PresentParticiple) {#will be being
				$Root = $conj.Imperative
				$Person = "First"
				$Tense = "FutureContinuous"
			}
			# ($conj.PastPerfect + " " + $conj.PerfectParticiple) {#had been having been
			($conj.PastPerfect + " " + $conj.PresentParticiple) {#had been being
				$Root = $conj.Imperative
				$Person = "First"
				$Tense = "PastPerfectContinuous"
			}
			# ($conj.FuturePerfect + " " + $conj.PerfectParticiple) {#will have been having been
			($conj.FuturePerfect + " " + $conj.PresentParticiple) {#will have been being
				$Root = $conj.Imperative
				$Person = "First"
				$Tense = "FuturePerfectContinuous"
			}



			default {
			}
		}#end switch 
	if ($Root) {
		$out = "" | Select-Object @{n="Root";e={$Root}}, @{n="Person";e={$Person}}, @{n="Tense";e={$Tense}}
	}
	Return $out
}

Function Get-Conjugate {
	Param(
		$Verb = "is",
#Pronoun - I|you/we/they|he/she/they/it
		[ValidateSet("First","Plural","Singular")][string]$Person = "First" ,
		[ValidateSet("Future","FutureContinuous","FuturePerfect","FuturePerfectContinuous","Imperative","Infinitive","Noun","Past","PastContinuous","PastParticiple","PastPerfect","PastPerfectContinuous","PerfectParticiple","Present","PresentContinuous","PresentParticiple","PresentPerfect","PresentPerfectContinuous")][string]$Tense 
	)
	$out = ""| select "Imperative", "Infinitive", "Present", "Past", "Future", "PresentParticiple", "PastParticiple", "PerfectParticiple", "PresentPerfect", "PastPerfect", "FuturePerfect", "PresentContinuous", "PastContinuous", "Noun", "FutureContinuous", "PresentPerfectContinuous", "PastPerfectContinuous", "FuturePerfectContinuous"
	$Persons = @{}
	switch ($Person) {
		"First" {
			$Persons.have = "have"
			$Persons.Present = "am"
			$Persons.Past = "was"
		}
		"Plural" {
			$Persons.Present = "are"
			$Persons.Past = "were"
			$Persons.have = "have"
		}
		"Singular" {
			$Persons.Present = "is"
			$Persons.Past = "was"
			$Persons.have = "has"
		}
		default {
			Write-Host "Bad Value: $Person"
		}
	}

	if (($Verb -eq "is") -OR ($Verb -eq "be")) {
		$out.Imperative = "be"
		$out.Infinitive = "to " +$out.Imperative
		$out.Present = $Persons.Present
		$out.Past = $Persons.Past
		$out.Future = "will " + $out.Imperative
		$out.PresentParticiple = "being"
		$out.PastParticiple = "been"
		$out.PerfectParticiple = "having " + $out.PastParticiple
		$out.PresentPerfect = $Persons.have + " " + $out.PastParticiple
		$out.PastPerfect = "had " +  $out.PastParticiple
		$out.FuturePerfect = "will have" + " " +  $out.PastParticiple
		$out.PresentContinuous = $out.Present + " " + $out.PerfectParticiple
		$out.Noun = "action"
		$out.PastContinuous = $out.Past + " " + $out.PresentParticiple
		$out.FutureContinuous = $out.Future + " " + $out.PresentParticiple
		$out.PresentPerfectContinuous = $Persons.have + " " +  $out.PastParticiple
		$out.PastPerfectContinuous = $out.PastPerfect + " " + $out.PresentParticiple
		$out.FuturePerfectContinuous = $out.FuturePerfect + " " + $out.PresentParticiple
	} else {
		$out.Imperative = $Verb
		# if ($out.Imperative -eq "is") {
			# $out.Present = $Persons.Present
			# $out.Past = $Persons.Past
		# } else {
			$out.Present = $out.Imperative
			$out.Past = $out.Present + "ed"
			$out.Past = $out.Past -replace "eed","ed" 
			$out.Past = $out.Past -replace "ived","ove" 
			$out.Past = $out.Past -replace "aved","ad" 
			$out.Past = $out.Past -replace "ited","at"  
			$out.Past = $out.Past -replace "baat","baited" 
		# }
		$out.Infinitive = "to " +$out.Imperative
		$out.PresentParticiple = $out.Present +"ing"
		$out.PresentParticiple = $out.PresentParticiple -replace "ating","atting"
		$out.Noun = $out.Imperative + "tion"
		$out.Noun = $out.Noun  -replace "etion","tion"
		$out.Noun = $out.Noun  -replace "ttion","tion"
		$out.Noun = $out.Noun  -replace "ltion","tion"
		$out.Noun = $out.Noun  -replace "dtion","sion"
		$out.Noun = $out.Noun  -replace "ytion","ication"
		$out.Noun = $out.Noun  -replace "writion","written"
		if ($Verb[-1] -eq "e") {
			if ($Verb[-2] -eq "e") {
			} else {
				$out.PresentParticiple = $out.PresentParticiple -replace "eing","ing"
			}
			$out.PresentParticiple = $out.PresentParticiple -replace "bing","being" 
			$out.Noun = $out.Noun -replace "btion","action" 
		} else {
			$out.Past = $out.Past -replace "iting","itting"
			$out.Past = $out.Past -replace "ated","atted"
			$out.PresentParticiple = $out.PresentParticiple -replace "oatting","oating" 
			$out.Past = $out.Past -replace "oatted","oated" 
			$out.Past = $out.Past -replace "aled","alled" 
			$out.Past = $out.Past -replace "eled","elled" 
			$out.Past = $out.Past -replace "tanded","tood" 
			
		}
		$out.Past = $out.Past -replace "^eated","eaten" 
		$out.Past = $out.Past -replace "^beated","beaten" 
		$out.Past = $out.Past -replace "yed$","ied" 
		$out.Past = $out.Past -replace "^bed$","been" 
		
		$out.Past = $out.Past -replace "feelled","felt" 
		$out.Past = $out.Past -replace "anged","ung" 
		$out.Past = $out.Past -replace "inged","ang" 
		$out.Past = $out.Past -replace "lighted","lit" 
		$out.Past = $out.Past -replace "maked","made" 
		$out.Past = $out.Past -replace "stealled","stole" 
		$out.Past = $out.Past -replace "swimed","swam" 
		$out.Past = $out.Past -replace "taked","took" 
		$out.Past = $out.Past -replace "wrat","wrote" 
		
		$out.Future = "will " + $out.Imperative 
		$out.PastParticiple = $out.Past
		$out.PresentContinuous = $Persons.Present +" " +  $out.PresentParticiple
		$out.PastContinuous = $Persons.Past + " " + $out.PresentParticiple
		$out.FutureContinuous = (Get-Conjugate).Future + " " + $out.PresentParticiple
		$out.PresentPerfect = $Persons.have + " " + $out.PastParticiple
		$out.PastPerfect = "had " + $out.PastParticiple
		$out.FuturePerfect = "will have" + " " +  $out.PastParticiple
		$out.PerfectParticiple = "having " + $out.PastParticiple
		$out.PresentPerfectContinuous = $Persons.have + " " +  $out.PastParticiple
		$out.PastPerfectContinuous = (Get-Conjugate).PastPerfect + " " + $out.PresentParticiple
		$out.FuturePerfectContinuous = (Get-Conjugate).FuturePerfect + " " + $out.PresentParticiple
	}# end if "is"
	if ($Tense) {
		Return $out.$Tense
	} else {
		Return $out
	}
}

Function Get-BulkDeconjugation {
	Param(
		$Book,
		$booksplit = ($Book -split "[.] "),
		$Conjugates = (Get-Conjugate),
		$names = (Get-HashNames $Conjugates),
		$out = @()
	)
	foreach  ($line in $booksplit) {
		foreach ($name in $names) { 
			$currentItemConj = $Conjugates.$name
			If ($line -match $currentItemConj) {
				$Name,$varValue = $line -split " $currentItemConj "
				$de = Get-Deconjugate $currentItemConj
				$mid = "" | Select-Object @{n="Name";e={$Name}}, @{n="Value";e={$varValue}}, @{n="Pronoun";e={"I"}}, @{n="Root";e={$de.Root}}, @{n="Person";e={$de.Person}}, @{n="Tense";e={$de.Tense}}
				$out += $mid
			}
		}
	}
	Return $out
}

Function Get-TestConjugates {
	$Conjugates = Get-Conjugate
	(Get-HashNames $Conjugates).name | %{
		$tense = $_;
		$test = (Get-Deconjugate $Conjugates.$tense).tense -eq $tense;
		if ($test) {
			write-host "$_ - $test"
		} else {
			write-host "$_ - $test" -f red
		}
	}
}

#ELI5 mode: Get-Summary -Article $g -OutputDetail 2 -InformativityLower 1 -InformativityUpper 2 -WordinessUpper 100 -WordinessLower 10 -OutputLength 3
#Expert mode: Get-Summary -Article $g -OutputDetail 2 -InformativityLower 4 -InformativityUpper 12
#$t = $s[0..5000] -join "" -replace "`n`n`n","" -split "`n`n"
#Need to troubleshoot why it's duplicating sentences.
Function Get-Summary {
# $g = Get-Clipboard;$h = $g -split "`n`n";$b = $h | where {($_ -split "[.] ").length -gt 2};
# For ($d = 0 ; $d -lt $b.count ; $d+=4) {
# (($b[$d] -split "[.] ")[0..1]+ ($b[$d+1] -split "[.] ")[0..1] +($b[$d+2] -split "[.] ")[0..1] +($b[$d+3] -split "[.] ")[0..1]-join ". ")+".`n`n"
#Write-Host -f green " d number  $($d)"
# }; #end For d
	Param(
		$Article = (Get-Clipboard),
		[int]$OutputDetail = 4,
		[int]$OutputLength = 1,
		[int]$InformativityUpper = 6,
		[int]$InformativityLower = 2,
		[int]$WordinessUpper = 30,
		[int]$WordinessLower = 10
	)
	[string[]]$SplitArticle = $Article -split "`n`n";
	[string[]]$Paragraphs = $SplitArticle | where {($_ -split "[.] ").length -ge $InformativityLower} | where {($_ -split "[.] ").length -le $InformativityUpper};
	[string[]]$out = $null
	
	For ($p = 0 ; $p -le $Paragraphs.count ; $p+=$OutputDetail) {
		# For ($s = 0 ; $s -le $OutputDetail ; $s++) {
			$ParagraphSplit = ($Paragraphs[$p+$s] -split " ")
		Write-Host "ParagraphSplit p $p s $s $ParagraphSplit"
			$WordCount = $ParagraphSplit.length
			if (($WordCount -gt $WordinessLower) -AND ($WordCount -lt $WordinessUpper)) {
				$out = $out + (($Paragraphs[$p] -split "[.] ")[0..$OutputLength] )#+".`n`n"
			}
		# }; #end For OutputDetail
		$out = $out  -replace "[.]\n",""
		# $out = $out  | where {$_ -notmatch "Copyright"}
		# $out = $out  | where {$_ -notmatch "All Rights Reserved"}
		$out = ($out  -join ". ") +".`n`n"
	}; #end For Paragraphs.count
	Return $out
}

Function Get-Summary2 {
# $g = Get-Clipboard;$h = $g -split "`n`n";$b = $h | where {($_ -split "[.] ").length -gt 2};
# For ($d = 0 ; $d -lt $b.count ; $d+=4) {
# (($b[$d] -split "[.] ")[0..1]+ ($b[$d+1] -split "[.] ")[0..1] +($b[$d+2] -split "[.] ")[0..1] +($b[$d+3] -split "[.] ")[0..1]-join ". ")+".`n`n"
#Write-Host -f green " d number  $($d)"
# }; #end For d
	Param(
		$Article = (Get-Clipboard),
		[int]$Skip = 1,
		[int]$Relevance = 2,
		[int]$Detail= 3
	)
	1..100 | %{$Article = $Article -replace "`n$($_)`n","`n`n"}
	# 1..100 | %{$Article = $Article -replace "`n$($_)`n",""}
	"I","II""III""IIII""V" | %{$Article = $Article -replace "`n$($_)`n","`n`n"}
	# "I","II""III""IIII""V" | %{$Article = $Article -replace "`n$($_)`n",""}
	[string[]]$Paragraphs = $Article -split "`n`n" -replace "-`n","" -replace "`n"," " -replace "  "," "
	# [string[]]$Paragraphs = $Article -split "`n`n" 
	$Paragraphs = $Paragraphs | where {($_ -split "[.] ").length -ge $Relevance}
	[string[]]$out = $null
	
	For ($p = 0 ; $p -lt $Paragraphs.count ; $p+=$Skip) {
		$Sentences = $Paragraphs[$p] -split "[.] "
		# $Sentences = $Sentences | where {$_.length -gt 2}
		# $Sentences = $Sentences
		$out = $out + (($Sentences)[0..$Detail] )#+".`n`n"
		$out = ($out  -join ". ") +".`n`n" -replace "`n[.] ","`n" -replace "[.][.]","."
		# $out += "P $P"
		# For ($l = 0 ; $l -le $Level ; $l++) {
		# $out += "L $l - P + L = $($P+$l)"
		# }; #end For l
		# $out = $out  | where {$_ -notmatch "Copyright"}
		# $out = $out  | where {$_ -notmatch "All Rights Reserved"}
		# $out = $out  | Select-Object -Unique
		# $out = $out  | Where-Object {$_}
	}; #end For d
	Return $out
}

<# 51185 chars input

$File=".\count.csv";"Level,Depth,Relevance,Count" >> $File;$n = 5;for ($a = 1 ; $a -lt $n ; $a++) { for ($b = 1 ; $b -lt $n ; $b++) { for ($c = 1 ; $c -lt $n ; $c++) { $g = Get-Summary2 -Article $text -level $a -Depth $b -Relevance $c; $g = ($g -split "").count; "$a,$b,$c,$g" >> $File } } };$x = gc $File | ConvertFrom-Csv;rm $File


#>

Function Get-HashNames {
	Param(
		$HashTable
	)
	($HashTable  | gm | where {$_.membertype -match "noteproperty"}).name
}

Function Get-AddInfo {
	Param(
		$Term,
		$clip
	)
	$BulkDeconj = (Get-BulkDeconjugation -book $clip) | where {$_.value}
	$SplitDeconj = $BulkDeconj| where {($_.name -split " ").count -lt 6}| where {($_.name -split " ").count -gt 3}
	$Lines = 0..$SplitDeconj.count
	foreach ($Line in $Lines) {
		try {
			$LineItem = $SplitDeconj[$Line]
			[int]$NameSplit = ($LineItem.name -split " ").count
			[int]$ValueSplit = ($LineItem.value -split " ").count
			if ($NameSplit -lt $ValueSplit) {
				$dataVar.($LineItem.name) = $LineItem.value
			} else {
				$dataVar.($LineItem.value) = $LineItem.name
			}
		} catch {}
		
	}
}

Function Get-Info {
	Param(
		$Prompt
	)
	$out = ""
	If ($Prompt -match "What is") {
		$Prompt = $Prompt -replace "What is ",""
		$Prompt = $Prompt -replace "\?",""
		$out = $dataVar.$Prompt
	}
	if ($out) {
	}
	Return $out
}

Function Get-Setup {
	Param(
		[string[]]$NoteFiles,
		[switch]$NoAnswers,
		[switch]$Prev,
		[switch]$Attn,
		[switch]$Split
	)
	$SetupStart = Get-Date
	$Clip = ""
	Foreach ($NoteFile in $NoteFiles) {
		if ($Split) {
			$clip += (gc $NoteFile) -join $enum.LFReplace
		} else {
			$clip += (gc $NoteFile)
		}; #end if Split
	}; #end Foreach NoteFile
	$clip = Get-Tokenizer $clip
	
	if ($Attn) {
		$script:weights = (Get-Weights -Mode Attn -clip $clip)
		$script:Pre = Get-Weights -clip $clip -Mode Trivet -weightArray $Pre
		$NoAnswers = $true
	} else {
		if ($prev) {
			$script:weights = (Get-Weights -Mode Trivet -clip $clip)
		} else {
			$script:weights = (Get-Weights -Mode Third -clip $clip)
		}; #end if prev
	}; #end if prev
	[string[]]$Keys = $weights.keys
	# $Keys = "bread","hotspot","peppers","yakima","change","socks","sun","rain","2019","site","hill","tent","wind","ranger","building","store","place","water","sun","today","on","the","at"
	$n = 0
	if (!($NoAnswers))  {
		$Keys |%{
			$n++
			$pc = $n/$Keys.count * 100
			Write-Progress -Activity "$($MyInvocation.MyCommand.Name) " -Status "Preparing answers - $pc percent complete - generating  $_" -PercentComplete $pc -CurrentOperation $_
			Get-AddInfo $_ -clip $clip
		}
	}

	if ($Attn) {
		$IdeaIndex = Get-Weights -Mode Satin -clip $clip -weightArray $IdeaIndex
		Get-BulkSatinStrain -clip $clip
	} 
	
	$dataVar."the weather" = "zzMCPFunction Get-Weather"
	$WordCount = ($Clip -split " ").count
	$SetupEnd = Get-Date
	$time = ($SetupEnd - $SetupStart);
	$TotalTime = Get-Date -Hour $time.Hours -Minute $time.Minutes -Second $time.Seconds -f T
	Write-Host "TML training for $WordCount words took $TotalTime hours."
}

Function Get-TransferIdeasToWeights {
	$n = 0;
	[string[]]$Keys = $Weights.keys;
	foreach ($key in $Keys) {
		$n++
		[string[]]$subkeys = $weights[$key].keys
		foreach ($subkey in $subkeys) {
			$weights.$key.$subkey = $IdeaIndex.$subkey
			$pct = $n/$keys.count*100
			write-progress -Activity "copy $pct % complete" -PercentComplete $pct -CurrentOperation "copy $subkey"
		}#end foreach subkey
	}#end foreach key	
}

Function Get-SaveWeights {
	$weights | Export-Clixml -Path C:\repos\ToyLanguageModel\weights.gtml
	$pre | Export-Clixml -Path C:\repos\ToyLanguageModel\pre.gtml
	$IdeaIndex | Export-Clixml -Path C:\repos\ToyLanguageModel\IdeaIndex.gtml
	Compress-Archive -LiteralPath C:\repos\ToyLanguageModel\Gilgamech-17k-v0.1-GTST1\ -DestinationPath C:\repos\ToyLanguageModel\Gilgamech-17k-v0.1-GTST1.zip
	Rename-Item -Path C:\repos\ToyLanguageModel\Gilgamech-17k-v0.1-GTST1.zip -NewName C:\repos\ToyLanguageModel\Gilgamech-17k-v0.1-GTST1.gtws
}



Function Get-Answer {
	Param(
		[string]$String = "What is along US-97?"
	)
	$out = (Get-Info $String)
	$String = $String -replace "What is ","" -replace "\?",""
	$mid = ""
	if ($out -match "zzMCPFunction") {
		$out = $out -replace "zzMCPFunction ",""
		$out = $out -replace "[.]",""
		$out = $out -replace " ",""
		$out
		.$out
	} else {
		# if ($out.gettype().basetype.name -eq "Array") {$out = $out | Get-Random}
		$one,$two,$throwAwayTheRest = $out -split " ";
		$mid = Get-ThirdSentence $one $two -Weights $weights
	}
	$out = "$String was $mid"
	$out = $out.substring(0,1).toupper() + $out.substring(1,$out.length-1)+"." 
	$out = $out -replace "[.][.]","."
	$out = $out -replace "[,][.]","."
	$out = $out -replace "[?][.]","?"
	$out = Get-NormalizeTenses $out
	Return $out
}

Function Get-CompositeAnswer {
	Param (
		$WordOne = "Rainier",
		$WordTwo
	)
	if ($WordTwo) {
		$a = get-thirdSentence $WordTwo $WordOne -Weights $w2 -Reverse;
		$b = get-thirdSentence $WordOne $WordTwo -Weights $weights;
		$Replace = $WordOne + " " +$WordTwo
	} else {
		$a = get-thirdSentence $WordOne -Weights $w2 -Reverse;
		$b = get-thirdSentence $WordOne -Weights $weights;
		$Replace = $WordOne
	}
	$b = $b.substring(0,1).ToLower() + $b.substring(1,$b.length-1)
	Return ($a -replace "$($Replace)[.]","")+$b
}
#MCP Functions 
Function Get-Weather {
	$weather = iwr "https://api.weather.gov/alerts/active/area/WA" | ConvertFrom-Json
	$weather2 = iwr $weather.features.id[0] | ConvertFrom-Json
	$weather3 = iwr $weather.features.id[1] | ConvertFrom-Json
	Return ($weather2.properties.description + $weather3.properties.description)
}

Function Get-ThreeWords {
	Param(
		$WordOne,
		$WordTwo,
		$WordThree
	)
	$FirstThird = ((Get-ThirdSentence "," $WordOne -Weights $w2 -Reverse) -split ",")[-2];
	$FirstThird = $FirstThird.substring(0,1).ToLower() + $FirstThird.substring(1,$FirstThird.length-1)
	$out = $FirstThird 
	if ($WordTwo) {
		$SecondThird = ((Get-ThirdSentence "," $WordTwo -Weights $w2 -Reverse) -split ",")[-2];
		$SecondThird = $SecondThird.substring(0,1).ToLower() + $SecondThird.substring(1,$SecondThird.length-1)
		$out += ", " + $SecondThird
	}
	if ($WordThree) {
		$ThirdThird = ((Get-ThirdSentence "," $WordThree -Weights $w2 -Reverse) -split ",")[-2];
		$ThirdThird = $ThirdThird.substring(0,1).ToLower() + $ThirdThird.substring(1,$ThirdThird.length-1)
		$out += ", " + $ThirdThird
	}
	$out += ". " 
	$out = $out.trim()
	$out = $out.substring(0,1).toupper() + $out.substring(1,$out.length-1)
	Return $out
}

Function Get-Sentence {
	Param(
		[int]$Words = (get-random -Minimum 1 -Maximum 3)
	)
	$SomeWords = "bread","hotspot","peppers","yakima","change","socks","sun","rain","2019","site","hill","tent","wind","ranger","building","store","place","water","sun","today","on","the","at"
	$a = $SomeWords | get-random
	$b = $null
	$c = $null
	switch ($Words) {
		1 {}
		2 {
			$b = $SomeWords | get-random
		}
		3 {
			$b = $SomeWords | get-random
			$c = $SomeWords | get-random
		}
		default {}
	} 
	Get-ThreeWords $a $b $c
}

Function Get-Paragraph {
	Param (
		[int]$Sentences = (get-random -Minimum 3 -Maximum 7)
	)
	$out = "";
	1..$Sentences |%{
		$out += Get-Sentence ;$out +=" ";
	};
	Return $out
}

Function Get-NewThing {#Experiment involving getting the first and second words, then the "connecting tissue" between them.
	Param(
		$clip = (($chill -join " EOS ") + ($isms -join " EOS ") + $book),
		$w3 = (Get-Weights -Mode Init -clip $clip)
	)
	$n = 0
	$w4 = $w3.clone()
	foreach ($key in $w4.keys) {
		$w3.$key = $w4.clone()
		$pc = $n / $w4.keys.count * 100
		$n++
		Write-Progress -Activity "$($MyInvocation.MyCommand.Name) init table" -Status "$pc percent complete: $($d[$h]) $($d[$i])" -PercentComplete $pc -CurrentOperation $weights.($currentItem) 
	}
	$clip = $clip -split "EOS" -split "[.][ ]"
	# $c = $clip[1505]
	$n = 0
	foreach ($c in $clip) {
		$pc = $n / $clip.count * 100
		$n++
		# Write-Host -f green "This is  c  $($c)"
		$d = ""
		try {
			$d = Get-Tokenizer $c
		} catch {}
		if ($d) {
			$out = ""
			for ($i = 2; $i -lt $d.count; $i++) {
				for ($h = 1 ; $h -lt $d.count ; $h++) {
				#	Write-Host -f green " h number  $($h)"
					# $pc = $i / $d.count
					if ($d[$h]) {
						Write-Progress -Activity "$($MyInvocation.MyCommand.Name) write table" -Status "$pc percent complete: $($d[$h]) $($d[$i])" -PercentComplete $pc -CurrentOperation $weights.($currentItem) 
						$out = ($d[$h..($i -1)]  -join " ");
						#$out = $out.substring(0,1).toupper() + $out.substring(1,$out.length-1);
						#"$($d[0]) to $($d[$i]) - $out"
						try {$w3.($d[$h]).($d[$i]) += $out} catch{}
					}
				}; #end for h
			}
		}; #end if c
	}; #end foreach c
	Return $w3
}; #end Get-NewThing

Function Get-NormalizeTenses {
	Param(
		$clip
	)
	$SentenceTense = "";
	$out = "";
	foreach ($word in ($clip -split " ")) {
		$d = Get-Deconjugate $word
		#"word: $word - d: $d - SentenceTense b4: $(`"`" -eq $SentenceTense)"
		if ($SentenceTense.length -le 1) {
			$SentenceTense = $d.Tense;
			# $SentenceTense
		}
		#"word: $word - d: $d - SentenceTense af: $SentenceTense"
		if ($d.Person) {
			#$d;
			# $SentenceTense
			$out += Get-Conjugate -Verb $d.Root -Person $d.Person -Tense $SentenceTense
			# $out
		} else {
			$out +=$word
		}
		$out += " "
		$d = ""
	};
	Return $out
}

Function Get-LoopCoding {
	Param(
		$FilePath = "C:\repos\ToyLanguageModel\pass.ps1",
		$Vibes = 10000,
		[switch]$Matrix,
		[switch]$Prev,
		[switch]$Split
	)
	[int]$TotalLines = 0
	$Timestamp = "# " + (Get-Date -f s)
	$Timestamp | Out-File -FilePath $FilePath -Append
	
	while ($true) {
		$sTime = Get-Date
		$Scriptblock = "";
		if ($Prev) {
			$Host.UI.RawUI.WindowTitle = "$($TotalLines) -$Vibes Vibes"
			$Code = Get-ThirdSentence "function" -Weights $weights -MaxLength $Vibes -Reverse;
		} else {
			$Host.UI.RawUI.WindowTitle = "$($TotalLines) $Vibes Vibes"
			$Code = Get-ThirdSentence "function" -Weights $weights -MaxLength $Vibes;
		}; #end if Prev
		# Write-host "Generation took $TotalSeconds seconds."
		if ($Matrix) {
			"`n";
		}; #end if Matrix
		try{
			if ($Split) {
				$Code = ($Code -split "#")[0]
			}
			$Scriptblock = [Scriptblock]::Create($Code);
			. $Scriptblock;
			write-host $Code -f green;
			$Code | out-file -FilePath $FilePath -Append
			$TotalLines += $Code.length
		}catch{
			# write-host $Code
		};
		$eTime = Get-Date
		$TotalSeconds = ($eTime - $sTime).TotalSeconds
		# Out-File $FilePath -InputObject (gc $FilePath | Select-Object -Unique)
		$Host.UI.RawUI.WindowTitle = "$($TotalLines) $($TotalSeconds) of sleep"
		sleep ($TotalSeconds * 0.2)
	} 
}


<# GTML File Format
KV list:
- Author
- Version
- Date
- Corpus size
Hashtables
- weights
- IdeaIndex
#>



<# 
#https://stackoverflow.com/questions/9361594/powershell-can-speak-but-can-it-write-if-i-speak

$null = [Reflection.Assembly]::LoadWithPartialName("System.Speech")

## Create the two main objects we need for speech recognition and synthesis
if (!$global:SpeechModuleListener) {
    ## For XP's sake, don't create them twice...
    $global:SpeechModuleSpeaker = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $global:SpeechModuleListener = New-Object System.Speech.Recognition.SpeechRecognizer
}

$script:SpeechModuleMacros = @{}
## Add a way to turn it off
$script:SpeechModuleMacros.Add("Stop Listening", {$script:listen = $false; Suspend-Listening})
$script:SpeechModuleComputerName = ${env:ComputerName}

function Update-SpeechCommands {
    #.Synopsis 
    #  Recreate the speech recognition grammar
    #.Description
    #  This parses out the speech module macros, 
    #  and recreates the speech recognition grammar and semantic results, 
    #  and then updates the SpeechRecognizer with the new grammar, 
    #  and makes sure that the ObjectEvent is registered.
    $choices = New-Object System.Speech.Recognition.Choices
    foreach ($choice in $script:SpeechModuleMacros.GetEnumerator()) {
        New-Object System.Speech.Recognition.SemanticResultValue $choice.Key, $choice.Value.ToString() |
            ForEach-Object { $choices.Add($_.ToGrammarBuilder()) }
    }

    if ($VerbosePreference -ne "SilentlyContinue") {
        $script:SpeechModuleMacros.Keys |
            ForEach-Object { Write-Host"$Computer, $_" -Fore Cyan }
    }

    $builder = New-Object System.Speech.Recognition.GrammarBuilder("$Computer, ")
    $builder.Append((New-ObjectSystem.Speech.Recognition.SemanticResultKey("Commands"), $choices.ToGrammarBuilder()))
    $grammar = New-Object System.Speech.Recognition.Grammar $builder
    $grammar.Name = "Power VoiceMacros"

    ## Take note of the events, but only once (make sure to remove the old one)
    Unregister-Event"SpeechModuleCommandRecognized" -ErrorAction SilentlyContinue
    $null = Register-ObjectEvent $grammar SpeechRecognized `
                -SourceIdentifier"SpeechModuleCommandRecognized" `
                -Action {iex $event.SourceEventArgs.Result.Semantics.Item("Commands").Value}

    $global:SpeechModuleListener.UnloadAllGrammars()
    $global:SpeechModuleListener.LoadGrammarAsync($grammar)
}

function Add-SpeechCommands {
    #.Synopsis
    #  Add one or more commands to the speech-recognition macros, and update the recognition
    #.Parameter CommandText
    #  The string key for the command to remove
    [CmdletBinding()]
    Param([hashtable]$VoiceMacros,[string]$Computer=$Script:SpeechModuleComputerName)

    ## Add the new macros
    $script:SpeechModuleMacros += $VoiceMacros 
    ## Update the default if they change it, so they only have to do that once.
    $script:SpeechModuleComputerName = $Computer 
    Update-SpeechCommands
}

function Remove-SpeechCommands {
    #.Synopsis
    #  Remove one or more command from the speech-recognition macros, and update the recognition
    #.Parameter CommandText
    #  The string key for the command to remove
    Param([string[]]$CommandText)
    foreach ($command in $CommandText) {
        $script:SpeechModuleMacros.Remove($Command)
    }
    Update-SpeechCommands
}

function Clear-SpeechCommands {
    #.Synopsis
    #  Removes all commands from the speech-recognition macros, and update the recognition
    #.Parameter CommandText
    #  The string key for the command to remove
    $script:SpeechModuleMacros = @{}
    ## Default value: A way to turn it off
    $script:SpeechModuleMacros.Add("Stop Listening", {Suspend-Listening})
    Update-SpeechCommands
}

function Start-Listening {
    #.Synopsis
    #  Sets the SpeechRecognizer to Enabled
    $global:SpeechModuleListener.Enabled = $true
    Say-This "Speech Macros are $($Global:SpeechModuleListener.State)"
    Write-Host "Speech Macros are $($Global:SpeechModuleListener.State)"
}

function Suspend-Listening {
    #.Synopsis
    #  Sets the SpeechRecognizer to Disabled
    $global:SpeechModuleListener.Enabled = $false
    Say-This "Speech Macros are disabled"
    Write-Host "Speech Macros are disabled"
}

function Remove-SpeechXP {
    #.Synopis
    #  Dispose of the SpeechModuleListener and SpeechModuleSpeaker
    $global:SpeechModuleListener.Dispose(); $global:SpeechModuleListener = $null
    $global:SpeechModuleSpeaker.Dispose();  $global:SpeechModuleSpeaker = $null
}

Set-Alias asc Add-SpeechCommands
Set-Alias rsc Remove-SpeechCommands
Set-Alias csc Clear-SpeechCommands
Set-Alias say Out-Speech
Set-Alias listen Start-Listening
# Export-ModuleMember -Function * -Alias * -VariableSpeechModuleListener, SpeechModuleSpeaker
 #>