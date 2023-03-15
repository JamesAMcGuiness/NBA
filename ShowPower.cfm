<cfinclude template="createHFA.cfm">
<cfinclude template="PowerPts.cfm">
<cfinclude template="CreatePowerMinutes.cfm">


<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>
<cfset Gametime = '#GetRunCt.Gametime#'>





<cfquery datasource="nba" name="GetIt">
Select Team,AVG(PS) + AVG(DPS) as Power
from Power
where gametime < '#gametime#'
Group by Team
order by AVG(PS) + AVG(DPS) desc
</cfquery>


<cfoutput query="GetIt">
#Getit.Team#...#GetIt.Power#<br>
</cfoutput>

<p>



<cfquery datasource="nba" name="Getspds">
Select *
from nbaschedule
where GameTime = '#GameTime#'
</cfquery>

<table width="50%" border="1">
<tr>
<td>Fav</td>
<td>HA</td>
<td>Spd</td>
<td>Und</td>
<td>Pts</td>
<td>Reb</td>
<td>Inside</td>
<td>Outside</td>
<td>Turnover</td>
<td>FGPct</td>
</tr>

<cfloop query="GetSpds">

    <cfset fav           = '#GetSpds.Fav#'>
    <cfset und           = '#GetSpds.Und#'>
    <cfset ha            = '#GetSpds.ha#'>
    <cfset spd           = Getspds.spd>


<cfquery datasource="NBA" name="GetFav">
Select AVG(PS) + AVG(DPS) as Power
from Power 
where team = '#fav#'
</cfquery>

<cfquery datasource="NBA" name="GetUnd">
Select AVG(PS) + AVG(DPS) as Power
from Power 
where team = '#und#'
</cfquery>


<cfquery datasource="NBA" name="GetFavP">
Select *
from BetterThanAvg 
where team = '#fav#'
</cfquery>

<cfquery datasource="NBA" name="GetUndP">
Select *
from BetterThanAvg 
where team = '#und#'
</cfquery>


<cfset ptsdif = GetFavP.PowerPts - GetUndP.PowerPts>
<cfset rebdif = GetFavP.PowerReb - GetUndP.PowerReb>
<cfset Insidedif = GetFavP.PowerInside - GetUndP.PowerInside>
<cfset outsidedif = GetFavP.PowerOutside - GetUndP.PowerOutside>
<cfset todif = GetFavP.PowerTurnover - GetUndP.PowerTurnover>
<cfset fgdif = GetFavP.PowerFGPct - GetUndP.PowerFGPct>

<cfset favpow = #Getfav.Power#>
<cfset undpow = #GetUnd.Power#>
<cfset favpow2 = #Getfav.Power#>
<cfset undpow2 = #GetUnd.Power#>



	<cfquery datasource="NBA" name="GetHFA">
	Select (f.HFA + U.HFA)/2 as useHFA
	from NBAHomeFieldAdv f, NBAHomeFieldAdv u 
	where f.Team = '#fav#'
	and   u.Team = '#und#'
	</cfquery>

	<cfset UseHFA = GetHFA.UseHFA>


<cfif ha is 'H' >
	<cfset favpow  = favpow + 2.33>
	<cfset favpow2 = favpow + useHFA>
	
<cfelse>
	<cfset undpow = undpow + 2.33>
	<cfset undpow2 = undpow + useHFA>

</cfif>

<cfset PredMOV = FavPow - UndPow>
<cfset PredMOV2 = FavPow2 - UndPow2>



<cfquery datasource="NBA" name="GetFavPY">
Select *
from FinalPicks 
where Fav = '#fav#'
and gametime = '#gametime#'
and FavPlayedYest = 'Y'
</cfquery>

<cfquery datasource="NBA" name="GetUndPY">
Select *
from FinalPicks 
where Fav = '#fav#'
and gametime = '#gametime#'
and UndPlayedYest = 'Y'
</cfquery>

<cfset Pick = 'N/A'>
<cfset PickRat = 0>

<cfif GetFavPY.recordcount gt 0 AND GetUndPY.recordcount gt 0>

<cfelse>

	<cfif GetFavPY.recordcount gt 0>
		<cfset PredMOV = PredMOV - 2.5>
	</cfif>

	<cfif GetUndPY.recordcount gt 0>
		<cfset PredMOV = PredMOV + 2.5>
	</cfif>
</cfif>

<cfoutput>
MOV  for #Fav# is #PredMOV#....Spread is #spd# <br>
MOV2 for #Fav# is #PredMOV2#....Spread is #spd# 
</cfoutput>

<cfif PredMov - spd gt 0>
	<cfset pick = fav>
	<cfset PickRat = PredMov - spd>
</cfif>

<cfif PredMov - spd lt 0>
	<cfset pick = und>
	<cfset PickRat = PredMov + spd>
</cfif>

<cfif PredMov lt spd>
	<cfset pick = und>
	<cfset PickRat = spd - PredMov>
</cfif>




<cfif PredMov2 - spd gt 0>
	<cfset pick2 = fav>
	<cfset PickRat2 = PredMov2 - spd>
</cfif>

<cfif PredMov2 - spd lt 0>
	<cfset pick2 = und>
	<cfset PickRat2 = PredMov2 + spd>
</cfif>

<cfif PredMov2 lt spd>
	<cfset pick2 = und>
	<cfset PickRat2 = spd - PredMov2>
</cfif>





<cfquery datasource="NBA" name="GetUndPY">
	Update FinalPicks 
	SET SYS500 = ''
	where Fav = '#fav#'
	and gametime = '#gametime#'
</cfquery>

