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


<cfquery datasource="nba" name="tpmpctsfav">
Select Avg(otpm) as avotpmpct, Avg(dtpm) as avdtpmpct
from nbadata
where team in ('#GetGames.fav#')
</cfquery>

<cfquery datasource="nba" name="tpmpctsund">
Select Avg(otpm) as avotpmpct, Avg(dtpm) as avdtpmpct
from nbadata
where team in ('#GetGames.und#')
</cfquery>

<cfset FavOtpmpct = tpmpctsfav.avotpmpct>
<cfset UndOtpmpct = tpmpctsund.avotpmpct>

<cfset Favdtpmpct = tpmpctsfav.avdtpmpct>
<cfset Unddtpmpct = tpmpctsund.avdtpmpct>


<cfset FavPredtpmpct = (FavOtpmpct + Unddtpmpct)/2>
<cfset UndPredtpmpct = (Favdtpmpct + UndOtpmpct)/2>  


<cfquery datasource="nba" name="addit">
Select (f.tpm03 + u.negtpm03 )/2 as ptpm03,
       (f.tpm46 + u.negtpm46 )/2 as ptpm46,
	   (f.tpm79 + u.negtpm79 )/2 as ptpm79,
	   (f.tpm1012 + u.negtpm1012)/2 as ptpm1012,
	   (f.tpm1315 + u.negtpm1315 )/2 as ptpm1315,
	   (f.tpm16plus + u.negtpm16Plus )/2 as ptpm16plus,
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
<td width="10%">Avg tpmpct</td>
<td width="10%">tpm 0-3</td>
<td width="10%">tpm 4-6</td>
<td width="10%">tpm 7-9</td>
<td width="10%">tpm 10-12</td>
<td width="10%">tpm 13-15</td>
<td width="10%">tpm 16+</td>
<td width="10%">Total</td>
</tr>

<cfoutput query="Addit">
<cfset favtot = ptpm03 + ptpm46 + ptpm79 + ptpm1012 + ptpm1315 + ptpm16plus>
<cfset FavOffUse = FavTot>


<tr>
<td>#Team#</td>
<td>#FavOtpmpct#</td>
<td>#ptpm03#</td>
<td>#ptpm46#</td>
<td>#ptpm79#</td>
<td>#ptpm1012#</td>
<td>#ptpm1315#</td>
<td>#ptpm16plus#</td>
<td>#favtot#</td>
</tr>
</cfoutput>

<cfset FavOffTot = favtot>

<cfquery datasource="nba" name="addit22">
Select (u.tpm03 + f.negtpm03 )/2 as uptpm03,
       (u.tpm46 + f.negtpm46 )/2 as uptpm46,
	   (u.tpm79 + f.negtpm79 )/2 as uptpm79,
	   (u.tpm1012 + f.negtpm1012 )/2 as uptpm1012,
	   (u.tpm1315 + f.negtpm1315 )/2 as uptpm1315,
	   (u.tpm16plus + f.negtpm16Plus )/2 as uptpm16plus,
	   u.team
	   
from Bigwinstatsoff u, BigwinstatsDef f
Where f.Team = '#fav#'
and   f.ha = '#favha#'
and u.Team = '#und#'
and u.ha = '#undha#'


</cfquery>

<cfoutput query="Addit22">
<cfset undtot = uptpm03 + uptpm46 + uptpm79 + uptpm1012 + uptpm1315 + uptpm16plus>
<cfset UndOffTot = undtot>
<cfset UndOffUse = UndOffTot>

<tr>
<td>#Team#</td>
<td>#UndOtpmpct#</td>
<td>#uptpm03#</td>
<td>#uptpm46#</td>
<td>#uptpm79#</td>
<td>#uptpm1012#</td>
<td>#uptpm1315#</td>
<td>#uptpm16plus#</td>
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

<cfquery datasource="nba" name="tpmpctsfav">
Select Avg(otpm) as avotpmpct, Avg(dtpm) as avdtpmpct
from nbadata
where team in ('#GetGames.fav#')
</cfquery>

<cfquery datasource="nba" name="tpmpctsund">
Select Avg(otpm) as avotpmpct, Avg(dtpm) as avdtpmpct
from nbadata
where team in ('#GetGames.und#')
</cfquery>

<cfset Favdtpmpct = tpmpctsfav.avdtpmpct>
<cfset Unddtpmpct = tpmpctsund.avdtpmpct>


