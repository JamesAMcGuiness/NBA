<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<cfquery datasource="nbaschedule" name="Getspds">
Select *
from nbaschedule
where GameTime = '#Session.gametime#'
</cfquery>

<cfquery datasource="NBAPicks" name="GetPicks">
Select distinct * from NBAPicks where GameTime = '#Session.GameTime#' and (systemid="GAP" or systemid="GameSimHAForAvgs")
order by Systemid,Pct Desc
</cfquery>


<body>
<table align="center" width="60%" border="1">
<tr>
<td>
System Name: Picks for <cfoutput>#Session.GameTime#</cfoutput>
</td>
<td>
Favorite
</td>
<td>
H/A
</td>
<td>
Spread
</td>
<td>
Underdog
</td>
<td>
Our Pick
</td>
<td>
Pick Strength
</td>
</tr>

<cfoutput query="GetPicks" group="Systemid">
<tr>
<td>#Systemid#</td>
</tr>
<cfoutput>
<tr>
<td>&nbsp;</td>
<td>#fav#</td>
<td>#ha#</td>
<td>#spd#</td>
<td>#und#</td>
<td>#pick#</td>
<td>#pct#</td>
</tr>
</cfoutput>

</cfoutput>

</table>







<table align="center" width="60%" border="1">
<tr>
<td>
System Name: Picks for <cfoutput>#Session.GameTime#</cfoutput>
</td>
<td>
Favorite
</td>
<td>
H/A
</td>
<td>
Spread
</td>
<td>
Underdog
</td>
<td>
Sys1
</td>
<td>
Pick
</td>
<td>
Pick Strength
</td>
<td>
Sys2
</td>
<td>
Pick
</td>
<td>
Pick Strength
</td>

<td>
Sys3
</td>
<td>
Pick
</td>
<td>
Pick Strength
</td>

<td>
Sys4
</td>
<td>
Pick
</td>
<td>
Pick Strength
</td>
</tr>


<cfoutput query="GetSpds">
<tr>
	<cfquery datasource="NBAPicks" name="GetPicks">
	Select 
		Pick,Pct,SystemId
	from NBAPicks 
	where GameTime = '#Session.GameTime#'
	and Fav = '#GetSpds.Fav#'
	and (systemid="GAP" or systemid="GameSimHAForAvgs")
	Group by Systemid,Pick,pct
	order by Systemid
	</cfquery>

	<td>&nbsp;</td>
	<td>#fav#</td>
	<td>#ha#</td>
	<td>#spd#</td>
	<td>#und#</td>
	<cfloop query="GetPicks">
	
	<td>#Systemid#</td>
	<td>#Pick#</td>
	<td>#Pct#</td>
	
	</cfloop>

</tr>	
</cfoutput>

</table>


</body>
</html>
