<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<!--- <cfset myGametime = Session.gametime> --->

<cfquery  datasource="nbastats" name="Addit">	
delete from NBAPcts
</cfquery>	


<cfquery  datasource="nbastats" name="Addit">	
delete from NBAAvgs
</cfquery>	

<cfset myDate = CreateDate( "#Year(Now())#", "#month(Now())#", "#day(now())#" )>

<cfset myDateCheck = Replace(Mid(ToString(DateAdd("d",myDate,-20)),6,10),'-','','all')>

<!--- Create the Avgs for each team --->
<cfquery  datasource="nbastats" name="GetAdv">
	Select 
	  Team,	
 	  Avg(ofga - otpa) as ofga,
	  Avg(otpa)        as oTpa,	
      Avg(oFta)        as oFta,
	   
	  Avg ( (ofgm - otpm) / (ofga - otpa)) as ofgpct,
	  Avg  (otpm / otpa)                as oTppct, 
	  Avg (oftm / ofta)                   as oFTpct,  
	   
	  Avg(dfga - dtpa) as dfga,
	  Avg(dtpa)        as dTpa,	
      Avg(dFta)        as dFta,
	   
	  Avg ( (dfgm - dtpm) / (dfga - dtpa) ) as dfgpct,
	  Avg  (dtpm / dtpa)                as dTppct,
	  Avg (dftm / dfta)                   as dFTpct  

 	from nbadata 

	where GameTime >= '#myDateCheck#'
	and mins = 240
  	Group by Team
	
	</cfquery>

	<cfoutput query="GetAdv">
	<cfquery  datasource="nbaavgs" name="Add">
	Insert into NBAAvgs
	 (
	  Team,	
	  ofga,
	  oTpa,	
      oFta,
	  ofgpct,
	  oTppct, 
	  oFTpct,  
	  dfga,
	  dTpa,	
      dFta,
	  dfgpct,
	  dTppct, 
	  dFTpct  
	)
	values
	(
	  '#Team#',	
	  #ofga#,
	  #oTpa#,	
      #oFta#,
	  #ofgpct#,
	  #oTppct#, 
	  #oFTpct#,  
		  #dfga#,
	  #dTpa#,	
      #dFta#,
	  #dfgpct#,
	  #dTppct#, 
	  #dFTpct#  
	)
	</cfquery>
	
</cfoutput>	

	
<cfquery  datasource="nbastats" name="GetTeams">	
select distinct team from nbadata	
</cfquery>	

<cfloop query="getteams">
	
	<cfset Fav = '#getteams.team#'>

	
	<!--- For each Team, see how they did versus the avgs of their opponent  --->
	
	<cfquery  datasource="nbastats" name="GetAdv">
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
	and   f.Team = '#fav#'
	and   f.GameTime >= '#myDateCheck#'
	and a.Team in (Select opp from nbadata where team = '#fav#' and gametime >= '#myDateCheck#')
	and f.mins = 240
	order by oPowFGa
	</cfquery>

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
	
	<cfquery  datasource="nbastats" name="Addit">

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
	'#fav#',
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
<!--- 	#fav#<br>
	Zone1: #100*(ozone1/oPowFGaover)#<br>
	Zone2: #100*(ozone2/oPowFGaover)#<br>
	Zone3: #100*(ozone3/oPowFGaover)#<br>
	Zone4: #100*(ozone4/oPowFGaover)#<br>		
	
	Zone1: #100*(uzone1/oPowFGaunder)#<br>
	Zone2: #100*(uzone2/oPowFGaunder)#<br>
	Zone3: #100*(uzone3/oPowFGaunder)#<br>
	Zone4: #100*(uzone4/oPowFGaunder)#<br>	
 --->	


	<cfif oPowFGaover neq 0>
	<cfquery datasource="NBAPcts" name="Updateit">
	Update NBApcts
	Set 
	oofgaz1 = #100*(ozone1/oPowFGaover)#,
	oofgaz2 = #100*(ozone2/oPowFGaover)#,
	oofgaz3 = #100*(ozone3/oPowFGaover)#,
	oofgaz4 = #100*(ozone4/oPowFGaover)#
	where Team = '#fav#'	
	</cfquery>
	</cfif>
	
	<cfif oPowFGaunder neq 0>
	<cfquery datasource="NBAPcts" name="Updateit">
	Update NBApcts
	Set
	oufgaz1 = #100*(Uzone1/oPowFGaunder)#,
	oufgaz2 = #100*(Uzone2/oPowFGaunder)#,
	oufgaz3 = #100*(Uzone3/oPowFGaunder)#,
	oufgaz4 = #100*(Uzone4/oPowFGaunder)#
	where Team = '#fav#'	
	</cfquery>
	</cfif>




