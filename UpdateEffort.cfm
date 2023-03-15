
<hr>

<cftry>

<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>


<cfquery name="GetFavStats" datasource="nba" >
Select d.team,d.opp,d.ps - ((s.ou/2) + (s.spd/2)) as FavOffEff,  ((s.ou/2) - (s.spd/2)) - d.dps as FavDefEff , s.gametime
FROM nbaschedule s, nbadata d
where s.Gametime = d.Gametime
and s.fav = d.team
and s.ou <> 0
order by s.gametime desc
</cfquery>


<cfquery name="GetUndStats" datasource="nba" >
Select d.team, d.opp, d.ps - ((s.ou/2) - (s.spd/2)) as UndOffEff, ((s.ou/2) + (s.spd/2)) - d.dps as UndDefEff , s.gametime
FROM nbaschedule s, nbadata d
where s.Gametime = d.Gametime
and s.und = d.team
and s.ou <> 0
order by s.gametime desc
</cfquery>


<cfdump var="#GetFavStats#">
<cfdump var="#GetUndStats#">






<cfoutput query="GetFAVStats">

<cfquery name="UpdFav" datasource="nba" >
Update NBAData
Set OffEffort  = #GetFavStats.FavOffEff#
Where gametime = '#GetFavStats.Gametime#'
AND Team       = '#GetFavStats.team#'
</cfquery>


<cfquery name="UpdFav" datasource="nba" >
Update NBAData
Set DefEffort  = -1*#GetFavStats.FavOffEff#
Where gametime = '#GetFavStats.Gametime#'
AND Team       = '#GetFavStats.Opp#'
</cfquery>


</cfoutput>



<cfoutput query="GetUndStats">

<cfquery name="UpdUnd" datasource="nba" >
Update NBAData
Set OffEffort  = #GetUndStats.UndOffEff#
Where gametime = '#GetUndStats.Gametime#'
AND Team       = '#GetUndStats.team#'
</cfquery>


<cfquery name="UpdUnd" datasource="nba" >
Update NBAData
Set DefEffort  = -1*#GetUndStats.UndOffEff#
Where gametime = '#GetUndStats.Gametime#'
AND Team       = '#GetUndStats.opp#'
</cfquery>


</cfoutput>


<cfquery name="UpdUnd" datasource="nba" >
Update NBAData
Set TotEffort  = OffEffort + DefEffort
</cfquery>

<cfquery datasource="Nba" name="UPDATE">
	Insert into NBADataLoadStatus
	(
	ProgramName
	)
	values
	(
	'UpdateEffort.cfm'
	)
</cfquery>




<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:UpdateEffort.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>


