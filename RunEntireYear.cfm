<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>
<cfabort>
<body>

<cfquery datasource="Nba" name="GetStatus">
	Select Runflag
	from RunStatus
</cfquery>

<cfif GetStatus.RunFlag is 'Y'>
	<cfabort>
</cfif>

<cfinclude template="FigureOutPicks.cfm">


</body>
</html>
