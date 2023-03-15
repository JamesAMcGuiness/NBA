<cftry>

<cfset WeHaveAPlay = false>
	
<cfquery datasource="Nba" name="xGetRunct">
	Select sys98,sys99,gametime from FinalPicks  order by gametime desc
</cfquery> 	

<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>

<cfquery datasource="NBA" name="AddPicks">
DELETE from MJEmail
Where Gametime = '#gametime#'
</cfquery>

<cfset SkipEmail = false>

<!--- If this is our LATE load of spreads (11 AM or later)... --->
<cfif Hour(Now()) gte 11>

		Second run........<br>

		<!--- What is the number of games we currently have --->
		<cfquery datasource="Nba" name="GetGameCt">
		Select count(*) as g1
		from NBASchedule
		Where Gametime = '#gametime#' 
		</cfquery>

		<!--- What was the number of games we loaded EARLY --->
		<cfquery datasource="Nba" name="GetGameCt2">
		Select GameCt as g2
		from NBAGameCt
		</cfquery>

		<cfoutput>
		Checking #GetGameCt.g1# vs #GetGameCt2.g2#
		</cfoutput>

		<!--- If it is the same number of games we can skip sending an email to MJ --->
		<cfif GetGameCt.g1 is GetGameCt2.g2>
			<cfset SkipEmail = true>
		</cfif>
		
</cfif>

<cfoutput>
SkipEmail is #SkipEmail#
</cfoutput>

<!--- Get all the favorites who are HOME --->
<cfquery datasource="Nba" name="GetFavHome">
	Select *
	from NBASchedule
	where Gametime = '#Gametime#'
	and HA = 'H'
</cfquery>

<cfloop query="GetFavHome">

	<!--- For each Favorite who is home  --->
	<cfset done     = false>
	<cfset daysback = -1>
	<cfset Covct    = 0>
	
	<cfloop condition="not done">
		<cfset yyyy        = left(gametime,4)>
		<cfset mm          = mid(gametime,5,2)>
		<cfset dd          = right(gametime,2)>
		<cfset mydate      = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
		<CFSET DAYcheck    = #Dateformat(DateAdd("d",#daysback#,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
		<CFSET DAYcheckSTR = ToString(DAYCheck)>


		<!--- See if team played  --->
		<cfquery datasource="Nba" name="FoundTeam">
		Select *
		from finalPicks
		where GameTime = '#DAYcheckSTR#'
		and (Fav = '#GetFavHome.Fav#' or Und = '#GetFavHome.Fav#') 
		</cfquery>

		

		<!--- Team found --->
		<cfif FoundTeam.recordcount gt 0>
			<cfoutput>
			Home team, #GetFavHome.Fav# played on #DAYcheckSTR#<br>
			</cfoutput>
			<cfset TeamWasFav = false>
			<cfif FoundTeam.Fav is '#GetFavHome.Fav#' >
				<cfset TeamWasFav = true>
			</cfif>

			<!--- Was team home or away --->
			<cfset TeamWasAway = false>
			<cfif TeamWasFav and FoundTeam.ha is 'A'>
				<cfset TeamWasAway = true>
			</cfif>

			<cfif not TeamWasFav and FoundTeam.ha is 'H'>
				<cfset TeamWasAway = true>
			</cfif>

			<cfoutput>
			Was this team Away?: #TeamWasAway#<br>
			
			The team that covered was:#FoundTeam.WhoCovered# and the Favorite was:'#GetFavHome.Fav#'<br> 
			</cfoutput>

			<!--- Did team cover and were they on the road?
			<cfif FoundTeam.WhoCovered is '#GetFavHome.Fav#' and TeamWasAway >
				YEP!!!<br>
				<cfset Covct = Covct + 1>
				<cfset done = false>

			<cfelse>
				<cfset done = true>
			</cfif>
			--->
			
			<!--- Did team win by 10 or more? --->
			<cfquery datasource="NBA" name="GetGameResults">	
			Select *
			from NbaData
			Where Team = '#GetFavHome.Fav#'
			and Ps - Dps > 0
			and Gametime = '#DAYcheckSTR#'
			</cfquery>

			<cfif GetGameResults.Recordcount neq 0 and TeamWasAway>

			<cfset Covct = Covct + 1>
				<cfset done = false>

			<cfelse>
				<cfset done = true>
			</cfif>

			

		</cfif>

		<cfset daysback = daysback -1>
		<cfif covct is 2>
			<cfset done = true>
		</cfif>
		
	</cfloop>

	<cfif covct is 2>
		<cfoutput>
		***************************************************************************<br>	
		We have a traditional MJ play AGAINST #GetFavHome.Fav#.... and on #GetFavHome.Und#<br>
		***************************************************************************<br>
		<cfquery datasource="NBA" name="AddPicks">
		Update FinalPicks
		Set SYS200 = '#GetFavHome.Und#'
		Where Fav = '#GetFavHome.Fav#' 
		and GameTime = '#gametime#'
		</cfquery>

		<cfset WeHaveAPlay = true>

		</cfoutput>
		
		
		<cfif SkipEmail is false>
			
			<cfquery datasource="NBA" name="AddPicks">
			Insert into MJEmail(Gametime,GameDesc)
			Values('#gametime#','We have an AWAY Dog play on #GetFavHome.Und#')
			</cfquery>

		</cfif>		
		
	</cfif>
	<cfset covct = 0>

