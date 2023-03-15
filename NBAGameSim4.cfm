
<!--- <cfquery name="Getone" datasource="psp_psp" >
	delete from RandomSim
</cfquery>
 --->

<cfscript>
 Application.objRandom = CreateObject("Component", "Random");
</cfscript>
  
<cfset Session.Week = 62>
<cfset Session.longyear = '2004'>

<cfset fav = 'CHA'>Pick
<cfset und = 'GSW'>
<cfset ha  = 'H'>
<cfset Client.spread = 3>
<cfset myou = 193.5>

<cfset fav = 'LAC'>Pick
<cfset und = 'BOS'>
<cfset ha  = 'A'>
<cfset Client.spread = 6.5>
<cfset myou = 193.5>


<!--- <cfquery datasource="nflspds" name="Getspds">
Select *
from nflspds
where week = #Session.week#
and longyear = '#Session.longyear#'
</cfquery>
 --->

<!--- <cfset TotalGames = Getspds.Recordcount> --->

<cfset OverCovpct =0>
<cfset overcovct = 0>

<!--- <cfscript>
Application.objRandom.setBounds(1,#Totalgames#);
RandomNumber = Application.objRandom.next();
</cfscript>
 --->
<cfset loopct = 0>
<cfset simfav = ''>
<cfset simund = ''>
<cfset simspd = 0>
<cfset simfav = ''>
<cfset picked = false>

<cfquery  datasource="nbastats" name="GetFavOff">
Select 
       Avg(oReb)       as OffRebFor,
	   Avg(oDreb)      as DefrebFor,
	   Avg(dTurnovers) as TurnovFor,
	   Avg(oFTa)       as FTAttFor,
	   Avg(ofga - (dTurnovers + oReb + oDreb)) as RegPosFor,
	   Avg(ofgm) / Avg(ofga) as fgRateFor,
	   Avg(otpm) / Avg(ofga) as tpRateFor,
	   Avg(oftm) / Avg(ofta) as ftRateFor,
	   Avg(dTurnovers / dfga) as toRateFor
 from nbadata
  where Team = '#fav#'
</cfquery>


<cfquery  datasource="nbastats" name="GetUndOff">
Select 
       Avg(oReb)       as OffRebFor,
	   Avg(oDreb)      as DefrebFor,
	   Avg(dTurnovers) as TurnovFor,
	   Avg(oFTa)       as FTAttFor,
	   Avg(ofga - (dTurnovers + oReb + oDreb)) as RegPosFor,
	   Avg(ofgm) / Avg(ofga) as fgRateFor,
	   Avg(otpm) / Avg(ofga) as tpRateFor,
	   Avg(oftm) / Avg(ofta) as ftRateFor,
	   Avg(dTurnovers / dfga) as toRateFor
	   
 from nbadata
  where Team = '#Und#'
</cfquery>


<cfquery  datasource="nbastats" name="GetFavDef">
Select 
       Avg(dReb)       as OffRebGiv,
	   Avg(dDreb)      as DefrebGiv,
	   Avg(oTurnovers) as TurnovGiv,
	   Avg(dFTa)       as FTAttGiv,
	   Avg(dfga - (oTurnovers + dReb + dDreb)) as RegPosGiv,
	   Avg(dfgm) / Avg(dfga) as fgRateGiv,
	   Avg(dtpm) / Avg(dfga) as tpRateGiv,
	   Avg(dftm) / Avg(dfta) as ftRateGiv,
	   Avg(oTurnovers / ofga) as toRateGiv
 from nbadata
  where Team = '#fav#'
</cfquery>

<cfquery  datasource="nbastats" name="GetUndDef">
Select 
       Avg(dReb)       as OffRebGiv,
	   Avg(dDreb)      as DefrebGiv,
	   Avg(oTurnovers) as TurnovGiv,
	   Avg(dFTa)       as FTAttGiv,
	   Avg(dfga - (oTurnovers + dReb + dDreb)) as RegPosGiv,
	   Avg(dfgm) / Avg(dfga) as fgRateGiv,
	   Avg(dtpm) / Avg(dfga) as tpRateGiv,
	   Avg(dftm) / Avg(dfta) as ftRateGiv,
	   Avg(oTurnovers / ofga) as toRateGiv
	   
 from nbadata
  where Team = '#Und#'
</cfquery>

<Cfset FavOffRebFor = (GetFavOff.OffRebFor + GetUndDef.OffRebGiv)/2 >
<Cfset UndOffRebFor = (GetUndOff.OffRebFor + GetFavDef.OffRebGiv)/2 >

<Cfset FavDefRebFor = (GetFavOff.DefRebFor + GetUndDef.DefRebGiv)/2 >
<Cfset UndDefRebFor = (GetUndOff.DefRebFor + GetFavDef.DefRebGiv)/2 >

<Cfset FavTurnovFor = (GetFavOff.TurnovFor + GetUndDef.TurnovGiv)/2 >
<Cfset UndTurnovFor = (GetUndOff.TurnovFor + GetFavDef.TurnovGiv)/2 >

<Cfset FavRegPos    = (GetFavOff.RegPosFor + GetUndDef.RegPosGiv)/2 >
<Cfset UndRegPos    = (GetUndOff.RegPosFor + GetFavDef.RegPosGiv)/2 >

<cfset FavCreatedPos = FavOffRebFor + FavDefRebFor + FavTurnovFor>  
<cfset UndCreatedPos = UndOffRebFor + UndDefRebFor + UndTurnovFor>  

<cfset FavFinalPos = FavRegPos + FavCreatedPos + 20>  
<cfset UndFinalPos = UndRegPos + UndCreatedPos + 20>  


<cfoutput>
Predicted Favorite Pos: #FavFinalPos#<br>
Predicted Underdog Pos: #UndFinalPos#<br>
</cfoutput>

<br>
<br>


<cfset oFavFGpct = (GetFavOff.fgratefor + GetUndDef.fgrategiv)/2>
<cfset oFavTPpct = (GetFavOff.TPratefor + GetUndDef.TPrategiv)/2>
<cfset oFavTOpct = (GetFavOff.TORateFor + GetUndDef.TORategiv)/2>
<cfset oFavFTpct = GetFavOff.FTRatefor>


<cfset FavPredFGSuccess = oFavFgpct*100>
<cfset FavPredTPSuccess = oFavTPpct*100>
<cfset FavPredFTSuccess = oFavFTpct*100>

<cfset oUndFGpct = (GetUndOff.fgratefor + GetFavDef.fgrategiv)/2>
<cfset oUndTPpct = (GetUndOff.TPratefor + GetFavDef.TPrategiv)/2>
<cfset oUndTOpct = (GetUndOff.TORateFor + GetFavDef.TORategiv)/2>
<cfset oUndFTpct = GetUndOff.FTRateFor>

<cfset UndPredFGSuccess = oUndFgpct*100>
<cfset UndPredTPSuccess = oUndTPpct*100>
<cfset UndPredFTSuccess = oUndFTpct*100>


<cfoutput>
 oFavFGpct = #oFavFGpct#<br>
 oFavTPpct = #oFavTPpct#<br>
 oFavTOpct = #oFavTOpct#<br>
 oFavFTpct = #oFavFTpct#<br>
----------------------------------------------------<br>
 oUndFGpct = #oUndFGpct#<br>
 oUndTPpct = #oUndTPpct#<br>
 oUndTOpct = #oUndTOpct#<br>
 oUndFTpct = #oUndFTpct#<br>
-----------------------------------------------------<br>


<cfquery datasource="nbapospcts" name="GetDefFavDrivePct">
select team,
		fgatt as fg2ptpct,
		tpatt as fg3ptpct,
		turnovpct as turnovrpct,
		fouled,
		orebpct,
		drebpct,
		fgpct,
		tppct,
		topct,
		ftpct
		
from nbapospcts
Where Team = '#fav#'
and OffDef = 'D'
</cfquery>


<cfquery datasource="nbapospcts" name="GetDefUndDrivePct">
Select team, 
		fgatt as fg2ptpct,
		tpatt as fg3ptpct,
		turnovpct as turnovrpct,
		fouled,
		orebpct,
		drebpct,
		fgpct,
		tppct,
		topct,
		ftpct

from nbapospcts
Where Team = '#und#'
and OffDef = 'D'
</cfquery>



<cfquery datasource="nbapospcts" name="GetOffFavDrivePct">
Select team, 
		fgatt as fg2ptpct,
		tpatt as fg3ptpct,
		turnovpct as turnovrpct,
		fouled,
		orebpct,
		drebpct,
		fgpct,
		tppct,
		topct,
		ftpct

from nbapospcts
Where Team = '#fav#'
and OffDef = 'O'
</cfquery>


<cfquery datasource="nbapospcts" name="GetOffUndDrivePct">
Select team, 
		fgatt as fg2ptpct,
		tpatt as fg3ptpct,
		turnovpct as turnovrpct,
		fouled,
		orebpct,
		drebpct,
		fgpct,
		tppct,
		topct,
		ftpct

from nbapospcts
Where Team = '#fav#'
and OffDef = 'O'
</cfquery>

<br>
<br>
</cfoutput>


<!-- Create the range of numbers to use in the simulation for each stat -->
<!-- 2pt Att -->
<cfset FavPlayFGAttNum   = (GetOffFavDrivePct.fg2ptpct + GetDefUndDrivePct.fg2ptpct)/2*100> 

<!-- 3pt Att -->
<cfset FavPlayTpAttNum   = (GetOffFavDrivePct.fg3ptpct + GetDefUndDrivePct.fg3ptpct)/2*100> 

<!-- Fouled -->
<cfset FavPlayFouled     = (GetOffFavDrivePct.fouled + GetDefUndDrivePct.fouled)/2*100> 

<!-- Turnover -->
<cfset FavPlayTurnoverNum   = (GetOffFavDrivePct.turnovrpct + GetDefUndDrivePct.turnovrpct)/2*100 > 




<!-- Predicted Offensive FG Pcts -->
<cfset FavPredFGpct  = ((GetOffFavDrivePct.Fgpct + GetDefUndDrivePct.fgpct)/2)*100>
<cfset UndPredFGpct  = ((GetOffUndDrivePct.Fgpct + GetDefFavDrivePct.fgpct)/2)*100>

<!-- Predicted Offensive 3pFG Pcts -->
<cfset FavPredTPpct  = ((GetOffFavDrivePct.TPpct + GetDefUndDrivePct.TPpct)/2)*100>
<cfset UndPredTPpct  = ((GetOffUndDrivePct.TPpct + GetDefFavDrivePct.TPpct)/2)*100>

<!-- Predicted Offensive FThrow Pcts -->
<cfset FavPredFTpct  = (GetOffFavDrivePct.FTpct*100)>
<cfset UndPredFTpct  = (GetOffUndDrivePct.FTpct*100)>


<!-- Predicted Offensive Rebound pcts -->
<cfset FavPredOffReb = ((GetOffFavDrivePct.Orebpct + GetDefUndDrivePct.Orebpct)/2)*100>
<cfset UndPredOffReb = ((GetOffUndDrivePct.Orebpct + GetDefFavDrivePct.Orebpct)/2)*100>

<cfoutput>
FavPredOffReb = #FavPredOffReb#<br> 
UndPredOffReb = #UndPredOffReb#<br>
-----------------------------------------------------------------------
</cfoutput>


<!-- Predicted Defensive Rebound pcts -->
<cfset FavPredDefReb = ((GetOffFavDrivePct.drebpct + GetDefUndDrivePct.drebpct)/2)*100>
<cfset UndPredDefReb = ((GetOffUndDrivePct.drebpct + GetDefFavDrivePct.drebpct)/2)*100>

<cfoutput>
<br>
FavPredDefReb = #FavPredDefReb#<br> 
UndPredDefReb = #UndPredDefReb#<br>
-----------------------------------------------------------------------
</cfoutput>



<cfset FavFinalReb = (FavPredOffReb + FavPredDefReb)/2>
<cfset UndFinalReb = (UndPredOffReb + UndPredDefReb)/2>

<cfoutput>
<br>
FavFinalReb = #FavFinalReb#<br> 
UndFinalReb = #UndFinalReb#<br> 
-----------------------------------------------------------------------
</cfoutput>




<cfif FavFinalReb - UndFinalReb gt 0>
	<cfset addit = FavFinalReb - UndFinalReb>
	<cfset FavFinalReb = FavPredOffReb + (FavFinalReb - UndFinalReb)>
	<cfset UndFinalReb = UndPredOffReb>
<cfelse>
	<cfset addit = UndFinalReb - FavFinalReb>
	<cfoutput>addit is #addit#</cfoutput>
	<cfset UndFinalReb = UndPredOffReb + addit>
	<cfset FavFinalReb = FavPredOffReb>
</cfif>



<!-- Create the range of numbers to use in the simulation for each stat -->
<!-- 2pt Att -->
<cfset UndPlayFGAttNum   = (GetOffUndDrivePct.fg2ptpct + GetDefFavDrivePct.fg2ptpct)/2*100> 

<!-- 3pt Att -->
<cfset UndPlayTpAttNum   = (GetOffUndDrivePct.fg3ptpct + GetDefFavDrivePct.fg3ptpct)/2*100> 

<!-- Fouled -->
<cfset UndPlayFouled     = (GetOffUndDrivePct.fouled + GetDefFavDrivePct.fouled)/2*100> 

<!-- Turnover -->
<cfset UndPlayTurnoverNum   = (GetOffUndDrivePct.turnovrpct + GetDefFavDrivePct.turnovrpct)/2*100 > 


<cfoutput>
<BR>
FavPlayFGAttNum    = #FavPlayFGAttNum#<br>
FavPlayTpAttNum    = #FavPlayTpAttNum#<br>
FavPredFouled      = #FavPlayFouled#<br>
FavPlayTurnoverNum = #FavPlayTurnoverNum#<br>
FavPredictedOffReb = #FavFinalReb#<br>
FavPredFGpct       = #FavPredFGpct#<br>
FavPredTPpct       = #FavPredTPpct#<br>
FavPredFTpct       = #FavPredFTpct#<br>
============================================================================<br><br>
</cfoutput>



<cfoutput>
UndPlayFGAttNum    = #UndPlayFGAttNum#<br>
UndPlayTpAttNum    = #UndPlayTpAttNum#<br>
UndPredFouled      = #UndPlayFouled#<br>
UndPlayTurnoverNum = #UndPlayTurnoverNum#<br>
UndPredictedOffReb = #UndFinalReb#<br>
UndPredFGpct       = #UndPredFGpct#<br>
UndPredTPpct       = #UndPredTPpct#<br>
UndPredFTpct       = #UndPredFTpct#<br>
============================================================================<br><br>
</cfoutput>
<!--- <cfoutput>
FavDriveTotal is: #FavDriveTotal#........UndDriveTotal is: #UndDriveTotal#........<br>
</cfoutput>
 --->
 
 
 
<cfset FavTotalPoints   = 0>
<cfset UndTotalPoints   = 0>
<cfset FavAvgPoints     = 0>
<cfset UndAvgPoints     = 0>
<cfset FavCovPct        = 0>
<cfset UndCovPct        = 0>
<cfset FavWinPct        = 0>
<cfset UndWinPct        = 0>

<!--- <cfset fav = '#favname#'>
<cfset und = '#undname#'>
 --->
<cfset variables.Possesion    = '#Fav#'>

<cfset FavCovCt         = 0>
<cfset UndCovCt         = 0>
<cfset FavScore         = 0>
<cfset UndScore         = 0> 
<cfset AddPoints        = 0>
<CFSET GAMECT           = 0>
<cfset FavPosDone       = false>
<cfset UndPosDone       = false>

<!--- Loop for each game simulated --->
<cfloop index="simct" from="1" to="100">
	
	<cfif Possesion is '#Fav#'>
		<cfset chkTurnoverpct = FavPlayTurnoverNum>
		<cfset chkFoulpct      = FavPlayFouled> 
	<cfelse>
		<cfset chkTurnoverpct = UndPlayTurnoverNum>
		<cfset chkFoulpct       = UndPlayFouled> 
	</cfif>
	
	<cfset FavDriveCt       = 0>
	<cfset UndDriveCt       = 0>
	

	<cfoutput>
	Fav Predicted Possesions is: #FavFinalPos#<br>
	Und Predicted Possesions is: #undFinalPos#<br>
	</cfoutput>
	
	<cfset FavDriveTotal    = FavFinalPos>
	<cfset UndDriveTotal    = UndFinalPos> 
	
	<!---
	**********************************************************************************************************************
	Begin Game Simulation.....
	**********************************************************************************************************************
	--->
	<!--- <cfoutput>loopct is #loopct#...randomnum = #randomnumber#....#simfav#....#simund#</cfoutput> --->
	<cfscript>
 	Application.objRandom.setBounds(1,100);
	</cfscript>
	
	<cfset done = false>
	
	
	<cfloop condition="done is false">
		<cfset keeppossesion = false>
		<cfscript>
			Rn = Application.objRandom.next();
		</cfscript>
 		<!--- <cfoutput>
		Rn is: #rn#<br>
		</cfoutput> --->

		<cfif checkForTurnover(rn,chkTurnoverpct) is 'Y'>
			<cfoutput>
			Checking for turnover with #rn# leq #chkTurnoverpct#<br>
			</cfoutput>
			<cfset PossesionType = 'Turnover'>
			
		<cfelseif checkForFoul(rn,chkfoulpct) is 'Y'>
			<cfoutput>
			Checking for Foul with #rn# leq #chkfoulpct#<br>
			</cfoutput>
			
			<cfset PossesionType = 'Freethrow'>
		
		<cfelse>		
		<!-- Regular possesion -->
		
			<!--- See what type of possesion it is... --->
			<!--- <cfoutput>Possesion is for #Possesion#............<br></cfoutput> --->
			
			<cfif possesion is '#fav#'>
				<cfoutput>
				Checking Fav Stats #RN#,#FavPlayFGAttNum#,#FavPlayTpAttNum#,#FavPlayFouled#<br> 
				</cfoutput>
				<cfset checkrebound = FavFinalReb> 
				<Cfset PossesionType = getPossesionType(RN,FavPlayFGAttNum,FavPlayTpAttNum,FavPlayFouled)>
			<cfelse>
				<cfoutput>
				 Checking Und Stats #RN#,#UndPlayFGAttNum#,#UndPlayTpAttNum#,#UndPlayFouled#<br> 
				</cfoutput>
				<cfset checkrebound = UndFinalReb> 
				<Cfset PossesionType = getPossesionType(Rn,UndPlayFGAttNum,UndPlayTpAttNum,UndPlayFouled)>
			</cfif>
		</cfif>
		
			<cfoutput>
			<!--- Posessiontype is #PossesionType#<br> --->
			</cfoutput>

			<cfswitch expression="#PossesionType#">
		
			<cfcase value="2ptFGAtt">
				<cfif possesion is '#fav#'>
					<cfoutput>
					Checking #Fav# 2ptFgattRate of #FavPredfGpct#<br> 
					</cfoutput>
					<cfset checkpct = #FavPredfGpct#>
				<cfelse>
					<cfoutput>
					Checking #Und# 2ptFgattRate of #UndPredfGpct#<br>
					</cfoutput>
					<cfset checkpct = #UndPredfGpct#>
				</cfif>
			</cfcase>
			
			<cfcase value="3ptFGAtt">
				<cfif possesion is '#fav#'>
					<cfoutput>
					Checking #Fav# 3ptFgattRate of #FavPredTPpct#<br>
					</cfoutput>
					<cfset checkpct = #FavPredTPpct#>
				<cfelse>
					<cfoutput>
					 Checking #Und# 3ptFgattRate of #UndPredTPpct#<br> 
					</cfoutput>
					<cfset checkpct = #UndPredTPpct#>
				</cfif>
			</cfcase>
			
			<cfcase value="Freethrow">
			
				<cfif possesion is '#fav#'>
					<cfoutput>
					 Checking #Fav# Free Throw Rate of #FavPredFTpct#<br> 
					</cfoutput>
					<cfset checkpct = #FavPredFTpct#>
					
				<cfelse>
					<cfoutput>
					 Checking #Und# Free Throw Rate of #UndPredFTpct#<br> 
					</cfoutput>
					<cfset checkpct = #UndPredFTPct#>
					
				</cfif>
			</cfcase>

			<cfcase value="Turnover">
				TURNOVER!!!!!!!<br>
			</cfcase>
			</cfswitch>
			
			<cfscript>
			Rn = Application.objRandom.next();
			</cfscript>

			<cfif PossesionType neq 'Turnover'>
		
			<!--- See if success or fail on the attempt... --->
			<cfif checkPosseionResult(rn,checkpct) is 'Success'>
				 Made shot!...<Br> 
				<cfif possesion is '#fav#'>
					<cfset FavScore = updateScore(FavScore,possesionType)>
					<cfoutput>FavScore is now #Favscore#<br></cfoutput>
				<cfelse>
					<cfset UndScore = updateScore(UndScore,possesionType)>
					 <cfoutput>UndScore is now #Undscore#<br></cfoutput>
				</cfif>
								
			<cfelse>
			    Missed shot...<br>
				<cfif PossesionType is '2ptFGAtt' or  PossesionType is '3ptFGAtt'>
					
					<cfscript>
					Rn = Application.objRandom.next();
					</cfscript>
				
					<!-- Check for rebound -->
					<cfset KeepPossesion = false>
					<cfoutput>
					 ************** About to check rebound percent of #checkrebound#<br>
					 Checking Rebound percent #checkrebound#<br> 
					</cfoutput>
					  
					<cfif GotTheRebound(rn,(checkrebound)) is 'Y'>
						*******===========================================>>>>>>>>>>>>>.Got the rebound!<br> 
						<cfoutput>Keep the ball for #possesion#...<br></cfoutput>
						<cfset KeepPossesion = true>
						<cfset PossesionType = 'Rebound'>
					</cfif>
					
				</cfif>
			</cfif>
			<cfelse>
				<cfset KeepPossesion = false>
			</cfif>	
 		<cfoutput>
		PossesionType is: #PossesionType#<br>
		</cfoutput>

	 	<cfoutput>
		Favscore is: #Favscore#=======Undscore is: #Undscore#=======<br>
		</cfoutput>
		
		<!--- Add 1 to Possesion Counters --->
		<cfif possesion is '#fav#' and FavPosDone is false and PossesionType neq 'Freethrow' >
			<cfset FavDriveCt = FavDriveCt + 1>
			<cfif FavDriveCt ge FavDriveTotal>
				<cfset FavPosDone = true>
			</cfif>
		</cfif>	
			
		<cfif possesion is '#und#' and UndPosDone is false and PossesionType neq 'Freethrow' >
			<cfset UndDriveCt = UndDriveCt + 1>
			<cfif UndDriveCt ge UndDriveTotal>
				<cfset UndPosDone = true>
			</cfif>
		</cfif>
		
		<cfif possesion is '#fav#'>
			<cfif KeepPossesion is false>
				<CFSET POSSESION = '#UND#'>
			<cfelse>
				<cfset FavDriveCt = FavDriveCt - 1>
			</cfif>	
				
		<cfELSE>
		
			<cfif KeepPossesion is false>
				<CFSET POSSESION = '#fav#'>
			<cfelse>
				<cfset UndDriveCt = UndDriveCt - 1>
			</cfif>	

		</CFIF>
		
		<cfif FavPosDone is true and UndPosDone is true>
			<cfset Done = true>
		</cfif>
		
 		<cfoutput>
		#FavDriveTotal# vs #FavDriveCt#<br>
		#UndDriveTotal# vs #UndDriveCt#<br>
		</cfoutput> 

		<cfoutput>
		Possesion is now over to #Possesion#......<br>
		</cfoutput>
	</cfloop>
	

	<cfif Ha is 'H'>
		
		<cfset FavTotalPoints   = FavTotalPoints + FavScore + 2.5>
		<cfset UndTotalPoints   = UndTotalPoints + UndScore>
		
		<cfset PredFavScore = FavScore + 2.5>
		<cfset PredUndScore = Undscore>
		<cfset PredMOV = PredFavScore - PredUndscore>
						
		<cfif PredMOV gt #Client.spread#>
				<cfset FavCovCt = FavCovCt + 1>
				<cfoutput>
	 			============>#fav#:#PredFavscore#....spd: #Client.spread#.....#und#:#PredUndscore#....Favorite covered.....#FavCovct#<br> 
				</cfoutput>
				<cfset gamect = gamect + 1>
		<cfelse>
			
			<cfif PredMOV lt #Client.spread#>
		
				<cfset UndCovCt = UndCovCt + 1>
				<cfoutput>
 				=====================>#fav#:#PredFavscore#....spd: #Client.spread#.....#und#:#PredUndscore#....Underdog covered.....#UndCovct#<br> 
				</cfoutput>
				<cfset gamect = gamect + 1>
			</cfif>
				
		</cfif>
		
		<cfif (Favscore + UndScore) gt myou>
			<cfset overcovct = overcovct + 1>
		</cfif>
				
	<cfelse>
	
		<cfset FavTotalPoints   = FavTotalPoints + FavScore>
		<cfset UndTotalPoints   = UndTotalPoints + UndScore + 2.5>

		<cfset PredFavScore = FavScore >
		<cfset PredUndScore = Undscore + 2.5>
		<cfset PredMOV = PredFavScore - PredUndscore>

	
		<cfif PredMOV gt #Client.spread#>
				<cfset FavCovCt = FavCovCt + 1>
				<cfoutput>
	 			============>#fav#:#PredFavscore#....spd: #Client.spread#.....#und#:#PredUndscore#....Favorite covered.....#FavCovct#<br> 
				</cfoutput>
				<cfset gamect = gamect + 1>
		<cfelse>
		
			<cfif PredMOV lt #Client.spread#>
		
				<cfset UndCovCt = UndCovCt + 1>
				<cfoutput>
 				=====================>#fav#:#PredFavscore#....spd: #Client.spread#.....#und#:#PredUndscore#....Underdog covered.....#UndCovct#<br> 
				</cfoutput>
				<cfset gamect = gamect + 1>
			</cfif>	
				
		</cfif>
	
		<cfif (Favscore + UndScore) gt myou>
			<cfset overcovct = overcovct + 1>
		</cfif>
		
	</cfif>	
<!--- 	<CFOUTPUT>
	******************************************#fAVSCORE#................#UNDSCORE#**************************
	</cfoutput>
 --->	
 

	<cfset FavScore         = 0>
	<cfset UndScore         = 0> 

	<cfset FavPosDone = false>
	<cfset UndPosDone = false>

</cfloop>
	
	<!--- After 500 games played....--->
	<cfset FavAvgPoints = Numberformat(FavTotalPoints/GAMECT,"99.99")>
	<cfset UndAvgPoints = Numberformat(UndTotalPoints/GAMECT,"99.99")>
	<Cfset FavCovPct    = Numberformat(FavCovCt/GAMECT,"99.99")>
	<Cfset UndCovPct    = Numberformat(UndCovCt/GAMECT,"99.99")>
	<Cfset OverCovPct   = Numberformat(OverCovCt/GAMECT,"99.99")>
	<br>
	<br>
	<cfset ourpick = ''>
	<cfset ourpickpct = 0>
	<cfset ouroupick = ''>
	<cfset ouroupickpct = 0>

<cfoutput>
********************************************<br>
#Fav# Avg PS: #FavAvgPoints#<br>
#und# Avg PS: #UndAvgPoints#<br>
#Fav# COVER PCT IS: #fAVCOVPCT#<br>
Over Cover Pct is: #OverCovpct#
********************************************<br>
</cfoutput>	
<!--- 
<cfif FavCovpct gt .50>
	We like the favorite, #Fav# predicted cover of #GetGames.spread# is #FavCovPct#
	<cfset ourpick = '#fav#'>
	<cfset ourpickpct = #FavCovPct#>
		
<cfelse>

	<cfset temp = 1 - #FavCovPct#>
	We like the Underdog, #Und# predicted cover of #GetGames.spread# is #temp#
	<cfset ourpick = '#und#'>
	<cfset ourpickpct = #temp#>

</cfif> 
<cfif OverCovpct gt .50>
	We like the OVER #myou#, predicted cover of #OverCovPct#
	<cfset ouroupick = 'OVER'>
	<cfset ouroupickpct = #OverCovPct#>

<cfelse>
	<cfset temp = 1 - #OverCovPct#>
	We like the UNDER #myou#, predicted cover of #temp#
	<cfset ouroupick = 'UNDER'>
	<cfset ouroupickpct = #temp#>

</cfif>  --->



	
<cfscript>

function checkForTurnover(rn,checkpct)
{
  	 if (rn lte checkpct)
	 	return 'Y';
	 else
	 {
	 	return 'N';	
	 }
}


function checkForFoul(rn,chkfoulpct)
{
  	 if (rn lte chkfoulpct)
	 	return 'Y';
	 else
	 {
	 	return 'N';	
	 }
}




function GotTheRebound(rn,checkrebound)
{
  	 if (rn lte checkrebound)
	 	return 'Y';
	 else
	 {
	 	return 'N';	
	 }
}
 
  function getPossesionType(rn,twoptrge,threeptrge,freethrowrge)
  { 
  
  	 if (rn lte twoptrge)
	 	return '2ptFGAtt';
	  
  	 
	 	return '3ptFGAtt';
   
  } 
</cfscript>

<cfscript> 
  function checkPosseionResult(rn,rge)
  { 
  
	if (rn lte rge)
	{
		return 'Success';
  	}
  
  	return 'Failed-checkPossesionResult';
   }
</cfscript>


<cfscript> 
  function updateScore(oldScore,playType)
  { 
  
	if (playType is '2ptFGAtt')
	{
		return oldScore + 2;
  	}
  
	if (playType is '3ptFGAtt')
	{
		return oldScore + 3;
  	}
  
  	if (playType is 'Freethrow')
	{
		return oldScore + 1;
  	}
  
  	return oldScore + 0;
   }
</cfscript>

<cfscript> 
  function updatePossCt(oldPossct)
  { 
   	return oldPossct + 1;
   }
</cfscript>


