
<cfquery datasource="Nba" name="UPDATE">
	DELETE from NBADataLoadStatus
</cfquery>

<cfquery datasource="Nba" name="updRunct">
			Update NbaGameTime
			Set Runct = 0
</cfquery>


<cfquery datasource="nba" Name="GetGames1">
Select gt.*
from NbaGametime gt
</cfquery>

<cfquery datasource="nba" Name="GetGameCt">
Select Count(*) as TotGames
from NbaSchedule
where Gametime = '#GetGames1.Gametime#'
</cfquery>

<cfset totgames = GetGameCt.TotGames>


<cfloop index="i" from="1" to="#totgames#">

	<cfset start = "#Now()#">
	
	<cfloop index="i" from="1" to="200000000">

	</cfloop>

	<cfset end = "#Now()#">
	
	<cfoutput>#Start# vas #end#</cfoutput>
	<p>
	<p>

<cfquery datasource="nba" Name="GetGames">
Select n.*
from NBASchedule n, NbaGametime gt
where gt.Gametime = n.Gametime
and n.fav not in (Select Team from NbaData where gametime = '#Getgames1.Gametime#') 
</cfquery>





<cfif GetGames.recordcount neq 0>

	<cfset GameTime = GetGames.GameTime>

	<cfset yyyy = left(GetGames.gametime,4)>
	<cfset mm   = mid(GetGames.gametime,5,2)>
	<cfset dd   = right(GetGames.gametime,2)>
	<cfset mydate = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
	<CFSET NEXTDAY = #Dateformat(DateAdd("d",1,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
	<CFSET NEXTDAYSTR = ToString(NEXTDAY)>



<cfloop query="GetGames">

	<cfquery datasource="nba" Name="delGames">
		Delete from NBAData Where Gametime = '#GetGames.Gametime#' and (Team = '#Getgames.Fav#' or Team = '#Getgames.Und#') 
	</cfquery>

	
	<cfif GetGames.Ha is 'H'>
		
		<cfset hometm = '#Getgames.Fav#'>
		<cfset awaytm = '#Getgames.und#'>
		<cfset usethis = '#hometm#'>
		
		<cfif hometm is 'BKN'>
			<cfset usethis = 'BRK'>
		</cfif>

		<cfif hometm is 'CHA'>
			<cfset usethis = 'CHO'>
		</cfif>
		
		<cfif hometm is 'PHX'>
			<cfset usethis = 'PHO'>
		</cfif>
		
		
		
		
	<cfelse>
	
		<cfset awaytm = '#Getgames.fav#'>
		<cfset hometm = '#Getgames.Und#'>

		<cfoutput>
		Hometm = #hometm#
		</cfoutput>

		<cfset usethis = '#hometm#'>

		<cfif hometm is 'BKN'>
			<cfset usethis = 'BRK'>
		</cfif>

		<cfif hometm is 'CHA'>
			
		
			<cfset usethis = 'CHO'>
		</cfif>
		
		<cfif hometm is 'PHX'>
			<cfset usethis = 'PHO'>
		</cfif>

		
		
	</cfif>

	


	<cfset gameday = '#GetGames.Gametime#0' & '#usethis#.html'>
	<cfset myurl = 'https://www.basketball-reference.com/boxscores/' & '#GAMEDAY#'>
	

<cfoutput>
<cfhttp url="#myurl#" method="GET">
</cfhttp> 
</cfoutput>


<cfoutput>
<cfset mypage = #cfhttp.FileContent#>
#myurl#
</cfoutput>

Get here!
<cfoutput>#mypage#</cfoutput>

<cfset myctr = 0>
<cfset alldone = false>
<cfset FoundPos = Find('data-stat="player" >Team Totals</th><td class="right " data-stat="mp"','#mypage#') >

<cfoutput> FoundPos is #FoundPos#</cfoutput>





<cfif FoundPos gt 0>
	<cfset myctr = myctr + 1>
</cfif>