<cfquery name="GetitFav" datasource="NBA">
Delete from NBAPicks
where systemid in('SYS500WithNBAHomeFieldADV','AVGSYS500AndSYS500WithNBAHomeFieldADV','SYS500','AvgOfAllPowerRatings')
and gametime = '#gametime#'
and fav = '#fav#'
</cfquery>

<cfquery datasource="NBA" name="Add1">
	INSERT INTO NBAPicks(Gametime,Fav,spd,und,Pick,PickRating,SystemId) Values('#gametime#','#fav#',#spd#,'#und#','#pick#',#pickrat#,'SYS500') 
</cfquery>

<cfquery datasource="NBA" name="Add2">
	INSERT INTO NBAPicks(Gametime,Fav,spd,und,Pick,PickRating,SystemId) Values('#gametime#','#fav#',#spd#,'#und#','#pick2#',#pickrat2#,'SYS500WithNBAHomeFieldADV') 
</cfquery>

<cfif pick is pick2>
	<cfset AvgPickRat = (pickrat + pickrat2)/2>
	<cfquery datasource="NBA" name="Add3">
	INSERT INTO NBAPicks(Gametime,Fav,spd,und,Pick,PickRating,SystemId) Values('#gametime#','#fav#',#spd#,'#und#','#pick#',#Avgpickrat#,'AVGSYS500AndSYS500WithNBAHomeFieldADV') 
	</cfquery>
</cfif>


<br>

<cfoutput>
************** PickRat is #PickRat# *********************** <br> 
************** PickRat2 is #PickRat2# *********************** <br> 
************** PickRatAvg is #pick# with a rating of: #(PickRat + PickRat2)/2# *********************** <br> 

</cfoutput>
<p>
<cfif PickRat gte 4.0>
	<cfset Pick = '#Pick#*'>


<cfif '#MonthAsString(Month(Now()))#' neq 'xOctober'>
	<cfif '#MonthAsString(Month(Now()))#' neq 'xNovember'>
	
		<cfoutput>
		Pick is #pick# with a value of #PickRat#<br>
		</cfoutput>
		*******************************************<br>

	
		<cfquery datasource="NBA" name="Updit">
		Update FinalPicks 
		SET SYS500 = '#Pick#'
		where Fav = '#fav#'
		and gametime = '#gametime#'
		</cfquery>
	</cfif>
</cfif>
</cfif>






<cfoutput>
<tr>
<td>#Fav#</td>
<td>#HA#</td>
<td>#Spd#</td>
<td>#Und#</td>
<td>#PtsDif#</td>
<td>#RebDif#</td>
<td>#InsideDif#</td>
<td>#OutsideDif#</td>
<td>#ToDif#</td>
<td>#FGDif#</td>
</tr>
</cfoutput>





</cfloop>














<cfloop query="GetSpds">

    <cfset fav           = '#GetSpds.Fav#'>
    <cfset und           = '#GetSpds.Und#'>
    <cfset ha            = '#GetSpds.ha#'>
    <cfset spd           = Getspds.spd>





<cfquery name="GetitFav" datasource="NBA">
Select PickRating 
from NBAPicks
where systemid in('AVGSYS500AndSYS500WithNBAHomeFieldADV','PowerRatingWithHealth')
and gametime = '#gametime#'
and fav='#fav#'
and Pick = '#fav#'
</cfquery>

<cfquery name="GetitUnd" datasource="NBA">
Select PickRating  
from NBAPicks
where systemid in('AVGSYS500AndSYS500WithNBAHomeFieldADV','PowerRatingWithHealth')
and gametime = '#gametime#'
and fav='#fav#'
and Pick = '#und#'
</cfquery>



<cfset favrat = 0>
<cfset undrat = 0>
<cfset tot = GetItFav.recordcount + GetItUnd.recordcount>


<cfif GetItFav.recordcount gt 0>
	<cfloop query="GetItFav">
	<cfset favrat = favrat + #GetItFav.PickRating#>
	</cfloop>
</cfif>	

<cfif GetItUnd.recordcount gt 0>
	<cfloop query="GetItUnd">
	<cfset undrat = undrat + #GetItUnd.PickRating#>
	</cfloop>

</cfif>	

<cfif Undrat is ''>
	<cfset undrat = 0>
</cfif>

<cfif Favrat is ''>
	<cfset Favrat = 0>
</cfif>





	<cfoutput>
	#fav# vs #und#<br>
	#FavRat#<br>
	#UndRat#
	The Tot = #tot#
	</cfoutput>
	
<cfset theplay   = 0>
<cfset therating = 0>

<cfif FavRat gt UndRat>
	<cfset theplay = '#Fav#'>
	<cfset therating = (FavRat - UndRat) / tot > 
</cfif>


<cfif UndRat gt FavRat>
	<cfset theplay = '#Und#'>
	<cfset therating = (UndRat - FavRat) / tot> 
</cfif>

<cfoutput>
****************************************************Final Pick is #theplay# with a rating of #therating#<br>
</cfoutput>

<cfquery name="GetitFav" datasource="NBA">
Delete from NBAPicks
where systemid in('AvgOfAllPowerRatings')
and gametime = '#gametime#'
and fav = '#fav#'
</cfquery>

<cfquery datasource="NBA" name="Add2">
	INSERT INTO NBAPicks(Gametime,Fav,spd,und,Pick,PickRating,SystemId) Values('#gametime#','#fav#',#spd#,'#und#','#theplay#',#therating#,'AvgOfAllPowerRatings') 
</cfquery>


</cfloop>

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('Ran SHOWPOWER.cfm')
</cfquery>
