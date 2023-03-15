<cftry>

<cfinclude template="FigureUnderperformDefensively.cfm">

<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

 
<cfset GameTime = GetRunct.GameTime>

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
		from finalPicks
		where GameTime = '#gametime#'
		and (Fav = '#Getit.Team#' or Und = '#GetIt.Team#') 
	</cfquery>

	<cfset thepick = FoundTeam.und>
	<cfset TeamIsFav = true>
	<cfif Getit.Team is foundteam.und >
		<cfset TeamIsFav = false>
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
	<cfset criteriact = 0>
	<cfloop condition="not done">
		<cfset yyyy        = left(gametime,4)>
		<cfset mm          = mid(gametime,5,2)>
		<cfset dd          = right(gametime,2)>
		<cfset mydate      = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
		
		<CFSET DAYcheck    = #Dateformat(DateAdd("d",#daysback#,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
		<CFSET DAYcheckSTR = ToString(DAYCheck)>
	
		<CFSET DAYcheck7    = #Dateformat(DateAdd("d",-7,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
		<CFSET DAYcheck7STR = ToString(DAYCheck7)>
	

		<!--- <cfoutput>	
		xxxxSee if team played on: #Daycheckstr#<br> 
		</cfoutput>  --->
	
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
				
				<cfset FailToQualifyCt  = FailToQualifyCt + 1>
			
			</cfif>
		
		</cfif>
			

		<cfset daysback  = daysback -1>

		
		<cfset CriteriaCt = 0>
		<cfif Gamect gt	5 >
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
			
			<cfoutput>
			<p>	
			
	
			<!--- See if this team has been picked within the last seven days --->
			<cfquery datasource="Nba" name="GetSeven">	
			Select Und
			from FinalPicks
			Where gametime >= '#DAYcheck7STR#'
			and gametime < '#gametime#'
			and SYS60 <> '#thepick#'	
			and (Fav ='#Getit.team#' or Und='#Getit.team#') 	
			</cfquery>
			
			<cfif GetSeven.recordcount is 0>
				
				<cfquery datasource="Nba" name="GetDefEff">
					UPDATE FinalPicks
					Set SYS60      = '#thepick#'
					Where gametime = '#GameTime#'
					and (Fav = '#Getit.Team#' or Und = '#GetIt.Team#')
				</cfquery>
			</cfif>	
				
			
			<p>
			</cfoutput>
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

















******************************************************************************
4 out of the last 5 games gave good defensive effort, Away at least 3 out of 5
******************************************************************************
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
	

		<!--- <cfoutput>	
		xxxxSee if team played on: #Daycheckstr#<br> 
		</cfoutput>  --->
	
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
		<p>
		<cfoutput>
		Days back is #daysback#<br>
		</cfoutput>


		<cfset daysback  = daysback -1>

		
		<cfset CriteriaCt = 0>
		<cfif Gamect gte	5 >
				Gamect is gt 5 <br>
		
				<cfoutput>
				<cfif FailToQualifyct lt 2>
					FailToQualifyCt is lt 2...<br>
					
					<p>
					We have a team who is likely to underperform DEFENSIVELY...on #Gametime# by #GetIt.Team#>
					<p>
					<cfset CriteriaCt = 1>
				</cfif>
				</cfoutput>
				
				<cfif AwayCt gt 2>
					<cfoutput>
					<p>
					We have a team who is likely to underperform OVERALL...on #Gametime# by #GetIt.Team#>
					</cfoutput>
					<cfset CriteriaCt = CriteriaCt +1>
					<cfif CriteriaCt is 2>
					<p>
					BINGO!!!!
					<p>	
					******************************************************************************************************
					</cfif>	
					
				</cfif>
				<hr>
			<cfset done = true>
					<cfoutput>
		Team is #Getit.Team#...Awayct is #Awayct#....CriteriaCt is #Criteriact#... TeamIsFav = #Teamisfav#<br>
		</cfoutput>

		</cfif>
		
		
				
		<cfif CriteriaCt is 2 and TeamIsFav>
		SYS80 PLAY....YES!!!!<br>
		<cfoutput>
		<p>	
		

		<!--- See if this team has been picked within the last seven days 
		<cfquery datasource="Nba" name="GetSeven">	
		Select Und
		from FinalPicks
		Where gametime >= '#DAYcheck7STR#'
		and gametime < '#gametime#'
		and SYS60A <> '#thepick#'	
		and (Fav ='#Getit.team#' or Und='#Getit.team#') 	
		</cfquery>
		--->
		
			<cfquery datasource="Nba" name="myTeam">
			Select Fav,Und, FavHealthL7, UndHealthL7
			from finalPicks
			where GameTime = '#gametime#'
			and (Fav = '#Getit.Team#' or Und = '#GetIt.Team#') 
			</cfquery>


			<cfif (myTeam.UndHealthL7 - myTeam.FavHealthL7) gte 3>

		
			********** Play AGAINST #GetIt.Team# ***************************
			<cfquery datasource="Nba" name="GetDefEff">
				UPDATE FinalPicks
				Set SYS60A     = '#myTeam.Und#'
				Where gametime = '#GameTime#'
				and (Fav = '#Getit.Team#' or Und = '#GetIt.Team#')
			</cfquery>
			
			</cfif>
			
		<p>
		</cfoutput>
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



















































