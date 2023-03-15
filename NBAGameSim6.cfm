<!---
NBAGameSim5 - Uses no power ratings, just rergular stats with 48 minutes of simulation

--->



<!--- <cfquery name="Getone" datasource="psp_psp" >
	delete from RandomSim
</cfquery>
 --->

<!--- <cfset mygametime = Session.GameTime> --->
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

<cfset SystemId        = 'NBAGameSim6'>

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

	<cfset myFavFGDrives = 0>
	<cfset myFavTPDrives = 0>
	<cfset myFavFTDrives = 0>
	<cfset myUndFGDrives = 0>
	<cfset myUndTPDrives = 0>
	<cfset myUndFTDrives = 0>

<!--- 	<cfoutput query="GetFavOff">
	#team#...fgatt:#FgAttFor#...tpatt:#tpattfor#....ftatt:#ftattfor#...3ppctdrive:#tppctfor#....fg%:#fgshotfor#...3p%:#tpshotfor#....ft%:#ftshotfor#<br>
	</cfoutput>
 --->	
	<cfquery  datasource="nbastats" name="GetFavOff">
	Select 
	   Avg(oFga - otpa)                   as FGAttFor,
	   Avg(otpa)                          as TPAttFor,	
	   Avg(oFTa)                          as FTAttFor,
	   
	   Avg(otpa / ofga)                   as TPPctFor,
	   
	   Avg((ofgm - otpm) / (ofga - otpa)) as fgShotFor,
	   Avg(otpm / otpa)                   as tpShotFor,
	   Avg(oftm / ofta)                   as ftShotFor


 	from nbadata
  	where Team = '#fav#'
	and GameTime < '#myGameTime#'
	</cfquery>


	<cfquery  datasource="nbastats" name="GetUndOff">
	Select 
	   Avg(oFga - otpa)                   as FGAttFor,
	   Avg(otpa)                          as TPAttFor,	
	   Avg(oFTa)                          as FTAttFor,
	   
	   Avg(otpa / ofga)                   as TPPctFor,
	   
	   Avg((ofgm - otpm) / (ofga - otpa)) as fgShotFor,
	   Avg(otpm / otpa)                   as tpShotFor,
	   Avg(oftm / ofta)                   as ftShotFor


 	from nbadata
  	where Team = '#und#'
	and GameTime < '#myGameTime#'
	
	</cfquery>


	<cfquery  datasource="nbastats" name="GetFavDef">
	Select 
	   Avg(dFga - dtpa)                   as FGAttGiv,
	   Avg(dtpa)                          as TPAttGiv,	
	   Avg(dFTa)                          as FTAttGiv,
	   
	   Avg(dtpa / dfga)                   as TPPctGiv,
	   
	   Avg((dfgm - dtpm) / (dfga - dtpa)) as fgShotGiv,
	   Avg(dtpm / dtpa)                   as tpShotGiv,
	   Avg(dftm / dfta)                   as ftShotGiv


 	from nbadata
  	where Team = '#fav#'
	and GameTime < '#myGameTime#'
	</cfquery>

	
	
	<cfquery  datasource="nbastats" name="GetUndDef">
	Select 
	   Avg(dFga - dtpa)                   as FGAttGiv,
	   Avg(dtpa)                          as TPAttGiv,	
	   Avg(dFTa)                          as FTAttGiv,
	   
	   Avg(dtpa / dfga)                   as TPPctGiv,
	   
	   Avg((dfgm - dtpm) / (dfga - dtpa)) as fgShotGiv,
	   Avg(dtpm / dtpa)                   as tpShotGiv,
	   Avg(dftm / dfta)                   as ftShotGiv


 	from nbadata
  	where Team = '#und#'
	and GameTime < '#myGameTime#'
	</cfquery>

	
	<cfset oFavFGpct = (GetFavOff.fgShotfor + GetUndDef.fgShotgiv)/2>
	<cfset oFavTPpct = (GetFavOff.TPShotfor + GetUndDef.TPShotgiv)/2>
	<cfset oFavFTpct = GetFavOff.FTShotfor>
	
	<cfset oFavFgAtt = (GetFavOff.FgAttFor   + GetUndDef.fgAttGiv)/2>
	<cfset oFavTPAtt = (GetFavOff.TPAttFor   + GetUndDef.TPAttGiv)/2>
	<cfset oFavFTAtt = (GetFavOff.FTAttFor   + GetUndDef.ftAttGiv)/2>
	
	<!--- Use this for Fav's predicted shooting percent rates    --->
	<cfset FavPredFGSuccess = oFavFgpct*100>
	<cfset FavPredTPSuccess = oFavTPpct*100>
	<cfset FavPredFTSuccess = oFavFTpct*100>

	<cfset oUndFGpct = (GetUndOff.fgShotfor + GetFavDef.fgShotgiv)/2>
	<cfset oUndTPpct = (GetUndOff.TPShotfor + GetFavDef.TPShotgiv)/2>
	<cfset oUndFTpct = GetUndOff.FTShotFor>

	<cfset oUndFgAtt = (GetUndOff.FgAttFor   + GetFavDef.fgAttGiv)/2>
	<cfset oUndTPAtt = (GetUndOff.TPAttFor   + GetFavDef.TPAttGiv)/2>
	<cfset oUndFTAtt = (GetUndOff.FTAttFor   + GetFavDef.ftAttGiv)/2>

	
	
	<!--- Use this for Und's predicted shooting percent rates    --->
	<cfset UndPredFGSuccess = oUndFgpct*100>
	<cfset UndPredTPSuccess = oUndTPpct*100>
	<cfset UndPredFTSuccess = oUndFTpct*100>

	<cfoutput>
	#fav#<br>
 	FavPredFGSuccess = #FavPredFGSuccess#<br>
	FavPredTPSuccess = #FavPredTPSuccess#<br> 
 	FavPredFTSuccess = #FavPredFTSuccess#<br>  
	FavPredFGAtt     = #oFavFgAtt#<br> 
	FavPredTPAtt     = #oFavTPAtt#<br> 
	FavPredFTAtt     = #oFavFTAtt#<br> 
	----------------------------------------------------<br>
	#und#<br>
 	oUndFGpct        = #100*oUndFGpct#<br>
 	oUndTPpct        = #100*oUndTPpct#<br>
 	oUndFTpct        = #100*oUndFTpct#<br>
	UndPredFGAtt     = #oUndFgAtt#<br> 
	UndPredTPAtt     = #oUndTPAtt#<br> 
	UndPredFTAtt     = #oUndFTAtt#<br> 

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


			<cfquery datasource="nbastats" name="GetFavOpp">
			Select 
				d.opp,
				d.gametime
			from nbadata d
			where Team = '#Fav#'
			</cfquery>
		
			<cfset FavTpattforPow = 0>
			<cfset FavFGattforPow = 0>
			<cfset FavFTattforPow = 0>
		
			<cfset FavTpattGivPow = 0>
			<cfset FavFGattGivPow = 0>
			<cfset FavFTattGivPow = 0>
		
			<cfset FavTpMadeForPow = 0>
			<cfset FavFGMadeForPow = 0>
		
			<cfset FavTpMadeGivPow = 0>
			<cfset FavFGMadeGivPow = 0>
			<cfset ct = 0>
		
			<cfloop query="GetFavopp">
				
				<!-- Get the Avg's for the opponent -->
				<cfquery  datasource="nbastats" name="GetFavOppAvg">
					Select 
				
					   Avg(otpa)        as TpAttFor,
					   Avg(ofga - otpa) as FgAttFor,
					   Avg(ofta)        as FTAttFor,
				
					   Avg(dtpa)        as TpAttGiv,
					   Avg(dfga - dtpa) as FgAttGiv,
					   Avg(dfta)        as FTAttGiv,
					   
					   Avg(otpm / otpa) as TpMadeFor,
					   Avg((ofgm - otpm) / (ofga - otpa)) as FgMadeFor,
					   
					   Avg(dtpm / dtpa)          as TpMadeGiv,
					   Avg((dfgm - dtpm) / (dfga-dtpa)) as FgMadeGiv
					   
				 	from nbadata
				  	where Team = '#GetFavOpp.opp#'
				</cfquery>
				
				<!-- See how favorite did versus the averages -->
				<cfquery  datasource="nbastats" name="GetFavResults">
					Select 
						ps,
						opp,
					   otpa as TpAttFor,
					   ofga - otpa as FgAttFor,
					   ofta as FTAttFor,
				
					   dtpa as TpAttGiv,
					   dfga-dtpa as FgAttGiv,
					   dfta as FTAttGiv,
					   
				   	   (otpm / otpa) as TpMadeFor,
					   (ofgm - otpm) / (ofga-otpa) as FgMadeFor,
					   
					   (dtpm / dtpa) as TpMadeGiv,
					   (dfgm - dtpm) / (dfga-dtpa) as FgMadeGiv
					   
				 	from nbadata
				  	where Team = '#fav#'
					and   opp = '#GetFavOpp.opp#'
					and   gametime = '#GetFavOpp.gametime#'
				</cfquery>
				
				<cfset FavTpattforPow = FavTpattforPow + (GetFavResults.TpattFor - GetFavOppAvg.Tpattgiv)>
				<cfset FavFGattforPow = FavFGattforPow + ((GetFavResults.FGAttFor - GetFavResults.TPAttFor) - GetFavOppAvg.FGattgiv)>
				<cfset FavFTattforPow = FavFTattforPow + (GetFavResults.FTAttFor - GetFavOppAvg.FTattgiv)>
				
				<cfset FavTpattGivPow = FavTpattGivPow + (GetFavOppAvg.TpattFor - GetFavResults.TpattGiv)>
				<cfset FavFGattGivPow = FavFGattGivPow + ((GetFavOppAvg.FGattFor - GetFavOppAvg.TPAttFor) - GetFavResults.FGattGiv)>
				<cfset FavFTattGivPow = FavFTattGivPow + (GetFavOppAvg.FTattFor - GetFavResults.FTattGiv)>
				
				<cfset FavTpMadeForPow = FavTpMadeForPow + (GetFavResults.TpMadeFor - GetFavOppAvg.TpMadeGiv)>
				<cfset FavFGMadeForPow = FavFGMadeForPow + (GetFavResults.FGMadeFor - GetFavOppAvg.FGMadeGiv)>
				
				<cfset FavTpMadeGivPow = FavTpMadeGivPow + (GetFavOppAvg.TpMadeFor - GetFavResults.TpMadeGiv)>
				<cfset FavFGMadeGivPow = FavFGMadeGivPow + (GetFavOppAvg.FGMadeFor - GetFavResults.FGMadeGiv)>
				
				<cfset ct = ct + 1>
 				<cfoutput>
				FavFGattforPow=#FavFGattforPow#..(#GetFavResults.FgAttFor# minus #GetFavResults.TPAttFor#) Minus #GetFavOppAvg.FGattgiv#.....<br> 
				</cfoutput>

			</cfloop>

			<cfset FavTpattforPow = FavTpattforPow/ct>
			<cfset FavFGattforPow = FavFGattforPow/ct>
			<cfset FavFTattforPow = FavFTattforPow/ct>
			<cfset FavTpattGivPow = FavTpattGivPow/ct>
			<cfset FavFGattGivPow = FavFGattGivPow/ct>
			<cfset FavFTattGivPow = FavFTattGivPow/ct>


			<cfquery datasource="nbastats" name="GetUndOpp">
			Select 
				d.opp,
				d.gametime
			from nbadata d
			where Team = '#Und#'
			</cfquery>
		
			<cfset UndTpattforPow = 0>
			<cfset UndFGattforPow = 0>
			<cfset UndFTattforPow = 0>
		
			<cfset UndTpattGivPow = 0>
			<cfset UndFGattGivPow = 0>
			<cfset UndFTattGivPow = 0>
		
			<cfset UndTpMadeForPow = 0>
			<cfset UndFGMadeForPow = 0>
		
			<cfset UndTpMadeGivPow = 0>
			<cfset UndFGMadeGivPow = 0>
			<cfset ct = 0>
		
			<cfloop query="GetUndopp">
			
				<!-- Get the Avg's for the opponent -->
				<cfquery  datasource="nbastats" name="GetUndOppAvg">
					Select 
				
					   Avg(otpa)        as TpAttFor,
					   Avg(ofga - otpa) as FgAttFor,
					   Avg(ofta)        as FTAttFor,
				
					   Avg(dtpa)        as TpAttGiv,
					   Avg(dfga - dtpa) as FgAttGiv,
					   Avg(dfta)        as FTAttGiv,
					   
					   Avg(otpm / otpa) as TpMadeFor,
					   Avg((ofgm - otpm) / (ofga-otpa)) as FgMadeFor,
					   
					   Avg(dtpm / dtpa)          as TpMadeGiv,
					   Avg((dfgm - dtpm) / (dfga-dtpa)) as FgMadeGiv
					   
				 	from nbadata
				  	where Team = '#GetUndOpp.opp#'
				</cfquery>
				
				<!-- See how favorite did versus the averages -->
				<cfquery  datasource="nbastats" name="GetUndResults">
					Select 
						ps,
						opp,
					   otpa as TpAttFor,
					   ofga-otpa as FgAttFor,
					   ofta as FTAttFor,
				
					   dtpa as TpAttGiv,
					   dfga-dtpa as FgAttGiv,
					   dfta as FTAttGiv,
					   
				   	   (otpm / otpa) as TpMadeFor,
					   (ofgm - otpm) / (ofga-otpa) as FgMadeFor,
					   
					   (dtpm / dtpa) as TpMadeGiv,
					   (dfgm - dtpm) / (dfga-dtpa) as FgMadeGiv
					   
				 	from nbadata
				  	where Team = '#und#'
					and   opp = '#GetUndOpp.opp#'
					and   gametime = '#GetUndOpp.gametime#'
				</cfquery>
				

				
				<cfset UndTpattforPow = UndTpattforPow + (GetUndResults.TpattFor - GetUndOppAvg.Tpattgiv)>
				<cfset UndFGattforPow = UndFGattforPow + ((GetUndResults.FGAttFor - GetUndResults.TPAttFor) - GetUndOppAvg.FGattgiv)>
				<cfset UndFTattforPow = UndFTattforPow + (GetUndResults.FTAttFor - GetUndOppAvg.FTattgiv)>
				<cfset UndTpattGivPow = UndTpattGivPow + (GetUndOppAvg.TpattFor - GetUndResults.TpattGiv)>

				<cfset UndFGattGivPow = UndFGattGivPow + ((GetUndOppAvg.FGattFor - GetUndOppAvg.TPAttFor) - GetUndResults.FGattGiv)>
				
				
				<cfset UndFTattGivPow = UndFTattGivPow + (GetUndOppAvg.FTattFor - GetUndResults.FTattGiv)>
				
				<cfset UndTpMadeForPow = UndTpMadeForPow + (GetUndResults.TpMadeFor - GetUndOppAvg.TpMadeGiv)>
				<cfset UndFGMadeForPow = UndFGMadeForPow + (GetUndResults.FGMadeFor - GetUndOppAvg.FGMadeGiv)>
				
				<cfset UndTpMadeGivPow = UndTpMadeGivPow + (GetUndOppAvg.TpMadeFor - GetUndResults.TpMadeGiv)>
				<cfset UndFGMadeGivPow = UndFGMadeGivPow + (GetUndOppAvg.FGMadeFor - GetUndResults.FGMadeGiv)>
				
				<cfset ct = ct + 1>
				<cfoutput>
				<!--- #GetFavResults.FGMadeFor# - #GetFavOppAvg.FGMadeGiv#.....#FGMadeForPow#<br> --->
				</cfoutput>
				
			</cfloop>

			<cfset UndTpattforPow = UndTpattforPow/ct>
			<cfset UndFGattforPow = UndFGattforPow/ct>
			<cfset UndFTattforPow = UndFTattforPow/ct>
			<cfset UndTpattGivPow = UndTpattGivPow/ct>
			<cfset UndFGattGivPow = UndFGattGivPow/ct>
			<cfset UndFTattGivPow = UndFTattGivPow/ct>

			<cfset myFavFGDrives   = oFavFgAtt + (favFGAttForPow - UndFGattGivPow) >
			<cfset myFavTPDrives   = oFavTPAtt + (favTPAttForPow - UndTPattGivPow) >
			<cfset myFavFTDrives   = oFavFtAtt + (favFTAttForPow - UndFTattGivPow) >

			<cfset myUndFGDrives   = oUndFgAtt + (UndFGAttForPow - FavFGattGivPow)>
			<cfset myUndTPDrives   = oUndTPAtt + (UndTPAttForPow - FavTPattGivPow)>
			<cfset myUndFTDrives   = oUndFtAtt + (UndFTAttForPow - FavFTattGivPow)>
			
			
			<cfoutput>
			#fav#<br>
			===========myFAVFGDrives = #myFAVFGDrives#...oFavFgAtt=#oFavFgAtt#...favFGAttForPow=#favFGAttForPow#.. UndFGattGivPow=#UndFGattGivPow#<br>
			===========myFAVTPDrives   = #myFAVTPDrives#<br>
			===========myFAVFTDrives   = #myFAVFTDrives#<br>
			#und#<br>
			===========myUndFGDrives = #myUndFGDrives#<br>
			===========myUndTPDrives   = #myUndTPDrives#<br>
			===========myUndFTDrives   = #myUndFTDrives#<br>

			</cfoutput>


	
	
	
	<cfloop index="myct" from="1" to="2">
	
		<cfif myct is 1>
			<cfset checkthisTP = FavPredTPSuccess>
			<cfset checkthisFG = FavPredFGSuccess>
			<cfset checkthisFT = FavPredFTSuccess>
	
			<cfset myFGDrives    = myFavFGDrives>
			<cfset myTPDrives    = myFavTPDrives>
			<cfset myFTDrives    = myFavFTDrives>

		<cfelse>

			<cfset checkthisTP = UndPredTPSuccess>
			<cfset checkthisFG = UndPredFGSuccess>
			<cfset checkthisFT = UndPredFTSuccess>
			
			<cfset myFGDrives    = myUndFGDrives>
			<cfset myTPDrives    = myUndTPDrives>
			<cfset myFTDrives    = myUndFTDrives>
			
			
		</cfif>
	
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
	
			<!--- For each Fg Frive of the game... --->
			<cfloop index="ii" from="1" to="#myfgDrives#">
			
				<!--- <cfoutput>min is #ii#<br></cfoutput> --->
				<cfscript>
					Rn = Application.objRandom.next();
				</cfscript>
	
				<cfif checkPosseionResult(rn,#checkthisFG#) is 'Success'>
					<cfset Score = score + 2>
				</cfif>	
			</cfloop> <!-- Get next minute... -->

			<!--- For each Fg Frive of the game... --->
			<cfloop index="ii" from="1" to="#myTPDrives#">
			
				<!--- <cfoutput>min is #ii#<br></cfoutput> --->
				<cfscript>
					Rn = Application.objRandom.next();
				</cfscript>
	
				<cfif checkPosseionResult(rn,#checkthisTP#) is 'Success'>
					<cfset Score = score + 3>
				</cfif>	
			</cfloop> <!-- Get next minute... -->


			<!--- For each Freethrow drive of the game... --->
			<cfloop index="ii" from="1" to="#myftDrives#">
			
				<!--- <cfoutput>min is #ii#<br></cfoutput> --->
				<cfscript>
					Rn = Application.objRandom.next();
				</cfscript>
	
				<cfif checkPosseionResult(rn,#checkthisFT#) is 'Success'>
					<cfset Score = score + 1>
				</cfif>	
			</cfloop> <!-- Get next minute... -->
			
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
	
		<cfif Ha is 'H'>
			<!-- For Spreads -->
			<cfset PredFavScore = aFavScore[ii] + 2.5>
			<cfset PredUndScore = aUndscore[ii]>
			<cfset PredMOV = PredFavScore - PredUndscore>
						
			<cfif PredMOV gt #Client.spread#>
				<cfset gamect = gamect + 1>
				<cfset FavCovCt = FavCovCt + 1>
				<cfoutput>
	 			<!--- #fav#:#PredFavscore#....spd: #Client.spread#.....#und#:#PredUndscore#....Favorite covered.....#FavCovct#<br>  --->
				</cfoutput>
			<cfelse>
				<cfif PredMOV lt #Client.spread#>
					<cfset gamect = gamect + 1>
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
					<cfset gamect = gamect + 1>
					<cfset FavCovCt = FavCovCt + 1>
					<cfoutput>
		 			<!--- #fav#:#PredFavscore#....spd: #Client.spread#.....#und#:#PredUndscore#....Favorite covered.....#FavCovct#<br>  --->
					</cfoutput>
			<cfelse>
		
				<cfif PredMOV lt #Client.spread#>
					<cfset gamect = gamect + 1>
					<cfset UndCovCt = UndCovCt + 1>
					<cfoutput>
 					<!--- #fav#:#PredFavscore#....spd: #Client.spread#.....#und#:#PredUndscore#....Underdog covered.....#UndCovct#<br>  --->
					</cfoutput>
				</cfif>	
			</cfif>
		</cfif>	

		<cfif (PredFavScore + PredUndScore) gt myou>
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




