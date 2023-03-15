<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<cfset Gametime = '20171118'>	
	
<cfquery  datasource="nba" name="GetGames">	
select *
from nbaschedule
where Gametime = '#gametime#'
</cfquery>	


<cfloop query="GetGames">
	<cfset Fav = '#GetGames.Fav#'>
	<cfset Und = '#GetGames.Und#'>
	<cfset HA  = '#GetGames.HA#'>
	<cfset Totals = #GetGames.ou#>
	<cfset FavFinal = 0> 
	<cfset UndFinal = 0> 
	
<!--- Count games played for each Team --->
<cfquery datasource="nba" name="GetGameCtsFav">
SELECT distinct Gametime AS TOTGAMES
FROM PBPResults
WHERE TEAM = '#fav#'
AND GAMETIME > '20171014' and gametime < '#gametime#'
</cfquery>

<cfquery datasource="nba" name="GetGameCtsUnd">
SELECT distinct Gametime AS TOTGAMES
FROM NBADATA
WHERE TEAM = '#und#'
AND GAMETIME > '20171014' and gametime < '#gametime#'
</cfquery>



<!--- Create Total Possessions Per Qtr --->
<cfquery  datasource="nba" name="oGetAvgsFav">	
select 
	o.team,
	SUM(o.TotalPossesions)    as aoTotPoss,
	AVG(o.gs2ptshortmakepct)   as aoShortMake,
	AVG(o.gs2ptmidmakepct)     as aoMidMake,
	AVG(o.gs2ptmakepct)        as ao2ptmake,
	AVG(o.gs3ptmakepct)        as ao3ptmake,
	AVG(o.gsFTMakePct)         as aoFTMake,
	AVG(o.gsTurnoverPct)       as aoTurnover,
	AVG(o.gsShortRebPct + o.gsMidRebPct + o.gsLongRebPct) as aOffReb
from PBPAvgPctsHA o
where o.Team = '#Fav#'
group by o.team, o.OffDef, o.Period
order by o.team, o.OffDef desc, o.Period
</cfquery>	




<!---	
[1] = Off/Qtr1
[2] = Off/Qtr2	
[3] = Off/Qtr3
[4] = Off/Qtr4	
	
[5] = Def/Qtr1
[6] = Def/Qtr2	
[7] = Def/Qtr3
[8] = Def/Qtr4	
--->	
	
<cfquery  datasource="nba" name="oGetAvgsUnd">	
select 
	o.team,
	SUM(o.TotalPossesions)    as aoTotPoss,
	AVG(o.gs2ptshortmakepct)   as aoShortMake,
	AVG(o.gs2ptmidmakepct)     as aoMidMake,
	AVG(o.gs2ptmakepct)        as ao2ptmake,
	AVG(o.gs3ptmakepct)        as ao3ptmake,
	
	AVG(o.gsFTMakePct)         as aoFTMake,
	AVG(o.gsTurnoverPct)       as aoTurnover,
	AVG(o.gsShortRebPct + o.gsMidRebPct + o.gsLongRebPct) as aOffReb
from PBPAvgPctsHA o
where o.Team = '#Und#'
group by o.team, o.OffDef, o.Period 
order by o.team, o.OffDef desc, o.Period
</cfquery>		
	
<!--- Offense --->
<cfset oAvgFavPred2ptmakePct = (oGetAvgsFav.ao2ptmake[1] + oGetAvgsFav.ao2ptmake[2] + oGetAvgsFav.ao2ptmake[3] + oGetAvgsFav.ao2ptmake[4])/4>
<cfset oAvgFavPred3ptmakePct = (oGetAvgsFav.ao3ptmake[1] + oGetAvgsFav.ao3ptmake[2] + oGetAvgsFav.ao3ptmake[3] + oGetAvgsFav.ao3ptmake[4])/4>
<cfset oAvgFavPredFTmakePct  = (oGetAvgsFav.aoFTmake[1] + oGetAvgsFav.aoFTmake[2] + oGetAvgsFav.aoFTmake[3] + oGetAvgsFav.aoFTmake[4])/4>

