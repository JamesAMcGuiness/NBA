
<cfif 1 is 2>
		<cfset Gametime = '20191203'>	

		<cfquery datasource="NBA" name="Getit99">
			Select distinct Gametime, Fav,Und,spd,whocovered
			from FinalPicks p, GAP gund, GAP gfav
			Where p.Und = gund.Team
			and p.fav = gfav.Team
			and gund.dRebounding in ('G')
			and gund.ops <> 'P'
			and gfav.ops in ('P','A')
			and p.Gametime = '#gametime#'
			and p.spd >= 3.5
			</cfquery>

			<cfquery datasource="NBA" name="Upd">
				Update FinalPicks
				Set Sys100 = ''
				where Gametime = '#gametime#'
				and Sys100 = 'UNDER'
			</cfquery>


			<cfoutput query="Getit99">

				<cfquery datasource="NBA" name="Upd2">
				Update FinalPicks
				Set Sys100 = '#Getit99.und#'
				where Gametime = '#gametime#'
				and Fav = '#Getit99.Fav#'
				</cfquery>
				
			</cfoutput>
			

			<cfquery datasource="NBA" name="Upd">
					Update FinalPicks
					Set Sys2 = ''
					
			</cfquery>	

			<cfquery datasource="NBA" name="Getit98">
			Select distinct Gametime, Fav,Und
			from FinalPicks p
			Where p.UndHealthL7 < -9
			</cfquery>
	
			<cfoutput query="Getit98">
			
				<cfquery datasource="NBA" name="Upd">
					Update FinalPicks
					Set Sys2 = '#GetIt98.Fav#'
					where Gametime = '#GetIt98.gametime#'
					and Fav = '#GetIt98.Fav#'
				</cfquery>

			</cfoutput>	

<cfabort>
</cfif>





<cftry>

<cfquery datasource="NBA" name="Loadit">
Select * from RunStatus
</cfquery>	

<cfif loadit.RunStatus is 'DONE'>
	Run status is DONE!
	<cfabort>
</cfif>


<cfset myyear  = Year(now())>
<cfset mymonth = Numberformat(Month(now()),'00')>
<cfset myday   = Numberformat(Day(now()),'00')>
<cfset mydate = myyear & mymonth & myday>


<cfset Session.TheDate = mydate>
<cfset Session.GameTime = mydate>



	<!-- Check to see if photo file exists. --->
	<cfset myfile = "nbaspds.txt">

	<cfset thisPath = ExpandPath("*.*")>
	<cfset thisDirectory = GetDirectoryFromPath(thisPath)>
		
	<cfif FileExists(ExpandPath(myfile))>
 
		file exists!
		<!--- <cfinclude template="LoadGamesFromWeb.cfm"> --->
			
		<!-- Delete Daily Spreads -->
		<cffile action="Delete" file="#ExpandPath(myfile)#">

		<cfquery datasource="Nba" name="updRunct">
			Update NbaGameTime
			Set Runct = 0,
			GameTime = '#Session.theDate#'
		</cfquery>
		
	</cfif>
		
	<!-- Check to see if all the  -->
	<cfquery datasource="Nba" name="GetRunct">
		Select RunCt,Gametime
		from NBAGameTime
	</cfquery>

		
	<!-- Already done making predictions -->
	<cfif GetRunct.RunCt gte 3 >
		
			<cfquery datasource="Nba" name="GetStatus">
			Update NBASTATUS	
			set Status = 'RUNFIGUREOUTPICKS'
			</cfquery>
		
			<cfquery datasource="NBA" name="Loadit">
			DELETE from RunStatus
			</cfquery>	

			<cfquery datasource="NBA" name="Loadit">
			Insert into RunStatus (RunStatus) values ('DONE')
			</cfquery>	

			<cfinclude template="FigureOutPicks.cfm">
			
			<cfquery datasource="NBA" name="Loadit">
			Insert into RunStatus (RunStatus) values ('Finished FigureOutPicks.cfm')
			</cfquery>	

			
			
			<cfinclude template="PicksReport.cfm">

			<cfquery datasource="NBA" name="Loadit">
			Insert into RunStatus (RunStatus) values ('Finished PicksReport.cfm')
			</cfquery>	

			<cfinclude template="UpdateSysx.cfm">
			
			<cfquery datasource="NBA" name="Loadit">
			Insert into RunStatus (RunStatus) values ('Finished UpdateSysx.cfm')
			</cfquery>	
			
			
			<cfinclude template="LastSevenHealth.cfm">
			
			<cfquery datasource="NBA" name="Getit99">
			Select distinct Gametime, Fav,Und,spd,whocovered
			from FinalPicks p, GAP gund, GAP gfav
			Where p.Und = gund.Team
			and p.fav = gfav.Team
			and gund.dRebounding in ('G')
			and gund.ops <> 'P'
			and gfav.ops in ('P','A')
			and p.Gametime = '#gametime#'
			and p.spd >= 3.5
			</cfquery>

			<cfquery datasource="NBA" name="Upd">
				Update FinalPicks
				Set Sys100 = ''
				where Gametime = '#gametime#'
				and Sys100 = 'UNDER'
			</cfquery>


			<cfoutput query="Getit99">

				<cfquery datasource="NBA" name="Upd2">
				Update FinalPicks
				Set Sys100 = '#Getit99.und#'
				where Gametime = '#gametime#'
				and Fav = '#Getit99.Fav#'
				</cfquery>
				
			</cfoutput>
			

			<cfquery datasource="NBA" name="Upd">
					Update FinalPicks
					Set Sys2 = ''
					
			</cfquery>	

			<cfquery datasource="NBA" name="Getit98">
			Select distinct Gametime, Fav,Und
			from FinalPicks p
			Where p.UndHealthL7 < -9
			</cfquery>
	
			<cfoutput query="Getit98">
			
				<cfquery datasource="NBA" name="Upd">
					Update FinalPicks
					Set Sys2 = '#GetIt98.Fav#'
					where Gametime = '#GetIt98.gametime#'
					and Fav = '#GetIt98.Fav#'
				</cfquery>

			</cfoutput>	

			
			<cfset nextDay = #Dateformat(DateAdd("d",1,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
			<cfoutput>Next Day is #nextDay#</cfoutput>


			<cfinclude template="CreateTeamScoringProfiles.cfm">

			<cfquery datasource="NBA" name="Loadit">
			Insert into RunStatus (RunStatus) values ('Finished a complete and successful run.')
			</cfquery>	

			<cfquery datasource="Nba" name="UpdStatus">
			Insert into NBADataloadStatus(StepName) values('Successful Run Of All Predictions!')
			</cfquery>
						
			<cfabort>
					
		
	<cfelse>
	
		<cfif GetRunct.Runct is 0>
			
			
			
			<cfinclude template="TeamHealth2.cfm">
		</cfif>
			
   		<cfinclude template="GameSimUltimateTest2007.cfm">

		
   </cfif>
	   
<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:NBASYS.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>
