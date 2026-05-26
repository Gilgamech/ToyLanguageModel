#Copyright 2026 Gilgamech Technologies
#Author: Stephen Gillie
#Created 5/15/2026
#Updated 5/25/2026
#And the love kickstarts again.

<# Directions:
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
$cenum.toppenish = "Toppenish"
$cenum.canad = "Canad"
$cenum."battle violets"= "Battle Violets"

[ValidateSet("Text","Code")][string]$WeightMode = "Text"
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
		[ValidateSet("Init","Write","ThirdI","ThirdW","Third","Both")][string]$Mode = "Both",
		$weights = @{},
		[switch]$Debug
	)	
	$clip = Get-Tokenizer $clip 

	$Length = ($clip.length -2)
	if ("Init Both Third" -match $mode) {
		for ($i=0; $i -le $Length; $i++) {
			$this = $clip[$i];
			# $next = $clip[$i+1];
			# "$this - $next"
			$weights.($this) = @{}
			$pc = $i / $Length * 100
			Write-Progress -Activity "Initializing hash table" -Status "$pc percent complete: $this" -PercentComplete $pc -CurrentOperation $name
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
			Write-Progress -Activity "Writing hash table" -Status "$pc percent complete: $this $next" -PercentComplete $pc -CurrentOperation $name
		}
	}
	if ("ThirdI" -match $mode) {
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
			Write-Progress -Activity "Initializing Third table" -Status "$pc percent complete: $this $next" -PercentComplete $pc -CurrentOperation $name
		}
	}
	if ("ThirdW" -match $mode) {
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
			Write-Progress -Activity "Writing Third table" -Status "$pc percent complete: $this $next $second" -PercentComplete $pc -CurrentOperation $name
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
