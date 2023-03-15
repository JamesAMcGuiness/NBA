<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>

<cfset Gametime = '20180222'>
 
<cfquery name="GetSpds" datasource="nba" >
SELECT *
FROM nbaschedule
where trim(GAMETIME) = '#GAMETIME#'
and fav = 'CHA'
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

	<cfset myurl = 'http://127.0.0.1:8500/NBACode/NBAPBP.html'>
	
	<cfoutput>
	#myurl#<br>	
	<cfhttp url="#myurl#" method="GET" resolveurl="false">
	</cfhttp>
	</cfoutput>



	<cfset thepage = '#cfhttp.filecontent#'>

	
<cfset myArryOfPlays = ArrayNew(1)>	

<cfset PlayCt   = 0>
<cfset myStruct = StructNew()>
<cfset StructInsert(myStruct,"PlayCtr",1)>
<cfset StructInsert(myStruct,"Team","")>
<cfset StructInsert(myStruct,"PlayTime","")>
<cfset StructInsert(myStruct,"Player","")>
<cfset StructInsert(myStruct,"PlayDesc","")>
<cfset StructInsert(myStruct,"ShotType","")>
<cfset StructInsert(myStruct,"ShotLength",0)>
<cfset StructInsert(myStruct,"HomeScore",0)>
<cfset StructInsert(myStruct,"AwayScore",0)>
<cfset StructInsert(myStruct,"Quarter",0)>