</cfloop>












<!--- Get all the Underdogs --->
<cfquery datasource="Nba" name="Getit">
	Select *
	from NBASchedule
	where Gametime = '#Gametime#'
</cfquery>



<cfloop query="Getit">
	<cfoutput>
	<p>	
    Checking this und: #Getit.Und#<br>  
	<p>
	</cfoutput>
	<!--- For each underdog  --->
	<cfset done     = false>
	<cfset daysback = -1>
	<cfset Covct    = 0>
	
	<cfloop condition="not done">
		<cfset yyyy        = left(gametime,4)>
		<cfset mm          = mid(gametime,5,2)>
		<cfset dd          = right(gametime,2)>
		<cfset mydate      = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
		<CFSET DAYcheck    = #Dateformat(DateAdd("d",#daysback#,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
		<CFSET DAYcheckSTR = ToString(DAYCheck)>


		<cfoutput>	
		xxxxSee if team played on: #Daycheckstr#<br> 
		</cfoutput>
		<!--- See if Underdog played  --->
		<cfquery datasource="Nba" name="FoundTeam">
		Select *
		from finalPicks
		where GameTime = '#DAYcheckSTR#'
		and (Fav = '#Getit.Und#' or Und = '#GetIt.Und#') 
		</cfquery>

		<!--- Team found --->
		<cfif FoundTeam.recordcount gt 0>
			<cfoutput>
			 This team played on #DayCheckStr#<br>
			</cfoutput> 

			<cfset TeamWasFav = false>
			<cfif FoundTeam.Fav is '#GetIt.Und#' >
					Team was FAVORITE<br>
				<cfset TeamWasFav = true>
			<cfelse>
				 Team was Underdog<br>

			</cfif>

			<!--- team was FAV --->
			<cfset TeamWasAway = false>
			<cfif TeamWasFav and FoundTeam.ha is 'H'>
				
				 Team was a FAV and HOME...<br>
			<cfelse>
				<cfset TeamWasAway = true>
				
			</cfif>

			<!--- team was UND --->
			<cfif not TeamWasFav and FoundTeam.ha is 'H'>
				<cfset TeamWasAway = true>
				 Team was Away...<br> 
			<cfelse>
				
			</cfif>

			<!--- team was UND --->
			<cfif not TeamWasFav and FoundTeam.ha is 'A'>
				<cfset TeamWasAway = false>
				<!--- Team was a UND and Away...<br> --->
			<cfelse>
				
			</cfif>


			<!--- Did team cover and were they on the road? --->
			
			
			<cfif TeamWasFav is false>
			
					<cfoutput>
					Checking whocovered:#FoundTeam.WhoCovered# vs Underdog:'#FoundTeam.und#' and was team away?.. #TeamWasAway#<br> 
					</cfoutput>
			
					<!--- Did team win by 10 or more? --->
					<cfquery datasource="NBA" name="GetGameResults">	
					Select *
					from NbaData
					Where Team = '#FoundTeam.Und#'
					and Ps - Dps > 0
					and Gametime = '#DAYcheckSTR#'
					</cfquery>
			
			
			
			
			
				<cfif  GetGameResults.recordcount gt 0 and TeamWasAway >
						
					<cfset Covct = Covct + 1>
					<cfoutput>
					YES Team covered....and Covct is #Covct#<br>
					</cfoutput>
					<cfset done = false>
	
					<cfif covct is 2>
						<cfoutput>
						FoundTeam.und is #FoundTeam.und# and Und is #Getit.Und# and ha is #Getit.ha#<br> 	
							
							
						 <cfif  Getit.ha is 'A' and Getit.spd lte 3> 
									*********************************************************<br>		
								We have an MJ play on #Getit.Fav#<br>
								*********************************************************<br>
							
					
							<cfquery datasource="NBA" name="AddPicks">
							Update FinalPicks
							Set SYS200 = '#Getit.fav#'
							Where Fav = '#GetIt.Fav#' 
							and GameTime = '#gametime#'
							</cfquery>
							
							<cfset WeHaveAPlay = true>

							
							<cfif SkipEmail is false>
								
								<cfquery datasource="NBA" name="AddPicks">
								Insert into MJEmail(Gametime,GameDesc)
								Values('#gametime#','We have an AWAY Dog play on #Getit.fav#')
								</cfquery>

							</cfif>
							
						</cfif> 	
							</cfoutput>
					</cfif>
				<cfelse>
					<!--- No cover done with this guy...<br> --->
					<cfset done = true>
				</cfif>
				
			<cfelse>
			
					<cfoutput>
					Checking whocovered:#FoundTeam.WhoCovered# vs Favorite:'#FoundTeam.fav#'<br> 
					</cfoutput>
			
			
					<!--- Did team win by 10 or more? --->
					<cfquery datasource="NBA" name="GetGameResults">	
					Select *
					from NbaData
					Where Team = '#FoundTeam.Fav#'
					and Ps - Dps > 0
					and Gametime = '#DAYcheckSTR#'
					</cfquery>
		
					<cfif GetGameResults.Recordcount neq 0 and foundteam.ha is 'A'>
		
						<cfset Covct = Covct + 1>
						<cfset done = false>
	
						<cfif covct is 2>
							<cfoutput>
							FoundTeam.und is #FoundTeam.und# and Und is #Getit.Und# and ha is #Getit.ha#<br> 	
								
								
							 <cfif  Getit.ha is 'A'> 
								*********************************************************<br>		
								We have an MJ play on #Getit.Fav#<br>
								*********************************************************<br>
					
								<cfquery datasource="NBA" name="AddPicks">
								Update FinalPicks
								Set SYS200 = '#Getit.fav#'
								Where Fav = '#GetIt.Fav#' 
								and GameTime = '#gametime#'
								</cfquery>
								
								<cfset WeHaveAPlay = true>

								
								<cfif SkipEmail is false>
			
									<cfquery datasource="NBA" name="AddPicks">
									Insert into MJEmail(Gametime,GameDesc)
									Values('#gametime#','We have an AWAY Dog play on #Getit.fav#')
									</cfquery>
									
								</cfif>						
								
								
							</cfif> 	
							</cfoutput>
						</cfif>
					<cfelse>
						<cfset done = true>
					</cfif>
					
			
				<!---  
				<cfif  FoundTeam.WhoCovered is '#FoundTeam.fav#' and foundteam.ha is 'A'>
						
						
					<cfset Covct = Covct + 1>
					<cfoutput>
					YES Team covered....and Covct is #Covct#<br>
					</cfoutput>
					<cfset done = false>
	
					<cfif covct is 2>
						<cfoutput>
						FoundTeam.und is #FoundTeam.und# and Und is #Getit.Und# and ha is #Getit.ha#<br> 	
							
							
						 <cfif  Getit.ha is 'A'> 
							*********************************************************<br>		
							We have an MJ play on #Getit.Fav#<br>
							*********************************************************<br>
				
						<cfquery datasource="NBA" name="AddPicks">
						Update FinalPicks
						Set SYS200 = '#Getit.fav#'
						Where Fav = '#GetIt.Fav#' 
						and GameTime = '#gametime#'
						</cfquery>
								</cfif> 	
							</cfoutput>
					</cfif>
	
	
	
	
	
				<cfelse>
					<!--- No cover done with this guy...<br> --->
					<cfset done = true>
				</cfif>
				--->
			
			</cfif>
		</cfif>

		<cfset daysback = daysback -1>
		<cfif covct is 2>
			<cfset done = true>
		</cfif>
		<p>
		<p>
	</cfloop>
	 
	<cfset covct = 0>

