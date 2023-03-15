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


<cfquery datasource="nba" name="fgapctsfav">
Select Avg(ofga) as avofgapct, Avg(dfga) as avdfgapct
from nbadata
where team in ('#GetGames.fav#')
</cfquery>

<cfquery datasource="nba" name="fgapctsund">
Select Avg(ofga) as avofgapct, Avg(dfga) as avdfgapct
from nbadata
where team in ('#GetGames.und#')
</cfquery>

<cfset FavOfgapct = fgapctsfav.avofgapct>
<cfset UndOfgapct = fgapctsund.avofgapct>

<cfset Favdfgapct = fgapctsfav.avdfgapct>
<cfset Unddfgapct = fgapctsund.avdfgapct>


<cfset FavPredfgapct = (FavOfgapct + Unddfgapct)/2>
<cfset UndPredfgapct = (Favdfgapct + UndOfgapct)/2>  


<cfquery datasource="nba" name="addit">
Select (f.fga03 + u.negfga03 )/2 as pfga03,
       (f.fga46 + u.negfga46 )/2 as pfga46,
	   (f.fga79 + u.negfga79 )/2 as pfga79,
	   (f.fga1012 + u.negfga1012)/2 as pfga1012,
	   (f.fga1315 + u.negfga1315 )/2 as pfga1315,
	   (f.fga16plus + u.negfga16Plus )/2 as pfga16plus,
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
<td width="10%">Avg fgapct</td>
<td width="10%">fga 0-3</td>
<td width="10%">fga 4-6</td>
<td width="10%">fga 7-9</td>
<td width="10%">fga 10-12</td>
<td width="10%">fga 13-15</td>
<td width="10%">fga 16+</td>
<td width="10%">Total</td>
</tr>

<cfoutput query="Addit">
<cfset favtot = pfga03 + pfga46 + pfga79 + pfga1012 + pfga1315 + pfga16plus>
<cfset FavOffUse = FavTot>


<tr>
<td>#Team#</td>
<td>#FavOfgapct#</td>
<td>#pfga03#</td>
<td>#pfga46#</td>
<td>#pfga79#</td>
<td>#pfga1012#</td>
<td>#pfga1315#</td>
<td>#pfga16plus#</td>
<td>#favtot#</td>
</tr>
</cfoutput>

<cfset FavOffTot = favtot>

<cfquery datasource="nba" name="addit22">
Select (u.fga03 + f.negfga03 )/2 as upfga03,
       (u.fga46 + f.negfga46 )/2 as upfga46,
	   (u.fga79 + f.negfga79 )/2 as upfga79,
	   (u.fga1012 + f.negfga1012 )/2 as upfga1012,
	   (u.fga1315 + f.negfga1315 )/2 as upfga1315,
	   (u.fga16plus + f.negfga16Plus )/2 as upfga16plus,
	   u.team
	   
from Bigwinstatsoff u, BigwinstatsDef f
Where f.Team = '#fav#'
and   f.ha = '#favha#'
and u.Team = '#und#'
and u.ha = '#undha#'


</cfquery>

<cfoutput query="Addit22">
<cfset undtot = upfga03 + upfga46 + upfga79 + upfga1012 + upfga1315 + upfga16plus>
<cfset UndOffTot = undtot>
<cfset UndOffUse = UndOffTot>

<tr>
<td>#Team#</td>
<td>#UndOfgapct#</td>
<td>#upfga03#</td>
<td>#upfga46#</td>
<td>#upfga79#</td>
<td>#upfga1012#</td>
<td>#upfga1315#</td>
<td>#upfga16plus#</td>
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

<cfquery datasource="nba" name="fgapctsfav">
Select Avg(ofga) as avofgapct, Avg(dfga) as avdfgapct
from nbadata
where team in ('#GetGames.fav#')
</cfquery>

<cfquery datasource="nba" name="fgapctsund">
Select Avg(ofga) as avofgapct, Avg(dfga) as avdfgapct
from nbadata
where team in ('#GetGames.und#')
</cfquery>

<cfset Favdfgapct = fgapctsfav.avdfgapct>
<cfset Unddfgapct = fgapctsund.avdfgapct>


<cfset FavPredfgapct = (FavOfgapct + Unddfgapct)/2>
<cfset UndPredfgapct = (Favdfgapct + UndOfgapct)/2>  


