#Copyright 2026 Gilgamech Technologies
#Author: Stephen Gillie
#Created 5/15/2026
#Updated 9/01/2026
#Notes:
#v3.0 - Adding the Index Inference system. Can answer questions about the corpus, confirming verifiable information while refuting unverifiable information.  
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
 if (!($iix)) {$iix = @()}

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
		[string[]]$Keys= $weights.keys
		for ($i=0; $i  -lt $Keys.count; $i++) {
			$iix += "" | select @{n = "key"; e = {$Keys[$i]}},@{n = "value"; e = {$IdeaIndex.($Keys[$i])}} 
		}
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

	$Length = ($clip.length -2)
	$Unique = $clip | Sort-Object -Unique
	$UniqueLength = ($Unique.length -2)
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
				$Significance = $clipcount / $Weights.($currentItem).keys.count
				$Significance += $clipcount / $Pre.($currentItem).keys.count
			} catch {
				# write-host "pre $currentItem $($Weights.($currentItem).keys.count)"
				$Significance = .1
			}
			
				try {
			if ($IdeaIndex.($currentItem) -lt $IdeaIndex.($next)) {
				# $IdeaIndex.($currentItem) += $Strain * (Get-Significance $currentItem).RelativeSignificance
				# $IdeaIndex.($currentItem) +=  $ClipStrain / $Weights.($currentItem).keys.count
					[int]$IdeaIndex.($currentItem) +=  ($Strain / $Significance)
					# [int]$IdeaIndex.($currentItem) +=  $Strain
				# $IdeaIndex.($next) -= $Strain
			} elseif ($IdeaIndex.($currentItem) -gt $IdeaIndex.($next)) {
				# $IdeaIndex.($currentItem) -= $Strain * (Get-Significance $currentItem).RelativeSignificance
				# $IdeaIndex.($currentItem) -= $ClipStrain / $Weights.($currentItem).keys.count
					# [int]$IdeaIndex.($currentItem) -=  $Strain
					[int]$IdeaIndex.($currentItem) -=  ($Strain / $Significance)
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
			$next = $clip[$i+1]; # * $Significance
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
		$Significance = [math]::round($clipcount / $Weights.($iw).keys.count,0)
		$Significance += [math]::round($clipcount / $Pre.($iw).keys.count,0)
		Write-Host "$iw ($Significance) - " -foregroundcolor $mid.($iw).PSColor -nonewline
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
	$o = 0;
	[string[]]$Keys = $Weights.keys;
	foreach ($key in $Keys) {
		$n++
		[string[]]$subkeys = $weights[$key].keys
		foreach ($subkey in $subkeys) {
			$o++
			[string[]]$thirdkeys = $weights[$key][$Subkey].keys
			foreach ($thirdkey in $thirdkeys) {
				$weights.$key.$subkey.$thirdkey = $IdeaIndex.$thirdkey
				$pct = $n/$keys.count*100
				write-progress -Activity "copy $pct % complete" -PercentComplete $pct -CurrentOperation "copy $subkey $o of key $key $n"
			}#end foreach thirdkey	
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
	$w2 | Export-Clixml -Path "$Path\w2.$Ext"
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
		$script:w2 = Import-Clixml -Path "$TempPath\$Name\w2.$Ext"
		$script:pre = Import-Clixml -Path "$TempPath\$Name\pre.$Ext"
		$script:IdeaIndex = Import-Clixml -Path "$TempPath\$Name\IdeaIndex.$Ext"
		Remove-Item "$TempPath\" -Recurse
		Get-Enkida1 "orange tent" -Display
	}
}

#~<>~<>~<>~<>~<> Attention ~<>~<>~<>~<>~<>

Function Get-Significance {
	Param(
		[string]$Prompt
	)
	# $Prompt = Get-Tokenizer $Prompt
	$PromptSplit = $Prompt -split " ";
	$mid = @()
	foreach ($Word in $PromptSplit) {
		# $mid += $Word | Select-Object @{n="Word";e={$_}},@{n="Significance";e={$IdeaIndex.keys.count / $Weights.($_).keys.count}},@{n="IdeaIndex";e={$IdeaIndex.($_)}} 
		try {
			$WordSignificance = $clipcount / $Weights.($Word).keys.count
			$WordSignificance += $clipcount / $Pre.($Word).keys.count
		} catch {
			$WordSignificance += $clipcount / 1
		}
		$mid += $Word | Select-Object @{n="Word";e={$_}},@{n="Significance";e={$WordSignificance}},@{n="IdeaIndex";e={$IdeaIndex.($_)}}#,@{n="Weight";e={$Weights.($_)}} 
	}
	$ml = ($mid.Significance | Measure-Object -sum).sum;
	# $ml = 1; #Might give better results.

	$out = $mid| select Word, @{n="RelativeSignificance";e={$_.Significance / $ml}}, IdeaIndex | sort RelativeSignificance -Descending
	return $out
}

Function Get-Relevance {
	Param(
		[string]$Sentence,
		[string]$Prompt,
		[switch]$Display
	)
	# $PromptSignificance = Get-Significance (Get-Tokenizer $Prompt)# | where {$_.RelativeSignificance -gt .2}
	$PromptSignificance = Get-Significance $Prompt # | where {$_.RelativeSignificance -gt .2}
	
	# $Significance = $Significance | where {$_.RelativeSignificance -gt .01}  
	$Significance = Get-Significance ($Sentence -split " "| sort -Unique) 
	$n = 0
	foreach ($PSIX in $PromptSignificance) {
		$Significance = $Significance | select *, @{n="$($PSIX.word)";e={[math]::abs($_.IdeaIndex - $PSIX.IdeaIndex)}} 
	}
	[int]$score = 1000000000
	foreach ($PSIX in $PromptSignificance) {
		$min = ($Significance.("$($PSIX.word)") | Measure-Object -Minimum).Minimum #/ ($Sentence -split " ").count
		if ($Display) {write-host "$($PSIX.word) - $min"}

		if ($min -eq 0) {
			$zeroes += $PSIX.RelativeSignificance
		} else {
			if ($min -lt $score) {
				$score = $min
			}
		}
	}
	Return $score / $zeroes
}

Function Get-PredictWord {
	Param(
		$WordOne,
		$WordTwo,
		$TargetWord = $WordOne,
		$ix = ($IdeaIndex[$TargetWord]),
		[switch]$Debug,
		[switch]$Display
	); #end Param
	if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) $WordOne $WordTwo $TargetWord"}
		try {
	[string[]]$keys = $weights[$WordOne][$WordTwo].keys;
	[string[]]$k2 = $w2[$WordOne][$WordTwo].keys;
		if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) Keys: $keys "}
	[int[]]$values = $weights[$WordOne][$WordTwo].values
	[int[]]$v2 = $w2[$WordOne][$WordTwo].values
		if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) values: $values "}
		} catch {
			# write-host "keys or values $WordOne $WordTwo"
		}

	[array]$out=$null;
	[string]$StringOut = ""
	$newdist = 10000000000;
	$OldLikelihood = 10000000000
	for ($k = 0 ; $k -lt $keys.count ; $k++) { 
		$key = $keys[$k]
		[int]$value = $values[$k]
		if ($Debug) { Write-Host "$($MyInvocation.MyCommand.Name) Selected key: $key - value: $value - " -nonewline}
		$Repeats = ($Sentence | select-string $key -AllMatches).Matches.count  + 1
		$dist = [math]::abs($value - $ix)
		try {
			$Significance = 1 / $Weights.($key).keys.count
			$Significance += 1 / $Pre.($key).keys.count
		} catch {
			$Significance = .05
		}
		# $Significance = 1 / $Significance
		#L = Dist * Sig * R / I
		try {
			$Instances = $v2[$k]
			$Likelihood = $dist * $Significance * $Repeats / $Instances
		} catch {
			# write-host "$Likelihood = $dist * $Significance * $Repeats / $Instances"
		}
		#Likelihood is inverted, so closer to 0 is more likely.
		#Distance scales with Likelihood.
		#Significance scales with Likelihood - more Significant words should be more tightly-coupled to the idea than less-Significant ones.
		#Repeats scales with Likelihood.
		#Instances scales inversely with Likelihood. Because Likelihood is inverted. So a higher Instance would give lower Likelihood.
		if ($Display) {
			$mid = "" | select @{n="Word";e={$key}}, @{n="Likelihood";e={$Likelihood}}
			$out += $mid
		} else {
			if ($Likelihood -lt $OldLikelihood) {
				$OldLikelihood = $Likelihood
				$StringOut = $key
			}
		}
		if ($Debug) { Write-Host "Likelihood: $Likelihood"}
		if ($Debug) { Write-Host "L = Dist * Sig * R / I: $Likelihood = $dist * $Significance * $Repeats / $Instances"}
	};
	if ($Display) {
		$sum = ($out.Likelihood | Measure-Object -Sum).sum
		$out | %{$_.Likelihood = $_.Likelihood / $sum}
		return $out
	} else {
		return $StringOut;
	}
}; #end Function

