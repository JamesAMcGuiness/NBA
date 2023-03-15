




<cfoutput>
<cfhttp url="https://www.nba.com/game/phi-vs-det-0022000243" method="GET">
</cfhttp> 
</cfoutput>

<cfoutput>
<cfset mypage = #cfhttp.FileContent#>
</cfoutput>

<cfset FoundLSSPos = Find('PITP','#mypage#',1) >

<cfoutput>
#FoundLSSPos#
</cfoutput>

<cfabort>



<cfquery datasource="nba" Name="GetGames">
Select n.*
from NBASchedule n, NbaGametime gt
where gt.Gametime = n.Gametime
</cfquery>

<cfset GameTime = GetGames.GameTime>

<cfset yyyy = Left('#Gametime#',4)>
<cfset MM = MID('#Gametime#',5,2)>
<cfset DD = Right('#Gametime#',2)>

<cfset theDate = '#yyyy#' & '-' & '#mm#' & '-' & '#dd#'>


<cfset myurl = 'https://www.nba.com/games?date=#thedate#'>
	
<cfoutput>
<cfhttp url="#myurl#" method="GET">
</cfhttp> 
</cfoutput>

<cfoutput>
<cfset mypage = #cfhttp.FileContent#>
#myurl#
</cfoutput>




<cfset lss= '<a href="/game/'>
<cfset rss= ' class='>


<cfset startpos = 1>
<cfloop index="x" from="1" to="20">

<cfset FoundLSSPos = Find('<a href="/game/','#mypage#',#startpos#) >

<cfif FoundLSSPos is 0>
	<cfabort>
</cfif>	

<cfset FoundRSSPos = Find('<a href="/game/','#mypage#',#FoundLSSPos#) >
<cfset GetURL = Paresit('#mypage#',#FoundLSSPos#,'<',' c')>
<cfset StartPos = FoundRSSPos + 10> 
<cfset lenofstring = LEN(GetURL)>

<cfset FinalURL = 'https://www.nba.com' & '#mid(GetURL,9,lenofstring - 1)#'>


<cfoutput>
#replace(FinalURL,'"','')#<br>
</cfoutput>


</cfloop>



<cffunction name="FindStringInPage" access="remote" output="yes" returntype="Numeric">
	-- Returns the position of where the string was found	
	<cfargument name="LookFor"              type="String"  required="yes" />
	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />

	<cfset FoundStringPos = FINDNOCASE('#arguments.LookFor#','#arguments.theViewSourcePage#',#arguments.startLookingPosition#)>  	

	<cfreturn #FoundStringPos# >

</cffunction>
				   

<cffunction name="paresit" access="remote" output="yes" returntype="String">

	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />
	<cfargument name="LeftSideString"       type="String"  required="yes" />
	<cfargument name="RightSideString"      type="String"  required="yes" />
 
	<cfif 1 is 2>
	<cfoutput>
	Search on #arguments.theViewSourcePage# for Leftside:  #arguments.LeftsideString# at spot #arguments.startLookingPosition#<br>
	</cfoutput>
	</cfif>
 
	<cfset posOfLeftsidestring = FINDNOCASE('#arguments.LeftSideString#','#arguments.theViewSourcePage#',#arguments.startLookingPosition#)>  
	
	<cfif 1 is 2>
	<cfoutput>
	posOfLeftsidestring = #posOfLeftsidestring#
	</cfoutput>
	</cfif>	
		
	<cfset LengthOfLeftSideString = LEN('#arguments.LeftSideString#')>

	<cfset posOfRightsidestring    = FINDNOCASE('#arguments.RightSideString#','#arguments.theViewSourcePage#',#posOfLeftsidestring# +1)>  	
	<cfset LengthOfRightSideString = LEN('#arguments.RightSideString#')>

	<cfif 1 is 2>
	<cfoutput>
	Search on #arguments.theViewSourcePage# for Rightside: #arguments.RightsideString# at spot #posOfLeftsidestring# +1 <br>
	</cfoutput>
	</cfif>

	<p>
	
	<cfif 1 is 2>
	<cfoutput>
	posOfRightsidestring = #posOfRightsidestring#
	</cfoutput>
	</cfif>
	
	<cfif posOfRightsidestring neq 0 and posOfleftsidestring neq 0>
		
		<cfset StartParsePos = posOfLeftsidestring  + LengthOfLeftSideString>
		<cfset EndParsePos   = posOfRightsidestring>
		<cfset LenOfParseVal = (#EndParsePos# - #StartParsePos#)>
		
		<cfset parseVal = Mid('#arguments.theViewSourcePage#',#StartParsePos#,#LenOfParseVal#)>

		<cfif 1 is 1>
		<cfoutput>
		StartParsePos = #startparsepos#><br>
		EndParsePos   = #endparsepos#><br>
		LenOfParseVal = #LenOfParseVal#><br>
		parseVal=#parseVal#	<br>
		</cfoutput>
		</cfif>
	
	<cfelse>
		<cfset parseVal = '0'>
	</cfif>

	
	<cfreturn '#parseVal#'>

</cffunction>