******************************************************************************
4 out of the last 5 games gave good defensive effort, Away at least 3 out of 5
******************************************************************************
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
	<cfset WeakDefEffortLastGame = false>
	
	<cfloop condition="not done">
		<cfset yyyy        = left(gametime,4)>
		<cfset mm          = mid(gametime,5,2)>
		<cfset dd          = right(gametime,2)>
		<cfset mydate      = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
		
		<CFSET DAYcheck    = #Dateformat(DateAdd("d",#daysback#,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
		<CFSET DAYcheckSTR = ToString(DAYCheck)>
	
		<CFSET DAYcheck7    = #Dateformat(DateAdd("d",-7,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
		<CFSET DAYcheck7STR = ToString(DAYCheck7)>
	

		<!--- <cfoutput>	
		xxxxSee if team played on: #Daycheckstr#<br> 
		</cfoutput>  --->
	
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
									
			Weak Defensive Effort....
			<cfif GetDefEff.recordcount is 0>
				
				Weak effort... Update Failed to qualify!!!...<br>
				<cfset FailToQualifyCt  = FailToQualifyCt + 1>
			
				Weak effort in last game
				<cfif GameCt is 1>
					<cfset WeakDefEffortLastGame = true>				

				</cfif>
				
			</cfif>



		
		</cfif>
		<p>
		<cfoutput>
		Days back is #daysback#<br>
		</cfoutput>


		<cfset daysback  = daysback -1>

		
		<cfset CriteriaCt = 0>
		<cfif Gamect gte	5 >
				Gamect is gte 5 <br>
		
				<cfoutput>
				<cfif FailToQualifyct lt 2>
					FailToQualifyCt is lt 2...<br>
					
					<p>
					We have a team who is likely to underperform DEFENSIVELY...on #Gametime# by #GetIt.Team#>
					<p>
					<cfset CriteriaCt = 1>
				</cfif>
				</cfoutput>
				
				<cfif AwayCt gt 2>
					<cfoutput>
					<p>
					We have a team who is likely to underperform OVERALL...on #Gametime# by #GetIt.Team#>
					</cfoutput>
					<cfset CriteriaCt = CriteriaCt +1>
					<cfif CriteriaCt is 2>
					<p>
					BINGO!!!!
					<p>	
					******************************************************************************************************
					</cfif>	
					
				</cfif>
				<hr>
			<cfset done = true>
					<cfoutput>
		Team is #Getit.Team#...Awayct is #Awayct#....CriteriaCt is #Criteriact#... TeamIsFav = #Teamisfav#<br>
		</cfoutput>

		</cfif>
		
		
				
		<cfif CriteriaCt is 2 and TeamIsFav and WeakDefEffortLastGame is false>
		SYS80 Play!!!!<br>
		<cfoutput>
		<p>	
		

		
			
			
		<p>
		</cfoutput>
		</cfif>

	</cfloop>
	<cfset FailToQualifyCt  = 0>
	<p>
	<p>
	<hr>

	<cfif daysback lt -14>
			<cfset done = true>
	</cfif>