<cfset oAvgUndPred2ptmakePct = (oGetAvgsUnd.ao2ptmake[1] + oGetAvgsUnd.ao2ptmake[2] + oGetAvgsUnd.ao2ptmake[3] + oGetAvgsUnd.ao2ptmake[4])/4>
<cfset oAvgUndPred3ptmakePct = (oGetAvgsUnd.ao3ptmake[1] + oGetAvgsUnd.ao3ptmake[2] + oGetAvgsUnd.ao3ptmake[3] + oGetAvgsUnd.ao3ptmake[4])/4>
<cfset oAvgUndPredFTmakePct  = (oGetAvgsUnd.aoFTmake[1] + oGetAvgsUnd.aoFTmake[2] + oGetAvgsUnd.aoFTmake[3] + oGetAvgsUnd.aoFTmake[4])/4>
	
<!--- Defense --->	
<cfset dAvgFavPred2ptmakePct = (oGetAvgsFav.ao2ptmake[5] + oGetAvgsFav.ao2ptmake[6] + oGetAvgsFav.ao2ptmake[7] + oGetAvgsFav.ao2ptmake[8])/4>
<cfset dAvgFavPred3ptmakePct = (oGetAvgsFav.ao3ptmake[5] + oGetAvgsFav.ao3ptmake[6] + oGetAvgsFav.ao3ptmake[7] + oGetAvgsFav.ao3ptmake[8])/4>
<cfset dAvgFavPredFTmakePct  = (oGetAvgsFav.aoFTmake[5] + oGetAvgsFav.aoFTmake[6] + oGetAvgsFav.aoFTmake[7] + oGetAvgsFav.aoFTmake[8])/4>

<cfset dAvgUndPred2ptmakePct = (oGetAvgsUnd.ao2ptmake[5] + oGetAvgsUnd.ao2ptmake[6] + oGetAvgsUnd.ao2ptmake[7] + oGetAvgsUnd.ao2ptmake[8])/4>
<cfset dAvgUndPred3ptmakePct = (oGetAvgsUnd.ao3ptmake[5] + oGetAvgsUnd.ao3ptmake[6] + oGetAvgsUnd.ao3ptmake[7] + oGetAvgsUnd.ao3ptmake[8])/4>
<cfset dAvgUndPredFTmakePct  = (oGetAvgsUnd.aoFTmake[5] + oGetAvgsUnd.aoFTmake[6] + oGetAvgsUnd.aoFTmake[7] + oGetAvgsUnd.aoFTmake[8])/4>
	
	
<!--- Predicted Avgs --->
<cfset FavGamePred2pt = (oAvgFavPred2ptmakePct + dAvgUndPred2ptmakePct)/2> 	
<cfset FavGamePred3pt = (oAvgFavPred3ptmakePct + dAvgUndPred3ptmakePct)/2> 		
<cfset FavGamePredFT  = (oAvgFavPredFTmakePct + dAvgUndPredFTmakePct)/2> 		
	
<cfset UndGamePred2pt = (dAvgFavPred2ptmakePct + oAvgUndPred2ptmakePct)/2> 	
<cfset UndGamePred3pt = (dAvgFavPred3ptmakePct + oAvgUndPred3ptmakePct)/2> 		
<cfset UndGamePredFT  = (dAvgFavPredFTmakePct + oAvgUndPredFTmakePct)/2> 		

<cfset FavGamePredTotPossQ1 = oGetAvgsFav.aoTotPoss[1] / GetGameCtsFav.Recordcount>
<cfset FavGamePredTotPossQ2 = oGetAvgsFav.aoTotPoss[2] / GetGameCtsFav.Recordcount>
<cfset FavGamePredTotPossQ3 = oGetAvgsFav.aoTotPoss[3] / GetGameCtsFav.Recordcount>
<cfset FavGamePredTotPossQ4 = oGetAvgsFav.aoTotPoss[4] / GetGameCtsFav.Recordcount>



<cfset UndGamePredTotPossQ1 = oGetAvgsUnd.aoTotPoss[1] / GetGameCtsUnd.Recordcount>
<cfset UndGamePredTotPossQ2 = oGetAvgsUnd.aoTotPoss[2] / GetGameCtsUnd.Recordcount>
<cfset UndGamePredTotPossQ3 = oGetAvgsUnd.aoTotPoss[3] / GetGameCtsUnd.Recordcount>
<cfset UndGamePredTotPossQ4 = oGetAvgsUnd.aoTotPoss[4] / GetGameCtsUnd.Recordcount>

