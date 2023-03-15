<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfset Team = 'NYK'>

<cfquery datasource="nbastats"  name="GetPlus10">
Select gametime,opp, ha from nbadata
where team = '#team#'
<!--- and (ps - dps < -7 or ps - dps > 0)  --->
and ps - dps <= -10
</cfquery>


	<cfset GScoring = 0>
	<cfset AScoring = 0>
	<cfset PScoring = 0>
	
	<cfset GRebounding = 0>
	<cfset ARebounding = 0>
	<cfset PRebounding = 0>
	
	<cfset GTurnovers = 0>
	<cfset ATurnovers = 0>
	<cfset PTurnovers = 0>
	
	<cfset Gfgpct = 0>
	<cfset Afgpct = 0>
	<cfset Pfgpct = 0>


<cfset loopct = 0>
<cfoutput query="GetPlus10">

	<cfquery datasource="nba" name="GetGAP">
	Select * from GAP where Team = '#GetPlus10.opp#'
	</cfquery>
		
	<cfloop query="GetGAP">
	
		<cfset loopct = loopct + 1>
		
		<cfif GetGap.Scoring is 'G'>
			<cfset GScoring = Gscoring + 1>
		</cfif>
	
		<cfif GetGap.Scoring is 'A'>
			<cfset AScoring = Ascoring + 1>
		</cfif>

		<cfif GetGap.Scoring is 'P'>
			<cfset PScoring = Pscoring + 1>
		</cfif>

		
		
		<cfif GetGap.Turnovers is 'G'>
			<cfset GTurnovers = GTurnovers + 1>
		</cfif>
	
		<cfif GetGap.Turnovers is 'A'>
			<cfset ATurnovers = ATurnovers + 1>
		</cfif>

		<cfif GetGap.Turnovers is 'P'>
			<cfset PTurnovers = PTurnovers + 1>
		</cfif>

		
		
		<cfif GetGap.Rebounding is 'G'>
			<cfset GRebounding = GRebounding + 1>
		</cfif>
	
		<cfif GetGap.Rebounding is 'A'>
			<cfset ARebounding = ARebounding + 1>
		</cfif>

		<cfif GetGap.Rebounding is 'P'>
			<cfset PRebounding = PRebounding + 1>
		</cfif>

		
		<cfif GetGap.FGpct is 'G'>
			<cfset GFGpct = GFGpct + 1>
		</cfif>
	
		<cfif GetGap.FGpct is 'A'>
			<cfset AFGpct = AFGpct + 1>
		</cfif>

		<cfif GetGap.FGpct is 'P'>
			<cfset PFGpct = PFGpct + 1>
		</cfif>
	
	</cfloop>

</cfoutput>

<cfoutput>
	 GScoring = #(GScoring / loopct)*100#<br> 
	 AScoring = #(AScoring / loopct)*100#<br> 
	 PScoring = #(pScoring / loopct)*100#<br> 
<hr>	
	 GRebounding = #(GRebounding / loopct)*100#<br> 
	 ARebounding = #(ARebounding / loopct)*100#<br>
	 PRebounding = #(pRebounding / loopct)*100#<br>
<hr>	 
	 GTurnovers = #(GTurnovers / loopct)*100#<br> 
	 ATurnovers = #(ATurnovers / loopct)*100#<br>
	 PTurnovers = #(PTurnovers / loopct)*100#<br>
<hr>	
	 Gfgpct = #(Gfgpct / loopct)*100#<br>
	 Afgpct = #(Afgpct / loopct)*100#<br>
	 Pfgpct = #(pfgpct / loopct)*100#<br>

Total Games was: #loopct#
</cfoutput>
</body>
</html>
