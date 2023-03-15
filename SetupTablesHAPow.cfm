<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>


<cfset mygametime = Session.gametime>

<!---
This needs to run after you create the Home and Away Averages

--->
<cfinclude template="SetupHAAvgs.cfm">

<body>

<cfquery name="GetTeams" datasource="nba" >
SELECT *
FROM nbaschedule
where trim(GAMETIME) = '#myGAMETIME#'
</cfquery>

<cfloop query="getteams">
<cfloop index="hh" from="1" to="2">


	<cfif hh is 1>
		<cfif ha is 'H'>
			<cfset Teamha = 'H'>
			<cfset Oppha  = 'A'>
		<cfelse>
			<cfset Teamha = 'A'>
			<cfset Oppha  = 'H'>
		</cfif>
	<cfelse>
		<cfif ha is 'H'>
			<cfset Teamha = 'A'>
			<cfset Oppha  = 'H'>
		<cfelse>
			<cfset Teamha = 'H'>
			<cfset Oppha  = 'A'>
		</cfif>
	</cfif>
	
	<cfif hh is 1>
		<cfset Team = '#getteams.Fav#'>
		<cfset opp  = '#getteams.und#'>
	<cfelse>
		<cfset Team = '#getteams.und#'>
		<cfset opp = '#getteams.fav#'>
		
	</cfif>
	
	
	<!--- For each Team, see how they did versus the avgs of their opponent  --->
	
	<cfquery  datasource="nba" name="GetAdv">
	Select 
 	  f.opp,
	  a.dfga                      as oppdfga,
	  (100*a.ofgpct)              as jim1,
	  f.dfgpct                    as jim2,
	  f.ofgpct                    as jim3,
	  (100 * a.dfgpct)            as jim4,
	  f.ofga - f.otpa              as favfga,
	  (f.ofga - f.otpa) -  a.dfga as oPowFGa,
	  f.oTpa -  a.dtpa            as oPowTPa,	
      f.oFta -  a.dfta            as oPowFTa,
	  ((f.ofgm - f.otpm)/(f.ofga - f.otpa)*100) - (100 * a.dfgpct) as oPowFGpct,
	  f.oTppct - (100 * a.dtppct) as oPowTPpct, 
	  
	  	  
	  a.ofga - (f.dfga - f.dtpa)  as dPowFGa,
	  a.oTpa - f.dtpa             as dPowTPa,	
      a.oFta - f.dfta             as dPowFTa,

	  (100 * a.ofgpct) - ((f.dfgm - f.dtpm)/(f.dfga - f.dtpa)*100) as dPowFGpct,
	  (100*a.otppct) - f.dtppct   as dPowTPpct

 	from nbadata f, nbaavgs a
  	where f.opp = a.Team
	and   f.Team = '#Team#'
	and   f.ha   = '#Teamha#'
	and   f.GameTime < '#myGameTime#'

	</cfquery>

	<cfoutput>************************Rowcount = #GetAdv.recordcount#<br>********************</cfoutput>
	
	
	
	<cfset oPowFGaover   = 0>
	<cfset oPowFGpctover = 0>
	<cfset oPowTPaover   = 0>
	<cfset oPowTPpctover = 0>
	<cfset oPowFTaover   = 0>	

	<cfset dPowFGaover   = 0>
	<cfset dPowFGpctover = 0>
	<cfset dPowTPaover   = 0>
	<cfset dPowTPpctover = 0>
	<cfset dPowFTaover   = 0>
	
	<cfset ct            = 0>	
		
	<cfoutput query="GetAdv">
	
	<cfset ct = ct + 1>
	
	<cfif oPowFGA Gt 0>
		<cfset oPowFGAover = oPowFGAover + 1>
	</cfif>
	
	<cfif oPowFGpct Gt 0>
		<cfset oPowFGpctover = oPowFGpctover + 1>
	</cfif>

	<cfif dPowFGa Gt 0>
		<cfset dPowFGaover = dPowFGaover + 1>
	</cfif>
	
	<cfif dPowFGpct Gt 0>
		<cfset dPowFGpctover = dPowFGpctover + 1>
	</cfif>

	<cfif oPowTPa Gt 0>
		<cfset oPowTPaover = oPowTPaover + 1>
	</cfif>

	<cfif oPowTPpct Gt 0>
		<cfset oPowTPpctover = oPowTPpctover + 1>
	</cfif>
	
	<cfif dPowTPa Gt 0>
		<cfset dPowTPaover = dPowTPaover + 1>
	</cfif>

	<cfif dPowTPpct Gt 0>
		<cfset dPowTPpctover = dPowTPpctover + 1>
	</cfif>

	
	<cfif oPowFTa Gt 0>
		<cfset oPowFTaover = oPowFTaover + 1>
	</cfif>
	
	<cfif dPowFTa Gt 0>
		<cfset dPowFTaover = dPowFTaover + 1>
	</cfif>

	
	</cfoutput>
	
	<cfquery  datasource="nba" name="Addit">

	Insert Into NBAPcts
	(
	Team,
	oFga,
	oFgpct,
	oTpa,
	oTppct,
	oFta,
	dFga,
	dFgpct,
	dTpa,
	dTppct,
	dFta
	
	)
	values
	(
	'#Team#',
	#100*(oPowFGaover/ct)#,
	#100*(oPowFGpctover/ct)#,
	#100*(oPowTPaover/ct)#,
	#100*(oPowTPpctover/ct)#,
	#100*(oPowFTaover/ct)#,
	#100*(dPowFGaover/ct)#,
	#100*(dPowFGpctover/ct)#,
	#100*(dPowTPaover/ct)#,
	#100*(dPowTPpctover/ct)#,
	#100*(dPowFTaover/ct)#
	
	)
	</cfquery>	
	
	
	<cfset ct = 0>
	<cfset oPowFGaover = 0>
	<cfset oPowFGpctover = 0>
	<cfset dPowFGaover = 0>
	<cfset dPowFGpctover = 0>


	<cfset oPowTPaover = 0>
	<cfset oPowTPpctover = 0>
	<cfset dPowTPaover = 0>
	<cfset dPowTPpctover = 0>
	
