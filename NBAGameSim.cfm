
<!--- <cfquery name="Getone" datasource="psp_psp" >
	delete from RandomSim
</cfquery>
 --->

<cfscript>
 Application.objRandom = CreateObject("Component", "Random");
</cfscript>
  
<cfset Session.Week = 62>
<cfset Session.longyear = '2004'>
<cfset fav = 'LAC'>
<cfset und = 'NJN'>
<cfset ha  = 'H'>
<cfset Client.spread = 7>
<cfset myou = 205>
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


<cfquery  datasource="nbapospcts" name="GetFavPcts">
Select * from nbapospcts where Team = '#fav#' and Offdef = 'O'
</cfquery>

<cfquery  datasource="nbapospcts" name="GetUndPcts">
Select * from nbapospcts where Team = '#und#' and Offdef = 'O'
</cfquery>


<cfset oFavFGpct = #GetFavPcts.FGpct#>
<cfset oFavTPpct = #GetFavPcts.TPpct#>
<cfset oFavTOpct = #GetFavPcts.TOpct#>
<cfset oFavFTpct = #GetFavPcts.FTpct#>

<cfset oFavPos   = #GetFavPcts.Pos#>
<cfset oFavFgattpct = #GetFavPcts.FGatt#>
<cfset oFavTpattpct = #GetFavPcts.Tpatt#>
<cfset oFavTurnovpct = #GetFavPcts.Turnovpct#>
<cfset oFavFouled    = #GetFavPcts.Fouled#>


<cfset oUndFGpct = #GetUndPcts.FGpct#>
<cfset oUndTPpct = #GetUndPcts.TPpct#>
<cfset oUndTOpct = #GetUndPcts.TOpct#>
<cfset oUndFTpct = #GetUndPcts.FTpct#>


<cfset oUndPos       = #GetUndPcts.Pos#>
<cfset oUndFgattpct  = #GetUndPcts.FGatt#>
<cfset oUndTpattpct  = #GetUndPcts.Tpatt#>
<cfset oUndTurnovpct = #GetUndPcts.Turnovpct#>
<cfset oUndFouled    = #GetUndPcts.Fouled#>




<cfoutput>
 oFavFGpct = #GetFavPcts.FGpct#<br>
 oFavTPpct = #GetFavPcts.TPpct#<br>
 oFavTOpct = #GetFavPcts.TOpct#<br>
 oFavFTpct = #GetFavPcts.FTpct#<br>
----------------------------------------------------<br>
 oFavPos       = #GetFavPcts.Pos#<br>
 oFavFgattpct  = #GetFavPcts.FGatt#<br>
 oFavTpattpct  = #GetFavPcts.Tpatt#<br>
 oFavTurnovpct = #GetFavPcts.Turnovpct#<br>
 oFavFouled    = #GetFavPcts.Fouled#<br>
----------------------------------------------------<br>

 oUndFGpct = #GetUndPcts.FGpct#<br>
 oUndTPpct = #GetUndPcts.TPpct#<br>
 oUndTOpct = #GetUndPcts.TOpct#<br>
 oUndFTpct = #GetUndPcts.FTpct#<br>
-----------------------------------------------------<br>

 oUndPos       = #GetUndPcts.Pos#<br>
 oUndFgattpct  = #GetUndPcts.FGatt#<br>
 oUndTpattpct  = #GetUndPcts.Tpatt#<br>
 oUndTurnovpct = #GetUndPcts.Turnovpct#<br>
 oUndFouled    = #GetUndPcts.Fouled#<br>
-----------------------------------------------------<br>
<br>
<br>
</cfoutput>


<cfquery  datasource="nbapospcts" name="GetFavPcts">
Select * from nbapospcts where Team = '#fav#' and Offdef = 'D'
</cfquery>

<cfquery  datasource="nbapospcts" name="GetUndPcts">
Select * from nbapospcts where Team = '#und#' and Offdef = 'D'
</cfquery>