Function Get-PredictSentence { 
	Param(
		$WordOne,
		$WordTwo = ($w2.($WordOne).keys | get-random),
		$TargetWord = $WordOne,
		$MaxLength = 25,
		$Start = (Get-Date),
		[switch]$Debug,
		[switch]$Display
	)
	
	$n = 0
	$sentence = "$WordOne $WordTwo ";
	while ($sentence -notmatch "eos") {
		$n++
		$newword = Get-PredictWord -WordOne $WordOne -WordTwo $WordTwo -TargetWord $TargetWord
		$WordOne = $WordTwo
		$WordTwo = $newword
		$sentence += "$newword "
		if ($n -gt $MaxLength) {
			$sentence += " eos "
			# Return $Sentence
		}
	};
	Return $Sentence
}

Function Get-InterPrompt {
	Param(
		$Prompt,
		[switch]$Display
	)
	$Prompt = "$Prompt eos"
	# $prompt = Get-Tokenizer $prompt
	# $weightlist = @()
	[string[]]$Sentences = @()
	[string[]]$PromptSplit = $Prompt -split " "
	$PromptSignificance = Get-Significance $Prompt
	if ($Display) {write-host $PromptSignificance}
	
	$UnknownIdeas = $PromptSignificance | where {$null -match $_.IdeaIndex}
	if ($UnknownIdeas) {
		$IdkJoin = $UnknownIdeas.word -join " "
		$Sentences += "I don't know about $IdkJoin eos "
	} else {
		# $PromptSignificance = $PromptSignificance[0..(($weightlist.count /2)-1)]
		for ($p = 0 ; $p -lt ($PromptSplit.length) ; $p++) {
			for ($q = 0 ; $q -lt ($PromptSplit.length) ; $q++) {
				if ($weights.($PromptSplit[$p]).($PromptSplit[$q])) {
					foreach ($TargetWord in $PromptSignificance.Word) {
						$Sentence = Get-PredictSentence -WordOne $PromptSplit[$p] -WordTwo $PromptSplit[$q] -TargetWord $TargetWord
						if ($Display) {write-host ($PromptSplit[$p] + " " + $PromptSplit[$q] + " - " + $TargetWord  + " - " + $Sentence)}
						$Sentences += $Sentence
						# Get-PredictSatinWord -weightOne $PromptSplit[$p] -weightTwo $PromptSplit[$q] -ix $_
					} # end foreach TargetWord
				} else {
					if ($Display) {write-host ("miss: " + $PromptSplit[$p] + " " + $PromptSplit[$q] + " - " + $TargetWord  + " - " + $weights.($PromptSplit[$p]).($PromptSplit[$q]))}
				} # end if weights
			} # end if q
		} # end if p
	} # end if UnknownIdeas
	$Sentences = ($Sentences | select -unique) #-join " "
	Return $Sentences
}

