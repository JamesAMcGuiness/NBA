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
and i.gametime = '#gametime#'
order by i.Gametime desc
</cfquery>


<table width="70%" border="1">
<tr>
	  <td>Gametime</td>
	  <td>fav</td>	
	  <td>ha</td>		
	  <td>spd</td>	
  	  <td>Und</td>	
	  <td>Who Covered</td>	
	  <td>Overall Rating</td>
	  <td>Fav Played Yest</td>	
	  <td>Fav Health ADV</td>
  	  <td>Favrat</td>
  	  <td>favTeamHealth</td>	
	  <td>UndTeamHealth</td>
      		
	  						
	  </tr>
<cfset w = 0>	  
<cfset l = 0>
<cfoutput query="GetUnderdogRating">
      <cfset UndRat = 0>
      <cfset variables.Und = '#GetUnderdogRating.Fav#'>
      
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
	 
    <!--- 20-12 63% --->
	<!--- <cfif UndRat ge 10 and undplayedyest is 'N' and (Undhealth - favhealth gt -3) and (#UndRat# + #spd# gt 18) > --->
	<cfif UndRat ge 17 and favplayedyest is 'N' and (favhealth - undhealth ge -2) and spd lt 15>  
	
  <cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
	Set SYS14    = '#fav#'
	Where Fav    = '#fav#' 
	and GameTime = '#gametime#'
	</cfquery>

	
	  <cfset bgcolor = 'White'>
	  <cfif whocovered is '#fav#'>
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
	  <td>#UndRat - spd#</td>
	   <td>#FavPlayedYest#</td>	
	    <td>#favHealth - UndHealth#</td>
  	  <td>#undrat#</td>
  	  <td>#favHealth#</td>	
	  <td>#UndHealth#</td>
	  </tr>
	  </cfif>
	  
	  
</cfoutput>
</tr>
</table>
<cfoutput>
Wins: #w#<br>
Losses: #l#
</cfoutput>


<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:TopFavoritePlays.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>


