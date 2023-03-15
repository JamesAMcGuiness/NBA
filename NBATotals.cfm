<cfinclude template="CreateAvgs.cfm">

<cfquery datasource="nba" name="getinfo">
Select * from finalpicks fp
where gametime in (select gametime from nbagametime)
</cfquery>

<cfset ovct = 0>
<cfoutput query="getinfo">


	<cfquery datasource="nba" name="getfav">
	Select * from NBAPcts
	where team = '#Getinfo.fav#'
	</cfquery>

	<cfquery datasource="nba" name="getund">
	Select * from NBAPcts
	where team = '#Getinfo.und#'
	</cfquery>


	<cfif getFav.Ofgpct gte 60>
		<cfset ovct = ovct + 1>
	</cfif>
	
	<cfif getFav.Dfgpct lte 40>
		<cfset ovct = ovct + 1>
	</cfif>

	<cfif getFav.oTPA gte 60>
		<cfset ovct = ovct + 1>
	</cfif>

	<cfif getFav.oTPPCT gte 60>
		<cfset ovct = ovct + 1>
	</cfif>

	<cfif getFav.dTPA lte 40>
		<cfset ovct = ovct + 1>
	</cfif>

	<cfif getFav.dTPpct lte 40>
		<cfset ovct = ovct + 1>
	</cfif>

	<cfif getFav.ofta gte 60>
		<cfset ovct = ovct + 1>
	</cfif>
	
	<cfif getFav.dfta lte 40>
		<cfset ovct = ovct + 1>
	</cfif>




	<cfif getUnd.Ofgpct gte 60>
		<cfset ovct = ovct + 1>
	</cfif>
	
	<cfif getUnd.Dfgpct lte 40>
		<cfset ovct = ovct + 1>
	</cfif>

	<cfif getUnd.oTPA gte 60>
		<cfset ovct = ovct + 1>
	</cfif>

	<cfif getUnd.oTPPCT gte 60>
		<cfset ovct = ovct + 1>
	</cfif>

	<cfif getUnd.dTPA lte 40>
		<cfset ovct = ovct + 1>
	</cfif>

	<cfif getUnd.dTPpct lte 40>
		<cfset ovct = ovct + 1>
	</cfif>

	<cfif getUnd.ofta gte 60>
		<cfset ovct = ovct + 1>
	</cfif>
	
	<cfif getUnd.dfta lte 40>
		<cfset ovct = ovct + 1>
	</cfif>

	Total OVER Rating For #Getinfo.fav#/#GetInfo.Und# is #ovct# out of 16<br>
	<cfif ovct lte 3>

		<!--- Favors an under performance of stats for the teams playing... --->
		<cfquery datasource="nba" name="SYS54">
		UPDATE FinalPicks
		Set SYS54 = 'UNDER'
		where Und = '#Getinfo.und#'
		and gametime = '#Getinfo.gametime#'
		</cfquery>

	</cfif>

	<cfset ovct = 0>

</cfoutput>










<hr>

















<cfset undct = 0>
<cfoutput query="getinfo">


	<cfquery datasource="nba" name="getfav">
	Select * from NBAPcts
	where team = '#Getinfo.fav#'
	</cfquery>

	<cfquery datasource="nba" name="getund">
	Select * from NBAPcts
	where team = '#Getinfo.und#'
	</cfquery>


	<cfif getFav.Ofgpct lte 40>
		<cfset undct = undct + 1>
	</cfif>
	
	<cfif getFav.Dfgpct gte 60>
		<cfset undct = undct + 1>
	</cfif>

	<cfif getFav.oTPA lte 40>
		<cfset undct = undct + 1>
	</cfif>

	<cfif getFav.oTPPCT lte 40>
		<cfset undct = undct + 1>
	</cfif>

	<cfif getFav.dTPA gte 60>
		<cfset undct = undct + 1>
	</cfif>

	<cfif getFav.dTPpct gte 60>
		<cfset undct = undct + 1>
	</cfif>

	<cfif getFav.ofta lte 40>
		<cfset undct = undct + 1>
	</cfif>
	
	<cfif getFav.dfta gte 60>
		<cfset undct = undct + 1>
	</cfif>


	<cfif getUnd.Ofgpct lte 40>
		<cfset undct = undct + 1>
	</cfif>
	
	<cfif getUnd.Dfgpct gte 60>
		<cfset undct = undct + 1>
	</cfif>

	<cfif getUnd.oTPA lte 40>
		<cfset undct = undct + 1>
	</cfif>

	<cfif getUnd.oTPPCT lte 40>
		<cfset undct = undct + 1>
	</cfif>

	<cfif getUnd.dTPA gte 60>
		<cfset undct = undct + 1>
	</cfif>

	<cfif getUnd.dTPpct gte 60>
		<cfset undct = undct + 1>
	</cfif>

	<cfif getUnd.ofta lte 40>
		<cfset undct = undct + 1>
	</cfif>
	
	<cfif getUnd.dfta gte 60>
		<cfset undct = undct + 1>
	</cfif>


	Total UNDER Rating For #Getinfo.fav#/#GetInfo.Und# is #undct# out of 16<br>
	<cfset undct = 0>

</cfoutput>








