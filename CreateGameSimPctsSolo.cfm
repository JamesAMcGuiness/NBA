
<cfscript>
 Application.objRandom = CreateObject("Component", "Random");
</cfscript>

<cfset AwayTeam  = 'GSW'>
<cfset HomeTeam  = 'BOS'>

<cfloop index="zz" from="1" to="2">
	<cfset FinalScoreAllQtrs = 0>

<cfif zz is 1>
	<cfset RunFor = AwayTeam>
	<cfset PossForHa = 'A'>
	<cfset OppHa     = 'H'>
	
<cfelse>
	<cfset RunFor = HomeTeam>
	<cfset PossForHa = 'H'>
	<cfset OppHa     = 'A'>

</cfif>
	
<cfset FinalScore = 0>
<cfloop index="theperiod" from="1" to = "4">

<cfset period     = #theperiod#>
<cfset TeamPlayCt = 0>
<cfset tot        = 0>


<cfloop index="r" from="1" to="500">
	<cfset Score     = 0>
	<cfset theScore  = 0>
	
<cfscript>
 	Application.objRandom.setBounds(1,100);
</cfscript>

<cfscript>
		Rn = Application.objRandom.next();
</cfscript>
	
<cfset done      = false>
<cfset PossFor   = RunFor>

<cfquery datasource="NBA" name="GetPosCt">
		Select AVG(TotalPossesions) as Stat
		FROM PBPStatsForPred
		WHERE Team IN ('#RunFor#')
		AND Period = #period#
		AND OFFDef = 'O'
</cfquery>

<cfloop condition="done is false">
	<cfset AddPlayCt = 'Y'>
	<cfset score     = 0>

	<cfquery datasource="NBA" name="GetStats">
		Select gs2ptShortMissPct,	
		 gs2ptShortMakePct,    
		 gs2ptMidMissPct,      
		 gs2ptMidMakePct,      
		 gs3ptMakePct,         
		 gs3ptMissPct,         
		 gsFTMakePct,          
		 gsFTMissPct,         
		 gsShortRebPct, 
		 gsMidRebPct,   
		 gsLongRebPct      
		FROM PBPStatsForPred
		WHERE Team = '#PossFor#'
		AND HA     = '#possforHA#'
		AND Period = #period#
		AND OFFDef = 'O'
	</cfquery>

	<cfif GetStats.recordcount is 0>
		<cfabort showerror="No Stats found for #PossFor#...#possforha#">
	</cfif>

	
	
		<cfset gs2ptMissShortReb = ROUND(100*GetStats.gsShortRebPct)>
		<cfset gs2ptMissMidReb   = ROUND(100*GetStats.gsMidRebPct)>
		<cfset gs3ptMissReb      = ROUND(100*GetStats.gsLongRebPct)>
		
		<cfset gs2ptMakeShort    = ROUND(100*GetStats.gs2ptShortMakePct)>
		<cfset range1            = gs2ptMakeShort>
		
		<cfset gs2ptMakeMid      = ROUND(100*GetStats.gs2ptMidMakePct)>
		<cfset range2 = range1   + gs2ptMakeMid>
		
		<cfset gs3ptMake         = ROUND(100*GetStats.gs3ptMakePct)>
		<cfset range3 = range2   + gs3ptMake>
			
		<cfset range4 = range3 + ROUND(100*(GetStats.gs2ptShortMissPct))>

		<cfset range5 = range4 + ROUND(100*(GetStats.gs2ptMidMissPct))>

		<cfset range6 = range5 + ROUND(100*(GetStats.gs3ptMissPct))>
					
		<cfset gsFTMade          = ROUND(100*GetStats.gsFTMakePct)>
		<cfset range7 = range6   + gsFTMade>
				
		<cfset gsFTMiss          = ROUND(100*GetStats.gsFTMissPct)>
		<cfset range8 = range7   + gsFTMiss>
			
		
		
		<cfif 1 is 2>
		<cfdump var="#variables#">
		<cfabort>
		</cfif>


	<cfscript>
		Rn = Application.objRandom.next();
	</cfscript>

	<!---<cfoutput>	
	The random number for Possession Type was... #rn#<br>
	</cfoutput>--->
	                                         
	<Cfset PossesionType = getPossesionType(RN,range1,range2,range3,range4,range5,range6,range7,range8)>
	
	<cfswitch expression="#PossesionType#">
		
			<cfcase value="MissShortRge">
				<!---<cfoutput>	
				Missed 2pt Short Shot for #PossFor#<br>
				</cfoutput>--->
				<cfscript>
				Rn = Application.objRandom.next();
				</cfscript>

				<cfif 1 is 2>
				<cfif getOFFRebResult(rn,'SHORTTWO',gs2ptMissShortReb,gs2ptMissMidReb,gs3ptMissReb) is 'REBOUND'>
					<cfset AddPlayCt = 'N'>
				</cfif>
				</cfif>
				
			</cfcase>

			<cfcase value="MissMidRge">
				<!---<cfoutput>	
				Missed 2pt Mid Rge Shot for #PossFor#<br>
				</cfoutput>--->
				
				<cfscript>
				Rn = Application.objRandom.next();
				</cfscript>

				<cfif 1 is 2>	
				<cfif getOFFRebResult(rn,'MIDTWO',gs2ptMissShortReb,gs2ptMissMidReb,gs3ptMissReb) is 'REBOUND'>
					<cfset AddPlayCt = 'N'>
				</cfif>
				</cfif>
				
				
			</cfcase>

			<cfcase value="MissLongRge">
				<!---<cfoutput>	
				Missed 3pt Shot for #PossFor#<br>
				</cfoutput>--->
				
				<cfscript>
				Rn = Application.objRandom.next();
				</cfscript>

				<cfif 1 is 2>	
				<cfif getOFFRebResult(rn,'LONG',gs2ptMissShortReb,gs2ptMissMidReb,gs3ptMissReb) is 'REBOUND'>
					<cfset AddPlayCt = 'N'>
				</cfif>
				</cfif>
				
				
			</cfcase>
			
			<cfcase value="2ptMakeShort">
				<!---<cfoutput>			
				Made 2pt Short Shot for #PossFor#<br>
				</cfoutput>--->
				<cfset Score      =  2>
			</cfcase>
						
			
			<cfcase value="2ptMakeMid">
				
				<!---<cfoutput>
				Made 2pt Mid Range shot for #possfor#<br>		
				</cfoutput>--->
				
				<cfset Score      =  2>
				
			</cfcase>
			
			<cfcase value="3ptMake">
				<!---<cfoutput>
				Made 3pt shot for #PossFor#<br>	
				</cfoutput>--->
				
				<cfset Score      =  3>
				
			</cfcase>
			
			<cfcase value="FTMade">
				<!---<cfoutput>
				Free Throw Made for #PossFor#<br>
				</cfoutput>--->
								
				<cfset Score = 1>
				
			</cfcase>
			
			<cfcase value="FTMiss">
				<!---<cfoutput>
				Free Throw Miss for #PossFor#<br>
				</cfoutput>--->
				
			</cfcase>

			<cfcase value="Turnover">
				<cfset Score = 0>
				<!---<cfoutput>
				Turnover! for #PossFor#<br>
				</cfoutput>--->	
			</cfcase>
			

			<cfcase value="Error">
				<cfabort showerror="Error: Not one of the defined Possesion Types">		
			</cfcase>
		</cfswitch>
		

		<cfscript>
			Rn = Application.objRandom.next();
		</cfscript>
		
		
		<cfif AddPlayCt is 'Y'>
			
				<cfset theScore = theScore + Score>
				<cfset TeamPlayCt = TeamPlayCt + 1>
		</cfif>
		
					
			
		<cfif TeamPlayCt gte GetPosCt.Stat >
			<cfset Tot = tot + theScore>
			<cfset done = true>
				
		</cfif>
		
		
		<!---
		<cfoutput>	
		DEN #HomeScore#...#HomeTeamPlayCt#<br>
		MIL #AwayScore#...#AwayTeamPlayCt#<br>
		Posession is now for: #PossFor#<br>
		Ha is #possforHA#<br>
		Done?...#done#<br>
		</cfoutput>	
		--->
		
		
