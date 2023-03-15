<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfset myteam = 'MEM'>

<!-- Get all the games where this team covered the spread -->
<cfquery datasource="nbastats" name="GetCovData">
select opp, ha
from nbadata 
where team = '#myteam#' 
<!--- and (ps - dps > 0 or dps - ps < 5) --->
and ps - dps > 4
</cfquery>

<cfset gsc = 0>
<cfset asc = 0>
<cfset psc = 0>

<cfset greb = 0>
<cfset areb = 0>
<cfset preb = 0>

<cfset gfgpct = 0>
<cfset afgpct = 0>
<cfset pfgpct = 0>

<cfset gins = 0>
<cfset ains = 0>
<cfset pins = 0>

<cfset gtpatt = 0>
<cfset atpatt = 0>
<cfset ptpatt = 0>

<cfset covct = 0>
<cfoutput query="GetCovData">

<cfset covct = covct + 1>

<cfquery datasource="nba" name="GoodScoring">
Select Team
from gap
where scoring = 'G'
and team = '#GetCovData.opp#'
</cfquery>

<cfif GoodScoring.recordcount neq 0>
	<cfset gsc = gsc + 1>
</cfif>


<cfquery datasource="nba" name="AvgScoring">
Select Team
from gap
where scoring = 'A'
and team = '#GetCovData.opp#'
</cfquery>

<cfif AvgScoring.recordcount neq 0>
	<cfset asc = asc + 1>
</cfif>

<cfquery datasource="nba" name="PoorScoring">
Select Team
from gap
where scoring = 'P'
and team = '#GetCovData.opp#'
</cfquery>

<cfif PoorScoring.recordcount neq 0>
	<cfset psc = psc + 1>
</cfif>


<cfquery datasource="nba" name="GoodRebounding">
Select Team
from gap
where Rebounding = 'G'
and team = '#GetCovData.opp#'
</cfquery>

<cfif GoodRebounding.recordcount neq 0>
	<cfset greb = greb + 1>
</cfif>


<cfquery datasource="nba" name="AvgRebounding">
Select Team
from gap
where Rebounding = 'A'
and team = '#GetCovData.opp#'
</cfquery>

<cfif AvgRebounding.recordcount neq 0>
	<cfset areb = areb + 1>
</cfif>


<cfquery datasource="nba" name="PoorRebounding">
Select Team
from gap
where scoring = 'P'
and team = '#GetCovData.opp#'
</cfquery>

<cfif PoorRebounding.recordcount neq 0>
	<cfset preb = preb + 1>
</cfif>


<cfquery datasource="nba" name="GoodInside">
Select Team
from gap
where FtAtt = 'G'
and team = '#GetCovData.opp#'
</cfquery>

<cfif GoodInside.recordcount neq 0>
	<cfset gins = gins + 1>
</cfif>

<cfquery datasource="nba" name="AvgInside">
Select Team
from gap
where FtAtt = 'A'
and team = '#GetCovData.opp#'
</cfquery>

<cfif AvgInside.recordcount neq 0>
	<cfset ains = ains + 1>
</cfif>

<cfquery datasource="nba" name="PoorInside">
Select Team
from gap
where FtAtt = 'P'
and team = '#GetCovData.opp#'
</cfquery>

<cfif PoorInside.recordcount neq 0>
	<cfset pins = pins + 1>
</cfif>


<cfquery datasource="nba" name="GoodTPAtt">
Select Team
from gap
where TPAtt = 'G'
and team = '#GetCovData.opp#'
</cfquery>

<cfif GoodTPAtt.recordcount neq 0>
	<cfset gTPAtt = gTPAtt + 1>
</cfif>

<cfquery datasource="nba" name="AvgTPAtt">
Select Team
from gap
where TPAtt = 'A'
and team = '#GetCovData.opp#'
</cfquery>

<cfif AvgTPAtt.recordcount neq 0>
	<cfset aTPAtt = aTPAtt + 1>
</cfif>

