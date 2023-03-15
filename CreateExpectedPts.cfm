<cfquery datasource="NBA" name="Updit">
UPDATE NBAData
SET MOV = PS - DPS
</cfquery>    

<cfquery datasource="NBA" name="Updit">
UPDATE NBASchedule
SET FavExpectedPts = (OU/2) + (spd/2),
    UndExpectedPts = (OU/2) - (spd/2)
WHERE OU > 0	
</cfquery>    

<cfquery datasource="NBA" name="GetGames">
SELECT n.* , gt.gametime
from NBASchedule n, NBAGametime gt
where gt.Gametime = n.gametime
</cfquery>

<cfif 1 is 2>
<cfquery datasource="NBA" name="GetGames">
SELECT n.* 
from NBASchedule n
where n.gametime ='20200111'
</cfquery>
</cfif>

<cfloop query="GetGames">

<cfset Fav        = '#GetGames.Fav#'>
<cfset Und        = '#GetGames.Und#'>
<cfset OU         = GetGames.Ou>
<cfset FavPredPts = GetGames.FavExpectedPts>
<cfset UndPredPts = GetGames.UndExpectedPts>


<cfquery datasource="NBA" name="qFavPredPts">
Select Count(1) as Yes
From NbaData 
where Team = '#Fav#'
AND PS >= #FavPredPts#
and gametime < '#GetGames.Gametime#'
</cfquery>

<cfquery datasource="NBA" name="TotGms">
Select Count(*) as Gms
From NbaData 
where Team = '#Fav#'
and gametime < '#GetGames.Gametime#'
</cfquery>


<cfset PctGms = qFavPredPts.Yes / TotGms.gms>
<cfoutput>
Off Prob: #PctGms#
</cfoutput>


<cfquery datasource="NBA" name="qFavPredPts">
Select Count(1) as Yes
From NbaData 
where Team = '#Und#'
AND DPS >= #FavPredPts#
and gametime < '#GetGames.Gametime#'
</cfquery>

<cfquery datasource="NBA" name="TotGms">
Select Count(*) as Gms
From NbaData 
where Team = '#Und#'
and gametime < '#GetGames.Gametime#'
</cfquery>

<p>
<cfset PctGms = qFavPredPts.Yes / TotGms.gms>
<cfoutput>
Def Prob: #PctGms#
</cfoutput>








<cfquery datasource="NBA" name="qFavPredPts">
Select Count(1) as Yes
From NbaData 
where Team = '#Und#'
AND PS >= #UndPredPts#
and gametime < '#GetGames.Gametime#'
</cfquery>

<cfquery datasource="NBA" name="TotGms">
Select Count(*) as Gms
From NbaData 
where Team = '#Und#'
and gametime < '#GetGames.Gametime#'
</cfquery>

<p>

<cfset PctGms = qFavPredPts.Yes / TotGms.gms>
<cfoutput>
Off Prob: #PctGms#
</cfoutput>

<p>

<cfquery datasource="NBA" name="qFavPredPts">
Select Count(1) as Yes
From NbaData 
where Team = '#Fav#'
AND DPS >= #UndPredPts#
and gametime < '#GetGames.Gametime#'
</cfquery>

<cfquery datasource="NBA" name="TotGms">
Select Count(*) as Gms
From NbaData 
where Team = '#Fav#'
and gametime < '#GetGames.Gametime#'
</cfquery>

<p>
<cfset PctGms = qFavPredPts.Yes / TotGms.gms>
<cfoutput>
Def: #PctGms#
</cfoutput>











-------------------------------------------------------------------------------------------------<br>







<cfquery datasource="NBA" name="qOverFavPredPts">
Select Count(1) as Yes
From NbaData 
where Team = '#Fav#'
AND PS-DPS >= #spd#
and gametime < '#GetGames.Gametime#'
</cfquery>

<cfquery datasource="NBA" name="TotGms">
Select Count(*) as Gms
From NbaData 
where Team = '#Fav#'
and gametime < '#GetGames.Gametime#'
</cfquery>


<cfset PctGms = qOverFavPredPts.Yes / TotGms.gms>
<cfoutput>
FAV Prob Cover Spd: #PctGms#
<cfset FavProbCovPct = PctGms>
</cfoutput>


<cfquery datasource="NBA" name="qOverFavPredPts">
Select Count(1) as Yes
From NbaData 
where Team = '#Und#'
AND DPS - PS <= #spd#
and gametime < '#GetGames.Gametime#'
</cfquery>

