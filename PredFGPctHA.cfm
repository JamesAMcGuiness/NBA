<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>

<cfset mygametime = "#GetRunCt.gametime#">

<cfif 1 is 1>

<cfinclude template="CreatePowerMinutes.cfm">


<cfquery datasource="nba">
Delete from fgpctHome
</cfquery>

<cfquery datasource="nba">
Delete from fgpctAway
</cfquery>

<cfloop index="ii" from="1" to="2">

<cfset hatouse = 'A'>
<cfif ii is 1>
	<cfset hatouse = 'H'>
</cfif>

<cfquery datasource="nba" name="GetTeams">
Select distinct(team) from Power
</cfquery>


<cfloop query="GetTeams">
<cfset Team = '#GetTeams.team#'>

<cfquery datasource="nba" name="Getit">
Select * from Power
where team = '#team#'
and ha = '#hatouse#'
</cfquery>

<cfset urg1 = 0>
<cfset urg2 = 0>
<cfset urg3 = 0>
<cfset urg4 = 0>
<cfset urg5 = 0>

<cfset org1 = 0>
<cfset org2 = 0>
<cfset org3 = 0>
<cfset org4 = 0>
<cfset org5 = 0>

<cfset loopct = 0>

<cfoutput query="Getit">

<cfif round(ofgpct) ge 0 and round(ofgpct) le 3>
	<cfset org1 = org1 + 1>
</cfif>

<cfif round(ofgpct) ge 4 and round(ofgpct) le 6.0>
	<cfset org2 = org2 + 1>
</cfif>

<cfif round(ofgpct) ge 7 and round(ofgpct) le 9.0>
	<cfset org3 = org3 + 1>
</cfif>

<cfif round(ofgpct) ge 10 and round(ofgpct) le 12.0>
	<cfset org4 = org4 + 1>
</cfif>

<cfif round(ofgpct) ge 13>
	<cfset org5 = org5 + 1>
</cfif>

<cfif round(ofgpct) le -1  and round(ofgpct) ge -3>
	<cfset urg1 = urg1 + 1>
</cfif>

<cfif round(ofgpct) le -4 and round(ofgpct) ge -6.0>
	<cfset urg2 = urg2 + 1>
</cfif>

<cfif round(ofgpct) le -7 and round(ofgpct) ge -9.0>
	<cfset urg3 = urg3 + 1>
</cfif>

<cfif round(ofgpct) le -10 and round(ofgpct) ge -12.0>
	<cfset urg4 = urg4 + 1>
</cfif>

<cfif round(ofgpct) le -13>
	<cfset urg5 = urg5 + 1>
</cfif>

<cfset loopct = loopct + 1>
</cfoutput>

<cfoutput>
<cfset urg1 = urg1/loopct>
<cfset urg2 =  urg2/loopct>
<cfset urg3 =  urg3/loopct>
<cfset urg4 =  urg4/loopct>
<cfset urg5 = urg5/loopct>

<cfset org1 = org1/loopct>
<cfset org2 =  org2/loopct>
<cfset org3 =  org3/loopct>
<cfset org4 =  org4/loopct>
<cfset org5 = org5/loopct>

<!--  
urg1 = #urg1*100#<BR>
urg2 =  #urg2*100#<BR>
urg3 =  #urg3*100#<BR>
urg4 =  #urg4*100#<BR>
urg5 = #urg5*100#<BR>
#team#.............#(urg1 + urg2 + urg3 + urg4 + urg5)*100#<br>

-------------------------<BR>
org1 = #org1*100#<BR>
org2 =  #org2*100#<BR>
org3 =  #org3*100#<BR>
org4 =  #org4*100#<BR>
org5 = #org5*100#<BR>
#team#.............#(org1 + org2 + org3 + org4 + org5)*100#
-->
</cfoutput>

<cfif hatouse is 'H'>

<cfquery datasource="nba">
Insert into FGPctHome
(
Team,
oFGPctR1,
oFGPctR2,
oFGPctR3,
oFGPctR4,
oFGPctR5,
uFGPctR1,
uFGPctR2,
uFGPctR3,
uFGPctR4,
uFGPctR5,
oOverallFGPct,
uOverallFGPct
)

Values
(
'#team#',
#org1*100#,
#org2*100#,
#org3*100#,
#org4*100#,
#org5*100#,
#urg1*100#,
#urg2*100#,
#urg3*100#,
#urg4*100#,
#urg5*100#,
#(org1 + org2 + org3 + org4 + org5)*100#,
#(urg1 + urg2 + urg3 + urg4 + urg5)*100#
)
</cfquery> 

<cfelse>

<cfquery datasource="nba">
Insert into FGPctAway
(
Team,
oFGPctR1,
oFGPctR2,
oFGPctR3,
oFGPctR4,
oFGPctR5,
uFGPctR1,
uFGPctR2,
uFGPctR3,
uFGPctR4,
uFGPctR5,
oOverallFGPct,
uOverallFGPct
)

Values
(
'#team#',
#org1*100#,
#org2*100#,
#org3*100#,
#org4*100#,
#org5*100#,
#urg1*100#,
#urg2*100#,
#urg3*100#,
#urg4*100#,
#urg5*100#,
#(org1 + org2 + org3 + org4 + org5)*100#,
#(urg1 + urg2 + urg3 + urg4 + urg5)*100#
)
</cfquery> 


</cfif>




<cfset urg1 = 0>
<cfset urg2 = 0>
<cfset urg3 = 0>
<cfset urg4 = 0>
<cfset urg5 = 0>

<cfset org1 = 0>
<cfset org2 = 0>
<cfset org3 = 0>
<cfset org4 = 0>
<cfset org5 = 0>

<cfset loopct = 0>

<cfoutput query="Getit">

<cfif round(offreb) ge 0 and round(offreb) le 3>
	<cfset org1 = org1 + 1>
</cfif>

<cfif round(offreb) ge 4 and round(offreb) le 6.0>
	<cfset org2 = org2 + 1>
</cfif>

<cfif round(offreb) ge 7 and round(offreb) le 9.0>
	<cfset org3 = org3 + 1>
</cfif>

<cfif round(offreb) ge 10 and round(offreb) le 12.0>
	<cfset org4 = org4 + 1>
</cfif>

<cfif round(offreb) ge 13>
	<cfset org5 = org5 + 1>
</cfif>

<cfif round(offreb) le -1  and round(offreb) ge -3>
	<cfset urg1 = urg1 + 1>
</cfif>

<cfif round(offreb) le -4 and round(offreb) ge -6.0>
	<cfset urg2 = urg2 + 1>
</cfif>

<cfif round(offreb) le -7 and round(offreb) ge -9.0>
	<cfset urg3 = urg3 + 1>
</cfif>

<cfif round(offreb) le -10 and round(offreb) ge -12.0>
	<cfset urg4 = urg4 + 1>
</cfif>

<cfif round(offreb) le -13>
	<cfset urg5 = urg5 + 1>
</cfif>

<cfset loopct = loopct + 1>
</cfoutput>

<cfoutput>
<cfset urg1 = urg1/loopct>
<cfset urg2 =  urg2/loopct>
<cfset urg3 =  urg3/loopct>
<cfset urg4 =  urg4/loopct>
<cfset urg5 = urg5/loopct>

<cfset org1 = org1/loopct>
<cfset org2 =  org2/loopct>
<cfset org3 =  org3/loopct>
<cfset org4 =  org4/loopct>
<cfset org5 = org5/loopct>
<br>
<br>
<!-- 
Defense....<br>
urg1 = #urg1*100#<BR>
urg2 =  #urg2*100#<BR>
urg3 =  #urg3*100#<BR>
urg4 =  #urg4*100#<BR>
urg5 = #urg5*100#<BR>
#team#.............#(urg1 + urg2 + urg3 + urg4 + urg5)*100#<br>
-------------------------<BR>
org1 = #org1*100#<BR>
org2 =  #org2*100#<BR>
org3 =  #org3*100#<BR>
org4 =  #org4*100#<BR>
org5 = #org5*100#<BR>
#team#.............#(org1 + org2 + org3 + org4 + org5)*100#
 -->
</cfoutput>


<cfif hatouse is 'H'>

<cfquery datasource="nba">
Update FGPctHome
set oOffRebR1 = #org1*100#,
oOffRebR2 = #org2*100#,
oOffRebR3 = #org3*100#,
oOffRebR4 = #org4*100#,
oOffRebR5 = #org5*100#,
uOffRebR1 = #urg1*100#,
uOffRebR2 = #urg2*100#,
uOffRebR3 = #urg3*100#,
uOffRebR4 = #urg4*100#,
uOffRebR5 = #urg5*100#,
oOffRebPct = #(org1 + org2 + org3 + org4 + org5)*100#,
uOffRebPct = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 

<cfelse>

<cfquery datasource="nba">
Update FGPctAway
set oOffRebR1 = #org1*100#,
oOffRebR2 = #org2*100#,
oOffRebR3 = #org3*100#,
oOffRebR4 = #org4*100#,
oOffRebR5 = #org5*100#,
uOffRebR1 = #urg1*100#,
uOffRebR2 = #urg2*100#,
uOffRebR3 = #urg3*100#,
uOffRebR4 = #urg4*100#,
uOffRebR5 = #urg5*100#,
oOffRebPct = #(org1 + org2 + org3 + org4 + org5)*100#,
uOffRebPct = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 

</cfif>





<cfset urg1 = 0>
<cfset urg2 = 0>
<cfset urg3 = 0>
<cfset urg4 = 0>
<cfset urg5 = 0>

<cfset org1 = 0>
<cfset org2 = 0>
<cfset org3 = 0>
<cfset org4 = 0>
<cfset org5 = 0>

<cfset loopct = 0>

<cfoutput query="Getit">

<cfif round(defreb) ge 0 and round(defreb) le 3>
	<cfset org1 = org1 + 1>
</cfif>

<cfif round(defreb) ge 4 and round(defreb) le 6.0>
	<cfset org2 = org2 + 1>
</cfif>

<cfif round(defreb) ge 7 and round(defreb) le 9.0>
	<cfset org3 = org3 + 1>
</cfif>

<cfif round(defreb) ge 10 and round(defreb) le 12.0>
	<cfset org4 = org4 + 1>
</cfif>

<cfif round(defreb) ge 13>
	<cfset org5 = org5 + 1>
</cfif>

<cfif round(defreb) le -1  and round(defreb) ge -3>
	<cfset urg1 = urg1 + 1>
</cfif>

<cfif round(defreb) le -4 and round(defreb) ge -6.0>
	<cfset urg2 = urg2 + 1>
</cfif>

<cfif round(defreb) le -7 and round(defreb) ge -9.0>
	<cfset urg3 = urg3 + 1>
</cfif>

<cfif round(defreb) le -10 and round(defreb) ge -12.0>
	<cfset urg4 = urg4 + 1>
</cfif>

<cfif round(defreb) le -13>
	<cfset urg5 = urg5 + 1>
</cfif>

<cfset loopct = loopct + 1>
</cfoutput>