<cfquery datasource="nba" name="PoorTPAtt">
Select Team
from gap
where TPAtt = 'P'
and team = '#GetCovData.opp#'
</cfquery>

<cfif PoorTPAtt.recordcount neq 0>
	<cfset pTPAtt = pTPAtt + 1>
</cfif>



<cfquery datasource="nba" name="GoodFGPct">
Select Team
from gap
where TPAtt = 'G'
and team = '#GetCovData.opp#'
</cfquery>

<cfif GoodFGPct.recordcount neq 0>
	<cfset gFGpct = gFGpct + 1>
</cfif>

<cfquery datasource="nba" name="AvgFGPct">
Select Team
from gap
where TPAtt = 'A'
and team = '#GetCovData.opp#'
</cfquery>

<cfif AvgFGPct.recordcount neq 0>
	<cfset aFGpct = aFGpct + 1>
</cfif>

<cfquery datasource="nba" name="PoorFGPct">
Select Team
from gap
where TPAtt = 'P'
and team = '#GetCovData.opp#'
</cfquery>


<cfif PoorFGPct.recordcount neq 0>
	<cfset pFGpct = pFGpct + 1>
</cfif>


</cfoutput>
<cfoutput>
For #myteam# to cover the spread:#covct#<br>

Good Scoring: #gsc/covct#<br>
Avg Scoring: #asc/covct#<br>
Poor Scoring #psc/covct#<br>
<hr>
Good Reb: #greb/covct#<br>
Avg Reb: #areb/covct#<br>
Poor Reb: #preb/covct# <br>
<hr>
Good FGPct: #gfgpct/covct#<br>
Avg FGPct: #afgpct/covct#<br>
Poor FGPct: #pfgpct/covct# <br>
<hr>
Good Inside: #gins/covct#<br>
Avg Inside: #ains/covct#<br>
Poor Inside: #pins/covct# <br>
<hr>
Good 3PT: #gtpatt/covct#<br>
Avg 3PT: #atpatt/covct#<br>
Poor 3PT: #ptpatt/covct# <br>
<hr>
</cfoutput>















-----------------------------------------------------------------------------------------------------------------------------------------------------------------------<br>



<cfset myteam = 'LAC'>

<!-- Get all the games where this team covered the spread -->
<cfquery datasource="nbastats" name="GetCovData">
select opp, ha
from nbadata 
where team = '#myteam#' 
and (ps - dps > 0 or dps - ps < 4) 
</cfquery>

<cfset gsc = 0>
<cfset asc = 0>
<cfset psc = 0>

<cfset greb = 0>
<cfset areb = 0>
<cfset preb = 0>

<cfset gfgpct = 0>
<cfset afgpct = 0>
<cfset pfgpct = 0>

<cfset gins = 0>
<cfset ains = 0>
<cfset pins = 0>

<cfset gtpatt = 0>
<cfset atpatt = 0>
<cfset ptpatt = 0>

<cfset covct = 0>
<cfoutput query="GetCovData">

<cfset covct = covct + 1>

<cfquery datasource="nba" name="GoodScoring">
Select Team
from gap
where scoring = 'G'
and team = '#GetCovData.opp#'
</cfquery>

<cfif GoodScoring.recordcount neq 0>
	<cfset gsc = gsc + 1>
</cfif>


<cfquery datasource="nba" name="AvgScoring">
Select Team
from gap
where scoring = 'A'
and team = '#GetCovData.opp#'
</cfquery>

<cfif AvgScoring.recordcount neq 0>
	<cfset asc = asc + 1>
</cfif>

<cfquery datasource="nba" name="PoorScoring">
Select Team
from gap
where scoring = 'P'
and team = '#GetCovData.opp#'
</cfquery>

<cfif PoorScoring.recordcount neq 0>
	<cfset psc = psc + 1>
</cfif>


<cfquery datasource="nba" name="GoodRebounding">
Select Team
from gap
where Rebounding = 'G'
and team = '#GetCovData.opp#'
</cfquery>

<cfif GoodRebounding.recordcount neq 0>
	<cfset greb = greb + 1>
</cfif>


