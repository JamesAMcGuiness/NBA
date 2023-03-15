<!-- For each team, get all their games -->

<!--- <cfquery datasource="nba" name="getit">
Delete from Matrix
</cfquery>

<cfquery datasource="nba" name="getit">
Delete from Matrixdps
</cfquery>

<cfquery datasource="nba" name="getit">
Delete from MatrixFGPct
</cfquery>

<cfquery datasource="nba" name="getit">
Delete from MatrixDfgpct
</cfquery>
 --->


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

<cfquery datasource="nba" name="getit">
Delete from MatrixPIP where gametime = '#mygametime#'
</cfquery>

<cfquery datasource="nba" name="getit">
Delete from MatrixdPIP where gametime = '#mygametime#'
</cfquery>



<cfquery datasource="nba"  name="GetTeams">
Select Distinct team 
from GAP
<!--- and team = 'DAL' --->
</cfquery>

<cfloop query="GetTeams">

	<cfset theTeam = GetTeams.Team>

	<cfquery datasource="nba" name="GetOppGames">
		Select * from nbadata where team = '#theTeam#'
		and gametime = '#mygametime#'
	</cfquery>

	
	<!-- For each game, for each stat -->
	<cfloop query="GetOppGames">

		<cfset TheOpp     = GetOppGames.opp>
		<cfset TheOppPIP  = GetOppGames.dpip>
		<cfset TheOppDPIP  = GetOppGames.opip>	
	
		<!-- For each stat   -->
		<cfloop index="ii" from="1" to="1">
			<cfswitch expression="#ii#">
		
				<cfcase value="1">
					<cfset stat = 'OPIP'>
					
					<!-- For the stat -->
					<!-- Get Opponents percent better ratings for the stat in question -->
					<cfquery datasource="nba" name="BetterThanAvg">
						Select opip from BetterThanAvg where team = '#theopp#'
					</cfquery>
		
					<cfset usethis = BetterThanAvg.opip>
		
					<cfoutput>
					The OPIP rating for #theopp# is #usethis#<br>
					</cfoutput>
		
		
					<!-- Get teams with worse percent better ratings -->
					<cfquery datasource="nba" name="Worse">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and opip < #usethis#
					</cfquery>	

					<cfoutput>
					The teams WORSE on Offense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Worse">
					#Team#, #opip#<br>
					</cfoutput>
	
	
	
					<!-- Get teams with better percent better ratings -->
					<cfquery datasource="nba" name="Better">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and opip > #usethis#
					</cfquery>	


					<cfoutput>
					The teams BETTER on offense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Better">
					#Team#, #opip#<br>
					</cfoutput>

	
					<!-- Get teams with same percent better ratings -->
					<cfquery datasource="nba" name="Same">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and opip = #usethis#
					</cfquery>	

					<cfoutput>
					The teams EQUAL on offense to #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Same">
					#Team#, #opip#<br>
					</cfoutput>


					<!-- For all the teams worse -->
					<cfloop query="worse">
					
						<cfset TheWorseTeam = Worse.team>
					
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchWorse = ( (usethis) - (Worse.opip))/100>
						
						<!-- Get what the opponent scored, and increase this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppPIP - (HowMuchWorse*TheOppPIP)>

						<cfoutput>
						#TheWorseteam# is #HowMuchWorse# worse on Offense, since #TheOppPIP# was scored than we will store the lower #ValueToSave#<br>
						</cfoutput>
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixPIP
						(Team,
						opip,
						ha,
						opp,
						gametime
						)
						Values
						(
						'#TheWorseTeam#',
						#valuetosave#,
						'H',
						'#TheTeam#',
						'#mygametime#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDPIP
						(Team,
						dpip,
						ha,
						opp,
						gametime
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'A',
						'#theworseteam#',
						'#mygametime#'
						)
						</cfquery>	
					
					
					
					</cfloop>

					<!-- For all the teams better -->
					<cfloop query="better">
					
						<cfset TheBetterTeam = Better.Team>
					
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchBetter = (Better.opip - usethis)/100>
						
						<!-- Get what the opponent scored, and decrease this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppPIP + (HowMuchBetter*TheOppPIP)>
						<cfoutput>
						#TheBetterteam# is #HowMuchBetter# better on Offense, since #TheOppPIP# was scored than we will store the higher amount #ValueToSave#<br>
						</cfoutput>

						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixPIP
						(Team,
						opip,
						ha,
						opp,
						gametime
						)
						Values
						(
						'#TheBetterTeam#',
						#valuetosave#,
						'H',
						'#TheTeam#',
						'#mygametime#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDPIP
						(Team,
						dpip,
						ha,
						opp,
						gametime
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'A',
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
						<cfoutput>
						#thesameteam# is rated the same, since #TheOppPIP# was scored than we will store the same value #ValueToSave#<br>
						</cfoutput>
						<!-- Save Matrix row -->	
												<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixPIP
						(Team,
						opip,
						ha,
						opp,
						gametime
						)
						Values
						(
						'#theSameTeam#',
						#valuetosave#,
						'H',
						'#theTeam#',
						'#mygametime#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDPIP
						(Team,
						dpip,
						ha,
						opp,
						gametime
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'A',
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
