#~<>~<>~<>~<>~<> Inference ~<>~<>~<>~<>~<>

Function Get-IdeaIndexLookup {
	Param(
		[string]$TargetWord,
		[int]$Range = 1000
	)
		$iix | where {$_.value -gt ($IdeaIndex.$TargetWord - $Range)} | where {$_.value -lt ($IdeaIndex.$TargetWord + $Range)}
}

Function Get-SentenceFromSequence {
	Param(
		[string[]]$Sequence
	)
	$out = @()
	if ($Sequence) {
		$FirstSeq = $Sequence[0] -split " "
		for ($n = 1;$n -lt $Sequence.count; $n++) {
			$SecondSeq = $Sequence[$n] -split " "
			if (($FirstSeq[-2] -eq $SecondSeq[0]) -and ($FirstSeq[-1] -eq $SecondSeq[1])) {
				$FirstSeq = ($FirstSeq + $SecondSeq | select -Unique)
			} else {
				$out += $FirstSeq -join " "
				$FirstSeq = $Sequence[$n+0] -split " "
			}
		}
		$out += $FirstSeq -join " "
		Return $out
	}
}

Function Get-SequenceProbability {
	Param(
		$Prompt
	)
	$PromptSplit = $Prompt -split " ";
	$out = @();
	foreach ($n in (0..($PromptSplit.count -3))) {
		[int]$a = 0
		[int]$b = 0
		try {
			$a =$w2.($PromptSplit[$n]).($PromptSplit[$n+1]).($PromptSplit[$n+2])
			$b =$pre.($PromptSplit[$n+2]).($PromptSplit[$n+1]).($PromptSplit[$n])
		} catch {
		}
		[int]$Incidence = [math]::sqrt($a * $b) # These should always match, so should be replaced with an error message. 
		$out += "" | select @{n="Incidence";e={$Incidence}}, @{n="Sequence";e={"$($PromptSplit[$n]) $($PromptSplit[$n+1]) $($PromptSplit[$n+2])"}}
	};
	$out2 = @();
	[string[]]$trueSeq = Get-SentenceFromSequence ($out | where {$_.Incidence -gt 0}).Sequence
	foreach ($seq in $trueSeq) {
	[double]$Significance = 0
		foreach ($word in ($seq -split " ")) {
			$Significance =+ $w2.($word).keys.count + $pre.($word).keys.count 
		}
		if ($Significance -gt 0) {
			$Significance = 1/$Significance
		}
		$out2 += "" | select @{n="Incidence";e={1}}, @{n="Sequence";e={$seq}}, @{n="Significance";e={$Significance}}
	}
	[string[]]$falseSeq = Get-SentenceFromSequence ($out | where {$_.Incidence -eq 0}).Sequence
	foreach ($seq in $falseSeq) {
	[double]$Significance = 0
		foreach ($word in ($seq -split " ")) {
			$Significance =+ $w2.($word).keys.count + $pre.($word).keys.count 
		}
		if ($Significance -gt 0) {
			$Significance = 1/$Significance
		}
		$out2 += "" | select @{n="Incidence";e={0}}, @{n="Sequence";e={$seq}}, @{n="Significance";e={$Significance}}
	}
	$ml = ($out2.Significance | Measure-Object -sum).sum;
	$out2 = $out2| select Incidence, Sequence, @{n="RelativeSignificance";e={$_.Significance / $ml}}
	$out2 = $out2| select *, @{n="AdjProb";e={$_.incidence * $_.RelativeSignificance}} 
		Return $out2
}

