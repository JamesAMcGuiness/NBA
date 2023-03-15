<cfif 1 is 1>

<cftry>

<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>

<cfquery datasource="Nba" name="Addit">
	Delete from TeamSituation where Gametime = '#Gametime#'
</cfquery>

<!--- Get all the Teams that are playing this gametime --->
<cfquery datasource="Nba" name="Getit">
	Select Distinct Team
	from NBAData
	where Team in (Select fav from finalpicks where gametime = '#gametime#')
	or Team in (Select Und from finalpicks where gametime = '#gametime#')
</cfquery>

<cfloop query="Getit">

	<cfoutput>
    Checking this : #Getit.Team#<br>  
	</cfoutput>

	<!--- For each Team  --->
	<cfset done      = false>
	<cfset daysback  = -7>
	<cfset DayOffCt  = 0>
	<cfset health    = 0>
	<cfset roadct    = 0>
	<cfset Covct     = 0>
	<cfset NoCovct   = 0>
	<cfset loopct    = 0>
	<cfset multiplier = 0>
	<cfset CumSpd     = 0> 
	
	
	<cfset Gamect     = 0>
	<cfset CumSpdLasttwo = 0>
	<cfset CumScoreLasttwo    = 0>
	<cfset CumDefScoreLasttwo = 0>
	<cfset PrevCumScoreLasttwo    = 0>
	<cfset PrevCumDefScoreLasttwo = 0>
	<cfset PrevCumSpdLstTwo = 0>
	<cfset pfl2  = 0>
	<cfset dpfl2 = 0>
	<cfset lastdayplayed = ''>
	<cfset ConseqGamesBigLeadCt = 0>
	
	<cfloop condition="not done">
		<cfset yyyy        = left(gametime,4)>
		<cfset mm          = mid(gametime,5,2)>
		<cfset dd          = right(gametime,2)>
		<cfset mydate      = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
		<CFSET DAYcheck    = #Dateformat(DateAdd("d",#daysback#,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
		<CFSET DAYcheckSTR = ToString(DAYCheck)>
		<cfset loopct = loopct + 1>

		<cfif loopct is 1>
			<cfset multiplier = 1 >	
		<cfelseif loopct is 2>
			<cfset multiplier = 1.2 >
		<cfelseif loopct is 3>
			<cfset multiplier = 1.4 >
		<cfelseif loopct is 4>
			<cfset multiplier = 1.6 >
		<cfelseif loopct is 5>
			<cfset multiplier = 2.0 >
		<cfelseif loopct is 6>
			<cfset multiplier = 2.6 >
		<cfelseif loopct is 7>
			<cfset multiplier = 2.8 >
		</cfif>


		<cfoutput>	
		xxxxSee if team played on: #Daycheckstr#<br> 
		</cfoutput>
	
		<!--- See if played  --->
		<cfquery datasource="Nba" name="FoundTeam">
		Select *
		from finalPicks
		where GameTime = '#DAYcheckSTR#'
		and (Fav = '#Getit.Team#' or Und = '#GetIt.Team#') 
		</cfquery>

		<!--- Team found --->
		<cfif FoundTeam.recordcount gt 0>
			
			<cfoutput>
			 This team played on #DayCheckStr#<br>
			</cfoutput> 
			
			<cfset lastdayplayed = '#DayCheckStr#'>
			 
			<cfset TeamWasFav = false>
			<cfif FoundTeam.Fav is '#GetIt.Team#' >
					Team was FAVORITE<br>
				<cfset TeamWasFav = true>
			<cfelse>
				 Team was Underdog<br>
			</cfif>
 			

			<!--- team was FAV --->
			<cfset TeamWasAway = false>
			<cfif TeamWasFav and FoundTeam.ha is 'H'>
				
				 Team was a FAV and HOME...<br>
			<cfelse>
				<cfset TeamWasAway = true>
				
			</cfif>

			<!--- team was UND --->
			<cfif not TeamWasFav and FoundTeam.ha is 'H'>
				<cfset TeamWasAway = true>
				 Team was Away...<br> 
			<cfelse>
				
			</cfif>

			<!--- team was UND --->
			<cfif not TeamWasFav and FoundTeam.ha is 'A'>
				<cfset TeamWasAway = false>
				<!--- Team was a UND and Away...<br> --->
			<cfelse>
				
			</cfif>

			<cfif TeamWasAway>
			
				<cfset Roadct = Roadct + 1>
			
				<cfif RoadCt is 1>
			
					<cfset Health = health - (2*multiplier)>
			
				<cfelseif Roadct is 2>
			
					<cfset Health = health - (3*multiplier)>
					
				<cfelseif Roadct is 3>
			
					<cfset Health = health - (4*multiplier)>
			
				<cfelseif Roadct is 4>
					<cfset Health = health - (5*multiplier)>
				<cfelseif Roadct is 5>
					<cfset Health = health - (6*multiplier)>
					
				</cfif>	
			<cfelse>
				Team was HOME<br>
				<cfset Roadct = 0>
				<cfset Health = Health - (1 *multiplier)>
			</cfif>
			

			<!--- Did team cover and were they on the road? --->
			<cfoutput>
			Checking #FoundTeam.WhoCovered# vs '#FoundTeam.und#' and #TeamWasAway#<br> 
			</cfoutput>
			
			
			<!--- Who won the game and by how much? --->
			<cfquery datasource="Nba" name="WhoWon">
			Select * from NBAData
			Where gametime = '#FoundTeam.GameTime#'
			and Team = '#GetIt.Team#'
			</cfquery>
			
			<cfif WhoWon.Recordcount is 0>
				<cfabort showerror = "No NBAData row found for #FoundTeam.GameTime# and Team: #Getit.Team#">
			</cfif>
			
			
			<cfset spdbeat = 0>
			<cfset Gamect = Gamect + 1>
						
			<!--- Team was favorite --->
			<cfif TeamWasFav>
				 <cfif WhoWon.ps gt WhoWon.dps>
					<cfset spdbeat = (WhoWon.ps - WhoWon.dps) - FoundTeam.spd>
					<cfset pfl2  = Whowon.ps>
					<cfset dpfl2 = Whowon.dps>
				<cfelse>
					<cfset pfl2  = Whowon.ps>
					<cfset dpfl2 = Whowon.dps>
					<cfset spdbeat = -1*((WhoWon.dps - WhoWon.ps) + FoundTeam.spd)>
				</cfif>
			<cfelse>
				<!--- Team was Underdog --->
				<cfif WhoWon.ps gt WhoWon.dps>
					<cfset spdbeat = (WhoWon.ps - WhoWon.dps) + FoundTeam.spd>
				<cfelse>
				
					<cfset spdbeat = FoundTeam.spd - (WhoWon.dps - WhoWon.ps)>
				</cfif>
				<cfset pfl2  = Whowon.ps>
				<cfset dpfl2 = Whowon.dps>
				
			</cfif>
			
			<cfset CumSpd = CumSpd + spdbeat>
			<cfset CumSpdLasttwo      = PrevCumSpdLstTwo + spdbeat>
			<cfset CumScoreLasttwo    = PrevCumScoreLasttwo + pfl2>
			<cfset CumDefScoreLasttwo = PrevCumDefScoreLasttwo + dpfl2>
			
			
			<cfset PrevCumSpdLstTwo       = spdbeat>
			<cfset PrevCumScoreLasttwo    = pfl2>
			<cfset PrevCumDefScoreLasttwo = dpfl2>
			
			
				<cfoutput>
				*** pfl2  = #pfl2#<br>
				*** dpfl2 = #dpfl2#<br>
				****** Last two game ***** and spdbeat was #spdbeat#<br>
				****** CumSpdLastTwo is #CumSpdLasttwo#<br>
				</cfoutput>
			
			
			<cfif  FoundTeam.WhoCovered is '#Getit.Team#'>
					
				<cfset Covct = Covct + 1>
				<cfset NoCovct = 0>
				<cfoutput>
				YES Team covered....and Covct is #Covct#<br>
				</cfoutput>
			
			
			<cfelse>
				<!--- No cover done with this guy...<br> --->
				<cfset Covct = 0>
				<cfset NoCovct = NoCovct + 1>
				
			</cfif>
			
			<cfset DayOffCt = 0> 
			
		<cfelse>
		    <cfset Roadct = 0>
			Had the day off...<br>
			<cfoutput>
			DayOffCt is #DayOffCt#<br>
			</cfoutput>
			<cfset DayOffCt = DayOffCt + 1>
			
			<cfif DayOffCt is 1>
				<cfset Health = Health + 1*(multiplier)>
			<cfelseif DayOffCt is 2>
				<cfset Health = Health + 3*(multiplier)>
			<cfelseif DayOffCt is 3>
				<cfset Health = Health + 5*(multiplier)>
					
			<cfelseif DayOffCt is 4>
				<cfset Health = Health + 6*(multiplier)>
			</cfif>
		
			<cfif DayOffCt gt 4>
				<cfset Health = 5>
			</cfif>
		
		</cfif>
        <cfoutput>
		Current Health is #Health#<br>
		</cfoutput>
		<cfset daysback = daysback + 1>
			<cfif daysback is 0>
				<cfset done = true>
		</cfif>
		<p>
		<p>
	</cfloop>

	<cfquery datasource="Nba" name="Addit">
	Insert into TeamSituation
	(TeamHealth, 
	LatestCoverCt,
	LatestNoCoverCt,
	CumSpd,
	team,
	Gametime,
	LastTwoCumSpd,
	LastTwoCumScore,
	LastTwoDefScore
	)
	values
	(
	#health#,
	#CovCt#,
	#NoCovCt#,
	#CumSpd/gamect#,
	'#Getit.Team#',
	#gametime#,
	#CumSpdLasttwo#,
	#CumScoreLasttwo#,
	#CumDefScoreLasttwo#
	)
	</cfquery>

	<cfoutput>
	The team health for the last week for #Getit.Team# is #health#...Latest Cover Ct is #covct#... Latest No Cover Ct is #nocovct#...CumSpd = #CumSpd/gamect#
	</cfoutput>
	
	<cfif nocovct gte 2 and (CumSpd/gamect) lte -5>
		<p>	
		<cfoutput>
	    ***********************************************<br>
		Situation favoring #Getit.Team# to cover....<br>
	    ***********************************************<br>
	    </cfoutput>
	</cfif>
	
	
	<cfif covct gte 2 and (CumSpd/gamect) gte 5>
		<p>	
		<cfoutput>
	    ***********************************************<br>
		Situation favoring #Getit.Team# to NOT cover....<br>
	    ***********************************************<br>
	    </cfoutput>
	</cfif>
	
	
	
	<cfset theday = lastdayplayed>

	<cfoutput> 
	The last day #Getit.team# played was on #theday#
	</cfoutput>


	<!--- See if team won last time they played... --->
	<cfquery datasource="nba" name="GetLastGameWL">
	Select s.fav,s.und from NBAData d, Nbaschedule s
	Where d.gametime = '#theday#'
	and d.Team = '#Getit.team#'
	and d.ps < d.dps
	and (d.team = s.fav or d.team = s.und)	
	</cfquery>
	
	<!--- 
