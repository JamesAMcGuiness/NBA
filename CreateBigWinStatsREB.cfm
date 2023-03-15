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


<cfquery datasource="nba" name="rbpctsfav">
Select Avg(otreb) as avorbpct, Avg(dtreb) as avdrbpct
from nbadata
where team in ('#GetGames.fav#')
</cfquery>

<cfquery datasource="nba" name="rbpctsund">
Select Avg(otreb) as avorbpct, Avg(dtreb) as avdrbpct
from nbadata
where team in ('#GetGames.und#')
</cfquery>

<cfset FavOrbpct = rbpctsfav.avorbpct>
<cfset UndOrbpct = rbpctsund.avorbpct>

<cfset Favdrbpct = rbpctsfav.avdrbpct>
<cfset Unddrbpct = rbpctsund.avdrbpct>


<cfset FavPredrbpct = (FavOrbpct + Unddrbpct)/2>
<cfset UndPredrbpct = (Favdrbpct + UndOrbpct)/2>  


<cfquery datasource="nba" name="addit">
Select (f.rb03 + u.negrb03 )/2 as prb03,
       (f.rb46 + u.negrb46 )/2 as prb46,
	   (f.rb79 + u.negrb79 )/2 as prb79,
	   (f.rb1012 + u.negrb1012)/2 as prb1012,
	   (f.rb1315 + u.negrb1315 )/2 as prb1315,
	   (f.rb16plus + u.negrb16Plus )/2 as prb16plus,
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
<td width="10%">Avg rbpct</td>
<td width="10%">rb 0-3</td>
<td width="10%">rb 4-6</td>
<td width="10%">rb 7-9</td>
<td width="10%">rb 10-12</td>
<td width="10%">rb 13-15</td>
<td width="10%">rb 16+</td>
<td width="10%">Total</td>
</tr>

<cfoutput query="Addit">
<cfset favtot = prb03 + prb46 + prb79 + prb1012 + prb1315 + prb16plus>
<cfset FavOffUse = FavTot>


<tr>
<td>#Team#</td>
<td>#FavOrbpct#</td>
<td>#prb03#</td>
<td>#prb46#</td>
<td>#prb79#</td>
<td>#prb1012#</td>
<td>#prb1315#</td>
<td>#prb16plus#</td>
<td>#favtot#</td>
</tr>
</cfoutput>

<cfset FavOffTot = favtot>

<cfquery datasource="nba" name="addit22">
Select (u.rb03 + f.negrb03 )/2 as uprb03,
       (u.rb46 + f.negrb46 )/2 as uprb46,
	   (u.rb79 + f.negrb79 )/2 as uprb79,
	   (u.rb1012 + f.negrb1012 )/2 as uprb1012,
	   (u.rb1315 + f.negrb1315 )/2 as uprb1315,
	   (u.rb16plus + f.negrb16Plus )/2 as uprb16plus,
	   u.team
	   
from Bigwinstatsoff u, BigwinstatsDef f
Where f.Team = '#fav#'
and   f.ha = '#favha#'
and u.Team = '#und#'
and u.ha = '#undha#'


</cfquery>

<cfoutput query="Addit22">
<cfset undtot = uprb03 + uprb46 + uprb79 + uprb1012 + uprb1315 + uprb16plus>
<cfset UndOffTot = undtot>
<cfset UndOffUse = UndOffTot>

<tr>
<td>#Team#</td>
<td>#UndOrbpct#</td>
<td>#uprb03#</td>
<td>#uprb46#</td>
<td>#uprb79#</td>
<td>#uprb1012#</td>
<td>#uprb1315#</td>
<td>#uprb16plus#</td>
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

<cfquery datasource="nba" name="rbpctsfav">
Select Avg(otreb) as avorbpct, Avg(dtreb) as avdrbpct
from nbadata
where team in ('#GetGames.fav#')
</cfquery>

<cfquery datasource="nba" name="rbpctsund">
Select Avg(otreb) as avorbpct, Avg(dtreb) as avdrbpct
from nbadata
where team in ('#GetGames.und#')
</cfquery>

<cfset Favdrbpct = rbpctsfav.avdrbpct>
<cfset Unddrbpct = rbpctsund.avdrbpct>


