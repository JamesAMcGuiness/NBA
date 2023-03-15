<cftry>



<cfquery datasource="Nba" name="UPDATE">
	DELETE from NBADataLoadStatus
</cfquery>

<cfquery datasource="Nba" name="updRunct">
			Update NbaGameTime
			Set Runct = 0
</cfquery>

<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>

<cfset yyyy = left(gametime,4)>
<cfset mm   = mid(gametime,5,2)>
<cfset dd   = right(gametime,2)>
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

<cfif hometeam is 'BKN' >
	<cfset hometeam = 'BRK'>
</cfif>
	
<cfif hometeam is 'PHX' >
	<cfset hometeam = 'PHO'>
</cfif>

<cfif hometeam is 'CHX' >
	<cfset hometeam = 'CHO'>
</cfif>

<cfif hometeam is 'CHA' >
	<cfset hometeam = 'CHO'>
</cfif>





<cfif awayteam is 'BKN' >
	<cfset awayteam = 'BRK'>
</cfif>
	
<cfif awayteam is 'PHX' >
	<cfset awayteam = 'PHO'>
</cfif>

<cfif awayteam is 'CHX' >
	<cfset awayteam = 'CHO'>
</cfif>

<cfif awayteam is 'CHA' >
	<cfset awayteam = 'CHO'>
</cfif>



<cfset myfavurl = myfav>
<cfset myundurl = myund>
<cfif myfav is 'CHA'>
	<cfset myfavurl = 'CHO'>
</cfif>
<cfif myund is 'CHA'>
	<cfset myundurl = 'CHO'>
</cfif>

<cfif myfav is 'PHX'>
	<cfset myfavurl = 'PHO'>
</cfif>
<cfif myund is 'PHX'>
	<cfset myundurl = 'PHO'>
</cfif>

<cfif myfav is 'BKN'>
	<cfset myfavurl = 'BRK'>
</cfif>
<cfif myund is 'BKN'>
	<cfset myundurl = 'BRK'>
</cfif>




<cfset myurl = 'http://www.basketball-reference.com/boxscores/' & '#gametime#' & '0' & '#hometeam#.html'>
<cfif 1 Is 2>


<cfset myurl ='http://scores.nbcsports.com/nba/boxscore.asp?gamecode=2017101709&home=9&vis=10&final=true'>
</cfif>
<cfset myurl = 'http://127.0.0.1:8500/NBACode/' & '#myfavurl##myundurl##gametime#0'>

<cfoutput>
#myurl#
</cfoutput>


<cfoutput>
	#myurl#<br>	
	<cfhttp url="#myurl#" method="GET" resolveurl="false">
	</cfhttp>
	</cfoutput>



<cfset thepage = '#cfhttp.filecontent#'>

<cfoutput>#thepage#</cfoutput>




