<cfset gametime='20171117'>

<cfquery datasource="NBA" name="GetGames">
Select *
from NbaSchedule 
where Gametime = '#gametime#'
</cfquery>

<cfloop query="GetGames">

<cfset Fav = '#GetGames.fav#'>
<cfset Und = '#GetGames.und#'>
<cfset ha  = '#GetGames.ha#'>


<cfquery datasource="NBA" name="GetFavTotGames">
Select 
	TEAM,
	Gametime
from PbPResults 
where OffDef ='O'
and Team     = '#fav#'
group by Team,Gametime
</cfquery>

<cfquery datasource="NBA" name="GetUndTotGames">
Select 
	TEAM,
	Gametime
from PbPResults 
where OffDef ='O'
and Team     = '#Und#'
group by Team,Gametime
</cfquery>



<cfquery datasource="NBA" name="GetFavPoss">
Select SUM(TotalPossesions) AS TOTPOSS
from PbPAvgPctsHA 
where OffDef ='O'
and Team     = '#fav#'
</cfquery>

<cfquery datasource="NBA" name="GetUndPoss">
Select SUM(TotalPossesions) AS TOTPOSS
from PbPAvgPctsHA 
where OffDef ='O'
and Team     = '#Und#'
</cfquery>




<cfquery datasource="NBA" name="GetFavStatPreds">
Select 
	AVG(fav.vShortSucPct)   as VShortSuc,
	AVG(fav.ShortSucPct)    as ShortSuc,
	AVG(fav.MidSucPct)      as MidSuc,
	AVG(fav.MidLongSucPct)  as MidLongSuc,
	AVG(fav.LongSucPct)     as LongSuc,
	AVG(fav.gsFTMakePct)    as FTSuc
from PbPAvgPctsHA Fav
where fav.OffDef ='O'
and fav.Team     = '#fav#'
</cfquery>


<cfquery datasource="NBA" name="GetUndStatPreds">
Select 
	AVG(und.vShortSucPct)   as VShortSuc,
	AVG(und.ShortSucPct)    as ShortSuc,
	AVG(und.MidSucPct)      as MidSuc,
	AVG(und.MidLongSucPct)  as MidLongSuc,
	AVG(und.LongSucPct)     as LongSuc,
	AVG(und.gsFTMakePct)    as FTSuc
from PbPAvgPctsHA Und
where und.OffDef ='O'
and und.Team     = '#und#'
</cfquery>

<cfset FavTotPosForSim = GetFavPoss.TotPoss / GetFavTotGames.recordcount>
<cfset UndTotPosForSim = GetUndPoss.TotPoss / GetUndTotGames.recordcount>

<cfset FavVShortPts   = 2 * (GetFavStatPreds.VShortSuc * FavTotPosForSim)>
<cfset FavShortPts    = 2 * (GetFavStatPreds.ShortSuc * FavTotPosForSim)>
<cfset FavMidPts      = 2 * (GetFavStatPreds.MidSuc * FavTotPosForSim)>
<cfset FavMidLongPts  = 2 * (GetFavStatPreds.MidLongSuc * FavTotPosForSim)>
<cfset FavLongPts     = 3 * (GetFavStatPreds.LongSuc * FavTotPosForSim)>
<cfset FavFT          = 1 * (GetFavStatPreds.FTSuc * FavTotPosForSim)>

<cfset UndVShortPts   = 2 * (GetUndStatPreds.VShortSuc * UndTotPosForSim)>
<cfset UndShortPts    = 2 * (GetUndStatPreds.ShortSuc * UndTotPosForSim)>
<cfset UndMidPts      = 2 * (GetUndStatPreds.MidSuc * UndTotPosForSim)>
<cfset UndMidLongPts  = 2 * (GetUndStatPreds.MidLongSuc * UndTotPosForSim)>
<cfset UndLongPts     = 3 * (GetUndStatPreds.LongSuc * UndTotPosForSim)>
<cfset UndFT          = 1 * (GetUndStatPreds.FTSuc * UndTotPosForSim)>

<cfset FavFinalPts = FavVShortPts + FavShortPts + FavMidPts + FavMidLongPts + FavLongPts + FavFT>
<cfset UndFinalPts = UndVShortPts + UndShortPts + UndMidPts + UndMidLongPts + UndLongPts + UndFT>




<cfoutput>
<table width="50%" Border="1" cellpadding="4" cellspacing="4">
<tr>
<td>Team</td>
<td>Very Short Points</td>
<td>Short Points</td>
<td>Mid Points</td>
<td>Mid Long Points</td>
<td>Long Points</td>
<td>Total Expected Points</td>

</tr>

<tr>
<td>#Fav#</td>
<td>#FavVShortPts#</td>
<td>#FavShortPts#</td>
<td>#FavMidPts#</td>
<td>#FavMidLongPts#</td>
<td>#FavLongPts#</td>
<td>#FavFinalPts#</td>
</tr>

<tr>
<td>#Und#</td>
<td>#UndVShortPts#</td>
<td>#UndShortPts#</td>
<td>#UndMidPts#</td>
<td>#UndMidLongPts#</td>
<td>#UndLongPts#</td>
<td>#UndFinalPts#</td>
</tr>

</table>


**********************************************<br>
PREDICTION:<br>
#FAV# #FavFinalPts#<br>
#UND# #UndFinalPts#<br>
Spread: #FavFinalPts - UndFinalPts#<br>
Total: #FavFinalPts + UndFinalPts#
**********************************************<br>

</cfoutput>















<p>
<p>











<cfquery datasource="NBA" name="GetFavTotGames">
Select 
	TEAM,
	Gametime
from PbPResults 
where OffDef ='D'
and Team     = '#fav#'
group by Team,Gametime
</cfquery>

