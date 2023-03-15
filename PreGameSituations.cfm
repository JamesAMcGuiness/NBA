
<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>



<cfset yyyy        = left(gametime,4)>
<cfset mm          = mid(gametime,5,2)>
<cfset dd          = right(gametime,2)>

<cfset daysback  = -1>
	
<cfset mydate      = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET DAYcheck    = #Dateformat(DateAdd("d",#daysback#,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET DAYcheckSTR = ToString(DAYCheck)>

<!--- Get all the Favorites that are playing this gametime --->
<cfquery datasource="Nba" name="GetFavsPlaying">
	Select *
	from FinalPicks
	where gametime = '#gametime#'
	AND FAV <> ''
</cfquery>



<cfloop query="GetFavsPlaying">
<cfset variables.UndConseqRdCt    = 0>
<cfset variables.UndPlayedOT      = 'N'>
<cfset variables.UndPlayedYest    = 'N'>
<cfset variables.UndOffLoss       = 'N'>
<cfset variables.UndHealth        = 0>
<cfset variables.UndLatestCoverCt = 0>

	<cfset variables.FavConseqRdCt    = 0>
	<cfset variables.FavPlayedOT      = 'N'>
	<cfset variables.FavPlayedYest    = 'N'>
	<cfset variables.FAVOffLoss       = 'N'>
	<cfset variables.FavHealth        = 0>
	<cfset variables.FavLatestCoverCt = 0>
	
	
	<cfquery datasource="Nba" name="GetYestStats">
		Select *
		from NBAData
		where GameTime = '#DAYcheckSTR#'
		and Team       = '#GetFavsPlaying.Fav#' 
	</cfquery>

	<cfif GetYestStats.recordcount neq 0>
		<cfset variables.FavPlayedYest = 'Y'>
		The favorite #GetFavsPlaying.Fav# played Yesterday.<br>
		<cfif GetYestStats.mins gt 240 >
			<cfset variables.FavPlayedOT = 'Y'>
			The favorite #GetFavsPlaying.Fav# played in OT game Yesterday.<br>
		</cfif>
		
	</cfif>		
	
	
	<cfquery maxrows="1" datasource="Nba" name="GetFavLastGameWL">
		Select PS - DPS AS ptdiff
		from NBADATA
		where Team = '#GetFavsPlaying.Fav#' 
		order by Gametime desc
	</cfquery>
	
	<cfoutput query="GetFavLastGameWL">
	#ptdiff#
	</cfoutput>
	
	<cfoutput>
	<cfif GetFavLastGameWL.ptdiff lt 0>
		The fav Lost yesterday!<br>
		<cfset variables.FAVOffLoss = 'Y'>
		#variables.FAVOffLoss#....<br>
	</cfif>	
	</cfoutput>
	
	<cfquery maxrows="1" datasource="Nba" name="GetFavTeamSit">
		Select *
		from TeamSituation
		where Team = '#GetFavsPlaying.Fav#' 
		order by Gametime desc
	</cfquery>
	
	<cfset variables.FavHealth        = GetFavTeamSit.TeamHealth>
	<cfset variables.FavLatestCoverCt = GetFavTeamSit.LatestCoverCt>
	
	<cfquery datasource="Nba" name="GetFavConseqRdct">
		Select ConseqRoadCt
		from TeamHealth
		where Team = '#GetFavsPlaying.Fav#' 
	</cfquery>
	
	<cfset variables.FavConseqRdCt = GetFavConseqRdct.ConseqRoadCt>

	

	
	<cfquery datasource="Nba" name="GetYestStats">
		Select *
		from NBAData
		where GameTime = '#DAYcheckSTR#'
		and Team       = '#GetFavsPlaying.Und#' 
	</cfquery>

	<cfif GetYestStats.recordcount neq 0>
		<cfset variables.UndPlayedYest = 'Y'>
		
		<cfif GetYestStats.mins gt 240 >
			<cfset variables.UndPlayedOT = 'Y'>
		</cfif>
		
	</cfif>		
	
	
	<cfquery maxrows="1" datasource="Nba" name="GetUndLastGameWL">
		Select PS - DPS AS ptdiff
		from NBADATA
		where Team = '#GetFavsPlaying.Und#' 
		order by Gametime desc
	</cfquery>
	
	<cfif GetUndLastGameWL.ptdiff lt 0>
		<cfset variables.UndOffLoss = 'Y'>
	</cfif>	
	
	<cfquery maxrows="1" datasource="Nba" name="GetUndTeamSit">
		Select *
		from TeamSituation
		where Team = '#GetFavsPlaying.Und#' 
		order by Gametime desc
	</cfquery>
	
	<cfset variables.UndHealth        = GetUndTeamSit.TeamHealth>
	<cfset variables.UndLatestCoverCt = GetUndTeamSit.LatestCoverCt>
	
	<cfquery datasource="Nba" name="GetUndConseqRdct">
		Select ConseqRoadCt
		from TeamHealth
		where Team = '#GetFavsPlaying.Und#' 
	</cfquery>
	
	<cfset variables.UndConseqRdCt = #GetUndConseqRdct.ConseqRoadCt#>
	
	
	<cfoutput>
		und               = '#GetFavsPlaying.Und#'<br>
		UndConseqRdCt     = #variables.UndConseqRdCt# ,<br>
		UndPlayedOT       = #variables.UndPlayedOT#,<br>
		UndOffLoss        = #variables.UndOffLoss#,<br>
		UndHealthL7       = #variables.UndHealth#,<br>
		UndLatestCoverCt  = #variables.UndLatestCoverCt#,<br>
		FAV               = '#GetFavsPlaying.fav#'<br>
		FavConseqRdCt     = #variables.FavConseqRdCt# ,<br>
		FavPlayedOT       = #variables.FavPlayedOT#,<br>
		FavOffLoss        = #variables.FavOffLoss#,<br>
		FavHealthL7       = #variables.FavHealth#,<br>
		FavLatestCoverCt  = #variables.FavLatestCoverCt#<br>
		<p>
		*************************************************<br>
	</cfoutput>
	
	<cfquery datasource="Nba" name="UpdateFP">
		Update FinalPicks
		Set UndConseqRdCt = #variables.UndConseqRdCt# ,
		UndPlayedOT       = '#variables.UndPlayedOT#',
		UndOffLoss        = '#variables.UndOffLoss#',
		UndHealthL7       = #variables.UndHealth#,
		UndLatestCovCt    = #variables.UndLatestCoverCt#,
		FavConseqRdCt     = #variables.FavConseqRdCt# ,
		FavPlayedOT       = '#variables.FavPlayedOT#',
		FavOffLoss        = '#variables.FavOffLoss#',
		FavHealthL7       = #variables.FavHealth#,
		FavLatestCovCt  = #variables.FavLatestCoverCt#
		
		where Und = '#GetFavsPlaying.Und#' 
		and gametime = '#gametime#'
	</cfquery>
	
		
</cfloop>	

<cfquery datasource="Nba" name="GetStatus">
	Insert into NBADataLoadStatus (gametime,StepName)
	values('#Gametime#','PreGameSituations.cfm')
</cfquery>


  
<!---
<cfcatch type="any">

<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:PreGameSituations.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>


</cfcatch>

</cftry>
--->


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	