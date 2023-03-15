<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('In PowerRtingPicks.cfm')
</cfquery>


<cfif 1 is 1>

	<cfquery datasource="Nba" name="UpdStatus">
		Insert into NBADataloadStatus(StepName) values('In PowerRatingPicks.cfm about to call ShowPowerHA.cfm')
	</cfquery>


	<cfif 1 is 2>
	<cfinclude template="ShowPowerHA.cfm">
	</cfif>


	<cfinclude template="createHFA.cfm">


	<cfquery datasource="nba" name="getinfo">
	Select Pick, gametime, fav 
	from NBAPicks where Systemid = 'PowerRatingWithHealth' AND PickRating >= 2 
	</cfquery>

	<cfloop query="getinfo">
	<cfquery datasource="nba" name="u">
	UPDATE FinalPicks
	SET SYS102 = '#GetInfo.Pick#' 
	WHERE Gametime='#GetInfo.Gametime#'
	AND fav='#GetInfo.Fav#' 
	</cfquery>

	</cfloop>

</cfif>


<cfquery datasource="nba" name="DelIt">
Delete from NBAHomeFieldAdv
</cfquery> 

<cfquery datasource="nba" name="GetIt">
Select Team, HomePower + 20 as hmp, AwayPower + 20 as awp, TotalPower + 20 as tp
From HomeAwayPower
</cfquery> 

<cfoutput query="GetIt">																																																		

	<cfset Homestat = (GetIt.hmp - GetIt.awp) / GetIt.tp>
	<cfset HFA = 2.3 + (2.3 * HomeStat)>


	<cfquery datasource="nba" name="Addit">
	INSERT INTO NBAHomeFieldAdv(Team, HFA, HomeFieldWt) VALUES('#GetIt.Team#',#HFA#,#HomeStat#)
	</cfquery>


</cfoutput>


<table border="1" width="65%">
<tr>
<td>
FAV
</td>
<td>
H/A
</td>
<td>
Spread
</td>
<td>
Und
</td>
<td>
Avg Spread
</td>
<td>
Avg Spread w/Health
</td>
<td>
Pick
</td>
<td>
FAV Spd Value
</td>
<td>
Pick W/ Health
</td>
<td>
FAV Spd Value w/Health
</td>
</tr>

<cfquery datasource="nba" Name="GetDay">
SELECT Gametime
FROM NBAGametime
</cfquery>

<cfset thegametime = '#GetDay.Gametime#'>


<cfquery datasource="NBA" name="Addit">
Delete from NBAPicks where Gametime ='#thegametime#' and systemid='PowerRatingWithHealth'
</cfquery>


<cfquery datasource="nba" Name="GetGames">
SELECT *
FROM NBASchedule
WHERE Gametime = '#thegametime#'
</cfquery>



<cfloop query="GetGames">

<cfset theFav = '#GetGames.Fav#'>
<cfset theUnd = '#GetGames.Und#'>
<cfset thespd = '#GetGames.spd#'>
<cfset theHA  = '#GetGames.ha#'>

<cfquery datasource="nba" Name="GetFavHAPower">
SELECT p.Team, p.TotalPower, p.HomePower, p.AwayPower, fp.FavHealthL7, fp.spd, fp.ha
FROM HomeAwayPower p, FinalPicks fp
WHERE FP.FAV = p.Team
AND p.Team = '#theFAV#'
and fp.gametime = '#theGameTime#'
</cfquery>

<cfquery datasource="nba" Name="GetUndHAPower">
SELECT p.Team, p.TotalPower, p.HomePower, p.AwayPower, fp.UndHealthL7, fp.spd, fp.ha
FROM HomeAwayPower p, FinalPicks fp
WHERE FP.UND = p.Team
AND p.Team = '#theUND#'
and fp.gametime = '#theGameTime#'
</cfquery>







<cfset Fraw = GetFavHAPower.TotalPower>
<cfset Uraw = GetUndHAPower.TotalPower>
<cfset Diffraw = FRaw - URaw>
<cfset FavHlthAdv = (.45* ( GetFavHAPower.FavHealthL7 - GetUndHAPower.UndHealthL7))> 

<cfif '#theHa#' is 'H'>
  <cfset FHA  = 2.15 + GetFavHAPower.HomePower>
  <cfset UHA  = GetUndHAPower.AwayPower>
  <cfset Uraw = GetUndHAPower.AwayPower>
  
<cfelse>
  <cfset FHA  = GetFavHAPower.AwayPower>
  <cfset UHA  = 2.15 + GetUNDHAPower.HomePower>
  <cfset Uraw = GetUndHAPower.HomePower>
</cfif>

<cfset DiffHA = FHA - UHA>

<Cfset AvgSpd                  = (Diffraw + DiffHA)/2>
<cfset FavSpdVal               = AvgSpd - #val(thespd)#>
<cfset FavSpdValWithHlthFactor = FavSpdVal + FavHlthAdv>

<cfset Pick     = '#theund#'>
<cfset PickHlth = '#theund#'>
<cfif FavSpdVal gt 0>
  <cfset Pick = '#thefav#'>
</cfif>

<cfif FavSpdValWithHlthFactor gt 0>
  <cfset PickHlth = '#thefav#'>
</cfif>

<cfoutput>
<tr>
<td>
#theFAV#
</td>
<td>
#theha#
</td>
<td>
#thespd#
</td>
<td>
#theund#
</td>
<td>
#AvgSpd#
</td>
<td>
#AvgSpd + FavHlthAdv#
</td>
<td>
#pick#
</td>
<td>
#FAVSpdVal#
</td>
<td>
#PickHlth#
</td>
<td>
#FavSpdValWithHlthFactor#
</td>
</tr>
</cfoutput>

<cfquery datasource="NBA" name="Addit">
Insert Into NBAPicks(Gametime,Fav,spd,und,Pick,PickRating,SystemId) values('#thegametime#','#thefav#','#thespd#','#theund#','#PickHlth#',#ABS(FavSpdValWithHlthFactor)#,'PowerRatingWithHealth')
</cfquery>

<cfif #ABS(FavSpdValWithHlthFactor)# gte 1.9999>

<cfquery datasource="NBA" name="xAddit">
UPDATE FinalPicks
SET SYS102 = '#PickHlth#'
WHERE GAMETIME = '#thegametime#'
AND FAV = '#thefav#'
</cfquery>
</cfif>


</cfloop>



</table>


<cfquery datasource="nba" name="getinfo">
Select distinct * from finalpicks fp
where gametime in (select gametime from nbagametime)
</cfquery>

<cfloop query="Getinfo">
<cfif GetInfo.PIPPick gt ''>
		<cfif GetInfo.PIPPick is '#Left(GetInfo.SYS500,3)#' >
			<cfif GetInfo.SYS29 is GetInfo.PIPPick >
				<cfquery datasource="nba">
				Update FinalPicks
				Set SYS50       = '#GetInfo.PIPPick#'
				Where gametime  = '#Getinfo.gametime#'
				and fav         = '#GetInfo.fav#'
			</cfquery>
			</cfif>
		</cfif>
</cfif>
</cfloop>
<cfinclude template="CreateHFA.cfm">