<cfif GetLastGameWL.recordcount neq 0>
		
		<cfif GetLastGameWL.Fav is '#Getit.Team#'>
		
			<cfquery datasource="nba" name="GetLastGameWL">
			Update FinalPicks
			Set LostLastGameFav = 'Y'
			Where gametime = '#gametime#'
			and Fav = '#Getit.team#'
			</cfquery>
			
		</cfif>	
		
		<cfif GetLastGameWL.Und is '#Getit.Team#'>
		
			<cfquery datasource="nba" name="GetLastGameWL">
			Update FinalPicks
			Set LostLastGameUnd = 'Y'
			Where gametime = '#gametime#'
			and Und = '#Getit.team#'
			</cfquery>
			
		</cfif>	
	
			
	</cfif>
 --->

<cfif 1 is 2>

		


<cfquery datasource="nba" name="GetGames">
Select * 
from NBASchedule
where gametime='#theday#'
and (Fav ='#Getit.team#' or Und = '#Getit.team#') 
</cfquery>

<cfset theawayteam = '#Getgames.fav#'>
<cfset thehometeam = '#Getgames.und#'>

<cfquery datasource="nba" name="GetLeadChanges">
Select Sum(LeadChange) as lc
from NBADrivecharts
Where Team in('#theawayteam#','#thehometeam#')
and OffDef='O'
and gametime = '#theday#'
and result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS','FREETHROWMADE','FREETHROWMISSED')
</cfquery>