<cfset LookFor  = 'Team Totals'> 
<cfset startpos = 1>
<cfset TeamTotalsStartPos = FindStringInPage('#thepage#','#LookFor#',#startpos#)>

<cfoutput>
Team Totals found at pos #TeamTotalsStartPos#
</cfoutput>

<cfset LeftSideString   = '<td class="right " data-stat="mp" >'>
<cfset RightSideString  = '</td>'>
<cfset startpos  = TeamTotalsStartPos>


<cfset aminplayed = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfoutput>
Start pos is #StartPos#
</cfoutput>

<cfset LeftSideString   = '<td class="right " data-stat="fg" >'>
<cfset aFGM       = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfoutput>
afgm = #afgm#
</cfoutput>


<cfset LeftSideString   = '<td class="right " data-stat="fga" >'>
<cfset aFGA      = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfoutput>
afga = #afga#
</cfoutput>

<cfset LeftSideString   = '<td class="right " data-stat="fg_pct" >'>
<cfset aFGPCT    = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="fg3" >'>
<cfset aFG3M     = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="fg3a" >'>
<cfset aFG3A     = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="fg3_pct" >'>
<cfset aFG3pct   = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="ft" >'>
<cfset aFTM      = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="fta" >'>
<cfset aFTA      = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="ft_pct" >'>
<cfset aFTpct    = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="orb" >'>
<cfset aOffReb   = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="drb" >'>
<cfset aDefReb   = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="trb" >'>
<cfset aTotReb   = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="ast" >'>
<cfset aAssists  = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="stl" >'>
<cfset aSteals   = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="blk" >'>
<cfset aBlocks   = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString    = '<td class="right " data-stat="tov" >'>
<cfset aTurnovers = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="pts" >'>
<cfset aPts      = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>


<cfoutput>
#aminplayed#
#aPTS#,#afgm#,#afga#,#afgpct#,#aFG3m#,#aFG3a#,#aFG3pct#,#aftm#,#afta#,#aftpct#,#aOffReb#,#aDefReb#,#aTotReb#,#aassists#,#asteals#, #aturnovers#,#ablocks#
</cfoutput>

<cfset LookFor = LeftSideString>
<cfset StartPos = FindStringInPage('#thepage#','#LookFor#',#startpos#)>


<!--- This will get us to the advanced stats boxscore… --->
<cfset LookFor  = 'Team Totals'>
<cfset AdvancedTeamTotalsStartPos = FindStringInPage('#thepage#','#LookFor#',#startpos#)>

<!--- Look again to find the regular Boxscore data…  --->
<cfset TeamTotalsStartPos = FindStringInPage('#thepage#','#LookFor#',#AdvancedTeamTotalsStartPos# + 20)>



<cfset LeftSideString   = '<td class="right " data-stat="mp" >'>
<cfset RightSideString  = '</td>'>
<cfset startpos  = TeamTotalsStartPos>


<cfset hminplayed = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfoutput>
Start pos is #StartPos#
</cfoutput>

<cfset LeftSideString   = '<td class="right " data-stat="fg" >'>
<cfset hFGM       = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfoutput>
hfgm = #hfgm#
</cfoutput>


<cfset LeftSideString   = '<td class="right " data-stat="fga" >'>
<cfset hFGA      = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfoutput>
hfga = #hfga#
</cfoutput>

<cfset LeftSideString   = '<td class="right " data-stat="fg_pct" >'>
<cfset hFGPCT    = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="fg3" >'>
<cfset hFG3M     = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="fg3a" >'>
<cfset hFG3A     = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="fg3_pct" >'>
<cfset hFG3pct   = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="ft" >'>
<cfset hFTM      = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="fta" >'>
<cfset hFTA      = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="ft_pct" >'>
<cfset hFTpct    = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="orb" >'>
<cfset hOffReb   = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="drb" >'>
<cfset hDefReb   = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="trb" >'>
<cfset hTotReb   = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="ast" >'>
<cfset hAssists  = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="stl" >'>
<cfset hSteals   = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="blk" >'>
<cfset hBlocks   = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString    = '<td class="right " data-stat="tov" >'>
<cfset hTurnovers = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfset LeftSideString   = '<td class="right " data-stat="pts" >'>
<cfset hPts      = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>


<cfif hometeam is 'BRK' >
	<cfset hometeam = 'BKN'>
</cfif>
	
<cfif hometeam is 'PHO' >
	<cfset hometeam = 'PHX'>
</cfif>

<cfif hometeam is 'CHX' >
	<cfset hometeam = 'CHA'>
</cfif>

<cfif hometeam is 'CHO' >
	<cfset hometeam = 'CHA'>
</cfif>



<cfif awayteam is 'BRK' >
	<cfset awayteam = 'BKN'>
</cfif>
	
<cfif awayteam is 'PHO' >
	<cfset awayteam = 'PHX'>
</cfif>

<cfif awayteam is 'CHX' >
	<cfset awayteam = 'CHA'>
</cfif>

<cfif awayteam is 'CHO' >
	<cfset awayteam = 'CHA'>
</cfif>


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

<cfif 1 is 2
<cfinclude template="UpdateRecordForTimePeriod.cfm">
</cfif>


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
	'LoadNBABoxscore2016.cfm'
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
	'LoadBoxscoreDataNBA.cfm'
	)
</cfquery>

<cfquery name="GetInfo" datasource="nba">
Delete from RunStatus
</cfquery>

<cfinclude template="PIPLoad.cfm">
<cfinclude template="CreatePBPPercents.cfm">
<cfinclude template="UpdateEffort.cfm">
</cfif>










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
		<cfhttpparam name='mySubject' type='FormField' value="Error:LoadNBABoxscore2016.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>


















