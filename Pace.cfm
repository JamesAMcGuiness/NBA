	



<cfif 1 is 2>

<cfquery datasource="NBA" name="GetIt">
	Select team,  AVG( 0.5 *  ((oFGA + 0.4 * oFTA - 1.07 * (oReB / (oTReB + ODReB)) * (oFGA - oFGM) + oTurnovers) + 
	       (dFGA + 0.4 * dFTA - 1.07 * (dReb / (dTReb + ddReB)) * (dFGA - dFGM) + dTurnovers)) ) as PACE
	from NBAData
	where mins = 240
	Group by Team
</cfquery>

<cfoutput query="Getit">
#Getit.Team#, #Getit.Pace#<br>
</cfoutput>


<cfquery datasource="NBA" name="GetIt">
UPDATE NBAData
SET PACE = 0.5 *  ((oFGA + 0.4 * oFTA - 1.07 * (oReB / (oTReB + ODReB)) * (oFGA - oFGM) + oTurnovers) + 
	       (dFGA + 0.4 * dFTA - 1.07 * (dReb / (dTReb + ddReB)) * (dFGA - dFGM) + dTurnovers))  
where mins = 240
</cfquery>
</cfif>

<cfset w = 0>
<cfset l = 0>


<cfquery datasource="NBA" name="GetIt">
	Select distinct FavHealthL7, UndHealthL7, d.gametime,s.fav,s.spd,s.und,d.Team, d.PACE, d.PS, d.DPS, (d.PS + d.DPS) as TOTPTS, s.ou, (fp.FavHealthL7 + fp.UndHealthL7) as GameHealth, fp.FavHealthL7, fp.UndHealthL7
	
	from NBAData d, FinalPicks fp, NBASchedule s
	where d.mins = 240
	and s.gametime = d.gametime
	and fp.gametime = s.gametime
	and (d.team = fp.fav or d.team = fp.und)
	and (s.fav = fp.fav)
	and (fp.FavHealthL7 + fp.UndHealthL7) <= -14
	
	order by d.gametime desc, s.fav
</cfquery>

-- Exclude any games with Top 3 in TPM BetterThanAvg
and s.FAV not in ('MIL','GSW','HOU')
and s.UND not in ('MIL','GSW','HOU')








<table border="1" width="50%">
<tr>
<td>GameTime</td>
<td>FAV</td>
<td>SPD</td>
<td>UND</td>
<td>Total</td>
<td>Total Pts</td>
<td>GameHealth</td>
<td>Predicted Pace</td>
<td>Pace</td>
<td>Pred 3PTA</td>
<td>Pred 3PTM</td>
<td>Fav Health</td>
<td>Und Health</td>
<td>Win/Loss</td>

</tr>

<cfoutput query="Getit" group="FAV">

<cfquery datasource="NBA" name="GetAvg">
	Select d.Team, AVG(d.Pace) as aPACE
	from NBAData d
	where d.mins = 240
	and d.Pace > 0
	and (Team = '#FAV#' or Team ='#Und#')
	and d.gametime < '#gametime#'
	group by d.team
</cfquery>

<cfquery datasource="NBA" name="FAVGetAvg3pt">
	Select AVG(d.oTPA) as offTPA, AVG(d.dTPA) as defTPA
	from NBAData d
	where d.mins = 240
	and (Team = '#FAV#')
	and d.gametime < '#gametime#'
</cfquery>

<cfquery datasource="NBA" name="UNDGetAvg3pt">
	Select AVG(d.oTPA) as offTPA, AVG(d.dTPA) as defTPA
	from NBAData d
	where d.mins = 240
	and (Team = '#UND#')
	and d.gametime < '#gametime#'
</cfquery>


<cfquery datasource="NBA" name="FAVGetAvgTPM">
	Select AVG(d.oTPM) as offTPM, AVG(d.dTPM) as defTPM
	from NBAData d
	where d.mins = 240
	and (Team = '#FAV#')
	and d.gametime < '#gametime#'
</cfquery>

<cfquery datasource="NBA" name="UNDGetAvgTPM">
	Select AVG(d.oTPM) as offTPM, AVG(d.dTPM) as defTPM
	from NBAData d
	where d.mins = 240
	and (Team = '#UND#')
	and d.gametime < '#gametime#'
</cfquery>

<cfquery datasource="NBA" name="GetAvgTPM">
	Select AVG(d.oTPM) as avgTPM
	from NBAData d
	where d.mins = 240
	and d.gametime < '#gametime#'
</cfquery>

<cfquery datasource="NBA" name="GetTOPTPM1">
	Select d.Team, (AVG(d.otpm) - #GetAvgTPM.avgTPM#) / AVG(d.otpm)*100   as thestat  
	from NBAData d
	where d.mins = 240
	and d.gametime < '#gametime#'
	Group BY d.Team
	order by 2 desc
</cfquery>

<cfquery dbtype="query" name="GetTOPTPM">
	Select Team   
	from GetTOPTPM1
	where thestat > 12.9999
</cfquery>

<cfset myList = ValueList(GetTOPTPM.Team)>

<cfif 1 is 2>
<cfdump var="#GetTOPTPM1#">
<cfdump var="#GetTOPTPM#">
</cfif>


<cfset TotPredTPM1 = FAVGetAvgTPM.OffTPM + UNDGetAvgTPM.DefTPM>
<cfset TotPredTPM2 = UNDGetAvgTPM.OffTPM + FAVGetAvgTPM.DefTPM>
<cfset Tot3ptm = (FAVGetAvgTPM.OffTPM + UNDGetAvgTPM.OffTPM)>



<cfset FavOfftppred = FAVGetAvg3pt.OffTPA + UNDGetAvg3pt.DefTPA>
<cfset UndOfftppred = UNDGetAvg3pt.OffTPA + FAVGetAvg3pt.DefTPA>
<cfset Tot3pta = (FavOfftppred + UndOfftppred)/4>

<cfset totpredpace = 0>
<cfloop query="GetAvg">
<cfset totpredpace = totpredpace + #aPace#>
</cfloop>
<cfset totpredpace = totpredpace/2>


totpredpace lt 108 && Tot3pta gt 31.99 &&
<cfif Tot3pta gt 31.99 && FavHealthL7 lt -5 && UndHealthL7 lt -5>



checking '#gametime#', '#mylist#'<br>

<tr>
<td>#GameTime#</td>
<td>#FAV#</td>
<td>#SPD#</td>
<td>#UND#</td>
<td>#ou#</td>
<td>#TotPts#</td>
<td>#GameHealth#</td>
<td>#TotPredPace#</td>
<td>#Pace#</td>
<td>#tot3pta#</td>
<td>#tot3ptm#</td>
<td>#FavHealthL7#</td>
<td>#UndHealthL7#</td>

<td><cfif totpts lt ou>WINNER!<cfelse> Loser</cfif></td>
</tr>

<cfif totpts lt ou>
<cfset w = w + 1>
<cfelseif totpts gt ou >
<cfset l = l + 1>
</cfif>

</cfif>

</cfoutput>

</table>
<cfoutput>
#w# - #l#
</cfoutput>
