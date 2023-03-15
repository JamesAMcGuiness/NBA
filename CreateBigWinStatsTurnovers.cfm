<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset mygametime = GetRunct.GameTime>
<!--- <cfset mygametime = "20081225"> --->

<cfquery datasource="nba" name="GetTeams">
Select Distinct team 
from gap
</cfquery>



<!-- Create Predicted ranges based on teams offense and defense -->


<cfquery name="GetGames" datasource="nba">
Select * from nbaschedule where gametime='#mygametime#'
</cfquery>

<cfloop query="Getgames">

<cfset Fav = '#fav#'>
<cfset Und = '#und#'>
<cfset favha = '#Ha#'>

<cfif favha is 'H'>
	<cfset undha = 'A'>
<cfelse>
	<cfset undha = 'H'>
</cfif>


<cfquery datasource="nba" name="turnoverspctsfav">
Select Avg(oturnovers) as avotopct, Avg(dturnovers) as avdtopct
from nbadata
where team in ('#GetGames.fav#')
</cfquery>

<cfquery datasource="nba" name="turnoverspctsund">
Select Avg(oturnovers) as avotopct, Avg(dturnovers) as avdtopct
from nbadata
where team in ('#GetGames.und#')
</cfquery>

<cfset FavOturnoverspct = turnoverspctsfav.avotopct>
<cfset UndOturnoverspct = turnoverspctsund.avotopct>

<cfset Favdturnoverspct = turnoverspctsfav.avdtopct>
<cfset Unddturnoverspct = turnoverspctsund.avdtopct>


<cfset FavPredturnoverspct = (FavOturnoverspct + Unddturnoverspct)/2>
<cfset UndPredturnoverspct = (Favdturnoverspct + UndOturnoverspct)/2>  


<cfquery datasource="nba" name="addit">
Select (f.to03 + u.negto03 )/2 as pto03,
       (f.to46 + u.negto46 )/2 as pto46,
	   (f.to79 + u.negto79 )/2 as pto79,
	   (f.to1012 + u.negto1012)/2 as pto1012,
	   (f.to1315 + u.negto1315 )/2 as pto1315,
	   (f.to16plus + u.negto16Plus )/2 as pto16plus,
	   f.team
	   
from Bigwinstatsoff f, BigwinstatsDef u
Where f.Team = '#fav#'
and   f.ha = '#favha#'
and u.Team = '#und#'
and u.ha = '#undha#'

</cfquery>

<table border='1' width="100%">
<tr>
<td width="5%">Team</td>
<td width="10%">Avg turnoverspct</td>
<td width="10%">turnovers 0-3</td>
<td width="10%">turnovers 4-6</td>
<td width="10%">turnovers 7-9</td>
<td width="10%">turnovers 10-12</td>
<td width="10%">turnovers 13-15</td>
<td width="10%">turnovers 16+</td>
<td width="10%">Total</td>
</tr>

<cfoutput query="Addit">
<cfset favtot = pto03 + pto46 + pto79 + pto1012 + pto1315 + pto16plus>
<cfset FavOffUse = FavTot>


<tr>
<td>#Team#</td>
<td>#FavPredturnoverspct#</td>
<td>#pto03#</td>
<td>#pto46#</td>
<td>#pto79#</td>
<td>#pto1012#</td>
<td>#pto1315#</td>
<td>#pto16plus#</td>
<td>#favtot#</td>
</tr>
</cfoutput>

<cfset FavOffTot = favtot>

<cfquery datasource="nba" name="addit22">
Select (u.to03 + f.negto03 )/2 as upto03,
       (u.to46 + f.negto46 )/2 as upto46,
	   (u.to79 + f.negto79 )/2 as upto79,
	   (u.to1012 + f.negto1012 )/2 as upto1012,
	   (u.to1315 + f.negto1315 )/2 as upto1315,
	   (u.to16plus + f.negto16Plus )/2 as upto16plus,
	   u.team
	   
from Bigwinstatsoff u, BigwinstatsDef f
Where f.Team = '#fav#'
and   f.ha = '#favha#'
and u.Team = '#und#'
and u.ha = '#undha#'


</cfquery>

<cfoutput query="Addit22">
<cfset undtot = upto03 + upto46 + upto79 + upto1012 + upto1315 + upto16plus>
<cfset UndOffTot = undtot>
<cfset UndOffUse = UndOffTot>