<cfset dFavFGpct = #GetFavPcts.FGpct#>
<cfset dFavTPpct = #GetFavPcts.TPpct#>
<cfset dFavTOpct = #GetFavPcts.TOpct#>

<cfset dFavPos       = #GetFavPcts.Pos#>
<cfset dFavFgattpct  = #GetFavPcts.FGatt#>
<cfset dFavTpattpct  = #GetFavPcts.Tpatt#>
<cfset dFavTurnovpct = #GetFavPcts.Turnovpct#>
<cfset dFavFouled    = #GetFavPcts.Fouled#>


<cfset dUndFGpct     = #GetUndPcts.FGpct#>
<cfset dUndTPpct     = #GetUndPcts.TPpct#>
<cfset dUndTOpct     = #GetUndPcts.TOpct#>

<cfset dUndPos       = #GetUndPcts.Pos#>
<cfset dUndFgattpct  = #GetUndPcts.FGatt#>
<cfset dUndTpattpct  = #GetUndPcts.Tpatt#>
<cfset dUndTurnovpct = #GetUndPcts.Turnovpct#>
<cfset dUndFouled    = #GetUndPcts.Fouled#>


<cfoutput>
 dFavFGpct = #GetFavPcts.FGpct#<br>
 dFavTPpct = #GetFavPcts.TPpct#<br>
 dFavTOpct = #GetFavPcts.TOpct#<br>
 dFavFTpct = #GetFavPcts.FTpct#<br>
----------------------------------------------------<br>
 dFavPos       = #GetFavPcts.Pos#<br>
 dFavFgattpct  = #GetFavPcts.FGatt#<br>
 dFavTpattpct  = #GetFavPcts.Tpatt#<br>
 dFavTurnovpct = #GetFavPcts.Turnovpct#<br>
 dFavFouled    = #GetFavPcts.Fouled#<br>
----------------------------------------------------<br>

 dUndFGpct = #GetUndPcts.FGpct#<br>
 dUndTPpct = #GetUndPcts.TPpct#<br>
 dUndTOpct = #GetUndPcts.TOpct#<br>
 dUndFTpct = #GetUndPcts.FTpct#<br>
-----------------------------------------------------<br>

 dUndPos       = #GetUndPcts.Pos#<br>
 dUndFgattpct  = #GetUndPcts.FGatt#<br>
 dUndTpattpct  = #GetUndPcts.Tpatt#<br>
 dUndTurnovpct = #GetUndPcts.Turnovpct#<br>
 dUndFouled    = #GetUndPcts.Fouled#<br>

</cfoutput>




<!-- Create the overall predicted possesion percecnts -->
<cfset FavPredPos       = (oFavPos + dUndPos)/2>
<cfset FavPredFGAttPct  = (oFavFgattpct + dUndFgattpct)/2>
<cfset FavPredTpAttPct  = (oFavTpattpct + dUndTpattpct)/2>
<cfset FavPredTurnovpct = (oFavTurnovpct + dUndTurnovpct)/2>
<cfset FavPredFouledpct = (oFavFouled + dUndFouled)/2>

<cfset UndPredPos       = (oUndPos + dFavPos)/2>
<cfset UndPredFGAttPct  = (oUndFgattpct + dFavFgattpct)/2>
<cfset UndPredTpAttPct  = (oUndTpattpct + dFavTpattpct)/2>
<cfset UndPredTurnovpct = (oUndTurnovpct + dFavTurnovpct)/2>
<cfset UndPredFouledpct = (oUndFouled + dFavFouled)/2>

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
<cfset FavPlayFGAttNum   = (FavPredFGAttPct*100)> 

<!-- 3pt Att -->
<cfset FavPlayTpAttNum   = (FavPredTPAttPct*100) + FavPlayFGAttNum> 

<!-- Turnover -->
<cfset FavPlayTurnoverNum   = (FavPredTurnovPct*100) + FavPlayTpAttNum> 

