
<!--- <cfquery name="Getone" datasource="psp_psp" >
	delete from RandomSim
</cfquery>
 --->

<cfscript>
 Application.objRandom = CreateObject("Component", "Random");
</cfscript>
  
<cfset Session.Week = 62>
<cfset Session.longyear = '2004'>


<cfset fav = 'SEA'>
<cfset und = 'LAC'>PICK
<cfset ha  = 'H'>
<cfset Client.spread = 2.5>
<cfset myou = 210.5>


<cfset fav = 'PHX'>
<cfset und = 'CLE'>
<cfset ha  = 'A'>
<cfset Client.spread = 5.5>
<cfset myou = 210.5>



<cfset fav = 'MIL'>
<cfset und = 'NYK'>PICK
<cfset ha  = 'H'>
<cfset Client.spread = 1.5>
<cfset myou = 210.5>

<cfset fav = 'SAS'>
<cfset und = 'LAL'>PICK
<cfset ha  = 'A'>
<cfset Client.spread = 3>
<cfset myou = 210.5>

<cfset fav = 'WAS'>
<cfset und = 'BOS'>PICK
<cfset ha  = 'A'>
<cfset Client.spread = 5>
<cfset myou = 210.5>

<cfset fav = 'DET'>
<cfset und = 'IND'>
<cfset ha  = 'H'>
<cfset Client.spread = 7>
<cfset myou = 210.5>

<cfset fav = 'ORL'>
<cfset und = 'ATL'>
<cfset ha  = 'A'>
<cfset Client.spread = 5.5>
<cfset myou = 210.5>




<cfset fav = 'CLE'>
<cfset und = 'GSW'>
<cfset ha  = 'H'>
<cfset Client.spread = 2>
<cfset myou = 204>

<cfset fav = 'IND'>
<cfset und = 'BOS'>Pick
<cfset ha  = 'H'>
<cfset Client.spread = 9>
<cfset myou = 188.5>

<cfset fav = 'NYK'>
<cfset und = 'LAL'>Pick
<cfset ha  = 'H'>
<cfset Client.spread = 2>
<cfset myou = 204>

<cfset fav = 'DAL'>
<cfset und = 'SEA'>Pick
<cfset ha  = 'H'>
<cfset Client.spread = 12.5>
<cfset myou = 198.5>

<cfset fav = 'WAS'>
<cfset und = 'DET'>
<cfset ha  = 'H'>
<cfset Client.spread = 2>
<cfset myou = 203>


<cfset fav = 'MIA'>
<cfset und = 'MIL'>
<cfset ha  = 'H'>
<cfset Client.spread = 8>
<cfset myou = 203>





------------------------
<cfset fav = 'ORL'>
<cfset und = 'ATL'>
<cfset ha  = 'A'>
<cfset Client.spread = 4>
<cfset myou = 180.5>

<cfset fav = 'NOK'>
<cfset und = 'POR'>
<cfset ha  = 'H'>
<cfset Client.spread = 5.5>
<cfset myou = 179>

<cfset fav = 'SAC'>
<cfset und = 'MEM'>
<cfset ha  = 'A'>
<cfset Client.spread = 1>
<cfset myou = 179>

<cfset fav = 'PHX'>
<cfset und = 'MIN'>
<cfset ha  = 'A'>
<cfset Client.spread = 5>
<cfset myou = 210.4>


<cfset fav = 'UTA'>
<cfset und = 'NJN'>
<cfset ha  = 'H'>
<cfset Client.spread = 3>
<cfset myou = 179>
--------------------------------------------------

<cfset fav = 'TOR'>Pick
<cfset und = 'WAS'>
<cfset ha  = 'H'>
<cfset Client.spread = 3.5>
<cfset myou = 179>


<cfset fav = 'GSW'>
<cfset und = 'ATL'>Pick
<cfset ha  = 'A'>
<cfset Client.spread = 1>
<cfset myou = 179>

<cfset fav = 'CHA'>
<cfset und = 'NYK'>
<cfset ha  = 'H'>
<cfset Client.spread = 3	>
<cfset myou = 179>

