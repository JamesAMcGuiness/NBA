<cftry>

<cfset myUserCFC = createObject("component", "PSP2012.NFL.FORMS.User") />

<cfquery datasource="Nba" name="GetStatus">
	Update RunStatus 
	set Runflag = 'Y',
	runstatus=''
</cfquery>



<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<!-- See if any picks have been made -->
 
<cfquery datasource="nba" name="findit23">
	Select * from nbagamesim where gametime='#GetRunCt.GameTime#'
</cfquery>	


Found rows is : <cfoutput>#findit23.recordcount#</cfoutput>

<!---
<cfif findit23.recordcount neq 0>
<cfabort>
</cfif> 
--->

<cfquery datasource="NBA" name="Loadit">
	Delete from LoadStats 
</cfquery>	

<cfquery datasource="NBA" name="Loadit">
	Delete from NBASchedule where gametime='#GetRunCt.GameTime#'
</cfquery>	

<cfset myurl = 'http://www.covers.com/odds/basketball/nba-spreads.aspx'>
<!--- 
<cfset myurl = '127.0.0.1:8500/NBACode/nba-spreads.aspx'>
 --->
		
	<cfoutput>
	<cfhttp url="#myurl#" method="GET" resolveurl="false">
	</cfhttp>
	</cfoutput>

	<cfset mypage = '#cfhttp.filecontent#'>

	<!--- 
<cfoutput>#mypage#</cfoutput>
 --->

	

<!--- <cffile action="read"
	file="c:\CFusionMX7\wwwroot\pspweb\NBA\nbaspds.txt" 
	variable="myPage"> --->

***************************************************************************************
<cfset foundit           = 1>
<cfset StatsFor          = 'A'>
<cfset loopct            = 0>
<cfset AwayTeam          = ''>
<cfset HomeTeam          = ''>
<cfset HomeTeamFavored   = true>
<cfset myteamabbrev      = ''>
<cfset gms               = 0 >
<cfset StartLookingAtPos = 1>