<cfset myArryOfPlays[1] = structCopy(myStruct)>

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
<cfset LookForFourthQtr = FindStringInPage('#thepage#','#LookFor#',#startpos#)>

<cfset LookFor  = 'Start of 1st quarter'> 
<cfset startpos = 1>
<cfset LookForFirstQtr = FindStringInPage('#thepage#','#LookFor#',#startpos#)>
<cfset Quarter = 1>


<cfset AwayScore = 0>
<cfset HomeScore = 0>
<cfset pts2add   = 0>

<cfif LookForFirstQtr gt 0> 

	<cfoutput>
	LookForFirstQtr found at pos #LookForFirstQtr#
	</cfoutput>
	
	<!--- Time --->
	<cfset LeftSideString   = '<td>'>
	<cfset RightSideString  = '</td>'>
	<cfset startpos         = LookForFirstQtr>
	<cfset LookForPosition  = FindStringInPage('#thepage#','#RightSideString#',#startpos#)>

	<cfif LookForPosition gt 0> 
		<cfset aSTAT    = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

		<cfif aSTAT gt ''>
			<cfset StructUpdate(myStruct,"PlayTime","#aSTAT#")>
			<cfset StructUpdate(myStruct,"Player","")>
			<cfset StructUpdate(myStruct,"PlayDesc","")>
			<cfset StructUpdate(myStruct,"ShotType","")>
			<cfset StructUpdate(myStruct,"ShotLength",0)>
			<cfset StructUpdate(myStruct,"HomeScore",0)>
			<cfset StructUpdate(myStruct,"AwayScore",0)>
			<cfset StructUpdate(myStruct,"Quarter",#Quarter#)>

		</cfif>

	<cfelse>

		<cfset done = true>
	</cfif>


<cfelse>
	<cfset done = true>
</cfif>



<!--- Get to after the Jump Ball --->
<cfset LeftSideString   = '</td>'>
<cfset RightSideString  = '</td>'>
<cfset startpos         = LookForPosition>
<cfset LookForPosition  = FindStringInPage('#thepage#','#LeftSideString#',#startpos#)>





<!--- Loop thru all the plays --->
<cfloop condition ="not Done">
<cfif  #playct# lt 10>
Get here
<cfdump var = #mystruct#>

	<!--- Time Of First Play--->
	<cfset LeftSideString   = '<td>'>
	<cfset RightSideString  = '</td>'>
	<cfset startpos         = LookForPosition>
	<cfset LookForPosition = FindStringInPage('#thepage#','#RightSideString#',#startpos#)>

	<cfif LookForPosition gt 0>

		<cfif LookForPosition lt LookForSecondQtr>
			<cfset Quarter = 1>

		<cfelseif LookForPosition lt LookForThirdQtr>
			<cfset Quarter = 2>

		<cfelseif LookForPosition lt LookForFourthQtr>
			<cfset Quarter = 3>

		<cfelse>
			<cfset Quarter = 4>
		</cfif>


		<cfset aTOP = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

		
		<!--- We found the time of the play... --->
		<cfif aTOP gt ''>

			<cfoutput>
			topfound = #atop#<br>
			</cfoutput>
			
			<cfset PlayCt = PlayCt + 1>

			
			<cfset myStruct = StructNew()>
			<cfset StructInsert(myStruct,"PlayCtr",#PlayCt#)>
			<cfset StructInsert(myStruct,"Team","")>
			<cfset StructInsert(myStruct,"PlayTime","")>
			<cfset StructInsert(myStruct,"Player","")>
			<cfset StructInsert(myStruct,"PlayDesc","")>
			<cfset StructInsert(myStruct,"ShotType","")>
			<cfset StructInsert(myStruct,"ShotLength",0)>
			<cfset StructInsert(myStruct,"HomeScore",0)>
			<cfset StructInsert(myStruct,"AwayScore",0)>
			<cfset StructInsert(myStruct,"Quarter",0)>

			<!--- Check for this next <td>&nbsp;</td>, if found then data is for Home team else data is for away team --->
			<cfset LeftSideString   = "class='center>'">
			<cfset RightSideString  = '<a' >
			<cfset startpos         = LookForPosition + 10>
			<cfset LookForPosition  = FindStringInPage('#thepage#','#RightSideString#',#startpos#)>

			
			About to call Parseit<br>	
			<cfset tdfound = ParseIt('#thepage#',LookForPosition,'#LeftSideString#','#RightSideString#')>

			<cfoutput>
			The value to store is #tdfound#<br>
			</cfoutput>
			
			<cfif tdfound is ' ' or tdfound is '&nbsp;'>
				<cfset PlayFor = '#hometeam#'>
			<cfelse>
				<cfset PlayFor = '#awayteam#'>
			</cfif>

			<cfabort>
			
			<cfset StructUpdate(myStruct,"PlayTime","#aTOP#")>
			<cfset StructUpdate(myStruct,"Player","")>
			<cfset StructUpdate(myStruct,"PlayDesc","")>
			<cfset StructUpdate(myStruct,"Quarter",#Quarter#)>
			<cfset StructUpdate(myStruct,"Team",'#PlayFor#')>


			<!--- Check the quotes for the type of play --->
			<cfset LeftSideString   = "'">
			<cfset RightSideString  = "'">
			<cfset startpos         = LookForPosition>
			
			<cfset tmp = mid('#thepage#',#LookForPosition#,50)>
			<cfoutput>
			Looking for a quote in the following string: at '#tmp#'
			</cfoutput>
			
			<cfabort>
			
			<cfset LookForPosition = FindStringInPage('#thepage#',"#RightSideString#",#startpos#)>

			<!--- quotes found --->
			<cfif LookForPosition gt 0>
			
				<cfset aSTAT    = ParseIt('#thepage#',#StartPos#,"#LeftSideString#","#RightSideString#")>
				
				
				<!--- No shot made --->
				<cfif LEN(aSTAT) is 0>
	
					Not a made or attempted shot...<br>
					
					
					
					<!--- See what the play was --->
					<cfset LeftSideString   = "</a>">
					<cfset RightSideString  = ">">
					<cfset startpos         = LookForPosition>	
					<cfset LookForPosition = FindStringInPage('#thepage#','#RightSideString#',#startpos#)>
					
					<cfif LookForPosition gt 0>
						<br>
						Found the anchor...<br>
						<cfset aPlayDesc = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>
						<cfoutput>#aPlayDesc#</cfoutput>
						<cfabort>
						
						<cfif aPlayDesc gt ''>
							

							<!--- See who was involved in the play desc --->
							<cfset LeftSideString   = 'html">'>
							<cfset RightSideString  = "</a>">
							<cfset startpos         = LookForPosition>	
							<cfset LookForPosition  = FindStringInPage('#thepage#','#RightSideString#',#startpos#)>	
							
							<cfif LookForPosition gt 0>

								<cfset aPlayer = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

	
								<cfif aPlayer gt ''>
	
									
									<cfset StructUpdate(myStruct,"PlayTime","#aTOP#")>
									<cfset StructUpdate(myStruct,"Player","#aPlayer#")>
									<cfset StructUpdate(myStruct,"PlayDesc","#aPlayDesc#")>
									<cfset StructUpdate(myStruct,"Quarter",#Quarter#)>
									<cfset StructUpdate(myStruct,"Team",'#PlayFor#')>

											
									<cfdump var= "#myStruct#">

								</cfif>
							</cfif>	
	
						</cfif>
					</cfif>
				</cfif>	

			<!--- No quotes found Shot was made --->
			<cfelse>					

				No Quotes found!...<br>
			
				<!--- Shot made --->
				<cfif aSTAT is 'bbr-play-score'>
	
					Show was made!..<br>
	
					<!--- See what player took the shot --->
					<cfset LeftSideString   = 'html">'>
					<cfset RightSideString  = "</a">
					<cfset startpos         = LookForPosition>	

					<cfset LookForPosition = FindStringInPage('#thepage#','#RightSideString#',#startpos#)>

					<cfif LookForPosition gt 0>
						<cfset aPlayer    = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

						<cfif aPlayer gt ''>
							<cfset PlayCt = PlayCt + 1>

							<!--- See what happened in the play desc --->
							<cfset LeftSideString   = "a>">
							<cfset RightSideString  = "</td>">
							<cfset startpos         = LookForPosition>	
							<cfset LookForPosition = FindStringInPage('#thepage#','#RightSideString#',#startpos#)>

							<cfif LookForPosition gt 0>
								<cfset aPlayDesc = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>

								<cfif aPlayDesc gt ''>
									
									<cfset StructUpdate(myStruct,"PlayTime","#aTOP#")>
									<cfset StructUpdate(myStruct,"Player","#aPlayer#")>
									<cfset StructUpdate(myStruct,"PlayDesc","#aPlayDesc#")>
									<cfset StructUpdate(myStruct,"Quarter",#Quarter#)>
									<cfset StructUpdate(myStruct,"Team",'#PlayFor#')>

								</cfif>
							</cfif>
						</cfif>
					</cfif>
				</cfif>

			</cfif>
	

		<cfelse>		
		
			<cfset Done = true>
		</cfif>

	
	
	<cfset theshottype = getShotType('#aPlayDesc#')>
	<cfset StructUpdate(myStruct,"ShotType","#theshottype#")>
	<cfset theplaytype = getPlayType('#aPlayDesc#')>
	
	<cfif theshottype is 'SHOT' or theshottype is 'FTA'>
	
		<cfif theshottype is 'SHOT'>
			<cfset theshotlen = getShotLength('#aPlayDesc#')>
			<cfset StructUpdate(myStruct,"ShotLength","#theshotlen#")>	
		</cfif>	

		<cfset pts2add = 0>
		<cfif theplaytype is 'FTMADE' or theplaytype is 'TECHFTMADE'>
			<cfset pts2add = 1>
		</cfif>

		<cfif theplaytype is '2PTMADE'>
			<cfset pts2add = 2>
		</cfif>

		<cfif theplaytype is '3PTMADE'>
			<cfset pts2add = 3>
		</cfif>

	</cfif>
		
		
	<cfif '#PlayFor#' is '#AwayTeam#'>
		
		<cfset AwayScore = AwayScore + pts2Add>
	<cfelse>
		<cfset HomeScore = HomeScore + pts2Add>

	</cfif>
	
	
	<cfset StructUpdate(myStruct,"HomeScore",#homescore#)>
	<cfset StructUpdate(myStruct,"AwayScore",#awayscore#)>

	


	<!--- Add Row To PBP Table 
	<cfquery name="Addit" Datasource="NBA">
		INSERT INTO NBADriveCharts(Team,OffDef,PlayType,Qtr,TimeOfPlay,PlayFor,EasyShot,
	

	</cfquery>
	--->

	<cfdump var="#mySTruct#">

	
	
</cfif>


<cfelse>

	<cfset Done = true>
</cfif>
	
</cfloop>


<cfset Done = true>
</cfloop>









<cffunction name="ParseIt" access="remote" output="yes" returntype="String">

	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />

	<cfargument name="LeftSideString"       type="String"  required="yes" />
	<cfargument name="RightSideString"      type="String"  required="yes" />
 
	<cfset posOfLeftsidestring = FINDNOCASE("#arguments.LeftSideString#",'#arguments.theViewSourcePage#',#arguments.startLookingPosition#)>  
	<cfoutput>
	posOfLeftsidestring = #posOfLeftsidestring#
	</cfoutput>
		
	<cfset LengthOfLeftSideString = LEN('#arguments.LeftSideString#')>

	<cfset posOfRightsidestring    = FINDNOCASE("#arguments.RightSideString#",'#arguments.theViewSourcePage#',#posOfLeftsidestring#)>  	
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
	
	<cfset parseVal = "">
	<cfif LenOfParseVal gt 0>
		<cfset parseVal = Mid('#arguments.theViewSourcePage#',#StartParsePos#,#LenOfParseVal#)>
	</cfif>
	
	<cfreturn parseVal>

</cffunction>



<cffunction name="FindStringInPage" access="remote" output="yes" returntype="Numeric">

	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="LookFor"              type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />

	<cfoutput>
	In FindStringInPage....<br>
	<cfset tmp = mid('#arguments.theViewSourcePage#',#arguments.startLookingPosition#,55)>
	Looking for '#arguments.LookFor#' starting at #tmp#<br>
	</cfoutput>
	
	
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

	<cfif FINDNOCASE('jump ball','#arguments.theplay#') gt 0>
		<cfset play = 'JUMPBALL'>
	</cfif>

	
	
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































