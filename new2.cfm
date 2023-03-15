
<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>


 
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

	<cfif hometeam is 'CHA' >
		<cfset hometeam = 'CHO'>
	</cfif>


	<cfif awayteam is 'BKN' >
		<cfset awayteam = 'BRK'>
	</cfif>
	
	<cfif awayteam is 'PHX' >
		<cfset awayteam = 'PHO'>
	</cfif>

	<cfif awayteam is 'CHA' >
		<cfset awayteam = 'CHO'>
	</cfif>

	<cfset myurl = 'http://www.basketball-reference.com/boxscores/' & '#gametime#' & '0' & '#hometeam#.html'>

	<cfoutput>
	#myurl#<br>	
	<cfhttp url="#myurl#" method="GET" resolveurl="false">
	</cfhttp>
	</cfoutput>



	<cfset thepage = '#cfhttp.filecontent#'>


<cfset PlayCt   = 0>
<cfset myStruct = StructNew()>
<cfset done     = false>

<!--- Find Main Lookup tag --->
<cfset LookFor  = 'Start of 2nd quarter'> 
<cfset startpos = 1>
<cfset LookForSecondQtr = FindStringInPage('#thepage#','#LookFor#',#startpos#)>

<cfset LookFor  = 'Start of 3rd quarter'> 
<cfset startpos = 1>
<cfset LookForThirdQtr = FindStringInPage('#thepage#','#LookFor#',#startpos#)>

<cfset LookFor  = 'Start of 4th quarter'> 
<cfset startpos = 1>
<cfset LookForThirdQtr = FindStringInPage('#thepage#','#LookFor#',#startpos#)>

<cfset LookFor  = 'Start of 1st quarter'> 
<cfset startpos = 1>
<cfset LookForFirstQtr = FindStringInPage('#thepage#','#LookFor#',#startpos#)>
<cfset Quarter = 1>


<cfset AwayScore = 0>
<cfset HomeScore = 0>


<cfif LookForFirstQtr gt 0> 


	<cfoutput>
	LookForPosition found at pos #LookForPosition#
	</cfoutput>

	<!--- Time --->
	<cfset LeftSideString   = '<td>'>
	<cfset RightSideString  = '</td>'>
	<cfset startpos         = LookForFirstQtr>
	<cfset LookForPosition  = FindStringInPage('#thepage#','#RightSideString#',#startpos#)>



	<cfif LookForPosition gt 0> 
		<cfset aSTAT    = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

		<cfif aSTAT gt ''>
			<cfset PlayCt = PlayCt + 1>
	
			<cfset StructInsert(myStruct,"PlayCtr",#playct#>
			

		</cfif>

	<cfelse>

		<cfset done = true>
	</cfif>

<cfelse>

		<cfset done = true>
	</cfif>




</cfloop>



<cffunction name="ParseIt" access="remote" output="yes" returntype="String">

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
	
	
	<cfreturn parseVal>

</cffunction>



<cffunction name="FindStringInPage" access="remote" output="yes" returntype="Numeric">

	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="LookFor"              type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />

	<cfset FoundStringPos = FINDNOCASE('#arguments.LookFor#','#arguments.theViewSourcePage#',#arguments.startLookingPosition#)>  	

	<cfreturn #FoundStringPos# >

</cffunction>



<cffunction name="SetupVariables" access="remote" output="yes" returntype="Numeric">

	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="LookFor"              type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />

	<cfset FoundStringPos = FINDNOCASE('#arguments.LookFor#','#arguments.theViewSourcePage#',#arguments.startLookingPosition#)>  	

	<cfreturn #FoundStringPos# >

</cffunction>



<cffunction name="getPlayType" access="remote" output="yes" returntype="String">

	<cfargument name="thePlay"    type="String"  required="yes" />
	
	<cfoutput>
	<cfset play = 'Not found - #arguments.theplay#'>
	</cfoutput>

	<cfif FINDNOCASE('makes 2-pt','#arguments.theplay#') gt 0>
		<cfset play = '2PTMADE'>
	</cfif>

	<cfif FINDNOCASE('makes 3-pt','#arguments.theplay#') gt 0>
		<cfset play = '3PTMADE'>
	</cfif>

	<cfif FINDNOCASE('misses 2-pt','#arguments.theplay#') gt 0>
		<cfset play = '2PTMISS'>
	</cfif>

	<cfif FINDNOCASE('misses 3-pt','#arguments.theplay#') gt 0>
		<cfset play = '3PTMISS'>
	</cfif>


	<cfif FINDNOCASE('Offensive rebound','#arguments.theplay#') gt 0>
		<cfset play = 'OFFREB'>
	</cfif>

	<cfif FINDNOCASE('Defensive rebound','#arguments.theplay#') gt 0>
		<cfset play = 'DEFREB'>
	</cfif>

	<cfif FINDNOCASE('Turnover','#arguments.theplay#') gt 0>
		<cfset play = 'TURNOVER'>
	</cfif>

	<cfif FINDNOCASE('Personal foul','#arguments.theplay#') gt 0>
		<cfset play = 'PERSONALFOUL'>
	</cfif>


	<cfif FINDNOCASE('Shooting foul','#arguments.theplay#') gt 0>
		<cfset play = 'SHOOTINGFOUL'>
	</cfif>

	<cfif FINDNOCASE('Loose ball foul','#arguments.theplay#') gt 0>
		<cfset play = 'LOOSEBALLFOUL'>
	</cfif>
	
	<cfif FINDNOCASE('Technical foul','#arguments.theplay#') gt 0>
		<cfset play = 'TECHNICALFOUL'>
	</cfif>
	
	
	<cfif FINDNOCASE('makes free throw','#arguments.theplay#') gt 0>
		<cfset play = 'FTMADE'>
	</cfif>

	<cfif FINDNOCASE('makes technical free throw','#arguments.theplay#') gt 0>
		<cfset play = 'TECHFTMADE'>
	</cfif>

	<cfif FINDNOCASE('misses technical free throw','#arguments.theplay#') gt 0>
		<cfset play = 'TECHFTMISS'>
	</cfif>

		
	<cfif FINDNOCASE('misses free throw','#arguments.theplay#') gt 0>
		<cfset play = 'FTMISS'>
	</cfif>

	<cfif FINDNOCASE('timeout','#arguments.theplay#') gt 0>
		<cfset play = 'TIMEOUT'>
	</cfif>
	
	
	<cfif FINDNOCASE('Offensive charge foul','#arguments.theplay#') gt 0>
		<cfset play = 'CHARGEFOUL'>
	</cfif>
	
	
	<cfif FINDNOCASE('Personal block foul','#arguments.theplay#') gt 0>
		<cfset play = 'BLOCKFOUL'>
	</cfif>
	

	<cfreturn '#play#' >

</cffunction>


<cffunction name="getShotType" access="remote" output="yes" returntype="String">

	<cfargument name="thePlay"    type="String"  required="yes" />
	
	<cfoutput>
	<cfset play = 'Not Found - #arguments.theplay#'>
	</cfoutput>

	<cfif FINDNOCASE('makes 2-pt','#arguments.theplay#') gt 0>
		<cfset play = 'SHOT'>
	</cfif>

	<cfif FINDNOCASE('makes 3-pt','#arguments.theplay#') gt 0>
		<cfset play = 'SHOT'>
	</cfif>

	<cfif FINDNOCASE('misses 2-pt','#arguments.theplay#') gt 0>
		<cfset play = 'SHOT'>
	</cfif>

	<cfif FINDNOCASE('misses 3-pt','#arguments.theplay#') gt 0>
		<cfset play = 'SHOT'>
	</cfif>


	<cfif FINDNOCASE('Offensive rebound','#arguments.theplay#') gt 0>
		<cfset play = 'REBOUND'>
	</cfif>

	<cfif FINDNOCASE('Defensive rebound','#arguments.theplay#') gt 0>
		<cfset play = 'REBOUND'>
	</cfif>

	<cfif FINDNOCASE('Turnover','#arguments.theplay#') gt 0>
		<cfset play = 'TURNOVER'>
	</cfif>

	<cfif FINDNOCASE('Personal foul','#arguments.theplay#') gt 0>
		<cfset play = 'FOUL'>
	</cfif>


	<cfif FINDNOCASE('Shooting foul','#arguments.theplay#') gt 0>
		<cfset play = 'FOUL'>
	</cfif>

	<cfif FINDNOCASE('Loose ball foul','#arguments.theplay#') gt 0>
		<cfset play = 'FOUL'>
	</cfif>
	
	<cfif FINDNOCASE('Technical foul','#arguments.theplay#') gt 0>
		<cfset play = 'FOUL'>
	</cfif>
	
	
	<cfif FINDNOCASE('makes free throw','#arguments.theplay#') gt 0>
		<cfset play = 'FTA'>
	</cfif>

	<cfif FINDNOCASE('makes technical free throw','#arguments.theplay#') gt 0>
		<cfset play = 'FTA'>
	</cfif>

	<cfif FINDNOCASE('misses technical free throw','#arguments.theplay#') gt 0>
		<cfset play = 'FTA'>
	</cfif>

		
	<cfif FINDNOCASE('misses free throw','#arguments.theplay#') gt 0>
		<cfset play = 'FTA'>
	</cfif>

	<cfif FINDNOCASE('timeout','#arguments.theplay#') gt 0>
		<cfset play = 'TIMEOUT'>
	</cfif>
	
	
	<cfif FINDNOCASE('Offensive charge foul','#arguments.theplay#') gt 0>
		<cfset play = 'FOUL'>
	</cfif>
	
	
	<cfif FINDNOCASE('Personal block foul','#arguments.theplay#') gt 0>
		<cfset play = 'FOUL'>
	</cfif>
	
	<cfreturn '#play#' >

</cffunction>



<cffunction name="getShotLength" access="remote" output="yes" returntype="Number">
	<cfargument name="thePlay"    type="String"  required="yes" />

	<cfset los = '-1'>

	<cfset LookForPosition  = FindStringInPage('#arguments.theplay#','at rim',#startpos#)>
	<cfif LookForPosition gt 0> 
		<cfset los = '0'>		
	<cfelse>

		<cfset LeftSideString   = 'from'>
		<cfset RightSideString  = 'ft'>
		<cfset startpos         = 1>
		<cfset LookForPosition  = FindStringInPage('#arguments.theplay#','#RightSideString#',#startpos#)>


		<cfif LookForPosition gt 0>
			<cfset los = ParseIt('#arguments.theplay#',#StartPos#,'#LeftSideString#','#RightSideString#')>
		</cfif>
	</cfif>

	<cfreturn #val(los)# >

</cffunction>































