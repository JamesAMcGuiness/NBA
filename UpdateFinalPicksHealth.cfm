<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset gametime = '#GetRunCt.Gametime#'>

<!--- Get all the Favorites that are playing this gametime --->
<cfquery datasource="Nba" name="GetFavsPlaying">
	Select *
	from FinalPicks
	where gametime = '#gametime#'
	AND FAV <> ''
</cfquery>


<cfloop query="GetFavsPlaying">


<cfquery datasource="Nba" name="GetHlth">
	SELECT LastSeven
	from TeamHealth 
	where Team = '#GetFavsPlaying.Fav#'
</cfquery>


<cfquery datasource="Nba" name="GetFavsPlaying2">
	UPDATE FinalPicks
	SET FavHealthL7 = #GetHlth.LastSeven#
	where gametime = '#gametime#'
	AND FAV = '#GetFavsPlaying.Fav#'
</cfquery>


<cfquery datasource="Nba" name="GetHlth">
	SELECT LastSeven
	from TeamHealth 
	where  Team = '#GetFavsPlaying.Und#'
</cfquery>


<cfquery datasource="Nba" name="GetFavsPlaying2">
	UPDATE FinalPicks
	SET UndHealthL7 = #GetHlth.LastSeven#
	where gametime = '#gametime#'
	AND FAV = '#GetFavsPlaying.Fav#'
</cfquery>

</cfloop>

<cfquery datasource="Nba" name="GetStatus">
	Insert into NBADataLoadStatus (gametime,StepName)
	values('#Gametime#','UpdateFinalPicksHealth.cfm')
</cfquery>

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	