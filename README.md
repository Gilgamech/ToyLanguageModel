# Toy Language Model.

A tiny answer system. Expect hallucinations. Eventually meant to be similar to an AI LLM. 

## Directions:
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