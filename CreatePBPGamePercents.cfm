<cfset myPBPCFC = createObject("component", "NBAPBP") />

 
<cfset Gametime = '20131207'>

<cfquery name="GetGames" datasource="nba">
	Select *
	from NBASchedule
	where Gametime = '#gametime#'
</cfquery>

<cfloop query="GetGames">
	<cfset myPBPCFC.createPBPPercents('#Gametime#','#GetGames.Fav#')>
	<cfset myPBPCFC.createPBPPercents('#Gametime#','#GetGames.Und#')>
</cfloop>	




<cfquery name="GetGames" datasource="nba">
	Select *
	from NBAschedule
	where Gametime = '20131207'
</cfquery>

<cfloop query="GetGames">

<cfset fav = Getgames.fav>
<cfset und = Getgames.und>


<cfquery name="GetInfoOff" datasource="nba">
	Select Team, Avg(Opportunity) as aOpportunity , Avg(InsidePct) as aInsidePct, Avg(OutsidePct) as aOutsidePct, Avg(FtaPct) as aFtaPct, 
	Avg(MadeInsidePct) as aMadeInsidePct, Avg(MadeOutsidePct) as aMadeOutsidePct, Avg(MadeNormalPct) as aMadeNormalPct,
	(100 - (Avg(InsidePct) + Avg(OutsidePct))) as NormalShotPct
	from PBPPercents
	where OffDef = 'O'
	and Team in ('#fav#','#und#')
	group by team
</cfquery>


<cfquery name="GetInfoDef" datasource="nba">
	Select Team, Avg(Opportunity) as aOpportunity , Avg(InsidePct) as aInsidePct, Avg(OutsidePct) as aOutsidePct, Avg(FtaPct) as aFtaPct, 
	Avg(MadeInsidePct) as aMadeInsidePct, Avg(MadeOutsidePct) as aMadeOutsidePct, Avg(MadeNormalPct) as aMadeNormalPct,
	(100 - (Avg(InsidePct) + Avg(OutsidePct))) as NormalShotPct
	from PBPPercents
	where OffDef = 'D'
	and Team in ('#fav#','#und#')
	Group By Team
</cfquery>

<table border="1">
<tr>
<td>Team</td>
<td>Opportunity</td>
<td>Normal Pct</td>
<td>Inside Pct</td>
<td>Outside Pct</td>
<td>FTA Pct</td>
<td>Make Inside Pct</td>
<td>Make Outside Pct</td>
<td>Make Normal Pct</td>
</tr>

<cfoutput query="GetInfoOff">
<tr>
<td>#Team#</td>
<td>#aOpportunity#</td>
<td>#NormalShotPct#</td>
<td>#aInsidePct#</td>
<td>#aOutsidePct#</td>
<td>#aFTAPct#</td>
<td>#aMadeInsidePct#</td>
<td>#aMadeOutsidePct#</td>
<td>#aMadeNormalPct#</td>
</tr>
</cfoutput>
</table>

<table border="1">
<tr>
<td>Team</td>
<td>Opportunity</td>
<td>Normal Pct</td>
<td>Inside Pct</td>
<td>Outside Pct</td>
<td>FTA Pct</td>
<td>Make Inside Pct</td>
<td>Make Outside Pct</td>
<td>Make Normal Pct</td>
</tr>

<cfoutput query="GetInfoDef">
<tr>
<td>#Team#</td>
<td>#aOpportunity#</td>
<td>#NormalShotPct#</td>
<td>#aInsidePct#</td>
<td>#aOutsidePct#</td>
<td>#aFTAPct#</td>
<td>#aMadeInsidePct#</td>
<td>#aMadeOutsidePct#</td>
<td>#aMadeNormalPct#</td>
</tr>
</cfoutput>
</table>


<hr>

</cfloop>