</cfoutput>	
	
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
<!--- 	<br>FGPCT....<br>
	#fav#<br>
	Zone1: #100*(ozone1/oPowFGpctover)#<br>
	Zone2: #100*(ozone2/oPowFGpctover)#<br>
	Zone3: #100*(ozone3/oPowFGPctover)#<br>
	Zone4: #100*(ozone4/oPowFGpctover)#<br>		
	
	Zone1: #100*(uzone1/oPowFGpctunder)#<br>
	Zone2: #100*(uzone2/oPowFGpctunder)#<br>
	Zone3: #100*(uzone3/oPowFGpctunder)#<br>
	Zone4: #100*(uzone4/oPowFGpctunder)#<br>		
 --->


	 <cfif oPowFGpctover neq 0>
 
	<cfquery datasource="NBAPcts" name="Updateit">
	Update NBApcts
	Set 
	ooFGpctz1 = #100*(ozone1/oPowFGpctover)#,
	ooFGpctz2 = #100*(ozone2/oPowFGpctover)#,
	ooFGpctz3 = #100*(ozone3/oPowFGpctover)#,
	ooFGpctz4 = #100*(ozone4/oPowFGpctover)#
	where Team = '#fav#'
	</cfquery>
	</cfif>
	
	<cfif oPowFGpctunder neq 0>
	<cfquery datasource="NBAPcts" name="Updateit">
	Update NBApcts
	Set
	ouFGpctz1 = #100*(uzone1/oPowFGPctunder)#,
	ouFGpctz2 = #100*(uzone2/oPowFGPctunder)#,
	ouFGpctz3 = #100*(uzone3/oPowFGPctunder)#,
	ouFGpctz4 = #100*(uzone4/oPowFGPctunder)#
	where Team = '#fav#'
	</cfquery> 
	</cfif>



	</cfoutput>	

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
<!--- 	<br>dFGPCT....<br>
	#fav#<br>
	Zone1: #100*(ozone1/dPowFGpctover)#<br>
	Zone2: #100*(ozone2/dPowFGpctover)#<br>
	Zone3: #100*(ozone3/dPowFGpctover)#<br>
	Zone4: #100*(ozone4/dPowFGpctover)#<br>		
	
	Zone1: #100*(uzone1/dPowFGpctunder)#<br>
	Zone2: #100*(uzone2/dPowFGpctunder)#<br>
	Zone3: #100*(uzone3/dPowFGpctunder)#<br>
	Zone4: #100*(uzone4/dPowFGpctunder)#<br>		
 --->

 <cfset needcomma = true>

	<cfif dPowFGpctover neq 0>
	<cfquery datasource="NBAPcts" name="Updateit">
	Update NBApcts
	Set 
	dofgpctz1 = #100*(ozone1/dPowFGpctover)#,
	dofgpctz2 = #100*(ozone2/dPowFGpctover)#,
	dofgpctz3 = #100*(ozone3/dPowFGpctover)#,
	dofgpctz4 = #100*(ozone4/dPowFGpctover)#
	where Team = '#fav#'
	
	</cfquery>
	</cfif>
	
	<cfif dPowFGpctunder neq 0>
	<cfquery datasource="NBAPcts" name="Updateit">
	Update NBApcts
	Set
	dufgpctz1 = #100*(uzone1/dPowFGpctunder)#,
	dufgpctz2 = #100*(uzone2/dPowFGpctunder)#,
	dufgpctz3 = #100*(uzone3/dPowFGpctunder)#,
	dufgpctz4 = #100*(uzone4/dPowFGpctunder)#
	where Team = '#fav#'
	
	</cfquery>
	</cfif>
	
	</cfoutput>		

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
<!--- 	<br>TPPCT....<br>
	#fav#<br>
	Zone1: #100*(ozone1/oPowTPpctover)#<br>
	Zone2: #100*(ozone2/oPowTPpctover)#<br>
	Zone3: #100*(ozone3/oPowTPpctover)#<br>
	Zone4: #100*(ozone4/oPowTPpctover)#<br>		
	
	Zone1: #100*(uzone1/oPowTPpctunder)#<br>
	Zone2: #100*(uzone2/oPowTPpctunder)#<br>
	Zone3: #100*(uzone3/oPowTPpctunder)#<br>
	Zone4: #100*(uzone4/oPowTPpctunder)#<br>		
 --->
 
	<cfif oPowTPpctover neq 0>
	<cfquery datasource="NBAPcts" name="Updateit">
	Update NBApcts
	Set 

	ooTPpctz1 = #100*(ozone1/oPowTPpctover)#,
	ooTPpctz2 = #100*(ozone2/oPowTPpctover)#,
	ooTPpctz3 = #100*(ozone3/oPowTPpctover)#,
	ooTPpctz4 = #100*(ozone4/oPowTPpctover)#
	where Team = '#fav#'
	</cfquery>
	</cfif>
	
	<cfif oPowTPpctunder neq 0>
	<cfquery datasource="NBAPcts" name="Updateit">
	Update NBApcts
	Set
	ouTPpctz1 = #100*(uzone1/oPowTPpctunder)#,
	ouTPpctz2 = #100*(uzone2/oPowTPpctunder)#,
	ouTPpctz3 = #100*(uzone3/oPowTPpctunder)#,
	ouTPpctz4 = #100*(uzone4/oPowTPpctunder)#
	where Team = '#fav#'
	</cfquery>
	</cfif>

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
<!--- 	<br>FTA....<br>
	#fav#<br>
	Zone1: #100*(ozone1/oPowFtaover)#<br>
	Zone2: #100*(ozone2/oPowFtaover)#<br>
	Zone3: #100*(ozone3/oPowFtaover)#<br>
	Zone4: #100*(ozone4/oPowFtaover)#<br>		
	
	Zone1: #100*(uzone1/oPowFtaunder)#<br>
	Zone2: #100*(uzone2/oPowFtaunder)#<br>
	Zone3: #100*(uzone3/oPowFtaunder)#<br>
	Zone4: #100*(uzone4/oPowFtaunder)#<br>		
 --->

 	<cfif oPowFTaover neq 0>
	<cfquery datasource="NBAPcts" name="Updateit">
	Update NBApcts
	Set 
	ooFTAz1 = #100*(ozone1/oPowFtaover)#,
	ooFTAz2 = #100*(ozone2/oPowFtaover)#,
	ooFTAz3 = #100*(ozone3/oPowFtaover)#,
	ooFTAz4 = #100*(ozone4/oPowFtaover)#
	where Team = '#fav#'
	</cfquery>
	</cfif>
	
	<cfif oPowFTaunder neq 0>
	<cfquery datasource="NBAPcts" name="Updateit">
	Update NBApcts
	Set
	ouFTAz1 = #100*(uzone1/oPowFTAunder)#,
	ouFTAz2 = #100*(uzone2/oPowFTAunder)#,
	ouFTAz3 = #100*(uzone3/oPowFTAunder)#,
	ouFTAz4 = #100*(uzone4/oPowFTAunder)#
	where Team = '#fav#'
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
		Didn't find #test#<br>
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
<!--- 	<br>TPA....<br>
	#fav#<br>
	Zone1: #100*(ozone1/oPowTPaover)#<br>
	Zone2: #100*(ozone2/oPowTPaover)#<br>
	Zone3: #100*(ozone3/oPowTPaover)#<br>
	Zone4: #100*(ozone4/oPowTPaover)#<br>		
	
	Zone1: #100*(uzone1/oPowTPaunder)#<br>
	Zone2: #100*(uzone2/oPowTPaunder)#<br>
	Zone3: #100*(uzone3/oPowTPaunder)#<br>
	Zone4: #100*(uzone4/oPowTPaunder)#<br>		
 --->

 	<cfif oPowTPAover neq 0>
	<cfquery datasource="NBAPcts" name="Updateit">
	Update NBApcts
	Set 

	ooTPAz1 = #100*(ozone1/oPowTPAover)#,
	ooTPAz2 = #100*(ozone2/oPowTPAover)#,
	ooTPAz3 = #100*(ozone3/oPowTPAover)#,
	ooTPAz4 = #100*(ozone4/oPowTPAover)#
	where Team = '#fav#'
	</cfquery>
	</cfif>
	
	<cfif oPowTPAunder neq 0>
	<cfquery datasource="NBAPcts" name="Updateit">
	Update NBApcts
	Set
	ouTPAz1 = #100*(uzone1/oPowTPAunder)#,
	ouTPAz2 = #100*(uzone2/oPowTPAunder)#,
	ouTPAz3 = #100*(uzone3/oPowTPAunder)#,
	ouTPAz4 = #100*(uzone4/oPowTPAunder)#
	where Team = '#fav#'
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

	<cfif dPowFGAover neq 0> 
	<cfquery datasource="NBAPcts" name="Updateit">
	Update NBApcts
	Set 

	doFGAz1 = #100*(ozone1/dPowFGAover)#,
	doFGAz2 = #100*(ozone2/dPowFGAover)#,
	doFGAz3 = #100*(ozone3/dPowFGAover)#,
	doFGAz4 = #100*(ozone4/dPowFGAover)#
	where Team = '#fav#'
	</cfquery>
	</cfif>
	
	<cfif dPowFGAunder neq 0>
	<cfquery datasource="NBAPcts" name="Updateit">
	Update NBApcts
	Set
	duFGAz1 = #100*(uzone1/dPowFGAunder)#,
	duFGAz2 = #100*(uzone2/dPowFGAunder)#,
	duFGAz3 = #100*(uzone3/dPowFGAunder)#,
	duFGAz4 = #100*(uzone4/dPowFGAunder)#
	where Team = '#fav#'
	</cfquery>
	</cfif>


	</cfoutput>	

	
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


	<cfif dPowTPAover neq 0>
	<cfquery datasource="NBAPcts" name="Updateit">
	Update NBApcts
	Set 
	doTPAz1 = #100*(ozone1/dPowTPAover)#,
	doTPAz2 = #100*(ozone2/dPowTPAover)#,
	doTPAz3 = #100*(ozone3/dPowTPAover)#,
	doTPAz4 = #100*(ozone4/dPowTPAover)#
	where Team = '#fav#'
	</cfquery>
	</cfif>
	
	<cfif dPowTPAunder neq 0>
	<cfquery datasource="NBAPcts" name="Updateit">
	Update NBApcts
	Set
	duTPAz1 = #100*(uzone1/dPowTPAunder)#,
	duTPAz2 = #100*(uzone2/dPowTPAunder)#,
	duTPAz3 = #100*(uzone3/dPowTPAunder)#,
	duTPAz4 = #100*(uzone4/dPowTPAunder)#
	where Team = '#fav#'
	</cfquery>
	</cfif>
	
	
	
	</cfoutput>	
	
	
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

	<cfif dPowTPpctover neq 0>
	<cfquery datasource="NBAPcts" name="Updateit">
	Update NBApcts
	Set 
	
	doTPpctz1 = #100*(ozone1/dPowTPpctover)#,
	doTPpctz2 = #100*(ozone2/dPowTPpctover)#,
	doTPpctz3 = #100*(ozone3/dPowTPpctover)#,
	doTPpctz4 = #100*(ozone4/dPowTPpctover)#
	where Team = '#fav#'
	</cfquery>
	</cfif>
	
	<cfif dPowTPpctunder neq 0>
	<cfquery datasource="NBAPcts" name="Updateit">
	Update NBApcts
	Set
	duTPpctz1 = #100*(uzone1/dPowTPpctunder)#,
	duTPpctz2 = #100*(uzone2/dPowTPpctunder)#,
	duTPpctz3 = #100*(uzone3/dPowTPpctunder)#,
	duTPpctz4 = #100*(uzone4/dPowTPpctunder)#
	where Team = '#fav#'
	</cfquery>
	</cfif>
	


	</cfoutput>	
	
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

	<cfif dPowFTAover neq 0>
	<cfquery datasource="NBAPcts" name="Updateit">
	Update NBApcts
	Set 

	doFTAz1 = #100*(ozone1/dPowFTAover)#,
	doFTAz2 = #100*(ozone2/dPowFTAover)#,
	doFTAz3 = #100*(ozone3/dPowFTAover)#,
	doFTAz4 = #100*(ozone4/dPowFTAover)#
	where Team = '#fav#'
	</cfquery>
	</cfif>
	
	<cfif dPowFTAunder neq 0>
	<cfquery datasource="NBAPcts" name="Updateit">	
	Update NBApcts
	Set
	duFTAz1 = #100*(uzone1/dPowFTAunder)#,
	duFTAz2 = #100*(uzone2/dPowFTAunder)#,
	duFTAz3 = #100*(uzone3/dPowFTAunder)#,
	duFTAz4 = #100*(uzone4/dPowFTAunder)#
	where Team = '#fav#'
	</cfquery>
	</cfif>
	
</cfloop>	
	

</body>
</html>