<cfoutput>
<cfset urg1 = urg1/loopct>
<cfset urg2 =  urg2/loopct>
<cfset urg3 =  urg3/loopct>
<cfset urg4 =  urg4/loopct>
<cfset urg5 = urg5/loopct>

<cfset org1 = org1/loopct>
<cfset org2 =  org2/loopct>
<cfset org3 =  org3/loopct>
<cfset org4 =  org4/loopct>
<cfset org5 = org5/loopct>
<!-- 
Defense....<br>
urg1 = #urg1*100#<BR>
urg2 =  #urg2*100#<BR>
urg3 =  #urg3*100#<BR>
urg4 =  #urg4*100#<BR>
urg5 = #urg5*100#<BR>
#team#.............#(urg1 + urg2 + urg3 + urg4 + urg5)*100#<br>
-------------------------<BR>
org1 = #org1*100#<BR>
org2 =  #org2*100#<BR>
org3 =  #org3*100#<BR>
org4 =  #org4*100#<BR>
org5 = #org5*100#<BR>
#team#.............#(org1 + org2 + org3 + org4 + org5)*100#
 -->
</cfoutput>


<cfif hatouse is 'H'>

<cfquery datasource="nba">
Update FGPctHome
set oDefRebR1 = #org1*100#,
oDefRebR2 = #org2*100#,
oDefRebR3 = #org3*100#,
oDefRebR4 = #org4*100#,
oDefRebR5 = #org5*100#,
uDefRebR1 = #urg1*100#,
uDefRebR2 = #urg2*100#,
uDefRebR3 = #urg3*100#,
uDefRebR4 = #urg4*100#,
uDefRebR5 = #urg5*100#,
oDefRebPct = #(org1 + org2 + org3 + org4 + org5)*100#,
uDefRebPct = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 

<cfelse>

<cfquery datasource="nba">
Update FGPctAway
set oDefRebR1 = #org1*100#,
oDefRebR2 = #org2*100#,
oDefRebR3 = #org3*100#,
oDefRebR4 = #org4*100#,
oDefRebR5 = #org5*100#,
uDefRebR1 = #urg1*100#,
uDefRebR2 = #urg2*100#,
uDefRebR3 = #urg3*100#,
uDefRebR4 = #urg4*100#,
uDefRebR5 = #urg5*100#,
oDefRebPct = #(org1 + org2 + org3 + org4 + org5)*100#,
uDefRebPct = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 

</cfif>






<cfset urg1 = 0>
<cfset urg2 = 0>
<cfset urg3 = 0>
<cfset urg4 = 0>
<cfset urg5 = 0>

<cfset org1 = 0>
<cfset org2 = 0>
<cfset org3 = 0>
<cfset org4 = 0>
<cfset org5 = 0>

<cfset loopct = 0>

<cfoutput query="Getit">

<cfif round(ofga) ge 0 and round(ofga) le 3>
	<cfset org1 = org1 + 1>
</cfif>

<cfif round(ofga) ge 4 and round(ofga) le 6.0>
	<cfset org2 = org2 + 1>
</cfif>

<cfif round(ofga) ge 7 and round(ofga) le 9.0>
	<cfset org3 = org3 + 1>
</cfif>

<cfif round(ofga) ge 10 and round(ofga) le 12.0>
	<cfset org4 = org4 + 1>
</cfif>

<cfif round(ofga) ge 13>
	<cfset org5 = org5 + 1>
</cfif>

<cfif round(ofga) le -1  and round(ofga) ge -3>
	<cfset urg1 = urg1 + 1>
</cfif>

<cfif round(ofga) le -4 and round(ofga) ge -6.0>
	<cfset urg2 = urg2 + 1>
</cfif>

<cfif round(ofga) le -7 and round(ofga) ge -9.0>
	<cfset urg3 = urg3 + 1>
</cfif>

<cfif round(ofga) le -10 and round(ofga) ge -12.0>
	<cfset urg4 = urg4 + 1>
</cfif>

<cfif round(ofga) le -13>
	<cfset urg5 = urg5 + 1>
</cfif>

<cfset loopct = loopct + 1>
</cfoutput>

<cfoutput>
<cfset urg1 = urg1/loopct>
<cfset urg2 =  urg2/loopct>
<cfset urg3 =  urg3/loopct>
<cfset urg4 =  urg4/loopct>
<cfset urg5 = urg5/loopct>

<cfset org1 = org1/loopct>
<cfset org2 =  org2/loopct>
<cfset org3 =  org3/loopct>
<cfset org4 =  org4/loopct>
<cfset org5 = org5/loopct>
<!--  
Defense....<br>
urg1 = #urg1*100#<BR>
urg2 =  #urg2*100#<BR>
urg3 =  #urg3*100#<BR>
urg4 =  #urg4*100#<BR>
urg5 = #urg5*100#<BR>
#team#.............#(urg1 + urg2 + urg3 + urg4 + urg5)*100#<br>
-------------------------<BR>
org1 = #org1*100#<BR>
org2 =  #org2*100#<BR>
org3 =  #org3*100#<BR>
org4 =  #org4*100#<BR>
org5 = #org5*100#<BR>
#team#.............#(org1 + org2 + org3 + org4 + org5)*100#
-->
</cfoutput>


<cfif hatouse is 'H'>

<cfquery datasource="nba">
Update FGPctHome
set oFGAR1 = #org1*100#,
oFGAR2 = #org2*100#,
oFGAR3 = #org3*100#,
oFGAR4 = #org4*100#,
oFGAR5 = #org5*100#,
uFGAR1 = #urg1*100#,
uFGAR2 = #urg2*100#,
uFGAR3 = #urg3*100#,
uFGAR4 = #urg4*100#,
uFGAR5 = #urg5*100#,
oOverallFGA = #(org1 + org2 + org3 + org4 + org5)*100#,
uOverallFGA = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 

<cfelse>

<cfquery datasource="nba">
Update FGPctAway
set oFGAR1 = #org1*100#,
oFGAR2 = #org2*100#,
oFGAR3 = #org3*100#,
oFGAR4 = #org4*100#,
oFGAR5 = #org5*100#,
uFGAR1 = #urg1*100#,
uFGAR2 = #urg2*100#,
uFGAR3 = #urg3*100#,
uFGAR4 = #urg4*100#,
uFGAR5 = #urg5*100#,
oOverallFGA = #(org1 + org2 + org3 + org4 + org5)*100#,
uOverallFGA = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 

</cfif>






































<cfset urg1 = 0>
<cfset urg2 = 0>
<cfset urg3 = 0>
<cfset urg4 = 0>
<cfset urg5 = 0>

<cfset org1 = 0>
<cfset org2 = 0>
<cfset org3 = 0>
<cfset org4 = 0>
<cfset org5 = 0>

<cfset loopct = 0>

<cfoutput query="Getit">

<cfif round(otppct) ge 0 and round(otppct) le 3>
	<cfset org1 = org1 + 1>
</cfif>

<cfif round(otppct) ge 4 and round(otppct) le 6.0>
	<cfset org2 = org2 + 1>
</cfif>

<cfif round(otppct) ge 7 and round(otppct) le 9.0>
	<cfset org3 = org3 + 1>
</cfif>

<cfif round(otppct) ge 10 and round(otppct) le 12.0>
	<cfset org4 = org4 + 1>
</cfif>

<cfif round(otppct) ge 13>
	<cfset org5 = org5 + 1>
</cfif>

<cfif round(otppct) le -1  and round(otppct) ge -3>
	<cfset urg1 = urg1 + 1>
</cfif>

<cfif round(otppct) le -4 and round(otppct) ge -6.0>
	<cfset urg2 = urg2 + 1>
</cfif>

<cfif round(otppct) le -7 and round(otppct) ge -9.0>
	<cfset urg3 = urg3 + 1>
</cfif>

<cfif round(otppct) le -10 and round(otppct) ge -12.0>
	<cfset urg4 = urg4 + 1>
</cfif>

<cfif round(otppct) le -13>
	<cfset urg5 = urg5 + 1>
</cfif>

<cfset loopct = loopct + 1>
</cfoutput>

<cfoutput>
<cfset urg1 = urg1/loopct>
<cfset urg2 =  urg2/loopct>
<cfset urg3 =  urg3/loopct>
<cfset urg4 =  urg4/loopct>
<cfset urg5 = urg5/loopct>

<cfset org1 = org1/loopct>
<cfset org2 =  org2/loopct>
<cfset org3 =  org3/loopct>
<cfset org4 =  org4/loopct>
<cfset org5 = org5/loopct>

<!-- 
Defense....<br>
urg1 = #urg1*100#<BR>
urg2 =  #urg2*100#<BR>
urg3 =  #urg3*100#<BR>
urg4 =  #urg4*100#<BR>
urg5 = #urg5*100#<BR>
#team#.............#(urg1 + urg2 + urg3 + urg4 + urg5)*100#<br>
-------------------------<BR>
org1 = #org1*100#<BR>
org2 =  #org2*100#<BR>
org3 =  #org3*100#<BR>
org4 =  #org4*100#<BR>
org5 = #org5*100#<BR>
#team#.............#(org1 + org2 + org3 + org4 + org5)*100#
 -->
</cfoutput>

<cfif HaToUse is 'H'>

<cfquery datasource="nba">
Update FGPctHome
set otppctR1 = #org1*100#,
otppctR2 = #org2*100#,
otppctR3 = #org3*100#,
otppctR4 = #org4*100#,
otppctR5 = #org5*100#,
utppctR1 = #urg1*100#,
utppctR2 = #urg2*100#,
utppctR3 = #urg3*100#,
utppctR4 = #urg4*100#,
utppctR5 = #urg5*100#,
oOverallTPPCT = #(org1 + org2 + org3 + org4 + org5)*100#,
uOverallTPPCT = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 

<cfelse>
<cfquery datasource="nba">
Update FGPctAway
set otppctR1 = #org1*100#,
otppctR2 = #org2*100#,
otppctR3 = #org3*100#,
otppctR4 = #org4*100#,
otppctR5 = #org5*100#,
utppctR1 = #urg1*100#,
utppctR2 = #urg2*100#,
utppctR3 = #urg3*100#,
utppctR4 = #urg4*100#,
utppctR5 = #urg5*100#,
oOverallTPPCT = #(org1 + org2 + org3 + org4 + org5)*100#,
uOverallTPPCT = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 


</cfif>


<cfset urg1 = 0>
<cfset urg2 = 0>
<cfset urg3 = 0>
<cfset urg4 = 0>
<cfset urg5 = 0>

<cfset org1 = 0>
<cfset org2 = 0>
<cfset org3 = 0>
<cfset org4 = 0>
<cfset org5 = 0>

<cfset loopct = 0>

<cfoutput query="Getit">

<cfif round(dtppct) ge 0 and round(dtppct) le 3>
	<cfset org1 = org1 + 1>
</cfif>

<cfif round(dtppct) ge 4 and round(dtppct) le 6.0>
	<cfset org2 = org2 + 1>
</cfif>

<cfif round(dtppct) ge 7 and round(dtppct) le 9.0>
	<cfset org3 = org3 + 1>
</cfif>

<cfif round(dtppct) ge 10 and round(dtppct) le 12.0>
	<cfset org4 = org4 + 1>
