
<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfquery datasource="Nba" name="GetIt">
	Select distinct sched.Gametime,sched.Fav,sched.ha,sched.spd,sched.und,sched.ou,res.ps,res.dps,sit.*
	from TeamSituation sit, NBASchedule sched, NBAData res
	Where sit.Gametime   = sched.Gametime
	and   res.gametime   = sit.Gametime
	and   (sit.Team = sched.Fav or sit.team = sched.und)
	and   (res.Team = sit.Team)
	and len(InLeadPct) > 0
	order by sched.gametime desc
</cfquery>

<cfoutput query="GetIt">
<cfset cov = 0>
<cfset covby = 0>	
	
<!--- Fav that covered --->	
<cfif ps - dps gt spd>
	<cfif Fav is Team>
		<cfset cov = 1>
		<cfset covby = (ps-dps) - spd>
	</cfif>
</cfif>	
	
<!--- Fav that didnt cover or lost outright --->	
<cfif (ps - dps lt spd) or (ps lt dps)>
	<cfif Fav is Team>
		<cfset cov = 0>
		<cfset covby = -1* (spd - (ps-dps))>
	</cfif>
</cfif>	
	
<!--- Underdog that covered or won straight up --->	
<cfif (dps - ps lt spd) or (ps gt dps)>
	<cfif Und is Team>
		<cfset cov = 1>
		<cfset covby = spd + (ps-dps)>
	</cfif>
</cfif>	
	
<!--- Underdog that didn't covered --->	
<cfif (dps - ps gt spd) >
	<cfif Und is Team>
		<cfset cov = 0>
		<cfset covby =  (spd - (dps-ps)) >
	</cfif>
</cfif>	
	
	
	
<cfset myou = ou>	
<cfif len(ou) is 0>	
	<cfset myou = 0>
</cfif>
	
<cfquery datasource="Nba" name="AddIt">	
	Insert into RattleData
	(
	BeatSpread,
	BeatSpreadBy,
	Gametime,
	Team,
	Fav,
	ha,
	spd,
	und,
	ou,
	ps,
	dps,
	TeamHealth,
	LatestCoverCt,
	LatestNoCoverCt,
	CumSpd,
	LastTwoCumSpd,
	LastTwoCumScore,
	LastTwoDefScore,
	LastTotalPlays,
	LastLeadChanges,
	InLeadPct,
	UpBigPct,
	DownBigPct
	)
	values
	(
	#cov#,
	#covby#,
	'#Gametime#',
	'#Team#',
	'#Fav#',
	'#ha#',
	#spd#,
	'#und#',
	#myou#,
	#ps#,
	#dps#,
	#TeamHealth#,
	#LatestCoverCt#,
	#LatestNoCoverCt#,
	#CumSpd#,
	#LastTwoCumSpd#,
	#LastTwoCumScore#,
	#LastTwoDefScore#,
	#LastTotalPlays#,
	#LastLeadChanges#,
	#InLeadPct#,
	#UpBigPct#,
	#DownBigPct#
	)
</cfquery>	

</cfoutput>
	