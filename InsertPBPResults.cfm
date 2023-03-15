	<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>

	
	<cfquery datasource="nba" name="GetIt">
	UPDATE RawPBP
	SET AwayTeam = 'PHX'
	where AwayTeam = 'PHO'
	</cfquery>

	<cfquery datasource="nba" name="GetIt">
	UPDATE RawPBP
	SET HomeTeam = 'PHX'
	where HomeTeam = 'PHO'
	</cfquery>

	<cfquery datasource="nba" name="GetIt">
	UPDATE RawPBP
	SET AwayTeam = 'CHA'
	where AwayTeam = 'CHO'
	</cfquery>

	<cfquery datasource="nba" name="GetIt">
	UPDATE RawPBP
	SET HomeTeam = 'CHA'
	where HomeTeam = 'CHO'
	</cfquery>
	
	<cfquery datasource="nba" name="GetIt">
	UPDATE RawPBP
	SET AwayTeam = 'NOP'
	where AwayTeam = 'NOH'
	</cfquery>

	<cfquery datasource="nba" name="GetIt">
	UPDATE RawPBP
	SET HomeTeam = 'NOP'
	where HomeTeam = 'NOH'
	</cfquery>
	
	<cfquery datasource="nba" name="GetIt">
	UPDATE RawPBP
	SET AwayTeam = 'BKN'
	where AwayTeam = 'BRK'
	</cfquery>

	<cfquery datasource="nba" name="GetIt">
	UPDATE RawPBP
	SET HomeTeam = 'BKN'
	where HomeTeam = 'BRK'
	</cfquery>
	
<cfquery name="Del" datasource="nba" >
DELETE FROM PBPResults
where trim(GAMETIME) = '#GAMETIME#'
</cfquery>



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

	<cfif ha is 'H'>
		<cfset HomeTeam = myfav>
		<cfset AwayTeam = myund>
	<cfelse>
		<cfset HomeTeam = myund>
		<cfset AwayTeam = myfav>
	</cfif>	
		
	<cfquery datasource="nba" name="GetIt">
	Select * from RawPBP 
	where gametime = '#gametime#'
	and AwayTeam = '#AwayTeam#'
	and HomeTeam = '#HomeTeam#'
	order by id
	</cfquery>


	

<cfset AwayPosCtr = 0>
<cfset HomePosCtr = 0>

<cfset Homescore = 0>
<cfset Awayscore = 0>