<cfquery datasource="nba" name="addit">
Select (f.fga03 + u.negfga03 )/2 as pfga03,
       (f.fga46 + u.negfga46 )/2 as pfga46,
	   (f.fga79 + u.negfga79 )/2 as pfga79,
	   (f.fga1012 + u.negfga1012)/2 as pfga1012,
	   (f.fga1315 + u.negfga1315 )/2 as pfga1315,
	   (f.fga16plus + u.negfga16Plus )/2 as pfga16plus,
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
<td width="10%">Avg fgapct</td>
<td width="10%">fga 0-3</td>
<td width="10%">fga 4-6</td>
<td width="10%">fga 7-9</td>
<td width="10%">fga 10-12</td>
<td width="10%">fga 13-15</td>
<td width="10%">fga 16+</td>
<td width="10%">Total</td>
</tr>

<cfoutput query="Addit">
<cfset favtot = pfga03 + pfga46 + pfga79 + pfga1012 + pfga1315 + pfga16plus>
<cfset FavDefTot = favtot>

<tr>
<td>#Fav#</td>
<td>#Favdfgapct#</td>
<td>#pfga03#</td>
<td>#pfga46#</td>
<td>#pfga79#</td>
<td>#pfga1012#</td>
<td>#pfga1315#</td>
<td>#pfga16plus#</td>
<td>#favtot#</td>
</tr>
</cfoutput>

<cfquery datasource="nba" name="addit22">
Select (u.fga03 + f.negfga03 )/2 as upfga03,
       (u.fga46 + f.negfga46 )/2 as upfga46,
	   (u.fga79 + f.negfga79 )/2 as upfga79,
	   (u.fga1012 + f.negfga1012 )/2 as upfga1012,
	   (u.fga1315 + f.negfga1315 )/2 as upfga1315,
	   (u.fga16plus + f.negfga16Plus )/2 as upfga16plus,
	   u.team
	   
from BigwinstatsDef u, BigwinstatsOff f
Where f.Team = '#fav#'
and   f.ha = '#favha#'
and u.Team = '#und#'
and u.ha = '#undha#'


</cfquery>

<cfoutput query="Addit22">
<cfset undtot = upfga03 + upfga46 + upfga79 + upfga1012 + upfga1315 + upfga16plus>
<cfset UndDefTot = undtot>

<tr>
<td>#Und#</td>
<td>#Unddfgapct#</td>
<td>#upfga03#</td>
<td>#upfga46#</td>
<td>#upfga79#</td>
<td>#upfga1012#</td>
<td>#upfga1315#</td>
<td>#upfga16plus#</td>
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
	<cfset FinalUndPct = (FavDefTot + (100 - FavOffUse))/2>
	<cfset UndLower = true>
</cfif> 

<table border="1">
<tr>
<td>Team</td>
<td>Predicted fgaPct</td>
<td>Predict Higher</td>
<td>Predict Lower</td>
<td>Predict Pct</td>
</tr>

<tr>
<td>#Fav#</td>
<td>#FavPredfgaPct#</td>
<td>#FavHigher#</td>
<td>#FavLower#</td>
<td>#FinalFavPct#</td>
</tr>

<tr>
<td>#Und#</td>
<td>#UndPredfgaPct#</td>
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

Set fFGA = #FinalFavPct#,
uFGA = #FinalUndPct#
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

<!-- If Fav has better then 50% of scoring higher in fgapct and opp is higher then 50% in allowing more fgapct -->



<p>



<!--- 
<cfif favtot ge 60>
	Update FinalPicks
	Set BigWinPick = '#fav#',
	BigWinRat      = #favtot - Undtot#
	BigWinRatio    = #(pfga79 + pfga1012 + pfga1315 + pfga16plus)/favtot)*100#
	Where gametime = '#mygametime#'
	and fav = '#fav' 
</cfif>


<cfif undtot ge 60>
	Update FinalPicks
	Set BigWinPick = '#*und#',
	BigWinRat      = #Undtot - favtot#
	BigWinRatio    = #(ufga79 + ufga1012 + ufga1315 + ufga16plus)/undtot)*100#
	Where gametime = '#mygametime#'
	and fav = '#fav' 
</cfif> --->

</cfloop>

 	   	   
</body>
</html>
