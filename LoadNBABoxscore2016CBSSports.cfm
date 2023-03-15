<cftry>

<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>

<cfset yyyy = left(GetRunCt.gametime,4)>
<cfset mm   = mid(GetRunCt.gametime,5,2)>
<cfset dd   = right(GetRunCt.gametime,2)>
<cfset mydate = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET NEXTDAY = #Dateformat(DateAdd("d",1,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET NEXTDAYSTR = ToString(NEXTDAY)>

<cfset GameTime2 = mydate>
<cfset GameTime  = ToString(GameTime2)>


<cfoutput>Gametime is #Gametime#</cfoutput>
 

<cfquery name="GetStats" datasource="nba" >
Select count(*) as foundit
FROM nbadata
where Trim(Gametime) = '#Gametime#'
</cfquery>
 
<cfif GetStats.Foundit neq 0>
 	<cfabort showerror="Stats already exist for #Gametime#"> 
</cfif>
 
<cfquery name="GetSpds" datasource="nba" >
SELECT *
FROM nbaschedule
where trim(GAMETIME) = '#GAMETIME#'
</cfquery>
 
<cfloop query="Getspds">

	<cfset myfav      = "#Getspds.fav#">
	<cfset myund      = "#GetSpds.und#">
	<cfset ha         = "#GetSpds.ha#">
	<cfset spd        = "#GetSpds.spd#">
 	<cfset GameTime   = "#Getspds.GameTime#">
	
	<cfoutput>
	#myfav#.....#myund#<br>	
	</cfoutput>		
		
	<cfif ha is 'H'>
		<cfset HomeTeam   = myfav>
		<cfset AwayTeam   = myUnd>
		
		
	<cfelse>
		<cfset HomeTeam   = myund>
		<cfset AwayTeam   = myfav>
	</cfif>

	
	
<cfif hometeam is 'SAS' >
	<cfset hometeam = 'SA'>
</cfif>
	
<cfif hometeam is 'NYK' >
	<cfset hometeam = 'NY'>
</cfif>

<cfif hometeam is 'GSW' >
	<cfset hometeam = 'GS'>
</cfif>

<cfif hometeam is 'NOH' >
	<cfset hometeam = 'NO'>
</cfif>

<cfif hometeam is 'PHX' >
	<cfset hometeam = 'PHO'>
</cfif>


<cfif awayteam is 'SAS' >
	<cfset awayteam = 'SA'>
</cfif>
	
<cfif awayteam is 'NYK' >
	<cfset awayteam = 'NY'>
</cfif>

<cfif awayteam is 'GSW' >
	<cfset awayteam = 'GS'>
</cfif>

<cfif awayteam is 'NOH' >
	<cfset awayteam = 'NO'>
</cfif>

<cfif awayteam is 'PHX' >
	<cfset awayteam = 'PHO'>
</cfif>



<cfset myurl = 'http://www.cbssports.com/nba/gametracker/boxscore/NBA_#gametime#' & '_#awayteam#@#hometeam#'>

<cfset myurl = 'http://www.pointspreadpros.com/psp2012/nfl/admin/Boxscore.html'>

<cfoutput>
	#myurl#<br>	
	<cfhttp url="#myurl#" method="GET" resolveurl="false">
	</cfhttp>
	</cfoutput>



<cfset thepage = '#cfhttp.filecontent#'>


