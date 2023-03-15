<cfquery datasource="nba" name="GetGameDay">
Select GameTime from NBAGameTime
</cfquery>
<cfset thegametime = '#GetGameDay.Gametime#'>

<cfset myurl = 'http://www.donbest.com/nba/odds/'>

<cfoutput>
	#myurl#<br>	
	<cfhttp url="#myurl#" method="GET" resolveurl="false">
	</cfhttp>
</cfoutput>

<cfset thepage = '#cfhttp.filecontent#'>
#thepage#
<cfoutput>

</cfoutput>

<cfset origPage = thepage>

<cfset StartPos = 1>
<cfset x = 0>

<cfset x = x + 1>
<cfset LeftSideString  =  '#x#'>
<cfset RightSideString =  '#x+1#'>
<cfloop index = "i" from="1" to="300">
		
			<cfset foundpos               = FindStringInPage('#LeftSideString#','#thepage#',#startpos#)>
			
			<cfif foundpos gt 0>
		
				-- Find Gametime
				<cfset foundpos               = FindStringInPage('#LeftSideString#','#thepage#',#startpos#)> 
				
				<cfset xtheGametime        = ParseIt('#thepage#',#foundpos#,'#LeftSideString#','#RightSideString#')>
				<cfoutput>xtheGametime=#xtheGametime#</cfoutput>
				
				
				<cfset StartPos = StartPos + 10>
				<cfset x = x + 2>
				<cfset LeftSideString  =  '#x#'>
				<cfset RightSideString =  '#x+1#'>
		
				-- Find FAV
				
				<cfset foundpos               = FindStringInPage('#LeftSideString#','#thepage#',#startpos#)>
				
				<cfset FavTeam        = ParseIt('#thepage#',#foundpos#,'#LeftSideString#','#RightSideString#')>
				<cfoutput>FavTeam=#FavTeam#<br></cfoutput>
				<cfoutput>xtheGametime=#xtheGametime#</cfoutput>
				
				
				<cfset StartPos = StartPos + 10>
				<cfset x = x + 2>
				<cfset LeftSideString  =  '#x#'>
				<cfset RightSideString =  '#x+1#'>
			
				-- Find HA
				
				<cfset foundpos               = FindStringInPage('#LeftSideString#','#thepage#',#startpos#)> 
				<cfset HA              = ParseIt('#thepage#',#foundpos#,'#LeftSideString#','#RightSideString#')>
				<cfoutput>HA=#ha#</cfoutput>
				
				<cfset StartPos = StartPos + 10>
				<cfset x = x + 2>
				<cfset LeftSideString  =  '#x#'>
				<cfset RightSideString =  '#x+1#'>
			
			
				-- Find Spd

				<cfset foundpos               = FindStringInPage('#LeftSideString#','#thepage#',#startpos#)>
				<cfset spd              = ParseIt('#thepage#',#foundpos#,'#LeftSideString#','#RightSideString#')>
				<cfoutput>spd=#spd#</cfoutput>
				
				
				<cfset StartPos = StartPos + 10>
				<cfset x = x + 2>
				<cfset LeftSideString  =  '#x#'>
				<cfset RightSideString =  '#x+1#'>
			
				-- Find Total

				<cfset foundpos               = FindStringInPage('#LeftSideString#','#thepage#',#startpos#)> 
				<cfset total              = ParseIt('#thepage#',#foundpos#,'#LeftSideString#','#RightSideString#')>
				<cfoutput>total=#total#</cfoutput>
				
				<cfset StartPos = StartPos + 10>
				<cfset x = x + 2>
				<cfset LeftSideString  =  '#x#'>
				<cfset RightSideString =  '#x+1#'>

			
				-- Find Und
				
				<cfset foundpos               = FindStringInPage('#LeftSideString#','#thepage#',#startpos#)> 
				<cfset UndTeam        = ParseIt('#thepage#',#foundpos#,'#LeftSideString#','#RightSideString#')>
				<cfoutput><br>UndTeam=#UndTeam#<br></cfoutput>
			
				<cfset StartPos = StartPos + 10>
				<cfset x = x + 2>
				<cfset LeftSideString  =  '#x#'>
				<cfset RightSideString =  '#x+1#'>			
				
				<cfquery datasource="nba" name="Addit">
				INSERT INTO NBASchedule(Gametime,Fav,ha,spd,ou,Und) values('#thegametime#','#trim(FavTeam)#','#trim(ha)#',#val(spd)#,#val(total)#,'#trim(UndTeam)#')
				</cfquery>
				
			
				<cfif 1 is 2>
				<cfquery datasource="nba" name="Delit">
				DELETE from NBASchedule
				where gametime = '#thegametime#'
				and FAV = '#FavTeam#'
				</cfquery>
				</cfif>
				
			
			</cfif>
		
			
		
			
		
</cfloop>




<cffunction name="FindStringInPage" access="remote" output="yes" returntype="Numeric">
	-- Returns the position of where the string was found	
	<cfargument name="LookFor"              type="String"  required="yes" />
	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />

	<cfset FoundStringPos = FINDNOCASE('#arguments.LookFor#','#arguments.theViewSourcePage#',#arguments.startLookingPosition#)>  	

	<cfreturn #FoundStringPos# >

</cffunction>


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
	
	
	
	
	<cfset parseVal = Mid('#arguments.theViewSourcePage#',#StartParsePos#,#LenOfParseVal#)>
	<cfoutput>
	StartParsePos = #startparsepos#><br>
	EndParsePos   = #endparsepos#><br>
 	LenOfParseVal = #LenOfParseVal#><br>
	parseVal=#parseVal#	<br>
	</cfoutput>
	
	
	<cfreturn '#parseVal#'>

</cffunction>

