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


<cfquery datasource="nba" name="ftmpctsfav">
Select Avg(oftm) as avoftmpct, Avg(dftm) as avdftmpct
from nbadata
where team in ('#GetGames.fav#')
</cfquery>

<cfquery datasource="nba" name="ftmpctsund">
Select Avg(oftm) as avoftmpct, Avg(dftm) as avdftmpct
from nbadata
where team in ('#GetGames.und#')
</cfquery>

<cfset FavOftmpct = ftmpctsfav.avoftmpct>
<cfset UndOftmpct = ftmpctsund.avoftmpct>

<cfset Favdftmpct = ftmpctsfav.avdftmpct>
<cfset Unddftmpct = ftmpctsund.avdftmpct>


<cfset FavPredftmpct = (FavOftmpct + Unddftmpct)/2>
<cfset UndPredftmpct = (Favdftmpct + UndOftmpct)/2>  


<cfquery datasource="nba" name="addit">
Select (f.ftm03 + u.negftm03 )/2 as pftm03,
       (f.ftm46 + u.negftm46 )/2 as pftm46,
	   (f.ftm79 + u.negftm79 )/2 as pftm79,
	   (f.ftm1012 + u.negftm1012)/2 as pftm1012,
	   (f.ftm1315 + u.negftm1315 )/2 as pftm1315,
	   (f.ftm16plus + u.negftm16Plus )/2 as pftm16plus,
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
<td width="10%">Avg ftmpct</td>
<td width="10%">ftm 0-3</td>
<td width="10%">ftm 4-6</td>
<td width="10%">ftm 7-9</td>
<td width="10%">ftm 10-12</td>
<td width="10%">ftm 13-15</td>
<td width="10%">ftm 16+</td>
<td width="10%">Total</td>
</tr>

<cfoutput query="Addit">
<cfset favtot = pftm03 + pftm46 + pftm79 + pftm1012 + pftm1315 + pftm16plus>
<cfset FavOffUse = FavTot>


<tr>
<td>#Team#</td>
<td>#FavOftmpct#</td>
<td>#pftm03#</td>
<td>#pftm46#</td>
<td>#pftm79#</td>
<td>#pftm1012#</td>
<td>#pftm1315#</td>
<td>#pftm16plus#</td>
<td>#favtot#</td>
</tr>
</cfoutput>

<cfset FavOffTot = favtot>

<cfquery datasource="nba" name="addit22">
Select (u.ftm03 + f.negftm03 )/2 as upftm03,
       (u.ftm46 + f.negftm46 )/2 as upftm46,
	   (u.ftm79 + f.negftm79 )/2 as upftm79,
	   (u.ftm1012 + f.negftm1012 )/2 as upftm1012,
	   (u.ftm1315 + f.negftm1315 )/2 as upftm1315,
	   (u.ftm16plus + f.negftm16Plus )/2 as upftm16plus,
	   u.team
	   
from Bigwinstatsoff u, BigwinstatsDef f
Where f.Team = '#fav#'
and   f.ha = '#favha#'
and u.Team = '#und#'
and u.ha = '#undha#'


</cfquery>

<cfoutput query="Addit22">
<cfset undtot = upftm03 + upftm46 + upftm79 + upftm1012 + upftm1315 + upftm16plus>
<cfset UndOffTot = undtot>
<cfset UndOffUse = UndOffTot>

<tr>
<td>#Team#</td>
<td>#UndOftmpct#</td>
<td>#upftm03#</td>
<td>#upftm46#</td>
<td>#upftm79#</td>
<td>#upftm1012#</td>
<td>#upftm1315#</td>
<td>#upftm16plus#</td>
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

<cfquery datasource="nba" name="ftmpctsfav">
Select Avg(oftm) as avoftmpct, Avg(dftm) as avdftmpct
from nbadata
where team in ('#GetGames.fav#')
</cfquery>

<cfquery datasource="nba" name="ftmpctsund">
Select Avg(oftm) as avoftmpct, Avg(dftm) as avdftmpct
from nbadata
where team in ('#GetGames.und#')
</cfquery>

<cfset Favdftmpct = ftmpctsfav.avdftmpct>
<cfset Unddftmpct = ftmpctsund.avdftmpct>


<cfset FavPredftmpct = (FavOftmpct + Unddftmpct)/2>
<cfset UndPredftmpct = (Favdftmpct + UndOftmpct)/2>  


