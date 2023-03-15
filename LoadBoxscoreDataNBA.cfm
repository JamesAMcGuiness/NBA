
<hr>

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
<cfset GameTime = ToString(GameTime2)>


<cfoutput>Gametime is #Gametime#</cfoutput>
<!--- 
<cfset Gametime = '20160312'>
 --->

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
	
	<cfset Matchup = trim('#awayteam#') & trim('#hometeam#')>
 	
	<cfoutput>
	<!--- <cfset myurl = 'http://www.nba.com/games/'#gametime#' & '/#matchup#/boxscore.html'> --->
	<cfset myurl = 'http://www.nba.com/games/#trim(gametime)#/#trim(matchup)#/gameinfo.html'>
	
	<cfset myurl = 'http://www.nba.com/games/20161025/NYKCLE##/boxscore'>
	
	</cfoutput>
	
	
					
	<cfoutput>
	#myurl#<br>	
	<cfhttp url="#myurl#" method="GET" resolveurl="false">
	</cfhttp>
	</cfoutput>




	<cfset mypage = '#cfhttp.filecontent#'>
	
	
	
<!---  <cfset mypage = replace('<th>&nbsp;</th>',' ','All')>  --->
	
	
<!---  
*******************************************************************************************************************
Delete all characters up to desired starting point
	
*******************************************************************************************************************
--->
<cfset statsfor=''>
<cfset aStat1 = 0>
<cfset aStat2 = 0>
<cfset aStat3a = 0>
<cfset aStat3b = 0>
<cfset aStat4a = 0>
<cfset aStat4b = 0>
<cfset aStat5a = 0>
<cfset aStat5b = 0>
<cfset aStat6 = 0>
<cfset aStat7 = 0>
<cfset aStat8 = 0>
<cfset aStat9 = 0>
<cfset aStat10 = 0>
<cfset aStat11 = 0>
<cfset aStat12 = 0>
<cfset aStat13 = 0>
<cfset aStat14 = 0>
<cfset aStat15 = 0>
<cfset aStat16 = 0>
<cfset aStat17 = 0>
<cfset mystart = 0>

<cfloop index="ii" from="1" to="2">

	<cfset StatsFor = HomeTeam>
	<cfset opp      = Awayteam>
	<cfset ha       = 'H'>
	<cfif ii is 1>
		<cfset StatsFor = AwayTeam>
		<cfset opp      = Hometeam>
	</cfif>
	
	
	
	<cfset astat1 = 240>
	<cfset usethis = '240'>
	<cfset removecharsbeforethis = '<td class="nbaGIScrTot">240</td>'>
	<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
	<!--- <cfoutput>
	foundpos is #foundpos#	
	</cfoutput> --->
	

	<cfif foundpos le 0>
		<cfset removecharsbeforethis = '<td class="nbaGIScrTot">265</td>'>
		<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
		<cfset usethis = '265'>
		<cfset astat1 = 265>
	</cfif>

	
	<cfif foundpos le 0>
		<cfset removecharsbeforethis = '<td class="nbaGIScrTot">290</td>'>
		<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
		<cfset usethis = '290'>
		<cfset astat1 = 290>
	</cfif>
	
	<cfif foundpos le 0>
		<cfset removecharsbeforethis = '<td class="nbaGIScrTot">315</td>'>
		<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
		<cfset usethis = '315'>
		<cfset astat1 = 315>
	</cfif>

	<cfif foundpos le 0>
		<cfset removecharsbeforethis = '<td class="nbaGIScrTot">180</td>'>
		<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
		<cfset usethis = '180'>
		<cfset astat1 = 180>
	</cfif>

   <cfoutput>
   Use this = #usethis#
	</cfoutput>


<!--- 

	<cfif foundpos le 0>
		<cfset removecharsbeforethis = '<th id="stat_min'>
		<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
		<cfset usethis = '240'>
		<cfset astat1 = 240>
	</cfif>
	

	<cfif foundpos le 0>
		<cfset removecharsbeforethis = '<th id="stat_min'>
		<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
		<cfset usethis = '265'>
		<cfset astat1 = 265>
	</cfif>

	<cfif foundpos le 0>
		<cfset removecharsbeforethis = '<th id="stat_min'>
		<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
		<cfset usethis = '290'>
		<cfset astat1 = 290>
	</cfif>

	<cfif foundpos le 0>
		<cfset removecharsbeforethis = '<th id="stat_min'>
		<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
		<cfset usethis = '315'>
		<cfset astat1 = 315>
	</cfif>

 --->
	
	