<cfset x = 0>
<cfoutput query="GetIt">
<cfset x = x + 1>
<cfif x gt 2>
<cfset thestring = GetIt["thedata"][#x#]>
<cfset thePeriod = GetIt["Quarter"][#x#]>

<cfset thesubstring = "*BEGIN*">
<p>
<cfset occurrences = ( Len(thestring) - Len(Replace(thestring,"#thesubstring#",'','all')) ) / Len(thesubstring) >
The string is #thestring#<br>

<cfset thestring = GetIt["thedata"][#x#]>
<cfset thesubstring = "*BEGIN*&nbsp;*END*">

<cfset foundthem = FINDNOCASE('#thesubstring#','#thestring#')>





<cfset occurrences = ( Len(thestring) - Len(Replace(thestring,"#thesubstring#",'','all')) ) / Len(thesubstring) >

<cfset StatsFor = HomeTeam>
<cfif Foundthem gt 100>
	<cfset StatsFor = AwayTeam>
</cfif>	

The Stats are for #StatsFor#<br>



<cfset TimeOfPlay = ParseIt('#thestring#',1,'*BEGIN*','*END*')>
The TIME OF PLAY is: #TimeOfPlay#<br>		

<cfset pt = getPlayType(thestring)>
PlayType is #pt#<br>

<cfset st = getShotType(thestring)>
Shot Type is #st#<br>

<cfset sl = 0>
<cfif st is 'SHOT'>
	<cfset sl = getShotLength(thestring)>
	Shot Length is #sl#<br>
</cfif>

<cfif st is 'SHOT' or st is 'FTA' or st is 'REBOUND' or st is 'TURNOVER'>

<cfif StatsFor is AwayTeam>
	<cfset AwayPosCtr = AwayPosCtr + 1>
	The Away Possession Ctr is #AwayPosCtr#<br>
<cfelse>
	<cfset HomePosCtr = HomePosCtr + 1>
	The Home Possession Ctr is #HomePosCtr#<br>
</cfif>
	




	<cfif pt is '2PTMADE'>
	
		<cfif StatsFor is AwayTeam>
			<cfset AwayScore = AwayScore + 2>	 
		<cfelse>
			<cfset HomeScore = HomeScore + 2>
		</cfif>

	</cfif>	
	
	<cfif pt is '3PTMADE'>
	
		<cfif StatsFor is AwayTeam>
			<cfset AwayScore = AwayScore + 3>	 
		<cfelse>
			<cfset HomeScore = HomeScore + 3>
		</cfif>

	</cfif>	
	
	<cfif pt is 'FTMADE' or pt is 'TECHFTMADE' >
	
		<cfif StatsFor is AwayTeam>
			<cfset AwayScore = AwayScore + 1>	 
		<cfelse>
			<cfset HomeScore = HomeScore + 1>
		</cfif>

	</cfif>	
	
</cfif>	
AwayScore = #AwayScore#<br>
HomeScore = #HomeScore#<br>
<cfset Sit = AwayScore - HomeScore>
The Away Score situation is: #Sit#<br>
	
<cfset nf = FINDNOCASE('not found','#pt#')>	

	
	
	
<cfif nf lt 1>	
<cfif st is 'SHOT' or st is 'REBOUND' or st is 'TURNOVER' or st is 'FOUL' or st is 'FTA'>

	<cfif st is 'FTA'>
		<cfset sl = 15>
	</cfif>	

<cfif StatsFor is AwayTeam>	
	<cfquery datasource="Nba" name="Addit">
		INSERT INTO PBPResults(Gametime,Team,opp,ha,PossessionCtr,Period,ScoreSituation,TimeOfPlay,PlayType,ShotType,ShotLength,OffDef,TeamScore,OppScore)
		VALUES('#gametime#','#AwayTeam#','#HomeTeam#','A',#AwayPosCtr#,#val(theperiod)#,#AwayScore - HomeScore#,'#TimeOfPlay#','#Pt#','#ST#',#sl#,'O',#AwayScore#,#HomeScore#)
	</cfquery>	

	<cfquery datasource="Nba" name="Addit">
		INSERT INTO PBPResults(Gametime,Team,opp,ha,PossessionCtr,Period,ScoreSituation,TimeOfPlay,PlayType,ShotType,ShotLength,OffDef,TeamScore,OppScore)
		VALUES('#gametime#','#HomeTeam#','#AwayTeam#','H',#HomePosCtr#,#val(theperiod)#,#HomeScore - AwayScore#,'#TimeOfPlay#','#Pt#','#St#',#sl#,'D',#HomeScore#,#AwayScore#)
	</cfquery>	
<cfelse>
	<cfquery datasource="Nba" name="Addit">
		INSERT INTO PBPResults(Gametime,Team,opp,ha,PossessionCtr,Period,ScoreSituation,TimeOfPlay,PlayType,ShotType,ShotLength,OffDef,TeamScore,OppScore)
		VALUES('#gametime#','#HomeTeam#','#AwayTeam#','H',#HomePosCtr#,#val(theperiod)#,#HomeScore - AwayScore#,'#TimeOfPlay#','#Pt#','#St#',#sl#,'O',#HomeScore#,#AwayScore#)
	</cfquery>

	<cfquery datasource="Nba" name="Addit">
		INSERT INTO PBPResults(Gametime,Team,opp,ha,PossessionCtr,Period,ScoreSituation,TimeOfPlay,PlayType,ShotType,ShotLength,OffDef,TeamScore,OppScore)
		VALUES('#gametime#','#AwayTeam#','#HomeTeam#','A',#AwayPosCtr#,#val(theperiod)#,#AwayScore - HomeScore#,'#TimeOfPlay#','#Pt#','#St#',#sl#,'D',#AwayScore#,#HomeScore#)
	</cfquery>	

</cfif>
</cfif>
</cfif>	
</cfif>
</cfoutput>
</cfLOOP>




<cffunction name="ParseIt" access="remote" output="yes" returntype="String">

	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />

	<cfargument name="LeftSideString"       type="String"  required="yes" />
	<cfargument name="RightSideString"      type="String"  required="yes" />
 
	<cfset posOfLeftsidestring = FINDNOCASE('#arguments.LeftSideString#','#arguments.theViewSourcePage#',#arguments.startLookingPosition#)>  
	<!---
	<cfoutput>
	posOfLeftsidestring = #posOfLeftsidestring#
	</cfoutput>
	--->
	
	<cfset LengthOfLeftSideString = LEN('#arguments.LeftSideString#')>

	<cfset posOfRightsidestring    = FINDNOCASE('#arguments.RightSideString#','#arguments.theViewSourcePage#',#posOfLeftsidestring#)>  	
	<cfset LengthOfRightSideString = LEN('#arguments.RightSideString#')>

	<!---

	<cfoutput>
	posOfRightsidestring = #posOfRightsidestring#
	</cfoutput>
	--->
	
	<cfset StartParsePos = posOfLeftsidestring  + LengthOfLeftSideString>
	<cfset EndParsePos   = posOfRightsidestring>
 	<cfset LenOfParseVal = (#EndParsePos# - #StartParsePos#)>

	<!---
	
	<cfoutput>
	StartParsePos = #startparsepos#><br>
	EndParsePos   = #endparsepos#><br>
 	LenOfParseVal = #LenOfParseVal#><br>
	</cfoutput>
	--->
	
	
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



<cffunction name="getShotLength" access="remote" output="yes" returntype="String">
	<cfargument name="thePlay"    type="String"  required="yes" />

	<cfset startpos = 1>
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

	<cfreturn '#los#' >

</cffunction>

