

<cfset myurl = 'http://127.0.0.1:8500/NBACode/donbest.htm'>

<cfoutput>
	#myurl#<br>	
	<cfhttp url="#myurl#" method="GET" resolveurl="false">
	</cfhttp>
</cfoutput>

<cfset thepage = '#cfhttp.filecontent#'>
<cfset origPage = thepage>


<cfset StartPos = 1>
<cfset mysubstring = 'oddsTeamWLink'>

<cfset notfound = 1>
<cfset ct = 0>
<cfloop condition = "NotFound = 1">
	
	<cfset foundpos = FindStringInPage('#mysubstring#','#thepage#',#startpos#) >
	
	<cfoutput>
	'#mysubstring#',#startpos#
	</cfoutput>
	
	<cfset foundpos = FINDNOCASE('#mysubstring#','#thepage#',#startpos#)>  	
	<p>
	<cfoutput>
	#foundpos#
	</cfoutput>
	
	<cfif foundpos is 0>
	<cfbreak>
	</cfif>
	
	<cfif foundpos gt 0>
		<cfset ct = ct + 1>
		<cfset StartPos = foundpos + 1>
	<cfelse>
		<cfset NotFound = 0>
		<cfset StartPos = foundpos + 1>
	</cfif>
	<p>
	<cfoutput>
	Startpos:#Startpos#
	</cfoutput>
	
	
	
	
</cfloop>


-- See how many games exist 
<cfset totgames = ct/2 >
<cfoutput>
#totgames#
</cfoutput>

<cfset startpos = 1>
<cfset thepage  = '#origPage#'>

-- For every game...
<cfloop index = "i" from="1" to="#totgames#">
		<cfoutput>
		-- Find Away Team
		<cfset LeftSideString  = 'oddsTeamWLink'>
		foundpos               = FindStringInPage('#LeftSideString#','#thepage#',#startpos#)> 
			
		
		<cfset RightSideString = '</span' >	
		<cfset AwayTeam        = ParseIt('#thepage#',#foundpos#,'#LeftSideString#','#RightSideString#')>


		-- Find Home Team
		<cfset startpos = foundpos + 28>
		<cfset LeftSideString  = 'oddsTeamWLink'>
		foundpos               = FindStringInPage('#LeftSideString#','#thepage#',#startpos#)>
		<cfset RightSideString = '</span'>	
		<cfset HomeTeam        = ParseIt('#thepage#',#foundpos#,'#LeftSideString#','#RightSideString#')>
		
		
		#AwayTeam#/#HomeTeam#
		</cfoutput>

		<cfabort>
		
		-- Get the short names used for Don Best site...
		<cfset shortnameAway = getShortNBAName('#AwayTeam#','DONBEST')>
		<cfset shortnameHome = getShortNBAName('#HomeTeam#','DONBEST')>
		
		<cfif shortnameAway is 'NOTFOUND'>
			<cfabort>
		</cfif>
		
		<cfif shortnameHome is 'NOTFOUND'>
			<cfabort>
		</cfif>
				
		<cfset thespdfound = 'N'>
		<cfset thetotfound = 'N'>
		<cfset NotDone = 1>
		-- Continue until we get a valid spread and total for this game...
		<cfloop condition = "NotDone = 1"> 
	
			<cfif (thespdfound is 'N') AND (thetotfound is 'N')> 
	
	
			<cfset LeftSideString  = 'Line_'>
			foundpos               = FindStringInPage('#thepage#','#LeftSideString#',startpos)>
			<cfset RightSideString  = '</div'>
			
			-- Search for the spread
			thespd = ParseIt('#thepage#',foundpos,LeftSideString,RightSideString)>

			-- Spread was found
			<cfif thespd neq ''>
			
				-- Was this a Total or a Spread?
				<cfif val(thespd) gt 100 >
					<cfset thetot = val(thespd)>
					<cfset thetotfound = 'Y'>
				<cfelse>
					<cfset thespdfound = 'Y'>
					
					-- if spd contains a + than the Away is favored otherwise home team is favorite
					<cfset fnc = Find('+','#thespd#')>

					-- Remove the sign from the spread
					<cfset thespd = Replace('#thespd#','+','')>
					<cfset thespd = Replace('#thespd#','-','')>
				</cfif>
			
			<cfelse>
				<cfset startpos = foundpos>
			</cfif>
			<cfif (thespdfound is 'Y') AND (thetotfound is 'Y')>
				<cfset NotDone = 0>
			</cfif>
			</cfif>
		</cfloop>
			
		-- If we found BOTH a spread and Total then store it....
		<cfif (thespdfound is 'Y') AND (thetotfound is 'Y')>
			-- Home team is favorite
			<cfif fnc is 0>
				<cfset tmp = insertSpread('#gametime#','#hometeam#','#thespd#',#thetot#,'#awayteam#')>
			<cfelse>
				<cfset tmp = insertSpread('#gametime#','#awayteam#','#thespd#',#thetot#,'#hometeam#')>
			</cfif>
		</cfif>
		
</cfloop>


<cffunction name="findSpread" access="remote" output="yes" returntype="String">

	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />
	<cfargument name="RightSideString"      type="String"  required="yes" />
	<cfargument name="spdArray"             type="Array"   required="yes" />

	<cfset FoundSpread = 'N'>
	<cfset origStartingPos = arguments.startLookingPosition>
	
	-- spdArray will look like this (1)='PK', (2) = '>+', (3) = '>-' 
	<cfloop array="#arguments.spdArray#" index="name"> 
		
		-- Search for the spreads in the page
		<cfset lookfor = '#name#'>
		
		<cfloop condition = "foundSpread is 'N'"> 
		
		
				-- See if spread symbol is found
				<cfset foundspd1 = FindStringInPage('#theViewSourcePage#','#lookfor#',#startLookingPosition#)>
				
				-- Spread symbol (+/-/PK) was found
				<cfif foundspd1 gt 0>
				
					-- Look for the right side (</div)
					<cfset foundspd2 = FindStringInPage('#theViewSourcePage#','</div',#foundspd1#)>

					-- Found the right side	
					<cfif foundspd2 gt 0>
					
						-- See what is between the left and right sides
						<cfset leftsidestring  = '#lookfor#'>
						<cfset rightsidestring = '</div'>
						<cfset parseval = parseit('#thepage#',#foundspd1#,'#leftsidestring#','#rightsidestring#')>
						
						-- Found the spread
						<cfif parseval neq ''>
							<cfset FoundSpread = 'Y'>
							--Return the spread
							<cfreturn '#parseval#'>
						<cfelse>
							-- look for spread from another book...
							<cfset startLookingPosition = foundspd2>
							
						</cfif>
						
					</cfif>
					
				</cfif>	
		</cfloop>
		
		-- Look for the next spread type (+,-,PK)
		<cfset startLookingPosition = origStartingPos>
		
	</cfloop>

	<cfif FoundSpread is 'N'>
		tmp = AddTracking('LoadBoxscore2016.cfm','No Spread Found For some games.')
		<cfreturn 'NOTFOUND'>
	</cfif>
	
</cffunction>



<cffunction name="findTotal" access="remote" output="yes" returntype="String">

	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />
	<cfargument name="RightSideString"      type="String"  required="yes" />
	<cfargument name="totArray"             type="Array"   required="yes" />

	<cfset FoundTotal = 'N'>
	<cfset origStartingPos = arguments.startLookingPosition>
	
	-- totArray will look like this '>17', '>18', '>19', '>20', '>21', '>22'
	<cfloop array="#arguments.totArray#" index="name"> 
		
		-- Search for the totals in the page
		<cfset lookfor = '#name#'>
		
		<cfloop condition = "foundtotal is 'N'"> 
		
		
				-- See if total is found
				<cfset foundspd1 = FindStringInPage('#theViewSourcePage#','#lookfor#',#startLookingPosition#)>
				
				-- total was found
				<cfif foundspd1 gt 0>
				
					-- Look for the right side (</div)
					<cfset foundspd2 = FindStringInPage('#theViewSourcePage#','</div',#foundspd1#)>

					-- Found the right side	
					<cfif foundspd2 gt 0>
					
						-- See what is between the left and right sides
						<cfset leftsidestring  = '#lookfor#'>
						<cfset rightsidestring = '</div'>
						<cfset parseval = parseit('#thepage#',#foundspd1#,'#leftsidestring#','#rightsidestring#')>
						
						-- Found the total
						<cfif parseval neq ''>
							<cfset FoundTotal = 'Y'>
							--Return the spread
							<cfreturn '#parseval#'>
						<cfelse>
							-- look for spread from another book...
							<cfset startLookingPosition = foundspd2>
							
						</cfif>
						
					</cfif>
					
				</cfif>	
		</cfloop>
		-- Look for the next spread type (+,-,PK)
		<cfset startLookingPosition = origStartingPos>
		
	</cfloop>

	<cfif FoundSpread is 'N'>
		tmp = AddTracking('LoadBoxscore2016.cfm','No Spread Found For some games.')
		<cfreturn 'NOTFOUND'>
	</cfif>
	
</cffunction>





<cffunction name="AddTracking" access="remote" output="yes" returntype="Void">
	<cfargument name="Module"      type="String"  required="yes" />
	<cfargument name="TrackDesc"   type="String"  required="yes" />

	<cfquery name="GetData" datasource="NBA">
	INSERT INTO Tracking(Module,TrackDesc) VALUES('#arguments.Module#','#arguments.TrackDesc#')
	</cfquery>

</cffunction>


<cffunction name="FindStringInPage" access="remote" output="yes" returntype="Numeric">
	-- Returns the position of where the string was found	
	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="LookFor"              type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />

	<cfoutput>	
	<cfset FoundStringPos = FINDNOCASE('#arguments.LookFor#','#arguments.theViewSourcePage#',#arguments.startLookingPosition#)>  	
	</cfoutput>
	<cfreturn #FoundStringPos# >

</cffunction>

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


<cffunction name="SetupVariables" access="remote" output="yes" returntype="Numeric">

	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="LookFor"              type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />

	<cfset FoundStringPos = FINDNOCASE('#arguments.LookFor#','#arguments.theViewSourcePage#',#arguments.startLookingPosition#)>  	

	<cfreturn #FoundStringPos# >

</cffunction>




<cffunction name="getPBPRatings" output="false" access="public" returnType="numeric">
    <cfargument name="Team"        type="string" required="false" default="" />
    <cfargument name="StatToCheck" type="string" required="false" default="" />
	
	<cfset RetVal = 0>
	
	<cfquery name="GetData" datasource="psp_psp">
		SELECT Rating as theRat
		FROM PBPRatings
		WHERE Team   = '#arguments.Team#'
		AND Category = '#arguments.StatToCheck#'
	</cfquery>
	
	<cfset RetVal = #GetData.theRat#>
</cffunction>	

<cffunction name="compareRatings" output="false" access="public" returnType="string">
    <cfargument name="TableToCheck" type="string" required="false" default="" />
    <cfargument name="fav" type="string" required="false" default="" />
	<cfargument name="und" type="string" required="false" default="" />
    <cfargument name="StatToCheck" type="string" required="false" default="" />
	
	<cfset var retval = "" />

	<cfif arguments.TableToCheck is 'PBPRatings' >
	
		<cfquery name="GetFavData" datasource="psp_psp">
		SELECT Rating as FavRat
		FROM PBPRatings
		WHERE Team = '#arguments.Fav#'
		AND Category = '#arguments.StatToCheck#'
		</cfquery>
	
		<cfquery name="GetUndData" datasource="psp_psp">
		SELECT Rating as UndRat
		FROM PBPRatings
		WHERE Team = '#arguments.Und#'
		AND Category = '#arguments.StatToCheck#'
		</cfquery>
	
		<cfif GetUndData.Rating lte GetFavData.Rating>
			<cfset RetVal = 'X'>
		</cfif>	
	</cfif>
	
	
	<cfif arguments.TableToCheck is 'LineDominationStats' >
	
		<cfquery name="GetFavData" datasource="psp_psp">
		SELECT AVG(WinRate3LPFor) - AVG(WinRate3LPAgst) as FavRat
		FROM LineDominationStats
		WHERE Team = '#arguments.Fav#'
		</cfquery>
	
		<cfquery name="GetUndData" datasource="psp_psp">
		SELECT AVG(WinRate3LPFor) - AVG(WinRate3LPAgst) as UndRat
		FROM LineDominationStats
		WHERE Team = '#arguments.Und#'
		</cfquery>
	
		<cfif GetUndData.Rating lte GetFavData.Rating>
			<cfset RetVal = 'X'>
		</cfif>	
	
	</cfif>
    <cfreturn RetVal />
	
</cffunction>



<cffunction name="updateStatMatchup" output="false" access="public" returnType="void">
    <cfargument name="week"         type="numeric" required="false" default="" />
    <cfargument name="fav"          type="string" required="false" default="" />
	<cfargument name="und"          type="string" required="false" default="" />
    <cfargument name="StatToUpdate" type="string" required="false" default="" />
	<cfargument name="StatValue"    type="string" required="false" default="" />
	
	<cfquery name="UpdData" datasource="psp_psp">
		UPDATE StatMatchup
		SET '#arguments.StatToUpdate#' = '#arguments.StatValue#'
		WHERE Team = '#arguments.Fav#'
		AND week = #arguments.week#  
	</cfquery>
	
</cffunction>

<cffunction name="insertStatMatchup" output="false" access="public" returnType="void">
    
	<cfset theGames = getGames()>
	<cfset theyear  = getSpdYear()>
	
	<cfloop query="#theGames#">
	
		<cfquery name="InsData" datasource="psp_psp">
			INSERT INTO StatMatchup(Week,FAV,UND,SPD,YEAR)
			VALUES(#week#,'#fav#','#und#',#spd#,#theYear#)
		</cfquery>
		
	</cfloop>
	
</cffunction>


<cffunction name="getGames" output="false" access="public" returnType="query">
    
	<cfset theWeek = getSpdWeek()> 
	
	<cfquery name="getGames" datasource="NFLSPDS">
		SELECT *
		FROM NFLSPDS
		WHERE week = #theWeek#  
	</cfquery>
	
	<cfreturn getgames>
	
</cffunction>


<cffunction name="getSpdWeek" output="false" access="public" returnType="numeric">

	<cfquery name="getWeek" datasource="psp_psp">
		SELECT Week + 1 as theweek
		FROM Week
	</cfquery>

	<cfset RetVal = #getWeek.theWeek#>
	
	<cfreturn RetVal />
	
</cffunction>
	
	
<cffunction name="getSpdYear" output="false" access="public" returnType="numeric">

	<cfquery name="getWeek" datasource="psp_psp">
		SELECT NFLYear as theyear
		FROM Week
	</cfquery>

	<cfset RetVal = #getWeek.theyear#>
	
	<cfreturn RetVal />
	
</cffunction>	

	
<cffunction name="getDataLoadWeek" output="false" access="public" returnType="numeric">

	<cfquery name="getWeek" datasource="psp_psp">
		SELECT Week
		FROM Week
	</cfquery>

	<cfset RetVal = #getWeek.Week#>
	
	<cfreturn RetVal />
	
</cffunction>	
	



<cffunction name="createSOS" output="false" access="public" returnType="void">

	<cfset theTeams = getTeams()>
	
	<cfloop query = '#theTeams#'>
	
		--Get the opponents of the team
		<cfset qopp = getOpponents('#theTeams.Team#')>
		<cfset totOppRat = 0>
		
		-- Lookup the opponents rating, add to total
		<cfloop query = '#qopp#'>
			<cfset theRat = getPbPRatings('#qopp.Team#','AvgOfAllRankings')>
			<cfset totOppRat = totOppRat + theRat>
		</cfloop>
	
		-- Create SOS Rating for team
		<cfset temp = insertPBPRatings('#theTeams.Team#','SOS',#totOppRat#,0)>
	
	</cfloop>
	
	<cfset RetVal = #getWeek.Week#>
	
	<cfreturn RetVal />
	
</cffunction>	


<cffunction name="getOpponents" output="false" access="public" returnType="query">
    <cfargument name="Team" type="string" required="false" default="" />
	<cfset theWeek = getSpdWeek()> 
	
	<cfquery name="getOpp" datasource="psp_psp">
		SELECT OPP
		FROM PBPTendencies
		WHERE week = #theWeek#  
		AND TEAM = '#arguments.Team#'
	</cfquery>
	
	<cfset RetVal = getOpp>
</cffunction>	
	


<cffunction name="getAllTeams" output="false" access="public" returnType="query">
	<cfquery name="getTeams" datasource="psp_psp">
		SELECT DISTINCT Team
		FROM PBPTendencies
	</cfquery>
	
	<cfset RetVal = getTeams>
</cffunction>	

<cffunction name="insertPBPRatings" output="false" access="public" returnType="void">
    <cfargument name="Team" type="string" required="false" default="" />
	<cfargument name="Category" type="string" required="false" default="" />
	<cfargument name="Cat_Value" type="Numeric" required="false" default="" />
	<cfargument name="Ranking" type="Numeric" required="false" default="" />
	
		<cfquery name="InsData" datasource="psp_psp">
			DELETE FROM PBPRating WHERE Team = '#arguments.team#'
			AND Category = '#arguments.Category#'
		</cfquery>
	
		<cfquery name="InsData" datasource="psp_psp">
			INSERT INTO PBPRating(Team,Category,Cat_Value,Ranking)
			VALUES('#arguments.team#','#arguments.Category#',#arguments.Cat_Value#',#arguments.Ranking#)
		</cfquery>
		
</cffunction>
	

<cffunction name="createPBPRankings" output="false" access="public" returnType="void">
	<cfargument name="qRankings" type="query" required="false" default="" />
	<cfargument name="Category"  type="string" required="false" default="" />
	
		-- Delete old rows
		<cfquery name="delit" datasource="psp_psp">
			DELETE FROM PBPRatings WHERE Category = '#arguments.Category#'
		</cfquery>
		
		<cfset loopct = 0>
		
		-- For Each row in query Category...
		<cfloop query="#arguments.qRankings#">
		
			<cfset loopct = loopct + 1>
		
			<cfquery name="InsData" datasource="psp_psp">
			INSERT INTO PBPRating(Team,Category,Cat_Value,Ranking)
			VALUES('#arguments.qRankings.team#','#arguments.Category#',#arguments.qRankings.Cat_Value#,#loopct#)
			</cfquery>
			
		</cfloop>
		
</cffunction>	
	



<cffunction name="getShortNBAName" output="false" access="public" returnType="String">

	<cfargument name="LookUpValue" type="string" required="false" default="" />
	<cfargument name="Site"        type="string" required="false" default="" />
	
	<cfset retval = 'NOTFOUND'>
	
	<cfif arguments.Site is 'DONBEST'>
		<cfswitch expression = '#arguments.LookUpValue#'>
		
			<cfcase value ="Brooklyn Nets">
				<cfset retval = "BRK">
			</cfcase>
		
			<cfcase value ="Orlando Magic">
				<cfset retval = "ORL">
			</cfcase>
		
			<cfcase value ="Cleveland Cavaliers">
				<cfset retval = "CLE">
			</cfcase>
		
			<cfcase value ="Chicago Bulls">
				<cfset retval = "CHI">
			</cfcase>
			
			<cfcase value ="New York Knicks">
				<cfset retval = "NYK">
			</cfcase>
			
			<cfcase value ="Boston Celtics">
				<cfset retval = "BOS">
			</cfcase>
			
			<cfcase value ="Minnesota Timberwolves">
				<cfset retval = "MIN">
			</cfcase>
			
			<cfcase value ="Indiana Pacers">
				<cfset retval = "IND">
			</cfcase>
			
			<cfcase value ="Portland Trail Blazers">
				<cfset retval = "POR">
			</cfcase>
			
			<cfcase value ="New Orleans Pelicans">
				<cfset retval = "NOP">
			</cfcase>

			<cfcase value ="Los Angeles Clippers">
				<cfset retval = "LAC">
			</cfcase>

			<cfcase value ="Utah Jazz">
				<cfset retval = "UTA">
			</cfcase>
			
			<cfcase value ="Detroit Pistons">
				<cfset retval = "DET">
			</cfcase>
			
			<cfcase value ="Atlanta Hawks">
				<cfset retval = "ATL">
			</cfcase>
			
			<cfcase value ="Charlotte Hornets">
				<cfset retval = "CHO">
			</cfcase>
		
			<cfcase value ="Golden State Warriors">
				<cfset retval = "GSW">
			</cfcase>
		
			<cfcase value ="Denver Nuggets">
				<cfset retval = "DEN">
			</cfcase>
		
			<cfcase value ="Oklahoma City Thunder">
				<cfset retval = "OKC">
			</cfcase>
		
			<cfcase value ="San Antonio Spurs">
				<cfset retval = "SAS">
			</cfcase>
		
			<cfcase value ="Los Angeles Lakers">
				<cfset retval = "LAL">
			</cfcase>
		
			<cfcase value ="Miami Heat">
				<cfset retval = "MIA">
			</cfcase>
		
			<cfcase value ="Memphis Grizzles">
				<cfset retval = "MEM">
			</cfcase>
		
			<cfcase value ="Dallas Mavericks">
				<cfset retval = "DAL">
			</cfcase>
		
			<cfcase value ="Phoenix Suns">
				<cfset retval = "PHX">
			</cfcase>
		
			<cfcase value ="Houston Rockets">
				<cfset retval = "HOU">
			</cfcase>

			<cfcase value ="Toronto Raptors">
				<cfset retval = "TOR">
			</cfcase>
			
			<cfcase value ="Washington Wizzards">
				<cfset retval = "WAS">
			</cfcase>

			<cfcase value ="Milwaukee Bucks">
				<cfset retval = "MIL">
			</cfcase>
		

			<cfcase value ="Philadelphia 76ers">
				<cfset retval = "PHI">
			</cfcase>
		</cfswitch>
	</cfif>	
		
	<cfreturn '#retval#'>		
		
</cffunction>	


<cffunction name="insertNBASpread" output="false" access="public" returnType="void">
    <cfargument name="Gametime" type="string" required="false" default="" />
	<cfargument name="Fav"      type="string" required="false" default="" />
	<cfargument name="Spd"      type="Numeric" required="false" default="" />
	<cfargument name="Total"    type="Numeric" required="false" default="" />
	<cfargument name="Und"      type="string" required="false" default="" />

	<cfquery name="insSpd" datasource="NBA">
	INSERT INTO NBASCHEDULE(GAMETIME,FAV,SPD,TOTAL,UND) VALUES ('#arguments.Gametime#','#argumments.Fav#',#arguments.Spd#,#arguments.Total#,'#arguments.Und#')
	</cfquery>

</cffunction>









	
	
	