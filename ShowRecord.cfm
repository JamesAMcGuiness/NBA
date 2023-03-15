<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>Untitled</title>
</head>

<body>


<!--- For each Game  --->
<cfquery datasource="NbaSchedule" name="GetPicks">
Select NBAPicks.*,s.ou as total
from NBAPicks, NBASchedule s
where NBAPicks.Gametime = s.Gametime
and NBAPicks.fav = s.fav
and NBAPicks.Systemid = 'GAP2a'
and NBAPicks.sidewinner <> 'P'
</cfquery>

<cfoutput query="GetPicks">

<cfset TheSpreadWinner = ''>
<cfset TheTotalWinner  = 0>

<cfset thefav = '#fav#'>
<cfset theund = '#und#'>
<cfset thespd = #spd#>
<cfset thetot = #total#>

<!--  See if the favorite covered  -->
<cfquery datasource="NbaStats" name="GetNbaData">
Select d.Team, d.PS - d.DPS as Spd, d.PS + d.dps as tot
from NBAData d
where d.Gametime = '#GetPicks.Gametime#'
and d.team = '#thefav#'  
</cfquery>

<cfif GetNbaData.spd gt thespd>
	<cfset TheSpreadWinner = '#thefav#'>
<cfelseif GetNbaData.spd lt #thespd# >
	<cfset TheSpreadWinner = '#theund#'>
<cfelse> 
	<cfset TheSpreadWinner = 'P'> 
</cfif>

<cfif GetNbaData.tot gt thetot>
	<cfset TheTotalWinner = 'O'>
<cfelseif GetNbaData.tot lt #thetot#>
	<cfset TheTotalWinner = 'U'>
<cfelse> 
	<cfset TheTotalWinner = 'P'>
</cfif>



</cfoutput>

<cfloop index="xx" from="1"  to="3">
<cfif xx is 1>
	<cfset spdrange = ">= 1 and pct <= 4.9">
	<cfset ourange = ">= 1 and oupct <= 4.9">
</cfif>
<cfif xx is 2>
	<cfset spdrange = ">= 5 and pct <= 10">
	<cfset ourange = ">= 4 and oupct <= 10">
</cfif>

<cfif xx is 3>
	<cfset spdrange = ">= 0 and pct <= 100">
	<cfset ourange = ">= 0 and oupct <= 100">
</cfif>


<cfquery datasource="NbaPicks" name="Upd">
<!--- Select * from NbaPicks where Pick <> 'Not en' and Sidewinner <> 'P' --->
Select * from NbaPicks where 1=1
and pct #spdrange#
and trim(systemid) = 'GAP2a'
and sidewinner <> 'P'
</cfquery>



<cfset w = 0>
<cfset ow = 0>
<cfoutput query="Upd">

<!-- '#upd.Pick#' is '#Upd.SideWinner#'...#w#....#pct#...<br>
-----------------------------------------<br> -->
<cfif '#trim(upd.Pick)#' is '#trim(Upd.SideWinner)#'>
	<cfset w = w + 1>
</cfif>

</cfoutput>
<cfoutput>
Record Count: #Upd.Recordcount#<br>
Your Winning% on SIDES for #spdrange#% was: #NumberFormat((w/Upd.Recordcount*100),'99.99')#<br>
</cfoutput>


<cfquery datasource="NbaPicks" name="Upd">
<!--- Select * from NbaPicks where Pick <> 'Not en' and ouwinner <> 'P' --->
Select * from NbaPicks where 1=1
and oupct #ourange#
and trim(systemid) = 'GAP2a'
and ouwinner <> 'P'
</cfquery>

<cfset w = 0>
<cfset ow = 0>
<cfoutput query="Upd">

<!-- '#upd.ouPick#' is '#Upd.ouWinner#'...#ow#....#oupct#<br>
-----------------------------------------<br> -->
<cfif '#trim(upd.OuPick)#' is '#trim(upd.OuWinner)#'>
	<cfset ow = ow + 1>
</cfif>

</cfoutput>
<cfoutput>
Record Count: #Upd.Recordcount#
Your Winning% on TOTALS for #ourange#% was: #Numberformat((ow/Upd.Recordcount*100),'99.99')#<br>
</cfoutput>
<br>
<br>
</cfloop>

</body>
</html>
