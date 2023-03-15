<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfset myyear  = Year(now())>
<cfset mymonth = Numberformat(Month(now()),'00')>
<cfset myday   = Numberformat(Day(now()),'00')>

<cfset mydate = myyear & mymonth & myday>

<cfif isdefined("Form.GameTime") >
	<cfset Session.GameTime = Form.GameTime>
	<cfset mydate = Form.GameTime>
</cfif>

<cfif IsDefined("Form.LoadData")>
	<cfif isdefined("Form.GameTime") and isdefined("Form.hdn_Year")>
 		<cfset Session.GameTime = CreateDate(#Form.hdn_Year#,#Form.hdn_Month#,#Form.hdn_Day#)>
		<cfoutput>#Session.GameTime#</cfoutput>


		<cfset Session.GameTime = Dateformat(DateAdd('d',-1,Session.GameTime),'yyyymmdd')>
				<cfoutput>#Session.GameTime#</cfoutput>
				
		<cfinclude template="LoadBoxscoreDataNBA.cfm">
	</cfif>
</cfif>

<cfif IsDefined("LoadSpreads")>
	<cfinclude template="LoadGamesFromWeb.cfm">
</cfif>


<cfif IsDefined("GameSimHA")>
	<cfinclude template="GameSimUltimateHomeAway.cfm">
</cfif>

<cfif IsDefined("FigurePicks")>
	<cfinclude template="FigureOutPicks.cfm">
</cfif>

<cfif IsDefined("ShowPicks")>
	<cfinclude template="PicksReport.cfm">
</cfif>


<cfif IsDefined("PowerPicks")>
	<cfinclude template="NBAPowerRatingPicks.cfm">
</cfif>

<cfif IsDefined("GameSim")>
	<cfinclude template="NBAGameSim6.cfm">
</cfif>

<cfif IsDefined("CommonOpp")>
	<cfinclude template="CommonOpponentSys.cfm">
</cfif>

<cfif IsDefined("PowerSys")>
	<cfinclude template="PowerSystem.cfm">
</cfif>


<form method="post" action="NbaDriver.cfm">

<cfoutput>
<input type="hidden" value="#myyear#"  name="hdn_Year">
<input type="hidden" value="#mymonth#" name="hdn_Month">
<input type="hidden" value="#myday#"   name="hdn_Day">
</cfoutput>

<Table align="center" border="0" width="800">
<tr>
<td colspan="4" align="center">
Day Of Game: (yyyymmdd) <input name="Gametime" type="text" value="<cfoutput>#mydate#</cfoutput>" maxlength="10" length="10">
<p>
</td>
<tr>
<td>
<input type="Submit" name="LoadData" value="Load Boxscore Data">
</td>

<td>
<input type="Submit" name="LoadSpreads" value="Load Daily Spreads">
</td>


<td>
<input type="Submit" name="GameSimHA" value="Make Picks GameSimHA">
</td>
<td>
<input type="Submit" name="FigurePicks" value="Figure Our Picks">
</td>
<td>
<input type="Submit" name="ShowPicks" value="Show Picks">
</td>

<td>
<input type="Submit" name="PowerPicks" value="Run Power Rating Picks">
</td>
<td>
<input type="Submit" name="GameSim" value="Run Game Simulator Picks">
</td>
<td>
<input type="Submit" name="CommonOpp" value="Run Common Opponent Picks">
</td>
<td>
<input type="Submit" name="PowerSys" value="Run Power System">
</td>

</tr>
</table>
</form>

</body>
</html>