<cfset fav = 'LAC'>
<cfset und = 'CHI'>
<cfset ha  = 'H'>
<cfset Client.spread = 3>
<cfset myou = 179>

<cfset fav = 'NJN'>
<cfset und = 'DET'>
<cfset ha  = 'H'>
<cfset Client.spread = 1>
<cfset myou = 179>

<cfset fav = 'SAS'>
<cfset und = 'UTA'>
<cfset ha  = 'A'>
<cfset Client.spread = 5>
<cfset myou = 179>

<cfset fav = 'LAL'>
<cfset und = 'BOS'>
<cfset ha  = 'A'>
<cfset Client.spread = 6.5>
<cfset myou = 179>

<cfset fav = 'LAC'>
<cfset und = 'CHI'>
<cfset ha  = 'H'>
<cfset Client.spread = 3.5>
<cfset myou = 179>

<cfset fav = 'GSW'>
<cfset und = 'ATL'>
<cfset ha  = 'A'>
<cfset Client.spread = 1>
<cfset myou = 179>

<cfset fav = 'CHA'>
<cfset und = 'NYK'>
<cfset ha  = 'H'>
<cfset Client.spread = 2.5>
<cfset myou = 179>


<cfset fav = 'ORL'>
<cfset und = 'MIL'>
<cfset ha  = 'H'>
<cfset Client.spread = 8>
<cfset myou = 179>


<cfset fav = 'HOU'>
<cfset und = 'SEA'>Pick
<cfset ha  = 'H'>
<cfset Client.spread = 10.5>
<cfset myou = 179>

<cfset fav = 'NJN'>Pick
<cfset und = 'DET'>
<cfset ha  = 'H'>
<cfset Client.spread = 1.5>
<cfset myou = 179>

<cfset fav = 'TOR'>
<cfset und = 'WAS'>
<cfset ha  = 'H'>
<cfset Client.spread = 4.5>
<cfset myou = 179>

<cfset fav = 'DAL'>
<cfset und = 'MEM'>
<cfset ha  = 'A'>
<cfset Client.spread = 7.5>
<cfset myou = 179>

<cfset fav = 'MIN'>Pick
<cfset und = 'SAC'>
<cfset ha  = 'H'>
<cfset Client.spread = 5>
<cfset myou = 179>
---------------------------------------------------

<cfset fav = 'PHX'>Pick
<cfset und = 'SAS'>
<cfset ha  = 'H'>
<cfset Client.spread = 6>
<cfset myou = 179>

<cfset fav = 'MIA'>Pick
<cfset und = 'CLE'>
<cfset ha  = 'H'>
<cfset Client.spread = 5.5>
<cfset myou = 193.5>

<cfset fav = 'CHA'>Pick
<cfset und = 'GSW'>
<cfset ha  = 'H'>
<cfset Client.spread = 3>
<cfset myou = 193.5>

<cfset fav = 'WAS'>
<cfset und = 'LAL'>Pick
<cfset ha  = 'H'>
<cfset Client.spread = 5.5>
<cfset myou = 193.5>

<cfset fav = 'IND'>
<cfset und = 'MEM'>Pick
<cfset ha  = 'A'>
<cfset Client.spread = 1>
<cfset myou = 193.5>

<cfset fav = 'DAL'>
<cfset und = 'MIN'>Pick
<cfset ha  = 'H'>
<cfset Client.spread = 10.5>
<cfset myou = 193.5>

