#Copyright 2026 Gilgamech Technologies
#Author: Stephen Gillie
#Created 5/15/2026
#Updated 6/10/2026
#Notes:
#v1.1 Added rudiumentary NLP, and a knowledge engine to inspire generation. 
#And the love kickstarts again.

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
$enum = @{}
$enum.space = " "
$enum.tab = "`t"
$enum.semicolon = "[;]"
$enum.semicolon2 = ";"
$enum.hyphenReplace = " zzhyphenzz "
$enum.hyphen = "[-]"
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
if ($WeightMode -eq "Text") {
	$clip = $clip -replace $enum.RegexChars,$enum.RegexReplace
	$clip = $clip -replace $enum.dot,$enum.EOL1
} else {
	$clip = $clip -replace $enum.hyphen,$enum.hyphenReplace  
	$clip = $clip -replace $enum.dot,$enum.dotReplace  
	$clip = $clip -replace $enum.semicolon,$enum.EOL1
	$clip = $clip -replace $enum.tab,$enum.EOL1
	$clip = $clip -replace $enum.RegexChars,$enum.RegexReplace
	$clip = $clip -replace $enum.LF,$enum.EOL2
}
	$clip = $clip -split $enum.space
	$clip = $clip | where {$_}
	$clip = $clip.ToLower();

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
		$clip = $clip -replace $enum.hyphenReplace,"-"
		$clip = $clip -replace $enum.dotReplace,"."
		# $clip = $clip -replace $enum.EOL4,$enum.semicolon2
	}
	Return $clip

}; #end Get-Detokenizer

Function Get-Weights {
	Param(
		$clip = (($fb) -join $enum.space),
		[ValidateSet("Both","Fourth","Init","Third","ThirdI","ThirdW","Write")][string]$Mode = "Both",
		$weights = @{},
		[switch]$Debug
	)	
	$clip = Get-Tokenizer $clip 
	$Length = ($clip.length -2)
	$Unique = $clip | Sort-Object -Unique
	$UniqueLength = ($Unique.length -2)


	if ("Init Both Third Fourth" -match $mode) {
		for ($i=0; $i -le $UniqueLength; $i++) {
			$this = $Unique[$i];
			# $next = $clip[$i+1];
			# "$this - $next"
			$weights.($this) = @{}
			$pc = $i / $UniqueLength * 100
			Write-Progress -Activity "Initializing hash table" -Status "$pc percent complete: $this" -PercentComplete $pc -CurrentOperation $weights.($this) 
		}
	}
	if ("Write Both" -match $mode) {
		for ($i=0; $i -le $Length; $i++) {
			$this = $clip[$i];
			$next = $clip[$i+1];
		try {
			$weights.($this).($next) += 1
		} catch {
				Write-Host "ThirdI Error: This $this Next $next"
		}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Writing hash table" -Status "$pc percent complete: $this $next" -PercentComplete $pc -CurrentOperation $weights.($this).($next)
		}
	}
	if ("ThirdI Fourth" -match $mode) {
		for ($i=0; $i -le $Length; $i++) {
			$this = $clip[$i];
			$next = $clip[$i+1];
			# "$this - $next"
			try {
				$weights.($this).($next) = @{}
			} catch {
				Write-Host "ThirdI Error: This $this Next $next"
			}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Initializing Third table" -Status "$pc percent complete: $this $next" -PercentComplete $pc -CurrentOperation $weights.($this).($next)
		}
	}
	if ("ThirdW Fourth" -match $mode) {
		for ($i=0; $i -le $Length; $i++) {
			$this = $clip[$i];
			$next = $clip[$i+1];
			$second = $clip[$i+2];
			# "$this - $next"
			# $weights.($this).($next).("zzNumber") += 1#This will be the sum.
			try {
				$weights.($this).($next).($second) += 1
			} catch {
				Write-Host "ThirdW Error: This $this Next $next Second $second"
			}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Writing Third table" -Status "$pc percent complete: $this $next $second" -PercentComplete $pc -CurrentOperation $weights.($this).($next).($second)
		}
	}



	if ("Fourth" -match $mode) {
		$weights = get-weights -Mode Init -clip $clip
		1..16|%{
			Write-Progress -Activity "Writing $_ table" -Status "$pc percent complete: $this $next $second" -PercentComplete $pc -CurrentOperation $weights.($this).($next).($second)
			$weightsClone = $weights.Clone();
			[array]$words = $weights.keys
			foreach ($word in $words) {
				$weights[$word] = $weightsClone
			}
		}
		#$w.set.set.set.set.set.set.set.set.set.set.set.set.set.set.set.set
		
		for ($i=0; $i -le $Length; $i++) {
			$this = $clip[$i];
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
			
			# $weights.($this).($next).("zzNumber") += 1#This will be the sum.

			try {
				# $weights.($this).zzNumber += 1
				# $weights.($this).($next).("zzNumber") += 1#This will be the sum.
				# $weights.($this).($next).zzNumber += 1
				# $weights.($this).($next).($third).zzNumber += 1
				# $weights.($this).($next).($third).($fourth).zzNumber += 1
				# $weights.($this).($next).($third).($fourth).($fifth).zzNumber += 1
				# $weights.($this).($next).($third).($fourth).($fifth).($sixth).zzNumber += 1
				# $weights.($this).($next).($third).($fourth).($fifth).($sixth).($seventh).zzNumber += 1
				# $weights.($this).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).zzNumber += 1
				# $weights.($this).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).zzNumber += 1
				# $weights.($this).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).zzNumber += 1
				# $weights.($this).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).zzNumber += 1
				# $weights.($this).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).zzNumber += 1
				# $weights.($this).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).($thirteenth).zzNumber += 1
				# $weights.($this).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).($thirteenth).($fourteenth).zzNumber += 1
				# $weights.($this).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).($thirteenth).($fourteenth).($fifteenth).zzNumber += 1
				$weights.($this).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).($thirteenth).($fourteenth).($fifteenth).($sixteenth) += 1
				#$w.($this).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).($thirteenth).($fourteenth).($fifteenth).($sixteenth)
			} catch {
				Write-Host "Fourth Error: $this $next $third $fourth $fifth $sixth $seventh $eigth $ninth $tenth $eleventh $twelvth $thirteenth $fourteenth $fifteenth $sixteenth"
			}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Writing Fourth table $i" -Status "$pc percent complete:  $this $next $third $fourth $fifth $sixth $seventh $eigth $ninth $tenth $eleventh $twelvth $thirteenth $fourteenth $fifteenth $sixteenth" -PercentComplete $pc -CurrentOperation $weights.($this).($next).($third).($fourth).($fifth).($sixth).($seventh).($eigth).($ninth).($tenth).($eleventh).($twelvth).($thirteenth).($fourteenth).($fifteenth).($sixteenth)
		}
	}
	Return $Weights
}

