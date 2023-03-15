<cftry>

<cfquery datasource="NBA" name="addit">
	DELETE FROM PIP
</cfquery>
 
<cfquery name="GetTeams" datasource="nba" >
SELECT Distinct Team
FROM NBAData
</cfquery>

<cfset myurl = 'http://www.hoopsstats.com/basketball/fantasy/nba/teamstats/23/4/diffeff/1-1'>


<cfoutput>
#myurl#<br>	
<cfhttp url="#myurl#" method="GET" resolveurl="false">
</cfhttp>
</cfoutput>

<cfset thepage = '#cfhttp.filecontent#'>

<cfset LookFor  = 'Deff'> 
<cfset startpos = 1>
<cfset TeamDefPos = FindStringInPage('#thepage#','#LookFor#',#startpos#)>

<cfoutput>
Team Totals found at pos #TeamDefPos#
</cfoutput>


<cfloop query="GetTeams">

<cfset theTeam = getTeam('#GetTeams.Team#')>

<cfset LookFor  = '#theTeam#'> 
<cfset startpos = TeamDefPos>
<cfset TeamPos = FindStringInPage('#thepage#','#LookFor#',#startpos#)>

<cfset startpos = TeamPos>

<cfloop index="i" from="1" to="18">
	<cfset LookFor   = '</CENTER>'> 
	<cfset StatPos   = FindStringInPage('#thepage#','#LookFor#',#startpos#)>
	<cfset startpos  = StatPos + 10>
</cfloop>

<cfset LeftSideString   = '<CENTER>'>
<cfset RightSideString  = '</CENTER>'>
<cfset aPIP             = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

<cfquery datasource="NBA" name="addit">
	INSERT INTO PIP(Team,PIPRat)
	Values('#GetTeams.Team#',#aPIP#)
</cfquery>

</cfloop>	


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



<cffunction name="getTeam" access="remote" output="yes" returntype="String">

	<cfargument name="Team"    type="String"  required="yes" />
	
	<cfswitch expression="#arguments.Team#">
	
		<cfcase value="DET">
			<cfset retval = 'Detroit'>
		</cfcase>
	
		<cfcase value="CLE">
			<cfset retval = 'Cleveland'>
		</cfcase>
	
		<cfcase value="ATL">
			<cfset retval = 'Atlanta'>
		</cfcase>

		<cfcase value="CHA">
			<cfset retval = 'Charlotte'>
		</cfcase>
	
		<cfcase value="GSW">
			<cfset retval = 'Golden State'>
		</cfcase>

		<cfcase value="DEN">
			<cfset retval = 'Denver'>
		</cfcase>

		<cfcase value="IND">
			<cfset retval = 'Indiana'>
		</cfcase>


		<cfcase value="OKC">
			<cfset retval = 'Oklahoma City'>
		</cfcase>

		
		<cfcase value="SAS">
			<cfset retval = 'San Antonio'>
		</cfcase>

		<cfcase value="LAL">
			<cfset retval = 'L.A.Lakers'>
		</cfcase>

		<cfcase value="MIN">
			<cfset retval = 'Minnesota'>
		</cfcase>

		<cfcase value="MIA">
			<cfset retval = 'Miami'>
		</cfcase>
		
		<cfcase value="BKN">
			<cfset retval = 'Brooklyn'>
		</cfcase>
		
		<cfcase value="MEM">
			<cfset retval = 'Memphis'>
		</cfcase>
		
		<cfcase value="DAL">
			<cfset retval = 'Dallas'>
		</cfcase>
		
		<cfcase value="NOP">
			<cfset retval = 'New Orleans'>
		</cfcase>
		
		<cfcase value="SAC">
			<cfset retval = 'Sacramento'>
		</cfcase>
		
		<cfcase value="POR">
			<cfset retval = 'Portland'>
		</cfcase>
		
		<cfcase value="LAC">
			<cfset retval = 'L.A.Clippers'>
		</cfcase>
		
		<cfcase value="UTA">
			<cfset retval = 'Utah'>
		</cfcase>
		
		<cfcase value="CHI">
			<cfset retval = 'Chicago'>
		</cfcase>
		
		<cfcase value="PHX">
			<cfset retval = 'Phoenix'>
		</cfcase>
		
		<cfcase value="HOU">
			<cfset retval = 'Houston'>
		</cfcase>
		
		<cfcase value="TOR">
			<cfset retval = 'Toronto'>
		</cfcase>

		<cfcase value="NYK">
			<cfset retval = 'New York'>
		</cfcase>		

		<cfcase value="WAS">
			<cfset retval = 'Washington'>
		</cfcase>

		<cfcase value="PHI">
			<cfset retval = 'Philadelphia'>
		</cfcase>

		<cfcase value="ORL">
			<cfset retval = 'Orlando'>
		</cfcase>
		
		<cfcase value="MIL">
			<cfset retval = 'Milwaukee'>
		</cfcase>		
		
	</cfswitch>
	
	<cfreturn '#retval#'>

</cffunction>


<cfquery datasource="Nba" name="UPDATE">
	Insert into NBADataLoadStatus
	(
	ProgramName
	)
	values
	(
	'PIPLoad.cfm'
	)
</cfquery>



<cfcatch type="any">
  <cfoutput>#cfcatch.Detail#</cfoutput>
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlertx.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:PIPLoad.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>


