</cfloop>


<cfset theSubject = 'No AWAY Dogs Qualify Today...'>
<cfset theBody    = 'No AWAY Dogs Qualify Today...'>
<cfset thecc      = 'jmcguin1@nycap.rr.com'>

<cfif WeHaveAPlay is true>
	
	<cfset theSubject = ''>
	<cfset theBody    = ''>
	
	<cfset theSubject = 'We have an AWAY Dog Play(s)!!!!!...'>

	<!--- Get all the picks... --->
	<cfquery datasource="NBA" name="GetMJPicks">
		Select * 
		from MJEmail
		Where Gametime = '#GameTime#'
	</cfquery>

	<cfoutput query="GetMJPicks">
		<cfset thebody = thebody & '#GetMJPicks.GameDesc#' & '<br>'>
	</cfoutput>
		
</cfif>


<!--- This is for MJ --->
<cfif Hour(Now()) gte 11>
	<cfset thecc = 'mdjfdl@gmail.com'>
</cfif>


<cfif Hour(Now()) lte 12> 
<!--- <cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#thebody#'>
		<cfhttpparam name='mySubject' type='FormField' value="#theSubject#">
		<cfhttpparam name='myCC'      type='FormField' value="#thecc#">
</cfhttp>  --->
</cfif>

<cfoutput>
myBody = #thebody#<br>
mySubject = #theSubject#<br>
myCC       = #thecc#
</cfoutput>


<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:MJsPicks.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>