<!--- See what percent of the time Home team was in the lead --->
<cfquery datasource="nba" name="HGetTotPlays">
Select count(*) as totplays
from NBADrivecharts dch 
Where dch.Team = '#thehometeam#'
and dch.OffDef = 'O'
and dch.gametime = '#theday#'
and dch.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>


<cfif HGetTotPlays.totplays is 0>

	
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='We dont have NBAdrivecharts data for #thehometeam# for gametime #theday#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:LastSevenHealth.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

	<cfabort showerror="We dont have NBAdrivecharts data for #thehometeam# for gametime #theday#">

</cfif>

<cfquery datasource="nba" name="AGetTotPlays">
Select count(*) as totplays
from NBADrivecharts dca 
Where dca.Team = '#theawayteam#'
and dca.OffDef = 'O'
and dca.gametime = '#theday#'
and dca.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>

<cfset totplays = HGettotplays.totplays + aGettotplays.totplays>

<cfquery datasource="nba" name="aGetLeadPcts">
Select Sum(dca.Haslead)/#totplays# as hasleadpct
from NBADrivecharts dca 
Where dca.Team = '#theawayteam#'
and dca.OffDef = 'O'
and dca.gametime = '#theday#'
and dca.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>

<cfquery datasource="nba" name="hGetLeadPcts">
Select Sum(dch.Haslead)/#totplays# as hasleadpct
from NBADrivecharts dch 
Where dch.Team = '#thehometeam#'
and dch.OffDef = 'O'
and dch.gametime = '#theday#'
and dch.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>


