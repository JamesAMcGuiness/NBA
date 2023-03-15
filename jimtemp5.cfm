<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>

<cfset mygametime = "#GetRunCt.gametime#">


<!-- This looks promising... For UNDER plays -->
<cfquery datasource="nba" name="Getinfo">
Select * from PreGameProb
where ffgpct < -59 and ufgpct < -59 
and (ftpm < 0 or utpm < 0)
and GameTime = '#mygametime#'
order by gametime desc
</cfquery> 


<cfoutput query="Getinfo">
	checking '1#GetInfo.Fav#'<br>
	
	<cfquery datasource="NBA" name="AddPicks">
			Update FinalPicks
			Set PreGameUnder = 'UNDER'
			Where Fav = '#GetInfo.Fav#' 
			and GameTime = '#mygametime#'
	</cfquery>
</cfoutput>

<!-- Promising for UNDERS... Start AFTER November 18 -->
<cfquery datasource="nba" name="Getinfo2">
Select * from PredictedStats
where (favfg + undfg < 85)
and (favtpm + undtpm < 10)
and (favfg + undfg <> 0)
and GameTime = '#mygametime#'
order by gametime desc
</cfquery> 


<cfoutput query="Getinfo2">
	checking '2#GetInfo2.Fav#'<br>
	<cfquery datasource="NBA" name="AddPicks">
			Update FinalPicks
			Set PredStatsUnder = 'UNDER'
			Where Fav = '#GetInfo2.Fav#' 
			and GameTime = '#mygametime#'
	</cfquery>
</cfoutput>


<!-- Promising for UNDERS... Start AFTER November 18 -->
<cfquery datasource="nbaPICKS" name="Getinfo3">
Select * from NBAPICKS
where SYSTEMID = 'GameSimTotals'
and GameTime = '#mygametime#'
</cfquery> 


<cfoutput query="Getinfo3">
	checking '3#GetInfo3.Fav#'<br>
	<cfquery datasource="NBA" name="AddPicks">
			Update FinalPicks
			Set GameSimOU = '#getInfo3.oupick#'
			Where Fav = '#GetInfo3.Fav#' 
			and GameTime = '#mygametime#'
	</cfquery>
</cfoutput>

<!-- Promising for UNDERS... Start AFTER November 18 -->
<cfquery datasource="nbaPICKS" name="Getinfo4">
Select * from NBAPICKS
where SYSTEMID = 'GameSimHAForAvgs'
and oupct >= 60
and GameTime = '#mygametime#'
</cfquery> 


<cfoutput query="Getinfo4">
		checking '4#GetInfo4.Fav#'<br>
	<cfquery datasource="NBA" name="AddPicks">
			Update FinalPicks
			Set GameSimOU60 = '#getInfo4.oupick#'
			Where Fav = '#GetInfo4.Fav#' 
			and GameTime = '#mygametime#'
	</cfquery>
</cfoutput>


<!-- This looks promising... Also no play if they played night previous -->
<cfquery datasource="nba" name="Getinfo5">
Select * from PredictedStats
where favfg - undfg >= 4.82 
and favreb - undreb >= 4.35
and val(spd) <= 12 and val(spd) <> 0
order by gametime desc
</cfquery> 


<cfoutput query="Getinfo5">
		checking '4#GetInfo5.Fav#'<br>
	<cfquery datasource="NBA" name="AddPicks">
			Update FinalPicks
			Set FgReb = '#getInfo5.fav#'
			Where Fav = '#GetInfo5.Fav#' 
			and GameTime = '#mygametime#'
	</cfquery>
</cfoutput>