------------------------------------------------------------------------------------------------------------------------------	
Offense - FGA	
	
	<cfset oZone1 = 0>
	<cfset oZone2 = 0>
	<cfset oZone3 = 0>
	<cfset oZone4 = 0>

	<cfset uZone1 = 0>
	<cfset uZone2 = 0>
	<cfset uZone3 = 0>
	<cfset uZone4 = 0>

	<cfset oPowFGaover  = 0>
	<cfset oPowFGaunder = 0>
	<cfset ct = 0>
	
	<cfoutput query="GetAdv">
	
	 <!-- #opp#.............#jim3#....#jim4#  <cfif jim3 gt jim4>Good</cfif><br> -->
	<cfset ct = ct + 1>
	<cfset picked = false>
	<cfif oPowFGa Ge 0>
		<cfset oPowFGaover = oPowFGaover + 1>
	
		<cfif round(oPowFGa) Ge 0 and round(oPowFGa) le 4>
			<cfset oZone1 = oZone1 + 1>
			<cfset picked = true>
		</cfif> 
	
		<cfif round(oPowFGa) Ge 5 and round(oPowFGa) le 10>
			<cfset oZone2 = oZone2 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(oPowFGa) Ge 11 and round(oPowFGa) le 15>
			<cfset oZone3 = oZone3 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(oPowFGa) Ge 16>
			<cfset oZone4 = oZone4 + 1>
			<cfset picked = true>			
		</cfif> 

		<cfif picked is false>
		Didn't find #oPowFGa#<br>
		</cfif>
		
		
	<cfelse>

		<cfset oPowFGaunder = oPowFGaunder + 1>
	
		<cfif round(oPowFGa) le -1 and round(oPowFGa) ge -4>
			<cfset uZone1 = uZone1 + 1>
		</cfif> 
	
		<cfif round(oPowFGa) le -5 and round(oPowFGa) ge -10>
			<cfset uZone2 = uZone2 + 1>
		</cfif> 
	
		<cfif round(oPowFGa) le -11 and round(oPowFGa) ge -15>
			<cfset uZone3 = uZone3 + 1>
		</cfif> 
	
		<cfif round(oPowFGa) le -16>
			<cfset uZone4 = uZone4 + 1>
		</cfif> 
	
	</cfif>	
	
	</cfoutput>	

	<cfoutput>
	#fav#<br>
	Zone1: #100*(ozone1/oPowFGaover)#<br>
	Zone2: #100*(ozone2/oPowFGaover)#<br>
	Zone3: #100*(ozone3/oPowFGaover)#<br>
	Zone4: #100*(ozone4/oPowFGaover)#<br>		
	
	Zone1: #100*(uzone1/oPowFGaunder)#<br>
	Zone2: #100*(uzone2/oPowFGaunder)#<br>
	Zone3: #100*(uzone3/oPowFGaunder)#<br>
	Zone4: #100*(uzone4/oPowFGaunder)#<br>	
	
	<cfquery datasource="NBA" name="Updateit">
	Update NBApcts
	Set 
	oofgaz1 = #100*(ozone1/oPowFGaover)#,
	oofgaz2 = #100*(ozone2/oPowFGaover)#,
	oofgaz3 = #100*(ozone3/oPowFGaover)#,
	oofgaz4 = #100*(ozone4/oPowFGaover)#,
	oufgaz1 = #100*(Uzone1/oPowFGaunder)#,
	oufgaz2 = #100*(Uzone2/oPowFGaunder)#,
	oufgaz3 = #100*(Uzone3/oPowFGaunder)#,
	oufgaz4 = #100*(Uzone4/oPowFGaunder)#
	
	where Team = '#team#'
	</cfquery>
	</cfoutput>	
	