<!--- See how may times HUGE leads a  --->
<cfquery datasource="nba" name="aUpBigPct">
Select Sum(dca.UpBig)/#totplays# as hasBIGleadpct
from NBADrivecharts dca 
Where dca.Team = '#theawayteam#'
and dca.OffDef = 'O'
and dca.gametime = '#theday#'
and dca.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>

<cfquery datasource="nba" name="hUpBigPct">
Select Sum(dch.UpBig)/#totplays# as hasBIGleadpct
from NBADrivecharts dch 
Where dch.Team = '#thehometeam#'
and dch.OffDef = 'O'
and dch.gametime = '#theday#'
and dch.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>


<!--- See how may times HUGE leads a  --->
<cfquery datasource="nba" name="aDownBigPct">
Select Sum(dca.DownBig)/#totplays# as downbig
from NBADrivecharts dca 
Where dca.Team = '#theawayteam#'
and dca.OffDef = 'O'
and dca.gametime = '#theday#'
and dca.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>

<cfquery datasource="nba" name="hdownBigPct">
Select Sum(dch.DownBig)/#totplays# as downbig
from NBADrivecharts dch 
Where dch.Team = '#thehometeam#'
and dch.OffDef = 'O'
and dch.gametime = '#theday#'
and dch.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>




<br>
<cfoutput>

