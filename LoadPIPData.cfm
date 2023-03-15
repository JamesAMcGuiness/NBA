<cfabort>

<cftry>
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
<cfset mystart = 1> 

 
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

	<cfset removecharsbeforethis = 'Points in the Paint:</td>'>
	<cfset LenOfRemoveCharsBeforeThis = Len(removecharsbeforethis)>
	<cfset foundpos = findnocase('#removecharsbeforethis#','#mypage#',1)>
	
	<cfset mypage = removechars(#mypage#,1,foundpos + LenOfRemoveCharsBeforeThis )> 
	
	
	
	
	
	
	<cfoutput>
	Did we find it?....#foundpos#
	</cfoutput>
	<p>

	
	<cfset mystart = 1>
	
	<!--- <cfoutput>
	foundpos is #foundpos#	
	</cfoutput> --->

	
			
	<cfset lookforbegin = '<td>'>
	<cfset lookforbeginlen = len(lookforbegin)>
	
	<cfset foundposbegin = findnocase('#lookforbegin#','#mypage#',mystart)>
	<cfset lookforend = '</td>'>
	<cfset lookforendlen = len(lookforend)>
	<cfset StartLooking = foundposbegin>
	
	<cfoutput>
	=======>Startlooking = #Startlooking# 
	</cfoutput>
	
	<cfset foundposend = findnocase('#lookforend#','#mypage#',startlooking)>
	
	<cfoutput>
	=======>EndPosFound = #foundposend# 
	</cfoutput>
	
	
	<cfset startFrom = (lookforbeginlen + foundposbegin)>
	<cfset ForALengthOf = foundposend - startFrom>
 	<cfset awayPIP =  mid(mypage,startfrom,ForALengthOf)>

	<cfoutput>
	#awayPIP#
	</cfoutput>



	<cfset lookforbegin = '<td class="nbaGIStatBord">'>
	<cfset lookforbeginlen = len(lookforbegin)>
	<cfset foundposbegin = findnocase('#lookforbegin#','#mypage#',mystart)>
	<cfset lookforend = '</td>'>
	<cfset lookforendlen = len(lookforend)>
	<cfset StartLooking = foundposbegin>
	=======>Startlooking = #Startlooking# 
	<cfset foundposend = findnocase('#lookforend#','#mypage#', startlooking )>
	
	<cfset startFrom = (lookforbeginlen + foundposbegin)>
	<cfset ForALengthOf = foundposend - startFrom>
 	<cfset homePIP =  mid(mypage,startfrom,ForALengthOf)>

	<cfif ha is 'H'>

		<cfquery datasource="nba" name="PIP" >
		Update NBAData
		set oPIP = #awayPIP#
		where gametime = '#gametime#'
		and Team = '#awayteam#'
		</cfquery>
	
		<cfquery datasource="nba" name="PIP" >
		Update NBAData
		set oPIP = #homePIP#
		where gametime = '#gametime#'
		and Team = '#hometeam#'
		</cfquery>

		<cfquery datasource="nba" name="PIP" >
		Update NBAData
		set dPIP = #homePIP#
		where gametime = '#gametime#'
		and Team = '#awayteam#'
		</cfquery>
	
		<cfquery datasource="nba" name="PIP" >
		Update NBAData
		set dPIP = #awayPIP#
		where gametime = '#gametime#'
		and Team = '#hometeam#'
		</cfquery>



	
	<cfelse>
	
		<cfquery datasource="nba" name="PIP" >
		Update NBAData
		set oPIP = #awayPIP#
		where gametime = '#gametime#'
		and Team = '#hometeam#'
		</cfquery>
	
		<cfquery datasource="nba" name="PIP" >
		Update NBAData
		set oPIP = #homePIP#
		where gametime = '#gametime#'
		and Team = '#awayteam#'
		</cfquery>

		<cfquery datasource="nba" name="PIP" >
		Update NBAData
		set dPIP = #homePIP#
		where gametime = '#gametime#'
		and Team = '#hometeam#'
		</cfquery>
	
		<cfquery datasource="nba" name="PIP" >
		Update NBAData
		set dPIP = #awayPIP#
		where gametime = '#gametime#'
		and Team = '#awayteam#'
		</cfquery>


	
	</cfif>
	
</cfloop>		
		
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
	'LOADEDPIP',
	'LoadPIPData.cfm'
	)
</cfquery>
	
	
<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:LoadPIPData.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>
	
				
 