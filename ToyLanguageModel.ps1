#Copyright 2026 Gilgamech Technologies
#Author: Stephen Gillie
#Created 5/15/2026
#Updated 8/20/2026
#Notes:
#v2.1 - Added answer setting system. Can reliably return info that has been stored.
#v2.0 - Introducing the Satin Attention system. Because N 1-dimensional vectors in N-vector space is equal to one N-dimensional vector. And while the latter are frequently represented as floating point numbers, the one vector can be represented as a single integer in the N-dimensional idea-space. 
#v1.2 - Vastly improved generation system.
#v1.1 - Added rudiumentary NLP, and a knowledge engine to inspire generation. 

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

[int]$clipcount = 4205 #100%
# $clipcount = 572 #90%
$null = [Reflection.Assembly]::LoadWithPartialName("System.Speech")
$Ext = "gtwt"
$Zip = "zip"
$WS = "gtws"
$Ver = "v1.0"
$Model = "Enkida1"

#endregion

#~<>~<>~<>~<>~<> Setup ~<>~<>~<>~<>~<>

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

#~<>~<>~<>~<>~<> Utility ~<>~<>~<>~<>~<>

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

#~<>~<>~<>~<>~<> Training ~<>~<>~<>~<>~<>

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
	# $clip = Get-Tokenizer $clip 
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
		$end = get-date;
		$time = ($end - $start);
		$formattedTime = get-date -Hour $time.Hours -Minute $time.Minutes -Second $time.Seconds -f T
		write-host "$formattedTime"
	}
	Get-TransferIdeasToWeights
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

#~<>~<>~<>~<>~<> Storage ~<>~<>~<>~<>~<>

Function Save-Weights {
	Param(
		$Name = "Gilgamech",
		$Root = "C:\repos\ToyLanguageModel\"
	)
	[int]$ixct = $($ideaIndex.count) / 1000
	$FullName = "$Name-$($ixct)k-$Ver-$Model"
	$Path = "$Root\$FullName"
	
	mkdir $Path -Force
	$weights | Export-Clixml -Path "$Path\weights.$Ext"
	$pre | Export-Clixml -Path "$Path\pre.$Ext"
	$IdeaIndex | Export-Clixml -Path "$Path\IdeaIndex.$Ext"
	Compress-Archive -LiteralPath "$Path\" -DestinationPath "$Path.zip"
	try {
		Rename-Item -Path "$Path.zip" -NewName "$FullName.$WS" -ErrorAction SilentlyContinue
	} catch {
		Remove-Item "$Path.$WS" -Recurse
		Rename-Item -Path "$Path.zip" -NewName "$FullName.$WS"
	}
	if (Test-Path "$Path.$WS") {
		Remove-Item "$Path\" -Recurse	
	}
}

Function Load-Weights {
	Param(
		$Path
	)
	if (test-path $Path) {
		$Root = split-path $Path
		$Name = (($path -split "\\")[-1] -replace "[.]$WS","")
		$FullName = "$Name-$($ixct)k-$Ver-$Model"
		$ZipPath = $Path -replace $WS,$Zip
		$TempPath = "$Root\TempWeightStorageArea"
		mkdir $TempPath -Force

		Copy-Item -Path "$Path" -Destination "$ZipPath"
		Expand-Archive -DestinationPath "$TempPath\" -Path "$ZipPath" -Force
		Remove-Item "$ZipPath" -Recurse
		sleep 1
		$script:weights = Import-Clixml -Path "$TempPath\$Name\weights.$Ext"
		$script:pre = Import-Clixml -Path "$TempPath\$Name\pre.$Ext"
		$script:IdeaIndex = Import-Clixml -Path "$TempPath\$Name\IdeaIndex.$Ext"
		Remove-Item "$TempPath\" -Recurse
		Ask-Enkida "orange tent" -Display
	}
}

#~<>~<>~<>~<>~<> Answers ~<>~<>~<>~<>~<>

