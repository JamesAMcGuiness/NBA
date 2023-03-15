<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfquery datasource="nba" name="NbaPosPcts">
Delete from NBAPosPcts
</cfquery>

<cfquery datasource="nba" name="GetAvgs">
Select team, 
		Avg(ofga + oTurnovers) as Pos,
		(Avg(ofga + ofta) - Avg(oSteals + oReb + odReb + dturnovers))/ Avg(ofga + oTurnovers) as RegPos,
		Avg(ofga - otpa)/ Avg(ofga + oTurnovers) as fg2ptpct,
		Avg(otpa) / Avg(ofga + oTurnovers) as fg3ptpct,
		Avg(oturnovers)/Avg(ofga + oTurnovers) as turnovrpct,
		Avg(ofta)/ Avg(ofga + oTurnovers) as fouled,
		Avg(oSteals)/Avg(dfga + dTurnovers) as StealPct,
		Avg(oReb)/Avg(ofga) as RebPct,
		Avg(odReb)/Avg(dfga) as dRebPct
		
from nbadata 
Where and mins = 240
group by Team
order by turnovrpct desc
</cfquery>


<cfoutput query="GetAvgs">
<cfquery datasource="nba" name="Addit">
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


<cfquery datasource="nba" name="GetOffAvgs">
Select team, 
	Avg(ofgm/ofga) as fgpct,
	Avg(otpm/otpa) as tppct, 
	Avg(oturnovers/ofga) as topct,
	Avg(oftm/ofta) as ftpct 
from nbadata 
Where mins = 240
group by Team
</cfquery>

<cfquery datasource="nba" name="GetDefAvgs">
Select team, 
	Avg(dfgm/dfga) as fgpct,
	Avg(dtpm/dtpa) as tppct, 
	Avg(dturnovers/dfga) as topct,
	Avg(dftm/dfta) as ftpct 
from nbadata
Where mins = 240 
group by Team
</cfquery>

<cfquery datasource="nba" name="GetAvgs">
Select team, 
		Avg(dfga + dTurnovers) as Pos,
		(Avg(dfga + dfta) - Avg(dSteals + dReb + ddReb + oturnovers))/ Avg(dfga + dTurnovers) as RegPos,
		Avg(dfga - dtpa)/ Avg(dfga + dTurnovers) as fg2ptpct,
		Avg(dtpa) / Avg(dfga + dTurnovers) as fg3ptpct,
		Avg(dturnovers)/Avg(dfga + dTurnovers) as turnovrpct,
		Avg(dfta)/ Avg(dfga + dTurnovers) as fouled,
		Avg(dSteals)/Avg(ofga + oTurnovers) as StealPct,
		Avg(dReb)/Avg(dfga) as RebPct,
		Avg(ddReb)/Avg(ofga) as dRebPct
		
from nbadata 
Where mins = 240
group by Team
order by turnovrpct desc
</cfquery>


<cfoutput query="GetAvgs">
<cfquery datasource="nba" name="Addit">
Insert into nbaPosPcts
(
Team,
OffDef,
Pos,
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
<cfquery datasource="nba" name="Updit">
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
<cfquery datasource="nba" name="Updit">
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