----------------------------------------------------------------------------------------------------------------------------	
	
	<cfset oZone1 = 0>
	<cfset oZone2 = 0>
	<cfset oZone3 = 0>
	<cfset oZone4 = 0>

	<cfset uZone1 = 0>
	<cfset uZone2 = 0>
	<cfset uZone3 = 0>
	<cfset uZone4 = 0>
	<cfset ct = 0>
	
	<cfset oPowFGpctover = 0>
	<cfset oPowFGPctunder =0>
	
	<cfoutput query="GetAdv">
		<cfset test = oPowFGpct>
	
	 <!-- #opp#.............#jim3#....#jim4#  <cfif jim3 gt jim4>Good</cfif><br> -->
	<cfset ct = ct + 1>
	<cfset picked = false>
	<cfif test Ge 0>
		<cfset oPowFGPctover = oPowFGpctover + 1>
	
		<cfif round(test) Ge 0 and round(test) le 4>
			<cfset oZone1 = oZone1 + 1>
			<cfset picked = true>
		</cfif> 
	
		<cfif round(test) Ge 5 and round(test) le 10>
			<cfset oZone2 = oZone2 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(test) Ge 11 and round(test) le 15>
			<cfset oZone3 = oZone3 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(test) Ge 16>
			<cfset oZone4 = oZone4 + 1>
			<cfset picked = true>			
		</cfif> 

		<cfif picked is false>
		Didn't find #test#<br>
		</cfif>
		
		
	<cfelse>

		<cfset oPowFGpctunder = oPowFGpctunder + 1>
	
		<cfif round(test) le -1 and round(test) ge -4>
			<cfset uZone1 = uZone1 + 1>
		</cfif> 
	
		<cfif round(test) le -5 and round(test) ge -10>
			<cfset uZone2 = uZone2 + 1>
		</cfif> 
	
		<cfif round(test) le -11 and round(test) ge -15>
			<cfset uZone3 = uZone3 + 1>
		</cfif> 
	
		<cfif round(test) le -16>
			<cfset uZone4 = uZone4 + 1>
		</cfif> 
	
	</cfif>	
	
	</cfoutput>	

	<cfoutput>
	<br>FGPCT....<br>
	#fav#<br>
	Zone1: #100*(ozone1/oPowFGpctover)#<br>
	Zone2: #100*(ozone2/oPowFGpctover)#<br>
	Zone3: #100*(ozone3/oPowFGPctover)#<br>
	Zone4: #100*(ozone4/oPowFGpctover)#<br>		
	
	Zone1: #100*(uzone1/oPowFGpctunder)#<br>
	Zone2: #100*(uzone2/oPowFGpctunder)#<br>
	Zone3: #100*(uzone3/oPowFGpctunder)#<br>
	Zone4: #100*(uzone4/oPowFGpctunder)#<br>		


	<cfquery datasource="NBA" name="Updateit">
	Update NBApcts
	Set 
	ooFGpctz1 = #100*(ozone1/oPowFGpctover)#,
	ooFGpctz2 = #100*(ozone2/oPowFGpctover)#,
	ooFGpctz3 = #100*(ozone3/oPowFGpctover)#,
	ooFGpctz4 = #100*(ozone4/oPowFGpctover)#,
	
	ouFGpctz1 = #100*(uzone1/oPowFGPctunder)#,
	ouFGpctz2 = #100*(uzone2/oPowFGPctunder)#,
	ouFGpctz3 = #100*(uzone3/oPowFGPctunder)#,
	ouFGpctz4 = #100*(uzone4/oPowFGPctunder)#
	
	where Team = '#team#'
	</cfquery> 

	</cfoutput>	

