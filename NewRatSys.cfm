<cfset gametime  = '20210102'>
<cfset StartFrom = '20201222'>


<cfset Session.Gametime2 = gametime>


<cfquery datasource="NBA" name="GetStats">
Delete from TeamRank where gametime = '#Gametime#'
</cfquery>

<cfquery datasource="NBA" name="GetStats">
Delete from TeamPerfPicks where gametime = '#Gametime#'
</cfquery>



<cfquery datasource="NBA" name="GetIt1">
SELECT TEAM, .70*AVG(TOTEFFORT) as Rat
FROM NBADATA
WHERE GAMETIME >= '#StartFrom#' and GAMETIME < '#gametime#' 
GROUP BY TEAM
ORDER BY AVG(TOTEFFORT) DESC
</cfquery>


<cfquery datasource="NBA" name="GetIt2">
SELECT TEAM, AVG(PS) as aps, AVG(dPS) as adps  , AVG(PS) - AVG(dPS) as MOV
FROM NBADATA
WHERE GAMETIME >= '#StartFrom#' and GAMETIME < '#gametime#' 
GROUP BY TEAM
ORDER BY 4 DESC
</cfquery>

<cfquery datasource="NBA" name="GetIt3">
SELECT TEAM, AVG(PS) - (SELECT AVG(dps) from nbadata WHERE GAMETIME >= '#startfrom#' and GAMETIME < '#gametime#') as psbta, 
(SELECT AVG(ps) from nbadata WHERE GAMETIME >= '#startfrom#' and GAMETIME < '#gametime#') - AVG(dPS) as dpsbta
FROM NBADATA
WHERE GAMETIME >= '#StartFrom#' and GAMETIME < '#gametime#' 
GROUP BY TEAM
ORDER BY 3 DESC
</cfquery>

<cfquery dbtype="query" name="GetTeams">
SELECT Distinct TEAM
FROM GetIt3
</cfquery>

<cfloop query="GetTeams">

	<cfset Tot = 0>

	<cfquery datasource="NBA" name="GetStats">
	Select Team, opp, Gametime, ps - dps as MOV
	from NBAData
	Where Team = '#GetTeams.Team#'
	AND GAMETIME >= '#StartFrom#' and GAMETIME < '#gametime#'
	</cfquery>

	<cfloop query="GetStats">
	
		<cfquery dbtype="query" name="GetOpp">
		SELECT Team,MOV
		FROM GetIt2
		WHERE Team = '#GetStats.opp#'
		</cfquery>
	
		<cfset PtsEarned = GetStats.MOV + GetOpp.MOV>
		<cfset Tot = Tot + PtsEarned>

	</cfloop>
	<cfoutput>
	Rating for #GetTeams.Team# is #Tot/GetStats.recordcount#<br>
	<cfquery datasource="NBA" name="GetStats">
	Insert into TeamRank(Team,Power,Gametime) values ('#GetTeams.Team#',#Tot/GetStats.recordcount#,'#Gametime#')
	</cfquery>
	</cfoutput>
</cfloop>



<!--- Now after ranking, see how each team did versus the rankings of their opponents --->
<cfquery datasource="NBA" name="GetRankings">
		SELECT Team, POWER
		FROM TeamRank
		WHERE Gametime = '#Gametime#'
</cfquery>

<cfloop query="GetTeams">

	<cfset Tot = 0>

	<cfquery datasource="NBA" name="GetStats">
	Select Team, opp, Gametime, ps - dps as MOV
	from NBAData
	Where Team = '#GetTeams.Team#'
	AND GAMETIME >= '#StartFrom#' and GAMETIME < '#gametime#'
	</cfquery>

	<cfloop query="GetStats">
	
		<cfquery dbtype="query" name="GetOpp">
		SELECT Team,Power
		FROM GetRankings
		WHERE Team = '#GetStats.opp#'
		</cfquery>
	
		
		<cfset PtsEarned = GetStats.MOV + GetOpp.Power>
		
		
		<cfset Tot = Tot + PtsEarned>

	</cfloop>
	
	<cfset PowerSOS = PtsEarned / GetStats.RecordCount>
	<cfquery datasource="NBA" name="UpdIt">
	Update TeamRank
	Set PowerSOS = #powerSOS#
	Where Team = '#GetTeams.Team#'
	AND GAMETIME ='#gametime#'
	</cfquery>

</cfloop>	
<cfif 1 is 2>
<cfinclude template="UpdateTeamRank2.cfm">
</cfif>