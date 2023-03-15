
<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfquery datasource="Nba" name="GetIt">
	Update RattleData
	set TenPlusInd = 1
	where BeatSpreadBy >= 10
	 
</cfquery>

<cfquery datasource="Nba" name="GetIt">
	Update RattleData
	set TenPlusInd = -1
	where BeatSpreadBy <= -10
	 
</cfquery>


<cfabort>

<cfquery datasource="Nba" name="GetIt">
	Select  sitf.*
	from RattleData sitf, RattleData situ
	Where len(sitf.InLeadPct) > 0
	and len(situ.InLeadPct) > 0
	and  sitf.gametime = situ.gametime
	and  sitf.fav = situ.fav
	and  (abs(sitf.LastLeadChanges - situ.LastLeadChanges) > 10 or (sitf.LastLeadChanges < 10 and situ.LastLeadChanges >= 20)
	or (situ.LastLeadChanges < 10 and sitf.LastLeadChanges >= 20))
</cfquery>


<cfset loopct = 0>

<cfoutput query="GetIt">
	<cfset loopct = loopct + 1>
	#BeatSpread#,#Gametime#','#Team#','#Fav#','#ha#',#spd#,'#und#',	#LastLeadChanges#<br>
	<cfif loopct is 2>
	<hr>
	<cfset loopct = 0>
	</cfif>
</cfoutput>
	