<cfquery datasource="NBA" name="TotGms">
Select Count(*) as Gms
From NbaData 
where Team = '#Und#'
and gametime < '#GetGames.Gametime#'
</cfquery>

<p>
<cfset PctGms = qOverFavPredPts.Yes / TotGms.gms>
<cfoutput>
UND Prob NOT Cover Spd: #PctGms#
<cfset UndProbNoCovPct = PctGms>
</cfoutput>

<cfset PredictedFavCovPct = (FavProbCovPct + (1 - UndProbNoCovPct))/2>



<cfquery datasource="NBA" name="qOverFavPredPts">
Select Count(1) as Yes
From NbaData 
where Team = '#Und#'
AND PS-DPS >= -#spd#
and gametime < '#GetGames.Gametime#'
</cfquery>

<cfquery datasource="NBA" name="TotGms">
Select Count(*) as Gms
From NbaData 
where Team = '#Und#'
and gametime < '#GetGames.Gametime#'
</cfquery>

<p>
<cfset PctGms = qOverFavPredPts.Yes / TotGms.gms>
<cfoutput>
UND Prob Cover Spd: #PctGms#
<cfset UndProbCovPct = PctGms>
</cfoutput>


<cfquery datasource="NBA" name="qOverFavPredPts">
Select Count(1) as Yes
From NbaData 
where Team = '#Fav#'
AND DPS - PS <= #spd#
and gametime < '#GetGames.Gametime#'
</cfquery>

<cfquery datasource="NBA" name="TotGms">
Select Count(*) as Gms
From NbaData 
where Team = '#Fav#'
and gametime < '#GetGames.Gametime#'
</cfquery>

<p>
<cfset PctGms = qOverFavPredPts.Yes / TotGms.gms>
<cfoutput>
FAV Prob NOT Cover Spd: #PctGms#
<cfset FavProbNoCovPct = PctGms>
</cfoutput>

<cfset PredictedUndCovPct = (UndProbCovPct + (1 - FavProbNoCovPct))/2>
<p>
************************************************************************************<br>
<cfoutput>
#fav# Predicted Cover Pct: #PredictedFavCovPct# predicted Total is #FavPredPts# <br>
#und# Predicted Cover Pct: #PredictedUndCovPct# predicted Total is #UndPredPts# <br>

<cfset PlayOnFavOver = 'N'>
<cfset PlayOnUndOver = 'N'>

<cfset PlayOnFavUnder = 'N'>
<cfset PlayOnUndUnder = 'N'>
<cfset FavPlayOnSide = ''>
<cfset UndPlayOnSide = ''>

<cfif PredictedFavCovPct gte .50>
	Alert!!....PLAY ON #fav# OVER Team Total of #FavPredPts#<br>
	<cfset PlayOnFavOver = 'Y'>
</cfif>	

<cfif PredictedUndCovPct gte .50>
	Alert!!....PLAY ON #und# OVER Team Total of #UndPredPts#<br>
	<cfset PlayOnUndOver = 'Y'>
</cfif>	

<cfif PredictedFavCovPct lt .30>
	Alert!!....PLAY ON #fav# UNDER Team Total of #FavPredPts#<br>
	<cfset PlayOnFavUnder = 'Y'>
</cfif>	

<cfif PredictedUndCovPct lt .30>
	Alert!!....PLAY ON #und# UNDER Team Total of #UndPredPts#<br>
	<cfset PlayOnUndUnder = 'Y'>
</cfif>	

<cfif PlayOnFavOver is 'Y'>
	<cfif PlayOnUndUnder is 'Y'>
		<cfset FavPlayOnSide = 'Y'>
	</cfif>
</cfif>	


<cfif PlayOnUndOver is 'Y'>
	<cfif PlayOnFavUnder is 'Y'>
		<cfset UndPlayOnSide = 'Y'>
	</cfif>
</cfif>	

<cfif FavPlayOnSide is 'Y'>
	Alert!!!....We have a SIDE play on #fav#<br>
</cfif>

<cfif UndPlayOnSide is 'Y'>
	Alert!!!....We have a SIDE play on #und#<br>
</cfif>



************************************************************************************<br>
<p>
</cfoutput>

<cfset FavPredPts = GetGames.FavExpectedPts>
<cfset UndPredPts = GetGames.UndExpectedPts>


</cfloop>