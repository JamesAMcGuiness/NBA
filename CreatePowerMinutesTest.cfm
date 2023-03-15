<cftry>

<cfif 1 is 1>


<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>



<cfquery  datasource="nba" name="remove">
delete from power
</cfquery>

<cfquery datasource="nba" name="Gettm">
	Select distinct team from nbadata 
</cfquery>

<cfoutput query="GetTm">

<cfset Fav='#GetTm.Team#'>


<!-- Get the opponents of the favorite -->
<cfquery datasource="nba" name="GetFavOpp">
	Select distinct
		d.opp,
		d.gametime,
		d.ha
	from nbadata d
	where Team = '#Fav#'
	and d.gametime < '#GetRunct.Gametime#'
</cfquery>


<cfset TpminforPow = 0>
<cfset FGminforPow = 0>
<cfset FTminforPow = 0>

<cfset TpminGivPow = 0>
<cfset FGminGivPow = 0>
<cfset FTminGivPow = 0>

<cfset TpattforPow = 0>
<cfset FGattforPow = 0>
<cfset FTattforPow = 0>

<cfset TpattGivPow = 0>
<cfset FGattGivPow = 0>
<cfset FTattGivPow = 0>

<cfset TpMadeForPow = 0>
<cfset FGMadeForPow = 0>

<cfset TpMadeGivPow = 0>
<cfset FGMadeGivPow = 0>


<cfset ct = 0>

<cfloop query="GetFavopp">

<cfquery  datasource="nba" name="GetFavOppAvg">
	Select 
	   Avg(ps) as ps1,
	   Avg(ofgm) as ofgm1,
	   
	   
	   Avg(ofga - otpa) as ofga1,
	   
	   
	   Avg ( (ofgm - otpm) / (ofga - otpa))*100 as ofgpct1,
	   
	   Avg(otpm) as otpm1,
	   Avg(otpa) as otpa1,
	   
	   
	   Avg  (otpm / otpa) *100               as oTppct1,
	   
	   Avg(oftm) as oftm1,
	   
	   Avg(ofta) as ofta1,
	   
	   
	   Avg (oftm / ofta)* 100                   as oFpct1,
	   
	   Avg(oreb) as oreb1,
	   Avg(oturnovers) as oturnovers1,
	   Avg(otreb) as OffReb1,
	   Avg(dtreb) as DefReb1,	
	   
	   Avg(dps) as dps1,
	   Avg(dfgm) as dfgm1,
	   
	   
	   Avg(dfga - dtpa) as dfga1,
	   
	   
	   
	   Avg ( (dfgm - dtpm) / (dfga - dtpa))*100 as dfgpct1,
	   
	   
	   Avg(dtpm) as dtpm1,
	   Avg(dtpa) as dtpa1,
	   
	   
	   Avg  (dtpm / dtpa)*100                as dTppct1,
	   
	   Avg(dftm) as dftm1,
	   Avg(dfta) as dfta1,
	   Avg(dftpct) as dfpct1,
	   Avg(dreb) as dreb1,
	   Avg(dturnovers) as dturnovers1
	   	   
 	from nbadata
  	where Team = '#GetFavOpp.opp#'
	and gametime < '#GetRunct.Gametime#'
</cfquery>

<!-- See how favorite did versus the averages -->
<cfquery  datasource="nba" name="GetFavResults">
	Select 
	   ps,
	   ofgm,
	   ofga,
	   ofgpct,
	   otpm,
	   otpa,
	   otppct,
	   oftm,
	   ofta,
	   oreb,
	   oturnovers,
	   
	   dps,
	   dfgm,
	   dfga,
	   dfgpct,
	   dtpm,
	   dtpa,
	   dtppct,
	   dftm,
	   dfta,
	   dreb,
	   dturnovers,
		otreb as Offreb,
	   dtreb as DefReb	
	   
 	from nbadata
  	where Team = '#fav#'
	and   opp = '#GetFavOpp.opp#'
	and   gametime = '#GetFavOpp.gametime#'
		and gametime < '#GetRunct.Gametime#'
</cfquery>


<cfset opowPS    = GetFavResults.PS - GetFavOppAvg.DPS1>
<cfset opowFGM   = GetFavResults.ofgm - GetFavOppAvg.dfgm1>
<cfset opowFGA   = (GetFAVResults.ofga - GetFAVResults.otpa ) - GetFavOppAvg.dfga1>
<cfset opowFGpct = GetFAVResults.ofgpct - GetFavOppAvg.dfgpct1>
<cfset opowTPM   = GetFAVResults.otpm - GetFavOppAvg.dtpm1>
<cfset opowTPA   = GetFAVResults.oTPA - GetFavOppAvg.dTPA1>
<cfset opowTPPCT = GetFAVResults.otppct - GetFavOppAvg.dtppct1>
<cfset opowFTM   = GetFAVResults.oftm - GetFavOppAvg.dftm1>
<cfset opowFTA   = GetFAVResults.ofta - GetFavOppAvg.dfta1>
<cfset opowreb   = GetFAVResults.oreb - GetFavOppAvg.dreb1>
<cfset opowturnovers = GetFavOppAvg.dturnovers1 - GetFAVResults.oturnovers>
<cfset opowReb    = GetFAVResults.OffReb - GetFavOppAvg.DefReb1>