<cfset FavPredrbpct = (FavOrbpct + Unddrbpct)/2>
<cfset UndPredrbpct = (Favdrbpct + UndOrbpct)/2>  


<cfquery datasource="nba" name="addit">
Select (f.rb03 + u.negrb03 )/2 as prb03,
       (f.rb46 + u.negrb46 )/2 as prb46,
	   (f.rb79 + u.negrb79 )/2 as prb79,
	   (f.rb1012 + u.negrb1012)/2 as prb1012,
	   (f.rb1315 + u.negrb1315 )/2 as prb1315,
	   (f.rb16plus + u.negrb16Plus )/2 as prb16plus,
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
<td width="10%">Avg rbpct</td>
<td width="10%">rb 0-3</td>
<td width="10%">rb 4-6</td>
<td width="10%">rb 7-9</td>
<td width="10%">rb 10-12</td>
<td width="10%">rb 13-15</td>
<td width="10%">rb 16+</td>
<td width="10%">Total</td>
</tr>

<cfoutput query="Addit">
<cfset favtot = prb03 + prb46 + prb79 + prb1012 + prb1315 + prb16plus>
<cfset FavDefTot = favtot>

<tr>
<td>#Fav#</td>
<td>#Favdrbpct#</td>
<td>#prb03#</td>
<td>#prb46#</td>
<td>#prb79#</td>
<td>#prb1012#</td>
<td>#prb1315#</td>
<td>#prb16plus#</td>
<td>#favtot#</td>
</tr>
</cfoutput>

<cfquery datasource="nba" name="addit22">
Select (u.rb03 + f.negrb03 )/2 as uprb03,
       (u.rb46 + f.negrb46 )/2 as uprb46,
	   (u.rb79 + f.negrb79 )/2 as uprb79,
	   (u.rb1012 + f.negrb1012 )/2 as uprb1012,
	   (u.rb1315 + f.negrb1315 )/2 as uprb1315,
	   (u.rb16plus + f.negrb16Plus )/2 as uprb16plus,
	   u.team
	   
from BigwinstatsDef u, BigwinstatsOff f
Where f.Team = '#fav#'
and   f.ha = '#favha#'
and u.Team = '#und#'
and u.ha = '#undha#'


</cfquery>

<cfoutput query="Addit22">
<cfset undtot = uprb03 + uprb46 + uprb79 + uprb1012 + uprb1315 + uprb16plus>
<cfset UndDefTot = undtot>

<tr>
<td>#Und#</td>
<td>#Unddrbpct#</td>
<td>#uprb03#</td>
<td>#uprb46#</td>
<td>#uprb79#</td>
<td>#uprb1012#</td>
<td>#uprb1315#</td>
<td>#uprb16plus#</td>
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
<td>Predicted rbPct</td>
<td>Predict Higher</td>
<td>Predict Lower</td>
<td>Predict Pct</td>
</tr>

<tr>
<td>#Fav#</td>
<td>#FavPredrbPct#</td>
<td>#FavHigher#</td>
<td>#FavLower#</td>
<td>#FinalFavPct#</td>
</tr>

<tr>
<td>#Und#</td>
<td>#UndPredrbPct#</td>
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

Set fREB = #FinalFavPct#,
uREB = #FinalUndPct#
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

<!-- If Fav has better then 50% of scoring higher in rbpct and opp is higher then 50% in allowing more rbpct -->



<p>



<!--- 
<cfif favtot ge 60>
	Update FinalPicks
	Set BigWinPick = '#fav#',
	BigWinRat      = #favtot - Undtot#
	BigWinRatio    = #(prb79 + prb1012 + prb1315 + prb16plus)/favtot)*100#
	Where gametime = '#mygametime#'
	and fav = '#fav' 
</cfif>


<cfif undtot ge 60>
	Update FinalPicks
	Set BigWinPick = '#*und#',
	BigWinRat      = #Undtot - favtot#
	BigWinRatio    = #(urb79 + urb1012 + urb1315 + urb16plus)/undtot)*100#
	Where gametime = '#mygametime#'
	and fav = '#fav' 
</cfif> --->

</cfloop>


 	   	   
</body>
</html>
