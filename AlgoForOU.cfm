


<cfset gametime = Session.Gametime2>

<cfquery name="GetSpds" datasource="nba" >
SELECT *
FROM nbaschedule
where trim(GAMETIME) = '#GAMETIME#'
</cfquery>
 
<cfloop query="Getspds">
	<cfset fav      = "#Getspds.fav#">
	<cfset und      = "#GetSpds.und#">
	<cfset thespd   = #val(GetSpds.spd)#>
	<cfset theTotal = #GetSpds.OU#>

<cfset VegasFAVPredScore = (theTotal/2) + (thespd/2)>
<cfset VegasUNDPredScore = (theTotal/2) - (thespd/2)>

<cfquery Datasource="NBA" Name="GetFAVRank">
Select * from TeamRank Where Team = '#fav#' and gametime='#gametime#'
</cfquery>
 
<cfquery Datasource="NBA" Name="GetUNDRank">
Select * from TeamRank Where Team = '#und#' and gametime='#gametime#'
</cfquery>

<cfset FavAvgOffPS = GetFAVRank.AvgPS>
<cfset FavAvgDefPS = GetFAVRank.AvgDPS>

<cfset UndAvgOffPS = GetUndRank.AvgPS>
<cfset UndAvgDefPS = GetUndRank.AvgDPS>
<cfset totpct = 0>
<cfset ProbFavOverVegasPred = 0>
<cfset ProbFavUnderVegasPred = 0>
<cfset ProbUndOverVegasPred = 0>
<cfset ProbUndUnderVegasPred = 0>
<cfset FavOffOverProb = 0>
<cfset FavOffUnderProb = 0>
<cfset UndOffOverProb = 0>
<cfset UndOffUnderProb = 0>

<!--- Fav Predicted to score MORE than the Underdogs AVG DPS --->
<cfif GetFAVRank.OffBetterPct gte GetFAVRank.OffWorsePct>
	<cfif VegasFAVPredScore lte GetUNDRank.AvgDPS>
		<cfset FavOffOverProb = GetFAVRank.OffBetterPct/100>

	<cfelse>
	
		<cfset Compare = VegasFAVPredScore - UndAvgDefPS>
		<cfif compare gt 0>
			<cfloop index="i" from="#Round(Compare)+1#" to="22">
				<cfset totpct = totpct + #evaluate("GetFAVRank.OffBetter#i#")#>
								
			</cfloop>	
		
			<cfset FavOffOverProb = (GetFAVRank.OffBetterPct/100)*(totpct/100)>	
		<cfelse>
			<cfset FavOffOverProb = GetFAVRank.OffBetterPct/100>
		</cfif>
		
	</cfif>

<cfelse>
	<!--- Fav Predicted to score LESS than the Underdogs AVG DPS --->
	<cfif VegasFAVPredScore gt GetUNDRank.AvgDPS>
		<cfset FavOffUnderProb = GetFAVRank.OffWorsePct/100>

	<cfelse>
		<cfset Compare = VegasFAVPredScore - UndAvgDefPS>
		<cfif Compare gt 0>
			<cfloop index="i" from="#Round(Compare)+1#" to="22">
				<cfset totpct = totpct + #evaluate("GetFAVRank.OffWorse#i#")#>
			</cfloop>	
		
			<cfset FavOffUnderProb = (GetFAVRank.OffWorsePct/100)*(totpct/100)>	
		<cfelse>
			<cfset FavOffUnderProb = GetFAVRank.OffWorsePct/100>
		</cfif>
	</cfif>

</cfif>

<cfset FavOver  = false>
<cfset FavUnder = false>
<cfset UndOver  = false>
<cfset UndUnder = false>

<cfset FavOverSc  = 0>
<cfset FavUnderSc = 0>
<cfset UndOverSc  = 0>
<cfset UndUnderSc = 0>


<cfoutput>
Offensive Predictions:<br>
<cfif FavOffOverProb gt 0>
	<cfset FavOver    = true>
	<cfset FavOverSc  = 100*FavOffOverProb>
	Probability of #FAV# scoring MORE than #VegasFAVPredScore# is #100*FavOffOverProb#<br>
	<br>