<cfset fav = 'PHX'>
<cfset und = 'UTA'>Pick
<cfset ha  = 'H'>
<cfset Client.spread = 11.5>
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
Select Avg(ofga + ofta) as TotalPos ,
       (Avg(oReb) / Avg(ofga))*100 as OffRebFor,
	   (Avg(oDreb) / Avg(dfga))*100 as DefrebFor,
	   (Avg(oSteals) / Avg(dfga))*100 as StealsFor,
	   (Avg(dTurnovers) / Avg(dfga))*100 as ToFor,
	   (Avg(oFta) / Avg(ofta + ofga))*100 as FouledFor,
	  (Avg(oReb) / Avg(ofga)) + (Avg(oDreb) / Avg(dfga)) + (Avg(oSteals) / Avg(dfga)) + (Avg(dTurnovers) / Avg(dfga))*100 as RegPosFor,
	   Avg(ofgm) / Avg(ofga) as fgRate,
	   Avg(otpm) / Avg(ofga) as tpRate,
	   Avg(oftm) / Avg(ofta) as ftRate
	   
 from nbadata
  where Team = '#fav#'
</cfquery>



<cfoutput query="GetFavOff">
<br>
Tot Pos: #TotalPos#<br>
Off Reb: #OffRebFor#<br>
Def Reb: #DefrebFor#<br>
Steals: #StealsFor#<br>
TO For: #ToFor#<br>
Fouls For: #FouledFor#<br>
Reg Pos: #RegPosFor#<br>
FGRate: #fgRate#<br>
3pRate: #tpRate#<br>
FT Rate: #ftRate#
</cfoutput>


<cfquery  datasource="nbastats" name="GetFavDef">
Select 
		Avg(dfga + dfta) as TotalPosG,
       (Avg(dReb) / Avg(dfga))*100 as OffRebG,
	   (Avg(dDreb) / Avg(ofga))*100 as DefrebG,
	   (Avg(dSteals) / Avg(ofga))*100 as StealsG,
 	   (Avg(oTurnovers) / Avg(ofga))*100 as ToG,
	   (Avg(dFta) / Avg(dfta + dfga))*100 as FouledG,
	   (Avg(dReb) / Avg(dfga)) + (Avg(dDreb) / Avg(ofga)) + (Avg(dSteals) / Avg(ofga)) + (Avg(oTurnovers) / Avg(ofga))*100 as RegPosG,
	   Avg(dfgm) / Avg(dfga) as fgRate,
	   Avg(dtpm) / Avg(dfga) as tpRate,
	   Avg(dftm) / Avg(dfta) as ftRate 
 from nbadata where Team = '#fav#'
</cfquery>
<br>
*******************************************************************************************************<br>
<cfoutput query="GetFavDef">
<br>
Tot Pos Given: #TotalPosg#<br>
Off Reb Given: #OffRebg#<br>
Def Reb Given:: #Defrebg#<br>
Steals Given:: #Stealsg#<br>
TO For Given:: #Tog#<br>
Fouls For Given:: #Fouledg#<br>
Reg Pos Given:: #RegPosg#<br>
FGRate Given:: #fgRate#<br>
3pRate Given:: #tpRate#<br>
FT Rate Given:: #ftRate#
</cfoutput>



<cfquery  datasource="nbastats" name="GetUndOff">
Select Avg(ofga + ofta) as TotalPos,
       Avg(oReb) / Avg(ofga)*100 as OffRebFor,
	   Avg(oDreb) / Avg(dfga)*100 as DefRebFor,
	   Avg(oSteals) / Avg(dfga)*100 as StealsFor,
	   Avg(dTurnovers) / Avg(dfga)*100 as ToFor,
	   (Avg(oFta) / Avg(ofta + ofga))*100 as Fouledfor,
   	   (Avg(oReb) / Avg(ofga)) + (Avg(oDreb) / Avg(dfga)) + (Avg(oSteals) / Avg(dfga)) + (Avg(dTurnovers) / Avg(dfga))*100 as RegPosFor,
	   Avg(ofgm) / Avg(ofga) as fgRate,
	   Avg(otpm) / Avg(ofga) as tpRate,
	   Avg(oftm) / Avg(ofta) as ftRate
 from nbadata where Team = '#und#'
</cfquery>

<br>
*************************************************************************************
<br>
<cfoutput query="GetUndOff">
<br>
Tot Pos: #TotalPos#<br>
Off Reb: #OffRebFor#<br>
Def Reb: #DefrebFor#<br>
Steals: #StealsFor#<br>
TO For: #ToFor#<br>
Fouls For: #FouledFor#<br>
Reg Pos: #RegPosFor#<br>
FGRate: #fgRate#<br>
3pRate: #tpRate#<br>
FT Rate: #ftRate#
</cfoutput>


