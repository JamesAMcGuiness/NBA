<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>

<cfset yyyy = left(GetRunCt.gametime,4)>
<cfset mm   = mid(GetRunCt.gametime,5,2)>
<cfset dd   = right(GetRunCt.gametime,2)>
<cfset mydate = #Dateformat(DateAdd("d",1,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<cfset myrunct = GetRunCt.Runct>


<cfquery datasource="NbaPicks" name="DelGaps">
Delete
from nbapicks 
where Gametime= '#GetRunCt.gametime#' and systemid like 'GAP%'
</cfquery>


<cfinclude  template="GAPScoring.cfm">
<cfinclude template="GAPRebounding.cfm">
<cfinclude template="GAPFTAtt.cfm">
<cfinclude template="GAPFGPct.cfm">

<cfquery datasource="NbaPicks" name="GetAvgGaps">
select 
	Fav,
	Ha,
	Und,
	spd,
	ou,
	avg(ouscore) as aou, 
	avg(favscore) as afav, 
	avg(undscore) as aund
from nbapicks 
where Gametime= '#GetRunCt.gametime#' and systemid like 'GAP%'
group by fav, ha, und, spd, ou
</cfquery>


<cfoutput query="GetAvgGaps">
<cfset predspd = GetAvgGaps.afav - GetAvgGaps.aund> 
<cfset predou  = aou>

<cfif predspd lt #GetAvgGaps.spd# >
	<cfset ourpick = #GetAvgGaps.und#>
	<cfset ourrat  = #GetAvgGaps.spd# - predspd>
</cfif>

<cfif #GetAvgGaps.aund# gt #GetAvgGaps.afav#>
	<cfset ourpick = #GetAvgGaps.und#>
	<cfset ourrat  = #GetAvgGaps.spd# - predspd>
</cfif>

<cfif predspd gt #GetAvgGaps.spd#>
	<cfset ourpick = #GetAvgGaps.fav#>
	<cfset ourrat  = predspd - #GetAvgGaps.spd#>
</cfif>

<cfif aou gt #GetAvgGaps.ou#>
	<cfset ouroupick = 'O'>
	<cfset ourourat = #GetAvgGaps.aou# - #GetAvgGaps.ou#>
</cfif>

<cfif GetAvgGaps.aou lt #GetAvgGaps.ou#>
	<cfset ouroupick = 'U'>
	<cfset ourourat = #GetAvgGaps.ou# - #GetAvgGaps.aou#>
</cfif>


	<cfquery datasource="NBAPicks" name="AddPicks">
	Insert into NBAPicks
	(GameTime,
	Fav,
	Ha,
	Spd,
	Und,
	Pick,
	FavScore,
	UndScore,
	Pct,
	Systemid,
	ou,
	oupick,
	oupct,
	ouscore
	)
	values
	(
	'#GetRunct.gametime#',
	'#GetAvgGaps.fav#',
	'#GetAvgGaps.ha#',
	#GetAvgGaps.spd#,
	'#GetAvgGaps.und#',
	'#ourpick#',
	#Numberformat(GetAvgGaps.afav,'999.99')#,
	#Numberformat(GetAvgGaps.aund,'999.99')#,
	#ourrat#,
	'GAP2a',
	#ou#,
	'#ouroupick#',
	#ourourat#,
	#Numberformat(GetAvgGaps.aou,'999.99')#
	)
	</cfquery>



</cfoutput>

<!--- <cfif myrunct ge 10> --->

	<cfquery datasource="Nba" name="GetRunct">
	Update NbaGameTime
	Set Gametime = '#myDate#',
	RunCt = 0
	</cfquery>
	
<!--- </cfif> --->

</body>
</html>
