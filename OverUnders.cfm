<cfset mygametime = '20070215'>
	
<cfquery datasource="nbaschedule" name="Getspds">
	Select *
	from nbaschedule
	where GameTime = '#mygametime#'
</cfquery>

<cfloop query="GetSpds">

	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset myou          =  #GetSpds.ou#>
	
	
	<cfquery  datasource="nbastats" name="GetFav">
	Select 
       Count(Gametime) as NumTimes
 	from nbadata
  	where Team   = '#Fav#'
	and ha       = '#ha#'
  	and GameTime < '#myGameTime#'
	and (ps + dps) > (#myou#)
	</cfquery>

	<cfquery  datasource="nbastats" name="GetFavTotGames">
	Select 
       *
 	from nbadata
  	where Team   = '#Fav#'
  	and GameTime < '#myGameTime#'
	and ha       = '#ha#'
	</cfquery>

	<cfoutput>
	#Fav# goes Over the total in #GetFav.NumTimes/GetFavTotGames.recordcount#<br>
	</cfoutput>		
	
	<cfset ha = 'H'>
	<cfif ha is 'H'>
		<cfset ha = 'A'>
	</cfif>
	
	<cfquery  datasource="nbastats" name="GetUnd">
	Select 
       Count(Gametime) as NumTimes
 	from nbadata
  	where Team   = '#Und#'
  	and GameTime < '#myGameTime#'
	and (ps + dps) > (#myou#)
	and ha       = '#ha#'
	</cfquery>

	<cfquery  datasource="nbastats" name="GetUndTotGames">
	Select 
       *
 	from nbadata
  	where Team   = '#Und#'
  	and GameTime < '#myGameTime#'
	and ha       = '#ha#'
	</cfquery>

	<cfoutput>	
	#Und# goes Over the total in #GetUnd.NumTimes/GetUndTotGames.recordcount#<br>
	</cfoutput>	
	------------------------------------------------------------------------------------------------<br>	
</cfloop>	