<br>
*************************************************************************************
<br>


<cfquery  datasource="nbastats" name="GetUndDef">
Select 
		Avg(dfga + dfta) as TotalPosG,
       (Avg(dReb) / Avg(dfga))*100 as OffRebG,
	   (Avg(dDreb) / Avg(ofga))*100 as DefrebG,
	   (Avg(dSteals) / Avg(ofga))*100 as StealsG,
 	   (Avg(oTurnovers) / Avg(ofga))*100 as ToG,
	   (Avg(dFta) / Avg(dfta + dfga))*100 as FouledG,
	   (Avg(dReb) / Avg(dfga)) + (Avg(dDreb) / Avg(ofga)) + (Avg(dSteals) / Avg(ofga)) + (Avg(oTurnovers) / Avg(ofga))*100 as RegPosG,
	   Avg(dfgm) / Avg(dfga) as fgRate,
	   Avg(dtpm) / Avg(dfga) as tpRate,
	   Avg(dftm) / Avg(dfta) as ftRate 
 from nbadata where Team = '#Und#'
</cfquery>


<cfquery  datasource="nbastats" name="GetFavDrivePct">
Select 
		Fgatt,
        Tpatt,
		fgpct,
		tppct,
		ftpct,
		Turnovpct,
	    Fouled,
		orebpct,
		drebpct,
		RegPos
 from nbapospcts where Team = '#Fav#' and OffDef='O'
</cfquery>


<cfquery  datasource="nbastats" name="GetUndDrivePct">
Select 
		Fgatt,
        Tpatt,
		fgpct,
		tppct,
		ftpct,
		Turnovpct,
	    Fouled,
		orebpct,
		drebpct,
		RegPos
 from nbapospcts where Team = '#Und#' and OffDef='O'
</cfquery>


<cfquery  datasource="nbastats" name="GetFavDriveDefPct">
Select 
		Fgatt,
        Tpatt,
		fgpct,
		tppct,
		ftpct,
		Turnovpct,
	    Fouled,
		orebpct,
		drebpct,
		RegPos
 from nbapospcts where Team = '#Fav#' and OffDef='D'
</cfquery>


<cfquery  datasource="nbastats" name="GetUndDriveDefPct">
Select 
		Fgatt,
        Tpatt,
		fgpct,
		tppct,
		ftpct,
		Turnovpct,
	    Fouled,
		orebpct,
		drebpct,
		RegPos
 from nbapospcts where Team = '#Und#' and OffDef='D'
</cfquery>



<cfset FavPos = (GetFavDrivePct.Regpos + GetUndDriveDefPct.Regpos)/2>
<cfset UndPos = (GetUndDrivePct.Regpos + GetFavDriveDefPct.Regpos)/2>



<cfoutput query="GetUndDef">
<br>
Tot Pos Given: #TotalPosg#<br>
Off Reb Given: #OffRebg#<br>
Def Reb Given:: #Defrebg#<br>
Steals Given:: #Stealsg#<br>
TO For Given:: #Tog#<br>
Fouls For Given:: #Fouledg#<br>
Reg Pos Given:: #RegPosg#<br>
FGRate Given:: #fgRate#<br>
3pRate Given:: #tpRate#<br>
FT Rate Given:: #ftRate#
</cfoutput>

<!--- Offensive Rebounds --->
<cfset PredFavOffReb = (GetFavOff.OffRebFor + GetUndDef.OffRebG)/2>
<cfset PredUndOffReb = (GetUndOff.OffRebFor + GetFavDef.OffRebG)/2>

<!--- Defensive Rebounds --->
<cfset PredFavDefReb = (GetFavOff.DefRebFor + GetUndDef.DefRebG)/2>
<cfset PredUndDefReb = (GetUndOff.DefRebFor + GetFavDef.DefRebG)/2>