</cfif>

<cfif round(dtppct) ge 13>
	<cfset org5 = org5 + 1>
</cfif>

<cfif round(dtppct) le -1  and round(dtppct) ge -3>
	<cfset urg1 = urg1 + 1>
</cfif>

<cfif round(dtppct) le -4 and round(dtppct) ge -6.0>
	<cfset urg2 = urg2 + 1>
</cfif>

<cfif round(dtppct) le -7 and round(dtppct) ge -9.0>
	<cfset urg3 = urg3 + 1>
</cfif>

<cfif round(dtppct) le -10 and round(dtppct) ge -12.0>
	<cfset urg4 = urg4 + 1>
</cfif>

<cfif round(dtppct) le -13>
	<cfset urg5 = urg5 + 1>
</cfif>

<cfset loopct = loopct + 1>
</cfoutput>

<cfoutput>
<cfset urg1 = urg1/loopct>
<cfset urg2 =  urg2/loopct>
<cfset urg3 =  urg3/loopct>
<cfset urg4 =  urg4/loopct>
<cfset urg5 = urg5/loopct>

<cfset org1 = org1/loopct>
<cfset org2 =  org2/loopct>
<cfset org3 =  org3/loopct>
<cfset org4 =  org4/loopct>
<cfset org5 = org5/loopct>
<!-- 
Defense....<br>
urg1 = #urg1*100#<BR>
urg2 =  #urg2*100#<BR>
urg3 =  #urg3*100#<BR>
urg4 =  #urg4*100#<BR>
urg5 = #urg5*100#<BR>
#team#.............#(urg1 + urg2 + urg3 + urg4 + urg5)*100#<br>
-------------------------<BR>
org1 = #org1*100#<BR>
org2 =  #org2*100#<BR>
org3 =  #org3*100#<BR>
org4 =  #org4*100#<BR>
org5 = #org5*100#<BR>
#team#.............#(org1 + org2 + org3 + org4 + org5)*100#
 -->
</cfoutput>

<cfif HaToUse Is 'H'>

<cfquery datasource="nba">
Update FGPctHome
set odtppctR1 = #org1*100#,
odtppctR2 = #org2*100#,
odtppctR3 = #org3*100#,
odtppctR4 = #org4*100#,
odtppctR5 = #org5*100#,
udtppctR1 = #urg1*100#,
udtppctR2 = #urg2*100#,
udtppctR3 = #urg3*100#,
udtppctR4 = #urg4*100#,
udtppctR5 = #urg5*100#,
oOveralldTPPCT = #(org1 + org2 + org3 + org4 + org5)*100#,
uOveralldTPPCT = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 

<cfelse>

<cfquery datasource="nba">
Update FGPctAway
set odtppctR1 = #org1*100#,
odtppctR2 = #org2*100#,
odtppctR3 = #org3*100#,
odtppctR4 = #org4*100#,
odtppctR5 = #org5*100#,
udtppctR1 = #urg1*100#,
udtppctR2 = #urg2*100#,
udtppctR3 = #urg3*100#,
udtppctR4 = #urg4*100#,
udtppctR5 = #urg5*100#,
oOveralldTPPCT = #(org1 + org2 + org3 + org4 + org5)*100#,
uOveralldTPPCT = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 


</cfif>


<cfset urg1 = 0>
<cfset urg2 = 0>
<cfset urg3 = 0>
<cfset urg4 = 0>
<cfset urg5 = 0>

<cfset org1 = 0>
<cfset org2 = 0>
<cfset org3 = 0>
<cfset org4 = 0>
<cfset org5 = 0>

<cfset loopct = 0>

<cfoutput query="Getit">

<cfif round(dfgpct) ge 0 and round(dfgpct) le 3>
	<cfset org1 = org1 + 1>
</cfif>

<cfif round(dfgpct) ge 4 and round(dfgpct) le 6.0>
	<cfset org2 = org2 + 1>
</cfif>

<cfif round(dfgpct) ge 7 and round(dfgpct) le 9.0>
	<cfset org3 = org3 + 1>
</cfif>

<cfif round(dfgpct) ge 10 and round(dfgpct) le 12.0>
	<cfset org4 = org4 + 1>
</cfif>

<cfif round(dfgpct) ge 13>
	<cfset org5 = org5 + 1>
</cfif>

<cfif round(dfgpct) le -1  and round(dfgpct) ge -3>
	<cfset urg1 = urg1 + 1>
</cfif>

<cfif round(dfgpct) le -4 and round(dfgpct) ge -6.0>
	<cfset urg2 = urg2 + 1>
</cfif>

<cfif round(dfgpct) le -7 and round(dfgpct) ge -9.0>
	<cfset urg3 = urg3 + 1>
</cfif>

<cfif round(dfgpct) le -10 and round(dfgpct) ge -12.0>
	<cfset urg4 = urg4 + 1>
</cfif>

<cfif round(dfgpct) le -13>
	<cfset urg5 = urg5 + 1>
</cfif>

<cfset loopct = loopct + 1>
</cfoutput>

<cfoutput>
<cfset urg1 = urg1/loopct>
<cfset urg2 =  urg2/loopct>
<cfset urg3 =  urg3/loopct>
<cfset urg4 =  urg4/loopct>
<cfset urg5 = urg5/loopct>

<cfset org1 = org1/loopct>
<cfset org2 =  org2/loopct>
<cfset org3 =  org3/loopct>
<cfset org4 =  org4/loopct>
<cfset org5 = org5/loopct>

<!--  
Defense....<br>
urg1 = #urg1*100#<BR>
urg2 =  #urg2*100#<BR>
urg3 =  #urg3*100#<BR>
urg4 =  #urg4*100#<BR>
urg5 = #urg5*100#<BR>
#team#.............#(urg1 + urg2 + urg3 + urg4 + urg5)*100#<br>
-------------------------<BR>
org1 = #org1*100#<BR>
org2 =  #org2*100#<BR>
org3 =  #org3*100#<BR>
org4 =  #org4*100#<BR>
org5 = #org5*100#<BR>
#team#.............#(org1 + org2 + org3 + org4 + org5)*100#
-->
</cfoutput>

<cfif HaToUse is 'H'>

<cfquery datasource="nba">
Update FGPctHome
set odFGPctR1 = #org1*100#,
odFGPctR2 = #org2*100#,
odFGPctR3 = #org3*100#,
odFGPctR4 = #org4*100#,
odFGPctR5 = #org5*100#,
udFGPctR1 = #urg1*100#,
udFGPctR2 = #urg2*100#,
udFGPctR3 = #urg3*100#,
udFGPctR4 = #urg4*100#,
udFGPctR5 = #urg5*100#,
oOveralldFGPct = #(org1 + org2 + org3 + org4 + org5)*100#,
uOveralldFGPct = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 

<cfelse>

<cfquery datasource="nba">
Update FGPctAway
set odFGPctR1 = #org1*100#,
odFGPctR2 = #org2*100#,
odFGPctR3 = #org3*100#,
odFGPctR4 = #org4*100#,
odFGPctR5 = #org5*100#,
udFGPctR1 = #urg1*100#,
udFGPctR2 = #urg2*100#,
udFGPctR3 = #urg3*100#,
udFGPctR4 = #urg4*100#,
udFGPctR5 = #urg5*100#,
oOveralldFGPct = #(org1 + org2 + org3 + org4 + org5)*100#,
uOveralldFGPct = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 

</cfif>




<cfset urg1 = 0>
<cfset urg2 = 0>
<cfset urg3 = 0>
<cfset urg4 = 0>
<cfset urg5 = 0>

<cfset org1 = 0>
<cfset org2 = 0>
<cfset org3 = 0>
<cfset org4 = 0>
<cfset org5 = 0>

<cfset loopct = 0>

<cfoutput query="Getit">

<cfif round(otpm) ge 0 and round(otpm) le 3>
	<cfset org1 = org1 + 1>
</cfif>

<cfif round(otpm) ge 4 and round(otpm) le 6.0>
	<cfset org2 = org2 + 1>
</cfif>

<cfif round(otpm) ge 7 and round(otpm) le 9.0>
	<cfset org3 = org3 + 1>
</cfif>

<cfif round(otpm) ge 10 and round(otpm) le 12.0>
	<cfset org4 = org4 + 1>
</cfif>

<cfif round(otpm) ge 13>
	<cfset org5 = org5 + 1>
</cfif>

<cfif round(otpm) le -1  and round(otpm) ge -3>
	<cfset urg1 = urg1 + 1>
</cfif>

<cfif round(otpm) le -4 and round(otpm) ge -6.0>
	<cfset urg2 = urg2 + 1>
</cfif>

<cfif round(otpm) le -7 and round(otpm) ge -9.0>
	<cfset urg3 = urg3 + 1>
</cfif>

<cfif round(otpm) le -10 and round(otpm) ge -12.0>
	<cfset urg4 = urg4 + 1>
</cfif>

<cfif round(otpm) le -13>
	<cfset urg5 = urg5 + 1>
</cfif>

<cfset loopct = loopct + 1>
</cfoutput>

<cfoutput>
<cfset urg1 = urg1/loopct>
<cfset urg2 =  urg2/loopct>
<cfset urg3 =  urg3/loopct>
<cfset urg4 =  urg4/loopct>
<cfset urg5 = urg5/loopct>

<cfset org1 = org1/loopct>
<cfset org2 =  org2/loopct>
<cfset org3 =  org3/loopct>
<cfset org4 =  org4/loopct>
<cfset org5 = org5/loopct>

<!-- 
Defense....<br>
urg1 = #urg1*100#<BR>
urg2 =  #urg2*100#<BR>
urg3 =  #urg3*100#<BR>
urg4 =  #urg4*100#<BR>
urg5 = #urg5*100#<BR>
#team#.............#(urg1 + urg2 + urg3 + urg4 + urg5)*100#<br>
-------------------------<BR>
org1 = #org1*100#<BR>
org2 =  #org2*100#<BR>
org3 =  #org3*100#<BR>
org4 =  #org4*100#<BR>
org5 = #org5*100#<BR>
#team#.............#(org1 + org2 + org3 + org4 + org5)*100#
 -->
</cfoutput>


<cfif HaToUse is 'H'>

<cfquery datasource="nba">
Update FGPctHome
set otpmR1 = #org1*100#,
otpmR2 = #org2*100#,
otpmR3 = #org3*100#,
otpmR4 = #org4*100#,
otpmR5 = #org5*100#,
utpmR1 = #urg1*100#,
utpmR2 = #urg2*100#,
utpmR3 = #urg3*100#,
utpmR4 = #urg4*100#,
utpmR5 = #urg5*100#,
oOverallTPM = #(org1 + org2 + org3 + org4 + org5)*100#,
uOverallTPM = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 


<cfelse>


<cfquery datasource="nba">
Update FGPctAway
set otpmR1 = #org1*100#,
otpmR2 = #org2*100#,
otpmR3 = #org3*100#,
otpmR4 = #org4*100#,
otpmR5 = #org5*100#,
utpmR1 = #urg1*100#,
utpmR2 = #urg2*100#,
utpmR3 = #urg3*100#,
utpmR4 = #urg4*100#,
utpmR5 = #urg5*100#,
oOverallTPM = #(org1 + org2 + org3 + org4 + org5)*100#,
uOverallTPM = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 