-------------------------------------------------------------------------------------------------------------------------------	
Defense - FGpct	

	<cfset oZone1 = 0>
	<cfset oZone2 = 0>
	<cfset oZone3 = 0>
	<cfset oZone4 = 0>

	<cfset uZone1 = 0>
	<cfset uZone2 = 0>
	<cfset uZone3 = 0>
	<cfset uZone4 = 0>
	<cfset ct = 0>
	<cfset dPowFGpctover = 0>
	<cfset dPowFGpctunder = 0>
	
	<cfoutput query="GetAdv">
		<cfset test = dPowFGpct>
	
	 <!-- #opp#.............#jim3#....#jim4#  <cfif jim3 gt jim4>Good</cfif><br> -->
	<cfset ct = ct + 1>
	<cfset picked = false>
	<cfif test Ge 0>
		<cfset dPowFGpctover = dPowFGpctover + 1>
	
		<cfif round(test) Ge 0 and round(test) le 4>
			<cfset oZone1 = oZone1 + 1>
			<cfset picked = true>
		</cfif> 
	
		<cfif round(test) Ge 5 and round(test) le 10>
			<cfset oZone2 = oZone2 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(test) Ge 11 and round(test) le 15>
			<cfset oZone3 = oZone3 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(test) Ge 16>
			<cfset oZone4 = oZone4 + 1>
			<cfset picked = true>			
		</cfif> 

		<cfif picked is false>
		Didn't find #test#<br>
		</cfif>
		
		
	<cfelse>

		<cfset dPowFGpctunder = dPowFGpctunder + 1>
	
		<cfif round(test) le -1 and round(test) ge -4>
			<cfset uZone1 = uZone1 + 1>
		</cfif> 
	
		<cfif round(test) le -5 and round(test) ge -10>
			<cfset uZone2 = uZone2 + 1>
		</cfif> 
	
		<cfif round(test) le -11 and round(test) ge -15>
			<cfset uZone3 = uZone3 + 1>
		</cfif> 
	
		<cfif round(test) le -16>
			<cfset uZone4 = uZone4 + 1>
		</cfif> 
	
	</cfif>	
	
	</cfoutput>	

	<cfoutput>
	<br>dFGPCT....<br>
	#fav#<br>
	Zone1: #100*(ozone1/dPowFGpctover)#<br>
	Zone2: #100*(ozone2/dPowFGpctover)#<br>
	Zone3: #100*(ozone3/dPowFGpctover)#<br>
	Zone4: #100*(ozone4/dPowFGpctover)#<br>		
	
	Zone1: #100*(uzone1/dPowFGpctunder)#<br>
	Zone2: #100*(uzone2/dPowFGpctunder)#<br>
	Zone3: #100*(uzone3/dPowFGpctunder)#<br>
	Zone4: #100*(uzone4/dPowFGpctunder)#<br>		


	<cfquery datasource="NBA" name="Updateit">
	Update NBApcts
	Set 
	dofgpctz1 = #100*(ozone1/dPowFGpctover)#,
	dofgpctz2 = #100*(ozone2/dPowFGpctover)#,
	dofgpctz3 = #100*(ozone3/dPowFGpctover)#,
	dofgpctz4 = #100*(ozone4/dPowFGpctover)#,
	dufgpctz1 = #100*(uzone1/dPowFGpctunder)#,
	dufgpctz2 = #100*(uzone2/dPowFGpctunder)#,
	dufgpctz3 = #100*(uzone3/dPowFGpctunder)#,
	dufgpctz4 = #100*(uzone4/dPowFGpctunder)#
	
	where Team = '#team#'
	</cfquery>

	</cfoutput>		
----------------------------------------------------------------------------------------------------------------------------	
Offense - 3pt pct	

	<cfset oZone1 = 0>
	<cfset oZone2 = 0>
	<cfset oZone3 = 0>
	<cfset oZone4 = 0>

	<cfset uZone1 = 0>
	<cfset uZone2 = 0>
	<cfset uZone3 = 0>
	<cfset uZone4 = 0>
	<cfset ct = 0>
	<cfset oPowTPpctover = 0>
	<cfset oPowTPpctunder =0>
	
	<cfoutput query="GetAdv">
		<cfset test = oPowTPpct>
	
	 <!-- #opp#.............#jim3#....#jim4#  <cfif jim3 gt jim4>Good</cfif><br> -->
	<cfset ct = ct + 1>
	<cfset picked = false>
	<cfif test Ge 0>
		<cfset oPowTPpctover = oPowTPpctover + 1>
	
		<cfif round(test) Ge 0 and round(test) le 4>
			<cfset oZone1 = oZone1 + 1>
			<cfset picked = true>
		</cfif> 
	
		<cfif round(test) Ge 5 and round(test) le 10>
			<cfset oZone2 = oZone2 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(test) Ge 11 and round(test) le 15>
			<cfset oZone3 = oZone3 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(test) Ge 16>
			<cfset oZone4 = oZone4 + 1>
			<cfset picked = true>			
		</cfif> 

		<cfif picked is false>
		Didn't find #test#<br>
		</cfif>
		
		
	<cfelse>

		<cfset oPowTPpctunder = oPowTPpctunder + 1>
	
		<cfif round(test) le -1 and round(test) ge -4>
			<cfset uZone1 = uZone1 + 1>
		</cfif> 
	
		<cfif round(test) le -5 and round(test) ge -10>
			<cfset uZone2 = uZone2 + 1>
		</cfif> 
	
		<cfif round(test) le -11 and round(test) ge -15>
			<cfset uZone3 = uZone3 + 1>
		</cfif> 
	
		<cfif round(test) le -16>
			<cfset uZone4 = uZone4 + 1>
		</cfif> 
	
	</cfif>	
	
	</cfoutput>	

	<cfoutput>
	<br>TPPCT....<br>
	#team#<br>
	Zone1: #100*(ozone1/oPowTPpctover)#<br>
	Zone2: #100*(ozone2/oPowTPpctover)#<br>
	Zone3: #100*(ozone3/oPowTPpctover)#<br>
	Zone4: #100*(ozone4/oPowTPpctover)#<br>		
	
	Zone1: #100*(uzone1/oPowTPpctunder)#<br>
	Zone2: #100*(uzone2/oPowTPpctunder)#<br>
	Zone3: #100*(uzone3/oPowTPpctunder)#<br>
	Zone4: #100*(uzone4/oPowTPpctunder)#<br>		

	<cfquery datasource="NBA" name="Updateit">
	Update NBApcts
	Set 
	ooTPpctz1 = #100*(ozone1/oPowTPpctover)#,
	ooTPpctz2 = #100*(ozone2/oPowTPpctover)#,
	ooTPpctz3 = #100*(ozone3/oPowTPpctover)#,
	ooTPpctz4 = #100*(ozone4/oPowTPpctover)#,
	
	ouTPpctz1 = #100*(uzone1/oPowTPpctunder)#,
	ouTPpctz2 = #100*(uzone2/oPowTPpctunder)#,
	ouTPpctz3 = #100*(uzone3/oPowTPpctunder)#,
	ouTPpctz4 = #100*(uzone4/oPowTPpctunder)#
	
	where Team = '#team#'
	</cfquery> 
	</cfoutput>	
	
