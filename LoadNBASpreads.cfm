
<cfquery datasource="Nba" name="GetStatus">
	Select Runflag
	from RunStatus
</cfquery>

<!--- <cfif GetStatus.RunFlag is 'Y'>
	<cfabort>
</cfif>
 --->

<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<!-- See if any picks have been made -->
<cfquery datasource="nba" name="findit23">
	Select * from nbagamesim where gametime='#GetRunCt.GameTime#'
</cfquery>	


Found rows is : <cfoutput>#findit23.recordcount#</cfoutput>

<!--- <cfif findit23.recordcount neq 0>
<cfabort>
</cfif> --->

<cfquery datasource="NBA" name="Loadit">
	Delete from LoadStats 
</cfquery>	

<cfquery datasource="NBA" name="Loadit">
	Delete from NBASchedule where gametime='#GetRunCt.GameTime#'
</cfquery>	

<cfset myurl = 'http://www.covers.com/sports/nba/nba_lines.aspx'>
	
	<cfoutput>
	<cfhttp url="#myurl#" method="GET" resolveurl="false">
	</cfhttp>
	</cfoutput>

	<cfset mypage = '#cfhttp.filecontent#'>

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
	 
     <cfset StringToFind = '<a href="/pageloader/pageloader.aspx?page=/data/nba/teams/team'>
     <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>

	  <cfif Foundit le 0 >
		11111111111111111111111<br>
		<!--- <cfquery datasource="NBASchedule" name="Loadit">
		Delete from NBASchedule where gametime="#GetRunCt.GameTime#"
		</cfquery>	 --->

		<cfabort>
	  </cfif>	

     <cfset LenOfStringToFind = LEN(StringToFind)>
      <cfset BegTeamPos = LenOfStringToFind + 13 + foundit>

     <cfset StartLookingAtPos = BegTeamPos>
     <cfset StringToFind = '</a>'>
     <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>

	  <cfif Foundit le 0 >
	  2222222222222222222222222222222222<br>
		<cfset GoodRun = false>
	  	
	  </cfif>
     
	 <cfset myteam = Mid(mypage,BegTeamPos,(Foundit - BegTeamPos))>
    	  	
	  <cfoutput>	
	  <cfset myteam = #setTeamName(myteam)#>
	  </cfoutput>
		
		<cfset AwayTeam = myteam>
		
	  <cfset StartLookingAtPos = Foundit>	

	 <cfset loopct = loopct + 1>
	 
     <cfset StringToFind = '<a href="/pageloader/pageloader.aspx?page=/data/nba/teams/team'>
     <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>

	  <cfif Foundit le 0 >
		  333333333333333333333333333333333333333<br>
		<cfset GoodRun = false>
	  </cfif>	


     <cfset LenOfStringToFind = LEN(StringToFind)>
     <cfset BegTeamPos = LenOfStringToFind + 13 + foundit>

     <cfset StartLookingAtPos = BegTeamPos>
     <cfset StringToFind = '</a>'>
     <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>

	  <cfif Foundit le 0 >
	  44444444444444444444444444444444444444<br>
				<cfset GoodRun = false>
			
	  </cfif>
     
	 <cfset myteam = Mid(mypage,BegTeamPos,(Foundit - BegTeamPos))>
    
	  <cfset StartLookingAtPos = foundit>
	  <cfoutput>	
	  <cfset myteam = #setTeamName(myteam)#>
	  </cfoutput>
		  
	<cfset HomeTeam = myteam>

			  <cfset StringToFind = '<td class="datacell"><div class=""><div class="right"></div>OFF</div>'>
			  <cfset Foundspd=Findnocase(StringToFind,mypage,StartLookingAtPos)>
				FindNoCase(
			  <cfoutput>
			  ==============foundspd is #foundspd#===================<br>
			  </cfoutput>

			  <cfif Foundspd neq 0>
			  	<cfset skipthisone = true>
			  </cfif>
			  			  
			  <cfset StringToFind = '<td class="datacell"><div class=""><div class="right">-110</div>'>
			  <cfset LenOfStringToFind = Len(StringToFind)>
			  <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>
			  <cfif Foundit neq 0>
			  	<cfset skipthisone = false>
			  </cfif>
			  
			  <cfset BegSpdPos = LenOfStringToFind + foundit>  	
			  
			  <cfset StartLookingAtPos = BegSpdPos> 
			    			  
			  <cfset StringToFind = '</div>'>
			  <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>
			  <cfset myspd = Mid(mypage,BegSpdPos,(Foundit - BegSpdPos))>
			  
  			  <cfset StartLookingAtPos = foundit> 

			  <cfset StringToFind = '<td class="datacell"><div class="right">-110</div>'>
			  <cfset LenOfStringToFind = Len(StringToFind)>
			  <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>
			  <cfset BegSpdPos = LenOfStringToFind + foundit>  	
			  
			  <cfset StartLookingAtPos = BegSpdPos> 
			    			  
			  <cfset StringToFind = '</td>'>
			  <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>
			  <cfset myou = Mid(mypage,BegSpdPos,(Foundit - BegSpdPos))>
			
	     	  <cfset StartLookingAtPos = foundit> 

			  <cfset StringToFind = '<td class="datacell"><div class=""><div class="right">-110</div>'>
			  <cfset LenOfStringToFind = Len(StringToFind)>
			  <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>
			  <cfset BegSpdPos = LenOfStringToFind + foundit>  	
			  
			  <cfset StartLookingAtPos = BegSpdPos> 
			    			  
			  <cfset StringToFind = '</div>'>
			  <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>
			  <cfset myspd = Mid(mypage,BegSpdPos,(Foundit - BegSpdPos))>
			  
  			  <cfset StartLookingAtPos = foundit> 


			  <cfset StringToFind = '<td class="datacell"><div class="right">-110</div>'>
			  <cfset LenOfStringToFind = Len(StringToFind)>
			  <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>
			  <cfset BegSpdPos = LenOfStringToFind + foundit>  	
			  
			  <cfset StartLookingAtPos = BegSpdPos> 
			    			  
			  <cfset StringToFind = '</td>'>
			  <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>
			  <cfset myou = Mid(mypage,BegSpdPos,(Foundit - BegSpdPos))>
			
	     	  <cfset StartLookingAtPos = foundit> 

				
			  <cfset MinusFound = FindNoCase('-','#myspd#')>
						
			  <cfset HomeTeamFavored = true>
			  <cfset myfav = HomeTeam>
			  <cfset myund = AwayTeam>
			  <cfset myha  = 'H'>
			  <cfif MinusFound le 0>
				 	<cfset HomeTeamFavored = false>
				    <cfset myfav = AwayTeam>
					<cfset myund = HomeTeam>
					<cfset myha  = 'A'>
			  </cfif>
	
				<cfoutput>
				Skipthisone is #skipthisone#...Spd is *#myspd#*, ou is #myou# and HomeTeamFavored = #HomeTeamFavored#....Hometeam=#HomeTeam#....AwayTeam=#AwayTeam#<br>
				</cfoutput>

				<cfif skipthisone is true or myspd is 'pk' or myspd is 'OFF' or myspd is 'Off' or myspd is 'off' or myspd is '' or myspd is ' '>
					OFF.....................................#HomeTeam# vs #awayteam#<br>
					<cfset GoodSpd = false>
					<cfset GoodRun = false>
					
	   			</cfif>
				
			     <cfif myspd is 'pk'>
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
		
				<cfif findit.recordcount is 0 and GoodRun is true>
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
				
				</cfquery>
				--->
				<cfelse>
				Game already exists for #myfav# vs #myund#<br>
				</cifif>
				
	  		</cfif>	
	  	</cfif>
	  
		<cfset StartLookingAtPos = foundit>
		<cfloop index="ii" from="1" to="6">

			<cfset StringToFind = '<a href="/pageloader/pageloader.aspx?page=/data/nba/teams/team'>
		     <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>
	
			  <cfif Foundit le 0 >
			  5555555555555555555555555555555555555555555555555555<br>
						<cfset GoodRun = false>
		
		  	</cfif>	
	
	   		  <cfset LenOfStringToFind = LEN(StringToFind)>
	      	  <cfset BegTeamPos = LenOfStringToFind + 13 + foundit>
	
		     <cfset StartLookingAtPos = BegTeamPos>
	    	 <cfset StringToFind = '</a>'>
	     	<cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>
	
			<cfset StartLookingAtPos = Foundit>
	
	
		</cfloop>
	
			<cfif loopct ge 25>
			    loooooooopct gt 25 <br>
				<cfset Foundit = 0>
			</cfif>
	</cfloop>

	<cfoutput>Goodrun is #goodrun#</cfoutput>
	
	<cfquery datasource="Nba" name="GetStatus">
	Update NBAStatus
	Set Status='RUNGAMESIM'
	</cfquery>

	

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
	
	<cfcase value="Oaklahoma City">
		<cfset myteamabbrev = 'OKC'>
	</cfcase>

	<cfdefaultcase>
		<cfset myteamabbrev = 'OKC'>
	</cfdefaultcase>
	
</cfswitch>
  	<cfreturn  myteamabbrev>
</cffunction>
	
