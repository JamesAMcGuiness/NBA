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

<cfquery datasource="nba"  name="GetTeams">
Select Distinct team 
from GAP
<!--- and team = 'DAL' --->
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
		<cfset TheOppreb  = GetOppGames.dreb>	
	
		<cfset TheOppFGpct   = GetOppGames.dfgpct>
		<cfset TheOppDFgpct  = GetOppGames.ofgpct>	
		<cfset TheOppdreb    = GetOppGames.oreb>	
	
	
		<cfoutput>
		The opponent for DAL is #theopp#<br>
		</cfoutput>
	
		<!-- For each stat   -->
		<cfloop index="ii" from="1" to="22">
			<cfswitch expression="#ii#">
		
				<cfcase value="1">
					<cfset stat = 'OPS'>
					
					<!-- For the stat -->
					<!-- Get Opponents percent better ratings for the stat in question -->
					<cfquery datasource="nba" name="BetterThanAvg">
						Select ops from BetterThanAvg where team = '#theopp#'
					</cfquery>
		
					<cfset usethis = BetterThanAvg.ops>
		
					<cfoutput>
					The OPS rating for #theopp# is #usethis#<br>
					</cfoutput>
		
		
					<!-- Get teams with worse percent better ratings -->
					<cfquery datasource="nba" name="Worse">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and ops < #usethis#
					</cfquery>	

					<cfoutput>
					The teams WORSE on Offense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Worse">
					#Team#, #ops#<br>
					</cfoutput>
	
	
	
					<!-- Get teams with better percent better ratings -->
					<cfquery datasource="nba" name="Better">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and ops > #usethis#
					</cfquery>	


					<cfoutput>
					The teams BETTER on offense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Better">
					#Team#, #ops#<br>
					</cfoutput>

	
					<!-- Get teams with same percent better ratings -->
					<cfquery datasource="nba" name="Same">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and ops = #usethis#
					</cfquery>	

					<cfoutput>
					The teams EQUAL on offense to #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Same">
					#Team#, #ops#<br>
					</cfoutput>


					<!-- For all the teams worse -->
					<cfloop query="worse">
					
						<cfset TheWorseTeam = Worse.team>
					
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchWorse = ( (usethis) - (Worse.ops))/100>
						
						<!-- Get what the opponent scored, and increase this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppPS - (HowMuchWorse*TheOppPS)>

						<cfoutput>
						#TheWorseteam# is #HowMuchWorse# worse on Offense, since #TheOppPS# was scored than we will store the lower #ValueToSave#<br>
						</cfoutput>
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrix
						(Team,
						ops,
						ha,
						opp
						)
						Values
						(
						'#TheWorseTeam#',
						#valuetosave#,
						'A',
						'#TheTeam#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDPS
						(Team,
						dps,
						ha,
						opp
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'H',
						'#theworseteam#'
						)
						</cfquery>	
					
					
					
					</cfloop>

					<!-- For all the teams better -->
					<cfloop query="better">
					
						<cfset TheBetterTeam = Better.Team>
					
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchBetter = (Better.ops - usethis)/100>
						
						<!-- Get what the opponent scored, and decrease this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppPS + (HowMuchBetter*TheOppPS)>
						<cfoutput>
						#TheBetterteam# is #HowMuchBetter# better on Offense, since #TheOppPS# was scored than we will store the higher amount #ValueToSave#<br>
						</cfoutput>

						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrix
						(Team,
						ops,
						ha,
						opp
						)
						Values
						(
						'#TheBetterTeam#',
						#valuetosave#,
						'A',
						'#TheTeam#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDPS
						(Team,
						dps,
						ha,
						opp
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'H',
						'#thebetterteam#'
						)
						</cfquery>	
					
					</cfloop>
					

					<!-- For all the teams equal -->
					<cfloop query="same">
						
						<cfset TheSameTeam = Same.Team>
						
						<!-- Get what the opponent scored, and decrease this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppPS>
						<cfoutput>
						#thesameteam# is rated the same, since #TheOppPS# was scored than we will store the same value #ValueToSave#<br>
						</cfoutput>
						<!-- Save Matrix row -->	
												<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrix
						(Team,
						ops,
						ha,
						opp
						)
						Values
						(
						'#theSameTeam#',
						#valuetosave#,
						'A',
						'#theTeam#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDPS
						(Team,
						dps,
						ha,
						opp
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'H',
						'#thesameteam#'
						)
						</cfquery>	

					
					</cfloop>


					
				</cfcase>
			
				<cfcase value="2">
					<cfset stat = 'OFGM'>
				</cfcase>
			
				<cfcase value="3">
					<cfset stat = 'OFGA'>
				</cfcase>
			
				<cfcase value="4">
					<cfset stat = 'OFGPCT'>

					<!-- For the stat -->
					<!-- Get Opponents percent better ratings for the stat in question -->
					<cfquery datasource="nba" name="BetterThanAvg">
						Select ofgpct from BetterThanAvg where team = '#theopp#'
					</cfquery>
		
					<cfset usethis = BetterThanAvg.ofgpct>
		
					<cfoutput>
					The ofgpct rating for #theopp# is #usethis#<br>
					</cfoutput>
		
		
					<!-- Get teams with worse percent better ratings -->
					<cfquery datasource="nba" name="Worse">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and ofgpct < #usethis#
					</cfquery>	

					<cfoutput>
					The teams WORSE on Offense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Worse">
					#Team#, #ofgpct#<br>
					</cfoutput>
	
	
	
					<!-- Get teams with better percent better ratings -->
					<cfquery datasource="nba" name="Better">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and ofgpct > #usethis#
					</cfquery>	


					<cfoutput>
					The teams BETTER on offense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Better">
					#Team#, #ofgpct#<br>
					</cfoutput>

	
					<!-- Get teams with same percent better ratings -->
					<cfquery datasource="nba" name="Same">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and ofgpct = #usethis#
					</cfquery>	

					<cfoutput>
					The teams EQUAL on offense to #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Same">
					#Team#, #ofgpct#<br>
					</cfoutput>


					<!-- For all the teams worse -->
					<cfloop query="worse">
					
						<cfset TheWorseTeam = Worse.team>
					
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchWorse = ( (usethis) - (Worse.ofgpct))/100>
						
						<!-- Get what the opponent scored, and increase this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppFGpct - (HowMuchWorse*TheOppFGPCT)>

						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixFGpct
						(Team,
						ofgpct,
						ha,
						opp
						)
						Values
						(
						'#TheWorseTeam#',
						#valuetosave#,
						'A',
						'#TheTeam#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDFGPCT
						(Team,
						dfgpct,
						ha,
						opp
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'H',
						'#theworseteam#'
						)
						</cfquery>	
					
					
					
					</cfloop>

					<!-- For all the teams better -->
					<cfloop query="better">
					
						<cfset TheBetterTeam = Better.Team>
					
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchBetter = (Better.ofgpct - usethis)/100>
						
						<!-- Get what the opponent scored, and decrease this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppFgpct + (HowMuchBetter*TheOppFgpct)>

						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixFGpct
						(Team,
						ofgpct,
						ha,
						opp
						)
						Values
						(
						'#TheBetterTeam#',
						#valuetosave#,
						'A',
						'#TheTeam#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDFGpct
						(Team,
						dfgpct,
						ha,
						opp
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'H',
						'#thebetterteam#'
						)
						</cfquery>	
					
					</cfloop>
					

					<!-- For all the teams equal -->
					<cfloop query="same">
						
						<cfset TheSameTeam = Same.Team>
						
						<!-- Get what the opponent scored, and decrease this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppFgpct>

						<!-- Save Matrix row -->	
												<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixFGpct
						(Team,
						ofgpct,
						ha,
						opp
						)
						Values
						(
						'#theSameTeam#',
						#valuetosave#,
						'A',
						'#theTeam#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDFGPCT
						(Team,
						dfgpct,
						ha,
						opp
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'H',
						'#thesameteam#'
						)
						</cfquery>	

					
					</cfloop>

				</cfcase>
	
				<cfcase value="5">
					<cfset stat = 'Otpm'>
				</cfcase>
	
				
				<cfcase value="6">
					<cfset stat = 'Otpa'>
				</cfcase>
	
				<cfcase value="7">
					<cfset stat = 'Otppct'>
				</cfcase>
	
				<cfcase value="8">
					<cfset stat = 'OFTM'>
				</cfcase>
	
				<cfcase value="9">
					<cfset stat = 'OFTA'>
				</cfcase>
	
			
				<cfcase value="10">
					<cfset stat = 'OREB'>

					<!-- For the stat -->
					<!-- Get Opponents percent better ratings for the stat in question -->
					<cfquery datasource="nba" name="BetterThanAvg">
						Select oreb from BetterThanAvg where team = '#theopp#'
					</cfquery>
		
					<cfset usethis = BetterThanAvg.oreb>
		
					<cfoutput>
					The oreb rating for #theopp# is #usethis#<br>
					</cfoutput>
		
		
					<!-- Get teams with worse percent better ratings -->
					<cfquery datasource="nba" name="Worse">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and oreb < #usethis#
					</cfquery>	

					<cfoutput>
					The teams WORSE on Offense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Worse">
					#Team#, #oreb#<br>
					</cfoutput>
	
	
	
					<!-- Get teams with better percent better ratings -->
					<cfquery datasource="nba" name="Better">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and oreb > #usethis#
					</cfquery>	


					<cfoutput>
					The teams BETTER on offense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Better">
					#Team#, #oreb#<br>
					</cfoutput>

	
					<!-- Get teams with same percent better ratings -->
					<cfquery datasource="nba" name="Same">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and oreb = #usethis#
					</cfquery>	

					<cfoutput>
					The teams EQUAL on offense to #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Same">
					#Team#, #oreb#<br>
					</cfoutput>


					<!-- For all the teams worse -->
					<cfloop query="worse">
					
						<cfset TheWorseTeam = Worse.team>
					
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchWorse = ( (usethis) - (Worse.oreb))/100>
						
						<!-- Get what the opponent scored, and increase this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppreb - (HowMuchWorse*TheOppreb)>

						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixreb
						(Team,
						oreb,
						ha,
						opp
						)
						Values
						(
						'#TheWorseTeam#',
						#valuetosave#,
						'A',
						'#TheTeam#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDreb
						(Team,
						dreb,
						ha,
						opp
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'H',
						'#theworseteam#'
						)
						</cfquery>	
					
					
					
					</cfloop>

					<!-- For all the teams better -->
					<cfloop query="better">
					
						<cfset TheBetterTeam = Better.Team>
					
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchBetter = (Better.oreb - usethis)/100>
						
						<!-- Get what the opponent scored, and decrease this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppreb + (HowMuchBetter*TheOppreb)>

						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixreb
						(Team,
						oreb,
						ha,
						opp
						)
						Values
						(
						'#TheBetterTeam#',
						#valuetosave#,
						'A',
						'#TheTeam#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDreb
						(Team,
						dreb,
						ha,
						opp
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'H',
						'#thebetterteam#'
						)
						</cfquery>	
					
					</cfloop>
					

					<!-- For all the teams equal -->
					<cfloop query="same">
						
						<cfset TheSameTeam = Same.Team>
						
						<!-- Get what the opponent scored, and decrease this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppreb>

						<!-- Save Matrix row -->	
												<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixreb
						(Team,
						oreb,
						ha,
						opp
						)
						Values
						(
						'#theSameTeam#',
						#valuetosave#,
						'A',
						'#theTeam#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDreb
						(Team,
						dreb,
						ha,
						opp
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'H',
						'#thesameteam#'
						)
						</cfquery>	

					</cfloop>	
				</cfcase>
	
				<cfcase value="11">
					<cfset stat = 'OTO'>
				</cfcase>
	
				<cfcase value="12">
					<cfset stat = 'DPS'>

					<!-- For the stat -->
					<!-- Get Opponents percent better ratings for the stat in question -->
					<cfquery datasource="nba" name="BetterThanAvg">
						Select dps from BetterThanAvg where team = '#theopp#'
					</cfquery>
		
		
					<cfset usethis = BetterThanAvg.dps>

					<cfoutput>
					The DPS rating for #theopp# is #usethis#<br>
					</cfoutput>
		
					<!-- Get teams with worse percent better ratings -->
					<cfquery datasource="nba" name="Worse">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and dps < #usethis#
					</cfquery>	


					<cfoutput>
					The teams WORSE on defense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Worse">
					#Team#, #dps#<br>
					</cfoutput>

	
					<!-- Get teams with better percent better ratings -->
					<cfquery datasource="nba" name="Better">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and dps > #usethis#
					</cfquery>	


					<cfoutput>
					The teams Better on defense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Better">
					#Team#, #dps#<br>
					</cfoutput>

	
					<!-- Get teams with same percent better ratings -->
					<cfquery datasource="nba" name="Same">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and dps = #usethis#
					</cfquery>	

					
					<cfoutput>
					The teams EQUAL on defense to #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Same">
					#Team#, #dps#<br>
					</cfoutput>


					<!-- For all the teams worse on defense -->
					<cfloop query="worse">
						
						
						<cfset TheWorseTeam = Worse.team>
						
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchWorse = ((usethis) - (Worse.dps))/100>
						
						<!-- Get what the opponent gave up scored, and increase this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppDPS + (HowMuchWorse*TheOppDPS)>
					
						<cfoutput>
						#theworseteam# is #HowMuchWorse# worse on defense, since #TheOppDPS# was GIVEN UP than we will store the higer value #ValueToSave#<br>
						</cfoutput>
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDPS
						(Team,
						dps,
						ha,
						opp
						)
						Values
						(
						'#theworseteam#',
						#valuetosave#,
						'A',
						'#theTeam#'
						)
						</cfquery>	
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrix
						(Team,
						ops,
						ha,
						opp
						)
						Values
						(
						'#theteam#',
						#valuetosave#,
						'H',
						'#theworseTeam#'
						)
						</cfquery>	
					
					
					
					</cfloop>

					<!-- For all the teams better -->
					<cfloop query="better">

						<cfset TheBetterTeam = Better.team>
						
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchBetter = ((Better.dps - usethis))/100>
						
						<!-- Get what the opponent gave up scored, and increase this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppDPS - (HowMuchBetter*TheOppDPS)>
					
						<!-- <cfoutput>
						#thebetterteam# is #HowMuchBetter# worse on defense, since #TheOppDPS# was GIVEN UP than we will store the lower value #ValueToSave#<br>
						</cfoutput> -->
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDPS
						(Team,
						dps,
						ha,
						opp
						)
						Values
						(
						'#thebetterteam#',
						#valuetosave#,
						'A',
						'#theTeam#'
						)
						</cfquery>	
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrix
						(Team,
						ops,
						ha,
						opp
						)
						Values
						(
						'#theteam#',
						#valuetosave#,
						'H',
						'#thebetterTeam#'
						)
						</cfquery>	
					
					</cfloop>
					

					<!-- For all the teams equal -->
					<cfloop query="same">
						
						<cfset thesameteam = same.team>
						
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDPS
						(Team,
						dps,
						ha,
						opp
						)
						Values
						(
						'#thesameteam#',
						#valuetosave#,
						'A',
						'#theTeam#'
						)
						</cfquery>	
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrix
						(Team,
						ops,
						ha,
						opp
						)
						Values
						(
						'#theteam#',
						#valuetosave#,
						'H',
						'#thesameTeam#'
						)
						</cfquery>	
					
					</cfloop>




				</cfcase>
			
				<cfcase value="13">
					<cfset stat = 'DFGM'>
				</cfcase>
			
				<cfcase value="14">
					<cfset stat = 'DFGA'>
				</cfcase>
			
				<cfcase value="15">
					<cfset stat = 'DFGPCT'>

					<!-- For the stat -->
					<!-- Get Opponents percent better ratings for the stat in question -->
					<cfquery datasource="nba" name="BetterThanAvg">
						Select dfgpct from BetterThanAvg where team = '#theopp#'
					</cfquery>
		
		
					<cfset usethis = BetterThanAvg.dfgpct>

					<cfoutput>
					The dfgpct rating for #theopp# is #usethis#<br>
					</cfoutput>
		
					<!-- Get teams with worse percent better ratings -->
					<cfquery datasource="nba" name="Worse">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and dfgpct < #usethis#
					</cfquery>	


					<cfoutput>
					The teams WORSE on defense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Worse">
					#Team#, #dfgpct#<br>
					</cfoutput>

	
					<!-- Get teams with better percent better ratings -->
					<cfquery datasource="nba" name="Better">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and dfgpct > #usethis#
					</cfquery>	


					<cfoutput>
					The teams Better on defense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Better">
					#Team#, #dfgpct#<br>
					</cfoutput>

	
					<!-- Get teams with same percent better ratings -->
					<cfquery datasource="nba" name="Same">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and dfgpct = #usethis#
					</cfquery>	

					
					<cfoutput>
					The teams EQUAL on defense to #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Same">
					#Team#, #dfgpct#<br>
					</cfoutput>


					<!-- For all the teams worse on defense -->
					<cfloop query="worse">
						
						
						<cfset TheWorseTeam = Worse.team>
						
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchWorse = ((usethis) - (Worse.dfgpct))/100>
						
						<!-- Get what the opponent gave up scored, and increase this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppdfgpct + (HowMuchWorse*TheOppdfgpct)>
					
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixdfgpct
						(Team,
						dfgpct,
						ha,
						opp
						)
						Values
						(
						'#theworseteam#',
						#valuetosave#,
						'A',
						'#theTeam#'
						)
						</cfquery>	
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixfgpct
						(Team,
						ofgpct,
						ha,
						opp
						)
						Values
						(
						'#theteam#',
						#valuetosave#,
						'H',
						'#theworseTeam#'
						)
						</cfquery>	
					
					
					
					</cfloop>

					<!-- For all the teams better -->
					<cfloop query="better">

						<cfset TheBetterTeam = Better.team>
						
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchBetter = ((Better.dfgpct - usethis))/100>
						
						<!-- Get what the opponent gave up scored, and increase this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppdfgpct - (HowMuchBetter*TheOppdfgpct)>
					
						<!-- <cfoutput>
						#thebetterteam# is #HowMuchBetter# worse on defense, since #TheOppdfgpct# was GIVEN UP than we will store the lower value #ValueToSave#<br>
						</cfoutput> -->
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixdfgpct
						(Team,
						dfgpct,
						ha,
						opp
						)
						Values
						(
						'#thebetterteam#',
						#valuetosave#,
						'A',
						'#theTeam#'
						)
						</cfquery>	
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixfgpct
						(Team,
						ofgpct,
						ha,
						opp
						)
						Values
						(
						'#theteam#',
						#valuetosave#,
						'H',
						'#thebetterTeam#'
						)
						</cfquery>	
					
					</cfloop>
					

					<!-- For all the teams equal -->
					<cfloop query="same">
						
						<cfset thesameteam = same.team>
						
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixdfgpct
						(Team,
						dfgpct,
						ha,
						opp
						)
						Values
						(
						'#thesameteam#',
						#valuetosave#,
						'A',
						'#theTeam#'
						)
						</cfquery>	
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixfgpct
						(Team,
						ofgpct,
						ha,
						opp
						)
						Values
						(
						'#theteam#',
						#valuetosave#,
						'H',
						'#thesameTeam#'
						)
						</cfquery>	
					
					</cfloop>




				</cfcase>
	
				<cfcase value="16">
					<cfset stat = 'Dtpm'>
				</cfcase>
	
				
				<cfcase value="17">
					<cfset stat = 'Dtpa'>
				</cfcase>
	
				<cfcase value="18">
					<cfset stat = 'Dtppct'>
				</cfcase>
	
				<cfcase value="19">
					<cfset stat = 'DFTM'>
				</cfcase>
	
				<cfcase value="20">
					<cfset stat = 'DFTA'>
				</cfcase>
	
			
				<cfcase value="21">
					<cfset stat = 'DREB'>

					<!-- For the stat -->
					<!-- Get Opponents percent better ratings for the stat in question -->
					<cfquery datasource="nba" name="BetterThanAvg">
						Select dreb from BetterThanAvg where team = '#theopp#'
					</cfquery>
		
		
					<cfset usethis = BetterThanAvg.dreb>

					<cfoutput>
					The dreb rating for #theopp# is #usethis#<br>
					</cfoutput>
		
					<!-- Get teams with worse percent better ratings -->
					<cfquery datasource="nba" name="Worse">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and dreb < #usethis#
					</cfquery>	


					<cfoutput>
					The teams WORSE on defense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Worse">
					#Team#, #dreb#<br>
					</cfoutput>

	
					<!-- Get teams with better percent better ratings -->
					<cfquery datasource="nba" name="Better">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and dreb > #usethis#
					</cfquery>	


					<cfoutput>
					The teams Better on defense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Better">
					#Team#, #dreb#<br>
					</cfoutput>

	
					<!-- Get teams with same percent better ratings -->
					<cfquery datasource="nba" name="Same">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and dreb = #usethis#
					</cfquery>	

					
					<cfoutput>
					The teams EQUAL on defense to #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Same">
					#Team#, #dreb#<br>
					</cfoutput>


					<!-- For all the teams worse on defense -->
					<cfloop query="worse">
						
						
						<cfset TheWorseTeam = Worse.team>
						
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchWorse = ((usethis) - (Worse.dreb))/100>
						
						<!-- Get what the opponent gave up scored, and increase this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppdreb + (HowMuchWorse*TheOppdreb)>
					
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixdreb
						(Team,
						dreb,
						ha,
						opp
						)
						Values
						(
						'#theworseteam#',
						#valuetosave#,
						'A',
						'#theTeam#'
						)
						</cfquery>	
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixreb
						(Team,
						oreb,
						ha,
						opp
						)
						Values
						(
						'#theteam#',
						#valuetosave#,
						'H',
						'#theworseTeam#'
						)
						</cfquery>	
					
					
					
					</cfloop>

					<!-- For all the teams better -->
					<cfloop query="better">

						<cfset TheBetterTeam = Better.team>
						
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchBetter = ((Better.dreb - usethis))/100>
						
						<!-- Get what the opponent gave up scored, and increase this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppdreb - (HowMuchBetter*TheOppdreb)>
					
						<!-- <cfoutput>
						#thebetterteam# is #HowMuchBetter# worse on defense, since #TheOppdreb# was GIVEN UP than we will store the lower value #ValueToSave#<br>
						</cfoutput> -->
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixdreb
						(Team,
						dreb,
						ha,
						opp
						)
						Values
						(
						'#thebetterteam#',
						#valuetosave#,
						'A',
						'#theTeam#'
						)
						</cfquery>	
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixreb
						(Team,
						oreb,
						ha,
						opp
						)
						Values
						(
						'#theteam#',
						#valuetosave#,
						'H',
						'#thebetterTeam#'
						)
						</cfquery>	
					
					</cfloop>
					

					<!-- For all the teams equal -->
					<cfloop query="same">
						
						<cfset thesameteam = same.team>
						
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixdreb
						(Team,
						dreb,
						ha,
						opp
						)
						Values
						(
						'#thesameteam#',
						#valuetosave#,
						'A',
						'#theTeam#'
						)
						</cfquery>	
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixreb
						(Team,
						oreb,
						ha,
						opp
						)
						Values
						(
						'#theteam#',
						#valuetosave#,
						'H',
						'#thesameTeam#'
						)
						</cfquery>	
					
					</cfloop>





				</cfcase>
	
				<cfcase value="22">
					<cfset stat = 'DTO'>
				</cfcase>
			
			
			</cfswitch>
	
	

	
	
	
		</cfloop>
	
	
	</cfloop>
	

</cfloop>























<cfquery datasource="nba"  name="GetTeams">
Select Distinct team 
from GAP
<!--- where team='DAL' --->
</cfquery>

<cfloop query="GetTeams">

	<cfquery datasource="nba" name="GetOppGames">
		Select * from nbadata where team = '#GetTeams.Team#'
		and ha = 'A'
		and gametime = '#mygametime#'
	</cfquery>

	
	<!-- For each game, for each stat -->
	<cfloop query="GetOppGames">

		<cfset TheOpp     = GetOppGames.opp>
		<cfset TheOppPS   = GetOppGames.dps>
		<cfset TheOppDPS  = GetOppGames.ps>	
	
		<cfoutput>
		The opponent for DAL is #theopp#<br>
		</cfoutput>
	
		<!-- For each stat   -->
		<cfloop index="ii" from="1" to="22">
			<cfswitch expression="#ii#">
		
				<cfcase value="1">
					<cfset stat = 'OPS'>
					
					<!-- For the stat -->
					<!-- Get Opponents percent better ratings for the stat in question -->
					<cfquery datasource="nba" name="BetterThanAvg">
						Select ops from BetterThanAvg where team = '#theopp#'
					</cfquery>
		
					<cfset usethis = BetterThanAvg.ops>
		
		<!-- 			<cfoutput>
					The OPS rating for #theopp# is #usethis#<br>
					</cfoutput> -->
		
		
					<!-- Get teams with worse percent better ratings -->
					<cfquery datasource="nba" name="Worse">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and ops < #usethis#
					</cfquery>	

<!-- 					<cfoutput>
					The teams WORSE on Offense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Worse">
					#Team#, #ops#<br>
					</cfoutput>
 -->	
	
	
					<!-- Get teams with better percent better ratings -->
					<cfquery datasource="nba" name="Better">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and ops > #usethis#
					</cfquery>	


<!-- 					<cfoutput>
					The teams BETTER on offense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Better">
					#Team#, #ops#<br>
					</cfoutput>
 -->
	
					<!-- Get teams with same percent better ratings -->
					<cfquery datasource="nba" name="Same">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and ops = #usethis#
					</cfquery>	

<!-- 					<cfoutput>
					The teams EQUAL on offense to #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Same">
					#Team#, #ops#<br>
					</cfoutput>
 -->

					<!-- For all the teams worse -->
					<cfloop query="worse">
					
						<cfset TheWorseTeam = Worse.team>
					
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchWorse = ( (usethis) - (Worse.ops))/100>
						
						<!-- Get what the opponent scored, and increase this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppPS - (HowMuchWorse*TheOppPS)>

<!-- 						<cfoutput>
						#TheWorseteam# is #HowMuchWorse# worse on Offense, since #TheOppPS# was scored than we will store the lower #ValueToSave#<br>
						</cfoutput>
 -->					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrix
						(Team,
						ops,
						ha,
						opp
						)
						Values
						(
						'#TheWorseTeam#',
						#valuetosave#,
						'H',
						'#TheTeam#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDPS
						(Team,
						dps,
						ha,
						opp
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'A',
						'#theworseteam#'
						)
						</cfquery>	
					
					
					
					</cfloop>

					<!-- For all the teams better -->
					<cfloop query="better">
					
						<cfset TheBetterTeam = Better.Team>
					
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchBetter = (Better.ops - usethis)/100>
						
						<!-- Get what the opponent scored, and decrease this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppPS + (HowMuchBetter*TheOppPS)>
<!-- 						<cfoutput>
						#TheBetterteam# is #HowMuchBetter# better on Offense, since #TheOppPS# was scored than we will store the higher amount #ValueToSave#<br>
						</cfoutput>
 -->
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrix
						(Team,
						ops,
						ha,
						opp
						)
						Values
						(
						'#TheBetterTeam#',
						#valuetosave#,
						'H',
						'#TheTeam#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDPS
						(Team,
						dps,
						ha,
						opp
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'A',
						'#thebetterteam#'
						)
						</cfquery>	
					
					</cfloop>
					

					<!-- For all the teams equal -->
					<cfloop query="same">
						
						<cfset TheSameTeam = Same.Team>
						
						<!-- Get what the opponent scored, and decrease this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppPS>
<!-- 						<cfoutput>
						#thesameteam# is rated the same, since #TheOppPS# was scored than we will store the same value #ValueToSave#<br>
						</cfoutput>
 -->						<!-- Save Matrix row -->	
												<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrix
						(Team,
						ops,
						ha,
						opp
						)
						Values
						(
						'#theSameTeam#',
						#valuetosave#,
						'H',
						'#theSameTeam#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDPS
						(Team,
						dps,
						ha,
						opp
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'A',
						'#thesameteam#'
						)
						</cfquery>	

					
					</cfloop>
				</cfcase>
			
				<cfcase value="2">
					<cfset stat = 'OFGM'>
				</cfcase>
			
				<cfcase value="3">
					<cfset stat = 'OFGA'>
				</cfcase>
			
				<cfcase value="4">
					<cfset stat = 'OFGPCT'>

					<!-- For the stat -->
					<!-- Get Opponents percent better ratings for the stat in question -->
					<cfquery datasource="nba" name="BetterThanAvg">
						Select ofgpct from BetterThanAvg where team = '#theopp#'
					</cfquery>
		
					<cfset usethis = BetterThanAvg.ofgpct>
		
					<cfoutput>
					The ofgpct rating for #theopp# is #usethis#<br>
					</cfoutput>
		
		
					<!-- Get teams with worse percent better ratings -->
					<cfquery datasource="nba" name="Worse">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and ofgpct < #usethis#
					</cfquery>	

					<cfoutput>
					The teams WORSE on Offense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Worse">
					#Team#, #ofgpct#<br>
					</cfoutput>
	
	
	
					<!-- Get teams with better percent better ratings -->
					<cfquery datasource="nba" name="Better">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and ofgpct > #usethis#
					</cfquery>	


					<cfoutput>
					The teams BETTER on offense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Better">
					#Team#, #ofgpct#<br>
					</cfoutput>

	
					<!-- Get teams with same percent better ratings -->
					<cfquery datasource="nba" name="Same">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and ofgpct = #usethis#
					</cfquery>	

					<cfoutput>
					The teams EQUAL on offense to #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Same">
					#Team#, #ofgpct#<br>
					</cfoutput>


					<!-- For all the teams worse -->
					<cfloop query="worse">
					
						<cfset TheWorseTeam = Worse.team>
					
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchWorse = ( (usethis) - (Worse.ofgpct))/100>
						
						<!-- Get what the opponent scored, and increase this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppFGpct - (HowMuchWorse*TheOppFGPCT)>

						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixFGpct
						(Team,
						ofgpct,
						ha,
						opp
						)
						Values
						(
						'#TheWorseTeam#',
						#valuetosave#,
						'H',
						'#TheTeam#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDFGPCT
						(Team,
						dfgpct,
						ha,
						opp
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'A',
						'#theworseteam#'
						)
						</cfquery>	
					
					
					
					</cfloop>

					<!-- For all the teams better -->
					<cfloop query="better">
					
						<cfset TheBetterTeam = Better.Team>
					
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchBetter = (Better.ofgpct - usethis)/100>
						
						<!-- Get what the opponent scored, and decrease this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppFgpct + (HowMuchBetter*TheOppFgpct)>

						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixFGpct
						(Team,
						ofgpct,
						ha,
						opp
						)
						Values
						(
						'#TheBetterTeam#',
						#valuetosave#,
						'H',
						'#TheTeam#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDFGpct
						(Team,
						dfgpct,
						ha,
						opp
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'A',
						'#thebetterteam#'
						)
						</cfquery>	
					
					</cfloop>
					

					<!-- For all the teams equal -->
					<cfloop query="same">
						
						<cfset TheSameTeam = Same.Team>
						
						<!-- Get what the opponent scored, and decrease this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppFgpct>

						<!-- Save Matrix row -->	
												<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixFGpct
						(Team,
						ofgpct,
						ha,
						opp
						)
						Values
						(
						'#theSameTeam#',
						#valuetosave#,
						'H',
						'#theTeam#'
						)
						</cfquery>	
					
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDFGPCT
						(Team,
						dfgpct,
						ha,
						opp
						)
						Values
						(
						'#TheTeam#',
						#valuetosave#,
						'A',
						'#thesameteam#'
						)
						</cfquery>	

					
					</cfloop>


				</cfcase>
	
				<cfcase value="5">
					<cfset stat = 'Otpm'>
				</cfcase>
	
				
				<cfcase value="6">
					<cfset stat = 'Otpa'>
				</cfcase>
	
				<cfcase value="7">
					<cfset stat = 'Otppct'>
				</cfcase>
	
				<cfcase value="8">
					<cfset stat = 'OFTM'>
				</cfcase>
	
				<cfcase value="9">
					<cfset stat = 'OFTA'>
				</cfcase>
	
			
				<cfcase value="10">
					<cfset stat = 'OREB'>
				</cfcase>
	
				<cfcase value="11">
					<cfset stat = 'OTO'>
				</cfcase>
	
				<cfcase value="12">
					<cfset stat = 'DPS'>

					<!-- For the stat -->
					<!-- Get Opponents percent better ratings for the stat in question -->
					<cfquery datasource="nba" name="BetterThanAvg">
						Select dps from BetterThanAvg where team = '#theopp#'
					</cfquery>
		
		
					<cfset usethis = BetterThanAvg.dps>

<!-- 					<cfoutput>
					The DPS rating for #theopp# is #usethis#<br>
					</cfoutput>
 -->		
					<!-- Get teams with worse percent better ratings -->
					<cfquery datasource="nba" name="Worse">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and dps < #usethis#
					</cfquery>	


<!-- 					<cfoutput>
					The teams WORSE on defense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Worse">
					#Team#, #dps#<br>
					</cfoutput>
 -->
	
					<!-- Get teams with better percent better ratings -->
					<cfquery datasource="nba" name="Better">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and dps > #usethis#
					</cfquery>	


<!-- 					<cfoutput>
					The teams Better on defense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Better">
					#Team#, #dps#<br>
					</cfoutput>
 -->
	
					<!-- Get teams with same percent better ratings -->
					<cfquery datasource="nba" name="Same">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and dps = #usethis#
					</cfquery>	

					
<!-- 					<cfoutput>
					The teams EQUAL on defense to #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Same">
					#Team#, #dps#<br>
					</cfoutput>
 -->

					<!-- For all the teams worse on defense -->
					<cfloop query="worse">
						
						
						<cfset TheWorseTeam = Worse.team>
						
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchWorse = ((usethis) - (Worse.dps))/100>
						
						<!-- Get what the opponent gave up scored, and increase this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppDPS + (HowMuchWorse*TheOppDPS)>
					
<!-- 						<cfoutput>
						#theworseteam# is #HowMuchWorse# worse on defense, since #TheOppDPS# was GIVEN UP than we will store the higer value #ValueToSave#<br>
						</cfoutput>
 -->					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDPS
						(Team,
						dps,
						ha,
						opp
						)
						Values
						(
						'#theworseteam#',
						#valuetosave#,
						'H',
						'#theTeam#'
						)
						</cfquery>	
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrix
						(Team,
						ops,
						ha,
						opp
						)
						Values
						(
						'#theteam#',
						#valuetosave#,
						'A',
						'#theworseTeam#'
						)
						</cfquery>	
					
					
					
					</cfloop>

					<!-- For all the teams better -->
					<cfloop query="better">

						<cfset TheBetterTeam = Better.team>
						
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchBetter = ((Better.dps - usethis))/100>
						
						<!-- Get what the opponent gave up scored, and increase this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppDPS - (HowMuchBetter*TheOppDPS)>
					
<!-- 						<cfoutput>
						#thebetterteam# is #HowMuchBetter# worse on defense, since #TheOppDPS# was GIVEN UP than we will store the lower value #ValueToSave#<br>
						</cfoutput>
 -->					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDPS
						(Team,
						dps,
						ha,
						opp
						)
						Values
						(
						'#thebetterteam#',
						#valuetosave#,
						'H',
						'#theTeam#'
						)
						</cfquery>	
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrix
						(Team,
						ops,
						ha,
						opp
						)
						Values
						(
						'#theteam#',
						#valuetosave#,
						'A',
						'#thebetterTeam#'
						)
						</cfquery>	
					
					</cfloop>
					

					<!-- For all the teams equal -->
					<cfloop query="same">
						
						<cfset thesameteam = same.team>
						
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into MatrixDPS
						(Team,
						dps,
						ha,
						opp
						)
						Values
						(
						'#thesameteam#',
						#valuetosave#,
						'H',
						'#theTeam#'
						)
						</cfquery>	
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrix
						(Team,
						ops,
						ha,
						opp
						)
						Values
						(
						'#theteam#',
						#valuetosave#,
						'A',
						'#thesameTeam#'
						)
						</cfquery>	
					
					</cfloop>




				</cfcase>			
				<cfcase value="13">
					<cfset stat = 'DFGM'>
				</cfcase>
			
				<cfcase value="14">
					<cfset stat = 'DFGA'>
				</cfcase>
			
				<cfcase value="15">

					<cfset stat = 'DFGPCT'>

					<!-- For the stat -->
					<!-- Get Opponents percent better ratings for the stat in question -->
					<cfquery datasource="nba" name="BetterThanAvg">
						Select dfgpct from BetterThanAvg where team = '#theopp#'
					</cfquery>
		
		
					<cfset usethis = BetterThanAvg.dfgpct>

					<cfoutput>
					The dfgpct rating for #theopp# is #usethis#<br>
					</cfoutput>
		
					<!-- Get teams with worse percent better ratings -->
					<cfquery datasource="nba" name="Worse">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and dfgpct < #usethis#
					</cfquery>	


					<cfoutput>
					The teams WORSE on defense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Worse">
					#Team#, #dfgpct#<br>
					</cfoutput>

	
					<!-- Get teams with better percent better ratings -->
					<cfquery datasource="nba" name="Better">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and dfgpct > #usethis#
					</cfquery>	


					<cfoutput>
					The teams Better on defense then #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Better">
					#Team#, #dfgpct#<br>
					</cfoutput>

	
					<!-- Get teams with same percent better ratings -->
					<cfquery datasource="nba" name="Same">
					Select * from BetterThanAvg 
					where team not in ('#theopp#','#theteam#')
					and dfgpct = #usethis#
					</cfquery>	

					
					<cfoutput>
					The teams EQUAL on defense to #theopp# are:<br>	
					</cfoutput>
					<cfoutput query="Same">
					#Team#, #dfgpct#<br>
					</cfoutput>


					<!-- For all the teams worse on defense -->
					<cfloop query="worse">
						
						
						<cfset TheWorseTeam = Worse.team>
						
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchWorse = ((usethis) - (Worse.dfgpct))/100>
						
						<!-- Get what the opponent gave up scored, and increase this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppdfgpct + (HowMuchWorse*TheOppdfgpct)>
					
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixdfgpct
						(Team,
						dfgpct,
						ha,
						opp
						)
						Values
						(
						'#theworseteam#',
						#valuetosave#,
						'H',
						'#theTeam#'
						)
						</cfquery>	
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixfgpct
						(Team,
						ofgpct,
						ha,
						opp
						)
						Values
						(
						'#theteam#',
						#valuetosave#,
						'A',
						'#theworseTeam#'
						)
						</cfquery>	
					
					
					
					</cfloop>

					<!-- For all the teams better -->
					<cfloop query="better">

						<cfset TheBetterTeam = Better.team>
						
						<!-- See how much worse this team is then the opponents rating -->
						<cfset HowMuchBetter = ((Better.dfgpct - usethis))/100>
						
						<!-- Get what the opponent gave up scored, and increase this amount by how much worse this team is thenthe opponent -->
						<cfset ValueToSave = TheOppdfgpct - (HowMuchBetter*TheOppdfgpct)>
					
						<!-- <cfoutput>
						#thebetterteam# is #HowMuchBetter# worse on defense, since #TheOppdfgpct# was GIVEN UP than we will store the lower value #ValueToSave#<br>
						</cfoutput> -->
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixdfgpct
						(Team,
						dfgpct,
						ha,
						opp
						)
						Values
						(
						'#thebetterteam#',
						#valuetosave#,
						'H',
						'#theTeam#'
						)
						</cfquery>	
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixfgpct
						(Team,
						ofgpct,
						ha,
						opp
						)
						Values
						(
						'#theteam#',
						#valuetosave#,
						'A',
						'#thebetterTeam#'
						)
						</cfquery>	
					
					</cfloop>
					

					<!-- For all the teams equal -->
					<cfloop query="same">
						
						<cfset thesameteam = same.team>
						
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixdfgpct
						(Team,
						dfgpct,
						ha,
						opp
						)
						Values
						(
						'#thesameteam#',
						#valuetosave#,
						'H',
						'#theTeam#'
						)
						</cfquery>	
					
						<!-- Save Matrix row -->	
						<cfquery datasource="nba" name="addit">
						Insert Into Matrixfgpct
						(Team,
						ofgpct,
						ha,
						opp
						)
						Values
						(
						'#theteam#',
						#valuetosave#,
						'A',
						'#thesameTeam#'
						)
						</cfquery>	
					
					</cfloop>




				
				</cfcase>
	
				<cfcase value="16">
					<cfset stat = 'Dtpm'>
				</cfcase>
	
				
				<cfcase value="17">
					<cfset stat = 'Dtpa'>
				</cfcase>
	
				<cfcase value="18">
					<cfset stat = 'Dtppct'>
				</cfcase>
	
				<cfcase value="19">
					<cfset stat = 'DFTM'>
				</cfcase>
	
				<cfcase value="20">
					<cfset stat = 'DFTA'>
				</cfcase>
	
			
				<cfcase value="21">
					<cfset stat = 'DREB'>
				</cfcase>
	
				<cfcase value="22">
					<cfset stat = 'DTO'>
				</cfcase>
			
			
			</cfswitch>
	
	

	
	
	
		</cfloop>
	
	
	</cfloop>
	

</cfloop>



<cfquery datasource="nba" name="Getspds">
Select *
from nbaschedule
where GameTime = '#mygametime#'
 </cfquery>

<cfloop query="GetSpds">
	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset spd           = #GetSpds.spd#>
	<cfset myou          = #GetSpds.ou#>  
	<cfset overct        = 0>
	
	<cfset UndHa = 'H'>
	<cfset favha = ha>
	
	<cfif ha is 'H'>
		<cfset UndHa = 'A'>
	</cfif>

<cfquery datasource="nba" name="getit1">
Select Avg(ops) as aops
from Matrix m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<!-- <cfoutput query="getit1">
#fav#: #Getit1.aops#<br>
</cfoutput>

<hr>
 -->

<cfquery datasource="nba" name="getit2">
Select Avg(ops) as aops
from Matrix m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undha#'
</cfquery>

<!-- <cfoutput query="getit2">
#und#: #Getit2.aops#<br>
</cfoutput>

<hr>
Defense<br>
 -->

<cfquery datasource="nba" name="getit3">
Select Avg(dps) as adps
from Matrixdps m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<!-- <cfoutput query="getit3">
#Fav# pts against: #Getit3.adps#<br>
</cfoutput>

<hr>
 -->

<cfquery datasource="nba" name="getit4">
Select Avg(dps) as adps
from Matrixdps m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undhA#'
</cfquery>

<!-- <cfoutput query="getit4">
#Und# pts against: #Getit4.adps#<br>
</cfoutput> -->

<!-- #fav# : #(Getit1.aops + Getit4.adps)/2#<br>
#und# : #(Getit2.aops + Getit3.adps)/2#<br>
Prediction #fav# by (Getit1.aops + Getit4.adps)/2 - (Getit2.aops + Getit3.adps)/2
<hr> 
<hr> -->

</cfloop>


