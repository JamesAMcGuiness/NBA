<cfset Gametime = '20191115'>

<cfquery datasource="NBA" name="GetResults">
Select fp.* 
from FinalPicks fp, NBAPicks p
WHERE fp.Gametime >= '#gametime#'
AND (fp.Whocovered <> 'PUSH' AND fp.Whocovered > '')
AND p.Gametime = fp.Gametime
and p.Fav = fp.Fav
and p.SystemId in ('PowerRatingWithHealth','SYS500','AvgOfAllPowerRatings','SYS500WithNBAHomeFieldADV')
order by fp.gametime desc
</cfquery>

<cfoutput query="GetResults">

	<cfquery datasource="NBA" name="Updit">
	UPDATE NBAPicks 
	SET WhoCovered = '#GetResults.WhoCovered#', 
	FavHealth = #GetResults.FavhealthL7#,
	UndHealth = #GetResults.UndhealthL7#,
	UndPlayedYest = '#GetResults.UndPlayedYest#',
	FavPlayedYest = '#GetResults.FavPlayedYest#'
	
	WHERE Gametime = '#GetResults.gametime#'
	and Fav = '#GetResults.Fav#'
	and SystemId in ('PowerRatingWithHealth','SYS500','AvgOfAllPowerRatings','SYS500WithNBAHomeFieldADV')
	</cfquery>


</cfoutput>