<tr>
<td>#Team#</td>
<td>#UndPredturnoverspct#</td>
<td>#upto03#</td>
<td>#upto46#</td>
<td>#upto79#</td>
<td>#upto1012#</td>
<td>#upto1315#</td>
<td>#upto16plus#</td>
<td>#undtot#</td>
</tr>
</cfoutput>
</table>

<cfset OverPlay = true>
<cfif favtot ge 60 and undtot ge 60>
	<cfset OverPlay = true>
</cfif>

<cfset UnderPlay = true>
<cfif favtot lt 50 and undtot lt 50>
	<cfset UnderPlay = true>
</cfif>



<!--- 
<cfif favtot ge 60>
	Update FinalPicks
	Set BigWinPick = '#fav#',
	BigWinRat      = #favtot - Undtot#
	BigWinRatio    = #(pFG79 + pFG1012 + pFG1315 + pFG16plus)/favtot)*100#
	Where gametime = '#mygametime#'
	and fav = '#fav' 
</cfif>


<cfif undtot ge 60>
	Update FinalPicks
	Set BigWinPick = '#*und#',
	BigWinRat      = #Undtot - favtot#
	BigWinRatio    = #(uFG79 + uFG1012 + uFG1315 + uFG16plus)/undtot)*100#
	Where gametime = '#mygametime#'
	and fav = '#fav' 
</cfif> --->


--------------------------------- Defense ------------------------------------------------------

<cfquery datasource="nba" name="turnoverspctsfav">
Select Avg(oturnovers) as avotopct, Avg(dturnovers) as avdtopct
from nbadata
where team in ('#GetGames.fav#')
</cfquery>

<cfquery datasource="nba" name="turnoverspctsund">
Select Avg(oturnovers) as avotopct, Avg(dturnovers) as avdtopct
from nbadata
where team in ('#GetGames.und#')
</cfquery>

<cfset Favdturnoverspct = turnoverspctsfav.avdtopct>
<cfset Unddturnoverspct = turnoverspctsund.avdtopct>


<cfset FavPredturnoverspct = (FavOturnoverspct + Unddturnoverspct)/2>
<cfset UndPredturnoverspct = (Favdturnoverspct + UndOturnoverspct)/2>  


<cfquery datasource="nba" name="addit">
Select (f.to03 + u.negto03 )/2 as pto03,
       (f.to46 + u.negto46 )/2 as pto46,
	   (f.to79 + u.negto79 )/2 as pto79,
	   (f.to1012 + u.negto1012)/2 as pto1012,
	   (f.to1315 + u.negto1315 )/2 as pto1315,
	   (f.to16plus + u.negto16Plus )/2 as pto16plus,
	   f.team
	   
from BigwinstatsDef f, BigwinstatsOff u
Where f.Team = '#fav#'
and   f.ha = '#favha#'
and u.Team = '#und#'
and u.ha = '#undha#'

</cfquery>
<table border="1" width="100%">
<tr>
<td width="5%">Team</td>
<td width="10%">Avg topct</td>
<td width="10%">to 0-3</td>
<td width="10%">to 4-6</td>
<td width="10%">to 7-9</td>
<td width="10%">to 10-12</td>
<td width="10%">to 13-15</td>
<td width="10%">to 16+</td>
<td width="10%">Total</td>
</tr>

<cfoutput query="Addit">
<cfset favtot = pto03 + pto46 + pto79 + pto1012 + pto1315 + pto16plus>
<cfset FavDefTot = favtot>

<tr>
<td>#Fav#</td>
<td>#Favdturnoverspct#</td>
<td>#pto03#</td>
<td>#pto46#</td>
<td>#pto79#</td>
<td>#pto1012#</td>
<td>#pto1315#</td>
<td>#pto16plus#</td>
<td>#favtot#</td>
</tr>
</cfoutput>

<cfquery datasource="nba" name="addit22">
Select (u.to03 + f.negto03 )/2 as upto03,
       (u.to46 + f.negto46 )/2 as upto46,
	   (u.to79 + f.negto79 )/2 as upto79,
	   (u.to1012 + f.negto1012 )/2 as upto1012,
	   (u.to1315 + f.negto1315 )/2 as upto1315,
	   (u.to16plus + f.negto16Plus )/2 as upto16plus,
	   u.team
	   
from BigwinstatsDef u, BigwinstatsOff f
Where f.Team = '#fav#'
and   f.ha = '#favha#'
and u.Team = '#und#'
and u.ha = '#undha#'


</cfquery>

