
<hr>


<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>



<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>



<cfset yyyy = left(GetRunCt.gametime,4)>
<cfset mm   = mid(GetRunCt.gametime,5,2)>
<cfset dd   = right(GetRunCt.gametime,2)>
<cfset mydate = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET NEXTDAY = #Dateformat(DateAdd("d",1,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET NEXTDAYSTR = ToString(NEXTDAY)>

<cfset GameTime2 = mydate>
<cfset GameTime = ToString(GameTime2)>

<cfoutput>Gametime is #Gametime#</cfoutput>


<cfquery name="GetStats" datasource="nbastats" >
Select count(*) as foundit
FROM nbadata
where Trim(Gametime) = '#Gametime#'
</cfquery>


 
<cfif GetStats.Foundit neq 0>
	<cfabort showerror="Stats already exist for #Gametime#">
</cfif>
 
 
<cfquery name="GetSpds" datasource="nbaschedule" >
SELECT *
FROM nbaschedule
where trim(GAMETIME) = '#GAMETIME#'
</cfquery>

 
<!--- <cfquery name="GetSpds" datasource="nbaschedule" >
SELECT *
FROM nbaschedule
where trim(GAMETIME) = '#gametime#'
and fav='NOH' or und='NOH'
</cfquery>
 --->
 
 
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
	<cfset myurl = 'http://www.nba.com/games/#trim(gametime)#/#trim(matchup)#/boxscore.html'>
	
	#myurl#<br>
	
	</cfoutput>
	
	<cfoutput>
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
	<cfset removecharsbeforethis = '<th>240</th>'>
	<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
	<!--- <cfoutput>
	foundpos is #foundpos#	
	</cfoutput> --->
	
	<cfif foundpos le 0>
		<cfset removecharsbeforethis = '<th>265</th>'>
		<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
		<cfset usethis = '265'>
		<cfset astat1 = 265>
	</cfif>

	
	<cfif foundpos le 0>
		<cfset removecharsbeforethis = '<th>290</th>'>
		<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
		<cfset usethis = '290'>
		<cfset astat1 = 290>
	</cfif>

	
	
	<cfif foundpos le 0>
		<cfset removecharsbeforethis = '<th>315</th>'>
		<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
		<cfset usethis = '315'>
		<cfset astat1 = 315>
	</cfif>

	<cfif foundpos le 0>
		<cfset removecharsbeforethis = '<th>180</th>'>
		<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
		<cfset usethis = '180'>
		<cfset astat1 = 180>
	</cfif>

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
	
	<cfset LenOfRemoveCharsBeforeThis = Len(removecharsbeforethis)>
	<cfset mypage = removechars(#mypage#,1,foundpos + LenOfRemoveCharsBeforeThis)>

<!--- 	<cfset mypage = replace('#mypage#','<td>','<th>',"All")>  
	<cfset mypage = replace('#mypage#','</td>','</th>',"All")>  
 --->
<cfset statct = 2>
<cfset done = false>
<cfset mystart = 0>

<cfloop condition="done is false">
	<!---  
	*******************************************************************************************************************
	Find the spot just BEFORE the value you want to scrape 
	
	*******************************************************************************************************************
	--->
	
	<cfset lookforbegin = '<th>'>
	<cfset lookforbeginlen = len(lookforbegin)>

	<cfoutput>
	
	<cfset foundposbegin = findnocase('#lookforbegin#','#mypage#',mystart)>
		
	<cfif foundposbegin is 0>
		<cfset lookforbegin = 'Total</td>'>
		<cfset lookforbeginlen = len(lookforbegin)>
		<cfset foundposbegin = findnocase('#lookforbegin#','#mypage#',mystart)>
		<cfset lookforend = '</td>'>
	<cfelse>	
		<!---  
		*******************************************************************************************************************
		Find the spot just AFTER the value you want to scrape 
	
		*******************************************************************************************************************
		--->
		<cfset lookforend = '</th>'>
	
	</cfif>
	<cfset lookforendlen = len(lookforend)>
	<cfset StartLooking = foundposbegin>
	<!-- =======>Startlooking = #Startlooking#  -->
		
	<cfset foundposend = findnocase('#lookforend#','#mypage#', startlooking )>
	
	</cfoutput>

	
	<!-- Load the stat -->
	<cfif foundposbegin neq 0 and foundposend neq 0>
		
		<cfoutput>
	
		<cfset statct = statct + 1>
		
		***********************Statct = #statct#<br>
		
		
		<cfset startFrom = (lookforbeginlen + foundposbegin)>
		<cfset ForALengthOf = foundposend - startFrom>
 
		<cfswitch expression=#statct#>
			<cfcase value="1">
				<cfset aStat1 =  mid(mypage,startfrom,ForALengthOf)>
			</cfcase>
			<cfcase value="2">
				<cfset aStat2 =  mid(mypage,startfrom,ForALengthOf)>
			</cfcase>
						
			FGM-A
			<cfcase value="3">
				<cfset aStat          =  mid(mypage,startfrom,ForALengthOf)>
				*********************<br>
				FGM-A Stat is:#aStat#<br>
				*********************<br>
				<cfset dashat         = findnocase('-',astat)>
				<cfset aStat3a        = val(Left(aStat,dashat - 1))>
				<cfset aStat3b        = val(  Right(aStat,Len(astat) - dashat) )>
				<cfoutput>aStat3a = #aStat3a#<br></cfoutput>
				<cfoutput>aStat3b = #aStat3b#<br></cfoutput>
				
			</cfcase>
			
			3pfgm-a
			<cfcase value="4">
				<cfset aStat          =  mid(mypage,startfrom,ForALengthOf)>
				<cfset aStat4a        = val(Left(aStat,2))>
				<cfset aStat4b        = val(Right(aStat,2))>
				
				<cfset dashat         = findnocase('-',astat)>
				<cfset aStat4a        = val(Left(aStat,dashat - 1))>
				<cfset aStat4b        = val(  Right(aStat,Len(astat) - dashat) )>
				<cfoutput>aStat4a = #aStat4a#<br></cfoutput>
				<cfoutput>aStat4b = #aStat4b#<br></cfoutput>
				
			</cfcase>
			
			Free throws made/attempted
			<cfcase value="5">
				<cfset aStat          =  mid(mypage,startfrom,ForALengthOf)>
				
				<cfset aStat5a        = val(Left(aStat,2))>
				<cfset aStat5b        = val(Right(aStat,2))>
				<cfset dashat         = findnocase('-',astat)>
				<cfset aStat5a        = val(Left(aStat,dashat - 1))>
				<cfset aStat5b        = val( Right(aStat,Len(astat) - dashat))>
				<cfoutput>aStat5a = #aStat5a#<br></cfoutput>
				<cfoutput>aStat5b = #aStat5b#<br></cfoutput>
			</cfcase>
			
			Offensive rebounds
			<cfcase value="7">
				<cfset aStat6 =  mid(mypage,startfrom,ForALengthOf)>
				<cfoutput>aStat6 = #aStat6#<br></cfoutput>
			</cfcase>
			
			Def rebounds
			<cfcase value="8">
				<cfset aStat7 =  mid(mypage,startfrom,ForALengthOf)>
			</cfcase>
			
			Total Rebounds
			<cfcase value="9">
				<cfset aStat8 =  aStat6 + aStat7>
			</cfcase>
			
			Assists
			<cfcase value="10">
				<cfset aStat9 =  mid(mypage,startfrom,ForALengthOf)>
			</cfcase>
			
			Personal Fouls
			<cfcase value="11">
				<cfset aStat10 =  mid(mypage,startfrom,ForALengthOf)>	
			</cfcase>
			
			Steals
			<cfcase value="12">
				<cfset aStat11 =  mid(mypage,startfrom,ForALengthOf)>
			</cfcase>
			
			Turnovers
			<cfcase value="13">
				<cfset aStat12 =  mid(mypage,startfrom,ForALengthOf)>
			</cfcase>
			
			
			Blocked Shots
			<cfcase value="14">
				<cfset aStat13 =  mid(mypage,startfrom,ForALengthOf)>
			
			</cfcase>
			
			Points
			<cfcase value="15">
				<cfset aStat14 =  mid(mypage,startfrom,ForALengthOf)>
				<cfset done = true>


<cfif ii is 1>
<cfoutput>
<br>
				'#statsfor#',<br>
				'#gametime#',<br>	
				'#opp#',<br>	
				#aStat1#,<br>
				#aStat3a#,<br>
				#aStat3b#,<br>
				#aStat3a/aStat3b#,<br>
				#aStat4a#,	<br>
				#aStat4b#,<br>
				#aStat4a/aStat4b#,<br>
				#aStat5a#,<br>
				#aStat5b#,<br>
				#aStat5a/aStat5b#,<br>
				#aStat6#,<br>
				#aStat7#,<br>
				#aStat8#,<br>
	assists		#aStat9#,<br>
	fouls		#aStat10#,<br>
	steals		#aStat11#,<br>
	to			#aStat12#,<br>
	blk			#aStat13#,<br>
	ps		*******	#aStat14#<br>

-------------------------------------------------------------------------------------------------------------------------
</cfoutput>		

</cfif>				
<br>
		
				<cfif ii is 1>
				
				<cfquery name="Addit"  datasource="nbastats">
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
				#aStat3a#,
				#aStat3b#,
				#(aStat3a/aStat3b)*100#,
				#aStat4a#,
				#aStat4b#,
				#(aStat4a/aStat4b)*100#,
				#aStat5a#,
				#aStat5b#,
				#(aStat5a/aStat5b)*100#,
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
				
				<cfquery name="Addit"  datasource="nbastats">
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
				dblkshots,
				dfouls,
				dmin,
				mins
				)
				Values
				(
				'#opp#',
				'#gametime#',	
				'#Statsfor#',
				'#ha#',
				#aStat14#,
				#aStat3a#,
				#aStat3b#,
				#(aStat3a/aStat3b)*100#,
				#aStat4a#,
				#aStat4b#,
				#(aStat4a/aStat4b)*100#,
				#aStat5a#,
				#aStat5b#,
				#(aStat5a/aStat5b)*100#,
				#aStat6#,
				#aStat7#,
				#aStat8#,
				#aStat9#,
				#aStat11#,
				#aStat12#,
				#aStat13#,
				#aStat10#,
				#aStat1#,
				#aStat1#
				)						
				</cfquery>
				
				<cfelse>
				
				The stats is #astat14#...	
	
				<cfif #ha# is 'H'>
					<cfset ha = 'A'>
				<cfelse>
					<cfset ha = 'H'>
				</cfif>
	
	
				
				<cfquery name="Addit"  datasource="nbastats">
				Update NBAdata
				Set ps = #aStat14#,
				  ofgm = #aStat3a#,
				  ofga = #aStat3b#,
				  ofgpct = #(aStat3a/aStat3b)*100#,
				  otpm = #aStat4a#,
				  otpa = #aStat4b#,
				  otppct = #(aStat4a/aStat4b)*100#,
				  oftm = #aStat5a#,
				  ofta = #aStat5b#,
				  oftpct = 	#(aStat5a/aStat5b)*100#,
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
				

				<cfquery name="Addit"  datasource="nbastats">
				Update NBAdata
				Set dps = #aStat14#,
				  dfgm = #aStat3a#,
				  dfga = #aStat3b#,
				  dfgpct = #(aStat3a/aStat3b)*100#,
				  dtpm = #aStat4a#,
				  dtpa = #aStat4b#,
				  dtppct = #(aStat4a/aStat4b)*100#,
				  dftm = #aStat5a#,
				  dfta = #aStat5b#,
				  dftpct = 	#(aStat5a/aStat5b)*100#,
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

<cfquery datasource="Nba" name="GetRunct">
	Update NBAGameTime 
	Set runct = -70,
	Gametime = '#NEXTDAYSTR#'
</cfquery>


<cfquery datasource="Nbastats" name="UPDATE">
	Update NBADATA 
	Set PS = (3*otpm) + (2*(ofgm-otpm)) + (oftm),
	DPS = (3*dtpm) + (2*(dfgm-Dtpm)) + (dftm)
</cfquery>


<cfquery datasource="Nbastats" name="UPDATE">
	Delete from NBADATA 
	where mins > 240
</cfquery>

<!--- <cfinclude template="WhoCovered.cfm">			 --->
				
				
 