<cfloop condition="Foundit neq 0">
	 <cfset GoodRun = true>
	 <cfset skipthisone = false>	
	 <cfset GoodSpd = true>
	 <cfset loopct = loopct + 1>
	 
     <cfset StringToFind = '<tr id="/sport/basketball/competition'>
		
     <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>

	  <cfif Foundit le 0 >
		Page HTML has changed!<br>
		<!--- <cfquery datasource="NBASchedule" name="Loadit">
		Delete from NBASchedule where gametime="#GetRunCt.GameTime#"
		</cfquery>	 --->

		<cfabort>
	  </cfif>	

      
     <cfset StartLookingAtPos = Foundit>
     <cfset StringToFind = '<strong>'>
    
	<cfset mystr = myUserCFC.parseString('#mypage#',StartLookingAtPos,'<strong>','</strong>')>
	
	<cfset myarry = arraynew(1)>
	<cfset myarry = ListToArray(mystr)>
	
	<cfoutput>
	mystr = #mystr#
	</cfoutput>
	
	<cfset myteam = myarry[1]>
	<cfset myteam = #setTeamName(myteam)#>
	
	  <cfoutput>
		myteam is #myteam#<br>	
	  </cfoutput>	
			
	  <cfset AwayTeam = myteam>
		
	  <cfset StartLookingAtPos = Foundit + len(StringToFind)>	

     <cfset StringToFind = '<strong>'>
	
	<cfset mystr = myUserCFC.parseString('#mypage#',myarry[2],'<strong>','</strong>')>

	<cfoutput>
	mystr = #mystr#
	</cfoutput>

	<cfset myarry2 = arraynew(1)>
	<cfset myarry2 = ListToArray(mystr)>


	<cfset myteam = replace(myarry2[1],'@','')>
	<cfset myteam = #setTeamName(Replace(myteam,'@',''))#>
	
	  <cfoutput>
		myteam is #myteam#<br>	
	  </cfoutput>	
			
	  <cfset HomeTeam = myteam>


	 <cfset loopct = loopct + 1>
	 
    
	<cfset mystr = myUserCFC.parseString('#mypage#',myarry[2],'<div class="line_top">','</div>')>
	
	<cfset myarry3 = arraynew(1)>
	<cfset myarry3 = ListToArray(mystr)>

	<cfset myou = myarry3[1]>

	<cfoutput>
	The total is #myou#<br>
	</cfoutput>

	

	<cfset mystr = myUserCFC.parseString('#mypage#',myarry3[2],'<div class="covers_bottom">','</div>')>
	
	<cfset myarry4 = arraynew(1)>
	<cfset myarry4 = ListToArray(mystr)>

	<cfset myspd = myarry4[1]>

	<cfoutput>
	The spd is #myspd#<br>
	</cfoutput>

				
			  <cfset PlusFound = FindNoCase('+','#myspd#')>
						
			  <cfset HomeTeamFavored = false>
			  <cfset myfav = AwayTeam>
			  <cfset myund = HomeTeam>
			  <cfset myha  = 'A'>
			  <cfif PlusFound le 0>
				 	<cfset HomeTeamFavored = true>
				    <cfset myfav = HomeTeam>
					<cfset myund = AwayTeam>
					<cfset myha  = 'H'>
			  </cfif>

				<cfif skipthisone is true or myspd is 'pk' or myspd is 'OFF' or myspd is 'Off' or myspd is 'off' or myspd is '' or myspd is ' '>
					OFF.....................................#HomeTeam# vs #awayteam#<br>
					<cfset GoodSpd = false>
					<cfset GoodRun = false>
					
	   			</cfif>
				
			     <cfif trim(myspd) is 'pk'>
					<cfset myspd = 0>
				</cfif>
	  
	  			<cfset finalspd = abs(myspd)>
	  

				<cfif GoodRun is true> 
	  	
				<cfquery datasource="NBA" name="findit">
				Select * from NBAschedule where gametime='#GetRunCt.GameTime#'
				and fav = '#myfav#'
				</cfquery>
		
				<cfoutput>
				Checking:***************** #myfav#/#GetRunCt.GameTime#/...#findit.recordcount#<br>
				</cfoutput>
		
				<cfif findit.recordcount is 0 >
				<cfquery datasource="NBA" name="Loadit">
				Insert into nbaschedule
				(
				gametime,
				fav,
				ha,
				spd,
				und,
				ou
				)
				values
				(
				'#GetRunCt.GameTime#',
				'#myfav#',
				'#myha#',
				#finalspd#,
				'#myund#',
				#myou#)
				
				</cfquery>


	  			 <!--- <cfquery datasource="NBA" name="Loadit">
				Insert into nbaschedule
				(
				gametime,
				fav,
				ha,
				spd,
				und,
				ou
				)
				values
				(
				'#GetRunCt.GameTime#',
				'#myfav#',
				'#myha#',
				#finalspd#,
				'#myund#',
				#myou#) 
				
				</cfquery> --->
				
				<cfelse>
				Game already exists for #myfav# vs #myund#<br>
				</cifif> 
				
	  		 </cfif>	
	  	</cfif> 

		<cfset StartLookingAtPos = myarry4[2]>


	</cfloop>

	<cfoutput>Goodrun is #goodrun#</cfoutput>
	
	<cfquery datasource="Nba" name="GetStatus">
	Update NBAStatus
	Set Status='RUNGAMESIM'
	</cfquery>

	<!--- See how many games are loaded so far.... --->
	<cfquery datasource="Nba" name="GetGameCt">
	Select count(*) 
	from NBASchedule
	Where gametime = '#GetRunCt.GameTime#'
	</cfquery>
	
	
	
	<!--- If this is our early load of spreads (Before 11 AM)... --->
	<cfif Hour(Now()) lt 11>

		<cfquery datasource="Nba" name="UpdGameCt">
		DELETE from NBAGameCt 
		</cfquery>

		<cfquery datasource="Nba" name="UpdGameCt">
		INSERT into NBAGameCt(#GetGameCt.recordcount#) 
		</cfquery>
		
	</cfif>

	<cfinclude template="UpdateConseqRoadCt.cfm">
	
<!--- 	<cfquery datasource="NBA" name="Loadit">
		Insert into LoadStats
		GameTime = '#GetRunct.gametime#',
		LoadSuccess_Flag = 'Y' 
	</cfquery>	
 --->		
	
	
<cffunction name="setTeamName" returntype="string" output=True>
  
	<cfargument name="fullteam">

<Cfswitch expression='#myteam#'>

	<cfcase value="Atlanta">
		<cfset myteamabbrev = 'ATL'>
	</cfcase>
	
	<cfcase value="Charlotte">
		<cfset myteamabbrev = 'CHA'>
	</cfcase>

	<cfcase value="Cleveland">
		<cfset myteamabbrev = 'CLE'>
	</cfcase>
	
	<cfcase value="Denver">
		<cfset myteamabbrev = 'DEN'>
	</cfcase>
	
	<cfcase value="Golden State">
		<cfset myteamabbrev = 'GSW'>
	</cfcase>

	<cfcase value="Indiana">
		<cfset myteamabbrev = 'IND'>
	</cfcase>
		
	<cfcase value="L.A. Lakers">
		<cfset myteamabbrev = 'LAL'>
	</cfcase>

	<cfcase value="Miami">
		<cfset myteamabbrev = 'MIA'>
	</cfcase>

	<cfcase value="Minnesota">
		<cfset myteamabbrev = 'MIN'>
	</cfcase>

	<cfcase value="New Orleans">
		<cfset myteamabbrev = 'NOP'>
	</cfcase>

	<cfcase value="Orlando">
		<cfset myteamabbrev = 'ORL'>
	</cfcase>

	<cfcase value="Phoenix">
		<cfset myteamabbrev = 'PHX'>
	</cfcase>

	<cfcase value="Sacramento">
		<cfset myteamabbrev = 'SAC'>
	</cfcase>

	<cfcase value="Seattle">
		<cfset myteamabbrev = 'SEA'>
	</cfcase>

	<cfcase value="Utah">
		<cfset myteamabbrev = 'UTA'>
	</cfcase>

	<cfcase value="Boston">
		<cfset myteamabbrev = 'BOS'>
	</cfcase>

	<cfcase value="Chicago">
		<cfset myteamabbrev = 'CHI'>
	</cfcase>

	<cfcase value="Dallas">
		<cfset myteamabbrev = 'DAL'>
	</cfcase>

	<cfcase value="Detroit">
		<cfset myteamabbrev = 'DET'>
	</cfcase>

	<cfcase value="Houston">
		<cfset myteamabbrev = 'HOU'>
	</cfcase>

	<cfcase value="L.A. Clippers">
		<cfset myteamabbrev = 'LAC'>
	</cfcase>

	<cfcase value="Memphis">
		<cfset myteamabbrev = 'MEM'>
	</cfcase>

	<cfcase value="Milwaukee">
		<cfset myteamabbrev = 'MIL'>
	</cfcase>

	<cfcase value="New Jersey">
		<cfset myteamabbrev = 'NJN'>
	</cfcase>

	<cfcase value="New York">
		<cfset myteamabbrev = 'NYK'>
	</cfcase>

	<cfcase value="Brooklyn">
		<cfset myteamabbrev = 'BKN'>
	</cfcase>

	<cfcase value="Philadelphia">
		<cfset myteamabbrev = 'PHI'>
	</cfcase>

	<cfcase value="Portland">
		<cfset myteamabbrev = 'POR'>
	</cfcase>

	<cfcase value="San Antonio">
		<cfset myteamabbrev = 'SAS'>
	</cfcase>

	<cfcase value="Toronto">
		<cfset myteamabbrev = 'TOR'>
	</cfcase>

	<cfcase value="Washington">
		<cfset myteamabbrev = 'WAS'>
	</cfcase>
	               
	<cfcase value="Oklahoma City">
		<cfset myteamabbrev = 'OKC'>
	</cfcase>

	<cfdefaultcase>
		<cfset myteamabbrev = 'XXX'>
	</cfdefaultcase>
	
</cfswitch>
  	<cfreturn  myteamabbrev>
</cffunction>
	

<cfquery datasource="Nba" name="UPDATE">
	Insert into NBADataLoadStatus
	(
	ProgramName
	)
	values
	(
	'LoadGamesFromWebWithFlag.cfm'
	)
</cfquery>


	
	
<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:LoadGamesFromWebWithFlag.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>

	
