<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>


<cfset myGametime = Session.GameTime>

<cfquery  datasource="nbas" name="Addit">	
delete from NBAPcts
</cfquery>	


<cfquery name="GetTeams" datasource="nba" >
SELECT *
FROM nbaschedule
where trim(GAMETIME) = '#myGAMETIME#'
</cfquery>

<cfloop query="getteams">

	<cfset fav = '#GetTeams.fav#'>
	<cfset und = '#GetTeams.und#'>
		
	<cfif ha is 'H'>
	
	<!--- Create the Avgs for each team --->
	<cfquery  datasource="nba" name="GetFav">
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
	where GameTime < '#mygametime#'
	and ha = 'H'
  	and Team = '#fav#'
	and mins = 240
	</cfquery>

	
	<cfquery  datasource="nba" name="GetUnd">
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
		where GameTime < '#mygametime#'
		and ha = 'A'
  		and Team = '#und#'
		and mins = 240
	</cfquery>
	
<cfelse>
	
	<cfquery  datasource="nba" name="GetFav">
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
		where GameTime < '#mygametime#'
		and ha = 'A'
  		and Team = '#fav#'
		and mins = 240
	</cfquery>

	
	<cfquery  datasource="nba" name="GetUnd">
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
		where GameTime < '#mygametime#'
		and ha = 'H'
  		and Team = '#und#'
		and mins = 240
	</cfquery>

	
	</cfif>

	
	<cfoutput query="GetFav">
	<cfquery  datasource="nba" name="Add">
	Update NBAAvgs
	  set ofga = #ofga#,
	      oTpa = #oTpa#,	
          oFta = #oFta#,
	      ofgpct = #ofgpct#,
	      oTppct = #oTppct#, 
	      oFTpct = #oFTpct# ,  
	      dfga   = #dfga# ,
	      dTpa   = #dTpa#,	
          dFta   = #dFta#,
	      dfgpct = #dfgpct# ,
	      dTppct = #dTppct#, 
	      dFTpct = #dFTpct# 
	where team = '#fav#'	  
	</cfquery>
	</cfoutput>
	
	<cfoutput query="GetUnd">
	<cfquery  datasource="nba" name="Add">
	Update NBAAvgs
	  set ofga = #ofga#,
	      oTpa = #oTpa#,	
          oFta = #oFta#,
	      ofgpct = #ofgpct#,
	      oTppct = #oTppct#, 
	      oFTpct = #oFTpct# ,  
	      dfga   = #dfga# ,
	      dTpa   = #dTpa#,	
          dFta   = #dFta#,
	      dfgpct = #dfgpct# ,
	      dTppct = #dTppct#, 
	      dFTpct = #dFTpct# 
	where team = '#und#'	  
	</cfquery>
	</cfoutput>	
	
</cfloop>	

	
</body>
</html>
