

<!--- <cfquery datasource="NBA" name="GetComebacks">
Select distinct s.gametime, s.fav, s.und, dcf.score as favscore,dcu.score as UndScore, dcu.TimeOfPlay, dcu.qtr
from NBADrivecharts dcf, NBADrivecharts dcu, nbadata d, nbaschedule s
Where dcf.gametime = dcu.gametime
and dcf.OffDef     = 'O'
and dcu.OffDef     ='O'
and (dcu.Score - dcf.Score >= 10)
and d.Team         = dcu.Team
and d.gametime     = dcu.gametime
and (d.ps - d.dps < 0)

and s.gametime = d.gametime
and s.und      = dcu.Team
and s.fav      = dcf.Team
and dcf.gametime >= '20141115' 
and dcf.qtr = dcu.qtr
and dcf.timeofplay = dcu.TimeOfPlay
and dcu.qtr = 4 
order by s.gametime desc
</cfquery> --->



<cfquery datasource="NBA" name="GetComebacks">
Select distinct s.gametime, s.fav, s.und, dcf.TeamHealth, dcu.TeamHealth 
from TeamSituation dcf, TeamSituation dcu, nbaschedule s
Where dcf.gametime = dcu.gametime

and s.gametime = dcu.gametime
and s.und      = dcu.Team
and s.fav      = dcf.Team
and dcf.gametime >= '20141115' 
and dcf.TeamHealth < -5
and dcu.TeamHealth < -5
order by s.gametime desc
</cfquery>


<cfoutput query="GetComebacks">
#gametime#, #fav#, #und#, #TeamHealth#,#TeamHealth#<br>
</cfoutput>




<cfset uct = 0>
<cfset oct = 0>
<cfset gct = 0 >
<cfloop query = "GetComebacks">


<!--- Get next game for the team --->
<cfquery datasource="NBA" name="GetNextGameRes">
Select fp.WhoCovered,fp.gametime,s.ou,d.ps + d.dps as totpts from finalpicks fp, nbadata d, nbaschedule s 
Where fp.Fav = '#GetComebacks.fav#'
and fp.gametime > '#GetComebacks.Gametime#'
and fp.gametime = d.gametime
and d.team = fp.fav
and s.gametime = d.gametime
and s.fav = fp.fav
order by fp.gametime desc
</cfquery>


<cfloop query="GetNextGameRes">
<cfoutput>	
#GetNextGameRes.gametime#....#GetNextGameRes.Whocovered#...OU:#ou#...TotPts:#totpts#.....
<cfif #ou# gt 205>
	UNDER

	<cfif #totpts# lt #ou#>
		<cfset uct = uct + 1>
	</cfif>
	<cfset gct = gct + 1>
</cfif>

<cfif #ou# lt 195>
	OVER
	
	<cfif #totpts# gt #ou#>
		<cfset oct = oct + 1>
	</cfif>
	<cfset gct = gct + 1>
</cfif>

<br>
</cfoutput>
</cfloop>

<hr>
</cfloop>

<cfoutput>
Unders:#uct#<br>
Overs:#oct#
Games: #gct#
</cfoutput>