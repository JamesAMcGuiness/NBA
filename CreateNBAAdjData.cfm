<cfquery datasource="nba" name="GetBetterThanAvg">
Delete from NBAAdjData
</cfquery>


<cfquery datasource="NBA" name="GetDay">
Select * 
from Nbagametime
</cfquery>

<cfquery datasource="nba" name="Getspds">
Select *
from nbaschedule
where gametime = '#GetDay.Gametime#'
 </cfquery>

<cfquery datasource="nba" name="GetBetterThanAvg">
Select * from BetterThanAvg
</cfquery>

<cfquery datasource="nba" name="GetTeams">
Select Distinct Team from nbadata
</cfquery>

<cfloop query="GetTeams">

	<!--- Get all the data for a Team --->
	<cfquery datasource="nba" name="GetTeamData">
	Select * from Nbadata where team = '#GetTeams.Team#'
	</cfquery>
	
	
	<cfoutput query="GetTeamData">
	
		<cfset mygametime = '#gametime#'>
		<cfset myteam     = '#team#'>
		<cfset myha       = '#ha#' >
		<cfset myopp      = '#opp#'>
	
		<!--- Get the opponents BetterThanAvg data --->
		<cfquery dbtype="query" name="GetOppBTA">
		Select * from GetBetterThanAvg where Team = '#GetTeamData.opp#'
		</cfquery>

		<cfset adj_PS     = GetTeamData.PS  + ((GetOppBTA.dPS/100) * GetTeamData.PS)>
		<cfset adj_dPS    = GetTeamData.dPS - ((GetOppBTA.oPS/100) * GetTeamData.dPS)>
		
		<cfset adj_FGPCT  = GetTeamData.oFGPCT  + ((GetOppBTA.dFGPCT/100) * GetTeamData.oFGPCT)>
		<cfset adj_dFGPCT = GetTeamData.dFGPCT - ((GetOppBTA.ofgpct/100) * GetTeamData.dfgpct)>
		
		<cfset adj_oFGa   = GetTeamData.oFGA  + ((GetOppBTA.dFGA/100) * GetTeamData.oFGA)>
		<cfset adj_dFGa   = GetTeamData.dFGA - ((GetOppBTA.ofga/100) * GetTeamData.dfga)>

		<cfset adj_oFGm   = GetTeamData.oFGM  + ((GetOppBTA.dFGM/100) * GetTeamData.oFGM)>
		<cfset adj_dFGm   = GetTeamData.dFGM - ((GetOppBTA.ofgm/100) * GetTeamData.dfgm)>

		<cfset adj_oFTm   = GetTeamData.oFTM  + ((GetOppBTA.dFTM/100) * GetTeamData.oFTM)>
		<cfset adj_dFTm   = GetTeamData.dFTM - ((GetOppBTA.oftm/100) * GetTeamData.dftm)>

		<cfset adj_oReb   = GetTeamData.oTReb  + ((GetOppBTA.dReb/100) * GetTeamData.oTReb)>
		<cfset adj_dReb   = GetTeamData.dTReb - ((GetOppBTA.oReb/100) * GetTeamData.dTReb)>

		<cfset adj_oTpm   = GetTeamData.oTpm  + ((GetOppBTA.dTpm/100) * GetTeamData.oTpm)>
		<cfset adj_dTpm   = GetTeamData.dTpm - ((GetOppBTA.oTpm/100) * GetTeamData.dTpm)>


		<cfquery datasource="nba" name="addit">
		insert into NBAADJDATA(gametime,team,ha,opp,ps,dps,ofga,dfga,ofgpct,dfgpct,otreb,dtreb,oftm,dftm,otpm,dtpm)
		values('#mygametime#','#myteam#','#myha#','#myopp#',#adj_ps#,#adj_dps#,#adj_ofga#,#adj_dfga#,#adj_fgpct#,#adj_dfgpct#,#adj_oreb#,#adj_dreb#,#adj_oftm#,#adj_dftm#,#adj_otpm#,#adj_dtpm#)
		</cfquery>

	</cfoutput>

</cfloop>
