#Copyright 2026 Gilgamech Technologies
#Author: Stephen Gillie
#Created 5/15/2026
#Updated 6/10/2026
#Notes:
#v1.1 Added rudiumentary NLP, and a knowledge engine to inspire generation. 

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



<#
Get caps words from input, put in other list. 
Identifying important words is as much how many are pointing to it as how many it's pointing to. 
n't - negation
Feel - certainty
#>

<# Wisdom:
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
Healthy was was happy was part of my personal maxims.
A few seemed to was using the choice of 'this one' and 'the everything else one'.


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
$enum.EOL1 = " EOL "
$enum.EOL2 = " EOL "
$enum.EOL3 = "EOL"
$enum.EOL4 = " EOL"
$enum.LF = "`n"
$enum.LFReplace = " zzLF "

#PowerShell reserved words.
$rEnum = @{}
$rEnum.aCount = "count"
$rEnum.aKeys = "keys"
$rEnum.aName = "name"
$rEnum.aReturn = "Return"
$rEnum.aValue = "value"
$rEnum.aAdd = "add"
$rEnum.aClear = "clear"
$rEnum.aContains = "contains"
$rEnum.aEquals = "equals"
$rEnum.aItem = "item"
$rEnum.aRemove = "remove"
$rEnum.aSecond = "Second"
$rEnum.aGetenumerator = "getenumerator"
$rEnum.aGettype = "gettype"
$rEnum.aPropert = "propert"
$rEnum.aPsobject = "psobject"
$rEnum.aTostring = "tostring"

#Caps words
$cenum = @{}
$cenum.seattle = "Seattle"
$cenum.richland = "Richland"
$cenum.aberdeen = "Aberdeen"
$cenum.wa = "WA"
$cenum.grayland = "Grayland"
$cenum.toppenish = "Toppenish"
$cenum.canad = "Canad" # Canada, Canadian, et cetera
$cenum.urizane = "Urizane" # Watermelon Man
$cenum."battle violets"= "Battle Violets"

#Prevent clobbering when reloading, but still init on first run.
 if (!($WeightMode)) {[ValidateSet("Text","Code")][string]$WeightMode = "Text"}
 if (!($dataVar)) {$dataVar = @{}}
 if (!($weights)) {$weights = @{}}
#endregion

Function Get-Tokenizer {
	Param(
		$Clip,
		[switch]$Debug
	); #end Param
	$clip = $clip -replace "\\",$enum.Backslash

	if ($WeightMode -eq "Text") {
		# $clip = $clip -replace $enum.RegexChars,$enum.RegexReplace
		$clip = $clip -replace $enum.dot,$enum.EOL1
		$clip = $clip.ToLower();
	} else {
		# $clip = $clip -replace "`t"," zzTab "
		$clip = $clip -replace "`t",""
		# $clip = $clip -replace $enum.hyphen,$enum.hyphenReplace  
		$clip = $clip -replace $enum.dot,$enum.dotReplace
		$clip = $clip -replace $enum.semicolon,$enum.EOL1
		# $clip = $clip -replace $enum.tab,$enum.EOL1
		# # $clip = $clip -replace $enum.RegexChars,$enum.RegexReplace
		# $clip = $clip -replace $enum.LF,$enum.EOL2
	}
	$clip = $clip -split $enum.space
	$clip = $clip | where {$_}

	$renum.keys  | %{$clip = $clip -replace $renum.($_),$_}
	Return $clip
}; #end GetTokenizer

Function Get-Detokenizer {
	Param(
		$Clip,
		[switch]$Debug
	); #end Param
	#PowerShell reserved words.
	$renum.keys  | %{$clip = $clip -replace $_, $renum.($_) };
	if ($WeightMode -eq "Text") {
		$renum.keys  | %{$clip = $clip -replace $_, $cenum.($_) };
		$clip = $clip -replace ",",", "
		$clip = $clip -replace "\("," ("
		$clip = $clip -replace "\)",") "
		$clip = $clip -replace "\?","? "
		$clip = $clip -replace "%","% "
		$clip = $clip -replace " i "," I "
		$clip = $clip -replace " us-"," US-"
		$clip = $clip -replace " wa-"," WA-"
		$clip = $clip -replace $enum.RegexChars2,$enum.RegexReplace2
		$clip = $clip -replace $enum.EOL2,"." 
	} else {
		$clip = $clip -replace $enum.RegexChars2,$enum.RegexReplace2
		$clip = $clip -replace $enum.EOL3,$enum.semicolon2
		$clip = $clip -replace "zzTab",""
		# $clip = $clip -replace $enum.hyphenReplace,"-"
	}
	$clip = $clip -replace $enum.dotReplace,"."
	$clip = $clip -replace "zzLF",$enum.LF
	$clip = $clip -replace $enum.Backslash,"\"
	Return $clip

}; #end Get-Detokenizer

