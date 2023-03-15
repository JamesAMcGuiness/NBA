<cfif 1 is 1>

<cftry>

<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>

<!--- 
<cfset GameTime = '20141122'>
 --->

<!--- Get all the Teams that are playing this gametime --->
<cfquery datasource="Nba" name="Getit">
	Select Distinct Team
	from NBAData
	where Team in (Select fav from finalpicks where gametime = '#gametime#')
	or Team in (Select Und from finalpicks where gametime = '#gametime#')
</cfquery>

<!--- Get all the Teams that are playing this gametime --->
<cfquery datasource="Nba" name="Getit">
	Select Distinct Team
	from NBAData
	where team <> ''
</cfquery>



<cfloop query="Getit">

	<cfoutput>
    Checking this : #Getit.Team#<br>  
	</cfoutput>

	<!--- For each Team  --->
	<cfset AwayCt               = 0>
	<cfset TotalAwayGamesInARow = 0>
		
	<cfquery datasource="Nba" name="GetData">
			Select * from NBAData
			Where Team = '#GetIt.Team#'
			order by Gametime
	</cfquery>
	
	<cfloop query="GetData">
		
		<cfif GetData.HA is 'A'>
			<cfset AwayCt = Awayct + 1>
		<cfelse>
			
			<cfset AwayCt = 0>
		</cfif>	
		<cfset TotalAwayGamesInARow = AwayCt>
	</cfloop>	

	<cfquery datasource="Nba" name="Updit">
	UPDATE TeamHealth
	SET ConseqRoadCt = #TotalAwayGamesInARow#
	WHERE Team = '#GetIt.Team#'
	</cfquery>	
		
		
</cfloop>
	

<cfcatch type="any">
  	
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.tagcontext[1].line#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:UpdateConseqRoadCt.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>

</cfif>