<cfloop condition="alldone is false">
	<cfset foundpos = Find('class="left " data-stat="player" >Team Totals</th><td class="right " data-stat="mp" >','#mypage#', #foundpos# + 1) >

	<cfif FoundPos gt 0>
	
		<cfoutput>We found it at #foundpos#<p></cfoutput>
	
		<cfset myctr = myctr + 1>
	<cfelse>
		<cfset alldone = true>
	</cfif>
</cfloop>
<cfoutput>
Total is #myctr#
</cfoutput>


16 myctr = spots 1/9  if normal game	240 minutes
18 myctr = spots 1/10 if 1 OT           265 minutes
20 myctr = spots 1/11 if 2 OT           280 minutes


<cfset AwayTeamBoxscore = Find('data-stat="player" >Team Totals</th><td class="right " data-stat="mp"','#mypage#',1)>

<cfoutput> AwayTeamBoxscore is #AwayTeamBoxscore#, and myctr is #myctr# </cfoutput>
<cfabort>

<cfif myctr is 16>
	<cfset HomeBoxscoreSkipCt = 8>
<cfelseif myctr is 18>	
	<cfset HomeBoxscoreSkipCt = 9>
<cfelseif myctr is 20>	
	<cfset HomeBoxscoreSkipCt = 10>
<cfelseif myctr is 22>	
	<cfset HomeBoxscoreSkipCt = 11>
</cfif>

<cfset Lastfoundpos = AwayTeamBoxscore + 10>
<cfloop index="ii" from="1" to="#HomeBoxscoreSkipCt#">
	<cfset foundpos = Find('data-stat="player" >Team Totals</th><td class="right " data-stat="mp"','#mypage#', #Lastfoundpos#) >
	<cfset Lastfoundpos = foundpos + 10>
</cfloop>

<cfset HomeTeamBoxscore = Find('data-stat="player" >Team Totals</th><td class="right " data-stat="mp"','#mypage#',#AwayTeamBoxscore# + 10)>


<cfset AwayTeamPos  = AwayTeamBoxscore>
<cfset HomeTeamPos  = foundpos>
	
<cfset StartPos = AwayTeamPos>
 

 
<cfoutput>
Stats for: #Awaytm#<br>
</cfoutput> 
 
 
 
 
<cfset leftsidestring = 'data-stat="mp" >'> 
<cfset rightsidestring = '</td>'>
<cfset mins = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="fg" >'>
<cfset fgm = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="fga" >'>
<cfset fga = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="fg_pct" >'>
<cfset fgpct = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="fg3" >'>
<cfset tpm = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="fg3a" >'>
<cfset tpa = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="fg3_pct" >'>
<cfset tppct = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="ft" >'>
<cfset ftm = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="fta" >'>
<cfset fta = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="ft_pct" >'>
<cfset ftPct = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="orb" >'>
<cfset oreb = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>
 
<cfset leftsidestring = 'data-stat="drb" >'>
<cfset dreb = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="trb" >'>
<cfset totreb = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="ast" >'>
<cfset assists = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="stl" >'>
<cfset stls = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="blk" >'>
<cfset blks = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>
 
<cfset leftsidestring = 'data-stat="tov" >'>
<cfset tos = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="pts" >'>
<cfset ps = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfoutput>
#ps#
#fgm#<br>
#fga#<br>
#fgpct#<br>
#tpm#<br>
#tpa#<br>
#tppct#<br>
#ftm#<br>
#fta#<br>
#ftPct#<br>
#oreb#<br>
#dreb#<br>
#totreb#<br>
#assists#<br>
#stls#<br>
#tos#<br>
#blks#<br>
0,
#mins# <br>
</cfoutput>

				
				
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
				'#AwayTM#',
				'#GetGames.Gametime#',	
				'#HomeTm#',
				'A',
				#ps#,
				#fgm#,
				#fga#,
				#100*fgpct#,
				#tpm#,
				#tpa#,
				#100*tppct#,
				#ftm#,
				#fta#,
				#100*ftPct#,
				#oreb#,
				#dreb#,
				#totreb#,
				#assists#,
				#stls#,
				#tos#,
				#blks#,
				0,
				#mins#,
				#mins#	
				)						
				</cfquery>
				


				<cfquery name="Addit"  datasource="nba">
				Insert into NBAdata
				(Team,
				GameTime,
				opp,
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
				dmin,
				mins
				)

				Values
				(
				'#HomeTm#',
				'#GetGames.Gametime#',	
				'#AwayTm#',	
				'H',
				#ps#,
				#fgm#,
				#fga#,
				#100*fgpct#,
				#tpm#,
				#tpa#,
				#100*tppct#,
				#ftm#,
				#fta#,
				#100*ftPct#,
				#oreb#,
				#dreb#,
				#totreb#,
				#assists#,
				#stls#,
				#tos#,
				#blks#,
				0,
				#mins#,
				#mins#	
				)						
						
				</cfquery>
		

<p>


<cfoutput>
Stats for: #Hometm#<br>
</cfoutput> 






<cfset StartPos = HomeTeamPos + 35>

<cfset leftsidestring = 'data-stat="mp" >'> 
<cfset rightsidestring = '</td>'>
<cfset mins = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="fg" >'>
<cfset fgm = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="fga" >'>
<cfset fga = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="fg_pct" >'>
<cfset fgpct = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="fg3" >'>
<cfset tpm = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="fg3a" >'>
<cfset tpa = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="fg3_pct" >'>
<cfset tppct = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="ft" >'>
<cfset ftm = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="fta" >'>
<cfset fta = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="ft_pct" >'>
<cfset ftPct = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="orb" >'>
<cfset oreb = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>
 
<cfset leftsidestring = 'data-stat="drb" >'>
<cfset dreb = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="trb" >'>
<cfset totreb = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="ast" >'>
<cfset assists = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="stl" >'>
<cfset stls = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="blk" >'>
<cfset blks = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>
 
<cfset leftsidestring = 'data-stat="tov" >'>
<cfset tos = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfset leftsidestring = 'data-stat="pts" >'>
<cfset ps = paresit9('#mypage#',#startpos#,'#leftsidestring#','#rightsidestring#')>

<cfoutput>
#mins# <br>
#fga#<br>
#fgm#<br>
#fga#<br>
#fgpct#<br>
#tpm#<br>
#tpa#<br>
#tppct#<br>
#ftm#<br>
#fta#<br>
#ftPct#<br>
#oreb#<br>
#dreb#<br>
#totreb#<br>
#assists#<br>
#stls#<br>
#blks#<br>
#tos#<br>
#ps#
</cfoutput>


				
				
				<cfquery name="Addit"  datasource="nba">
				Update NBAdata
				set	ps = #ps#,
				    ofgm = #fgm#,
				    ofga = #fga#,
				    ofgpct = #100*fgpct#,
				    otpm = #tpm#,
					otpa = #tpa#,
					otppct = #100*tppct#,
					oftm = #ftm#,
					ofta= #fta#,
					oftpct=#100*ftPct#,
					oreb=#oreb#,
					odreb=#dreb#,
					otreb=#totreb#,
					oAssists=#assists#,
					oSteals=#stls#,
					oTurnovers=#tos#,
					oBlkshots=#blks#,
					oFouls=0,
					Mins=#mins#,
					dmin=#mins#
				Where Team = '#HomeTm#'
				and Gametime = '#GetGames.Gametime#'
				</cfquery>

				<cfquery name="Addit"  datasource="nba">
				Update NBAdata
				set	dps = #ps#,
				    dfgm = #fgm#,
				    dfga = #fga#,
				    dfgpct = #100*fgpct#,
				    dtpm = #tpm#,
					dtpa = #tpa#,
					dtppct = #100*tppct#,
					dftm = #ftm#,
					dfta= #fta#,
					dftpct=#100*ftPct#,
					dreb=#oreb#,
					ddreb=#dreb#,
					dtreb=#totreb#,
					dAssists=#assists#,
					dSteals=#stls#,
					dTurnovers=#tos#,
					dBlkshots=#blks#,
					dFouls=0,
					dMin=#mins#,
					mins=#mins#
				Where Team = '#AwayTm#'
				and Gametime = '#GetGames.Gametime#'
				</cfquery>

				

				<cfabort>

</cfloop>


<cfelse>



<cfinclude template="CreateAvgs.cfm">		
<cfinclude template="CreateAvgsHomeAway.cfm">		
<cfinclude template="WhoCovered.cfm">
<cfinclude template="UpdateRecordForTimePeriod.cfm">


<cfset GameTime = GetGames1.GameTime>

<cfset yyyy = left(GetGames1.gametime,4)>
<cfset mm   = mid(GetGames1.gametime,5,2)>
<cfset dd   = right(GetGames1.gametime,2)>
<cfset mydate = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET NEXTDAY = #Dateformat(DateAdd("d",1,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET NEXTDAYSTR = ToString(NEXTDAY)>


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
	'LoadNBABoxscore2019.cfm'
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
	'LoadNBABoxscore2019.cfm'
	)
</cfquery>

<cfquery name="GetInfo" datasource="nba">
Delete from RunStatus
</cfquery>

<cfinclude template="PIPLoad.cfm">
<cfinclude template="CreatePBPPercents.cfm">
<cfinclude template="UpdateEffort.cfm">


</cfif>

</cfloop>




<cffunction name="FindStringInPage9" access="remote" output="yes" returntype="Numeric">
	-- Returns the position of where the string was found	
	<cfargument name="LookFor"              type="String"  required="yes" />
	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />

	<cfset FoundStringPos = FINDNOCASE('#arguments.LookFor#','#arguments.theViewSourcePage#',#arguments.startLookingPosition#)>  	

	<cfreturn #FoundStringPos# >

</cffunction>


<cffunction name="paresit9" access="remote" output="yes" returntype="String">

	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />
	<cfargument name="LeftSideString"       type="String"  required="yes" />
	<cfargument name="RightSideString"      type="String"  required="yes" />
 
	<cfif 1 is 2>
	<cfoutput>
	Search on #arguments.theViewSourcePage# for Leftside:  #arguments.LeftsideString# at spot #arguments.startLookingPosition#<br>
	</cfoutput>
	</cfif>
 
	<cfset posOfLeftsidestring = FINDNOCASE('#arguments.LeftSideString#','#arguments.theViewSourcePage#',#arguments.startLookingPosition#)>  
	
	<cfif 1 is 2>
	<cfoutput>
	posOfLeftsidestring = #posOfLeftsidestring#
	</cfoutput>
	</cfif>	
		
	<cfset LengthOfLeftSideString = LEN('#arguments.LeftSideString#')>

	<cfset posOfRightsidestring    = FINDNOCASE('#arguments.RightSideString#','#arguments.theViewSourcePage#',#posOfLeftsidestring# +1)>  	
	<cfset LengthOfRightSideString = LEN('#arguments.RightSideString#')>

	<cfif 1 is 2>
	<cfoutput>
	Search on #arguments.theViewSourcePage# for Rightside: #arguments.RightsideString# at spot #posOfLeftsidestring# +1 <br>
	</cfoutput>
	</cfif>

	<p>
	
	<cfif 1 is 2>
	<cfoutput>
	posOfRightsidestring = #posOfRightsidestring#
	</cfoutput>
	</cfif>
	
	<cfif posOfRightsidestring neq 0 and posOfleftsidestring neq 0>
		
		<cfset StartParsePos = posOfLeftsidestring  + LengthOfLeftSideString>
		<cfset EndParsePos   = posOfRightsidestring>
		<cfset LenOfParseVal = (#EndParsePos# - #StartParsePos#)>
		
		<cfset parseVal = Mid('#arguments.theViewSourcePage#',#StartParsePos#,#LenOfParseVal#)>

		<cfif 1 is 1>
		<cfoutput>
		StartParsePos = #startparsepos#><br>
		EndParsePos   = #endparsepos#><br>
		LenOfParseVal = #LenOfParseVal#><br>
		parseVal=#parseVal#	<br>
		</cfoutput>
		</cfif>
	
	<cfelse>
		<cfset parseVal = '0'>
	</cfif>

	
	<cfreturn '#parseVal#'>

</cffunction>








