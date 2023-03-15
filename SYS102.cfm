<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>
 
<cfset GameTime = '20160128'>

<!--- Get all the Teams that are playing this gametime --->
<cfquery datasource="Nba" name="Getit">
	Select Distinct Team
	from NBAData
	where Team in (Select fav from finalpicks where gametime = '#gametime#')
	or Team in (Select Und from finalpicks where gametime = '#gametime#')
</cfquery>

******************************************************************************
5 out of the last 6 games gave good defensive effort, Away at least 3 out of 6
******************************************************************************

<cfloop query="Getit">

	<cfquery datasource="Nba" name="FoundTeam">
		Select *
		from NBAData
		where Team = '#Getit.Team#'
		and gametime < '#gametime#'
		order by gametime desc 
	</cfquery>

	<cfset keepGoing = true>
	<cfset tenplusct = 0>
	<!--- Check the last three games for total effort --->
	<cfoutput query="FoundTeam" maxrows="4">
		
		<cfif TotEffort gte 0>

			<cfif TotEffort gte 10>
				<cfset tenplusct = tenplusct +1>
			</cfif>

		<cfelse>
			<cfset keepGoing = false>
		</cfif>	

	</cfoutput>

	<cfoutput>
	<p>	
	<cfif keepGoing is true and tenplusct gte 3>
		
		<!--- <cfquery datasource="Nba" name="GetUnd">
		Select Und
		from FinalPicks
		where Fav = '#Getit.Team#'
		and gametime = '#gametime#'
		and spd >= 5
		</cfquery> --->
		
		<!--- <cfif GetUnd.recordcount gt 0>
		<cfquery datasource="Nba" name="GetDefEff">
			UPDATE FinalPicks
				Set SYS101 = '#GetUnd.Und#'
			Where gametime = '#GameTime#'
			and (Fav = '#Getit.Team#' or Und = '#GetIt.Team#')
		</cfquery> --->
		
		We have a team off FOUR straight games of good effort: #Getit.Team# for #gametime#<br>
		<!--- </cfif> --->
	</cfif>
	</cfoutput>
	<cfset keepgoing = true>

</cfloop>