Function Get-Weights {
	Param(
		$clip = $fb,
		[ValidateSet("Both","Fourth","Init","Prev","PrevI","PrevW","Third","ThirdI","ThirdW","Trivet","TrivetI","TrivetW","Write")][string]$Mode = "Both",
		$weights = @{},
		[switch]$Debug
	)	
	$weights.zzLF = @{}
	$weights.zzdotzz = @{}
	$weights.zzbackslash = @{}
	$weights.zzTab = @{}
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

	if ("Init Both Prev Third Trivet Fourth" -match $mode) {
		for ($i=0; $i -le $UniqueLength; $i++) {
			$currentItem = $Unique[$i];
			# $next = $clip[$i+1];
			# "$currentItem - $next"
			$weights.($currentItem) = @{}
			$pc = $i / $UniqueLength * 100
			Write-Progress -Activity "Initializing hash table" -Status "$pc percent complete: $currentItem" -PercentComplete $pc -CurrentOperation $weights.($currentItem) 
		}
	}
	if ("Write Both" -match $mode) {
		for ($i=0; $i -le $Length; $i++) {
			$currentItem = $clip[$i];
			$next = $clip[$i+1];
		try {
			$weights.($currentItem).($next) += 1
		} catch {
				Write-Host "$Mode Error: This $currentItem Next $prev"
		}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Writing hash table" -Status "$pc percent complete: $currentItem $prev" -PercentComplete $pc -CurrentOperation $weights.($currentItem).($next)
		}
	}
	if ("PrevW" -match $mode) {#uses Init for init
		for ($i=0; $i -le $Length; $i++) {
			$currentItem = $clip[$i];
			$prev = $clip[$i-1];
			try {
				$weights.($currentItem).($prev) += 1
			} catch {
				try {
					$weights.($currentItem).($prev) = @{}
					$weights.($currentItem).($prev) += 1
				} catch {
					Write-Host "$Mode Error: This $currentItem Prev $prev"
				}
			}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Writing $Mode table" -Status "$pc percent complete: $currentItem $prev" -PercentComplete $pc -CurrentOperation $weights.($currentItem).($prev)
		}
	}
	if ("TrivetI" -match $mode) {#Init for Prev for Third
		for ($i=0; $i -le $Length; $i++) {
			$currentItem = $clip[$i];
			$prev = $clip[$i-1];
			# "$currentItem - $prev"
			try {
				$weights.($currentItem).($prev) = @{}
			} catch {
				Write-Host "$Mode Error: This $currentItem Prev $prev"
			}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Initializing $Mode table" -Status "$pc percent complete: $currentItem $prev" -PercentComplete $pc -CurrentOperation $weights.($currentItem).($prev)
		}
	}
	if ("TrivetW" -match $mode) {#Write for Prev for Third
		for ($i=0; $i -le $Length; $i++) {
			$currentItem = $clip[$i];
			$prev = $clip[$i - 1];
			$secondprev = $clip[$i - 2];
			# "$currentItem - $prev"
			try {
				$weights.($currentItem).($prev).($secondprev) += 1
			} catch {
				Write-Host "$Mode Error: This $currentItem Next $next Second $second"
			}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Writing $Mode table" -Status "$pc percent complete: $currentItem $prev" -PercentComplete $pc -CurrentOperation $weights.($currentItem).($prev)
		}
	}
	if ("ThirdI Fourth" -match $mode) {
		for ($i=0; $i -le $Length; $i++) {
			$currentItem = $clip[$i];
			$next = $clip[$i+1];
			# "$currentItem - $next"
			try {
				$weights.($currentItem).($next) = @{}
			} catch {
				Write-Host "$Mode Error: This $currentItem Next $next"
			}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Initializing $Mode table" -Status "$pc percent complete: $currentItem $next" -PercentComplete $pc -CurrentOperation $weights.($currentItem).($next)
		}
	}
	if ("ThirdW Fourth" -match $mode) {
		for ($i=0; $i -le $Length; $i++) {
			$currentItem = $clip[$i];
			$next = $clip[$i+1];
			$second = $clip[$i+2];
			# "$currentItem - $next"
			# $weights.($currentItem).($next).("zzNumber") += 1#This will be the sum.
			try {
				$weights.($currentItem).($next).($second) += 1
				# $weights.($DataOne).($DataTwo).($DataThree).("EOL") -> DataOne.was.made.with.Datatwo -> DataTwo pieces of DataThree -> DataThree in just under DataFour.
				# $weights.($DataOne).($DataTwo) -> DataOne.was.made.with.Datatwo
			} catch {
				Write-Host "$Mode Error: This $currentItem Next $next Second $second"
			}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Writing $Mode table" -Status "$pc percent complete: $currentItem $next $second" -PercentComplete $pc -CurrentOperation $weights.($currentItem).($next).($second)
		}
	}
	if ("FourthW" -match $mode) {
		$weights = get-weights -Mode Init -clip $clip
		1..16|%{
			Write-Progress -Activity "Writing $_ table" -Status "$pc percent complete: $currentItem $next $second" -PercentComplete $pc -CurrentOperation $weights.($currentItem).($next).($second)
			$weightsClone = $weights.Clone();
			[array]$words = $weights.keys
			foreach ($word in $words) {
				$weights[$word] = $weightsClone
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
			
			# $weights.($currentItem).($next).("zzNumber") += 1#This will be the sum.

			try {
				# $weights.($currentItem).zzNumber += 1
				# $weights.($currentItem).($next).("zzNumber") += 1#This will be the sum.
				# $weights.($currentItem).($next).zzNumber += 1
				# $weights.($currentItem).($next).($third).zzNumber += 1
				# $weights.($currentItem).($next).($third).($fourth).zzNumber += 1
				# $weights.($currentItem).($next).($third).($fourth).($fifth).zzNumber += 1
				# $weights.($currentItem).($next).($third).($fourth).($fifth).($sixth).zzNumber += 1
				# $weights.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).zzNumber += 1
				# $weights.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).zzNumber += 1
				# $weights.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).zzNumber += 1
				# $weights.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).zzNumber += 1
				# $weights.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).zzNumber += 1
				# $weights.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).zzNumber += 1
				# $weights.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).($thirteenth).zzNumber += 1
				# $weights.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).($thirteenth).($fourteenth).zzNumber += 1
				# $weights.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).($thirteenth).($fourteenth).($fifteenth).zzNumber += 1
				$weights.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).($thirteenth).($fourteenth).($fifteenth).($sixteenth) += 1
				#$w.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).($thirteenth).($fourteenth).($fifteenth).($sixteenth)
			} catch {
				Write-Host "Fourth Error: $currentItem $next $third $fourth $fifth $sixth $seventh $eigth $ninth $tenth $eleventh $twelvth $thirteenth $fourteenth $fifteenth $sixteenth"
			}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Writing Fourth table $i" -Status "$pc percent complete:  $currentItem $next $third $fourth $fifth $sixth $seventh $eigth $ninth $tenth $eleventh $twelvth $thirteenth $fourteenth $fifteenth $sixteenth" -PercentComplete $pc -CurrentOperation $weights.($currentItem).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).($thirteenth).($fourteenth).($fifteenth).($sixteenth)
		}
	}
	Return $Weights
}

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

