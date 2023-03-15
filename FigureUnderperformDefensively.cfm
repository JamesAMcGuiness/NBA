<cftry>

<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

 
<cfset GameTime = GetRunct.GameTime>


<cfquery datasource="Nba" name="GetDefEff">
UPDATE FinalPicks
Set SYS103      = ''
Where gametime = '#GameTime#'
</cfquery>

<!--- Get all the Teams that are playing this gametime --->
<cfquery datasource="Nba" name="Getit">
	Select Distinct Team
	from NBAData
	where Team in (Select fav from finalpicks where gametime = '#gametime#')
	or Team in (Select Und from finalpicks where gametime = '#gametime#')
</cfquery>

<cfloop query="Getit">

	<cfquery datasource="Nba" name="FoundTeam">
		Select *
		from finalPicks
		where GameTime = '#gametime#'
		and (Fav = '#Getit.Team#' or Und = '#GetIt.Team#') 
	</cfquery>

	<cfset thepick = FoundTeam.und>
	<cfset TeamIsFav = false>
	<cfif Getit.Team is foundteam.fav >
		<cfset TeamIsFav = true>
	</cfif>


	<!--- <cfoutput>
    	Checking this : #Getit.Team#<br>  
	</cfoutput> --->

	<!--- For each Team  --->
	<cfset done       	= false>
	<cfset daysback   	= -1>
	<cfset FourOfFive 	= false> 
	<cfset Gamect     	= 0>
	<cfset FailToQualifyCt  = 0>
	<cfset AwayCt = 0>
	
	<cfloop condition="not done">
		<cfset yyyy        = left(gametime,4)>
		<cfset mm          = mid(gametime,5,2)>
		<cfset dd          = right(gametime,2)>
		<cfset mydate      = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
		
		<CFSET DAYcheck    = #Dateformat(DateAdd("d",#daysback#,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
		<CFSET DAYcheckSTR = ToString(DAYCheck)>
	
		<CFSET DAYcheck7    = #Dateformat(DateAdd("d",-7,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
		<CFSET DAYcheck7STR = ToString(DAYCheck7)>
	

		
	
		<!--- See if played  --->
		<cfquery datasource="Nba" name="FoundTeam">
		Select *
		from finalPicks
		where GameTime = '#DAYcheckSTR#'
		and (Fav = '#Getit.Team#' or Und = '#GetIt.Team#') 
		</cfquery>
		
		<!--- Team found --->
		<cfif FoundTeam.recordcount gt 0>
			
			<cfoutput>
			Team played on '#DAYcheckSTR#' <br>
			</cfoutput>
			
			<cfif Foundteam.fav is '#Getit.team#'>
				
				<cfif FoundTeam.ha is 'A'>
					Team was AWAY and was a favorite <br>	
					<cfset AwayCt = Awayct + 1>
				</cfif>
			
			<cfelse>
				<cfif FoundTeam.ha is 'H'>
					Team was HOME and was a underdog <br>
					<cfset AwayCt = Awayct + 1>
				</cfif>
			
			
			</cfif>
			
			<!--- <cfoutput>
			 This team played on #DayCheckStr#<br>
			</cfoutput>  --->
			
			<cfset Gamect = Gamect + 1>
			
			<!--- See if team had a 0 or more rating for DefEffort --->
			<cfquery datasource="Nba" name="GetDefEff">
			Select * from NBAData
			Where gametime = '#FoundTeam.GameTime#'
			and Team       = '#GetIt.Team#'
			and DEFEFFORT > 0
			</cfquery>
			
			
			<cfif GetDefEff.recordcount is 0>
				Failed to qualify!!!...<br>
				<cfset FailToQualifyCt  = FailToQualifyCt + 1>
			
			</cfif>
		
		</cfif>
		
		<cfset daysback  = daysback -1>

		
		<cfset CriteriaCt = 0>
		<cfif Gamect gte	5 >
				Gamect is gt 5 <br>
		
				<cfoutput>
				<cfif FailToQualifyct lt 2>
					
					
					
					<cfset CriteriaCt = 1>
				</cfif>
				</cfoutput>
				
				<cfif AwayCt gt 2>
					
					<cfset CriteriaCt = CriteriaCt +1>
					<cfif CriteriaCt is 2>
					
					</cfif>	
					
				</cfif>
				<hr>
			<cfset done = true>
					

		</cfif>
		
		
				
		<cfif CriteriaCt is 2 and TeamIsFav>
		
		<cfquery datasource="Nba" name="GetDefEff">
				UPDATE FinalPicks
				Set SYS103      = '#Getit.Team#'
				Where gametime = '#GameTime#'
				and (Fav = '#Getit.Team#' or Und = '#GetIt.Team#')
		</cfquery>
		</cfif>


		<cfif daysback lt -14>
			<cfset done = true>
		</cfif>

	</cfloop>
	<cfset FailToQualifyCt  = 0>
	<p>
	<p>
	<hr>

</cfloop>


<cfcatch type="any">
  	
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:FigureUnderperformDefensively.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>



