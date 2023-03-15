<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfquery name="GetGameTime" datasource="NbaSchedule" >
Select Max(GameTime) as gtme
FROM nbaschedule
</cfquery>

<cfset GameTime = GetGameTime.gtme>

<cfquery name="GetNeedPreds" datasource="nbagamesim" >
Select fav, count(fav) as howmany
FROM nbagamesim
where Trim(Gametime) = '#Trim(Gametime)#'
Group By Fav
Having count(fav) <> 10
</cfquery>

<cfif GetNeedPreds.Recordcount neq 0 or GetNeedPreds.HowMany neq 10 >
	<cfset Session.GameTime = '#GameTime#'>
	<cfinclude template="GameSimUltimateHomeAway.cfm">
</cfif>


</body>
</html>
