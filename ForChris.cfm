<cftry>

<cfif 1 is 2>
www.mtsamples.com/site/pages/sample.asp?Type=93-Emergency Room Reports&Sample=1921-Abdominal Pain - Consult
www.mtsamples.com/site/pages/sample.asp?Type=93-Emergency Room Reports&Sample=2294-Abrasions & Lacerations - ER Visit
www.mtsamples.com/site/pages/sample.asp?Type=93-Emergency Room Reports&Sample=2334-Accidental Celesta Ingestion - ER Visit
www.mtsamples.com/site/pages/sample.asp?Type=93-Emergency Room Reports&Sample=2758-Agitation - ER Visit
www.mtsamples.com/site/pages/sample.asp?Type=93-Emergency Room Reports&Sample=2166-Air Under Diaphragm - Consult
www.mtsamples.com/site/pages/sample.asp?Type=93-Emergency Room Reports&Sample=1867-Airway Compromise & Foreign Body - ER Visit
www.mtsamples.com/site/pages/sample.asp?Type=93-Emergency Room Reports&Sample=1294-Altered Mental Status - ER Visit
www.mtsamples.com/site/pages/sample.asp?Type=93-Emergency Room Reports&Sample=1985-Angina - Consult
www.mtsamples.com/site/pages/sample.asp?Type=93-Emergency Room Reports&Sample=1257-Ankle pain
www.mtsamples.com/site/pages/sample.asp?Type=89-Discharge Summary&Sample=1254-Abscess with Cellulitis
www.mtsamples.com/site/pages/sample.asp?Type=89-Discharge Summary&Sample=2520-Anterior Cervical Discectomy & Fusion
www.mtsamples.com/site/pages/sample.asp?Type=89-Discharge Summary&Sample=1073-BRCA-2 mutation
www.mtsamples.com/site/pages/sample.asp?Type=89-Discharge Summary&Sample=1295-Bronchiolitis
www.mtsamples.com/site/pages/sample.asp?Type=89-Discharge Summary&Sample=2209-Cardiac Transfer Summary
www.mtsamples.com/site/pages/sample.asp?Type=89-Discharge Summary&Sample=646-Cardio/Pulmo
www.mtsamples.com/site/pages/sample.asp?Type=89-Discharge Summary&Sample=2617-Cellulitis
www.mtsamples.com/site/pages/sample.asp?Type=89-Discharge Summary&Sample=2486-Chest Pain & Respiratory Insufficiency
</cfif>



		<cfoutput>
			<cfhttp url="www.mtsamples.com/site/pages/sample.asp?Type=93-Emergency Room Reports&Sample=1921-Abdominal Pain - Consult" method="GET">
						
			</cfhttp> 
		</cfoutput>

		<cfset mypage = #cfhttp.FileContent#>

	<cfset StartPos = 1>		
	<cfset AllDone  = false>	
	<cfset i        = 0>
	<cfset outloop = 0>
	<cfset inloop = 0>
	<cfset myval1 = "">
	
	<cfset lookforbegin = '</H1>'>
	<cfset lookforend   = ':'>
	<cfset myval1       = ParseIt('#mypage#',#StartPos#,'#lookforbegin#','#lookforend#')>
	
	Back from call <p>
	
	<cfoutput>
	*****#myval1#<br>
	</cfoutput>		
	
	<cfset StartPos     = FindStringInPage('#lookforbegin#','#mypage#',#startpos#)>	
	
	<cfoutput>
	*****Startpos is #StartPos#<br>
	</cfoutput>		
	
	
	<p>
	
	Get here<p>
	
	
	
		
		
	<cfloop condition="alldone is false">
		<cfset outloop = outloop + 1>

					
					<cfset lookforbegin = '<B>'>
					<cfset lookforend   = '</B>'>
					
					<cfset BPos      = FindStringInPage('<B>','#mypage#',#startpos#)>				
					<cfset SlashBPos = FindStringInPage('</B>','#mypage#',#startpos#)>				
					<cfset BRPos     = FindStringInPage('<br>','#mypage#',#startpos#)>				
							
					<cfset myval1 = ParseIt('#mypage#',#StartPos#,'#lookforbegin#','#lookforend#')>
										
					
					<cfif myval1 gt ''>
							
						<cfoutput>
						#myval1#<br>
						</cfoutput>	
							
						<cfset lookforbegin = '</B>'>
						<cfset lookforend   = '<br>'>
					
						<cfset myval2 = ParseIt('#mypage#',#StartPos#,'#lookforbegin#','#lookforend#')>
					
							
						<cfoutput>
						#myval2#<br>
						</cfoutput>	
					
						<CFABORT>
					


					
						<cfset StartPos = FindStringInPage('#lookforend#','#mypage#',#startpos#)>		
							
						
						<cfset AllDone2  = false>
						<cfset Lastline = "">
						<cfloop condition="alldone2 is false">
							<cfset inloop = inloop + 1>			
										
							<cfset lookforbegin = '</B>'>
							<cfset lookforend   = '<br>'>
					
							<cfset myval2 = ParseIt('#mypage#',#StartPos#,'#lookforbegin#','#lookforend#')>
											
							<cfset StartPos = FindStringInPage('#lookforend#','#mypage#',#startpos#)>	
									
							<cfset StartPos = StartPos + 40>
									
							<cfoutput>
							**************#myval2#<br>
							</cfoutput>

							

							<cfif StartPos is 0>
								<cfset AllDone2 = true>
								<cfset LastLine = ''>
							<cfelse>
							
							
								<cfif 1 is 2>
								<cfif LastLine eq '#myval2#'>
									<cfset AllDone2 = true>
									<cfset LastLine = ''>
								<cfelse>
								
									<cfset LastLine = '#myval2#'>
								 </cfif>

								<cfif inloop gte 99999999920>
									
									<cfset AllDone2 = true>
									
								</cfif>
								</cfif>
								
								
							</cfif>	
						</cfloop>

					<cfelse>
						Get here!!!!.........<br>
						<cfset alldone = true>
					</cfif>
					
			<cfif outloop gte 15>
								
				<cfset AllDone = true>
								
			</cfif>		

	</cfloop>				


<cfcatch type="any">
	<cfoutput>
	'#cfcatch.Detail#'
	</cfoutput>
</cfcatch>
</cftry>		
		
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

		<cfif 1 is 2>
		<cfoutput>
		StartParsePos = #startparsepos#><br>
		EndParsePos   = #endparsepos#><br>
		LenOfParseVal = #LenOfParseVal#><br>
		parseVal=#trim(parseVal)#<br>
		</cfoutput>
		</cfif>
	
	
	</cfif>
	
	<cfreturn '#parseVal#'>

</cffunction>
	