Function Set-Answer {
	Param(
		[string]$WordOne,
		[string]$WordTwo,
		[string]$WordAnswer,
		[int]$Index = (Get-Random -Minimum 1 -Maximum 1GB )
	)
	$IndexOne = 0
	$IndexTwo = 0
	
	$TokenOne = Get-Tokenizer $WordOne
	$TokenTwo = Get-Tokenizer $WordTwo
	$TokenAnswer = Get-Tokenizer $WordAnswer
	
	if (!($pre.($TokenOne))) {$pre.($TokenOne) = @{}}
	if (!($pre.($TokenTwo))) {$pre.($TokenTwo) = @{}}
	if (!($pre.($TokenAnswer))) {$pre.($TokenAnswer) = @{}}

	if (!($weights.($TokenOne))) {$weights.($TokenOne) = @{}}
	if (!($weights.($TokenTwo))) {$weights.($TokenTwo) = @{}}
	if (!($weights.($TokenAnswer))) {$weights.($TokenAnswer) = @{}}

	if (!($ideaindex.($TokenOne))) {
		$ideaindex.($TokenOne) = $Index
	}
	if (!($ideaindex.($TokenTwo))) {
		$ideaindex.($TokenTwo) = $Index
	}
	if ($ideaindex.($TokenAnswer)) {
		# $Index = $ideaindex.($TokenAnswer)
		$ideaindex.($TokenAnswer) = ($ideaindex.($TokenOne) + $ideaindex.($TokenTwo)) / 2
	} else {
		$ideaindex.($TokenAnswer) = ($ideaindex.($TokenOne) + $ideaindex.($TokenTwo)) / 2
	}
	
	$weights.($TokenOne).($TokenTwo) = $Index
	$weights.($TokenTwo).($TokenAnswer) = $Index
	$weights.($TokenAnswer).eos = $Index

	$pre.($TokenAnswer).($TokenTwo) = $Index
	$pre.($TokenTwo).($TokenOne) = $Index
	$pre.($TokenOne).eos = $Index
	
	Ask-Enkida "$WordOne $WordTwo" -Display
}

Function Get-Loudness {
	Param(
		[string]$Prompt
	)
	# $Prompt = Get-Tokenizer $Prompt
	$PromptSplit = $Prompt -split " ";
	$mid = @()
	foreach ($Word in $PromptSplit) {
		# $mid += $Word | Select-Object @{n="Word";e={$_}},@{n="Loudness";e={$IdeaIndex.keys.count / $Weights.($_).keys.count}},@{n="IdeaIndex";e={$IdeaIndex.($_)}} 
		try {
			$WordLoudness = $clipcount / $Weights.($Word).keys.count
			$WordLoudness += $clipcount / $Pre.($Word).keys.count
		} catch {
			$WordLoudness += $clipcount / 1
		}
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
	# $PromptLoudness = Get-Loudness (Get-Tokenizer $Prompt)# | where {$_.RelativeLoudness -gt .2}
	$PromptLoudness = Get-Loudness $Prompt # | where {$_.RelativeLoudness -gt .2}
	
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
			try {
		[int[]]$values = $weights[$word].values
			} catch {
				write-host "values $word"
			}
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

Function Ask-Enkida {
	Param(
		[string]$Prompt,
		$Tokenized = (Get-Tokenizer $Prompt),
		$Start = (Get-Date),
		[switch]$SayPrompt,
		[switch]$SayReponse,
		[switch]$debug,
		[string]$PromptData = (Get-InterPrompt $Tokenized),
		[string[]]$Sentences = ($PromptData -join " " -split "eos"),
		# [string[]]$Sentences = ((Get-Tokenizer  $PromptData) -join " " -split "eos"), 
		$out = @()
	)
	$read = ""
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
	} else {
		$read = Get-Detokenizer ((($out | sort wordscore -Descending)[0].sentence + " eos ") -replace "  "," ")
	}
	$read += "`n($sec)"
	if ($SayReponse) {
		# (($out | sort wordscore -Descending))
		Say-This $Read
	} else {
		$read
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

<# These don't properly escape or otherwise aren't getting weights.
$weights.eos.zzdotzz  = 100
$weights.eos.zzbackslash  = 100
$weights.eos.zztab  = 100
$weights.eos.zzlf  = 100
#>