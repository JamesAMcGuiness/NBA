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


<cfquery datasource="nba" name="ftapctsfav">
Select Avg(ofta) as avoftapct, Avg(dfta) as avdftapct
from nbadata
where team in ('#GetGames.fav#')
</cfquery>

<cfquery datasource="nba" name="ftapctsund">
Select Avg(ofta) as avoftapct, Avg(dfta) as avdftapct
from nbadata
where team in ('#GetGames.und#')
</cfquery>

<cfset FavOftapct = ftapctsfav.avoftapct>
<cfset UndOftapct = ftapctsund.avoftapct>

<cfset Favdftapct = ftapctsfav.avdftapct>
<cfset Unddftapct = ftapctsund.avdftapct>


<cfset FavPredftapct = (FavOftapct + Unddftapct)/2>
<cfset UndPredftapct = (Favdftapct + UndOftapct)/2>  


<cfquery datasource="nba" name="addit">
Select (f.fta03 + u.negfta03 )/2 as pfta03,
       (f.fta46 + u.negfta46 )/2 as pfta46,
	   (f.fta79 + u.negfta79 )/2 as pfta79,
	   (f.fta1012 + u.negfta1012)/2 as pfta1012,
	   (f.fta1315 + u.negfta1315 )/2 as pfta1315,
	   (f.fta16plus + u.negfta16Plus )/2 as pfta16plus,
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
<td width="10%">Avg ftapct</td>
<td width="10%">fta 0-3</td>
<td width="10%">fta 4-6</td>
<td width="10%">fta 7-9</td>
<td width="10%">fta 10-12</td>
<td width="10%">fta 13-15</td>
<td width="10%">fta 16+</td>
<td width="10%">Total</td>
</tr>

<cfoutput query="Addit">
<cfset favtot = pfta03 + pfta46 + pfta79 + pfta1012 + pfta1315 + pfta16plus>
<cfset FavOffUse = FavTot>


<tr>
<td>#Team#</td>
<td>#FavOftapct#</td>
<td>#pfta03#</td>
<td>#pfta46#</td>
<td>#pfta79#</td>
<td>#pfta1012#</td>
<td>#pfta1315#</td>
<td>#pfta16plus#</td>
<td>#favtot#</td>
</tr>
</cfoutput>

<cfset FavOffTot = favtot>

<cfquery datasource="nba" name="addit22">
Select (u.fta03 + f.negfta03 )/2 as upfta03,
       (u.fta46 + f.negfta46 )/2 as upfta46,
	   (u.fta79 + f.negfta79 )/2 as upfta79,
	   (u.fta1012 + f.negfta1012 )/2 as upfta1012,
	   (u.fta1315 + f.negfta1315 )/2 as upfta1315,
	   (u.fta16plus + f.negfta16Plus )/2 as upfta16plus,
	   u.team
	   
from Bigwinstatsoff u, BigwinstatsDef f
Where f.Team = '#fav#'
and   f.ha = '#favha#'
and u.Team = '#und#'
and u.ha = '#undha#'


</cfquery>

<cfoutput query="Addit22">
<cfset undtot = upfta03 + upfta46 + upfta79 + upfta1012 + upfta1315 + upfta16plus>
<cfset UndOffTot = undtot>
<cfset UndOffUse = UndOffTot>

<tr>
<td>#Team#</td>
<td>#UndOftapct#</td>
<td>#upfta03#</td>
<td>#upfta46#</td>
<td>#upfta79#</td>
<td>#upfta1012#</td>
<td>#upfta1315#</td>
<td>#upfta16plus#</td>
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

<cfquery datasource="nba" name="ftapctsfav">
Select Avg(ofta) as avoftapct, Avg(dfta) as avdftapct
from nbadata
where team in ('#GetGames.fav#')
</cfquery>

<cfquery datasource="nba" name="ftapctsund">
Select Avg(ofta) as avoftapct, Avg(dfta) as avdftapct
from nbadata
where team in ('#GetGames.und#')
</cfquery>

<cfset Favdftapct = ftapctsfav.avdftapct>
<cfset Unddftapct = ftapctsund.avdftapct>


