 
<cfquery datasource="Nba" name="Getit">
	Select fav,und,gametime,sys0 as Pick
	from FinalPicks
	Where SYS0 <> ''
	AND Gametime <= '20161228'
</cfquery>

<cfoutput query="GetIt">

	<cfset thepick = "">
	<cfif RIGHT('#GetIt.Pick#',3) is '#GetIt.FAV#'>
		<cfset thepick = '#Getit.Und#'>
	</cfif>

	<cfif RIGHT('#GetIt.Pick#',3) is '#GetIt.UND#'>
		<cfset thepick = '#Getit.Fav#'>
	</cfif>
	
	The pick is #thepick# for gametime #Getit.gametime#<br>
	
	<cfif Getit.gametime gt ''>
	
	<cfquery datasource="Nba"> 
	Update FinalPicks
	SET SYS101 = '#thepick#' 
	Where Gametime = '#Getit.Gametime#'
	and FAV = '#Getit.Fav#'
	</cfquery>
	
	</cfif>
		
</cfoutput>