</cfif>











<cfset urg1 = 0>
<cfset urg2 = 0>
<cfset urg3 = 0>
<cfset urg4 = 0>
<cfset urg5 = 0>

<cfset org1 = 0>
<cfset org2 = 0>
<cfset org3 = 0>
<cfset org4 = 0>
<cfset org5 = 0>

<cfset loopct = 0>

<cfoutput query="Getit">

<cfif round(otpa) ge 0 and round(otpa) le 3>
	<cfset org1 = org1 + 1>
</cfif>

<cfif round(otpa) ge 4 and round(otpa) le 6.0>
	<cfset org2 = org2 + 1>
</cfif>

<cfif round(otpa) ge 7 and round(otpa) le 9.0>
	<cfset org3 = org3 + 1>
</cfif>

<cfif round(otpa) ge 10 and round(otpa) le 12.0>
	<cfset org4 = org4 + 1>
</cfif>

<cfif round(otpa) ge 13>
	<cfset org5 = org5 + 1>
</cfif>

<cfif round(otpa) le -1  and round(otpa) ge -3>
	<cfset urg1 = urg1 + 1>
</cfif>

<cfif round(otpa) le -4 and round(otpa) ge -6.0>
	<cfset urg2 = urg2 + 1>
</cfif>

<cfif round(otpa) le -7 and round(otpa) ge -9.0>
	<cfset urg3 = urg3 + 1>
</cfif>

<cfif round(otpa) le -10 and round(otpa) ge -12.0>
	<cfset urg4 = urg4 + 1>
</cfif>

<cfif round(otpa) le -13>
	<cfset urg5 = urg5 + 1>
</cfif>

<cfset loopct = loopct + 1>
</cfoutput>

<cfoutput>
<cfset urg1 = urg1/loopct>
<cfset urg2 =  urg2/loopct>
<cfset urg3 =  urg3/loopct>
<cfset urg4 =  urg4/loopct>
<cfset urg5 = urg5/loopct>

<cfset org1 = org1/loopct>
<cfset org2 =  org2/loopct>
<cfset org3 =  org3/loopct>
<cfset org4 =  org4/loopct>
<cfset org5 = org5/loopct>

<!-- 
Offense....<br>
urg1 = #urg1*100#<BR>
urg2 =  #urg2*100#<BR>
urg3 =  #urg3*100#<BR>
urg4 =  #urg4*100#<BR>
urg5 = #urg5*100#<BR>
#team#.............#(urg1 + urg2 + urg3 + urg4 + urg5)*100#<br>
-------------------------<BR>
org1 = #org1*100#<BR>
org2 =  #org2*100#<BR>
org3 =  #org3*100#<BR>
org4 =  #org4*100#<BR>
org5 = #org5*100#<BR>
#team#.............#(org1 + org2 + org3 + org4 + org5)*100#
 -->
</cfoutput>

<cfif HaToUse is 'H'>

<cfquery datasource="nba">
Update FGPctHome
set otpaR1 = #org1*100#,
otpaR2 = #org2*100#,
otpaR3 = #org3*100#,
otpaR4 = #org4*100#,
otpaR5 = #org5*100#,
utpaR1 = #urg1*100#,
utpaR2 = #urg2*100#,
utpaR3 = #urg3*100#,
utpaR4 = #urg4*100#,
utpaR5 = #urg5*100#,
oOverallTPA = #(org1 + org2 + org3 + org4 + org5)*100#,
uOverallTPA = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 


<cfelse>
<cfquery datasource="nba">
Update FGPctAway
set otpaR1 = #org1*100#,
otpaR2 = #org2*100#,
otpaR3 = #org3*100#,
otpaR4 = #org4*100#,
otpaR5 = #org5*100#,
utpaR1 = #urg1*100#,
utpaR2 = #urg2*100#,
utpaR3 = #urg3*100#,
utpaR4 = #urg4*100#,
utpaR5 = #urg5*100#,
oOverallTPA = #(org1 + org2 + org3 + org4 + org5)*100#,
uOverallTPA = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 

</cfif>





<cfset urg1 = 0>
<cfset urg2 = 0>
<cfset urg3 = 0>
<cfset urg4 = 0>
<cfset urg5 = 0>

<cfset org1 = 0>
<cfset org2 = 0>
<cfset org3 = 0>
<cfset org4 = 0>
<cfset org5 = 0>

<cfset loopct = 0>

<cfoutput query="Getit">

<cfif round(ofta) ge 0 and round(ofta) le 3>
	<cfset org1 = org1 + 1>
</cfif>

<cfif round(ofta) ge 4 and round(ofta) le 6.0>
	<cfset org2 = org2 + 1>
</cfif>

<cfif round(ofta) ge 7 and round(ofta) le 9.0>
	<cfset org3 = org3 + 1>
</cfif>

<cfif round(ofta) ge 10 and round(ofta) le 12.0>
	<cfset org4 = org4 + 1>
</cfif>

<cfif round(ofta) ge 13>
	<cfset org5 = org5 + 1>
</cfif>

<cfif round(ofta) le -1  and round(ofta) ge -3>
	<cfset urg1 = urg1 + 1>
</cfif>

<cfif round(ofta) le -4 and round(ofta) ge -6.0>
	<cfset urg2 = urg2 + 1>
</cfif>

<cfif round(ofta) le -7 and round(ofta) ge -9.0>
	<cfset urg3 = urg3 + 1>
</cfif>

<cfif round(ofta) le -10 and round(ofta) ge -12.0>
	<cfset urg4 = urg4 + 1>
</cfif>

<cfif round(ofta) le -13>
	<cfset urg5 = urg5 + 1>
</cfif>

<cfset loopct = loopct + 1>
</cfoutput>

<cfoutput>
<cfset urg1 = urg1/loopct>
<cfset urg2 =  urg2/loopct>
<cfset urg3 =  urg3/loopct>
<cfset urg4 =  urg4/loopct>
<cfset urg5 = urg5/loopct>

<cfset org1 = org1/loopct>
<cfset org2 =  org2/loopct>
<cfset org3 =  org3/loopct>
<cfset org4 =  org4/loopct>
<cfset org5 = org5/loopct>
<!--  
Offense....<br>
urg1 = #urg1*100#<BR>
urg2 =  #urg2*100#<BR>
urg3 =  #urg3*100#<BR>
urg4 =  #urg4*100#<BR>
urg5 = #urg5*100#<BR>
#team#.............#(urg1 + urg2 + urg3 + urg4 + urg5)*100#<br>
-------------------------<BR>
org1 = #org1*100#<BR>
org2 =  #org2*100#<BR>
org3 =  #org3*100#<BR>
org4 =  #org4*100#<BR>
org5 = #org5*100#<BR>
#team#.............#(org1 + org2 + org3 + org4 + org5)*100#
-->
</cfoutput>

<cfif HaToUse is 'H'>

<cfquery datasource="nba">
Update FGPctHome
set oftaR1 = #org1*100#,
oftaR2 = #org2*100#,
oftaR3 = #org3*100#,
oftaR4 = #org4*100#,
oftaR5 = #org5*100#,
uftaR1 = #urg1*100#,
uftaR2 = #urg2*100#,
uftaR3 = #urg3*100#,
uftaR4 = #urg4*100#,
uftaR5 = #urg5*100#,
oOverallfta = #(org1 + org2 + org3 + org4 + org5)*100#,
uOverallfta = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 

<cfelse>

<cfquery datasource="nba">
Update FGPctAway
set oftaR1 = #org1*100#,
oftaR2 = #org2*100#,
oftaR3 = #org3*100#,
oftaR4 = #org4*100#,
oftaR5 = #org5*100#,
uftaR1 = #urg1*100#,
uftaR2 = #urg2*100#,
uftaR3 = #urg3*100#,
uftaR4 = #urg4*100#,
uftaR5 = #urg5*100#,
oOverallfta = #(org1 + org2 + org3 + org4 + org5)*100#,
uOverallfta = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 

</cfif>




<cfset urg1 = 0>
<cfset urg2 = 0>
<cfset urg3 = 0>
<cfset urg4 = 0>
<cfset urg5 = 0>

<cfset org1 = 0>
<cfset org2 = 0>
<cfset org3 = 0>
<cfset org4 = 0>
<cfset org5 = 0>

<cfset loopct = 0>

<cfoutput query="Getit">

<cfif round(dfta) ge 0 and round(dfta) le 3>
	<cfset org1 = org1 + 1>
</cfif>

<cfif round(dfta) ge 4 and round(dfta) le 6.0>
	<cfset org2 = org2 + 1>
</cfif>

<cfif round(dfta) ge 7 and round(dfta) le 9.0>
	<cfset org3 = org3 + 1>
</cfif>

<cfif round(dfta) ge 10 and round(dfta) le 12.0>
	<cfset org4 = org4 + 1>
</cfif>

<cfif round(dfta) ge 13>
	<cfset org5 = org5 + 1>
</cfif>

<cfif round(dfta) le -1  and round(dfta) ge -3>
	<cfset urg1 = urg1 + 1>
</cfif>

<cfif round(dfta) le -4 and round(dfta) ge -6.0>
	<cfset urg2 = urg2 + 1>
</cfif>

<cfif round(dfta) le -7 and round(dfta) ge -9.0>
	<cfset urg3 = urg3 + 1>
</cfif>

<cfif round(dfta) le -10 and round(dfta) ge -12.0>
	<cfset urg4 = urg4 + 1>
</cfif>

<cfif round(dfta) le -13>
	<cfset urg5 = urg5 + 1>
</cfif>

<cfset loopct = loopct + 1>
</cfoutput>

<cfoutput>
<cfset urg1 = urg1/loopct>
<cfset urg2 =  urg2/loopct>
<cfset urg3 =  urg3/loopct>
<cfset urg4 =  urg4/loopct>
<cfset urg5 = urg5/loopct>

<cfset org1 = org1/loopct>
<cfset org2 =  org2/loopct>
<cfset org3 =  org3/loopct>
<cfset org4 =  org4/loopct>
<cfset org5 = org5/loopct>

<!-- 
Defense....<br>
urg1 = #urg1*100#<BR>
urg2 =  #urg2*100#<BR>
urg3 =  #urg3*100#<BR>
urg4 =  #urg4*100#<BR>
urg5 = #urg5*100#<BR>
#team#.............#(urg1 + urg2 + urg3 + urg4 + urg5)*100#<br>
-------------------------<BR>
org1 = #org1*100#<BR>
org2 =  #org2*100#<BR>
org3 =  #org3*100#<BR>
org4 =  #org4*100#<BR>
org5 = #org5*100#<BR>
#team#.............#(org1 + org2 + org3 + org4 + org5)*100#
 -->
</cfoutput>


<cfif HaToUse is 'H'>

