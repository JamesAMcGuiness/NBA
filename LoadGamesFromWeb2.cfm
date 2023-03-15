
<cfabort>

<cffile action="read"
	file="c:\CFusionMX7\wwwroot\pspweb\NBA\nbaspds.txt" 
	variable="myPage">

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
	 <cfset loopct = loopct + 1>
	 
     <cfset StringToFind = '<a href="/pageloader/pageloader.aspx?page=/data/nba/teams/team'>
     <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>

	  <cfif Foundit le 0 >
		<cfabort>
	  </cfif>	

     <cfset LenOfStringToFind = LEN(StringToFind)>
      <cfset BegTeamPos = LenOfStringToFind + 13 + foundit>

     <cfset StartLookingAtPos = BegTeamPos>
     <cfset StringToFind = '</a>'>
     <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>

	  <cfif Foundit le 0 >
		<cfabort showerror="Did not find end anchor.">
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
		<cfabort>
	  </cfif>	


     <cfset LenOfStringToFind = LEN(StringToFind)>
     <cfset BegTeamPos = LenOfStringToFind + 13 + foundit>

     <cfset StartLookingAtPos = BegTeamPos>
     <cfset StringToFind = '</a>'>
     <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>

	  <cfif Foundit le 0 >
		<cfabort showerror="Did not find end anchor.">
	  </cfif>
     
	 <cfset myteam = Mid(mypage,BegTeamPos,(Foundit - BegTeamPos))>
    
	  <cfset StartLookingAtPos = foundit>
	  <cfoutput>	
	  <cfset myteam = #setTeamName(myteam)#>
	  </cfoutput>
		  
	<cfset HomeTeam = myteam>


			   <cfloop index="ii" from="1" to "11">
	  
		  			-------------------------------- Gets the opening line -------------------------------
				  <cfset StringToFind = '<td class="datacell"><div class=""><div class="right">-1</div>'>
				  <cfset LenOfStringToFind = Len(StringToFind)>
				  <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>
				  <cfset BegSpdPos = LenOfStringToFind + foundit>  	
			  
				  <cfset StartLookingAtPos = BegSpdPos> 
			    			  
			  </cfloop>				  
							  
							  
			  <cfset StringToFind = '</div>'>
			  <cfset LenOfStringToFind = Len(StringToFind)>
			  <cfset Foundit1=Findnocase(StringToFind,mypage,StartLookingAtPos)>
			  <cfset BegSpdPos = LenOfStringToFind + foundit1>  	
			  <cfset StartLookingAtPos = BegSpdPos> 

			  <cfset StringToFind = '</div>'>
			  <cfset LenOfStringToFind = Len(StringToFind)>
			  <cfset Foundit2=Findnocase(StringToFind,mypage,StartLookingAtPos)>
			  <cfset EndSpdPos = foundit2 - 1>  	

			  <cfset myspd = Mid(mypage,BegSpdPos,(Foundit2 - BegSpdPos))>
	
			  			  
			  <cfset StartLookingAtPos = EndSpdPos> 
			    			  
			  <cfset StringToFind = '</td>'>
			  <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>
			  <cfset myou = Mid(mypage,BegSpdPos,(Foundit - BegSpdPos))>
			
	     	  <cfset StartLookingAtPos = foundit> 
			-------------------------------------------------
				
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
				Spd is #myspd#, ou is #myou# and HomeTeamFavored = #HomeTeamFavored#....Hometeam=#HomeTeam#....AwayTeam=#AwayTeam#<br>
				</cfoutput>
	  
			     <cfif myspd is 'pk'>
					<cfset myspd = 0>
				</cfif>
	  
	  			<cfset finalspd = abs(myspd)>
	  
	  			<cfquery datasource="NBAschedule" name="Loadit">
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
				'#DateFormat(now(),"yyyymmdd")#',
				'#myfav#',
				'#myha#',
				#finalspd#,
				'#myund#',
				#myou#)
				
				</cfquery>
	  
	  
	  
	  
		<cfset StartLookingAtPos = foundit>
		<cfloop index="ii" from="1" to="6">

			<cfset StringToFind = '<a href="/pageloader/pageloader.aspx?page=/data/nba/teams/team'>
		     <cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>
	
			  <cfif Foundit le 0 >
				<cfabort>
		  	</cfif>	
	
	   		  <cfset LenOfStringToFind = LEN(StringToFind)>
	      	  <cfset BegTeamPos = LenOfStringToFind + 13 + foundit>
	
		     <cfset StartLookingAtPos = BegTeamPos>
	    	 <cfset StringToFind = '</a>'>
	     	<cfset Foundit=Findnocase(StringToFind,mypage,StartLookingAtPos)>
	
			<cfset StartLookingAtPos = Foundit>
	
	
		</cfloop>
	
			<cfif loopct ge 25>
				<cfset Foundit = 0>
			</cfif>
	</cfloop>
	
	
	
	
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

</cfswitch>
  	<cfreturn  myteamabbrev>
</cffunction>
	