<!--- Steals --->
<cfset PredFavSteals = (GetFavOff.StealsFor + GetUndDef.StealsG)/2>
<cfset PredUndSteals = (GetUndOff.StealsFor + GetFavDef.StealsG)/2>

<!--- Turnovers --->
<cfset PredFavTurnoversFor = (GetFavOff.ToFor + GetUndDef.ToG)/2>
<cfset PredUndTurnoversFor = (GetUndOff.ToFor + GetFavDef.ToG)/2>

<!--- Possesions --->


<br>
<br>
<cfoutput>

-----------------------------------------------<br>
PredFavOffReb = #PredFavOffReb#<br>
PredUndOffRed = #PredUndOffReb#<br>
-----------------------------------------------<br>
PredFavDefReb = #PredFavDefReb#<br>
PredUndDefReb = #PredUndDefReb#<br>
-----------------------------------------------<br>
PredFavSteals = #PredFavSteals#<br>
PredUndSteals = #PredUndSteals#<br>
-----------------------------------------------<br>
PredFavTurnoversFor = #PredFavTurnoversFor#<br>
PredUndTurnoversFor = #PredUndTurnoversFor#<br>

</cfoutput>


<cfset oFavFGpct = #GetFavDrivePct.fgpct#>
<cfset oFavTPpct = #GetFavDrivePct.tppct#>
<cfset oFavTOpct = #GetFavOff.TOFor#>
<cfset oFavFTpct = #GetFavDrivePct.FTpct#>
<cfset oFavFouled = #GetFavOff.Fouledfor#>

<cfset oUndFGpct = #GetUndDrivePct.fgpct#>
<cfset oUndTPpct = #GetUndDrivePct.tppct#>
<cfset oUndTOpct = #GetUndOff.TOfor#>
<cfset oUndFTpct = #GetUndDrivePct.FTpct#>
<cfset oUndFouled    = #GetUndOff.Fouledfor#>


<cfset dFavFGpct = #GetFavDef.FGrate#>
<cfset dFavTPpct = #GetFavDef.TPrate#>
<cfset dFavTOpct = #GetFavDef.TOg#>
<cfset dFavFTpct = #GetFavDef.FTRate#>
<cfset dFavFouled = #GetFavDef.Fouledg#>

<cfset dUndFGpct = #GetUndDef.FGrate#>
<cfset dUndTPpct = #GetUndDef.TPrate#>
<cfset dUndTOpct = #GetUndDef.TOg#>
<cfset dUndFTpct = #GetUndDef.FTrate#>
<cfset dUndFouled = #GetUndDef.Fouledg#>




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
<br>
<br>
</cfoutput>

<!-- Create the overall predicted Success percecnts -->
<cfset FavPredFGSuccess = ((oFavFGpct + dUndFGpct)/2)*100> 
<cfset FavPredTPSuccess = ((oFavTPpct + dUndTPpct)/2)*100> 
<cfset FavPredTOSuccess = (oFavTOpct + dUndTOpct)/2> 
<cfset FavPredFTSuccess = oFavFTpct*100> 

<cfset UndPredFGSuccess = ((oUndFGpct + dFavFGpct)/2)*100> 
<cfset UndPredTPSuccess = ((oUndTPpct + dFavTPpct)/2)*100> 
<cfset UndPredTOSuccess = (oUndTOpct + dFavTOpct)/2> 
<cfset UndPredFTSuccess = oUndFTpct*100> 



<!-- Create the range of numbers to use in the simulation for each stat -->
<!-- 2pt Att -->
<cfset FavPlayFGAttNum   = (GetFavDrivePct.Fgatt*100)> 

<!-- 3pt Att -->
<cfset FavPlayTpAttNum   = (GetFavDrivePct.TPatt*100) + FavPlayFGAttNum > 

<!-- Fouled -->
<cfset FavPlayFouled     = (GetFavDrivePct.Fouled*100) + FavPlayTpAttNum > 

<!-- Turnover -->
<cfset FavPlayTurnoverNum   = FavPlayFouled + 1>