<cfquery datasource="nba">
Update FGPctHome
set odftaR1 = #org1*100#,
odftaR2 = #org2*100#,
odftaR3 = #org3*100#,
odftaR4 = #org4*100#,
odftaR5 = #org5*100#,
udftaR1 = #urg1*100#,
udftaR2 = #urg2*100#,
udftaR3 = #urg3*100#,
udftaR4 = #urg4*100#,
udftaR5 = #urg5*100#,
oOveralldfta = #(org1 + org2 + org3 + org4 + org5)*100#,
uOveralldfta = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 


<cfelse>

<cfquery datasource="nba">
Update FGPctAway
set odftaR1 = #org1*100#,
odftaR2 = #org2*100#,
odftaR3 = #org3*100#,
odftaR4 = #org4*100#,
odftaR5 = #org5*100#,
udftaR1 = #urg1*100#,
udftaR2 = #urg2*100#,
udftaR3 = #urg3*100#,
udftaR4 = #urg4*100#,
udftaR5 = #urg5*100#,
oOveralldfta = #(org1 + org2 + org3 + org4 + org5)*100#,
uOveralldfta = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 


</cfif>









<cfquery datasource="nba" name="GetAvg">
Select Avg(ofgpct) as avgofgpct,Avg(dfgpct) as avgdfgpct
from nbadata
where team = '#team#'
</cfquery>




<cfset urg1 = 0>
<cfset urg2 = 0>
<cfset urg3 = 0>
<cfset urg4 = 0>
<cfset urg5 = 0>

<cfset org1 = 0>
<cfset org2 = 0>
<cfset org3 = 0>
<cfset org4 = 0>
<cfset org5 = 0>

<cfset loopct = 0>

<cfoutput query="Getit">

<cfif round(dtpa) ge 0 and round(dtpa) le 3>
	<cfset org1 = org1 + 1>
</cfif>

<cfif round(dtpa) ge 4 and round(dtpa) le 6.0>
	<cfset org2 = org2 + 1>
</cfif>

<cfif round(dtpa) ge 7 and round(dtpa) le 9.0>
	<cfset org3 = org3 + 1>
</cfif>

<cfif round(dtpa) ge 10 and round(dtpa) le 12.0>
	<cfset org4 = org4 + 1>
</cfif>

<cfif round(dtpa) ge 13>
	<cfset org5 = org5 + 1>
</cfif>

<cfif round(dtpa) le -1  and round(dtpa) ge -3>
	<cfset urg1 = urg1 + 1>
</cfif>

<cfif round(dtpa) le -4 and round(dtpa) ge -6.0>
	<cfset urg2 = urg2 + 1>
</cfif>

<cfif round(dtpa) le -7 and round(dtpa) ge -9.0>
	<cfset urg3 = urg3 + 1>
</cfif>

<cfif round(dtpa) le -10 and round(dtpa) ge -12.0>
	<cfset urg4 = urg4 + 1>
</cfif>

<cfif round(dtpa) le -13>
	<cfset urg5 = urg5 + 1>
</cfif>

<cfset loopct = loopct + 1>
</cfoutput>

<cfoutput>
<cfset urg1 = urg1/loopct>
<cfset urg2 =  urg2/loopct>
<cfset urg3 =  urg3/loopct>
<cfset urg4 =  urg4/loopct>
<cfset urg5 = urg5/loopct>

<cfset org1 = org1/loopct>
<cfset org2 =  org2/loopct>
<cfset org3 =  org3/loopct>
<cfset org4 =  org4/loopct>
<cfset org5 = org5/loopct>
</cfoutput>

<cfif HaToUse is 'H'>

<cfquery datasource="nba">
Update FGPctHome
set odtpaR1 = #org1*100#,
odtpaR2 = #org2*100#,
odtpaR3 = #org3*100#,
odtpaR4 = #org4*100#,
odtpaR5 = #org5*100#,
udtpaR1 = #urg1*100#,
udtpaR2 = #urg2*100#,
udtpaR3 = #urg3*100#,
udtpaR4 = #urg4*100#,
udtpaR5 = #urg5*100#,
oOveralldtpa = #(org1 + org2 + org3 + org4 + org5)*100#,
uOveralldtpa = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 

<cfelse>

<cfquery datasource="nba">
Update FGPctAway
set odtpaR1 = #org1*100#,
odtpaR2 = #org2*100#,
odtpaR3 = #org3*100#,
odtpaR4 = #org4*100#,
odtpaR5 = #org5*100#,
udtpaR1 = #urg1*100#,
udtpaR2 = #urg2*100#,
udtpaR3 = #urg3*100#,
udtpaR4 = #urg4*100#,
udtpaR5 = #urg5*100#,
oOveralldtpa = #(org1 + org2 + org3 + org4 + org5)*100#,
uOveralldtpa = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 

</cfif>



















<cfset urg1 = 0>
<cfset urg2 = 0>
<cfset urg3 = 0>
<cfset urg4 = 0>
<cfset urg5 = 0>

<cfset org1 = 0>
<cfset org2 = 0>
<cfset org3 = 0>
<cfset org4 = 0>
<cfset org5 = 0>

<cfset loopct = 0>

<cfoutput query="Getit">

<cfif round(dfga) ge 0 and round(dfga) le 3>
	<cfset org1 = org1 + 1>
</cfif>

<cfif round(dfga) ge 4 and round(dfga) le 6.0>
	<cfset org2 = org2 + 1>
</cfif>

<cfif round(dfga) ge 7 and round(dfga) le 9.0>
	<cfset org3 = org3 + 1>
</cfif>

<cfif round(dfga) ge 10 and round(dfga) le 12.0>
	<cfset org4 = org4 + 1>
</cfif>

<cfif round(dfga) ge 13>
	<cfset org5 = org5 + 1>
</cfif>

<cfif round(dfga) le -1  and round(dfga) ge -3>
	<cfset urg1 = urg1 + 1>
</cfif>

<cfif round(dfga) le -4 and round(dfga) ge -6.0>
	<cfset urg2 = urg2 + 1>
</cfif>

<cfif round(dfga) le -7 and round(dfga) ge -9.0>
	<cfset urg3 = urg3 + 1>
</cfif>

<cfif round(dfga) le -10 and round(dfga) ge -12.0>
	<cfset urg4 = urg4 + 1>
</cfif>

<cfif round(dfga) le -13>
	<cfset urg5 = urg5 + 1>
</cfif>

<cfset loopct = loopct + 1>
</cfoutput>

<cfoutput>
<cfset urg1 = urg1/loopct>
<cfset urg2 =  urg2/loopct>
<cfset urg3 =  urg3/loopct>
<cfset urg4 =  urg4/loopct>
<cfset urg5 = urg5/loopct>

<cfset org1 = org1/loopct>
<cfset org2 =  org2/loopct>
<cfset org3 =  org3/loopct>
<cfset org4 =  org4/loopct>
<cfset org5 = org5/loopct>
</cfoutput>


<cfquery datasource="nba" name="GetAvg">
Select Avg(ofgpct) as avgofgpct,Avg(dfgpct) as avgdfgpct, avg(ofga) as avgofga, avg(dfga) as avgdfga
from nbadata
where team = '#team#'
</cfquery>

<cfif HaToUse is 'H'>

<cfquery datasource="nba">
Update FGPctHome
set odFGAR1 = #org1*100#,
odFGAR2 = #org2*100#,
odFGAR3 = #org3*100#,
odFGAR4 = #org4*100#,
odFGAR5 = #org5*100#,
udFGAR1 = #urg1*100#,
udFGAR2 = #urg2*100#,
udFGAR3 = #urg3*100#,
udFGAR4 = #urg4*100#,
udFGAR5 = #urg5*100#,
oOveralldFGA = #(org1 + org2 + org3 + org4 + org5)*100#,
uOveralldFGA = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 


<cfelse>

<cfquery datasource="nba">
Update FGPctAway
set odFGAR1 = #org1*100#,
odFGAR2 = #org2*100#,
odFGAR3 = #org3*100#,
odFGAR4 = #org4*100#,
odFGAR5 = #org5*100#,
udFGAR1 = #urg1*100#,
udFGAR2 = #urg2*100#,
udFGAR3 = #urg3*100#,
udFGAR4 = #urg4*100#,
udFGAR5 = #urg5*100#,
oOveralldFGA = #(org1 + org2 + org3 + org4 + org5)*100#,
uOveralldFGA = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 


</cfif>







<cfset urg1 = 0>
<cfset urg2 = 0>
<cfset urg3 = 0>
<cfset urg4 = 0>
<cfset urg5 = 0>

<cfset org1 = 0>
<cfset org2 = 0>
<cfset org3 = 0>
<cfset org4 = 0>
<cfset org5 = 0>

<cfset loopct = 0>

<cfoutput query="Getit">

<cfif round(ofga) ge 0 and round(ofga) le 3>
	<cfset org1 = org1 + 1>
</cfif>

<cfif round(ofga) ge 4 and round(ofga) le 6.0>
	<cfset org2 = org2 + 1>
</cfif>

<cfif round(ofga) ge 7 and round(ofga) le 9.0>
	<cfset org3 = org3 + 1>
</cfif>

<cfif round(ofga) ge 10 and round(ofga) le 12.0>
	<cfset org4 = org4 + 1>
</cfif>

<cfif round(ofga) ge 13>
	<cfset org5 = org5 + 1>
</cfif>

<cfif round(ofga) le -1  and round(ofga) ge -3>
	<cfset urg1 = urg1 + 1>
</cfif>

<cfif round(ofga) le -4 and round(ofga) ge -6.0>
	<cfset urg2 = urg2 + 1>
</cfif>

<cfif round(ofga) le -7 and round(ofga) ge -9.0>
	<cfset urg3 = urg3 + 1>
</cfif>

<cfif round(ofga) le -10 and round(ofga) ge -12.0>
	<cfset urg4 = urg4 + 1>
</cfif>

<cfif round(ofga) le -13>
	<cfset urg5 = urg5 + 1>
</cfif>

<cfset loopct = loopct + 1>
</cfoutput>

<cfoutput>
<cfset urg1 = urg1/loopct>
<cfset urg2 =  urg2/loopct>
<cfset urg3 =  urg3/loopct>
<cfset urg4 =  urg4/loopct>
<cfset urg5 = urg5/loopct>

<cfset org1 = org1/loopct>
<cfset org2 =  org2/loopct>
<cfset org3 =  org3/loopct>
<cfset org4 =  org4/loopct>
<cfset org5 = org5/loopct>

</cfoutput>


<cfquery datasource="nba" name="GetAvg">
Select Avg(ofgpct) as avgofgpct,Avg(dfgpct) as avgdfgpct, avg(ofga) as avgofga, avg(dfga) as avgdfga
from nbadata
where team = '#team#'
</cfquery>

<cfif HaToUse is 'H'>

<cfquery datasource="nba">
Update FGPctHome
set oFGAR1 = #org1*100#,
oFGAR2 = #org2*100#,
oFGAR3 = #org3*100#,
oFGAR4 = #org4*100#,
oFGAR5 = #org5*100#,
uFGAR1 = #urg1*100#,
uFGAR2 = #urg2*100#,
uFGAR3 = #urg3*100#,
uFGAR4 = #urg4*100#,
uFGAR5 = #urg5*100#,
oOverallFGA = #(org1 + org2 + org3 + org4 + org5)*100#,
uOverallFGA = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 

