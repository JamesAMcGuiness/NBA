
<cftry>

<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>

<cfset myGametime = GetRunct.GameTime>


<cfquery  datasource="nba" name="del">
Delete from NbaAvgs
</cfquery>

<cfquery  datasource="nba" name="GetAdv">
	Select 
	  Team,	
 	  Avg(ofga - otpa) as ofga1,
	  Avg(otpa)        as oTpa1,	
      Avg(oFta)        as oFta1,
	   
	  Avg ( (ofgm - otpm) / (ofga - otpa)) as ofgpct1,
	  Avg  (otpm / otpa)                as oTppct1, 
	  Avg (oftm / ofta)                   as oFTpct1,  
	   
	  Avg(dfga - dtpa) as dfga1,
	  Avg(dtpa)        as dTpa1,	
      Avg(dFta)        as dFta1,
	   
	  Avg ( (dfgm - dtpm) / (dfga - dtpa) ) as dfgpct1,
	  Avg  (dtpm / dtpa)                as dTppct1,
	  Avg (dftm / dfta)                   as dFTpct1  

 	from nbadata 
	where GameTime < '#mygametime#'
	and mins = 240
  	Group by Team
	
	</cfquery>

	<cfoutput query="GetAdv">
	<cfquery  datasource="nba" name="Add">
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
	  #ofga1#,
	  #oTpa1#,	
      #oFta1#,
	  #ofgpct1#,
	  #oTppct1#, 
	  #oFTpct1#,  
	  #dfga1#,
	  #dTpa1#,	
      #dFta1#,
	  #dfgpct1#,
	  #dTppct1#, 
	  #dFTpct1#  
	)
	</cfquery>
	
</cfoutput>	




<!--- Create the Avgs for each team --->
<cfquery  datasource="nba" name="GetAdvHome">
	Select 
	  Team,	
 	  Avg(ofga - otpa) as ohfga1,
	  Avg(otpa)        as ohTpa1,	
      Avg(oFta)        as ohFta1,
	   
	  Avg ( (ofgm - otpm) / (ofga - otpa)) as ohfgpct1,
	  Avg  (otpm / otpa)                as ohTppct1, 
	  Avg (oftm / ofta)                   as ohFTpct1,  
	   
	  Avg(dfga - dtpa) as dhfga1,
	  Avg(dtpa)        as dhTpa1,	
      Avg(dFta)        as dhFta1,
	   
	  Avg ( (dfgm - dtpm) / (dfga - dtpa) ) as dhfgpct1,
	  Avg  (dtpm / dtpa)                as dhTppct1,
	  Avg (dftm / dfta)                   as dhFTpct1  

 	from nbadata 
	where GameTime < '#mygametime#'
	and ha = 'H'
	and mins = 240
  	Group by Team
	
	</cfquery>
	

<cfoutput query="GetAdvHome">
	<cfquery  datasource="nba" name="Add">
	Update NBAAvgs
	  set ohfga=#ohfga1#,
	  ohTpa=#ohTpa1#,		
      ohFta=#ohFta1#,
	  ohfgpct=#ohfgpct1#,
	  ohTppct=#ohTppct1#,  
	  dhfga=#dhfga1#,
	  dhTpa=#dhTpa1#,
      dhFta=#dhFta1#,
	  dhfgpct=#dhfgpct1#,
	  dhTppct=#dhTppct1#
	Where Team = '#Team#'  
	
	</cfquery>
</cfoutput>

<cfquery  datasource="nba" name="GetAdvAway">
	Select 
	  Team,	
 	  Avg(ofga - otpa) as oafga1,
	  Avg(otpa)        as oaTpa1,	
      Avg(oFta)        as oaFta1,
	   
	  Avg ( (ofgm - otpm) / (ofga - otpa)) as oafgpct1,
	  Avg  (otpm / otpa)                as oaTppct1, 
	  Avg (oftm / ofta)                   as oaFTpct1,  
	   
	  Avg(dfga - dtpa) as dafga1,
	  Avg(dtpa)        as daTpa1,	
      Avg(dFta)        as daFta1,
	   
	  Avg ( (dfgm - dtpm) / (dfga - dtpa) ) as dafgpct1,
	  Avg  (dtpm / dtpa)                as daTppct1,
	  Avg (dftm / dfta)                   as daFTpct1  

 	from nbadata 
	where GameTime < '#mygametime#'
	and ha = 'A'
	and mins = 240
  	Group by Team
	
	</cfquery>
	
	<cfoutput query="GetAdvAway">
	<cfquery  datasource="nba" name="Add">
	Update NBAAvgs
	  set oafga=#oafga1#,
	  oaTpa=#oaTpa1#,		
      oaFta=#oaFta1#,
	  oafgpct=#oafgpct1#,
	  oaTppct=#oaTppct1#,  
	  dafga=#dafga1#,
	  daTpa=#daTpa1#,
      daFta=#daFta1#,
	  dafgpct=#dafgpct1#,
	  daTppct=#daTppct1#  
	Where Team = '#Team#'  

	</cfquery>
	</cfoutput>	


<cfquery datasource="Nba" name="UPDATE">
	Insert into NBADataLoadStatus
	(
	Gametime,
	StepName,
	ProgramName
	)
	values
	(
	'#myGametime#',
	'LOADEDNBAAVGSHOMEAWAY',
	'CreateAvgsHomeAway.cfm'
	)
</cfquery>


<cfinclude template="CreateAvgsHAPow.cfm"> 

<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:CreateAvgsHomeAway.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>