----------------------------------------------------------------------------------------------------------------------------	
	
	<cfset oZone1 = 0>
	<cfset oZone2 = 0>
	<cfset oZone3 = 0>
	<cfset oZone4 = 0>

	<cfset uZone1 = 0>
	<cfset uZone2 = 0>
	<cfset uZone3 = 0>
	<cfset uZone4 = 0>
	<cfset ct = 0>
	<cfset oPowFTaover = 0>
	<cfset oPowFTaunder =0>
	
	<cfoutput query="GetAdv">
		<cfset test = oPowFTa>
	
	 <!-- #opp#.............#jim3#....#jim4#  <cfif jim3 gt jim4>Good</cfif><br> -->
	<cfset ct = ct + 1>
	<cfset picked = false>
	<cfif test Ge 0>
		<cfset oPowFTaover = oPowFTaover + 1>
	
		<cfif round(test) Ge 0 and round(test) le 4>
			<cfset oZone1 = oZone1 + 1>
			<cfset picked = true>
		</cfif> 
	
		<cfif round(test) Ge 5 and round(test) le 10>
			<cfset oZone2 = oZone2 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(test) Ge 11 and round(test) le 15>
			<cfset oZone3 = oZone3 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(test) Ge 16>
			<cfset oZone4 = oZone4 + 1>
			<cfset picked = true>			
		</cfif> 

		<cfif picked is false>
		Didn't find #test#<br>
		</cfif>
		
		
	<cfelse>

		<cfset oPowFTaunder = oPowFTaunder + 1>
	
		<cfif round(test) le -1 and round(test) ge -4>
			<cfset uZone1 = uZone1 + 1>
		</cfif> 
	
		<cfif round(test) le -5 and round(test) ge -10>
			<cfset uZone2 = uZone2 + 1>
		</cfif> 
	
		<cfif round(test) le -11 and round(test) ge -15>
			<cfset uZone3 = uZone3 + 1>
		</cfif> 
	
		<cfif round(test) le -16>
			<cfset uZone4 = uZone4 + 1>
		</cfif> 
	
	</cfif>	
	
	</cfoutput>	

	<cfoutput>
	<br>FTA....<br>
	#team#<br>
	Zone1: #100*(ozone1/oPowFtaover)#<br>
	Zone2: #100*(ozone2/oPowFtaover)#<br>
	Zone3: #100*(ozone3/oPowFtaover)#<br>
	Zone4: #100*(ozone4/oPowFtaover)#<br>		
	
	Zone1: #100*(uzone1/oPowFtaunder)#<br>
	Zone2: #100*(uzone2/oPowFtaunder)#<br>
	Zone3: #100*(uzone3/oPowFtaunder)#<br>
	Zone4: #100*(uzone4/oPowFtaunder)#<br>		


	<cfquery datasource="NBA" name="Updateit">
	Update NBApcts
	Set 
	ooFTAz1 = #100*(ozone1/oPowFtaover)#,
	ooFTAz2 = #100*(ozone2/oPowFtaover)#,
	ooFTAz3 = #100*(ozone3/oPowFtaover)#,
	ooFTAz4 = #100*(ozone4/oPowFtaover)#,
	
	ouFTAz1 = #100*(uzone1/oPowFTAunder)#,
	ouFTAz2 = #100*(uzone2/oPowFTAunder)#,
	ouFTAz3 = #100*(uzone3/oPowFTAunder)#,
	ouFTAz4 = #100*(uzone4/oPowFTAunder)#
	
	where Team = '#team#'
	</cfquery> 


	</cfoutput>	
	
----------------------------------------------------------------------------------------------------------------------------	
	