<cfelse>

<cfquery datasource="nba">
Update FGPctAway
set oFGAR1 = #org1*100#,
oFGAR2 = #org2*100#,
oFGAR3 = #org3*100#,
oFGAR4 = #org4*100#,
oFGAR5 = #org5*100#,
uFGAR1 = #urg1*100#,
uFGAR2 = #urg2*100#,
uFGAR3 = #urg3*100#,
uFGAR4 = #urg4*100#,
uFGAR5 = #urg5*100#,
oOverallFGA = #(org1 + org2 + org3 + org4 + org5)*100#,
uOverallFGA = #(urg1 + urg2 + urg3 + urg4 + urg5)*100#
where team = '#team#'
</cfquery> 


</cfif>
</cfloop>



<cfif HaToUse is 'H'>

<cfquery datasource="nba"  name="GetIt">
Select * from FGPctHome order by team
</cfquery>

<cfelse>

<cfquery datasource="nba"  name="GetIt">
Select * from FGPctAway order by team
</cfquery>

</cfif>

<cfoutput query="Getit">
<cfset oval = 0>
<cfset uval=0>

<cfif oOveralldTppct gt uOveralldTPPCT>
	<cfset oval = ((odTPPCTR1 * 1.5) + (odTPPCTR2 * 5) + (odTPPCTR3 * 8) + (odTPPCTR4 * 11) + (odTPPCTR5 * 15)) /100>
<cfelse> 
	<cfset uval = ((udTPPCTR1 * 1.5) + (udTPPCTR2 * 5) + (udTPPCTR3 * 8) + (udTPPCTR4 * 11) + (udTPPCTR5 * 15))/100> 
</cfif>

<cfset useval = -1*uval>
<cfif oval gt uval>
	<cfset useval = oval>
</cfif> 

<cfif HaToUse is 'H'>

<cfquery datasource="nba">
Update FGPctHome
Set dTPPCTPowPct = #useval# 
Where team = '#team#'
</cfquery>


<cfelse>
<cfquery datasource="nba">
Update FGPctAway
Set dTPPCTPowPct = #useval# 
Where team = '#team#'
</cfquery>

</cfif>
</cfoutput>


<cfoutput query="Getit">
<cfset oval = 0>
<cfset uval=0>

<cfif oOverallTppct gt uOverallTPPCT>
	<cfset oval = ((oTPPCTR1 * 1.5) + (oTPPCTR2 * 5) + (oTPPCTR3 * 8) + (oTPPCTR4 * 11) + (oTPPCTR5 * 15)) /100>
<cfelse> 
	<cfset uval = ((uTPPCTR1 * 1.5) + (uTPPCTR2 * 5) + (uTPPCTR3 * 8) + (uTPPCTR4 * 11) + (uTPPCTR5 * 15))/100> 
</cfif>

<cfset useval = -1*uval>
<cfif oval gt uval>
	<cfset useval = oval>
</cfif> 

<cfif HaToUse is 'H'>

<cfquery datasource="nba">
Update FGPctHome
Set TPPCTPowPct = #useval# 
Where team = '#team#'
</cfquery>

<cfelse>

<cfquery datasource="nba">
Update FGPctAway
Set TPPCTPowPct = #useval# 
Where team = '#team#'
</cfquery>
</cfif>

</cfoutput>




<cfoutput query="Getit">
<cfset oval = 0>
<cfset uval=0>

<cfif oOverallFGPct gt uOverallFGPct>
	<cfset oval = ((oFGPCTR1 * 1.5) + (oFGPCTR2 * 5) + (oFGPCTR3 * 8) + (oFGPCTR4 * 11) + (oFGPCTR5 * 15)) /100>
<cfelse> 
	<cfset uval = ((uFGPCTR1 * 1.5) + (uFGPCTR2 * 5) + (uFGPCTR3 * 8) + (uFGPCTR4 * 11) + (uFGPCTR5 * 15))/100> 
</cfif>

<cfset useval = -1*uval>
<cfif oval gt uval>
	<cfset useval = oval>
</cfif> 

<cfif HaToUse is 'H'>

<cfquery datasource="nba">
Update FGPctHome
Set FGPctPowPct = #useval# 
Where team = '#team#'
</cfquery>

<cfelse>
<cfquery datasource="nba">
Update FGPctAway
Set FGPctPowPct = #useval# 
Where team = '#team#'
</cfquery>
</cfif>
</cfoutput>


<cfoutput query="Getit">
<cfset oval = 0>
<cfset uval=0>

<cfif oOverallDFGPct gt uOverallDFGPct>
	<cfset oval = ((odFGPCTR1 * 1.5) + (odFGPCTR2 * 5) + (odFGPCTR3 * 8) + (odFGPCTR4 * 11) + (odFGPCTR5 * 15)) /100>
<cfelse> 
	<cfset uval = ((udFGPCTR1 * 1.5) + (udFGPCTR2 * 5) + (udFGPCTR3 * 8) + (udFGPCTR4 * 11) + (udFGPCTR5 * 15))/100> 
</cfif>

<cfset useval = -1*uval>
<cfif oval gt uval>
	<cfset useval = oval>
</cfif> 

<cfif HaToUse is 'H'>

<cfquery datasource="nba">
Update FGPctHome
Set DFGPctPowPct = #useval# 
Where team = '#team#'
</cfquery>

<cfelse>
<cfquery datasource="nba">
Update FGPctAway
Set DFGPctPowPct = #useval# 
Where team = '#team#'
</cfquery>


</cfif>

</cfoutput>




















<cfoutput query="Getit">
<cfset oval = 0>
<cfset uval=0>

<cfif oOverallFGA gt uOverallFGA>
	<cfset oval = ((oFGaR1 * 1.5) + (oFGaR2 * 5) + (oFGaR3 * 8) + (oFGaR4 * 11) + (oFGaR5 * 15)) /100>
<cfelse> 
	<cfset uval = ((uFGaR1 * 1.5) + (uFGaR2 * 5) + (uFGaR3 * 8) + (uFGaR4 * 11) + (uFGaR5 * 15))/100> 
</cfif>

<cfset useval = -1*uval>
<cfif oval gt uval>
	<cfset useval = oval>
</cfif> 

<cfif Hatouse is 'H'>

<cfquery datasource="nba">
Update FGPctHome
Set FGAPowPct = #useval# 
Where team = '#team#'
</cfquery>

<cfelse>

<cfquery datasource="nba">
Update FGPctAway
Set FGAPowPct = #useval# 
Where team = '#team#'
</cfquery>


</cfif>

</cfoutput>


<cfoutput query="Getit">
<cfset oval = 0>
<cfset uval=0>

<cfif oOverallDFGA gt uOverallDFGA>
	<cfset oval = ((odFGaR1 * 1.5) + (odFGaR2 * 5) + (odFGaR3 * 8) + (odFGaR4 * 11) + (odFGaR5 * 15)) /100>
<cfelse> 
	<cfset uval = ((udFGaR1 * 1.5) + (udFGaR2 * 5) + (udFGaR3 * 8) + (udFGaR4 * 11) + (udFGaR5 * 15))/100> 
</cfif>

<cfset useval = -1*uval>
<cfif oval gt uval>
	<cfset useval = oval>
</cfif> 

<cfif Hatouse is 'H'>
<cfquery datasource="nba">
Update FGPctHome
Set DFGAPowPct = #useval# 
Where team = '#team#'
</cfquery>

<cfelse>
<cfquery datasource="nba">
Update FGPctAway
Set DFGAPowPct = #useval# 
Where team = '#team#'
</cfquery>
</cfif>

</cfoutput>




<cfoutput query="Getit">
<cfset oval = 0>
<cfset uval=0>

<cfif oOverallTPA gt uOverallTPA>
	<cfset oval = ((oTPaR1 * 1.5) + (oTPaR2 * 5) + (oTPaR3 * 8) + (oTPaR4 * 11) + (oTPaR5 * 15)) /100>
<cfelse> 
	<cfset uval = ((uTPaR1 * 1.5) + (uTPaR2 * 5) + (uTPaR3 * 8) + (uTPaR4 * 11) + (uTPaR5 * 15))/100> 
</cfif>

<cfset useval = -1*uval>
<cfif oval gt uval>
	<cfset useval = oval>
</cfif> 

<cfif Hatouse is 'H'>
<cfquery datasource="nba">
Update FGPctHome
Set TPAPowPct = #useval# 
Where team = '#team#'
</cfquery>

<cfelse>
<cfquery datasource="nba">
Update FGPctAway
Set TPAPowPct = #useval# 
Where team = '#team#'
</cfquery>
</cfif>
</cfoutput>

<cfoutput query="Getit">
<cfset oval = 0>
<cfset uval=0>

<cfif oOveralldTPA gt uOveralldTPA>
	<cfset oval = ((odTPaR1 * 1.5) + (odTPaR2 * 5) + (odTPaR3 * 8) + (odTPaR4 * 11) + (odTPaR5 * 15)) /100>
<cfelse> 
	<cfset uval = ((udTPaR1 * 1.5) + (udTPaR2 * 5) + (udTPaR3 * 8) + (udTPaR4 * 11) + (udTPaR5 * 15))/100> 
</cfif>

<cfset useval = -1*uval>
<cfif oval gt uval>
	<cfset useval = oval>
</cfif> 

<cfif Hatouse is 'H'>
<cfquery datasource="nba">
Update FGPctHome
Set dTPAPowPct = #useval# 
Where team = '#team#'
</cfquery>

<cfelse>
<cfquery datasource="nba">
Update FGPctAway
Set dTPAPowPct = #useval# 
Where team = '#team#'
</cfquery>

</cfif>

</cfoutput>

<cfoutput query="Getit">
<cfset oval = 0>
<cfset uval=0>

<cfif oOverallFTA gt uOverallFTA>
	<cfset oval = ((oFTAR1 * 1.5) + (oFTAR2 * 5) + (oFTAR3 * 8) + (oFTAR4 * 11) + (oFTAR5 * 15)) /100>
<cfelse> 
	<cfset uval = ((uFTAR1 * 1.5) + (uFTAR2 * 5) + (uFTAR3 * 8) + (uFTAR4 * 11) + (uFTAR5 * 15))/100> 
</cfif>

<cfset useval = -1*uval>
<cfif oval gt uval>
	<cfset useval = oval>
</cfif> 

<cfif Hatouse is 'H'>
<cfquery datasource="nba">
Update FGPctHome
Set FTAPowPct = #useval# 
Where team = '#team#'
</cfquery>

<cfelse>
<cfquery datasource="nba">
Update FGPctAway
Set FTAPowPct = #useval# 
Where team = '#team#'
</cfquery>


</cfif>

</cfoutput>


<cfoutput query="Getit">
<cfset oval = 0>
<cfset uval=0>

<cfif oOveralldFTA gt uOveralldFTA>
	<cfset oval = ((odFTAR1 * 1.5) + (odFTAR2 * 5) + (odFTAR3 * 8) + (odFTAR4 * 11) + (odFTAR5 * 15)) /100>