Function Ask-Enkida {
	Param(
		$Prompt = "boring rice while veggies?",
		$Start = (Get-Date)
	)
	$tokenized = (Get-Tokenizer $Prompt);
	[string[]]$out = @()
	$RelatedIdeas = @()
	$SequenceProbability = Get-SequenceProbability $tokenized
	[string[]]$TrueSeq = ($SequenceProbability | where {$_.incidence -eq 1}).sequence
	foreach ($seq in $TrueSeq) {
		$out = $out + $seq + " EOS " 
		($seq -split " ") | %{
				$RelatedIdeas += ((Get-IdeaIndexLookup $_ 10).key + " eos") -split " " 
		}
	}
	$RelatedIdeas = $RelatedIdeas| where {$_} | select -unique
	$FalseSeq = ($SequenceProbability | where {$_.incidence -ne 1}).sequence 
	foreach ($seq in $FalseSeq) {
		$out += Get-Enkida1 $seq
		$s2 = $seq -split " "
		for ($n = 0;$n -lt $s2.length; $n++) {
			try {
				$out += get-predictSentence $s2[$n] $s2[$n+1] $idea
			} catch {}
		}
			# foreach ($Idea in $RelatedIdeas) {
			# $n++
			# $count = ($FalseSeq -split " ").count + ($RelatedIdeas -split " ").count
			# $pct = $n / $count * 100
			# # Write-host "$seq -> $idea -> $n of $count"
			# Write-Progress -Activity "Thinking" -Status "$seq -> $idea -> $n of $count" -PercentComplete $pct 
			# # $out += Get-Enkida1 ($seq + " $Idea")
		# }
	}
	$out = $out -join " " 
	$out = (get-detokenizer $out)
	$end = get-date
	$sec = ((get-date $end) - (get-date $start)).TotalSeconds
	$out += "`n($sec)"
	Return $out
}

Function Get-Enkida1 {
	Param(
		[string]$Prompt,
		[int]$Depth = 3,
		[int]$SentenceLength = 3,
		$Tokenized = (Get-Tokenizer $Prompt),
		[switch]$SayPrompt,
		[switch]$SayReponse,
		[switch]$debug,
		[string[]]$Sentences = (Get-InterPrompt $Tokenized | where {($_ -split " ").count -gt $SentenceLength}),
		$out = @()
	)
	$read = ""
	#Return the sentence with the highest word score.
		#Need to emit "IDK"
	foreach ($Sentence in $Sentences) {
		if ($Sentence) {
			$Relevance = "" | Select-Object @{n="Relevance";e={Get-Relevance $Sentence $Prompt}},@{n="Sentence";e={$Sentence}};
			$out+=$Relevance
		}
	}
	if ($SayPrompt) {
		Say-This $Prompt
	}
	if ($debug) {
		$read = ($out | where {$_.Relevance} | sort Relevance)
	} else {
		try {
			$read = (Get-Detokenizer ($out | where {$_.Relevance} | sort Relevance)[0..$Depth].sentence)  -join " "  -replace "  "," "
		} catch {}
		# $read = Get-Detokenizer ((($out | sort Relevance -Descending)[0].sentence + " eos "))
		# $read |%	{$_ = "this" + $_.substring(0,1).ToUpper() + $_;write-host "$_"}
		# $read = $read.substring(0,1).ToUpper() + $out.substring(1,$out.length-1)
	}
	if ($SayReponse) {
		# (($out | sort Relevance -Descending))
		Say-This $Read
	} else {
		$read
	}
}

#~<>~<>~<>~<>~<> Utility ~<>~<>~<>~<>~<>

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
	
	Get-Enkida1 "$WordOne $WordTwo" -Display
}

<#
Take prompt and map against corups, then use significance and distance to reduce back to relevance.
#>
