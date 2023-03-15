<cftry>

<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>


<!--- Get all the Teams that are playing this gametime --->
<cfquery datasource="Nba" name="Getit">
	Select Distinct Team
	from NBAData
	where (Team in (Select fav from NBAschedule where gametime = '#gametime#')
		or Team in (Select Und from Nbaschedule where gametime = '#gametime#'))
		
</cfquery>
	


<cfdump var="#Getit#">



<cfset yyyy        = left(gametime,4)>
<cfset mm          = mid(gametime,5,2)>
<cfset dd          = right(gametime,2)>

<cfloop query="Getit">

	<!--- For each Team  --->
	<cfset done      = false>
	<cfset daysback  = -7>
	
	<cfset mydate      = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
	<CFSET DAYcheck    = #Dateformat(DateAdd("d",#daysback#,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
	<CFSET DAYcheckSTR = ToString(DAYCheck)>
	
	Checking from #DAYcheckSTR# to #gametime#<br>
	
	
	<!-- Get total games played in the last 7 days -->
	<cfquery datasource="Nba" name="GamesPlayed">
		Select *
		from NBASchedule
		where (GameTime >= '#DAYcheckSTR#' and GameTime < '#gametime#'
		and (Fav = '#Getit.Team#' or Und = '#GetIt.Team#') 
		
		)
		order by gametime desc
	</cfquery>
	
	<cfdump var="#GamesPlayed#">
	
	
	
		
	<cfset GamesPlayedInWeek = GamesPlayed.RecordCount>
	
	<cfoutput>
	The games played in week were: #GamesPlayedInWeek#<br>
	</cfoutput>
	
	<cfset Hlth = -1*GamesPlayedInWeek>
	
	<!-- See how many times they played conseq nights -->
	<cfset GametimePrevVal = ''>
	<cfset ConseqCt = 0>
	<cfloop query="GamesPlayed">
		
		<cfif GamesPlayed.Fav is '#GetIt.Team#'>
			<cfset StatsFor = 'TEAM'>
		</cfif>
		
		<cfif GamesPlayed.Und is '#GetIt.Team#'>
			<cfset StatsFor = 'OPP'>
		</cfif>
		
		<cfif GameTimePrevVal neq ''>
				
			<cfif Datediff("d",Gametime[currentrow],GameTimePrevVal) is 1>
				<cfset ConseqCt = ConseqCt + 1>
			</cfif>
		
		</cfif>
		<cfset GameTimePrevVal = Gametime[currentrow]>
	</cfloop>
	
	<cfset Hlth = Hlth + (-1*ConseqCt)>
		
	<!-- See how many games played AWAY -->
	<cfquery datasource="Nba" name="GamesAwayPlayed">
		Select *
		from NBASchedule
		where (GameTime >= '#DAYcheckSTR#' and GameTime < '#gametime#'
		and(  ( Fav = '#Getit.Team#' and Ha = 'A') or ( Und = '#GetIt.Team#' and ha = 'H')) 
		)
		order by gametime desc
	</cfquery>

	<cfset AwayGamesPlayedInWeek = GamesAwayPlayed.RecordCount>


	<cfif AwayGamesPlayedInWeek gt 1 >
	<cfset Hlth = Hlth + (-1*AwayGamesPlayedInWeek)>

	<!-- See how many times they played conseq Away nights -->
	<cfset AwayCt = 0>
	<cfset TwoConseqAwayCt = 0>
	<cfset ThreeConseqAwayCt = 0>
	<cfset FourConseqAwayCt = 0>
	
	<cfloop query="GamesPlayed">
		
		<cfif (HA is 'H' and Fav is '#GetIt.Team#') or (HA is 'A' and Und is '#GetIt.Team#')>
			<cfset AwayCt = AwayCt + 1>
			
			<cfif AwayCt is 2>
				<cfset TwoConseqAwayCt = 1>
			</cfif>
			
			<cfif AwayCt is 3>
				<cfset ThreeConseqAwayCt = 1>
			</cfif>
			
			<cfif AwayCt is 4>
				<cfset FourConseqAwayCt = 1>
			</cfif>
			
		<cfelse>
			<cfif AwayCt neq 0>
				<cfset AwayCt = AwayCt - 1>
			</cfif>
		</cfif>

	</cfloop>

	<cfif AwayCt is 4>
		Played 4 conseq Away games<br>
		<cfset Hlth = Hlth - 4>
	<cfelseif AwayCt is 3>
		Played 3 conseq Away games<br>
		<cfset Hlth = Hlth - 3>
	<cfelseif AwayCt is 2>
		Played 2 conseq Away games<br>
		<cfset Hlth = Hlth - 2>
	</cfif>

	</cfif>


	<CFSET DAYcheck    = #Dateformat(DateAdd("d",-1,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>	
	<CFSET DAYcheckSTR = ToString(DAYCheck)>	

	<!-- See if team played yesterday -->
	<cfquery datasource="Nba" name="PlayedYest">
		Select *
		from NBASchedule
		where( GameTime = '#DAYcheckSTR#'
		and( (Fav = '#Getit.Team#' or Und = '#GetIt.Team#'))
		) 
	</cfquery>

	<cfset TeamPlayedAwayYest = false>
	<cfoutput query="PlayedYest">	
		
		Team played Yesterday!<br>
		<cfset Hlth = Hlth - 1>
		<!-- See if team played Away or Home yesterday -->
		<cfif (HA is 'A' and Fav is '#GetIt.Team#') or (HA is 'H' and Und is '#GetIt.Team#')> 
			<cfset TeamPlayedAwayYest = true>
			<cfset Hlth = Hlth - 1>
			Team played Yesterday and was AWAY!<br>
		</cfif>
	</cfoutput>
	
	<cfset TeamIsAwayToday = false>
	<!-- See if team is AWAY today -->
	<cfquery datasource="Nba" name="TodaysGameAway">
		Select *
		from NBASchedule
		where( GameTime = '#Gametime#'
		and( (Fav = '#Getit.Team#' and ha = 'A') or  (Und = '#GetIt.Team#' and ha = 'H'))
		)  
	</cfquery>
	
	<cfif TodaysGameAway.recordcount gt 0 and TeamPlayedAwayYest is true>
		<cfset TeamIsAwayToday = true>
		<cfset Hlth = Hlth - 1>
		Team is AWAY today!<br>
	</cfif>
	
	<cfquery datasource="Nba" name="GetDefEff">
					UPDATE TeamHealth
					Set LastSeven  = #hlth#
					Where Team = '#Getit.Team#'
	</cfquery>
	
	<cfquery datasource="Nba" name="GetDefEff">
					UPDATE TeamSituation
					Set TeamHealth = #hlth#
					Where Team = '#Getit.Team#'
	</cfquery>
	
	<cfquery datasource="Nba" name="GetDefEff">
					UPDATE FinalPicks
					Set FavHealthL7  = #hlth#
					Where Fav IN('#Getit.Team#')
					and gametime='#gametime#'
	</cfquery>
	
	<cfquery datasource="Nba" name="GetDefEff">
					UPDATE FinalPicks
					Set UndHealthL7  = #hlth#
					Where Und IN('#Getit.Team#')
					and gametime='#gametime#'
	</cfquery>
	
	<cfset Hlth = 0>
	
	
	<cfif TeamPlayedAwayYest is true >
		<cfif TeamIsAwayToday is true >
			**********************************************************************<br>
			POTENTIAL PLAY AGAINST.....<cfoutput>#Getit.team#.....Health is #hlth#</cfoutput><br>
			**********************************************************************<br>
		</cfif>
	</cfif>
	get here!<br>
	
</cfloop>	
	
<!--- <cfquery datasource="Nba" name="GetDefEff">
	UPDATE Pace
	Set HealthGame = HealthTeam + HealthOpp
</cfquery>	 --->
	
	
<cfquery datasource="Nba" name="UPDATE">
	Insert into NBADataLoadStatus
	(
	Gametime,
	StepName,
	ProgramName
	)
	values
	(
	'#Gametime#',
	'LastSevenHealth2016',
	'LastSevenHealth2016.cfm'
	)
</cfquery>	
	
	
<cfcatch type="any">
  	
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.tagcontext[1].line#<p>#cfcatch.Message#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:LastSevenHealth2016.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>