</cfloop>	

<cfif 1 is 2>
<cfoutput>	
<p>
MIL #round(AwayScore)#<br>
</cfoutput>	
</cfif>

<cfset score      = 0>
<cfset FinalScore = Round(FinalScore + theScore)>
<cfset TeamPlayCt = 0>
</cfloop>	

<p>
<cfoutput>	
#RunFor# Final For Period #theperiod# was: #(FinalScore/r)#
<cfset FinalScoreAllQtrs = FinalScoreAllqtrs + round((FinalScore/r))>
</cfoutput>
<cfset Finalscore = 0>

</cfloop>
<p>
<cfoutput>
<b>The Final Score For #runfor# Was: #Round(FinalScoreAllQtrs)#</b>
</cfoutput>
<cfset  FinalScoreAllQtrs = 0>

</cfloop>

<cfscript> 
  function getFTPoss(rn)
  { 
	 if (rn lte 47.5)
	 	return 'ADDPOSS';
		
	if (rn gt 47.5)
	 	return 'NOADDPOSS';
		
		
  }
</cfscript>


	
<cfscript> 

  function getPossesionType(rn,MakeShortRge,MakeMidRge,LongMakeRge,MissShortRge,MissMidRge,MissLongRge,FTMadeRge,FTMissRge)
  { 
  
	if (rn lte MakeShortRge)
	 	return '2ptMakeShort';
  
	if (rn lte MakeMidRge)
	 	return '2ptMakeMid';

	if (rn lte LongMakeRge)
	 	return '3ptMake';
    		
	if (rn lte MissShortRge)
	 	return 'MissShortRge';
		
	if (rn lte MissMidRge)
	 	return 'MissMidRge';	
		
	if (rn lte MissLongRge)
	 	return 'MissLongRge';	
  
   	 if (rn lte FTMadeRge)
	 	return 'FTMade';
		
   	 if (rn lte FTMissRge)
	 	return 'FTMiss';
		
  	 if (rn lte 100)
	 	return 'Turnover';

     return 'Error'; 
	 
  } 
</cfscript>

<cfscript> 
  function getOFFRebResult(rn,ShotType,MissShortRebRge,MissMidRebRge,MissLongRebRge)
  { 
      if (ShotType is 'SHORTTWO')
	  {	
		if (rn lte MissShortRebRge)
			return 'REBOUND';
      
	  }
	  
	  if (ShotType is 'MIDTWO')
	  {
		if (rn lte MissMidRebRge)
			return 'REBOUND';
	  }	
  
	  if (ShotType is 'LONG')
	  {
		if (rn lte MissLongRebRge)
			return 'REBOUND';
    
	  }
	  return 'NOREBOUND';
   } 
</cfscript>