----------------------------------------------------------------------------------------------------------------------------	
	
	<cfset oZone1 = 0>
	<cfset oZone2 = 0>
	<cfset oZone3 = 0>
	<cfset oZone4 = 0>

	<cfset uZone1 = 0>
	<cfset uZone2 = 0>
	<cfset uZone3 = 0>
	<cfset uZone4 = 0>
	<cfset ct = 0>
	<cfset oPowTPaover = 0>
	<cfset oPowTPaunder =0>
	
	<cfoutput query="GetAdv">
		<cfset test = oPowTPa>
	
	 <!-- #opp#.............#jim3#....#jim4#  <cfif jim3 gt jim4>Good</cfif><br> -->
	<cfset ct = ct + 1>
	<cfset picked = false>
	<cfif test Ge 0>
		<cfset oPowTPaover = oPowTPaover + 1>
	
		<cfif round(test) Ge 0 and round(test) le 4>
			<cfset oZone1 = oZone1 + 1>
			<cfset picked = true>
		</cfif> 
	
		<cfif round(test) Ge 5 and round(test) le 10>
			<cfset oZone2 = oZone2 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(test) Ge 11 and round(test) le 15>
			<cfset oZone3 = oZone3 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(test) Ge 16>
			<cfset oZone4 = oZone4 + 1>
			<cfset picked = true>			
		</cfif> 

		<cfif picked is false>
		Didn't find #test# <cfabort><br>
		</cfif>
		
		
	<cfelse>

		<cfset oPowTPaunder = oPowTPaunder + 1>
	
		<cfif round(test) le -1 and round(test) ge -4>
			<cfset uZone1 = uZone1 + 1>
		</cfif> 
	
		<cfif round(test) le -5 and round(test) ge -10>
			<cfset uZone2 = uZone2 + 1>
		</cfif> 
	
		<cfif round(test) le -11 and round(test) ge -15>
			<cfset uZone3 = uZone3 + 1>
		</cfif> 
	
		<cfif round(test) le -16>
			<cfset uZone4 = uZone4 + 1>
		</cfif> 
	
	</cfif>	
	
	</cfoutput>	

	<cfoutput>
	<br>TPA....<br>
	#team#...#uzone1#...#uzone2#...#uzone3#...#uzone4#<br>
	
	<cfif #ozone1# neq 0>
	<cfquery datasource="NBA" name="Updateit">
		Update NBApcts
		Set 
		ooTPAz1 = #100*(ozone1/oPowTPAover)#,
		ooTPAz2 = #100*(ozone2/oPowTPAover)#,
		ooTPAz3 = #100*(ozone3/oPowTPAover)#,
		ooTPAz4 = #100*(ozone4/oPowTPAover)#
		where Team = '#team#'
	</cfquery> 
	<cfelse>
		<cfquery datasource="NBA" name="Updateit">
		Update NBApcts
		Set 
		ooTPAz1 = 0,
		ooTPAz2 = 0,
		ooTPAz3 = 0,
		ooTPAz4 = 0
		where Team = '#team#'	
		</cfquery>
	</cfif>

	<cfif #uzone1# neq 0>
	<cfquery datasource="NBA" name="Updateit">
		Update NBApcts
		Set 
		ouTPAz1 = #100*(uzone1/oPowTPAunder)#,
		ouTPAz2 = #100*(uzone2/oPowTPAunder)#,
		ouTPAz3 = #100*(uzone3/oPowTPAunder)#,
		ouTPAz4 = #100*(uzone4/oPowTPAunder)#
		where Team = '#team#'
	</cfquery> 
	<cfelse>
		<cfquery datasource="NBA" name="Updateit">
		Update NBApcts
		Set 
		ouTPAz1 = 0,
		ouTPAz2 = 0,
		ouTPAz3 = 0,
		ouTPAz4 = 0
		where Team = '#team#'
		</cfquery> 
	</cfif>	
	</cfoutput>	
	
----------------------------------------------------------------------------------------------------------------------------	
	





















----------------------------------------------------------------------------------------------------------------------------	
	
	<cfset oZone1 = 0>
	<cfset oZone2 = 0>
	<cfset oZone3 = 0>
	<cfset oZone4 = 0>

	<cfset uZone1 = 0>
	<cfset uZone2 = 0>
	<cfset uZone3 = 0>
	<cfset uZone4 = 0>
	<cfset ct = 0>
	<cfset dPowFGaover = 0>
	<cfset dPowFGaunder =0>
	
	<cfoutput query="GetAdv">
		<cfset test = dPowFGA>
	
	 <!-- #opp#.............#jim3#....#jim4#  <cfif jim3 gt jim4>Good</cfif><br> -->
	<cfset ct = ct + 1>
	<cfset picked = false>
	<cfif test Ge 0>
		<cfset dPowFGaover = dPowFGaover + 1>
	
		<cfif round(test) Ge 0 and round(test) le 4>
			<cfset oZone1 = oZone1 + 1>
			<cfset picked = true>
		</cfif> 
	
		<cfif round(test) Ge 5 and round(test) le 10>
			<cfset oZone2 = oZone2 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(test) Ge 11 and round(test) le 15>
			<cfset oZone3 = oZone3 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(test) Ge 16>
			<cfset oZone4 = oZone4 + 1>
			<cfset picked = true>			
		</cfif> 

		<cfif picked is false>
		Didn't find #test#<br>
		</cfif>
		
		
	<cfelse>

		<cfset dPowFGaunder = dPowFGaunder + 1>
	
		<cfif round(test) le -1 and round(test) ge -4>
			<cfset uZone1 = uZone1 + 1>
		</cfif> 
	
		<cfif round(test) le -5 and round(test) ge -10>
			<cfset uZone2 = uZone2 + 1>
		</cfif> 
	
		<cfif round(test) le -11 and round(test) ge -15>
			<cfset uZone3 = uZone3 + 1>
		</cfif> 
	
		<cfif round(test) le -16>
			<cfset uZone4 = uZone4 + 1>
		</cfif> 
	
	</cfif>	
	
	</cfoutput>	

	<cfoutput>

	<cfquery datasource="NBA" name="Updateit">
	Update NBApcts
	Set 
	doFGAz1 = #100*(ozone1/dPowFGAover)#,
	doFGAz2 = #100*(ozone2/dPowFGAover)#,
	doFGAz3 = #100*(ozone3/dPowFGAover)#,
	doFGAz4 = #100*(ozone4/dPowFGAover)#,
	
	duFGAz1 = #100*(uzone1/dPowFGAunder)#,
	duFGAz2 = #100*(uzone2/dPowFGAunder)#,
	duFGAz3 = #100*(uzone3/dPowFGAunder)#,
	duFGAz4 = #100*(uzone4/dPowFGAunder)#
	
	where Team = '#team#'
	</cfquery> 



	</cfoutput>	
	