<cfset dpowPS    = GetFavOppAvg.PS1 - GetFavResults.dPS  >
<cfset dpowFGM   = GetFavOppAvg.ofgm1 - GetFavResults.dfgm  >
<cfset dpowFGA   = (GetFavOppAvg.ofga1) - (GetFAVResults.ofga - GetFAVResults.otpa )  >
<cfset dpowFGpct = GetFavOppAvg.ofgpct1 - GetFAVResults.dfgpct>
<cfset dpowTPM   = GetFavOppAvg.otpm1 - GetFAVResults.dtpm  >
<cfset dpowTPA   = GetFavOppAvg.oTPA1 - GetFAVResults.dTPA  >
<cfset dpowTPPCT = GetFavOppAvg.otppct1 - GetFAVResults.dtppct  >
<cfset dpowFTM   = GetFavOppAvg.oftm1 - GetFAVResults.dftm >
<cfset dpowFTA   = GetFavOppAvg.ofta1 - GetFAVResults.dfta  >
<cfset dpowreb   = GetFavOppAvg.oreb1 - GetFAVResults.dreb  >
<cfset dpowturnovers = GetFAVResults.dturnovers - GetFavOppAvg.oturnovers1>
<cfset dpowReb    = GetFavOppAvg.OffReb1 - GetFAVResults.DefReb>

<cfoutput>
Checking:<br>
#GetFavOppAvg.ofga1# - #GetFAVOppAvg.otpa1# - #GetFAVResults.ofga# - #GetFAVResults.otpa#<br>

#GetFavOppAvg.ofga1 - GetFAVOppAvg.otpa1# vs #GetFAVResults.ofga - GetFAVResults.otpa#<br>
</cfoutput>

<cfquery  datasource="nba" name="GetFavResults">
Insert into Power
	   (Team,
	   Opp,
	   ha,
	   gametime,
	   ps,
	   ofgm,
	   ofga,
	   ofgpct,
	   otpm,
	   otpa,
	   otppct,
	   oftm,
	   ofta,
	   oreb,
	   oturnovers,
	   
	   dps,
	   dfgm,
	   dfga,
	   dfgpct,
	   dtpm,
	   dtpa,
	   dtppct,
	   dftm,
	   dfta,
	   dreb,
	   dturnovers,
	   OffReb,
	   DefReb
	   )
values
(
'#fav#',
'#GetFavOpp.opp#',
'#GetFavOpp.ha#',
'#GetFavOpp.gametime#',
	   #opowps#,
	   #opowfgm#,
	   #opowfga#,
	   #opowfgpct#,
	   #opowtpm#,
	   #opowtpa#,
	   #opowtppct#,
	   #opowftm#,
	   #opowfta#,
	   #opowreb#,
	   #opowturnovers#,
	   
	   #dpowps#,
	   #dpowfgm#,
	   #dpowfga#,
	   #dpowfgpct#,
	   #dpowtpm#,
	   #dpowtpa#,
	   #dpowtppct#,
	   #dpowftm#,
	   #dpowfta#,
	   #dpowreb#,
	   #dpowturnovers#,
	   #opowreb#,
	   #dpowreb#

)	   
</cfquery>

</cfloop>

</cfoutput>

<cfquery  datasource="nba" name="Getit">
Select Team,Avg(ps) + Avg(dps) as pow
from power
group by team
order by Avg(ps) + Avg(dps) desc
</cfquery>

<cfoutput query="Getit">
#team#,#pow#<br>
</cfoutput>


</cfif>


<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>


<cfquery datasource="nba" name="Getspds">
Select *
from nbaschedule
where GameTime = '#GetRunct.gametime#'
 </cfquery>

 
 Overall Power<br>
 
<cfset gamect = 0>
<cfloop query="GetSpds">

	<cfset PredFav = 0>
	<cfset PredUnd = 0>

	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset spd           = #GetSpds.spd#>

	<cfquery  datasource="nba" name="GetFav">
	Select Avg(ps + dps) as pow
	from power
	where team = '#fav#'
	</cfquery>
	
	<cfquery  datasource="nba" name="GetUnd">
	Select  Avg(ps + dps) as pow
	from power
	where team = '#und#'
	</cfquery>

	<cfoutput>
	-----------------------------------------------------------------<br>
	Looking for #fav# vs #und#<br>
	-----------------------------------------------------------------<br>
	</cfoutput>
	
	<cfif ha is 'H' >
		<cfset PredFav = 3 + GetFav.Pow>
	<cfelse>
		<cfset PredUnd = 3 + GetUnd.Pow>
	</cfif>
	
	<cfif PredFav - PredUnd gt spd>
		<cfset pick = '#fav#'>
		<cfset rat  = (PredFav - PredUnd) - spd>
	<cfelse>
	
		<cfif PredFav - PredUnd gt 0>
			<cfset pick = '#und#'>
			<cfset rat = spd - (PredFav - PredUnd)>
			
		<cfelse>
			<cfset pick = '#und#'>
			<cfset rat = spd + (predund - PredFav)>	
		</cfif>	
	
	</cfif>
	<cfoutput>
	Our pick is #pick# with rating of #rat#<br>
	</cfoutput>


	<!---  
	<cfquery datasource="NBAPicks" name="AddPicks">
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
	'#mygametime#',
	'#fav#',
	'#ha#',
	#spd#,
	'#und#',
	'#oudesc#',
	#pctbig#,
	'GameSimSide',
	0,
	'',
	0,
	0,
	0
	)
	</cfquery>
	--->	

	<cfset mypick = '#pick#'>	
	<cfif rat ge 9.5>
			<cfset mypick = '**#pick#'>	
	</cfif>

	
	<cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
	Set PowYTD = '#myPick#'
	Where Fav = '#Fav#'  
	and GameTime = '#GetRunct.gametime#'
	</cfquery>
	
	
</cfloop>	
	
<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:CreatePowerMinutes.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>
