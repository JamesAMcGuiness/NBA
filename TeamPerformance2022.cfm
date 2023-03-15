<cfquery datasource="NBA" name="GetDay">
Select * 
from Nbagametime
</cfquery>

<cfset daysback    = -1>
<cfset yyyy        = left(GetDay.gametime,4)>
<cfset mm          = mid(GetDay.gametime,5,2)>
<cfset dd          = right(GetDay.gametime,2)>
<cfset daysback      = -7>


<cfquery datasource="NBA" name="GetTeams">
Select Distinct Team 
from NbaData
</cfquery>



<cfset TeamPlayedAGame = 'N'>
<cfset ConseqDaysOff   = 0>

<Cfloop query="GetTeams">

	<cfset ConseqDayCt      = 0> 
	<cfset ConseqDayAwayCt  = 0> 
	<cfset ConseqSpdCoverCt = 0>
	<cfset ConseqSpdNOCoverCt = 0>
	

	<cfloop condition="daysback lte -1"> 
	

		<CFSET PriorDAY      = #Dateformat(DateAdd("d",daysback,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
		<CFSET PriorDayStr   = ToString(PriorDay)>
		<cfset TeamWasFav    = 'N'>
		<cfset TeamWasHome   = 'N'>
		

		<cfquery datasource="NBA" name="TeamPlayed">
		Select d.ps, d.dps, d.Gametime,d.Team, fp.* 
		from NBAData d, FinalPicks fp
		Where d.Team = '#GetTeams.Team#'
		and d.Gametime = '#PriorDayStr#'
		and d.Gametime = fp.Gametime
		and (fp.fav = d.Team or fp.und = d.Team)
		</cfquery>

		<cfset CoveredTheSpd    = 'N'>

		<cfif TeamPlayed.Recordcount gt 0>
			<cfset ConseqDaysOff = 0> 
			<cfset TeamPlayedAGame = 'Y'>
			<cfset ConseqDayCt = ConseqDayCt + 1> 
			<cfset MOV = TeamPlayed.ps - TeamPlayed.dps> 

			<cfif Teamplayed.Team is Teamplayed.Fav>
				<cfset TeamWasFav = 'Y'>
				<cfif TeamPlayed.HA is 'A'>
					<cfset ConseqDayAwayCt = ConseqDayAwayCt + 1>
					<cfset TeamWasHome   = 'N'>
				<cfelse>
					<cfset TeamWasHome   = 'Y'>
				</cfif>	
				<cfset PerformanceDiff = MOV - TeamPlayed.spd>
				
				<cfif MOV gt TeamPlayed.spd>
					<cfset CoveredTheSpd = 'Y'>
					<cfset ConseqSpdCoverCt = ConseqSpdCoverCt + 1>
					<cfset ConseqSpdNOCoverCt = 0>
				<cfelse>
					<cfset ConseqSpdCoverCt = 0>
					<cfset ConseqSpdNOCoverCt = ConseqSpdNOCoverCt + 1>
				</cfif>
				
			<cfelse>
			
			
				<cfif TeamPlayed.HA is 'H'>
					<cfset ConseqDayAwayCt = ConseqDayAwayCt + 1>
					<cfset TeamWasHome   = 'N'>
				<cfelse>
					<cfset TeamWasHome   = 'Y'>
					
				</cfif>	
			
			
			
				<cfif MOV gt 0>
					<cfset CoveredTheSpd = 'Y'>
					<cfset PerformanceDiff = MOV + TeamPlayed.spd>
					<cfset ConseqSpdCoverCt = ConseqSpdCoverCt + 1>
					<cfset ConseqSpdNOCoverCt = 0>
					
				<cfelse>

					<cfif MOV gt (-1*TeamPlayed.spd)>
						<cfset PerformanceDiff = TeamPlayed.spd + MOV>
						<cfset CoveredTheSpd = 'Y'>
						<cfset ConseqSpdCoverCt = ConseqSpdCoverCt + 1>
						<cfset ConseqSpdNOCoverCt = 0>
					<cfelse>

						<cfset PerformanceDiff = MOV + TeamPlayed.spd>
						<cfset ConseqSpdCoverCt = 0>
						<cfset ConseqSpdNOCoverCt = ConseqSpdNOCoverCt + 1>
					</cfif>
				
				</cfif>	
					
			</cfif>	
			


		<cfelse>
		
			<cfset ConseqDayCt = 0> 
			<cfset ConseqDaysOff = ConseqDaysOff + 1> 
					
		</cfif>
		
		<cfset daysback = daysback + 1>
		
		
		

		<cfif TeamPlayed.Recordcount gt 0 and daysback is 0>
		
			<p>
			<p>
			************************************************************************************************************<br>
			<cfoutput>
			Results for #GetTeams.Team# <b>on GameDay: #PriorDayStr#</b><br>
			<b>Game Situation:</b><br>
			Was the team favored? #TeamWasFav#<br>
			Was the team home? #TeamWasHome#<br>
			What was the spread? #TeamPlayed.spd#<br>
			<b>Performance:</b><br>
			What was the MOV? #mov#<br>
			What was the PerformanceDiff? #PerformanceDiff#<br>
			<b>Streaks for tiredness:</b><br>
			Current ConseqDayCt is #ConseqDayCt#<br>
			Current ConseqDayAwayCt is #ConseqDayAwayCt#<br>
			Current CONSEQ DAYS OFF is: #ConseqDaysOff#<br>
			<b>Streaks for COVERS:</b><br>
			Did they cover the spread? #CoveredTheSpd#<br>
			Current streak of covers is? #ConseqSpdCoverCt#<br> 
			Current streak of FAILED covers is? #ConseqSpdNOCoverCt#<br>
			************************************************************************************************************<br>
			</cfoutput>
			
		<cfelseif daysback is 0>
			************************************************************************************************************<br>
			<cfoutput>
			Results for #GetTeams.Team#<br> 
			<b>Streaks for tiredness:</b><br>
			Current ConseqDayCt is #ConseqDayCt#<br>
			Current ConseqDayAwayCt is #ConseqDayAwayCt#<br>
			Current CONSEQ DAYS OFF is: #ConseqDaysOff#<br>
			<b>Streaks for COVERS:</b><br>
			Current streak of covers is? #ConseqSpdCoverCt#<br> 
			Current streak of FAILED covers is? #ConseqSpdNOCoverCt#<br>
			************************************************************************************************************<br>
			</cfoutput>
		</cfif>
		
	</cfloop>

	<cfset daysback      = -7>

	<p>
	<p>
	<p>
	
</cfloop>

