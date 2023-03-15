<cfquery name="FavWhoLost" Datasource="NBA">
Select sched.Gametime,
Sched.Fav,
Sched.Spd,
Sched.HA,
Sched.Und,
data.ps,
data.dps,
hlth.TeamHealth,
data.ofgpct,
data.dfgpct


FROM NBASchedule sched, NBAData data, teamsituation hlth
Where sched.Fav = data.team
and sched.spd >= 8
and data.PS - data.DPS < 0
and sched.gametime = data.gametime
and sched.gametime = hlth.gametime
and sched.fav = hlth.team
order by sched.gametime desc
</cfquery>

<table border="1">

<tr>
<td>Gametime</td>
<td>Fav</td>
<td>Spd</td>
<td>H/A</td>
<td>Und</td>
<td>PS</td>
<td>DPS</td>
<td>Fav Health</td>
<td>FGPct</td>
<td>DFGPct</td>

</tr>


<cfoutput query="FAVWHOLOST">
<tr>
<td>#Gametime#</td>
<td>#Fav#</td>
<td>#Spd#</td>
<td>#HA#</td>
<td>#Und#</td>
<td>#PS#</td>
<td>#DPS#</td>
<td>#TeamHealth#</td>
<td>#ofgpct#</td>
<td>#dfgpct#</td>


</tr>
</cfoutput>