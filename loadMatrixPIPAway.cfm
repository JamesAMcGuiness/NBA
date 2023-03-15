<cftry>

<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset yyyy = left(GetRunCt.gametime,4)>
<cfset mm   = mid(GetRunCt.gametime,5,2)>
<cfset dd   = right(GetRunCt.gametime,2)>
<cfset mydate = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET PREVDAY = #Dateformat(DateAdd("d",-1,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET PREVDAYSTR = ToString(PREVDAY)>

<cfset myGameTime = PREVDAYSTR>

<cfquery datasource="nba"  name="GetTeams">
Select Distinct team 
from GAP
</cfquery>

<cfloop query="GetTeams">

	<cfset theTeam = GetTeams.Team>

	<cfquery datasource="nba" name="GetOppGames">
		Select * from nbadata where team = '#theTeam#'
		and ha = 'H'
		and gametime = '#mygametime#'
	</cfquery>

	
	<!-- For each game, for each stat -->
	<cfloop query="GetOppGames">

		<cfset TheOpp     = GetOppGames.opp>
		<cfset TheOppPS   = GetOppGames.dps>
		<cfset TheOppDPS  = GetOppGames.ps>	
		<cfset TheOppPIP  = GetOppGames.dPIP>	
	
		<cfset TheOppFGpct   = GetOppGames.dfgpct>
		<cfset TheOppDFgpct  = GetOppGames.ofgpct>	
		<cfset TheOppdPIP    = GetOppGames.oPIP>	
	
	
		<cfoutput>
		The opponent for #theteam# is #theopp#<br>
		</cfoutput>
	
		<!-- For each stat   -->
		<cfloop index="ii" from="1" to="1">
			<cfswitch expression="#ii#">
		
					
				<cfcase value="1">
					<cfset stat = 'OREB'>

					<!-- For the stat -->
					<!-- Get Opponents percent better ratings for the stat in question -->
					<cfquery datasource="nba" name="BetterThanAvg">
						Select oPIP from BetterThanAvg where team = '#theopp#'
					</cfquery>
		
					<cfset usethis = BetterThanAvg.oPIP>
		
					<cfoutput>
					The oPIP rating for #theopp# is #usethis#<br>
					</cfoutput>
		
		
					<!-- Get teams with worse percent better ratings -->
					<cfquery datasource="nba" name="Worse">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and oPIP < #usethis#
					</cfquery>	

					<cfoutput>
					The teams WORSE on Offense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Worse">
					#Team#, #oPIP#<br>
					</cfoutput>
	
	
	
					<!-- Get teams with better percent better ratings -->
					<cfquery datasource="nba" name="Better">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and oPIP > #usethis#
					</cfquery>	


					<cfoutput>
					The teams BETTER on offense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Better">
					#Team#, #oPIP#<br>
					</cfoutput>

	
					<!-- Get teams with same percent better ratings -->
					<cfquery datasource="nba" name="Same">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and oPIP = #usethis#
					</cfquery>	

					<cfoutput>
					The teams EQUAL on offense to #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Same">
					#Team#, #oPIP#<br>
					</cfoutput>


					<!-- For all the teams worse -->
					<cfloop query="worse">
					
						<cfset TheWorseTeam = Worse.team>
					
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchWorse = ( (usethis) - (Worse.oPIP))/100>
						
						<!-- Get what the opponent scored, and increase this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppPIP - (HowMuchWorse*TheOppPIP)>

						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixPIP
						(Team,
						oPIP,
						ha,
						opp,
						gametime
						)
						Values
						(
						'#TheWorseTeam#',
						#valuetosave#,
						'A',
						'#TheTeam#',
						'#mygametime#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDPIP
						(Team,
						dPIP,
						ha,
						opp,
						gametime
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'H',
						'#theworseteam#',
						'#mygametime#'
						)
						</cfquery>	
					
					
					
					</cfloop>

					<!-- For all the teams better -->
					<cfloop query="better">
					
						<cfset TheBetterTeam = Better.Team>
					
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchBetter = (Better.oPIP - usethis)/100>
						
						<!-- Get what the opponent scored, and decrease this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppPIP + (HowMuchBetter*TheOppPIP)>

						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixPIP
						(Team,
						oPIP,
						ha,
						opp,
						gametime
						)
						Values
						(
						'#TheBetterTeam#',
						#valuetosave#,
						'A',
						'#TheTeam#',
						'#mygametime#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDPIP
						(Team,
						dPIP,
						ha,
						opp,
						gametime
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'H',
						'#thebetterteam#',
						'#mygametime#'
						)
						</cfquery>	
					
					</cfloop>
					

					<!-- For all the teams equal -->
					<cfloop query="same">
						
						<cfset TheSameTeam = Same.Team>
						
						<!-- Get what the opponent scored, and decrease this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppPIP>

						<!-- Save Matrix row -->	
												<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixPIP
						(Team,
						oPIP,
						ha,
						opp,
						gametime
						)
						Values
						(
						'#theSameTeam#',
						#valuetosave#,
						'A',
						'#theTeam#',
						'#mygametime#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDPIP
						(Team,
						dPIP,
						ha,
						opp,
						gametime
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'H',
						'#thesameteam#',
						'#mygametime#'
						)
						</cfquery>	

					</cfloop>	
				</cfcase>
		</cfswitch>
		</cfloop>
	
	
	</cfloop>
	

</cfloop>


<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:LoadMatrixPIPAway.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>