----------------------------------------------------------------------------------------------------------------------------	










----------------------------------------------------------------------------------------------------------------------------	
	
	<cfset oZone1 = 0>
	<cfset oZone2 = 0>
	<cfset oZone3 = 0>
	<cfset oZone4 = 0>

	<cfset uZone1 = 0>
	<cfset uZone2 = 0>
	<cfset uZone3 = 0>
	<cfset uZone4 = 0>
	<cfset ct = 0>
	<cfset dPowTPaover = 0>
	<cfset dPowTPaunder =0>
	
	<cfoutput query="GetAdv">
		<cfset test = dPowTPA>
	
	 <!-- #opp#.............#jim3#....#jim4#  <cfif jim3 gt jim4>Good</cfif><br> -->
	<cfset ct = ct + 1>
	<cfset picked = false>
	<cfif test Ge 0>
		<cfset dPowTPaover = dPowTPaover + 1>
	
		<cfif round(test) Ge 0 and round(test) le 4>
			<cfset oZone1 = oZone1 + 1>
			<cfset picked = true>
		</cfif> 
	
		<cfif round(test) Ge 5 and round(test) le 10>
			<cfset oZone2 = oZone2 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(test) Ge 11 and round(test) le 15>
			<cfset oZone3 = oZone3 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(test) Ge 16>
			<cfset oZone4 = oZone4 + 1>
			<cfset picked = true>			
		</cfif> 

		<cfif picked is false>
		Didn't find #test#<br>
		</cfif>
		
		
	<cfelse>

		<cfset dPowTPaunder = dPowTPaunder + 1>
	
		<cfif round(test) le -1 and round(test) ge -4>
			<cfset uZone1 = uZone1 + 1>
		</cfif> 
	
		<cfif round(test) le -5 and round(test) ge -10>
			<cfset uZone2 = uZone2 + 1>
		</cfif> 
	
		<cfif round(test) le -11 and round(test) ge -15>
			<cfset uZone3 = uZone3 + 1>
		</cfif> 
	
		<cfif round(test) le -16>
			<cfset uZone4 = uZone4 + 1>
		</cfif> 
	
	</cfif>	
	
	</cfoutput>	

	<cfoutput>

	<cfquery datasource="NBA" name="Updateit">
	Update NBApcts
	Set 
	doTPAz1 = #100*(ozone1/dPowTPAover)#,
	doTPAz2 = #100*(ozone2/dPowTPAover)#,
	doTPAz3 = #100*(ozone3/dPowTPAover)#,
	doTPAz4 = #100*(ozone4/dPowTPAover)#,
	
	duTPAz1 = #100*(uzone1/dPowTPAunder)#,
	duTPAz2 = #100*(uzone2/dPowTPAunder)#,
	duTPAz3 = #100*(uzone3/dPowTPAunder)#,
	duTPAz4 = #100*(uzone4/dPowTPAunder)#
	
	where Team = '#team#'
	</cfquery> 



	</cfoutput>	
	
----------------------------------------------------------------------------------------------------------------------------	








