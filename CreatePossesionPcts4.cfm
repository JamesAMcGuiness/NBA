;/'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfquery datasource="nbapospcts" name="NbaPosPcts">
Delete from NBAPosPcts
</cfquery>

<cfquery datasource="nbastats" name="GetAvgs">
Select team, 
		Avg(oReb + oDReb + dTurnovers) as Pos,
		Avg(ofga - (oReb + oDReb + dTurnovers)) as RegPos,
		Avg ((ofga - otpa) / ofga) as fg2ptpct,
		Avg(otpa / ofga) as fg3ptpct,
		Avg(oturnovers / ofga) as turnovrpct,
		Avg(ofta / ofga) as fouled,
		Avg(oSteals / dfga) as StealPct,
		Avg(oReb / ofga) as RebPct,
		Avg(odReb /dfga) as dRebPct
		
from nbadata
group by Team
order by turnovrpct desc
</cfquery>


<cfoutput query="GetAvgs">
<cfquery datasource="nbaPosPcts" name="Addit">
Insert into nbaPosPcts
(
Team,
OffDef,
RegPos,
fgAtt,
tpAtt,
turnovpct,
Fouled,
StealPct,
ORebPct,
DRebPct,
pos
)
values
(
'#team#',
'O',
#Regpos#,
#numberformat(fg2ptpct,'999.999')#,
#numberformat(fg3ptpct,'999.999')#,
#numberformat(turnovrpct,'999.999')#,
#numberformat(fouled,'999.999')#,
#numberformat(StealPct,'999.999')#,
#numberformat(RebPct,'999.999')#,
#numberformat(dRebPct,'999.999')#,
#numberformat(pos,'999.999')#
)
</cfquery>
</cfoutput>


<cfquery datasource="nbastats" name="GetOffAvgs">
Select team, 
	Avg(ofgm/ofga) as fgpct,
	Avg(otpm/otpa) as tppct, 
	Avg(oturnovers/ofga) as topct,
	Avg(oftm/ofta) as ftpct 
from nbadata 
group by Team
</cfquery>

<cfquery datasource="nbastats" name="GetDefAvgs">
Select team, 
	Avg(dfgm/dfga) as fgpct,
	Avg(dtpm/dtpa) as tppct, 
	Avg(dturnovers/dfga) as topct,
	Avg(dftm/dfta) as ftpct 
from nbadata 
group by Team
</cfquery>

<cfquery datasource="nbastats" name="GetAvgs">
Select team, 
		Avg(dReb + dDReb + oTurnovers) as Pos,
		Avg(dfga - (oTurnovers + dReb + dDreb)) as RegPos,
		Avg ((dfga - dtpa) / dfga) as fg2ptpct,
		Avg(dtpa / dfga) as fg3ptpct,
		Avg(dturnovers / dfga) as turnovrpct,
		Avg(dfta / dfga) as fouled,
		Avg(dSteals / ofga) as StealPct,
		Avg(dReb / dfga) as RebPct,
		Avg(ddReb /ofga) as dRebPct
		
from nbadata
group by Team
order by turnovrpct desc

</cfquery>


<cfoutput query="GetAvgs">
<cfquery datasource="nbaPosPcts" name="Addit">
Insert into nbaPosPcts
(
Team,
OffDef,
Pos,
RegPos,
fgAtt,
tpAtt,
turnovpct,
Fouled,
StealPct,
ORebPct,
DRebPct,
pos
)
values
(
'#team#',
'D',
#pos#,
#Regpos#,
#numberformat(fg2ptpct,'999.999')#,
#numberformat(fg3ptpct,'999.999')#,
#numberformat(turnovrpct,'999.999')#,
#numberformat(fouled,'999.999')#,
#numberformat(StealPct,'999.999')#,
#numberformat(RebPct,'999.999')#,
#numberformat(dRebPct,'999.999')#,
#numberformat(pos,'999.999')#
)
</cfquery>
</cfoutput>

<cfoutput query="GetOffAvgs">
<cfquery datasource="nbaPosPcts" name="Updit">
Update NbaPosPcts
Set fgpct = #fgpct#,
tppct = #tppct#,
ftpct = #ftpct#,
topct = #topct#
where team = '#team#'
and Offdef = 'O'
</cfquery>
</cfoutput>

<cfoutput query="GetDefAvgs">
<cfquery datasource="nbaPosPcts" name="Updit">
Update NbaPosPcts
Set fgpct = #fgpct#,
tppct = #tppct#,
ftpct = #ftpct#,
topct = #topct#
where team = '#team#'
and Offdef = 'D'
</cfquery>
</cfoutput>



</body>
</html>