<cfset LookFor  = 'Team Stats'> 
<cfset startpos = 1>
<cfset TeamTotalsStartPos = FindStringInPage('#thepage#','#LookFor#',#startpos#)>

<cfoutput>
Team Totals found at pos #TeamTotalsStartPos#
</cfoutput>

<cfset LeftSideString   = '<td align="left">Points</td><td align="right">'>
<cfset RightSideString  = '</td>'>
<cfset startpos  = TeamTotalsStartPos>

<cfset aPtS = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset hPtS = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>





<cfset LeftSideString   = 'Field Goals</td><td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset aFGM = ParseDash('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#','LEFT')>
<cfset aFGA = ParseDash('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#','RIGHT')>
<cfset afgpct = (afgm/afga) * 100>

<cfset LeftSideString   = '<td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset hFGM = ParseDash('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#','LEFT')>
<cfset hFGA = ParseDash('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#','RIGHT')>
<cfset hfgpct = (hfgm/hfga) * 100>



<cfset LeftSideString   = 'Free Throws</td><td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset aFTM = ParseDash('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#','LEFT')>
<cfset aFTA = ParseDash('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#','RIGHT')>
<cfset aftpct = (aftm/afta) * 100>


<cfset LeftSideString   = '<td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset hFTM = ParseDash('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#','LEFT')>
<cfset hFTA = ParseDash('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#','RIGHT')>
<cfset hftpct = (hftm/hfta) * 100>




<cfset LeftSideString   = '3-pointers</td><td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset aFG3M = ParseDash('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#','LEFT')>
<cfset aFG3A = ParseDash('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#','RIGHT')>

<cfset LeftSideString   = '<td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset hFG3M = ParseDash('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#','LEFT')>
<cfset hFG3A = ParseDash('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#','RIGHT')>

<cfset hFG3pct = (hFG3M/hFG3A) * 100>
<cfset aFG3pct = (aFG3M/aFG3A) * 100>


<cfset LeftSideString   = 'Off. Rebounds</td><td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset aOffReb = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset hOffReb = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>



<cfset LeftSideString   = 'Def. Rebounds</td><td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset aDefReb = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset hDefReb = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>



<cfset LeftSideString   = 'Total Rebounds</td><td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset aTotReb = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset hTotReb = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>



<cfset LeftSideString   = 'Assists</td><td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset aAssists = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset hAssists = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>



<cfset LeftSideString   = 'Blocks</td><td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset aBlocks = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset hBlocks = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>



<cfset LeftSideString   = 'Fouls</td><td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset aFouls = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset hFouls = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>



<cfset LeftSideString   = 'Steals</td><td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset aSteals = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset hSteals = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>



<cfset LeftSideString   = 'Turnovers</td><td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset aTurnovers = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td align="right">'>
<cfset RightSideString  = '</td>'>

<cfset hTurnovers = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>


<cfif hometeam is 'SA' >
	<cfset hometeam = 'SAS'>
</cfif>
	
<cfif hometeam is 'NY' >
	<cfset hometeam = 'NYK'>
</cfif>

<cfif hometeam is 'GS' >
	<cfset hometeam = 'GSW'>
</cfif>

<cfif hometeam is 'NO' >
	<cfset hometeam = 'NOH'>
</cfif>

<cfif hometeam is 'PHO' >
	<cfset hometeam = 'PHX'>
</cfif>


<cfif awayteam is 'SA' >
	<cfset awayteam = 'SAS'>
</cfif>
	
<cfif awayteam is 'NY' >
	<cfset awayteam = 'NYK'>
</cfif>

<cfif awayteam is 'GS' >
	<cfset awayteam = 'GSW'>
</cfif>

<cfif awayteam is 'NO' >
	<cfset awayteam = 'NOH'>
</cfif>

<cfif awayteam is 'PHO' >
	<cfset awayteam = 'PHX'>
</cfif>



<cfoutput>
#aminplayed#
#aPTS#,#afgm#,#afga#,#afgpct#,#aFG3m#,#aFG3a#,#aFG3pct#,#aftm#,#afta#,#aftpct#,#aOffReb#,#aDefReb#,#aTotReb#,#aassists#,#asteals#, #aturnovers#,#ablocks#
</cfoutput>


	<cfquery datasource="NBA" name="addit">
	INSERT INTO NBADATA(Team,Opp,ha,gametime,ps,dps,ofgm,ofga,ofgpct,otpm,otpa,otppct,oftm,ofta,oftpct,oreb,odreb,otreb,oassists,osteals,oturnovers,oblkshots,dfgm,dfga,dfgpct,dtpm,dtpa,dtppct,dftm,dfta,dftpct,dreb,ddreb,dtreb,dassists,dsteals,dturnovers,dblkshots,mins,dmin)
	Values('#AwayTeam#','#HomeTeam#','A',#gametime#,#aPTS#,#hPTS#,#afgm#,#afga#,#afgpct*100#,#aFG3m#,#aFG3a#,#aFG3pct*100#,#aftm#,#afta#,#aftpct*100#,#aOffReb#,#aDefReb#,#aTotReb#,#aassists#,#asteals#, #aturnovers#,#ablocks#,#hfgm#,'#hfga#',#hfgpct*100#,#hFG3m#,#hFG3a#,#hFG3pct*100#,#hftm#,#hfta#,#hftpct*100#,#hOffReb#,#hDefReb#,#hOffReb + hDefReb#,#hassists#,#hsteals#,#hturnovers#,#hblocks#,#aminplayed#,#hminplayed#)						
	</cfquery>


	<cfquery datasource="NBA" name="addit">
	INSERT INTO NBADATA(Team,Opp,ha,gametime,ps,dps,ofgm,ofga,ofgpct,otpm,otpa,otppct,oftm,ofta,oftpct,oreb,odreb,otreb,oassists,osteals,oturnovers,oblkshots,dfgm,dfga,dfgpct,dtpm,dtpa,dtppct,dftm,dfta,dftpct,dreb,ddreb,dtreb,dassists,dsteals,dturnovers,dblkshots,mins,dmin)
	Values('#HomeTeam#','#AwayTeam#','H',#gametime#,#hPTS#,#aPTS#,#hfgm#,#hfga#,#hfgpct*100#,#hFG3m#,#hFG3a#,#hFG3pct*100#,#hftm#,#hfta#,#hftpct*100#,#hOffReb#,#hDefReb#,#hTotReb#,#hassists#,#hsteals#, #hturnovers#,#hblocks#,#afgm#,#afga#,#afgpct*100#,#aFG3m#,#aFG3a#,#aFG3pct*100#,#aftm#,#afta#,#aftpct*100#,#aOffReb#,#aDefReb#,#aOffReb + aDefReb#,#aassists#,#asteals#,#aturnovers#,#ablocks#,#hminplayed#,#aminplayed#)						
	</cfquery>

</cfloop>	



<cfif 1 is 1>
<!---
<cfinclude template="LoadPIPData.cfm"> 
--->

<cfinclude template="CreateAvgs.cfm">		
<cfinclude template="CreateAvgsHomeAway.cfm">		
<cfinclude template="WhoCovered.cfm">


<cfquery datasource="Nba" name="GetRunct">
	Update NBAGameTime 
	Set runct = 0,
	Gametime = '#NEXTDAYSTR#'
</cfquery>




<cfquery datasource="Nba" name="UPDATE">
	Insert into NBADataLoadStatus
	(
	Gametime,
	StepName,
	ProgramName
	)
	values
	(
	'#Gametime#',
	'GAMETIMEUPDATED',
	'LoadBoxscoreDataNBA.cfm'
	)
</cfquery>




 
<cfquery datasource="Nba" name="UPDATE">
	UPDATE NBADATA 
	set opip = 1, dpip = 1
	where gametime = '#gametime#'
</cfquery>


				
<cfquery datasource="Nba" name="GetStatus">
	Update RunStatus
	 set Runflag = 'N',
	 runstatus = ''
</cfquery>
				
<cfquery datasource="Nba" name="UPDATE">
	Insert into NBADataLoadStatus
	(
	Gametime,
	StepName,
	ProgramName
	)
	values
	(
	'#Gametime#',
	'LOADEDBOXSCORE',
	'LoadNBABoxscore2016CBSSports.cfm'
	)
</cfquery>

<cfquery name="GetInfo" datasource="nba">
Delete from RunStatus
</cfquery>

<!---
<cfinclude template="UpdateRecord.cfm">
--->

<cfinclude template="CreatePBPPercents.cfm">

<cfinclude template="UpdateEffort.cfm">

</cfif>



<cffunction name="ParseDash" access="remote" output="yes" returntype="Numeric">
	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />
	<cfargument name="LeftSideString"       type="String"  required="yes" />
	<cfargument name="RightSideString"      type="String"  required="yes" />
	<cfargument name="WhichStat"            type="String"  required="yes" />

	
	<cfset aStat = ParseIt('#arguments.theViewSourcePage#',#arguments.startLookingPosition#,'#arguments.LeftSideString#','#arguments.RightSideString#')>
			
	<cfset dashat = findnocase('-',astat)>
	<cfset aStat1 = val(Left(aStat,dashat - 1))>
	<cfset aStat2 = val(Right(aStat,Len(astat) - dashat))>

	<cfif arguments.WhichStat is 'LEFT'>
		<cfset retval = #aStat1#>
	<cfelse>
		<cfset retval = #aStat2#>
	</cfif>
	
	<cfreturn #retval#>
	
</cffunction>



<cffunction name="ParseIt" access="remote" output="yes" returntype="Numeric">

	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />

	<cfargument name="LeftSideString"       type="String"  required="yes" />
	<cfargument name="RightSideString"      type="String"  required="yes" />
 
	<cfset posOfLeftsidestring = FINDNOCASE('#arguments.LeftSideString#','#arguments.theViewSourcePage#',#arguments.startLookingPosition#)>  
	<cfoutput>
	posOfLeftsidestring = #posOfLeftsidestring#
	</cfoutput>
		
	<cfset LengthOfLeftSideString = LEN('#arguments.LeftSideString#')>

	<cfset posOfRightsidestring    = FINDNOCASE('#arguments.RightSideString#','#arguments.theViewSourcePage#',#posOfLeftsidestring#)>  	
	<cfset LengthOfRightSideString = LEN('#arguments.RightSideString#')>

	<p>
	
	<cfoutput>
	posOfRightsidestring = #posOfRightsidestring#
	</cfoutput>
	
	<cfset StartParsePos = posOfLeftsidestring  + LengthOfLeftSideString>
	<cfset EndParsePos   = posOfRightsidestring>
 	<cfset LenOfParseVal = (#EndParsePos# - #StartParsePos#)>
	
	<cfoutput>
	StartParsePos = #startparsepos#><br>
	EndParsePos   = #endparsepos#><br>
 	LenOfParseVal = #LenOfParseVal#><br>
		
	</cfoutput>
	
	
	
	<cfset parseVal = Mid('#arguments.theViewSourcePage#',#StartParsePos#,#LenOfParseVal#)>
	
	
	<cfreturn VAL(parseVal)>

</cffunction>



<cffunction name="FindStringInPage" access="remote" output="yes" returntype="Numeric">

	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="LookFor"              type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />

	<cfset FoundStringPos = FINDNOCASE('#arguments.LookFor#','#arguments.theViewSourcePage#',#arguments.startLookingPosition#)>  	

	<cfreturn #FoundStringPos# >

</cffunction>


<cfcatch type="any">
  <cfoutput>#cfcatch.Detail#</cfoutput>
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlertx.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:LoadBoxscoreDataNBA.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>


