<cfquery datasource="nba" name="AvgRebounding">
Select Team
from gap
where Rebounding = 'A'
and team = '#GetCovData.opp#'
</cfquery>

<cfif AvgRebounding.recordcount neq 0>
	<cfset areb = areb + 1>
</cfif>


<cfquery datasource="nba" name="PoorRebounding">
Select Team
from gap
where scoring = 'P'
and team = '#GetCovData.opp#'
</cfquery>

<cfif PoorRebounding.recordcount neq 0>
	<cfset preb = preb + 1>
</cfif>


<cfquery datasource="nba" name="GoodInside">
Select Team
from gap
where FtAtt = 'G'
and team = '#GetCovData.opp#'
</cfquery>

<cfif GoodInside.recordcount neq 0>
	<cfset gins = gins + 1>
</cfif>

<cfquery datasource="nba" name="AvgInside">
Select Team
from gap
where FtAtt = 'A'
and team = '#GetCovData.opp#'
</cfquery>

<cfif AvgInside.recordcount neq 0>
	<cfset ains = ains + 1>
</cfif>

<cfquery datasource="nba" name="PoorInside">
Select Team
from gap
where FtAtt = 'P'
and team = '#GetCovData.opp#'
</cfquery>

<cfif PoorInside.recordcount neq 0>
	<cfset pins = pins + 1>
</cfif>


<cfquery datasource="nba" name="GoodTPAtt">
Select Team
from gap
where TPAtt = 'G'
and team = '#GetCovData.opp#'
</cfquery>

<cfif GoodTPAtt.recordcount neq 0>
	<cfset gTPAtt = gTPAtt + 1>
</cfif>

<cfquery datasource="nba" name="AvgTPAtt">
Select Team
from gap
where TPAtt = 'A'
and team = '#GetCovData.opp#'
</cfquery>

<cfif AvgTPAtt.recordcount neq 0>
	<cfset aTPAtt = aTPAtt + 1>
</cfif>

<cfquery datasource="nba" name="PoorTPAtt">
Select Team
from gap
where TPAtt = 'P'
and team = '#GetCovData.opp#'
</cfquery>

<cfif PoorTPAtt.recordcount neq 0>
	<cfset pTPAtt = pTPAtt + 1>
</cfif>



<cfquery datasource="nba" name="GoodFGPct">
Select Team
from gap
where TPAtt = 'G'
and team = '#GetCovData.opp#'
</cfquery>

<cfif GoodFGPct.recordcount neq 0>
	<cfset gFGpct = gFGpct + 1>
</cfif>

<cfquery datasource="nba" name="AvgFGPct">
Select Team
from gap
where TPAtt = 'A'
and team = '#GetCovData.opp#'
</cfquery>

<cfif AvgFGPct.recordcount neq 0>
	<cfset aFGpct = aFGpct + 1>
</cfif>

<cfquery datasource="nba" name="PoorFGPct">
Select Team
from gap
where TPAtt = 'P'
and team = '#GetCovData.opp#'
</cfquery>


<cfif PoorFGPct.recordcount neq 0>
	<cfset pFGpct = pFGpct + 1>
</cfif>


</cfoutput>
<cfoutput>
For #myteam# to cover the spread:#covct#<br>

Good Scoring: #gsc/covct#<br>
Avg Scoring: #asc/covct#<br>
Poor Scoring #psc/covct#<br>
<hr>
Good Reb: #greb/covct#<br>
Avg Reb: #areb/covct#<br>
Poor Reb: #preb/covct# <br>
<hr>
Good FGPct: #gfgpct/covct#<br>
Avg FGPct: #afgpct/covct#<br>
Poor FGPct: #pfgpct/covct# <br>
<hr>
Good Inside: #gins/covct#<br>
Avg Inside: #ains/covct#<br>
Poor Inside: #pins/covct# <br>
<hr>
Good 3PT: #gtpatt/covct#<br>
Avg 3PT: #atpatt/covct#<br>
Poor 3PT: #ptpatt/covct# <br>
<hr>
</cfoutput>

