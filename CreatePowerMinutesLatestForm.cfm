<cftry>



<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>

<cfset yyyy = left(GetRunCt.gametime,4)>
<cfset mm   = mid(GetRunCt.gametime,5,2)>
<cfset dd   = right(GetRunCt.gametime,2)>
<cfset mydate = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET NEXTDAY = #Dateformat(DateAdd("d",-21,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET NEXTDAYSTR = ToString(NEXTDAY)>

<cfset GameTime2 = mydate>
<cfset myGameTime = ToString(GameTime2)>





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
	and gametime > '#NEXTDAYSTR#'
	and gametime < '#mygametime#'
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


<!-- Get the Avg's for the opponent -->
<cfquery  datasource="nba" name="GetFavOppAvg">
	Select 
	   Avg(ps) as ps1,
	   Avg(ofgm) as ofgm1,
	   Avg(ofga) as ofga1,
	   Avg(ofgpct) as ofgpct1,
	   Avg(otpm) as otpm1,
	   Avg(otpa) as otpa1,
	   Avg(otppct) as otppct1,
	   Avg(oftm) as oftm1,
	   Avg(ofta) as ofta1,
	   Avg(oftpct) as ofpct1,
	   Avg(oreb) as oreb1,
	   Avg(oturnovers) as oturnovers1,
	   
	   Avg(dps) as dps1,
	   Avg(dfgm) as dfgm1,
	   Avg(dfga) as dfga1,
	   Avg(dfgpct) as dfgpct1,
	   Avg(dtpm) as dtpm1,
	   Avg(dtpa) as dtpa1,
	   Avg(dtppct) as dtppct1,
	   Avg(dftm) as dftm1,
	   Avg(dfta) as dfta1,
	   Avg(dftpct) as dfpct1,
	   Avg(dreb) as dreb1,
	   Avg(dturnovers) as dturnovers1
	   	   
 	from nbadata
  	where Team = '#GetFavOpp.opp#'
	and gametime > '#NEXTDAYSTR#'
	and gametime < '#mygametime#'
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
	   dturnovers
	   
 	from nbadata
  	where Team = '#fav#'
	and   opp = '#GetFavOpp.opp#'
	and   gametime = '#GetFavOpp.gametime#'
	and gametime > '#NEXTDAYSTR#'
	and gametime < '#mygametime#'
</cfquery>

<cfif GetFavResults.recordcount gt 0 and GetFavOppAvg.recordcount gt 0>

<cfset opowPS    = GetFavResults.PS - GetFavOppAvg.DPS1>
<cfset opowFGM   = GetFavResults.ofgm - GetFavOppAvg.dfgm1>
<cfset opowFGA   = GetFAVResults.ofga - GetFavOppAvg.dfga1>
<cfset opowFGpct = GetFAVResults.ofgpct - GetFavOppAvg.dfgpct1>
<cfset opowTPM   = GetFAVResults.otpm - GetFavOppAvg.dtpm1>
<cfset opowTPA   = GetFAVResults.oTPA - GetFavOppAvg.dTPA1>
<cfset opowTPPCT = GetFAVResults.otppct - GetFavOppAvg.dtppct1>
<cfset opowFTM   = GetFAVResults.oftm - GetFavOppAvg.dftm1>
<cfset opowFTA   = GetFAVResults.ofta - GetFavOppAvg.dfta1>
<cfset opowreb   = GetFAVResults.oreb - GetFavOppAvg.dreb1>
<cfset opowturnovers = GetFavOppAvg.dturnovers1 - GetFAVResults.oturnovers>

<cfset dpowPS    = GetFavOppAvg.PS1 - GetFavResults.dPS  >
<cfset dpowFGM   = GetFavOppAvg.ofgm1 - GetFavResults.dfgm  >
<cfset dpowFGA   = GetFavOppAvg.ofga1 - GetFAVResults.dfga  >
<cfset dpowFGpct = GetFavOppAvg.ofgpct1 - GetFAVResults.dfgpct  >
<cfset dpowTPM   = GetFavOppAvg.otpm1 - GetFAVResults.dtpm  >
<cfset dpowTPA   = GetFavOppAvg.oTPA1 - GetFAVResults.dTPA  >
<cfset dpowTPPCT = GetFavOppAvg.otppct1 - GetFAVResults.dtppct  >
<cfset dpowFTM   = GetFavOppAvg.oftm1 - GetFAVResults.dftm >
<cfset dpowFTA   = GetFavOppAvg.ofta1 - GetFAVResults.dfta  >
<cfset dpowreb   = GetFavOppAvg.oreb1 - GetFAVResults.dreb  >
<cfset dpowturnovers = GetFAVResults.dturnovers - GetFavOppAvg.oturnovers1>

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
	   dturnovers
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
	   #dpowturnovers#


)	   
</cfquery>
</cfif>

</cfloop>

</cfoutput>


<cfquery  datasource="nba" name="Getit">
Select Team,Avg(ps) + Avg(dps) as pow
from power
group by team
order by team
</cfquery>

<cfoutput query="Getit">
#team#,#pow#<br>
</cfoutput>

<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>


<cfquery datasource="nba" name="Getspds">
Select *
from nbaschedule
where GameTime = '#GetRunct.gametime#'
 </cfquery>

 
Recent Form Overall Power<br>
 
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

	
	<cfset mypick = '#pick#'>	
	<cfif rat ge 9.5>
		<cfset mypick = '**#pick#'>	
	</cfif>
	
	<cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
	Set PowRecent = '#myPick#'
	Where Fav = '#Fav#'  
	and GameTime = '#GetRunct.GameTime#'
	</cfquery>





</cfloop>	
<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('CreatePowerMinutesLatestForm.cfm')
</cfquery>

<cfcatch type="any">
  
	<!--- 
<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:CreatePowerMinutesLatestForm.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>
 --->

</cfcatch>

</cftry>