<!-- Fouled, Shoot Free Throw -->
<cfset FavPlayFouled        = 100 - (FavPredFouledPct*100)> 

<cfoutput>
FavPlayFGAttNum = #FavPlayFGAttNum#<br>
FavPlayTpAttNum = #FavPlayTpAttNum#<br>
FavPlayTurnoverNum = #FavPlayTurnoverNum#<br>
FavPlayFouled = #FavPlayFouled#<br>
============================================================================<br><br>
</cfoutput>






<!-- 2pt Att -->
<cfset UndPlayFGAttNum   = (UndPredFGAttPct*100)> 

<!-- 3pt Att -->
<cfset UndPlayTpAttNum   = (UndPredTPAttPct*100) + UndPlayFGAttNum> 

<!-- Turnover -->
<cfset UndPlayTurnoverNum   = (UndPredTurnovPct*100) + UndPlayTpAttNum> 

<!-- Fouled, Shoot Free Throw -->
<cfset UndPlayFouled        = 100 - (UndPredFouledPct*100)> 


<cfoutput>
UndPlayFGAttNum = #UndPlayFGAttNum#<br>
UndPlayTpAttNum = #UndPlayTpAttNum#<br>
UndPlayTurnoverNum = #UndPlayTurnoverNum#<br>
UndPlayFouled = #UndPlayFouled#<br>
============================================================================<br><br>
</cfoutput>



<cfset FavDriveTotal    = Round(FavPredPos)>
<cfset UndDriveTotal    = Round(UndPredPos)> 

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
<cfloop index="simct" from="1" to="1000">
	<cfset FavDriveCt       = 0>
	<cfset UndDriveCt       = 0>
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
		<cfscript>
			Rn = Application.objRandom.next();
		</cfscript>
<!--- 		<cfoutput>
		Rn is: #rn#<br>
		</cfoutput>
 --->		
		
		<!--- See what type of possesion it is... --->
		<cfif possesion is '#fav#' and FavPosDone is false>
			<Cfset PossesionType = getPossesionType(RN,FavPlayFGAttNum,FavPlayTpAttNum,FavPlayTurnoverNum,FavPlayFouled)>
		<cfelse>
			<cfif UndPosDone is false>
				<Cfset PossesionType = getPossesionType(Rn,UndPlayFGAttNum,UndPlayTpAttNum,UndPlayTurnoverNum,UndPlayFouled)>
			</cfif>				
		</cfif>