----------------------------------------------------------------------------------------------------------------------------	
	
	<cfset oZone1 = 0>
	<cfset oZone2 = 0>
	<cfset oZone3 = 0>
	<cfset oZone4 = 0>

	<cfset uZone1 = 0>
	<cfset uZone2 = 0>
	<cfset uZone3 = 0>
	<cfset uZone4 = 0>
	<cfset ct = 0>
	<cfset dPowTPpctover = 0>
	<cfset dPowTPpctunder =0>
	
	<cfoutput query="GetAdv">
		<cfset test = dPowTPpct>
	
	 <!-- #opp#.............#jim3#....#jim4#  <cfif jim3 gt jim4>Good</cfif><br> -->
	<cfset ct = ct + 1>
	<cfset picked = false>
	<cfif test Ge 0>
		<cfset dPowTPpctover = dPowTPpctover + 1>
	
		<cfif round(test) Ge 0 and round(test) le 4>
			<cfset oZone1 = oZone1 + 1>
			<cfset picked = true>
		</cfif> 
	
		<cfif round(test) Ge 5 and round(test) le 10>
			<cfset oZone2 = oZone2 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(test) Ge 11 and round(test) le 15>
			<cfset oZone3 = oZone3 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(test) Ge 16>
			<cfset oZone4 = oZone4 + 1>
			<cfset picked = true>			
		</cfif> 

		<cfif picked is false>
		Didn't find #test#<br>
		</cfif>
		
		
	<cfelse>

		<cfset dPowTPpctunder = dPowTPpctunder + 1>
	
		<cfif round(test) le -1 and round(test) ge -4>
			<cfset uZone1 = uZone1 + 1>
		</cfif> 
	
		<cfif round(test) le -5 and round(test) ge -10>
			<cfset uZone2 = uZone2 + 1>
		</cfif> 
	
		<cfif round(test) le -11 and round(test) ge -15>
			<cfset uZone3 = uZone3 + 1>
		</cfif> 
	
		<cfif round(test) le -16>
			<cfset uZone4 = uZone4 + 1>
		</cfif> 
	
	</cfif>	
	
	</cfoutput>	

	<cfoutput>

	<cfquery datasource="NBA" name="Updateit">
	Update NBApcts
	Set 
	doTPpctz1 = #100*(ozone1/dPowTPpctover)#,
	doTPpctz2 = #100*(ozone2/dPowTPpctover)#,
	doTPpctz3 = #100*(ozone3/dPowTPpctover)#,
	doTPpctz4 = #100*(ozone4/dPowTPpctover)#,
	
	duTPpctz1 = #100*(uzone1/dPowTPpctunder)#,
	duTPpctz2 = #100*(uzone2/dPowTPpctunder)#,
	duTPpctz3 = #100*(uzone3/dPowTPpctunder)#,
	duTPpctz4 = #100*(uzone4/dPowTPpctunder)#
	
	where Team = '#team#'
	</cfquery> 



	</cfoutput>	
	
----------------------------------------------------------------------------------------------------------------------------	








----------------------------------------------------------------------------------------------------------------------------	
	
	<cfset oZone1 = 0>
	<cfset oZone2 = 0>
	<cfset oZone3 = 0>
	<cfset oZone4 = 0>

	<cfset uZone1 = 0>
	<cfset uZone2 = 0>
	<cfset uZone3 = 0>
	<cfset uZone4 = 0>
	<cfset ct = 0>
	<cfset dPowFTaover = 0>
	<cfset dPowFTaunder =0>
	
	<cfoutput query="GetAdv">
		<cfset test = dPowFTA>
	
	 <!-- #opp#.............#jim3#....#jim4#  <cfif jim3 gt jim4>Good</cfif><br> -->
	<cfset ct = ct + 1>
	<cfset picked = false>
	<cfif test Ge 0>
		<cfset dPowFTaover = dPowFTaover + 1>
	
		<cfif round(test) Ge 0 and round(test) le 4>
			<cfset oZone1 = oZone1 + 1>
			<cfset picked = true>
		</cfif> 
	
		<cfif round(test) Ge 5 and round(test) le 10>
			<cfset oZone2 = oZone2 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(test) Ge 11 and round(test) le 15>
			<cfset oZone3 = oZone3 + 1>
			<cfset picked = true>			
		</cfif> 
	
		<cfif round(test) Ge 16>
			<cfset oZone4 = oZone4 + 1>
			<cfset picked = true>			
		</cfif> 

		<cfif picked is false>
		Didn't find #test#<br>
		</cfif>
		
		
	<cfelse>

		<cfset dPowFTaunder = dPowFTaunder + 1>
	
		<cfif round(test) le -1 and round(test) ge -4>
			<cfset uZone1 = uZone1 + 1>
		</cfif> 
	
		<cfif round(test) le -5 and round(test) ge -10>
			<cfset uZone2 = uZone2 + 1>
		</cfif> 
	
		<cfif round(test) le -11 and round(test) ge -15>
			<cfset uZone3 = uZone3 + 1>
		</cfif> 
	
		<cfif round(test) le -16>
			<cfset uZone4 = uZone4 + 1>
		</cfif> 
	
	</cfif>	
	
	</cfoutput>	

	<cfoutput>

	<cfquery datasource="NBA" name="Updateit">
	Update NBApcts
	Set 
	doFTAz1 = #100*(ozone1/dPowFTAover)#,
	doFTAz2 = #100*(ozone2/dPowFTAover)#,
	doFTAz3 = #100*(ozone3/dPowFTAover)#,
	doFTAz4 = #100*(ozone4/dPowFTAover)#,
	
	duFTAz1 = #100*(uzone1/dPowFTAunder)#,
	duFTAz2 = #100*(uzone2/dPowFTAunder)#,
	duFTAz3 = #100*(uzone3/dPowFTAunder)#,
	duFTAz4 = #100*(uzone4/dPowFTAunder)#
	
	where Team = '#team#'
	</cfquery> 



	</cfoutput>	
	
----------------------------------------------------------------------------------------------------------------------------	

</cfloop>	
</cfloop>	




</body>
</html>