<cfelse> 
	<cfset uval = ((udFTAR1 * 1.5) + (udFTAR2 * 5) + (udFTAR3 * 8) + (udFTAR4 * 11) + (udFTAR5 * 15))/100> 
</cfif>

<cfset useval = -1*uval>
<cfif oval gt uval>
	<cfset useval = oval>
</cfif> 

<cfif Hatouse is 'H'>
<cfquery datasource="nba">
Update FGPctHome
Set dFTAPowPct = #useval# 
Where team = '#team#'
</cfquery>

<cfelse>
<cfquery datasource="nba">
Update FGPctAway
Set dFTAPowPct = #useval# 
Where team = '#team#'
</cfquery>


</cfif>

</cfoutput>



<cfoutput query="Getit">
<cfset oval = 0>
<cfset uval=0>

<cfif oOffRebPct gt uOffRebPct>
	<cfset oval = ((oOffRebR1 * 1.5) + (oOffRebR2 * 5) + (oOffRebR3 * 8) + (oOffRebR4 * 11) + (oOffRebR5 * 15)) /100>
<cfelse> 
	<cfset uval = ((uOffRebR1 * 1.5) + (uOffRebR2 * 5) + (uOffRebR3 * 8) + (uOffRebR4 * 11) + (uOffRebR5 * 15))/100> 
</cfif>

<cfset useval = -1*uval>
<cfif oval gt uval>
	<cfset useval = oval>
</cfif> 

<cfif Hatouse is 'H'>
<cfquery datasource="nba">
Update FGPctHome
Set OffRebPowPct = #useval# 
Where team = '#team#'
</cfquery>

<cfelse>
<cfquery datasource="nba">
Update FGPctAway
Set OffRebPowPct = #useval# 
Where team = '#team#'
</cfquery>


</cfif>

</cfoutput>


<cfoutput query="Getit">
<cfset oval = 0>
<cfset uval=0>

<cfif oDefRebPct gt uDefRebPct>
	<cfset oval = ((oDefRebR1 * 1.5) + (oDefRebR2 * 5) + (oDefRebR3 * 8) + (oDefRebR4 * 11) + (oDefRebR5 * 15)) /100>
<cfelse> 
	<cfset uval = ((uDefRebR1 * 1.5) + (uDefRebR2 * 5) + (uDefRebR3 * 8) + (uDefRebR4 * 11) + (uDefRebR5 * 15))/100> 
</cfif>

<cfset useval = -1*uval>
<cfif oval gt uval>
	<cfset useval = oval>
</cfif> 

<cfif Hatouse is 'H'>
<cfquery datasource="nba">
Update FGPctHome
Set DefRebPowPct = #useval# 
Where team = '#team#'
</cfquery>

<cfelse>
<cfquery datasource="nba">
Update FGPctAway
Set DefRebPowPct = #useval# 
Where team = '#team#'
</cfquery>


</cfif>

</cfoutput>





</cfloop>
</cfif>
















<cfquery datasource="nbaschedule" name="Getspds">
Select *
from nbaschedule
where GameTime = '#mygametime#'
 </cfquery>

<cfset gamect = 0>
<cfloop query="GetSpds">

	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset spd           = #GetSpds.spd#>
	<cfset ou          = #GetSpds.ou#>  

<cfif ha is 'H'>
<cfquery  datasource="nbastats" name="GetUnd">
Select 
		Avg(ofga)   as ofga,
		Avg(dfga)   as dfga,
		
		Avg(otpa)   as otpa,
		Avg(dtpa)   as dtpa,
		
		Avg(ofta)   as ofta,
		Avg(dfta)   as dfta,
		
		Avg(ofgm - otpm) / Avg(ofga - otpa)*100 as ofgpct,
		Avg(dfgm - dtpm) / Avg(dfga - dtpa)*100 as dfgpct,
		
		Avg(otppct)  as otppct,
		Avg(dtppct)  as dtppct,

		Avg(oftpct)  as oftpct,
		
		Avg(dfgpct) as dfgpct, 
		avg(ofgpct) as ofgpct,
		
		avg(oreb) as oreb,
		avg(odreb) as odreb,
		
		avg(dreb) as dreb,
		avg(ddreb) as ddreb
from nbadata
where team = '#und#'
and ha = 'A'
</cfquery>

<cfquery  datasource="nbastats" name="Getfav">
Select 
		Avg(ofga)   as ofga,
		Avg(dfga)   as dfga,
		
		Avg(otpa)   as otpa,
		Avg(dtpa)   as dtpa,
		
		Avg(ofta)   as ofta,
		Avg(dfta)   as dfta,
		
		Avg(ofgm - otpm) / Avg(ofga - otpa)*100 as ofgpct,
		Avg(dfgm - dtpm) / Avg(dfga - dtpa)*100 as dfgpct,
		
		Avg(otppct)  as otppct,
		Avg(dtppct)  as dtppct,

		Avg(oftpct)  as oftpct,
		
		Avg(dfgpct) as dfgpct, 
		avg(ofgpct) as ofgpct,
		
		avg(oreb) as oreb,
		avg(odreb) as odreb,
		
		avg(dreb) as dreb,
		avg(ddreb) as ddreb
		
from nbadata
where team = '#fav#'
and ha = 'H'
</cfquery>

<cfquery datasource="nba" name="GetUndPow">
Select 
	FGPctPowPct, 
	dFGPctPowPct,
	FGAPowPct,
	DFGAPowPct,
	TPAPowPct,
	dTPAPowPct,
	FTAPowPct,
	DFTAPowPct,
	OffRebPowPct,
	DefRebPowPct
from FgpctAway
Where team = '#und#'
</cfquery>

<cfquery datasource="nba" name="GetFavPow">
Select 
	FGPctPowPct, 
	dFGPctPowPct,
	FGAPowPct,
	DFGAPowPct,
	TPAPowPct,
	dTPAPowPct,
	FTAPowPct,
	DFTAPowPct,
	OffRebPowPct,
	DefRebPowPct
from fgpctHome
Where team = '#fav#'
</cfquery>


<cfelse>

<cfquery  datasource="nbastats" name="GetUnd">
Select 
		Avg(ofga)   as ofga,
		Avg(dfga)   as dfga,
		
		Avg(otpa)   as otpa,
		Avg(dtpa)   as dtpa,
		
		Avg(ofta)   as ofta,
		Avg(dfta)   as dfta,
		
		Avg(ofgm - otpm) / Avg(ofga - otpa)*100 as ofgpct,
		Avg(dfgm - dtpm) / Avg(dfga - dtpa)*100 as dfgpct,
		
		Avg(otppct)  as otppct,
		Avg(dtppct)  as dtppct,

		Avg(oftpct)  as oftpct,
		
		Avg(dfgpct) as dfgpct, 
		avg(ofgpct) as ofgpct,
		
		avg(oreb) as oreb,
		avg(odreb) as odreb,
		
		avg(dreb) as dreb,
		avg(ddreb) as ddreb
		
from nbadata
where team = '#und#'
and ha = 'H'
</cfquery>

<cfquery  datasource="nbastats" name="Getfav">
Select 
		Avg(ofga)   as ofga,
		Avg(dfga)   as dfga,
		
		Avg(otpa)   as otpa,
		Avg(dtpa)   as dtpa,
		
		Avg(ofta)   as ofta,
		Avg(dfta)   as dfta,
		
		Avg(ofgm - otpm) / Avg(ofga - otpa)*100 as ofgpct,
		Avg(dfgm - dtpm) / Avg(dfga - dtpa)*100 as dfgpct,
		
		Avg(otppct)  as otppct,
		Avg(dtppct)  as dtppct,

		Avg(oftpct)  as oftpct,
		
		Avg(dfgpct) as dfgpct, 
		avg(ofgpct) as ofgpct,
		
		avg(oreb) as oreb,
		avg(odreb) as odreb,
		
		avg(dreb) as dreb,
		avg(ddreb) as ddreb
from nbadata
where team = '#fav#'
and ha = 'A'
</cfquery>

<cfquery datasource="nba" name="GetUndPow">
Select 
	FGPctPowPct, 
	dFGPctPowPct,
	FGAPowPct,
	DFGAPowPct,
	TPAPowPct,
	dTPAPowPct,
	FTAPowPct,
	DFTAPowPct,
	OffRebPowPct,
	DefRebPowPct
from FgpctHome
Where team = '#und#'
</cfquery>

<cfquery datasource="nba" name="GetFavPow">
Select 
	FGPctPowPct, 
	dFGPctPowPct,
	FGAPowPct,
	DFGAPowPct,
	TPAPowPct,
	dTPAPowPct,
	FTAPowPct,
	DFTAPowPct,
	OffRebPowPct,
	DefRebPowPct
from fgpctAway
Where team = '#fav#'
</cfquery>







</cfif>


<!-- What each team does against the avg defense they face -->
<cfset FavPredOREB1 = GetUnd.dReb + GetUnd.ddReb + getfavpow.OffRebPowPct>
<cfset UndPredOREB1 = GetFav.dReb + GetFav.ddReb + getundpow.OffRebPowPct>

<!-- What each team's offense does against the avg defense they face -->
<cfset FavPredOreb2 = GetFav.oreb + GetFav.odreb  - getundpow.DefRebpowPct>
<cfset UndPredOreb2 = GetUnd.oreb + GetUnd.odreb  - getfavpow.DefRebpowPct>

<cfset FavFinalREB = (FavPredOreb1 + FavPredOreb2)/2> 
<cfset UndFinalREB = (UndPredOreb1 + UndPredOreb2)/2> 

<cfoutput>
REB FavFinal = #FavFinalREB#<br>
REB UndFinal = #UndFinalREB#<br>
</cfoutput>


<!-- What each team does against the avg defense they face -->
<cfset FavPredFGA1 = GetUnd.dfga + getfavpow.fgapowPct>
<cfset UndPredFGA1 = GetFav.dfga + getundpow.fgapowPct>

<!-- What each team's offense does against the avg defense they face -->
<cfset FavPredFGA2 = GetFav.ofga  - getundpow.dfgapowPct>
<cfset UndPredFGA2 = GetUnd.ofga - getfavpow.dfgapowPct>

<cfset FavFinalFGA = (FavPredFGA1 + FavPredFGA2)/2> 
<cfset UndFinalFGA = (UndPredFGA1 + UndPredFGA2)/2> 

<cfoutput>
FGA FavFinal = #FavFinalFGA#<br>
FGA UndFinal = #UndFinalFGA#<br>
</cfoutput>

<!-- What each team does against the avg defense they face -->
<cfset FavPredFGpct1 = GetUnd.dfgpct + getfavpow.FGPctPowPct>
<cfset UndPredFGpct1 = GetFav.dfgpct + getundpow.FGPctPowPct>

<!-- What each team's offense does against the avg defense they face -->
<cfset FavPredFGPct2 = GetFav.ofgpct - getundpow.dFGPctPowPct>
<cfset UndPredFGPct2 = GetUnd.ofgpct - getfavpow.dFGPctPowPct>

