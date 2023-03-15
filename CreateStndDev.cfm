
<cftry>

<cfinclude template="CreatePowerMinutes.cfm"> 

<cfquery  datasource="nba" name="Addit">
Delete from Stnddev
</cfquery>

<!-- Create Standard Deviation for PS and DPS power ratings -->
<cfquery  datasource="nba" name="GetTeams">
Select distinct Team from Power
</cfquery>


<cfloop query="GetTeams">

	<cfset psdiff      = 0>
	<cfset dpsdiff     = 0>
	<cfset overalldiff = 0>
	<cfset myteam = GetTeams.Team>

	<cfquery  datasource="nba" name="GetGame">
		Select Ps,dps from Power where team='#myTeam#'
	</cfquery>

	<cfset gamect = 0>
	<cfoutput query="GetGame">
	
		<cfquery  datasource="nba" name="GetAvg">
			Select Avg(Ps) as psPow, Avg(dps) as dpsPow, Avg(ps + dps) as overallPow from Power where team='#myteam#'
		</cfquery>
	
		<!-- For each POWER result -->
		<cfset psdiff      = psdiff +  ((GetGame.ps - GetAvg.psPOW)*(GetGame.ps - GetAvg.psPOW))>	
		<cfset dpsdiff     = dpsdiff + ((GetGame.dps - GetAvg.dpsPOW) *(GetGame.dps - GetAvg.dpsPOW))>	
   		<cfset overalldiff = overalldiff +  ( (GetGame.dps + GetGame.ps - GetAvg.overallPOW) * (GetGame.dps + GetGame.ps - GetAvg.overallPOW) )>	
		<cfset gamect = gamect + 1>
	
		<cfset psPow = GetAvg.PsPow>
		<cfset dpsPow = GetAvg.dPsPow>
		<cfset overall = psPow + dpsPow>
	</cfoutput>
	
	<cfif Gamect -1 gt 0>
	
	<cfset psdiff2 = sqr(psdiff / (gamect - 1))>
	<cfset dpsdiff2 = sqr(dpsdiff / (gamect - 1))>
	<cfset overalldiff2 = sqr(overalldiff / (gamect - 1))>
	<cfset FinalLoScore = 0>
	<cfset FinalHiScore = 0>
	
	<cfset FinalLoDScore = 0>
	<cfset FinalHiDScore = 0>
	
	<cfset FinalHiPow = 0>
	<cfset FinalLoPow = 0>
	
	<cfset FinalLoScore = pspow - psdiff2>
	<cfset FinalHiScore = pspow + psdiff2>
	
	<cfset FinalLoDScore = dpspow - dpsdiff2>
	<cfset FinalHiDScore = dpspow + dpsdiff2>
	
	<cfset FinalHiPow = overall + overalldiff2>
	<cfset FinalLoPow = overall - overalldiff2>
	
	
	
	<cfoutput>
	#myteam#<br>
	Hi score = #FinalHiScore#<br>
	Lo score = #FinalLoScore#<br>
	Final Hi = #FinalHiPow#<br>
	Final Lo = #FinalLoPow#<br>
	<hr>
	</cfoutput>


<cfquery  datasource="nba" name="Addit">
Insert into StndDev
	   (Team,
	   HiScore,
	   LoScore,
	   HiPower,
	   LoPower,
	   HiDefScore,
	   LoDefScore,
	   OverallScore
)
values
(
'#myteam#',
#FinalHiScore#,
#FinalLoScore#,
#FinalHiPow#,
#FinalLoPow#,
#FinalHiDScore#,
#FinalLoDscore#,
#(FinalHiScore + FinalLoScore) - (FinalHiDscore + FinalLoDscore)# 
)
</cfquery>
</cfif>	
</cfloop>


<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>


<cfquery datasource="nba" name="Getspds">
Select *
from nbaschedule
where GameTime = '#GetRunct.gametime#'
</cfquery>

<cfloop query="GetSpds">

	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>

	<cfquery  datasource="nba" name="GetFav">
	Select * from StndDev where team = '#fav#' 
	</cfquery> 	
	<cfquery  datasource="nba" name="GetUnd">
	Select * from StndDev where team = '#und#' 
	</cfquery> 	

	<cfif GetFav.LoScore neq '' and Getfav.HiScore neq '' and GetUnd.LoScore neq '' and GetUnd.HiScore neq ''  >
	<cfoutput>
	#fav#,#Getfav.HiScore#,#GetFav.LoScore#,#Getfav.HiScore + GetFav.LoScore#<br>
	#und#,#Getund.HiScore#,#GetUnd.LoScore#,#GetUnd.HiScore + GetUnd.LoScore#<br>
	
	<cfif Getfav.HiScore + GetFav.LoScore + GetUnd.HiScore + GetUnd.LoScore gt 0>
		Play OVER with rating of #Getfav.HiScore + GetFav.LoScore + GetUnd.HiScore + GetUnd.LoScore#.....OverallScoring:#GetFav.OverallScore + GetUnd.OverallScore# 
		<cfset oudesc = 'OVER'>
	<cfelse>
		Play UNDER with rating of #Getfav.HiScore + GetFav.LoScore + GetUnd.HiScore + GetUnd.LoScore#...OverallScoring:#GetFav.OverallScore + GetUnd.OverallScore# 
		<cfset oudesc = 'UNDER'>
	</cfif>
	
	<hr>
	
	<cfif abs(Getfav.HiScore + GetFav.LoScore + GetUnd.HiScore + GetUnd.LoScore) ge 15>
	
	<cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
	Set PowScore15Plus = '#oudesc#'
	Where Fav = '#Fav#'
	and GameTime = '#GetRunct.gametime#'
	</cfquery>
	
	</cfif>
	
		
	<cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
	Set PowOffDef = '#oudesc#',
	PowOffDefRat = #GetFav.OverallScore + GetUnd.OverallScore#,
	FavPowRat = #GetFav.OverallScore#,
	UndPowRat = #GetUnd.OverallScore#
	Where Fav = '#Fav#'
	and GameTime = '#GetRunct.gametime#'
	</cfquery>
		
	<cfquery datasource="NBA" name="AddPicks">
	Insert into NBAPicks
	(GameTime,
	Fav,
	Ha,
	Spd,
	Und,
	Pick,
	Pct,
	Systemid,
	ou,
	oupick,
	oupct,
	pctwonside,
	pctwontot
	)
	values
	(
	'#GetRunct.gametime#',
	'#fav#',
	'#ha#',
	#spd#,
	'#und#',
	'#oudesc#',
	#Getfav.HiScore + GetFav.LoScore + GetUnd.HiScore + GetUnd.LoScore#,
	'PowerTotals',
	0,
	'',
	0,
	0,
	0
	)
	</cfquery>

	
	
	
	</cfoutput>
</cfif>	
</cfloop>	



<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:CreateStndDev.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>