<cfoutput>
FavPlayFGAttNum    = #FavPlayFGAttNum#<br>
FavPlayTpAttNum    = #FavPlayTpAttNum#<br>
FavPredFouled      = #FavPlayFouled#<br>
FavPlayTurnoverNum = #FavPlayTurnoverNum#<br>

============================================================================<br><br>
</cfoutput>

<cfset FavPredReb = GetFavDrivePct.Orebpct*100>
<cfset UndPredReb = GetUndDrivePct.Orebpct*100>

<!-- Create the range of numbers to use in the simulation for each stat -->
<!-- 2pt Att -->
<cfset UndPlayFGAttNum   = (GetUndDrivePct.Fgatt*100)> 

<!-- 3pt Att -->
<cfset UndPlayTpAttNum   = (GetUndDrivePct.TPatt*100) + UndPlayFGAttNum > 

<!-- Fouled -->
<cfset UndPlayFouled     = (GetUndDrivePct.Fouled*100) + UndPlayTpAttNum > 

<!-- Turnover -->
<cfset UndPlayTurnoverNum   = UndPlayFouled + 1>

<cfoutput>
UndPlayFGAttNum    = #UndPlayFGAttNum#<br>
UndPlayTpAttNum    = #UndPlayTpAttNum#<br>
UndPredFouled      = #UndPlayFouled#<br>
UndPlayTurnoverNum = #UndPlayTurnoverNum#<br>
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
<cfloop index="simct" from="1" to="500">
	<cfset FavDriveCt       = 0>
	<cfset UndDriveCt       = 0>
	
	<cfset PredFavPos = FavPos + (PredFavOffReb+PredFavDefReb+PredFavSteals+PredFavTurnoversFor)>
	<cfset PredUndPos = UndPos + (PredUndOffReb+PredUndDefReb+PredUndSteals+PredUndTurnoversFor)>

	<cfoutput>
	Fav Predicted Possesions is: #PredFavPos#<br>
	Und Predicted Possesions is: #PredUndPos#<br>
	</cfoutput>
	
	<cfset FavDriveTotal    = PredFavPos>
	<cfset UndDriveTotal    = PredUndPos> 
	
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

				
		<!-- Regular possesion -->
		
			<!--- See what type of possesion it is... --->
			<!--- <cfoutput>Possesion is for #Possesion#............<br></cfoutput> --->
			
			<cfif possesion is '#fav#'>
				<cfoutput>
				<!--- Checking Fav Stats #RN#,#FavPlayFGAttNum#,#FavPlayTpAttNum#,#FavPlayFouled#<br> --->
				</cfoutput>
				<cfset checkrebound = FavPredReb> 
				<Cfset PossesionType = getPossesionType(RN,FavPlayFGAttNum,FavPlayTpAttNum,FavPlayFouled)>
			<cfelse>
				<cfoutput>
				<!--- Checking Und Stats #RN#,#UndPlayFGAttNum#,#UndPlayTpAttNum#,#UndPlayFouled#<br> --->
				</cfoutput>
				<cfset checkrebound = UndPredReb> 
				<Cfset PossesionType = getPossesionType(Rn,UndPlayFGAttNum,UndPlayTpAttNum,UndPlayFouled)>
			</cfif>

			<cfoutput>
			<!--- Posessiontype is #PossesionType#<br> --->
			</cfoutput>

			<cfswitch expression="#PossesionType#">
		
			<cfcase value="2ptFGAtt">
				<cfif possesion is '#fav#'>
					<cfoutput>
					<!--- Checking #Fav# 2ptFgattRate of #FavPredFGSuccess#<br> --->
					</cfoutput>
					<cfset checkpct = #FavPredFGSuccess#>
				<cfelse>
					<cfoutput>
					<!--- Checking #Und# 2ptFgattRate of #UndPredFGSuccess#<br> --->
					</cfoutput>
					<cfset checkpct = #UndPredFGSuccess#>
				</cfif>
			</cfcase>
			
			<cfcase value="3ptFGAtt">
				<cfif possesion is '#fav#'>
					<cfoutput>
					<!--- Checking #Fav# 3ptFgattRate of #FavPredTPSuccess#<br> --->
					</cfoutput>
					<cfset checkpct = #FavPredTPSuccess#>
				<cfelse>
					<cfoutput>
					<!--- Checking #Und# 3ptFgattRate of #UndPredTPSuccess#<br> --->
					</cfoutput>
					<cfset checkpct = #UndPredTPSuccess#>
				</cfif>
			</cfcase>
			
			<cfcase value="Freethrow">
			
				<cfif possesion is '#fav#'>
					<cfoutput>
					<!--- Checking #Fav# Free Throw Rate of #FavPredFTSuccess#<br> --->
					</cfoutput>
					<cfset checkpct = #FavPredFTSuccess#>
					
				<cfelse>
					<cfoutput>
					<!--- Checking #Und# Free Throw Rate of #UndPredFTSuccess#<br> --->
					</cfoutput>
					<cfset checkpct = #UndPredFTSuccess#>
					
				</cfif>
			</cfcase>

			<cfcase value="Turnover">
				
			</cfcase>
			</cfswitch>
			
			<cfscript>
			Rn = Application.objRandom.next();
			</cfscript>

			<cfif PossesionType neq 'Turnover'>
		
			<!--- See if success or fail on the attempt... --->
			<cfif checkPosseionResult(rn,checkpct) is 'Success'>
				<!--- Made shot!...<Br> --->
				<cfif possesion is '#fav#'>
					<cfset FavScore = updateScore(FavScore,possesionType)>
					<!--- <cfoutput>FavScore is now #Favscore#<br></cfoutput> --->
				<cfelse>
					<cfset UndScore = updateScore(UndScore,possesionType)>
					<!--- <cfoutput>UndScore is now #Undscore#<br></cfoutput> --->
				</cfif>
								
			<cfelse>
			    <!--- Missed shot...<br> --->
				<cfif PossesionType is '2ptFGAtt' or  PossesionType is '3ptFGAtt'>
					
					<cfscript>
					Rn = Application.objRandom.next();
					</cfscript>
				
					<!-- Check for rebound -->
					<cfset KeepPossesion = false>
					<cfoutput>
					<!--- ************** About to check rebound percent of #checkrebound#<br> --->
					<!--- Checking Rebound percent #checkrebound#<br> --->
					</cfoutput>
					  
					<cfif GotTheRebound(rn,(checkrebound)) is 'Y'>
						<!--- *******Got the rebound!<br> --->
						<!--- <cfoutput>Keep the ball for #possesion#...<br></cfoutput> --->
						<cfset KeepPossesion = true>
					</cfif>
					
				</cfif>
			</cfif>
			<cfelse>
				<cfset KeepPossesion = false>
			</cfif>	
<!--- 		<cfoutput>
		PossesionType is: #PossesionType#<br>
		</cfoutput>
 --->		
		


	<!--- 	<cfoutput>
		Favscore is: #Favscore#=======Undscore is: #Undscore#=======<br>
		</cfoutput> --->
		
		<!--- Add 1 to Possesion Counters --->
		<cfif possesion is '#fav#' and FavPosDone is false>
			<cfset FavDriveCt = FavDriveCt + 1>
			<cfif FavDriveCt ge FavDriveTotal>
				<cfset FavPosDone = true>
			</cfif>
		</cfif>	
			
		<cfif possesion is '#und#' and UndPosDone is false>
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
		
 		<!--- <cfoutput>
		#FavDriveTotal# vs #FavDriveCt#<br>
		#UndDriveTotal# vs #UndDriveCt#<br>
		</cfoutput> --->

		<!--- <cfoutput>
		Possesion is now #Possesion#......<br>
		</cfoutput> --->
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
	  
  	 if (rn lte threeptrge)
	 	return '3ptFGAtt';
  
  	 if (rn lte freethrowrge)
	 	return 'Freethrow';

	return 'Turnover';	
	 
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


