<!---
NBAGameSim5 - Uses no power ratings, just rergular stats with 48 minutes of simulation

--->



<!--- <cfquery name="Getone" datasource="psp_psp" >
	delete from RandomSim
</cfquery>
 --->

 <cfset mygametime = Session.GameTime>
 
 
<cfscript>
 Application.objRandom = CreateObject("Component", "Random");
</cfscript>

<cfset TotalGamesToSim  = 1000>
 
<cfquery datasource="nbaschedule" name="Getspds">
Select *
from nbaschedule
where GameTime = '#mygametime#'

</cfquery>

<cfset TotalGames = Getspds.Recordcount> 

<cfset SystemId        = 'NBAGameSim5'>

<cfquery datasource="nbapicks" name="Addit">
	Delete from NBAPicks
	where SystemId = '#SystemId#'
	and Gametime = '#myGametime#'
</cfquery>

<cfloop query="GetSpds">

	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset Client.spread = #GetSpds.spd#>
	<cfset myou          = #GetSpds.ou#> 
	
	<cfset overcovct = 0>
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
	   Avg((ofgm - otpm) / (ofga - otpa)) as fgRateFor,
	   Avg(otpm / otpa) as tpRateFor,
	   Avg(oftm / ofta) as ftRateFor,
	   Avg(dTurnovers / dfga) as toRateFor,
	   Avg(ofgm - ofga) as FgMissedFor,
	   Avg(oreb / (ofgm - ofga)) as OffRebForPctFor,
	   Avg(otpa / (mins/5)) as TpminFor,
	   Avg(  (ofga - otpa) / (mins/5) ) as FgminFor,
	   Avg(ofta / (mins/5)) as FTminFor
 	from nbadata
  	where Team = '#fav#'
	and GameTime < '#myGameTime#'
	</cfquery>


	<cfquery  datasource="nbastats" name="GetUndOff">
	Select 
       Avg(oReb)       as OffRebFor,
	   Avg(oDreb)      as DefrebFor,
	   Avg(dTurnovers) as TurnovFor,
	   Avg(oFTa)       as FTAttFor,
	   Avg(ofga - (dTurnovers + oReb + oDreb)) as RegPosFor,
   	   Avg((ofgm - otpm) / (ofga - otpa)) as fgRateFor,
	   Avg(otpm / otpa) as tpRateFor,
	   Avg(oftm / ofta) as ftRateFor,
	   Avg(dTurnovers / dfga) as toRateFor,
	   Avg(ofgm - ofga) as FgMissedFor,
	   Avg(oreb / (ofgm - ofga)) as OffRebForPctFor,
	   Avg(otpa / (mins/5)) as TpminFor,
	   Avg( (ofga - otpa) / (mins/5) ) as FgminFor,
	   Avg(ofta / (mins/5)) as FTminFor
	   
 	from nbadata
  	where Team = '#Und#'
  	and GameTime < '#myGameTime#'
	</cfquery>


	<cfquery  datasource="nbastats" name="GetFavDef">
	Select 
       Avg(dReb)       as OffRebGiv,
	   Avg(dDreb)      as DefrebGiv,
	   Avg(oTurnovers) as TurnovGiv,
	   Avg(dFTa)       as FTAttGiv,
	   Avg(dfga - (oTurnovers + dReb + dDreb)) as RegPosGiv,
	   Avg((dfgm - dtpm) / (dfga - dtpa)) as fgRateGiv,
	   Avg(dtpm / dtpa) as tpRateGiv,
	   Avg(dftm / dfta) as ftRateGiv,
	   Avg(oTurnovers / ofga) as toRateGiv,
	   Avg(dfgm - dfga) as FgMissedGiv,
	   Avg(dreb / (dfgm - dfga)) as OffRebForPctGiv,
	   Avg(dtpa / (dmin/5)) as TpminGiv,
	   Avg( (dfga - dtpa) / (dmin/5) ) as FgminGiv,
	   Avg(dfta / (dmin/5)) as FTminGiv
 	from nbadata
  	where Team = '#fav#'
  	and GameTime < '#myGameTime#'
	</cfquery>

	<cfquery  datasource="nbastats" name="GetUndDef">
	Select 
       Avg(dReb)       as OffRebGiv,
	   Avg(dDreb)      as DefrebGiv,
	   Avg(oTurnovers) as TurnovGiv,
	   Avg(dFTa)       as FTAttGiv,
	   Avg(dfga - (oTurnovers + dReb + dDreb)) as RegPosGiv,
	   Avg((dfgm - dtpm) / (dfga - dtpa)) as fgRateGiv,
	   Avg(dtpm / dtpa) as tpRateGiv,
	   Avg(dftm / dfta) as ftRateGiv,
	   Avg(oTurnovers / ofga) as toRateGiv,
	   Avg(dfgm - dfga) as FgMissedGiv,
	   Avg(dreb / (dfgm - dfga)) as OffRebForPctGiv,
	   Avg(dtpa / (dmin/5)) as TpminGiv,
	   Avg( (dfga - dtpa) / (dmin/5) ) as FgminGiv,
	   Avg(dfta / (dmin/5)) as FTminGiv
	   
 	from nbadata
  	where Team = '#Und#'
  	and GameTime < '#myGameTime#'
	</cfquery>


	<cfset oFavFGpct = (GetFavOff.fgratefor + GetUndDef.fgrategiv)/2>
	<cfset oFavTPpct = (GetFavOff.TPratefor + GetUndDef.TPrategiv)/2>
	<cfset oFavTOpct = (GetFavOff.TORateFor + GetUndDef.TORategiv)/2>
	<cfset oFavFTpct = GetFavOff.FTRatefor>

	<cfset oFavTPmin = (GetFavOff.TpminFor + GetUndDef.TpminGiv)/2> 
	<cfset oFavFGmin = (GetFavOff.FGminFor + GetUndDef.FGminGiv)/2> 
	<cfset oFavFTmin = (GetFavOff.FTminFor + GetUndDef.FTminGiv)/2> 

	<!--- Use this for Fav's predicted shooting percent rates    --->
	<cfset FavPredFGSuccess = oFavFgpct*100>
	<cfset FavPredTPSuccess = oFavTPpct*100>
	<cfset FavPredFTSuccess = oFavFTpct*100>

	<cfset FavPredTPMin     = oFavTPmin> 
	<cfset FavPredFGMin     = oFavFGmin> 
	<cfset FavPredFTMin     = oFavFTmin> 

	<cfset oUndFGpct = (GetUndOff.fgratefor + GetFavDef.fgrategiv)/2>
	<cfset oUndTPpct = (GetUndOff.TPratefor + GetFavDef.TPrategiv)/2>
	<cfset oUndTOpct = (GetUndOff.TORateFor + GetFavDef.TORategiv)/2>

	<cfset oUndFTpct = GetUndOff.FTRateFor>
	<cfset oUndTPmin = (GetUndOff.TpminFor + GetFavDef.TpminGiv)/2> 
	<cfset oUndFGmin = (GetUndOff.FGminFor + GetFavDef.FGminGiv)/2> 
	<cfset oUndFTmin = (GetUndOff.FTminFor + GetFavDef.FTminGiv)/2> 



	<!--- Use this for Und's predicted shooting percent rates    --->
	<cfset UndPredFGSuccess = oUndFgpct*100>
	<cfset UndPredTPSuccess = oUndTPpct*100>
	<cfset UndPredFTSuccess = oUndFTpct*100>

	<cfset UndPredTPMin     = oUndTPmin> 
	<cfset UndPredFGMin     = oUndFGmin> 
	<cfset UndPredFTMin     = oUndFTmin> 

	<cfoutput>
 	oFavFGpct = #oFavFGpct#<br>
 	oFavTPpct = #oFavTPpct#<br>
 	oFavTOpct = #oFavTOpct#<br>
 	oFavFTpct = #oFavFTpct#<br>
 	FavPredTPSuccess = #FavPredTPSuccess#<br> 
 	FavPredFGSuccess = #FavPredFGSuccess#<br>
 	FavPredFTSuccess = #FavPredFTSuccess#<br>  
	----------------------------------------------------<br>
 	oUndFGpct = #oUndFGpct#<br>
 	oUndTPpct = #oUndTPpct#<br>
 	oUndTOpct = #oUndTOpct#<br>
 	oUndFTpct = #oUndFTpct#<br>
 	UndPredFGSuccess = #UndPredFGSuccess#<br>
 	UndPredTPSuccess = #UndPredTPSuccess#<br>
 	UndPredFTSuccess = #UndPredFTSuccess#<br>  

	-----------------------------------------------------<br>


	
	<br>
	<br>
	</cfoutput>

	<cfset aFavScore    = arraynew(1)>
	<cfset aUndScore    = arraynew(1)>

	<cfset TPA          = arraynew(1)>
	<cfset FGA          = arraynew(1)>
	<cfset FTA          = arraynew(1)>

	<cfset chkTPA       = arraynew(1)>
	<cfset chkFGA       = arraynew(1)>
	<cfset chkFTA       = arraynew(1)>

	<cfset FavAvgPoints = 0>
	<cfset UndAvgPoints = 0>
	<Cfset FavCovPct    = 0>
	<Cfset UndCovPct    = 0>
	<Cfset OverCovPct   = 0>

	<cfloop index="myct" from="1" to="2">
	
		<cfif myct is 1>
	
			<cfset TPPerMin    = FavPredTPMin>
			<cfset FGPerMin    = FavPredFGMin>
			<cfset FTPerMin    = FavPredFTMin>
		
			<cfset checkthisTP = FavPredTPSuccess>
			<cfset checkthisFG = FavPredFGSuccess>
			<cfset checkthisFT = FavPredFTSuccess>
		
		<cfelse>
	
			<cfset TPPerMin    = UndPredTPMin>
			<cfset FGPerMin    = UndPredFGMin>
			<cfset FTPerMin    = UndPredFTMin>
		
			<cfset checkthisTP = UndPredTPSuccess>
			<cfset checkthisFG = UndPredFGSuccess>
			<cfset checkthisFT = UndPredFTSuccess>
	
		</cfif>

		<!--- Create the Minutes chart for 2pt shot, 3pt Shot and Free Throw Shots --->
		<cfloop index="ii" from="1" to="48">
			<cfset TPA[ii]     = ii*TPPERMin>
			<cfset FGA[ii]     = ii*FGPERMin>
			<cfset FTA[ii]     = ii*FTPERMin>
		<!--- 		<cfoutput>
		#TPA[ii]#=====,#FGA[ii]#==========,#FTA[ii]#=================<br>
		</cfoutput>
 		--->		
		</cfloop>

		<cfif myct is 1>
			<cfoutput>
			<cfset PredictedFavScore = 3*(TPA[48]*FavPredTPSuccess) + 2*(FGA[48]*FavPredFGSuccess) + 1*(FTA[48]*FavPredFTSuccess) >
			Predicted Score For #Fav# is #PredictedFavScore#<br>
			</cfoutput>
		
		<cfelse>
			<cfoutput>
			<cfset PredictedUndScore = 3*(TPA[48]*UndPredTPSuccess) + 2*(FGA[48]*UndPredFGSuccess) + 1*(FTA[48]*UndPredFTSuccess) >
			Predicted Score For #Und# is #PredictedUndScore#<br>
			</cfoutput>
		
		</cfif>
		
		<cfset TPAct = 1>
		<cfset FGAct = 1>
		<cfset FTAct = 1>


		<!-- Show which Stats to check at each minute -->	
		<cfloop index="ii" from="1" to="48">
		<!--- <cfoutput>
		checking #TPA[ii]# ge #TPAct#<br>
		</cfoutput> --->
		
			<cfif TPA[ii] ge TPAct>
				<cfset chkTPA[ii] = 1>
				<cfset TPAct = TPAct + 1> 
				<!--- <cfoutput>Adding it!...#TPAct#<br></cfoutput> --->
			<cfelse>
				<cfset chkTPA[ii] = 0>
			</cfif>
		
			<cfif FGA[ii] ge FGAct>
				<cfset chkFGA[ii] = 1>
				<cfset FGAct = FGAct + 1> 
			<cfelse>
				<cfset chkFGA[ii] = 0>
			</cfif>
	
			<cfif FTA[ii] ge FTAct>
				<cfset chkFTA[ii] = 1>
				<cfset FTAct = FTAct + 1> 
			<cfelse>
				<cfset chkFTA[ii] = 0>
			</cfif>

		</cfloop>
	
		<!--- 	<cfloop index="ii" from="1" to="12">
		<cfoutput>
		#myct#..........................#chkTPA[ii]#===#chkFGA[ii]#===#chkFTA[ii]#<br>
		</cfoutput>
		</cfloop>
 		--->	
		
		<!--- 
		************************************************************************************************************************
	
		B-E-G-I-N             G-A-M-E            S-I-M-U-L-A-T-I-O-N
	
		************************************************************************************************************************
	 	--->
	
		<cfscript>
			Application.objRandom.setBounds(1,100);
		</cfscript>

		<!--- Each Game.... --->
		<cfloop index="jj" from="1" to="#TotalGamesToSim#">
			<cfset score = 0>
	
			<!--- For each minute of the game... --->
			<cfloop index="ii" from="1" to="48">
				<!--- <cfoutput>min is #ii#<br></cfoutput> --->
				<cfscript>
					Rn = Application.objRandom.next();
				</cfscript>

				<cfif chkTPA[ii] neq 0>
					<cfif checkPosseionResult(rn,#checkthisTP#) is 'Success'>
						<cfset Score = score + 3>
					</cfif>
				</cfif>

				<cfscript>
					Rn = Application.objRandom.next();
				</cfscript>
	
				<cfif chkFGA[ii] neq 0>
					<cfif checkPosseionResult(rn,#checkthisFG#) is 'Success'>
						<cfset Score = score + 2>
					</cfif>	
				</cfif>

				<cfscript>
					Rn = Application.objRandom.next();
				</cfscript>

				<cfif chkFTA[ii] neq 0>
					<cfif checkPosseionResult(rn,#checkthisFT#) is 'Success'>
						<cfset Score = score + 1>
					</cfif>	
				</cfif>
	
			</cfloop> <!-- Get next minute... -->

			<cfset domoreflag = false>
			<cfif round(FGA[48]) ge 49>
				<cfset domoreflag = true>
				<cfset domore = round(FGA[48] - 48)>
			</cfif>
		
			<!---
			<cfoutput>
			<br>
			<br>
			==>Domore = #domore#<br>
			<br>
			<br>
			</cfoutput>
 			--->
			<cfif doMoreFlag is true>
				<cfloop index="ii" from="1" to="#domore#">
					<cfscript>
						Rn = Application.objRandom.next();
					</cfscript>
	
					<cfif checkPosseionResult(rn,checkthisFG) is 'Success'>
						<cfset Score = score + 2>
					</cfif>	
				</cfloop>
			</cfif>
			
			<cfoutput>
			<!--- #FavScore#<br> --->
			<cfif myct is 1>
				<!--- <cfset TotFavScore = TotFavScore + score> --->
				<cfset aFavScore[jj] = score>
			<cfelse>
				<!--- <cfset TotUndScore = TotUndScore + score> --->
				<cfset aUndScore[jj] = score>
			</cfif>	
			</cfoutput>
		
			<cfset Score = 0>

		</cfloop> <!-- Get next game... -->
	
	</cfloop> <!-- Get next team... -->

	<!--- See who covered the spread... --->
	<cfset Gamect         = 0>
	<cfset FavTotalPoints = 0>
	<cfset UndTotalPoints = 0>
	<cfset UndCovCt       = 0>
	<cfset FavCovCt       = 0>
	
	<cfloop index="ii" from="1" to="#TotalGamesToSim#">

		<!-- For Over/Unders -->
		<cfset FavTotalPoints   = FavTotalPoints + aFavScore[ii]>
		<cfset UndTotalPoints   = UndTotalPoints + aUndScore[ii]>

		<cfset gamect = gamect + 1>
	
		<cfif Ha is 'H'>
			<!-- For Spreads -->
			<cfset PredFavScore = aFavScore[ii] + 2.5>
			<cfset PredUndScore = aUndscore[ii]>
			<cfset PredMOV = PredFavScore - PredUndscore>
						
			<cfif PredMOV gt #Client.spread#>
				<cfset FavCovCt = FavCovCt + 1>
				<cfoutput>
	 			<!--- #fav#:#PredFavscore#....spd: #Client.spread#.....#und#:#PredUndscore#....Favorite covered.....#FavCovct#<br>  --->
				</cfoutput>
			<cfelse>
				<cfif PredMOV lt #Client.spread#>
					<cfset UndCovCt = UndCovCt + 1>
					<cfoutput>
 					<!--- #fav#:#PredFavscore#....spd: #Client.spread#.....#und#:#PredUndscore#....Underdog covered.....#UndCovct#<br>  --->
					</cfoutput>
				</cfif>
			</cfif>
		<cfelse>

			<cfset PredFavScore = aFavScore[ii]>
			<cfset PredUndScore = aUndscore[ii] + 2.5>
			<cfset PredMOV = PredFavScore - PredUndscore>
	
			<cfif PredMOV gt #Client.spread#>
					<cfset FavCovCt = FavCovCt + 1>
					<cfoutput>
		 			<!--- #fav#:#PredFavscore#....spd: #Client.spread#.....#und#:#PredUndscore#....Favorite covered.....#FavCovct#<br>  --->
					</cfoutput>
			<cfelse>
		
				<cfif PredMOV lt #Client.spread#>
					<cfset UndCovCt = UndCovCt + 1>
					<cfoutput>
 					<!--- #fav#:#PredFavscore#....spd: #Client.spread#.....#und#:#PredUndscore#....Underdog covered.....#UndCovct#<br>  --->
					</cfoutput>
				</cfif>	
			</cfif>
		</cfif>	

		<cfif (aFavScore[ii] + aUndScore[ii]) gt myou>
			<cfset overcovct = overcovct + 1>
		</cfif>

	</cfloop>
	
	<!--- After all game simulations....--->
	<cfset FavAvgPoints = Numberformat(FavTotalPoints/GAMECT,"99.99")>
	<cfset UndAvgPoints = Numberformat(UndTotalPoints/GAMECT,"99.99")>
	<Cfset FavCovPct    = Numberformat(FavCovCt/GAMECT,"99.999")>
	<Cfset UndCovPct    = Numberformat(UndCovCt/GAMECT,"99.99")>
	<Cfset OverCovPct   = Numberformat(OverCovCt/GAMECT,"99.99")>

	<cfset ourpick      = ''>
	<cfset ourpickpct   = 0>
	<cfset ouroupick    = ''>
	<cfset ouroupickpct = 0>

	<cfoutput>
	********************************************<br>
	#Fav# Avg PS: #FavAvgPoints#<br>
	#und# Avg PS: #UndAvgPoints#<br>
	#Fav# COVER PCT IS: #Numberformat(100*(fAVCOVPCT),'999.999')#<br>
	Average Combined Points Is: #FavAvgPoints + UndAvgPoints#<br>
	Over Cover Pct is: #Numberformat(100*OverCovpct,'999.999')#<br>
	********************************************<br>
	</cfoutput>	

	<cfoutput>
	<cfif FavCovpct gt .50>
		We like the favorite, #Fav# predicted cover of #Client.spread# is #FavCovPct#
		<cfset ourpick = '#fav#'>
		<cfset ourpickpct = #FavCovPct#>
		
	<cfelse>
	
		<cfset temp = 1 - #FavCovPct#>
		We like the Underdog, #Und# predicted cover of #Client.spread# is #temp#
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

	</cfif>  
	</cfoutput>

	<cfquery datasource="nbapicks" name="Addit">
		Insert into NBAPicks
		(
		SystemId,
		Gametime,
		Fav,
		Ha,
		Spd,
		Und,
		Pick,
		Pct)
		Values
		(
		'#SystemId#',
		'#MYGametime#',
		'#fav#',
		'#HA#',
		#Client.spread#,
		'#und#',
		'#ourpick#',
		#(100*ourpickpct)#
		)
	</cfquery>
	
	<cfset arrayclear(TPA)>
	<cfset ArrayClear(FGA)>
	<cfset ArrayClear(FTA)>
	<cfset ArrayClear(chkTPA)>
	<cfset ArrayClear(chkFGA)>
	<cfset ArrayClear(chkFTA)>	
 	<br>
	<br>
	
</cfloop>

	
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