<cfset FavPredtpmpct = (FavOtpmpct + Unddtpmpct)/2>
<cfset UndPredtpmpct = (Favdtpmpct + UndOtpmpct)/2>  


<cfquery datasource="nba" name="addit">
Select (f.tpm03 + u.negtpm03 )/2 as ptpm03,
       (f.tpm46 + u.negtpm46 )/2 as ptpm46,
	   (f.tpm79 + u.negtpm79 )/2 as ptpm79,
	   (f.tpm1012 + u.negtpm1012)/2 as ptpm1012,
	   (f.tpm1315 + u.negtpm1315 )/2 as ptpm1315,
	   (f.tpm16plus + u.negtpm16Plus )/2 as ptpm16plus,
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
<td width="10%">Avg tpmpct</td>
<td width="10%">tpm 0-3</td>
<td width="10%">tpm 4-6</td>
<td width="10%">tpm 7-9</td>
<td width="10%">tpm 10-12</td>
<td width="10%">tpm 13-15</td>
<td width="10%">tpm 16+</td>
<td width="10%">Total</td>
</tr>

<cfoutput query="Addit">
<cfset favtot = ptpm03 + ptpm46 + ptpm79 + ptpm1012 + ptpm1315 + ptpm16plus>
<cfset FavDefTot = favtot>

<tr>
<td>#Fav#</td>
<td>#Favdtpmpct#</td>
<td>#ptpm03#</td>
<td>#ptpm46#</td>
<td>#ptpm79#</td>
<td>#ptpm1012#</td>
<td>#ptpm1315#</td>
<td>#ptpm16plus#</td>
<td>#favtot#</td>
</tr>
</cfoutput>

<cfquery datasource="nba" name="addit22">
Select (u.tpm03 + f.negtpm03 )/2 as uptpm03,
       (u.tpm46 + f.negtpm46 )/2 as uptpm46,
	   (u.tpm79 + f.negtpm79 )/2 as uptpm79,
	   (u.tpm1012 + f.negtpm1012 )/2 as uptpm1012,
	   (u.tpm1315 + f.negtpm1315 )/2 as uptpm1315,
	   (u.tpm16plus + f.negtpm16Plus )/2 as uptpm16plus,
	   u.team
	   
from BigwinstatsDef u, BigwinstatsOff f
Where f.Team = '#fav#'
and   f.ha = '#favha#'
and u.Team = '#und#'
and u.ha = '#undha#'


</cfquery>

<cfoutput query="Addit22">
<cfset undtot = uptpm03 + uptpm46 + uptpm79 + uptpm1012 + uptpm1315 + uptpm16plus>
<cfset UndDefTot = undtot>

<tr>
<td>#Und#</td>
<td>#Unddtpmpct#</td>
<td>#uptpm03#</td>
<td>#uptpm46#</td>
<td>#uptpm79#</td>
<td>#uptpm1012#</td>
<td>#uptpm1315#</td>
<td>#uptpm16plus#</td>
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
<td>Predicted tpmPct</td>
<td>Predict Higher</td>
<td>Predict Lower</td>
<td>Predict Pct</td>
</tr>

<tr>
<td>#Fav#</td>
<td>#FavPredtpmPct#</td>
<td>#FavHigher#</td>
<td>#FavLower#</td>
<td>#FinalFavPct#</td>
</tr>

<tr>
<td>#Und#</td>
<td>#UndPredtpmPct#</td>
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

Set fTPM = #FinalFavPct#,
uTPM = #FinalUndPct#
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

<!-- If Fav has better then 50% of scoring higher in tpmpct and opp is higher then 50% in allowing more tpmpct -->



<p>



<!--- 
<cfif favtot ge 60>
	Update FinalPicks
	Set BigWinPick = '#fav#',
	BigWinRat      = #favtot - Undtot#
	BigWinRatio    = #(ptpm79 + ptpm1012 + ptpm1315 + ptpm16plus)/favtot)*100#
	Where gametime = '#mygametime#'
	and fav = '#fav' 
</cfif>


<cfif undtot ge 60>
	Update FinalPicks
	Set BigWinPick = '#*und#',
	BigWinRat      = #Undtot - favtot#
	BigWinRatio    = #(utpm79 + utpm1012 + utpm1315 + utpm16plus)/undtot)*100#
	Where gametime = '#mygametime#'
	and fav = '#fav' 
</cfif> --->

</cfloop>

 	   	   
</body>
</html>