<cfelse>
	<cfif FavOffUnderProb GT 0> 
		<cfset FavUnder = true>
		<cfset FavUnderSc  = 100*FavOffUnderProb>
		Probability of #FAV# scoring LESS than #VegasFAVPredScore# is #100*FavOffUnderProb#<br>
	</cfif>	
</CFIF>
</cfoutput>






<cfset UndOffOverProb  = 0>
<cfset UndOffUnderProb = 0>
<cfset totpct =0>

<cfif GetUNDRank.OffBetterPct gte GetUNDRank.OffWorsePct>
	<cfif VegasUNDPredScore lte GetFAVRank.AvgDPS>
		<cfset UndOffOverProb = GetUNDRank.OffBetterPct/100>

	<cfelse>
		<cfset Compare = VegasUNDPredScore - FAVAvgDefPS>

		<cfloop index="i" from="#Round(Compare)+1#" to="22">
			<cfset totpct = totpct + #evaluate("GetUNDRank.OffBetter#i#")#>
		</cfloop>	
		
		<cfset UndOffOverProb = (GetUNDRank.OffBetterPct/100)*(totpct/100)>	
		
		
	</cfif>

<cfelse>
	<!--- Und Predicted to score LESS than the Favorite AVG DPS --->
	<cfif VegasUNDPredScore gt GetFAVRank.AvgDPS>
		<cfset UndOffUnderProb = GetUNDRank.OffWorsePct/100>
	<cfelse>
		<cfset Compare = VegasUNDPredScore - FavAvgDefPS>
		
		<cfif Compare gt 0>
			<cfloop index="i" from="#Round(Compare)+1#" to="22">
		
				<cfset totpct = totpct + #evaluate("GetUNDRank.OffWorse#i#")#>
			</cfloop>	
		
			<cfset UndOffUnderProb = (GetUNDRank.OffWorsePct/100)*(totpct/100)>	
		<cfelse>
			<cfset UndOffUnderProb = GetUNDRank.OffWorsePct/100>
		</cfif>	
	</cfif>
</cfif>
<p>

<cfoutput>
<cfif UndOffOverProb gt 0>
	<cfset UndOver    = true>
	<cfset UndOverSc  = 100*UndOffOverProb>
Probability of #UND# scoring MORE than #VegasUNDPredScore# is #100*UndOffOverProb#<br>
</cfif>
<cfif UndOffUnderProb gt 0>
	<cfset UndUnder    = true>
	<cfset UndUnderSc  = 100*UndOffUnderProb>
	Probability of #UND# scoring LESS than #VegasUNDPredScore# is #100*UndOffUnderProb#<br>
</cfif>
</cfoutput>


<cfset totpct=0>
			
<cfset FavDefUnderProb = 0>
<cfset FavDefOverProb =  0>
			
<!--- Fav Predicted to give up LESS than the Underdogs AVG PS --->
<cfif GetFAVRank.DefBetterPct gte GetFAVRank.DefWorsePct>
	<cfif VegasUNDPredScore lte GetUNDRank.AvgPS>
		<cfset FavDefUnderProb = GetFAVRank.DefBetterPct/100>

	<cfelse>
	
		<cfset Compare = VegasUNDPredScore - UndAvgOffPS>
		<cfif compare gt 0>
			<cfloop index="i" from="#Round(Compare)+1#" to="22">
				<cfset totpct = totpct + #evaluate("GetFAVRank.OffBetter#i#")#>
			</cfloop>	
		
			<cfset FavDefUnderProb = (GetFAVRank.DefBetterPct/100)*(totpct/100)>	
		<cfelse>
			<cfset FavDefUnderProb = GetFAVRank.DefBetterPct/100>
		</cfif>
		
	</cfif>