<cfquery datasource="NBA" name="GetUndTotGames">
Select 
	TEAM,
	Gametime
from PbPResults 
where OffDef ='D'
and Team     = '#Und#'
group by Team,Gametime
</cfquery>



<cfquery datasource="NBA" name="GetFavPoss">
Select SUM(TotalPossesions) AS TOTPOSS
from PbPAvgPctsHA 
where OffDef ='D'
and Team     = '#fav#'
</cfquery>

<cfquery datasource="NBA" name="GetUndPoss">
Select SUM(TotalPossesions) AS TOTPOSS
from PbPAvgPctsHA 
where OffDef ='D'
and Team     = '#Und#'
</cfquery>




<cfquery datasource="NBA" name="GetFavStatPreds">
Select 
	AVG(fav.vShortSucPct)   as VShortSuc,
	AVG(fav.ShortSucPct)    as ShortSuc,
	AVG(fav.MidSucPct)      as MidSuc,
	AVG(fav.MidLongSucPct)  as MidLongSuc,
	AVG(fav.LongSucPct)     as LongSuc,
	AVG(fav.gsFTMakePct)    as FTSuc
from PbPAvgPctsHA Fav
where fav.OffDef ='D'
and fav.Team     = '#fav#'
</cfquery>


<cfquery datasource="NBA" name="GetUndStatPreds">
Select 
	AVG(und.vShortSucPct)   as VShortSuc,
	AVG(und.ShortSucPct)    as ShortSuc,
	AVG(und.MidSucPct)      as MidSuc,
	AVG(und.MidLongSucPct)  as MidLongSuc,
	AVG(und.LongSucPct)     as LongSuc,
	AVG(und.gsFTMakePct)    as FTSuc
from PbPAvgPctsHA Und
where und.OffDef ='D'
and und.Team     = '#und#'
</cfquery>

<cfset FavTotPosForSim = GetFavPoss.TotPoss / GetFavTotGames.recordcount>
<cfset UndTotPosForSim = GetUndPoss.TotPoss / GetUndTotGames.recordcount>

<cfset FavVShortPts   = 2 * (GetFavStatPreds.VShortSuc * FavTotPosForSim)>
<cfset FavShortPts    = 2 * (GetFavStatPreds.ShortSuc * FavTotPosForSim)>
<cfset FavMidPts      = 2 * (GetFavStatPreds.MidSuc * FavTotPosForSim)>
<cfset FavMidLongPts  = 2 * (GetFavStatPreds.MidLongSuc * FavTotPosForSim)>
<cfset FavLongPts     = 3 * (GetFavStatPreds.LongSuc * FavTotPosForSim)>
<cfset FavFT          = 1 * (GetFavStatPreds.FTSuc * FavTotPosForSim)>

<cfset UndVShortPts   = 2 * (GetUndStatPreds.VShortSuc * UndTotPosForSim)>
<cfset UndShortPts    = 2 * (GetUndStatPreds.ShortSuc * UndTotPosForSim)>
<cfset UndMidPts      = 2 * (GetUndStatPreds.MidSuc * UndTotPosForSim)>
<cfset UndMidLongPts  = 2 * (GetUndStatPreds.MidLongSuc * UndTotPosForSim)>
<cfset UndLongPts     = 3 * (GetUndStatPreds.LongSuc * UndTotPosForSim)>
<cfset UndFT          = 1 * (GetUndStatPreds.FTSuc * UndTotPosForSim)>

<cfset FavFinalPts2 = FavVShortPts + FavShortPts + FavMidPts + FavMidLongPts + FavLongPts + FavFT>
<cfset UndFinalPts2 = UndVShortPts + UndShortPts + UndMidPts + UndMidLongPts + UndLongPts + UndFT>





<cfoutput>
<table width="50%" Border="1" cellpadding="4" cellspacing="4">
<tr>
<td>Team</td>
<td>Very Short Points</td>
<td>Short Points</td>
<td>Mid Points</td>
<td>Mid Long Points</td>
<td>Long Points</td>
<td>Total Expected Points</td>

</tr>

<tr>
<td>#Fav#</td>
<td>#FavVShortPts#</td>
<td>#FavShortPts#</td>
<td>#FavMidPts#</td>
<td>#FavMidLongPts#</td>
<td>#FavLongPts#</td>
<td>#FavFinalPts2#</td>
</tr>

<tr>
<td>#Und#</td>
<td>#UndVShortPts#</td>
<td>#UndShortPts#</td>
<td>#UndMidPts#</td>
<td>#UndMidLongPts#</td>
<td>#UndLongPts#</td>
<td>#UndFinalPts2#</td>
</tr>

</table>


**********************************************<br>
PREDICTION:<br>
#FAV# #FavFinalPts2#<br>
#UND# #UndFinalPts2#<br>
Spread: #FavFinalPts2 - UndFinalPts2#<br>
Total: #FavFinalPts2 + UndFinalPts2#
**********************************************<br>


<cfset FavCombined = (FavFinalPts + UndFinalPts2)/2>
<cfset UndCombined = (UndFinalPts + FavFinalPts2)/2>


<cfif 1 is 1>
<cfif ha is 'H'>
	<cfset FavCombined = FavCombined + (2.3/2)>
	<cfset UndCombined = UndCombined - (2.3/2)>
<cfelse>
	<cfset FavCombined = FavCombined - (2.3/2)>
	<cfset UndCombined = UndCombined + (2.3/2)>
</cfif>
</cfif>

**************************************************************<br>
<p>
#FAV# #favcombined#<br>
#Und# #undcombined#<br>
Spread: #favcombined - UndCombined#
Total: #favcombined + UndCombined#
</cfoutput>
**************************************************************<br>
<p>


</cfloop>







 