<cfquery datasource="nba" name="addit">
Select (f.ftm03 + u.negftm03 )/2 as pftm03,
       (f.ftm46 + u.negftm46 )/2 as pftm46,
	   (f.ftm79 + u.negftm79 )/2 as pftm79,
	   (f.ftm1012 + u.negftm1012)/2 as pftm1012,
	   (f.ftm1315 + u.negftm1315 )/2 as pftm1315,
	   (f.ftm16plus + u.negftm16Plus )/2 as pftm16plus,
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
<td width="10%">Avg ftmpct</td>
<td width="10%">ftm 0-3</td>
<td width="10%">ftm 4-6</td>
<td width="10%">ftm 7-9</td>
<td width="10%">ftm 10-12</td>
<td width="10%">ftm 13-15</td>
<td width="10%">ftm 16+</td>
<td width="10%">Total</td>
</tr>

<cfoutput query="Addit">
<cfset favtot = pftm03 + pftm46 + pftm79 + pftm1012 + pftm1315 + pftm16plus>
<cfset FavDefTot = favtot>

<tr>
<td>#Fav#</td>
<td>#Favdftmpct#</td>
<td>#pftm03#</td>
<td>#pftm46#</td>
<td>#pftm79#</td>
<td>#pftm1012#</td>
<td>#pftm1315#</td>
<td>#pftm16plus#</td>
<td>#favtot#</td>
</tr>
</cfoutput>

<cfquery datasource="nba" name="addit22">
Select (u.ftm03 + f.negftm03 )/2 as upftm03,
       (u.ftm46 + f.negftm46 )/2 as upftm46,
	   (u.ftm79 + f.negftm79 )/2 as upftm79,
	   (u.ftm1012 + f.negftm1012 )/2 as upftm1012,
	   (u.ftm1315 + f.negftm1315 )/2 as upftm1315,
	   (u.ftm16plus + f.negftm16Plus )/2 as upftm16plus,
	   u.team
	   
from BigwinstatsDef u, BigwinstatsOff f
Where f.Team = '#fav#'
and   f.ha = '#favha#'
and u.Team = '#und#'
and u.ha = '#undha#'


</cfquery>

<cfoutput query="Addit22">
<cfset undtot = upftm03 + upftm46 + upftm79 + upftm1012 + upftm1315 + upftm16plus>
<cfset UndDefTot = undtot>

<tr>
<td>#Und#</td>
<td>#Unddftmpct#</td>
<td>#upftm03#</td>
<td>#upftm46#</td>
<td>#upftm79#</td>
<td>#upftm1012#</td>
<td>#upftm1315#</td>
<td>#upftm16plus#</td>
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
<td>Predicted ftmPct</td>
<td>Predict Higher</td>
<td>Predict Lower</td>
<td>Predict Pct</td>
</tr>

<tr>
<td>#Fav#</td>
<td>#FavPredftmPct#</td>
<td>#FavHigher#</td>
<td>#FavLower#</td>
<td>#FinalFavPct#</td>
</tr>

<tr>
<td>#Und#</td>
<td>#UndPredftmPct#</td>
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


<cfoutput>
<cfquery datasource="nba">
Update PreGameProb

Set fFTM = #FinalFavPct#,
uFTM = #FinalUndPct#
Where Gametime = '#mygametime#'
and fav = '#fav#'
</cfquery>
</cfoutput>


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

<!-- If Fav has better then 50% of scoring higher in ftmpct and opp is higher then 50% in allowing more ftmpct -->



<p>



<!--- 
<cfif favtot ge 60>
	Update FinalPicks
	Set BigWinPick = '#fav#',
	BigWinRat      = #favtot - Undtot#
	BigWinRatio    = #(pftm79 + pftm1012 + pftm1315 + pftm16plus)/favtot)*100#
	Where gametime = '#mygametime#'
	and fav = '#fav' 
</cfif>


<cfif undtot ge 60>
	Update FinalPicks
	Set BigWinPick = '#*und#',
	BigWinRat      = #Undtot - favtot#
	BigWinRatio    = #(uftm79 + uftm1012 + uftm1315 + uftm16plus)/undtot)*100#
	Where gametime = '#mygametime#'
	and fav = '#fav' 
</cfif> --->

</cfloop>

 	   	   
</body>
</html>
