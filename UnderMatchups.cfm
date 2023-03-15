<cfquery datasource="NBA" name="GetGametime">
Select Gametime
from NBAGametime
</cfquery>


<cfquery datasource="NBA" name="GetBestPerimDef">
Delete from UnderMatchups
</cfquery>


<cfset thegametime = '#GetGametime.gametime#'>

 
<!--- <cfset thegametime = '20150112'> --->

<cfquery datasource="NBA" name="GetBestPerimDef">
Select Team, PerimeterShotPct
from PBPPercents
Where OffDef='D'
Order by PerimeterShotPct desc
</cfquery>


<cfquery datasource="NBA" name="GetWorstTen">
Select Team, MadeNormalPct
from PBPPercents
Where OffDef='O'
Order by MadeNormalPct 
</cfquery>


<cfset loopct = 0>
<cfloop query = "GetWorstTen">
	<cfset loopct = loopct + 1>


	<cfif loopct lt 11>

		<cfset loopct2 = 0>

		-- Create a Matrix of Games between 
		<cfloop query = "GetBestPerimDef">

			<cfset loopct2 = loopct2 + 1>


				<cfif loopct2 lt 11>


					<cfquery datasource="NBA" name="Addit">
						Insert into UnderMatchUps(GameTime,Team,Opp,Advantage)
						Values('#thegametime#','#GetWorstTen.Team#','#GetBestPerimDef.Team#','#GetBestPerimDef.Team#')
					</cfquery>


				</cfif>


		</cfloop>	

	</cfif>

</cfloop>


--Check todays slate to see if this matchup is there...
<cfquery datasource="NBA" name="GetGames">
Select * from NBASchedule g, UnderMatchups um
Where g.gametime='#thegametime#'
AND   g.gametime = um.Gametime
AND   (g.FAV = Um.Team AND g.und = um.opp AND g.gametime = um.Gametime)  
OR    (g.FAV = Um.opp  AND g.und = um.Team AND g.gametime = um.Gametime)
</cfquery>


<cfoutput query="GetGames">
<p>
#thegametime#..We have a favorable UNDER situation where a poor shooting team will be forced to shoot on the perimeter, in the #GetGames.Fav# vs #GetGames.Und# game<br>
<p>
#GetGames.Advantage# should have the advantage...Fav is #Getgames.fav#...spd is #GetGames.spd#
<p>
<cfif GetGames.Advantage is getgames.und>
*******UPSET ALERT!..... Take #getgames.und#
</cfif>


<cfset opsct  = 0>
<cfset dpsct  = 0>
<cfset otpmct = 0>


<cfset OtherTeam = '#fav#'>
<cfif GetGames.Advantage is '#fav#'>
	<cfset OtherTeam = '#und#'>
</cfif>

<cfquery datasource="NBA" name="GetOtherTeam">
Select * from BetterThanAvg bta
Where Team = '#OtherTeam#'
</cfquery>


<cfquery datasource="NBA" name="GetAdvTeam">
Select * from BetterThanAvg bta
Where Team = '#GetGames.Advantage#'
</cfquery>

<cfset pass = false>

<!--- If the opponent is ranked poorly in overall defensive points, pass on it --->
<cfif GetOtherTeam.dps lt -1.7>
	<cfset pass = true>
</cfif>

<!--- If the poor shooting team makes a lot of threes, pass on it --->
<cfif GetAdvTeam.otpm gte 10>
	<cfset pass = true>
</cfif>

<!--- If the poor shooting team is good in the paint, pass on it --->
<cfif GetAdvTeam.otpm gte 3>
	<cfset pass = true>
</cfif>

<cfif pass is true>
<p>
We should pass on this for one of the above qualifiers....
<p>
</cfif>

<!--- <cfif GetIt.ops lt 0 >
	<cfset opsct  = 1>
</cfif>

<cfif GetIt.dps gt 0 >
	<cfset dpsct  = 1>
</cfif>

<cfif GetIt.otpm lt 0 >
	<cfset otpmct = 1>
</cfif> --->


<hr>
</cfoutput>