<cfoutput query="Addit22">
<cfset undtot = upto03 + upto46 + upto79 + upto1012 + upto1315 + upto16plus>
<cfset UndDefTot = undtot>

<tr>
<td>#Und#</td>
<td>#Unddturnoverspct#</td>
<td>#upto03#</td>
<td>#upto46#</td>
<td>#upto79#</td>
<td>#upto1012#</td>
<td>#upto1315#</td>
<td>#upto16plus#</td>
<td>#undtot#</td>
</tr>
</cfoutput>

</table>
<cfoutput>

<cfset FavDefUse = FavDefTot>
<cfset UndDefUse = UndDefTot>

<cfset FavHigher = false>
<cfset FavLower = false>

<cfset UndHigher = false>
<cfset UndLower = false>

<cfset FinalFavPct = 0>
<cfset FinalUndPct = 0>

<!--- <cfoutput>
checking #FavOffUse# and #UndDefTot#<br>
</cfoutput>
 --->
<cfif FavOffUse ge 50 and (100 - UndDefTot ge 50)>
	<cfoutput>
	
	</cfoutput>
	<cfset FinalFavPct = (FavOffUse + (100 - UndDefTot))/2>
	<cfset FavHigher = true>
</cfif> 

<cfif UndOffUse ge 50 and (100 - FavDefTot ge 50)>
	<cfset FinalUndPct = (UndOffUse + (100 - FavDefTot))/2>
	<cfset UndHigher = true>
</cfif> 



<cfif FavOffUse le 50 and (UndDefTot ge 50)>
	<cfset FinalFavPct = (UndDefTot + (100 - FavOffUse))/2>
	<cfset FavLower = true>
</cfif> 

<cfif UndOffUse le 50 and (FavDefTot ge 50)>
	<cfset FinalUndPct = (FavDefTot + (100 - UndOffUse))/2>
	<cfset UndLower = true>
</cfif> 


<table border="1">
<tr>
<td>Team</td>
<td>Predicted turnoversPct</td>
<td>Predict Higher</td>
<td>Predict Lower</td>
<td>Predict Pct</td>
</tr>

<tr>
<td>#Fav#</td>
<td>#FavPredturnoversPct#</td>
<td>#FavHigher#</td>
<td>#FavLower#</td>
<td>#FinalFavPct#</td>
</tr>

<tr>
<td>#Und#</td>
<td>#UndPredturnoversPct#</td>
<td>#UndHigher#</td>
<td>#UndLower#</td>
<td>#FinalUndPct#</td>
</tr>
</table>
<p>

</cfoutput>

<cfif FavHigher is false>
	<cfset FinalFavPct = (-1*FinalFavPct)>
</cfif>

<cfif UndHigher is false>
	<cfset FinalUndPct = (-1*FinalUndPct)>
</cfif>


<cfquery datasource="nba">
Update PreGameProb

Set fTO = #FinalFavPct#,
uTO = #FinalUndPct#
Where Gametime = '#mygametime#'
and fav = '#fav#'
</cfquery>





<!--- <cfif FavOffTot lt 50>
	<cfset FavOffUse = 100 - FavOffTot>
</cfif>
	
<cfif UndOffTot lt 50>
	<cfset UndOffUse = 100 - UndOffTot>
</cfif>

<cfif FavDefTot lt 50>
	<cfset FavDefUse = 100 - FavDefTot>
</cfif>
	
<cfif UndDefTot lt 50>
	<cfset UndDefUse = 100 - UndDefTot>
</cfif> --->

<!-- If Fav has better then 50% of scoring higher in turnoverspct and opp is higher then 50% in allowing more turnoverspct -->



<p>



<!--- 
<cfif favtot ge 60>
	Update FinalPicks
	Set BigWinPick = '#fav#',
	BigWinRat      = #favtot - Undtot#
	BigWinRatio    = #(pturnovers79 + pturnovers1012 + pturnovers1315 + pturnovers16plus)/favtot)*100#
	Where gametime = '#mygametime#'
	and fav = '#fav' 
</cfif>


<cfif undtot ge 60>
	Update FinalPicks
	Set BigWinPick = '#*und#',
	BigWinRat      = #Undtot - favtot#
	BigWinRatio    = #(uturnovers79 + uturnovers1012 + uturnovers1315 + uturnovers16plus)/undtot)*100#
	Where gametime = '#mygametime#'
	and fav = '#fav' 
</cfif> --->

</cfloop>

 	   	   
</body>
</html>
