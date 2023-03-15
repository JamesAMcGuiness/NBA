<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<cfinclude template="CreateBetterThanAvgs.cfm"> 

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('CreateBetterThanAvgs.cfm')
</cfquery>



<cfinclude template="loadmatrixPSHome.cfm">

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('loadmatrixPSHome.cfm')
</cfquery>


<cfinclude template="loadmatrixPSAway.cfm">

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('loadmatrixPSAway.cfm')
</cfquery>



<cfinclude template="loadmatrixFGPctHome.cfm">
<cfinclude template="loadmatrixFGPctAway.cfm">
<cfinclude template="loadmatrixRebHome.cfm">
<cfinclude template="loadmatrixRebAway.cfm">
<cfinclude template="loadmatrixTPMHome.cfm">
<cfinclude template="loadmatrixTPMAway.cfm">
<cfinclude template="loadmatrixFTMHome.cfm">
<cfinclude template="loadmatrixFTMAway.cfm">
<cfinclude template="loadmatrixTOHome.cfm">
<cfinclude template="loadmatrixTOAway.cfm">
<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('UpdStatus.cfm')
</cfquery>

<cfinclude template="loadmatrixPIPHome.cfm">

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('loadmatrixPIPHome.cfm')
</cfquery>

<cfinclude template="loadmatrixPIPAway.cfm">

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('loadmatrixPIPAway.cfm')
</cfquery>

<cfinclude template="jimtemp2.cfm">

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('jimtemp2.cfm')
</cfquery>



<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('SuperSystemCompleted!')
</cfquery>


</body>
</html>
