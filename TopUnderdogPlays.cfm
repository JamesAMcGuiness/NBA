
<cftry>

<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>

<cfquery datasource="nba" name="GetUnderdogRating">
Select * from ImportantStatPreds i, finalpicks fp
Where 1 = 1
and fp.gametime = i.gametime
and fp.fav = i.fav

and i.gametime >= '20181115'
order by i.Gametime desc
</cfquery>
and i.gametime = '#gametime#'

<table width="70%" border="1">
<tr>
	  <td>Gametime</td>
	  <td>fav</td>	
	  <td>ha</td>		
	  <td>spd</td>	
  	  <td>Und</td>	
	  <td>Who Covered</td>	
	  <td>Overall Rating</td>
	  <td>Und Played Yest</td>	
	  <td>Und Health ADV</td>
  	  <td>undrat</td>
  	  <td>favTeamHealth</td>	
	  <td>UndTeamHealth</td>
       <td>Rating</td>		
	  						
	  </tr>
<cfset w = 0>	  
<cfset l = 0>
<cfoutput query="GetUnderdogRating">
      <cfset UndRat = 0>
      <cfset variables.Und = '#GetUnderdogRating.Und#'>
      
      <cfif FgpctAdv is '#variables.und#'>
            <cfset UndRat = UndRat + 2>
      </cfif>
      
      <cfif RebAdv is '#variables.und#'>
            <cfset UndRat = UndRat + 2>
      </cfif>

      <cfif PIPAdv is '#variables.und#'>
            <cfset UndRat = UndRat + 2>
      </cfif>
            
      <cfif TpmAdv is '#variables.und#'>
            <cfset UndRat = UndRat + 2>
      </cfif>
      
      <cfif FTMAdv is '#variables.und#'>
            <cfset UndRat = UndRat + 1>
      </cfif>

      <cfif ToAdv is '#variables.und#'>
            <cfset UndRat = UndRat + 1>
      </cfif>

      <cfif RebBig ge 50 and RebBig le 60 and RebAdv is '#variables.Und#'>
            <cfset UndRat = UndRat + 2>
      </cfif>

      <cfif RebBig gt 60 and RebAdv is '#variables.Und#'>
            <cfset UndRat = UndRat + 3>
      </cfif>

      <cfif FGPctBig ge 50 and FGPctBig le 60 and FGPCtAdv is '#variables.Und#'>
            <cfset UndRat = UndRat + 3>
      </cfif>

      <cfif FGPctBig gt 60 and FGPCtAdv is '#variables.Und#'>
            <cfset UndRat = UndRat + 4>
      </cfif>


      <cfif TOBig ge 50 and TOBig le 60 and TOAdv is '#variables.Und#'>
            <cfset UndRat = UndRat + 1>
      </cfif>

      <cfif ToBig gt 60 and ToAdv is '#variables.Und#'>
            <cfset UndRat = UndRat + 1.5>
      </cfif>


      <cfif FTMBig ge 50 and FTMBig le 60 and FTMAdv is '#variables.Und#'>
            <cfset UndRat = UndRat + 1.5>
      </cfif>

      <cfif FTMBig gt 60 and FTMAdv is '#variables.Und#'>
            <cfset UndRat = UndRat + 2>
      </cfif>


      <cfif TPMBig ge 50 and TPMBig le 60 and TPMAdv is '#variables.Und#'>
            <cfset UndRat = UndRat + 2>
      </cfif>

      <cfif TPMBig gt 60 and TPMAdv is '#variables.Und#'>
            <cfset UndRat = UndRat + 3>
      </cfif>
	
	<!--- 43-32 57%
	<cfif UndRat ge 10 and undplayedyest is 'N' and (Undhealth - favhealth gt -3)>
	---> 
	
	<!--- 39-25 61%
	<cfif UndRat ge 10 and undplayedyest is 'N' and (Undhealth - favhealth gt -3) and spd gt 1.5> 
	---> 
	
	<!--- 23-13 64% --->
	<!--- <cfif UndRat ge 10 and undplayedyest is 'N' and (Undhealth - favhealth gt -3) and spd gt 3.5 > --->
	 	
	<!--- 14-7 67% --->
	<!--- <cfif UndRat ge 10 and undplayedyest is 'N' and (Undhealth - favhealth gt -3) and (#UndRat# + #spd# gt 17) > --->

    <!--- 12-5 71% --->
	<!--- <cfif UndRat ge 10 and undplayedyest is 'N' and (Undhealth - favhealth gt -3) and (#UndRat# + #spd# gt 18) >  --->
	 
	<!--- 11-3 79% --->
	<!--- <cfif UndRat ge 10 and undplayedyest is 'N' and (Undhealth - favhealth gt -3) and (#UndRat# + #spd# gt 19) >  --->
	 
	
	<cfset Rating = 0>
	<cfset sysid = ''>
	<cfif UndRat ge 10 and undplayedyest is 'N' and (Undhealth - favhealth gt -3) and (#UndRat# + #spd# gt 19)>
		<cfset Rating = 6>
		<cfset sysid = 'SYS22'> 
	<cfelseif UndRat ge 10 and undplayedyest is 'N' and (Undhealth - favhealth gt -3) and (#UndRat# + #spd# gt 18)>
		<cfset Rating = 5> 
		<cfset sysid = 'SYS21'> 
	<cfelseif UndRat ge 10 and undplayedyest is 'N' and (Undhealth - favhealth gt -3) and (#UndRat# + #spd# gt 17) >
		<cfset Rating = 4>
		<cfset sysid = 'SYS19'> 
	<cfelseif UndRat ge 10 and undplayedyest is 'N' and (Undhealth - favhealth gt -3) and spd gt 3.5 >	
 		<cfset Rating = 3>
		<cfset sysid = 'SYS18'> 
	<cfelseif  UndRat ge 10 and undplayedyest is 'N' and (Undhealth - favhealth gt -3) and spd gt 1.5>
		 <cfset Rating = 2>
 		<cfset sysid = 'SYS28'> 
	<cfelseif UndRat ge 10 and undplayedyest is 'N' and (Undhealth - favhealth gt -3)>	
		 <cfset Rating = 1>
 		<cfset sysid = 'SYS27'> 
	</cfif>
		 		
	<cfif Rating neq 0>   

	  <cfset bgcolor = 'White'>
	  <cfif whocovered is '#und#'>
		  <cfset bgcolor = 'Green'>
		  <cfset w = w + 1>
	  <cfelse>
	  	<cfif len(whocovered) gt 1>
	  		<cfset L = L + 1>
	  	<cfelse>
	  		<cfset bgcolor = 'Yellow'>
	  	</cfif>
	  </cfif>
	  <tr bgcolor="#bgcolor#">
	  <td>#gametime#</td>	  
	  <td>#fav#</td>	
	  <td>#ha#</td>		
	  <td>#spd#</td>	
	  <td>#und#</td>	
	  <td>#whocovered#</td>	
	  <td>#UndRat + spd#</td>
	   <td>#UndPlayedYest#</td>	
	    <td>#UndHealth - favHealth#</td>
  	  <td>#undrat#</td>
  	  <td>#favHealth#</td>	
	  <td>#UndHealth#</td>
  	  <td>#Rating#</td>
	  </tr>
	  
	  <cfsavecontent variable="mysql">
	  Update FinalPicks
	  Set #SYSID#  = '#und#'
	  Where Und    = '#und#' 
	  and GameTime = '#gametime#'
	  </cfsavecontent>

 <cfquery datasource="NBA" name="AddPicks">
	#preservesinglequotes(mysql)#
</cfquery>
	  
	  
	  </cfif>
	  
	  
</cfoutput>
</tr>
</table>
<cfoutput>
Wins: #w#<br>
Losses: #l#
</cfoutput>


<cfquery datasource="Nba" name="UPDATE">
	Insert into NBADataLoadStatus
	(
	ProgramName
	)
	values
	(
	'Did TopUnderDogPlays.cfm'
	)
</cfquery>


<cfinclude template="TopUnderdogPlaysLast7Health.cfm">

<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:TopUnderdogPlays.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>