Total Plays: #HGettotplays.totplays + aGettotplays.totplays#<br>
<hr>
#thehometeam# was in the lead #hGetLeadPcts.hasleadpct#<br>
#theawayteam# was in the lead #aGetLeadPcts.hasleadpct#<br>
<hr>
#thehometeam# was UP BIG #hUpBigPct.hasBIGleadpct#<br>
#theawayteam# was UP BIG #aUpBigPct.hasBIGleadpct#<br>
<hr>
#thehometeam# was DOWN BIG #hDownBigPct.downbig#<br>
#theawayteam# was DOWN BIG #aDownBigPct.downbig#<br>

<hr>
Total Lead Changes: #GetLeadChanges.lc#<br>
</cfoutput>

<p>
<p>
<p>

 
<cfquery datasource="nba" name="upd2">
Update TeamSituation
Set LastLeadChanges = #GetLeadChanges.lc#,
InLeadPct = #100*hGetLeadPcts.hasleadpct#,
UpBigPct  = #100*hUpBigPct.hasBIGleadpct#,
DownBigPct = #100*hDownBigPct.downbig#,
LastTotalPlays = #HGettotplays.totplays#
Where Team = '#thehometeam#'
and gametime = '#gametime#'
</cfquery>

<cfquery datasource="nba" name="upd1">
Update TeamSituation
Set LastLeadChanges = #GetLeadChanges.lc#,
InLeadPct = #100*aGetLeadPcts.hasleadpct#,
UpBigPct  = #100*aUpBigPct.hasBIGleadpct#,
DownBigPct = #100*aDownBigPct.downbig#,
LastTotalPlays = #aGettotplays.totplays#
Where Team = '#theawayteam#'
and gametime = '#gametime#'
</cfquery>
 
	
</cfif>	

<cfif 1 is 2>
<cfquery datasource="nba" name="upd2">
Update TeamSituation
Set LastTotalPlays = #HGettotplays.totplays#
Where Team = '#thehometeam#'
and gametime = '#gametime#'
</cfquery>

<cfquery datasource="nba" name="upd1">
Update TeamSituation
Set LastTotalPlays = #aGettotplays.totplays#
Where Team = '#theawayteam#'
and gametime = '#gametime#'
</cfquery>
</cfif>
	
	<p>
	<p>
	<hr>
</cfloop>





	<!--- See if the last game, the team had 100+ LastTotalPlays --->
	<cfquery datasource="nba" name="GetOneHund">
	Select Team 
	from TeamSituation
	where gametime = '#GetRunct.GameTime#'
	and LastTotalPlays >= 100  
	</cfquery>
		
	
	
	<cfif GetOneHund.recordcount gt 0>
		
		<cfloop query="GetOneHund">
		
			<cfquery datasource="Nba" name="FoundTeam2">
				Select *
				from finalPicks
				where GameTime = '#GetRunct.GameTime#'
				and Fav        = '#Team#'
				and  spd      >= 4.5
			</cfquery>
	
			<cfif Foundteam2.recordcount gt 0>

	
				<!--- We have a favorite of 4.5 or more where last game they had 100+ total plays... --->
				<cfquery datasource="Nba" name="FoundTeam3">
				Update FinalPicks
				Set SYS57 = '#FoundTeam2.und#'
				where gametime = '#GetRunct.GameTime#'
				and und = '#FoundTeam2.und#'
				</cfquery>
		
			</cfif>
		</cfloop>
	</cfif>



<cfquery datasource="Nba" name="GetStatus">
	Insert into NBADataLoadStatus (gametime,StepName)
	values('#Gametime#','LastSevenHealth.cfm')
</cfquery>

<cfcatch type="any">
  	
 
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.tagcontext[1].line#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:LastSevenHealth.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>


</cfcatch>

</cftry>

</cfif>