<cfset FavFinalFGpct = (FavPredFGpct1 + FavPredFGpct2)/2> 
<cfset UndFinalFGpct = (UndPredFGpct2 + UndPredFGpct2)/2> 

<cfoutput>
FGPct FavFinal = #FavFinalFGpct#<br>
FGPct UndFinal = #UndFinalFGPct#<br>
</cfoutput>



<!-- What each team does against the avg defense they face -->
<cfset FavPredTPA1 = GetUnd.dtpa + getfavpow.TpaPowPct>
<cfset UndPredTPA1 = GetFav.dtpa + getundpow.tpaPowPct>

<!-- What each team's offense does against the avg defense they face -->
<cfset FavPredTPA2 = GetFav.otpa - getundpow.dTPAPowPct>
<cfset UndPredTPA2 = GetUnd.otpa - getfavpow.dTPAPowPct>

<cfset FavFinalTPA = (FavPredTPA1 + FavPredTPA2)/2> 
<cfset UndFinalTPA = (UndPredTPA1 + UndPredTPA2)/2> 

<cfoutput>
TPA FavFinal = #FavFinalTPA#<br>
TPA UndFinal = #UndFinalTPA#<br>
</cfoutput>



<!-- What each team does against the avg defense they face -->
<cfset FavPredFTA1 = GetUnd.dfta + getfavpow.ftapowPct>
<cfset UndPredFTA1 = GetFav.dfta + getundpow.ftapowPct>

<!-- What each team's offense does against the avg defense they face -->
<cfset FavPredFTA2 = GetFav.ofta - getundpow.dFTAPowPct>
<cfset UndPredFTA2 = GetUnd.ofta - getfavpow.dFTAPowPct>

<cfset FavFinalFTA = (FavPredFTA1 + FavPredFTA2)/2> 
<cfset UndFinalFTA = (UndPredFTA1 + UndPredFTA2)/2> 

<cfoutput>
FTA FavFinal = #FavFinalFTA#<br>
FTA UndFinal = #UndFinalFTA#<br>
</cfoutput>


<!--- 
<cfoutput query="Getit">
<cfset oval = 0>
<cfset uval=0>

<cfif oOverallTPA gt uOverallTPA>
	<cfset oval = ((otpaR1 * 1.5) + (otpaR2 * 5) + (otpaR3 * 8) + (otpaR4 * 11) + (otpaR5 * 15)) /100>
<cfelse> 
	<cfset uval = ((utpaR1 * 1.5) + (utpaR2 * 5) + (utpaR3 * 8) + (utpaR4 * 11) + (utpaR5 * 15))/100> 
</cfif>

<cfset useval = -1*uval>
<cfif oval gt uval>
	<cfset useval = oval>
</cfif> 

<cfquery datasource="nba">
Update FGPct
Set TPAPowPct = #useval# 
Where team = '#team#'
</cfquery>
</cfoutput>



<cfoutput query="Getit">
<cfset oval = 0>
<cfset uval=0>

<cfif oOverallFTA gt uOverallFTA>
	<cfset oval = ((oftaR1 * 1.5) + (oftaR2 * 5) + (oftaR3 * 8) + (oftaR4 * 11) + (oftaR5 * 15)) /100>
<cfelse> 
	<cfset uval = ((uftaR1 * 1.5) + (uftaR2 * 5) + (uftaR3 * 8) + (uftaR4 * 11) + (uftaR5 * 15))/100> 
</cfif>

<cfset useval = -1*uval>
<cfif oval gt uval>
	<cfset useval = oval>
</cfif> 

<cfquery datasource="nba">
Update FGPct
Set FTAPowPct = #useval# 
Where team = '#team#'
</cfquery>
</cfoutput>
 --->
<cfset predfav=0>
<cfset predund=0>

<cfquery datasource="nbastats" name="GetUndPrior">
Select avg(ps) as ps
from nbadata 
where team = '#und#'
and (ofgpct >= #undFInalfgpct# and ofgpct <= #undFInalfgpct + 2#)
</cfquery>

<cfquery datasource="nbastats" name="GetFavPrior">
Select avg(ps) as ps
from nbadata 
where team = '#fav#'
and (ofgpct >= #favFInalfgpct# and ofgpct <= #favFInalfgpct + 2#)
</cfquery>

<cfquery datasource="nbastats" name="GetFavPriorDef">
Select avg(dps) as dps
from nbadata 
where team = '#fav#'
and (dfgpct <= #undFInalfgpct# and dfgpct >= #undFInalfgpct + 2#)
</cfquery>

<cfquery datasource="nbastats" name="GetUndPriorDef">
Select avg(dps) as dps
from nbadata 
where team = '#und#'
and (dfgpct <= #favFInalfgpct# and dfgpct >= #favFInalfgpct + 2#)
</cfquery>

<cfset skipf1 = true>
<cfset skipf2 = true>

<cfif GetFavPrior.recordcount neq 0>
	<cfset f1 = GetFavPrior.ps>
	<cfset skipf1 = false>
</cfif>

<cfif GetFavPriordef.recordcount neq 0>
	<cfset f2 = GetFavPriorDef.dps>
	<cfset skipf2 = false>
</cfif>


<cfset skipu1 = true>
<cfset skipu2 = true>

<cfif GetUndPrior.recordcount neq 0>
	<cfset u1 = GetUndPrior.ps>
	<cfset skipu1 = false>
</cfif>

<cfif GetUndPriordef.recordcount neq 0>
	<cfset u2 = GetFavPriorDef.dps>
	<cfset skipu2 = false>
</cfif>

<cfset favaddit = 0>
<cfset undaddit = 0>
<cfif ha is 'H'>
	<cfset favaddit = 0>
<cfelse>
	<cfset undaddit = 0>
</cfif>

<cfif skipf1 is false>
	<cfset predfav = predfav + f1>
</cfif>

<cfif skipf2 is false>
	<cfset predfav = (predfav + f2)/2>
</cfif>


<cfif skipu1 is false>
	<cfset predund = predund + u1>
</cfif>

<cfif skipu2 is false>
	<cfset predund = (predund + u2)/2>
</cfif>



<cfoutput>
#fav# predicted: #predfav + favaddit#<br>
#und# predicted: #predund + undaddit#<br>
Total Points:#predfav + predund# versus #ou#<br>
Spread #(predfav + favaddit) - (predund + undaddit)# versus #spd#<br>
fg=#(FavFinalFGA - FavFinalTPA)*(FavFinalfgpct/100)*2#<br>
tp=#(FavFinalTPA * (GetFav.otppct/100))*3#<br>
ft=#FavFinalFTA*(GetFav.oftpct/100)#<br>
<cfset favnew = (FavFinalFGA - FavFinalTPA)*(FavFinalfgpct/100)*2 + (FavFinalTPA * (GetFav.otppct/100))*3 + FavFinalFTA*(GetFav.oftpct/100) + favaddit>
<cfset undnew = (UndFinalFGA - UndFinalTPA)*(UndFinalfgpct/100)*2 + (UndFinalTPA * (GetUnd.otppct/100))*3 + UndFinalFTA*(GetUnd.oftpct/100) + undaddit>
<cfset totpts = favnew + undnew>

-----------------------------------------------------------------------------------<br>
==================#fav# predicted: #favnew#<br>
==================#und# predicted: #undnew#<br>
==================Spread #favnew - Undnew# versus #spd#<br>
==================Total Points:#totpts# versus #ou#<br>
<cfset mypick=''>
<cfif (favnew - Undnew) ge (spd + 4.5)>
	<cfset mypick = '#fav#'>
</cfif>

<cfif (Undnew + spd - Favnew) ge 4.5>
	<cfset mypick = '#und#'>
</cfif>

<cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
	Set PowPredSideHA = '#mypick#'
	Where Fav = '#fav#' 
	and GameTime = '#mygametime#'
</cfquery>


<cfset mypick=''>
<cfif (totpts ge ou + 6)>
	<cfset mypick = 'Over'>
</cfif>

<cfif (totpts le ou - 6)>
	<cfset mypick = 'Under'>
</cfif>

<cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
	Set PowPredTotalHA = '#mypick#'
	Where Fav = '#fav#' 
	and GameTime = '#mygametime#'
</cfquery>


</cfoutput>

<cfif HaToUse is 'H'>
<cfquery datasource="nba" name="GetFav">
Select * from FGPctHome where team = '#fav#'
</cfquery>

<cfquery datasource="nba" name="GetUnd">
Select * from FGPctAway where team = '#und#'
</cfquery>

<cfelse>
<cfquery datasource="nba" name="GetFav">
Select * from FGPctAway where team = '#fav#'
</cfquery>

<cfquery datasource="nba" name="GetUnd">
Select * from FGPctHome where team = '#und#'
</cfquery>
</cfif>

<cfset fFgpct = GetFav.FgpctPowPct - GetUnd.dFGPctPowPct>
<cfset uFgpct = GetUnd.FgpctPowPct - GetFav.dFGPctPowPct>

<cfset fFga   = GetFav.FgaPowPct - GetUnd.dFGAPowPct>
<cfset uFga   = GetUnd.FgaPowPct - GetFav.dFGAPowPct>

<cfset fFta   = GetFav.FtaPowPct - GetUnd.dFTAPowPct>
<cfset uFta   = GetUnd.FtaPowPct - GetFav.dFTAPowPct>

<cfset ftpa   = GetFav.tpaPowPct - GetUnd.dTPAPowPct>
<cfset utpa   = GetUnd.tpaPowPct - GetFav.dTPAPowPct>

<cfset freb   = GetFav.OFFRebPowPct - GetUnd.DefRebPowPct>
<cfset ureb   = GetUnd.OffRebPowPct - GetFav.DefRebPowPct>

<cfset ftppct   = GetFav.tppctpowPct - GetUnd.DtppctPowPct>
<cfset utppct   = GetUnd.tppctPowPct - GetFav.DtppctPowPct>

<cfoutput>
fFgpct = #fFgpct#<br>
uFgpct = #uFgpct#<br>
#fFgpct - uFgpct#<br>
------------------------------------------------<br>
fFga   = #fFga#<br>
uFga   = #uFga#<br>
#fFga - uFga#<br>
------------------------------------------------<br>
fFta   = #fFta#<br>
uFta   = #uFta#<br>
#fFta - uFta#<br>
------------------------------------------------<br>
ftpa   = #ftpa#<br>
utpa   = #utpa#<br>
#ftpa - utpa#<br>
------------------------------------------------<br>
freb   = #freb#<br>
ureb   = #ureb#<br>
#freb - ureb#<br>
------------------------------------------------<br>
ftppct   = #ftppct#<br>
utppct   = #utppct#<br>
#ftppct - utppct#<br>
------------------------------------------------<br>

<cfquery datasource="nba">
Update FinalPicks
Set FGPctDif = #fFgpct - uFgpct#,
FGADif = #fFga - uFga#,
FTADif = #fFta - uFta#,
TPADif = #ftpa - utpa#,
TPPctDif = #ftppct - utppct#,
RebDif   = #freb - ureb#
Where Gametime = '#mygametime#'
and fav = '#fav#'
</cfquery>


</cfoutput>


</cfloop>

</body>
</html>