</cfloop>


















******************************************************************************
4 out of the last 5 games gave good defensive effort, Away at least 3 out of 5
******************************************************************************
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
	<cfset WeakDefEffortLastGame = false>
	
	<cfloop condition="not done">
		<cfset yyyy        = left(gametime,4)>
		<cfset mm          = mid(gametime,5,2)>
		<cfset dd          = right(gametime,2)>
		<cfset mydate      = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
		
		<CFSET DAYcheck    = #Dateformat(DateAdd("d",#daysback#,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
		<CFSET DAYcheckSTR = ToString(DAYCheck)>
	
		<CFSET DAYcheck7    = #Dateformat(DateAdd("d",-7,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
		<CFSET DAYcheck7STR = ToString(DAYCheck7)>
	

		<!--- <cfoutput>	
		xxxxSee if team played on: #Daycheckstr#<br> 
		</cfoutput>  --->
	
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
									
			Weak Defensive Effort....
			<cfif GetDefEff.recordcount is 0>
				
				Weak effort... Update Failed to qualify!!!...<br>
				<cfset FailToQualifyCt  = FailToQualifyCt + 1>
			
				Weak effort in last game
				<cfif GameCt is 1>
					<cfset WeakDefEffortLastGame = true>				

				</cfif>
				
			</cfif>



		
		</cfif>
		<p>
		<cfoutput>
		Days back is #daysback#<br>
		</cfoutput>


		<cfset daysback  = daysback -1>

		
		<cfset CriteriaCt = 0>
		<cfif Gamect gte	5 >
				Gamect is gt 5 <br>
		
				<cfoutput>
				<cfif FailToQualifyct lt 2>
					FailToQualifyCt is lt 2...<br>
					
					<p>
					We have a team who is likely to underperform DEFENSIVELY...on #Gametime# by #GetIt.Team#>
					<p>
					<cfset CriteriaCt = 1>
				</cfif>
				</cfoutput>
				
				<cfif AwayCt gt 2>
					<cfoutput>
					<p>
					We have a team who is likely to underperform OVERALL...on #Gametime# by #GetIt.Team#>
					</cfoutput>
					<cfset CriteriaCt = CriteriaCt +1>
					<cfif CriteriaCt is 2>
					<p>
					BINGO!!!!
					<p>	
					******************************************************************************************************
					</cfif>	
					
				</cfif>
				<hr>
			<cfset done = true>
					<cfoutput>
		Team is #Getit.Team#...Awayct is #Awayct#....CriteriaCt is #Criteriact#... TeamIsFav = #Teamisfav#<br>
		</cfoutput>

		</cfif>
		
		
				
		<cfif CriteriaCt is 2 and TeamIsFav and WeakDefEffortLastGame is false>
		YES!!!!<br>
		<cfoutput>
		<p>	
		
		<p>
		</cfoutput>
		</cfif>

	</cfloop>
	<cfset FailToQualifyCt  = 0>
	<p>
	<p>
	<hr>

	<cfif daysback lt -14>
			<cfset done = true>
	</cfif>

</cfloop>




<cfquery datasource="Nba" name="GetStatus">
	Insert into NBADataLoadStatus (gametime,StepName)
	values('#Gametime#','SYS60.cfm')
</cfquery>





<cfcatch type="any">
  	
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:FigureUnderperformDefensively.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>