Function Get-PredictWord {
	Param(
		$WordOne,
		$WordTwo,
		$Weights = (Get-Weights),
		[switch]$Debug
	); #end Param
	
	if ($WordTwo) {
		$WeightSet = $Weights.($WordOne).($WordTwo)
	} else {
		$WeightSet = $Weights.($WordOne)
	}
	try {
		$sum = 0
		($WeightSet.values | %{$sum += $_})
		if ($sum) {
			$rng = Get-Random -Maximum $sum
			if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) sum: $sum - rng: $rng"}
			$sum2 = 0;
			foreach ($key in $WeightSet.keys) {#Reserved words get clobbered.
				$sum2 += $WeightSet.$key;
				if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) key: $key sum2: $sum2"}
				if($sum2 -ge $rng) {
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
		
		# $pc = $i / $MaxLength * 100
		$pc = 0
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
}; #end Get-ThirdSentence

Function Get-ThirdSentence {
	Param(
		$Weights = $fb,
		$WordOne = ($Weights.($enum.EOL3).keys | Get-random),
		$WordTwo = ($Weights.($WordOne).keys | Get-random),
		$MaxLength = 25,
		[switch]$Debug
	)
	$out = "$WordOne $WordTwo "
	$out += (Get-PredictWord $WordOne $WordTwo $Weights) + $enum.space
	$i = 0
	While (($out -notmatch $enum.EOL3) -AND ($i -lt $MaxLength)) {
#If it doesn't get to $enum.EOL3 before $MaxLength, dump it and start over?
	# for ($i = 0; $i -lt $MaxLength; $i++) {
		$i++
		[array]$mid = ($out -split $enum.space | where {$_.length -gt 0})
		if ($mid) {
			if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) i: $i mid $mid"}
			
			# $pc = $i / $MaxLength * 100
			$pc = 0
			$NewWord = Get-PredictWord $mid[-2] $mid[-1] $Weights
			Write-Progress -Activity "Getting word $i of $MaxLength" -Status "$pc percent complete: $($mid[-2]) $($mid[-1]) - $NewWord" -PercentComplete $pc -CurrentOperation $mid[-1]
			if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) mid $($mid[-1]) $($mid[-2])"}
			if ($NewWord) {
				$out +=  "$NewWord "
			}
			if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) NewWord $NewWord"}
		}
	}

	$out = Get-Detokenizer $out 
	$out = $out.substring(0,1).toupper() + $out.substring(1,$out.length-1)
	Return $out
}; #end Get-ThirdSentence