<!---  
	
	<cfset astat1 = 240>
	<cfset usethis = '240'>
	<cfset removecharsbeforethis = '<td>240</td>'>
	<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
	<!--- <cfoutput>
	foundpos is #foundpos#	
	</cfoutput> --->
	
	<cfif foundpos le 0>
		<cfset removecharsbeforethis = '<td>265</td>'>
		<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
		<cfset usethis = '265'>
		<cfset astat1 = 265>
	</cfif>

	
	<cfif foundpos le 0>
		<cfset removecharsbeforethis = '<td>290</td>'>
		<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
		<cfset usethis = '290'>
		<cfset astat1 = 290>
	</cfif>

	
	
	<cfif foundpos le 0>
		<cfset removecharsbeforethis = '<td>315</td>'>
		<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
		<cfset usethis = '315'>
		<cfset astat1 = 315>
	</cfif>

	<cfif foundpos le 0>
		<cfset removecharsbeforethis = '<td>180</td>'>
		<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
		<cfset usethis = '180'>
		<cfset astat1 = 180>
	</cfif>
	
	
--->
	
	
	
	
	<cfset mypage = replace('#mypage#','<td id="nbaGIBoxNme" class="nbaGIScrTot">','<tdjim>',"All")>
	<cfset mypage = replace('#mypage#','<td class="nbaGIScrTot">','<tdjim>',"All")>
 	<!--- <cfset mypage = replace('#mypage#','<td>&nbsp;','<tdjim>&nbsp;',"All")> --->
	
	<cfset removecharsbeforethis = '<tdjim>Total</td>'>
	<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
	<cfset LenOfRemoveCharsBeforeThis = Len(removecharsbeforethis)>
	<cfset mypage = removechars(#mypage#,1,foundpos + LenOfRemoveCharsBeforeThis)> 
	
<cfoutput>#mypage#</cfoutput>
 

<!--- 	<cfset mypage = replace('#mypage#','<td>','<th>',"All")>  
	<cfset mypage = replace('#mypage#','</td>','</th>',"All")>  
 --->
<cfset statct = 0>
<cfset done = false>


<!--- 
<cfoutput>
#mypage#
</cfoutput>
 --->

<cfset mystart = 1>
<cfloop condition="done is false">
			
	<cfset lookforbegin = '<tdjim>'>
	<cfset lookforbeginlen = len(lookforbegin)>
	<cfset foundposbegin = findnocase('#lookforbegin#','#mypage#',mystart)>
	<cfset lookforend = '</td>'>
	<cfset lookforendlen = len(lookforend)>
	<cfset StartLooking = foundposbegin>
	<cfoutput>
	=======>Startlooking = #Startlooking# 
	</cfoutput>
	
	<cfset foundposend = findnocase('#lookforend#','#mypage#', startlooking )>
	
	<!--- <cfif statct is 0>
	
	<cfset mystart = foundposend>
	<cfset lookforbegin = '<tdjim>'>
	<cfset lookforbeginlen = len(lookforbegin)>
	<cfset foundposbegin = findnocase('#lookforbegin#','#mypage#',mystart)>
	<cfset lookforend = '</td>'>
	<cfset lookforendlen = len(lookforend)>
	<cfset StartLooking = foundposbegin>
	=======>Startlooking = #Startlooking# 
	<cfset foundposend = findnocase('#lookforend#','#mypage#', startlooking )>
	</cfif>
	 --->

		
	<!-- Load the stat -->
	<cfif foundposbegin neq 0 and foundposend neq 0>
		
		<cfoutput>
	
		<cfset statct = statct + 1>
		
		***********************Statct = #statct#<br>
		<cfset startFrom = (lookforbeginlen + foundposbegin)>
		<cfset ForALengthOf = foundposend - startFrom>
 

		<cfswitch expression=#statct#>
			<cfcase value="1">
				
				Case=1<br>
				<cfset aStat1 =  mid(mypage,startfrom,ForALengthOf)>
				<cfoutput>
				MINS is #astat1#<br>
				</cfoutput>



			</cfcase>
			
			<cfcase value="2">

				case=2<br>
				
				
				<cfset aStat2 =  mid(mypage,startfrom,ForALengthOf)>
				<cfoutput>
				
				<cfset dashat         = findnocase('-',astat2)>
				<cfset aStat2a        = val(Left(aStat2,dashat - 1))>
				<cfset aStat2b        = val(  Right(aStat2,Len(astat2) - dashat) )>
				FGM = #aStat2a#<br>
				FGA = #aStat2b#
				</cfoutput>
			</cfcase>
						

			<cfcase value="3">
				case=3<br>
				<cfset aStat          =  mid(mypage,startfrom,ForALengthOf)>
				<cfset dashat         = findnocase('-',astat)>
				<cfset aStat3a        = val(Left(aStat,dashat - 1))>
				<cfset aStat3b        = val(  Right(aStat,Len(astat) - dashat) )>
				<cfoutput>TPM = #aStat3a#<br></cfoutput>
				<cfoutput>TPA = #aStat3b#<br></cfoutput>
				
			</cfcase>
			

			

			<cfcase value="4">
				<cfset aStat          =  mid(mypage,startfrom,ForALengthOf)>
				<cfset aStat4a        = val(Left(aStat,2))>
				<cfset aStat4b        = val(Right(aStat,2))>
				
				<cfset dashat         = findnocase('-',astat)>
				<cfset aStat4a        = val(Left(aStat,dashat - 1))>
				<cfset aStat4b        = val(  Right(aStat,Len(astat) - dashat) )>
				<cfoutput>FTm = #aStat4a#<br></cfoutput>
				<cfoutput>FTa = #aStat4b#<br></cfoutput>
				
			</cfcase>
			
			<!--- <cfcase value="5">
				
				BLANK!<br>
			</cfcase> --->
			
			Offensive rebounds
			<cfcase value="5">
				<cfset aStat6 =  mid(mypage,startfrom,ForALengthOf)>
				<cfoutput>Off Reb = #aStat6#<br></cfoutput>
			</cfcase>
			
			Def rebounds
			<cfcase value="6">
				<cfset aStat7 =  mid(mypage,startfrom,ForALengthOf)>
				<cfoutput>Def Reb = #aStat7#<br></cfoutput>
			</cfcase>
			
			Total Rebounds
			<cfcase value="7">
				<cfset aStat8 =  aStat6 + aStat7>
				<cfoutput>Total Rebounds = #astat8#<br></cfoutput>
			</cfcase>
			
			Assists
			<cfcase value="8">
				<cfset aStat9 =  mid(mypage,startfrom,ForALengthOf)>
				<cfoutput>Assists = #astat9#<br></cfoutput>
			</cfcase>
			
			Personal Fouls
			<cfcase value="9">
				<cfset aStat10 =  mid(mypage,startfrom,ForALengthOf)>	
								<cfoutput>Personal Fouls = #astat10#<br></cfoutput>
			</cfcase>
			
			Steals
			<cfcase value="10">
				<cfset aStat11 =  mid(mypage,startfrom,ForALengthOf)>
								<cfoutput>Steals = #astat11#<br></cfoutput>
			</cfcase>
			
			Turnovers
			<cfcase value="11">
				<cfset aStat12 =  mid(mypage,startfrom,ForALengthOf)>
								<cfoutput>Turnovers = #astat12#<br></cfoutput>
			</cfcase>
			
			
			Blocked Shots
			<cfcase value="12">
				<cfset aStat13 =  mid(mypage,startfrom,ForALengthOf)>
								<cfoutput>Blocked Shots = #astat13#<br></cfoutput>
			
			</cfcase>
			
			BA?
			<cfcase value="13">
				<cfoutput>Stat14<br></cfoutput>			
			</cfcase>
			
			
			Points
			<cfcase value="14">
				<cfset aStat14 =  mid(mypage,startfrom,ForALengthOf)>
				<cfoutput>Points = #astat14#<br></cfoutput>
				<cfset done = true>



<br>
		
				<cfif ii is 1>
				
				<cfquery name="Addit"  datasource="nba">
				Insert into NBAdata
				(Team,
				GameTime,
				Opp,
				ha,
				ps,
				ofgm,
				ofga,
				ofgpct,
				otpm,
				otpa,
				otppct,
				oftm,
				ofta,
				oftpct,
				oreb,
				odreb,
				otreb,
				oAssists,
				oSteals,
				oTurnovers,
				oBlkshots,
				oFouls,
				Mins,
				dmin
				)
				Values
				(
				'#statsfor#',
				'#gametime#',	
				'#opp#',
				'#ha#',
				#aStat14#,
				#aStat2a#,
				#aStat2b#,
				#(aStat2a/aStat2b)*100#,
				#aStat3a#,
				#aStat3b#,
				#(aStat3a/aStat3b)*100#,
				#aStat4a#,
				#aStat4b#,
				#(aStat4a/aStat4b)*100#,
				#aStat6#,
				#aStat7#,
				#aStat8#,
				#aStat9#,
				#aStat11#,
				#aStat12#,
				#aStat13#,
				#astat10#,
				#astat1#,
				#astat1#
				)						
				</cfquery>
				

				<cfif #ha# is 'H'>
					<cfset ha = 'A'>
				<cfelse>
					<cfset ha = 'H'>
				</cfif>
				
				<cfquery name="Addit"  datasource="nba">
				Insert into NBAdata
				(Team,
				GameTime,
				Opp,
				ha,
				dps,
				dfgm,
				dfga,
				dfgpct,
				dtpm,
				dtpa,
				dtppct,
				dftm,
				dfta,
				dftpct,
				dreb,
				ddreb,
				dtreb,
				dAssists,
				dSteals,
				dTurnovers,
				dBlkshots,
				dFouls,
				Mins,
				dmin
				)
				Values
				(
				'#opp#',
				'#gametime#',	
				'#statsfor#',
				'#ha#',
				#aStat14#,
				#aStat2a#,
				#aStat2b#,
				#(aStat2a/aStat2b)*100#,
				#aStat3a#,
				#aStat3b#,
				#(aStat3a/aStat3b)*100#,
				#aStat4a#,
				#aStat4b#,
				#(aStat4a/aStat4b)*100#,
				#aStat6#,
				#aStat7#,
				#aStat8#,
				#aStat9#,
				#aStat11#,
				#aStat12#,
				#aStat13#,
				#astat10#,
				#astat1#,
				#astat1#
				)						
				</cfquery>
				
				<cfelse>
				
				The stats is #astat14#...	
	
				<cfif #ha# is 'H'>
					<cfset ha = 'A'>
				<cfelse>
					<cfset ha = 'H'>
				</cfif>
	
	
				
				<cfquery name="Addit"  datasource="nba">
				Update NBAdata
				Set ps = #aStat14#,
				  ofgm = #aStat2a#,
				  ofga = #aStat2b#,
				  ofgpct = #(aStat2a/aStat2b)*100#,
				  otpm = #aStat3a#,
				  otpa = #aStat3b#,
				  otppct = #(aStat3a/aStat3b)*100#,
				  oftm = #aStat4a#,
				  ofta = #aStat4b#,
				  oftpct = 	#(aStat4a/aStat4b)*100#,
				  oreb = #aStat6#,
				  odreb = #aStat7#,
				  otreb = #aStat8#,
				  oAssists = #aStat9#,
				  oSteals = #aStat11#,
				  oTurnovers = #aStat12#,
				  oblkshots  = #aStat13#,
				  oFouls  = #aStat10#,
				  ha = 'H' 
				Where GameTime = '#GameTime#'
				and Team = '#HomeTeam#'						
				</cfquery>
				

				<cfquery name="Addit"  datasource="nba">
				Update NBAdata
				Set dps = #aStat14#,
				  dfgm = #aStat2a#,
				  dfga = #aStat2b#,
				  dfgpct = #(aStat2a/aStat2b)*100#,
				  dtpm = #aStat3a#,
				  dtpa = #aStat3b#,
				  dtppct = #(aStat3a/aStat3b)*100#,
				  dftm = #aStat4a#,
				  dfta = #aStat4b#,
				  dftpct = 	#(aStat4a/aStat4b)*100#,
  				  dreb = #aStat6#,
				  ddreb = #aStat7#,
				  dtreb = #aStat8#,
				  dAssists = #aStat9#,
				  dSteals = #aStat11#,
				  dTurnovers = #aStat12#,
				  dblkshots = #aStat13#,
				  dFouls  = #aStat10#,
				  ha = 'A' 
				Where GameTime = '#GameTime#'
				and Team = '#AwayTeam#'						
				</cfquery>
 			
 			</cfif>

			</cfcase>
			
		</cfswitch>
		
		<cfset mystart = startfrom>
	
		</cfoutput>
				
	<cfelse>
		<cfset done = true>
	</cfif>	


</cfloop>

</cfloop>

</cfloop>				

<cfif 1 is 2>
<cfinclude template="LoadPIPData.cfm"> 
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
	Update NBADATA 
	Set PS = (3*otpm) + (2*(ofgm-otpm)) + (oftm),
	DPS = (3*dtpm) + (2*(dfgm-Dtpm)) + (dftm)
</cfquery>


<!--- 
<cfquery datasource="Nba" name="UPDATE">
	Delete from NBADATA 
	where mins > 240
</cfquery>
 --->

				
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


<cfinclude template="UpdateRecordForTimePeriod.cfm">

<cfinclude template="CreatePBPPercents.cfm">
<cfinclude template="UpdateEffort.cfm">
<cfinclude template="PIPLoad.cfm">

</cfif>


<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:LoadBoxscoreDataNBA.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>