<!--- 		<cfoutput>
		PossesionType is: #PossesionType#<br>
		</cfoutput>
 --->		
		<cfswitch expression="#PossesionType#">
		
			<cfcase value="2ptFGAtt">
				<cfif possesion is '#fav#'>
					<cfset checkpct = #FavPredFGSuccess#>
				<cfelse>
					<cfset checkpct = #UndPredFGSuccess#>
				</cfif>
			</cfcase>
			
			<cfcase value="3ptFGAtt">
				<cfif possesion is '#fav#'>
					<cfset checkpct = #FavPredTPSuccess#>
				<cfelse>
					<cfset checkpct = #UndPredTPSuccess#>
				</cfif>
			</cfcase>
		
			<cfcase value="Turnover">
				<cfif possesion is '#fav#'>
					<cfset checkpct = #FavPredTOSuccess#>
				<cfelse>
					<cfset checkpct = #UndPredTOSuccess#>
				</cfif>
			</cfcase>
			
			<cfcase value="Freethrow">
				<cfif possesion is '#fav#'>
					<cfset checkpct = #FavPredFTSuccess#>
				<cfelse>
					<cfset checkpct = #UndPredFTSuccess#>
				</cfif>
			</cfcase>

			<cfcase value="Error">
				<cfabort showerror="Error: Not one of the defined Possesion Types">		
			</cfcase>
		</cfswitch>
		
		<cfoutput>
		<!--- 		Checkpct is: #checkpct#<br>
		*****************PossesionType is... #PossesionType#<br>
 		--->		
 		</cfoutput>

		<cfscript>
			Rn = Application.objRandom.next();
		</cfscript>
		
		<!--- See if success or fail on the attempt... --->
		<cfif checkPosseionResult(rn,checkpct) is 'Success'>
			<cfif possesion is '#fav#'>
				<cfset FavScore = updateScore(FavScore,possesionType)>
			<cfelse>
				<cfset UndScore = updateScore(UndScore,possesionType)>
			</cfif>
		</cfif>

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
				<cfset possesion = '#fav#'>
			</cfif>
		</cfif>
		
		<cfif possesion is '#fav#'>
			<CFSET POSSESION = '#UND#'>
		<cfELSE>
			<CFSET POSSESION = '#FAV#'>
		</CFIF>
		
		<cfif FavPosDone is true and UndPosDone is true>
			<cfset Done = true>
		</cfif>
		
		<!--- <cfoutput>
		#FavDriveTotal# vs #FavDriveCt#<br>
		#UndDriveTotal# vs #UndDriveCt#<br>
		</cfoutput> --->
		
	</cfloop>
	
	<cfif Ha is 'H'>
		
		<cfset FavTotalPoints   = FavTotalPoints + FavScore + 2.6>
		<cfset UndTotalPoints   = UndTotalPoints + UndScore>
		
		<cfset PredFavScore = FavScore + 2.6>
		<cfset PredUndScore = Undscore>
		<cfset PredMOV = PredFavScore - PredUndscore>
						
		<cfif PredMOV gt #Client.spread#>
				<cfset FavCovCt = FavCovCt + 1>
	<!--- 			#fav#:#PredFavscore#....spd: #Client.spread#.....#und#:#PredUndscore#....Favorite covered.....#FavCovct#<br> --->
				<cfset gamect = gamect + 1>
		<cfelse>
			
			<cfif PredMOV lt #Client.spread#>
		
				<cfset UndCovCt = UndCovCt + 1>
<!--- 				#fav#:#PredFavscore#....spd: #Client.spread#.....#und#:#PredUndscore#....Underdog covered.....#UndCovct#<br> --->
				<cfset gamect = gamect + 1>
			</cfif>
				
		</cfif>
		
		<cfif (Favscore + UndScore) gt myou>
			<cfset overcovct = overcovct + 1>
		</cfif>
				
	<cfelse>
	
		<cfset FavTotalPoints   = FavTotalPoints + FavScore >
		<cfset UndTotalPoints   = UndTotalPoints + UndScore + 2.6>
		<cfset PredFavScore = FavScore >
		<cfset PredUndScore = Undscore + 2.6>
		<cfset PredMOV = PredFavScore - PredUndscore>

	
		<cfif PredMOV gt #Client.spread#>
				<cfset FavCovCt = FavCovCt + 1>
<!--- 				#fav#:#PredFavscore#....spd: #Client.spread#.....#und#:#PredUndscore#....Favorite covered.....#FavCovct#<br> --->
				<cfset gamect = gamect + 1>
		<cfelse>
		
			<cfif PredMOV lt #Client.spread#>
		
				<cfset UndCovCt = UndCovCt + 1>
<!--- 				#fav#:#PredFavscore#....spd: #Client.spread#.....#und#:#PredUndscore#....Underdog covered.....#undCovct#<br> --->
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
  function getPossesionType(rn,twoptrge,threeptrge,turnoverrge,freethrowrge)
  { 
  
  	 if (rn lte twoptrge)
	 	return '2ptFGAtt';
  
  	 if (rn lte threeptrge)
	 	return '3ptFGAtt';
  
   	 if (rn lte turnoverrge)
	 	return 'Turnover';

  	 if (rn lte 100)
	 	return 'Freethrow';

     return 'Error'; 
	 
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


