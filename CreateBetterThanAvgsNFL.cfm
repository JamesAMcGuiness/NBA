<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>


<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset mygametime = GetRunct.GameTime>



<cfquery datasource="nba" name="addit">
Delete from BetterThanAvg
</cfquery>

<cfquery datasource="nbastats" name="AvgTeam">
Select 
	   Avg(ps) as aps, 
	   avg(ofgm) as afgm,
	   Avg(ofga - otpa) as afga,
	   avg(ofgpct) as afgpct,
	   avg(otpm) as atpm,
	   avg(otpa) as atpa,
	   avg(otppct) as atppct,
	   avg(oftm) as aftm,
	   avg(ofta) as afta,
	   avg(otreb) as areb,
	   avg(oturnovers) as ato, 	
	   Avg(dps) as adps, 
	   avg(dfgm) as adfgm,
	   Avg(dfga - dtpa) as adfga,
	   avg(dfgpct) as adfgpct,
	   avg(dtpm) as adtpm,
	   avg(dtpa) as adtpa,
	   avg(dtppct) as adtppct,
	   avg(dftm) as adftm,
	   avg(dfta) as adfta,
	   avg(dtreb) as adreb,
	   avg(dturnovers) as adto
from nbadata		
WHERE gametime < '#mygametime#'
</cfquery>

<cfquery datasource="nba"  name="GetTeams">
Select Distinct team from GAP
</cfquery>

<!-- See how much better/wrose each team is versus the AVG team -->
<cfloop query="GetTeams">

<cfquery datasource="nbastats" name="TeamAvg">
Select 
	   Avg(ps) as aps, 
	   avg(ofgm) as afgm,
	   Avg(ofga - otpa) as afga,
	   avg(ofgpct) as afgpct,
	   avg(otpm) as atpm,
	   avg(otpa) as atpa,
	   avg(otppct) as atppct,
	   avg(oftm) as aftm,
	   avg(ofta) as afta,
	   avg(otreb) as areb,
	   avg(oturnovers) as ato, 	
	   Avg(dps) as adps, 
	   avg(dfgm) as adfgm,
	   avg(dfga - dtpa) as adfga,
	   avg(dfgpct) as adfgpct,
	   avg(dtpm) as adtpm,
	   avg(dtpa) as adtpa,
	   avg(dtppct) as adtppct,
	   avg(dftm) as adftm,
	   avg(dfta) as adfta,
	   avg(dtreb) as adreb,
	   avg(dturnovers) as adto
from nbadata		
Where Team = '#GetTeams.Team#'
and gametime < '#mygametime#'
</cfquery>
	
<cfloop query="TeamAvg">
	   <cfset st1 = ((TeamAvg.aps - AvgTeam.aps)/AvgTeam.aps)*100>
	   <cfset st2 = ((TeamAvg.afgm - AvgTeam.afgm)/TeamAvg.afgm)*100>
	   <cfset st3 = ((TeamAvg.afga - AvgTeam.afga)/TeamAvg.afga)*100>
	   <cfset st4 = ((TeamAvg.afgpct - AvgTeam.afgpct)/TeamAvg.afgpct)*100>
	   <cfset st5 = ((TeamAvg.atpm - AvgTeam.atpm)/TeamAvg.atpm)*100>
	   <cfset st6 = ((TeamAvg.atpa - AvgTeam.atpa)/TeamAvg.atpa)*100>
	   <cfset st7 = ((TeamAvg.atppct - AvgTeam.atppct)/TeamAvg.atppct)*100>
	   <cfset st8 = ((TeamAvg.aftm - AvgTeam.aftm)/TeamAvg.aftm)*100>
	   <cfset st9 = ((TeamAvg.afta - AvgTeam.afta)/TeamAvg.afta)*100>
	   <cfset st10 = ((TeamAvg.areb - AvgTeam.areb)/TeamAvg.areb)*100>
	   <cfset st11 = ((AvgTeam.ato - TeamAvg.ato)/TeamAvg.ato)*100 >	


	   <cfset st12 = ((AvgTeam.adps - TeamAvg.adps)/TeamAvg.adps)*100> 
	   <cfset st13 = ((AvgTeam.adfgm - TeamAvg.adfgm)/TeamAvg.adfgm)*100>
	   <cfset st14 = ((AvgTeam.adfga - TeamAvg.adfga)/TeamAvg.adfga)*100>
	   <cfset st15 = ((AvgTeam.adfgpct - TeamAvg.adfgpct)/TeamAvg.adfgpct)*100>
	   <cfset st16 = ((AvgTeam.adtpm - TeamAvg.adtpm)/TeamAvg.adtpm)*100>
	   <cfset st17 = ((AvgTeam.adtpa - TeamAvg.adtpa)/TeamAvg.adtpa)*100>
	   <cfset st18 = ((AvgTeam.adtppct - TeamAvg.adtppct)/TeamAvg.adtppct)*100>
	   <cfset st19 = ((AvgTeam.adftm - TeamAvg.adftm)/TeamAvg.adftm)*100>
	   <cfset st20 = ((AvgTeam.adfta - TeamAvg.adfta)/TeamAvg.adfta)*100>
	   <cfset st21 = ((AvgTeam.adreb - TeamAvg.adreb)/TeamAvg.adreb)*100>
	   <cfset st22 = ((TeamAvg.adto - AvgTeam.adto)/AvgTeam.adto)*100>


</cfloop>	
	
<cfquery datasource="nba" name="addit">
insert into BetterThanAvg
(Team,
ops,
ofgm,
ofga,
ofgpct,
otpm,
otpa,
otppct,
oftm,
ofta,
oreb,
oto,
dps,
dfgm,
dfga,
dfgpct,
dtpm,
dtpa,
dtppct,
dftm,
dfta,
dreb,
dto
)
Values
(
'#GetTeams.Team#',
#st1#,
#st2#,
#st3#,
#st4#,
#st5#,
#st6#,
#st7#,
#st8#,
#st9#,
#st10#,
#st11#,
#st12#,
#st13#,
#st14#,
#st15#,
#st16#,
#st17#,
#st18#,
#st19#,
#st20#,
#st21#,
#st22#
)


</cfquery>	
</cfloop>



</body>
</html>