<cfset oFAVPOSS = ((oGetAvgsFav.aoTotPoss[1] + oGetAvgsFav.aoTotPoss[2] + oGetAvgsFav.aoTotPoss[3] + oGetAvgsFav.aoTotPoss[4])/4) / GetGameCtsFav.Recordcount >
<cfset oUNDPOSS = ((oGetAvgsUnd.aoTotPoss[1] + oGetAvgsUnd.aoTotPoss[2] + oGetAvgsUnd.aoTotPoss[3] + oGetAvgsUnd.aoTotPoss[4])/4) / GetGameCtsUnd.Recordcount >

<cfset dFAVPOSS = ((oGetAvgsFav.aoTotPoss[5] + oGetAvgsFav.aoTotPoss[6] + oGetAvgsFav.aoTotPoss[7] + oGetAvgsFav.aoTotPoss[8])/4) / GetGameCtsFav.Recordcount >
<cfset dUNDPOSS = ((oGetAvgsUnd.aoTotPoss[5] + oGetAvgsUnd.aoTotPoss[6] + oGetAvgsUnd.aoTotPoss[7] + oGetAvgsUnd.aoTotPoss[8])/4) / GetGameCtsUnd.Recordcount >




<cfset FAVPOSS = ((oGetAvgsFav.aoTotPoss[1] + oGetAvgsFav.aoTotPoss[2] + oGetAvgsFav.aoTotPoss[3] + oGetAvgsFav.aoTotPoss[4])/4) / GetGameCtsFav.Recordcount >
<cfset UNDPOSS = ((oGetAvgsUnd.aoTotPoss[1] + oGetAvgsUnd.aoTotPoss[2] + oGetAvgsUnd.aoTotPoss[3] + oGetAvgsUnd.aoTotPoss[4])/4) / GetGameCtsUnd.Recordcount >

<cfset FAVPoss = (oFAVPOSS + dUNDPOSS)/2> 
<cfset UNDPoss = (dFAVPOSS + oUNDPOSS)/2> 


<!--- Calculate Projected Scores By Each QTR --->
<cfset Q1Fav = 2*(FavGamePred2pt*FAVPOSS) + 3*(FavGamePred3pt*FAVPOSS) + FavGamePredFT*FAVPOSS> 	
<cfset Q2Fav = 2*(FavGamePred2pt*FAVPOSS) + 3*(FavGamePred3pt*FAVPOSS) + FavGamePredFT*FAVPOSS> 		
<cfset Q3Fav = 2*(FavGamePred2pt*FAVPOSS) + 3*(FavGamePred3pt*FAVPOSS) + FavGamePredFT*FAVPOSS> 	
<cfset Q4Fav = 2*(FavGamePred2pt*FAVPOSS) + 3*(FavGamePred3pt*FAVPOSS) + FavGamePredFT*FAVPOSS> 	
	
<cfset Q1Und = 2*(UndGamePred2pt*UNDPOSS) + 3*(UndGamePred3pt*UNDPOSS) + UndGamePredFT*UNDPOSS> 	
<cfset Q2Und = 2*(UndGamePred2pt*UNDPOSS) + 3*(UndGamePred3pt*UNDPOSS) + UndGamePredFT*UNDPOSS> 		
<cfset Q3Und = 2*(UndGamePred2pt*UNDPOSS) + 3*(UndGamePred3pt*UNDPOSS) + UndGamePredFT*UNDPOSS> 	
<cfset Q4Und = 2*(UndGamePred2pt*UNDPOSS) + 3*(UndGamePred3pt*UNDPOSS) + UndGamePredFT*UNDPOSS>	




<cfset FavFinal = Q1Fav + Q2Fav + Q3Fav + Q4Fav>
<cfset UndFinal = Q1Und + Q2Und + Q3Und + Q4Und>

<cfif Ha is 'H'>
	<cfset FavFinal = FavFinal + (2.33/2)> 
	<cfset UndFinal = UndFinal - (2.33/2)> 
<cfelse>
	<cfset FavFinal = FavFinal - (2.33/2)> 
	<cfset UndFinal = UndFinal + (2.33/2)> 
</cfif>
	
<cfoutput>	
#fav#: #FavFinal#<br>
#Und#: #UndFinal#<br>
Ousr Spd: #(favfinal) - (undfinal)#.Actual Spd:...#spd#<br>
#(favfinal) + (undfinal)# vs Vegas Total of #totals#<br>
</cfoutput>
<cfdump var="#variables#">
<p>
</cfloop>