<cfelse>
	<!--- Fav Predicted to give up MORE than the Underdogs AVG PS --->
	<cfif VegasUNDPredScore gt GetUNDRank.AvgPS>
		<cfset FavDefOverProb = GetFAVRank.DefWorsePct/100>

	<cfelse>
		<cfset Compare = VegasUNDPredScore - UndAvgOffPS>
		<cfif Compare gt 0>
			<cfloop index="i" from="#Round(Compare)+1#" to="22">
				<cfset totpct = totpct + #evaluate("GetFAVRank.DefWorse#i#")#>
			</cfloop>	
		
			<cfset FavDefOverProb = (GetFAVRank.DefWorsePct/100)*(totpct/100)>	
		<cfelse>
			<cfset FavDefOverProb = GetFAVRank.DefWorsePct/100>
		
		</cfif>
	</cfif>

</cfif>
<p>


<cfset DefFavOver  = false>
<cfset DefFavUnder = false>
<cfset DefUndOver  = false>
<cfset DefUndUnder = false>

<cfset DefFavOverSc  = 0>
<cfset DefFavUnderSc = 0>
<cfset DefUndOverSc  = 0>
<cfset DefUndUnderSc = 0>


<cfoutput>
Defensive Predictions:<br>
<cfif FavDefOverProb gt 0>
	<cfset DefFavOver    = true>
	<cfset DefFavOverSc  = 100*FavDefOverProb>

Probability of #FAV# giving up MORE than #VegasUNDPredScore# is #100*FavDefOverProb#<br>
</cfif>
<cfif FavDefUnderProb gt 0>
Probability of #FAV# giving up LESS than #VegasUNDPredScore# is #100*FavDefUnderProb#<br>
	<cfset DefFavUnder    = true>
	<cfset DefFavUnderSc  = 100*FavDefUnderProb>

</cfif>
</cfoutput>













<cfset UndDefUnderProb = 0>
<cfset UndDefOverProb =  0>
<cfset totpct = 0>			
<!--- Und Predicted to give up LESS than the FAV AVG PS --->
<cfif GetUNDRank.DefBetterPct gte GetUNDRank.DefWorsePct>
	<cfif VegasFAVPredScore lte GetFAVRank.AvgPS>
		<cfset UNDDefUnderProb = GetUNDRank.DefBetterPct/100>

	<cfelse>
	
		<cfset Compare = VegasFAVPredScore - FAVAvgOffPS>
		<cfif compare gt 0>
			<cfloop index="i" from="#Round(Compare)+1#" to="22">
				<cfset totpct = totpct + #evaluate("GetUNDRank.OffBetter#i#")#>
			</cfloop>	
		
			<cfset UndDefUnderProb = (GetUNDRank.DefBetterPct/100)*(totpct/100)>	
		<cfelse>
			<cfset UndDefUnderProb = GetUNDRank.DefBetterPct/100>
		</cfif>
		
	</cfif>

<cfelse>
	<!--- Und Predicted to give up MORE than the FAV AVG PS --->
	<cfif VegasFAVPredScore gt GetFAVRank.AvgPS>
		<cfset UndDefOverProb = GetUNDRank.DefWorsePct/100>

	<cfelse>
		<cfset Compare = VegasFAVPredScore - FAVAvgOffPS>
		<cfif Compare gt 0>
			<cfloop index="i" from="#Round(Compare)+1#" to="22">
				<cfset totpct = totpct + #evaluate("GetUNDRank.DefWorse#i#")#>
			</cfloop>	
		
			<cfset UndDefOverProb = (GetUndRank.DefWorsePct/100)*(totpct/100)>	
		<cfelse>
		
			<cfset UndDefOverProb = GetUndRank.DefWorsePct/100>
		</cfif>
	</cfif>

</cfif>

<p>
<cfoutput>
Defensive Predictions:<br>
<cfif UndDefOverProb gt 0>
Probability of #UND# giving up MORE than #VegasFAVPredScore# is #100*UndDefOverProb#<br>
	<cfset DefUndOver      = true>
	<cfset DefUndOverSc  = 100*UndDefOverProb>

</cfif>

<cfif UndDefUnderProb gt 0>
Probability of #UND# giving up LESS than #VegasFAVPredScore# is #100*UndDefUnderProb#<br>
	<cfset DefUndUnder      = true>
	<cfset DefUndUnderSc  = 100*UndDefUnderProb>