Function Get-Sentence {
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
			("will " + $Persons.have.First + " *") {
				$Root = $ConjugatedVerb -replace ("will" + " " + $Persons.have.First + " "),""
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
				$Root = $ConjugatedVerb -replace "had ",""
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
	
	



		
	$out = "" | Select-Object @{n="Root";e={$Root}}, @{n="Person";e={$Person}}, @{n="Tense";e={$Tense}}
	Return $out
}

Function Get-Conjugate {
	Param(
		$Verb = "is",
#Pronoun - I|you/we/they|he/she/they/it
		[ValidateSet("First","Plural","Singular")][string]$Person = "First" 
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

	if ($Verb -eq "is") {
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
		if ($out.Imperative -eq "is") {
			$out.Present = $Persons.Present
			$out.Past = $Persons.Past
		} else {
			$out.Present = $out.Imperative
			$out.Past = $out.Present + "ed"
			$out.Past = $out.Past -replace "eed","ed" 
			$out.Past = $out.Past -replace "ived","ove" 
			$out.Past = $out.Past -replace "aved","ad" 
			$out.Past = $out.Past -replace "ited","at"  
			$out.Past = $out.Past -replace "baat","baited" 
		}
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
	}
	Return $out
}

Function Get-BulkDeconjugation {
	Param(
		$Book = (gc "C:\repos\website\OffgridOffice\New folder\Gillie, Stephen\OffgridOffice.md"),
		$booksplit = ($Book -split "[.] "),
		$selectstring = "2019",
		$lines = ($booksplit | select-string $selectstring),
		$Conjugates = (Get-Conjugate),
		$names = (Get-HashNames $Conjugates),
		$out = @()
	)
	foreach  ($line in $lines) {
		foreach ($name in $names) { 
			$ThisConj = $Conjugates.$name
			If ($line -match $ThisConj) {
				$Name,$varValue = $line -split " $ThisConj "
				$de = Get-Deconjugate $ThisConj
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
		$test = (get-deconjugate $Conjugates.$tense).tense -eq $tense;
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
		$Term
	)
	$BulkDeconj = (Get-BulkDeconjugation -selectstring $Term) | where {$_.value}
	$SplitDeconj = $BulkDeconj| where {($_.name -split " ").count -lt 6}| where {($_.name -split " ").count -gt 3}
	$Lines = 0..$SplitDeconj.count
	foreach ($Line in $Lines) {
		$LineItem = $SplitDeconj[$Line]
		[int]$NameSplit = ($LineItem.name -split " ").count
		[int]$ValueSplit = ($LineItem.value -split " ").count
		if ($NameSplit -lt $ValueSplit) {
			$dataVar.($LineItem.name) = $LineItem.value
		} else {
			$dataVar.($LineItem.value) = $LineItem.name
		}
		
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
		$out = $out.substring(0,1).toupper() + $out.substring(1,$out.length-1)+"."
	}
	Return $out
}

Function Get-Setup {
	Param(
		$Book = "C:\Files\OffgridOffice.md",
		$Notes1 = "C:\Files\Gillogisms.md",
		$Notes2 = "C:\Files\ChillSMP.txt"
	)
	$script:weights = (Get-Weights -Mode Third -clip (((gc $Notes2) -join $enum.EOL2) + ((gc $Notes1) -join $enum.EOL2) + (gc $Book)))
	Get-AddInfo 2019
	Get-AddInfo site
	Get-AddInfo hill
	Get-AddInfo tent
	Get-AddInfo wind
	Get-AddInfo ranger
	Get-AddInfo building
	Get-AddInfo favorite
	Get-AddInfo store
	Get-AddInfo place
	Get-AddInfo water
	Get-AddInfo sun
	Get-AddInfo today
	Get-AddInfo on
	Get-AddInfo the
	Get-AddInfo at
	Get-AddInfo head
	$dataVar."the weather" = "zzMCPFunction Get-Weather"
}

Function Get-Answer{
	Param(
		[string]$String = "What is along US-97?"
	)
	$out = (Get-Info $String)
	if ($out -match "zzMCPFunction") {
		$out = $out -replace "zzMCPFunction ",""
		$out = $out -replace "[.]",""
		$out = $out -replace " ",""
		$out
		.$out
	} else {
		$one,$two,$throwAwayTheRest = $out -split " ";
		Get-ThirdSentence $one $two -Weights $weights
	}
}

#MCP Functions 
Function Get-Weather {
	$weather = iwr "https://api.weather.gov/alerts/active/area/WA" | ConvertFrom-Json
	$weather2 = iwr $weather.features.id[0] | ConvertFrom-Json
	$weather3 = iwr $weather.features.id[1] | ConvertFrom-Json
	Return ($weather2.properties.description + $weather3.properties.description)
}
