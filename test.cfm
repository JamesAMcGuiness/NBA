

<cfset myurl ='http://www.donbest.com/nba/odds/'>

<cfoutput>
#myurl#
</cfoutput>


<cfoutput>
	#myurl#<br>	
	<cfhttp url="#myurl#" method="GET" resolveurl="false">
	</cfhttp>
	</cfoutput>



<cfset thepage = '#cfhttp.filecontent#'>

<cfoutput>#thepage#</cfoutput>