</cfif>
</cfoutput>
<p>
***********************************************************************************************************************************<br>

<cfif FavOver is true and DefUndOver is true>
	<cfset FavFinal = (FavOverSc + DefUndOverSc) / 2>
	<cfset FavDesc = 'OVER'>
</cfif>

<cfif FavOver is true and DefUndUnder is true>
	
	<cfif FavOverSc gte DefUndUnderSc>
		<cfset FavFinal = (FavOverSc + (100 - DefUndUnderSc))/2 >
		<cfset FavDesc = 'OVER'>
	<cfelse>
		<cfset FavFinal = (DefUndUnderSc + (100 - FavOverSc))/2 >
		<cfset FavDesc = 'UNDER'>
	</cfif>	
</cfif>

<cfif FavUnder is true and DefUndUnder is true>
	<cfset FavFinal = (FavUnderSc + DefUndUnderSc) / 2>
	<cfset FavDesc = 'UNDER'>
</cfif>

<cfif FavUnder is true and DefUndOver is true>
	
	<cfif FavUnderSc gte DefUndOverSc>
		<cfset FavFinal = (FavUnderSc + (100 - DefUndOverSc))/2 >
		<cfset FavDesc = 'UNDER'>
	<cfelse>
		<cfset FavFinal = (DefUndOverSc + (100 - FavUnderSc))/2 >
		<cfset FavDesc = 'OVER'>
	</cfif>	
</cfif>





<!--- Same way --->
<cfif UndOver is true and DefFavOver is true>
	<cfset UndFinal = (UndOverSc + DefFavOverSc) / 2>
	<cfset UndDesc = 'OVER'>
</cfif>

<!--- Opposite way --->
<cfif UndOver is true and DefFavUnder is true>
	
	<cfif UndOverSc gte DefFavUnderSc>
		<cfset UndFinal = (UndOverSc + (100 - DefFavUnderSc))/2 >
		<cfset UndDesc = 'OVER'>
	<cfelse>
		<cfset UndFinal = (DefFavUnderSc + (100 - UndOverSc))/2 >
		<cfset UndDesc = 'UNDER'>
	</cfif>	
</cfif>

<cfif UndUnder is true and DefFavUnder is true>
	<cfset UndFinal = (UndUnderSc + DefFavUnderSc) / 2>
	<cfset UndDesc = 'UNDER'>
</cfif>

<cfif UndUnder is true and DefFavOver is true>
	
	<cfif UndUnderSc gte DefFavOverSc>
		<cfset UndDesc = 'UNDER'>
	    <cfset UndFinal = (UndUnderSc + (100 - DefFavOverSc))/2 >
	<cfelse>
		<cfset UndDesc = 'OVER'>
		<cfset UndFinal = (DefFavOverSc + (100 - UndUnderSc))/2 >
	</cfif>	
</cfif>


<cfset BetFav = ''>
<cfset BetUnd = ''>
<cfset FavSpdConfidence = 0>
<cfset UndSpdConfidence = 0>
<cfset OverPlayFlag  = 'N'>
<cfset UnderPlayFlag = 'N'>
<cfset TotalConfidence = 0>
<cfset FavSpdWinConfidence = 0>
<cfset UndSpdWinConfidence = 0>

<cfif FavDesc is UndDesc>
	<cfif FavDesc is 'OVER'>
		<cfset OverPlayFlag = 'Y'>
	<cfelse>
		<cfset UnderPlayFlag = 'Y'>
	</cfif>	
	<cfset TotalConfidence = (FavFinal + UndFinal)/2>
<cfelse>
	<cfif FavFinal gt UndFinal>
		<cfif FavDesc is 'OVER'>
			<cfset OverPlayFlag = 'Y'>
			
		<cfelse>
			<cfset UnderPlayFlag = 'Y'>
		</cfif>	
		<cfset TotalConfidence = (FavFinal + UndFinal)/2>
		
	<cfelse>
		<cfset TotalConfidence = (UndFinal + FavFinal)/2>
		<cfif UndDesc is 'OVER'>
			<cfset OverPlayFlag = 'Y'>
			
		<cfelse>
			<cfset UnderPlayFlag = 'Y'>
		</cfif>	
		
		
	</cfif>	