<cfset FavPredftapct = (FavOftapct + Unddftapct)/2>
<cfset UndPredftapct = (Favdftapct + UndOftapct)/2>  


<cfquery datasource="nba" name="addit">
Select (f.fta03 + u.negfta03 )/2 as pfta03,
       (f.fta46 + u.negfta46 )/2 as pfta46,
	   (f.fta79 + u.negfta79 )/2 as pfta79,
	   (f.fta1012 + u.negfta1012)/2 as pfta1012,
	   (f.fta1315 + u.negfta1315 )/2 as pfta1315,
	   (f.fta16plus + u.negfta16Plus )/2 as pfta16plus,
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
<td width="10%">Avg ftapct</td>
<td width="10%">fta 0-3</td>
<td width="10%">fta 4-6</td>
<td width="10%">fta 7-9</td>
<td width="10%">fta 10-12</td>
<td width="10%">fta 13-15</td>
<td width="10%">fta 16+</td>
<td width="10%">Total</td>
</tr>

<cfoutput query="Addit">
<cfset favtot = pfta03 + pfta46 + pfta79 + pfta1012 + pfta1315 + pfta16plus>
<cfset FavDefTot = favtot>

<tr>
<td>#Fav#</td>
<td>#Favdftapct#</td>
<td>#pfta03#</td>
<td>#pfta46#</td>
<td>#pfta79#</td>
<td>#pfta1012#</td>
<td>#pfta1315#</td>
<td>#pfta16plus#</td>
<td>#favtot#</td>
</tr>
</cfoutput>

<cfquery datasource="nba" name="addit22">
Select (u.fta03 + f.negfta03 )/2 as upfta03,
       (u.fta46 + f.negfta46 )/2 as upfta46,
	   (u.fta79 + f.negfta79 )/2 as upfta79,
	   (u.fta1012 + f.negfta1012 )/2 as upfta1012,
	   (u.fta1315 + f.negfta1315 )/2 as upfta1315,
	   (u.fta16plus + f.negfta16Plus )/2 as upfta16plus,
	   u.team
	   
from BigwinstatsDef u, BigwinstatsOff f
Where f.Team = '#fav#'
and   f.ha = '#favha#'
and u.Team = '#und#'
and u.ha = '#undha#'


</cfquery>

<cfoutput query="Addit22">
<cfset undtot = upfta03 + upfta46 + upfta79 + upfta1012 + upfta1315 + upfta16plus>
<cfset UndDefTot = undtot>

<tr>
<td>#Und#</td>
<td>#Unddftapct#</td>
<td>#upfta03#</td>
<td>#upfta46#</td>
<td>#upfta79#</td>
<td>#upfta1012#</td>
<td>#upfta1315#</td>
<td>#upfta16plus#</td>
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
<td>Predicted ftaPct</td>
<td>Predict Higher</td>
<td>Predict Lower</td>
<td>Predict Pct</td>
</tr>

<tr>
<td>#Fav#</td>
<td>#FavPredftaPct#</td>
<td>#FavHigher#</td>
<td>#FavLower#</td>
<td>#FinalFavPct#</td>
</tr>

<tr>
<td>#Und#</td>
<td>#UndPredftaPct#</td>
<td>#UndHigher#</td>
<td>#UndLower#</td>
<td>#FinalUndPct#</td>
</tr>
</table>
<p>

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

<!-- If Fav has better then 50% of scoring higher in ftapct and opp is higher then 50% in allowing more ftapct -->



<p>



<!--- 
<cfif favtot ge 60>
	Update FinalPicks
	Set BigWinPick = '#fav#',
	BigWinRat      = #favtot - Undtot#
	BigWinRatio    = #(pfta79 + pfta1012 + pfta1315 + pfta16plus)/favtot)*100#
	Where gametime = '#mygametime#'
	and fav = '#fav' 
</cfif>


<cfif undtot ge 60>
	Update FinalPicks
	Set BigWinPick = '#*und#',
	BigWinRat      = #Undtot - favtot#
	BigWinRatio    = #(ufta79 + ufta1012 + ufta1315 + ufta16plus)/undtot)*100#
	Where gametime = '#mygametime#'
	and fav = '#fav' 
</cfif> --->

</cfloop>

 	   	   
</body>
</html>
