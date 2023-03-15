<cfset myUserCFC = createObject("component", "PSP2012.NFL.FORMS.User") />
<cfset myPBPCFC = createObject("component", "NBAPBP") />

<cfquery datasource="nba" name="GetDay">
Select Gametime 
from NBAGametime
</cfquery>

<cfset theday = GetDay.Gametime> 
 
<cfset theday = '20160104'> 


<cfquery name="Games" datasource="nba">
Select distinct n.* 
from NbaSchedule n
where n.Gametime = '#theDay#'
</cfquery>

<cfoutput query="Games">


	<cfset fav='#Games.fav#'>
	<cfset und='#Games.und#'>
	<cfset ha = '#Games.ha#'>

	<cfset dum = myPBPCFC.createPaceAndEfficiency('#theday#','#fav#','#und#','#ha#')>

	
</cfoutput>

<cfset Session.Gametime = '#theday#'>
<cfinclude template="LastSevenHealth2016.cfm">