</cfif>


<cfif FavDesc is 'UNDER'>
	<cfif UndDesc is 'OVER'>
		<cfset BetUnd = 'Y'>
		<cfset UndSpdWinConfidence = (FavFinal + UndFinal)/2>
		
	</cfif>
</cfif>

<cfif FavDesc is 'OVER'>
	<cfif UndDesc is 'UNDER'>
		<cfset BetFav = 'Y'>
		<cfset FavSpdWinConfidence = (FavFinal + UndFinal)/2>
	</cfif>
</cfif>



<cfoutput>
****************************************<br>
FINAL:<br> 
#Fav# #FavDesc# #VegasFAVPredScore# confidence is #FavFinal#<br>
#Und# #UndDesc# #VegasUNDPredScore# confidence is #UndFinal#<br>
****************************************<br>

<p>


<cfquery datasource="NBA" name="Additxxx">
INSERT INTO TeamPerfPicks(Gametime,Fav,Spd,Und,Total,TotalConfidence,FavConfidencePct,UndConfidencePct,FavSpdConfidence,UndSpdConfidence,VegasPredFavSc,VegasPredUndSc,FavPickType,UndPickType,Over_Play_Flag,Under_Play_Flag,Fav_Play_Flag,Und_Play_Flag)
values('#gametime#','#fav#',#thespd#,'#und#',#thetotal#,#TotalConfidence#,#FavFinal#,#UndFinal#,#FavSpdWinConfidence#,#UndSpdWinConfidence#,#VegasFAVPredScore#,#VegasUNDPredScore#,'#FavDesc#','#UndDesc#','#OverPlayFlag#','#UnderPlayFlag#','#BetFav#','#BetUnd#')
</cfquery>


</cfoutput>



<p>
</cfloop>

<cfquery datasource="NBA" name="GetFav">
Select d.PS, d.DPS, d.ps+d.dps as gametotal,d.gametime,d.team, d.ps-d.dps as FAVMOV
from NBAData d, TeamPerfPicks p
Where d.Team = p.Fav
and d.gametime = p.gametime
and d.mins = 240
</cfquery>

<cfquery datasource="NBA" name="GetUND">
Select d.PS, d.DPS, d.ps+d.dps as gametotal,d.gametime,d.team, d.ps-d.dps as UNDMOV
from NBAData d, TeamPerfPicks p
Where d.Team = p.Und
and d.gametime = p.gametime
and d.mins = 240
</cfquery>

<cfloop query="GetFav">

	<cfquery datasource="NBA" name="updit">
	UPDATE TeamPerfPicks
	SET FavActualPS = #GetFav.PS#,
	ActualTotPts = #GetFav.gametotal#,
	FavMOV       = #GetFav.FavMOV#
	WHERE Fav    = '#GetFav.Team#'
	AND Gametime = '#GetFav.Gametime#'
	</cfquery>
</cfloop>

<cfloop query="GetUND">

	<cfquery datasource="NBA" name="updit">
	UPDATE TeamPerfPicks
	SET UndActualPS = #GetUND.PS#,
	ActualTotPts = #GetUND.gametotal#,
	UndMOV       = #GetUnd.UndMOV#
	WHERE Und    = '#GetUnd.Team#'
	AND Gametime = '#GetUnd.Gametime#'
	</cfquery>
	
</cfloop>

<cfabort>		



		
Algo:

Offensive Predictions:
1. Compare which is larger FavOffBetterPct vs FavOffWorsePct
	If FavOffBetterPct >= FavOffWorsePct
	
		if VegasScorePredForFav <= Opp DPS Avg
			Use FavOffBetterPct as the probability
			
		if VegasScorePredForFav > Opp DPS Avg	
			Set Compare = (Take VegasScorePredForFav - Opp DPS Avg)
		
		If ROUND(Compare) > 0 then 
			
			Loop for ROUND(Compare) to 22
				Sum up the OffBetter#Loopct#
			End loop	
				
			Take FavOffBetterPct/100 * 	(Sum up the OffBetter#Loopct#/100) and this is the probability that Team will go OVER vegas number
			
		
			
			
2. 			
	
	If FavOffBetterPct < FavOffWorsePct
	
		if VegasScorePredForFav <= Opp DPS Avg
			Use FavOffWorsePct as the probability
			
		if VegasScorePredForFav > Opp DPS Avg	
			Set Compare = (Take VegasScorePredForFav - Opp DPS Avg)
		
		If ROUND(Compare) > 0 then 
			
			Loop for ROUND(Compare) to 22
				Sum up the OffWorse#Loopct#
			End loop	
				
			Take FavOffWorsePct/100 * 	(Sum up the OffWorse#Loopct#/100) and this is the probability that Team will go UNDER vegas number
			
		
			
		
		
Defensive Predictions:		

FAVORITE Hold opponent UNDER the Vegas number
1. Compare which is larger FAVDefBetterPct vs FAVDefWorsePct
	If FAVDefBetterPct >= FAVDefWorsePct
	
		if VegasScorePredForUND >= UND PS Avg
			Use FAVDefBetterPct as the probability
			
		if VegasScorePredForUND < UND PS Avg	
			Set Compare = (Take UND PS Avg - VegasScorePredForUND)
		
		If ROUND(Compare) > 0 then 
			
			Loop for ROUND(Compare) + 1 to 22 
				Sum up the DefBetter#Loopct#
			End loop	
				
			Take FAVDefBetterPct/100 * 	(Sum up the DefBetter#Loopct#/100) and this is the probability that UND will go UNDER the vegas number
			
			
UNDERDOG Hold opponent UNDER the Vegas number
1. Compare which is larger UNDDefBetterPct vs UNDDefWorsePct
	If UNDDefBetterPct >= UNDDefWorsePct
	
		if VegasScorePredForFAV >= FAV PS Avg
			Use UNDDefBetterPct as the probability
			
		if VegasScorePredForFAV < FAV PS Avg	
			Set Compare = (Take FAV PS Avg - VegasScorePredForFAV)
		
		If ROUND(Compare) > 0 then 
			
			Loop for ROUND(Compare) + 1 to 22 
				Sum up the DefBetter#Loopct#
			End loop	
				
			Take UNDDefBetterPct/100 * 	(Sum up the DefBetter#Loopct#/100) and this is the probability that FAV will go UNDER the vegas number
			
		
			
			
			
			
FAVORITE opponent goes OVER the Vegas number
1. Compare which is larger FAVDefBetterPct vs FAVDefWorsePct
	If FAVDefWorsePct > FAVDefBetterPct 
	
		if VegasScorePredForUND <= UND PS Avg
			Use FAVDefWorsePct as the probability
			
		if VegasScorePredForUND > UND PS Avg	
			Set Compare = (Take VegasScorePredForUND - UND PS Avg)
		
		If ROUND(Compare) > 0 then 
			
			Loop for ROUND(Compare) + 1 to 22 
				Sum up the DefWorse#Loopct#
			End loop	
				
			Take FAVDefWorsePct/100 * 	(Sum up the DefWorse#Loopct#/100) and this is the probability that UND will go OVER the vegas number
			
				
			
			
UNDERDOG opponent goes OVER the Vegas number
1. Compare which is larger UNDDefBetterPct vs UNDDefWorsePct
	If UNDDefWorsePct > UNDDefBetterPct 
	
		if VegasScorePredForFAV <= FAV PS Avg
			Use UNDDefWorsePct as the probability
			
		if VegasScorePredForFAV > FAV PS Avg	
			Set Compare = (Take VegasScorePredForFAV - FAV PS Avg)
		
		If ROUND(Compare) > 0 then 
			
			Loop for ROUND(Compare) + 1 to 22 
				Sum up the DefWorse#Loopct#
			End loop	
				
			Take UNDDefWorsePct/100 * 	(Sum up the DefWorse#Loopct#/100) and this is the probability that UND will go OVER the vegas number
			
				
			
						
			
			
			
			
			