Function Get-FourthSentence {
	Param(
		$Weights = $fb,
		$WordOne = ($Weights.($enum.EOL).keys | Get-random),
		$WordTwo = ($Weights.($WordOne).keys | Get-random),
		$MaxLength = 25,
		[switch]$Debug
	)
	$out = "$WordOne $WordTwo "
	$out += (Get-PredictWord $WordOne $WordTwo $Weights) + $enum.space
	$i = 0
	While (($out -notmatch $enum.EOL3) -AND ($i -lt $MaxLength)) {
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
		$WordOne = ($Weights.($enum.EOL3).keys | Get-random),
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
	While (($out -notmatch $enum.EOL3) -AND ($i -lt $MaxLength)) {
#If it doesn't get to $enum.EOL3 before $MaxLength, dump it and start over?
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
		$out = $out -replace $enum.EOL3,""
		$out = $out +$enum.EOL2
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
		$WordOne = ($Weights.($enum.EOL3).keys | Get-random),
		$MaxLength = 25,
		[switch]$Debug
	)
	$out = "$WordOne ";
	$out += (Get-PredictWord $WordOne -Weights $Weights) + $enum.space;
	$word = ($out -split $enum.space | where {$_.length -gt 0});
	if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) word: $word"}
	$out += (Get-PredictWord $word  -Weights $Weights) + $enum.space;
	if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) out $out"}
	While (($out -notmatch $enum.EOL3) -AND ($i -lt $MaxLength)) {
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
				$mid = "" | select-object @{n="Name";e={$Name}}, @{n="Value";e={$varValue}}, @{n="Pronoun";e={"I"}}, @{n="Root";e={$de.Root}}, @{n="Person";e={$de.Person}}, @{n="Tense";e={$de.Tense}}
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
		[switch]$Split
	)
	$Clip = ""
	Foreach ($NoteFile in $NoteFiles) {
		if ($Split) {
			$clip += (gc $NoteFile) -join $enum.LFReplace
		} else {
			$clip += (gc $NoteFile)
		}; #end if Split
	}; #end Foreach NoteFile
	
	if ($prev) {
		$script:weights = (Get-Weights -Mode Trivet -clip $clip )
	} else {
		$script:weights = (Get-Weights -Mode Third -clip $clip)
	}; #end if prev
	# $Infos = $weights.keys
	$Infos = "bread","hotspot","peppers","yakima","change","socks","sun","rain","2019","site","hill","tent","wind","ranger","building","store","place","water","sun","today","on","the","at"
	$n = 0
	if (!($NoAnswers))  {
		$Infos |%{
			$n++
			$pc = $n/$infos.count * 100
			Write-Progress -Activity "$($MyInvocation.MyCommand.Name) " -Status "Preparing answers - $pc percent complete - generating  $_" -PercentComplete $pc -CurrentOperation $_
			Get-AddInfo $_ -clip $clip
		}
	}
	$dataVar."the weather" = "zzMCPFunction Get-Weather"
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
		$clip = (($chill -join " EOL ") + ($isms -join " EOL ") + $book),
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
	$clip = $clip -split "EOL" -split "[.][ ]"
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

Function Get-VibeCoding {
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
