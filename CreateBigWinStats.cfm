<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset mygametime = GetRunct.GameTime>


<cfquery datasource="nba" name="GetTeams">
Delete from PreGameProb
where gametime='#mygametime#'
</cfquery>


<cfquery datasource="nba" name="GetTeams">
Delete from BigWinStatsOff
</cfquery>

<cfquery datasource="nba" name="GetTeams">
Delete from BigWinStatsDef
</cfquery>



<cfquery datasource="nba" name="GetTeams">
Select Distinct team 
from gap
</cfquery>

<cfoutput query="GetTeams">

<cfquery datasource="nba" name="Getit">
	Select * from Power where Team = '#GetTeams.Team#'
	and ha = 'H'
	and gametime < '#mygametime#'
</cfquery>

<cfset fgzeroto3  = 0>
<cfset fgFourto6  = 0>
<cfset fgSevento9 = 0>
<cfset fgTento12  = 0>
<cfset fgThirteento15 = 0>
<cfset fgGreater16 = 0>

<cfset rbzeroto3  = 0>
<cfset rbFourto6  = 0>
<cfset rbSevento9 = 0>
<cfset rbTento12  = 0>
<cfset rbThirteento15 = 0>
<cfset rbGreater16 = 0>

<cfset fgazeroto3  = 0>
<cfset fgaFourto6  = 0>
<cfset fgaSevento9 = 0>
<cfset fgaTento12  = 0>
<cfset fgaThirteento15 = 0>
<cfset fgaGreater16 = 0>

<cfset tpmzeroto3  = 0>
<cfset tpmFourto6  = 0>
<cfset tpmSevento9 = 0>
<cfset tpmTento12  = 0>
<cfset tpmThirteento15 = 0>
<cfset tpmGreater16 = 0>

<cfset ftmzeroto3  = 0>
<cfset ftmFourto6  = 0>
<cfset ftmSevento9 = 0>
<cfset ftmTento12  = 0>
<cfset ftmThirteento15 = 0>
<cfset ftmGreater16 = 0>

<cfset tozeroto3  = 0>
<cfset toFourto6  = 0>
<cfset toSevento9 = 0>
<cfset toTento12  = 0>
<cfset toThirteento15 = 0>
<cfset toGreater16 = 0>




<cfset fgnegzeroto3  = 0>
<cfset fgnegFourto6  = 0>
<cfset fgnegSevento9 = 0>
<cfset fgnegTento12  = 0>
<cfset fgnegThirteento15 = 0>
<cfset fgnegGreater16 = 0>

<cfset rbnegzeroto3  = 0>
<cfset rbnegFourto6  = 0>
<cfset rbnegSevento9 = 0>
<cfset rbnegTento12  = 0>
<cfset rbnegThirteento15 = 0>
<cfset rbnegGreater16 = 0>

<cfset fganegzeroto3  = 0>
<cfset fganegFourto6  = 0>
<cfset fganegSevento9 = 0>
<cfset fganegTento12  = 0>
<cfset fganegThirteento15 = 0>
<cfset fganegGreater16 = 0>

<cfset tpmnegzeroto3  = 0>
<cfset tpmnegFourto6  = 0>
<cfset tpmnegSevento9 = 0>
<cfset tpmnegTento12  = 0>
<cfset tpmnegThirteento15 = 0>
<cfset tpmnegGreater16 = 0>

<cfset ftmnegzeroto3  = 0>
<cfset ftmnegFourto6  = 0>
<cfset ftmnegSevento9 = 0>
<cfset ftmnegTento12  = 0>
<cfset ftmnegThirteento15 = 0>
<cfset ftmnegGreater16 = 0>

<cfset tonegzeroto3  = 0>
<cfset tonegFourto6  = 0>
<cfset tonegSevento9 = 0>
<cfset tonegTento12  = 0>
<cfset tonegThirteento15 = 0>
<cfset tonegGreater16 = 0>
<cfset FavOffUse = 0>
<cfset UndOffUse = 0>

<cfloop query="GetIt">

	<cfif Getit.ofgpct ge 0 and Getit.ofgpct le 3>
		<cfset fgzeroto3 = fgzeroto3 + 1>
	<cfelseif Getit.ofgpct ge 4 and Getit.ofgpct le 6>
		<cfset fgFourto6 = fgFourto6 + 1>
	<cfelseif Getit.ofgpct ge 7 and Getit.ofgpct le 9>
		<cfset fgSevento9 = fgSevento9 + 1>
	<cfelseif Getit.ofgpct ge 10 and Getit.ofgpct le 12>
		<cfset fgTento12 = fgTento12 + 1>
	<cfelseif Getit.ofgpct ge 13 and Getit.ofgpct le 15>
		<cfset fgThirteento15 = fgThirteento15 + 1>
	<cfelseif Getit.ofgpct ge 16>	
		<cfset fgGreater16 = fgGreater16 + 1>
	</cfif>	

	<cfif Getit.ofgpct ge -3 and Getit.ofgpct lt 0>
		<cfset fgnegzeroto3 = fgnegzeroto3 + 1>
	<cfelseif Getit.ofgpct ge -6 and Getit.ofgpct le -4>
		<cfset fgnegFourto6 = fgnegFourto6 + 1>
	<cfelseif Getit.ofgpct ge -9 and Getit.ofgpct le -7>
		<cfset fgnegSevento9 = fgnegSevento9 + 1>
	<cfelseif Getit.ofgpct ge -12 and Getit.ofgpct le -10>
		<cfset fgnegTento12 = fgnegTento12 + 1>
	<cfelseif Getit.ofgpct ge -15 and Getit.ofgpct le -13>
		<cfset fgnegThirteento15 = fgnegThirteento15 + 1>
	<cfelseif Getit.ofgpct le -16>	
		<cfset fgnegGreater16 = fgnegGreater16 + 1>
	</cfif>	




	<cfif Getit.offreb ge 0 and Getit.offreb le 3>
		<cfset rbzeroto3 = rbzeroto3 + 1>
	<cfelseif Getit.offreb ge 4 and Getit.offreb le 6>
		<cfset rbFourto6 = rbFourto6 + 1>
	<cfelseif Getit.offreb ge 7 and Getit.offreb le 9>
		<cfset rbSevento9 = rbSevento9 + 1>
	<cfelseif Getit.offreb ge 10 and Getit.offreb le 12>
		<cfset rbTento12 = rbTento12 + 1>
	<cfelseif Getit.offreb ge 13 and Getit.offreb le 15>
		<cfset rbThirteento15 = rbThirteento15 + 1>
	<cfelseif Getit.offreb ge 16>	
		<cfset rbGreater16 = rbGreater16 + 1>
	</cfif>	

	<cfif Getit.offreb ge -3 and Getit.offreb lt 0>
		<cfset rbnegzeroto3 = rbnegzeroto3 + 1>
	<cfelseif Getit.offreb ge -6 and Getit.offreb le -4>
		<cfset rbnegFourto6 = rbnegFourto6 + 1>
	<cfelseif Getit.offreb ge -9 and Getit.offreb le -7>
		<cfset rbnegSevento9 = rbnegSevento9 + 1>
	<cfelseif Getit.offreb ge -12 and Getit.offreb le -10>
		<cfset rbnegTento12 = rbnegTento12 + 1>
	<cfelseif Getit.offreb ge -15 and Getit.offreb le -13>
		<cfset rbnegThirteento15 = rbnegThirteento15 + 1>
	<cfelseif Getit.offreb le -16>	
		<cfset rbnegGreater16 = rbnegGreater16 + 1>
	</cfif>	


	
	<cfif Getit.ofga ge 0 and Getit.ofga le 3>
		<cfset fgazeroto3 = fgazeroto3 + 1>
	<cfelseif Getit.ofga ge 4 and Getit.ofga le 6>
		<cfset fgaFourto6 = fgaFourto6 + 1>
	<cfelseif Getit.ofga ge 7 and Getit.ofga le 9>
		<cfset fgaSevento9 = fgaSevento9 + 1>
	<cfelseif Getit.ofga ge 10 and Getit.ofga le 12>
		<cfset fgaTento12 = fgaTento12 + 1>
	<cfelseif Getit.ofga ge 13 and Getit.ofga le 15>
		<cfset fgaThirteento15 = fgaThirteento15 + 1>
	<cfelseif Getit.ofga ge 16>	
		<cfset fgaGreater16 = fgaGreater16 + 1>
	</cfif>	

	<cfif Getit.ofga ge -3 and Getit.ofga lt 0>
		<cfset fganegzeroto3 = fganegzeroto3 + 1>
	<cfelseif Getit.ofga ge -6 and Getit.ofga le -4>
		<cfset fganegFourto6 = fganegFourto6 + 1>
	<cfelseif Getit.ofga ge -9 and Getit.ofga le -7>
		<cfset fganegSevento9 = fganegSevento9 + 1>
	<cfelseif Getit.ofga ge -12 and Getit.ofga le -10>
		<cfset fganegTento12 = fganegTento12 + 1>
	<cfelseif Getit.ofga ge -15 and Getit.ofga le -13>
		<cfset fganegThirteento15 = fganegThirteento15 + 1>
	<cfelseif Getit.ofga le -16>	
		<cfset fganegGreater16 = fganegGreater16 + 1>
	</cfif>	



	<cfif Getit.otpm ge 0 and Getit.otpm le 3>
		<cfset tpmzeroto3 = tpmzeroto3 + 1>
	<cfelseif Getit.otpm ge 4 and Getit.otpm le 6>
		<cfset tpmFourto6 = tpmFourto6 + 1>
	<cfelseif Getit.otpm ge 7 and Getit.otpm le 9>
		<cfset tpmSevento9 = tpmSevento9 + 1>
	<cfelseif Getit.otpm ge 10 and Getit.otpm le 12>
		<cfset tpmTento12 = tpmTento12 + 1>
	<cfelseif Getit.otpm ge 13 and Getit.otpm le 15>
		<cfset tpmThirteento15 = tpmThirteento15 + 1>
	<cfelseif Getit.otpm ge 16>	
		<cfset tpmGreater16 = tpmGreater16 + 1>
	</cfif>	

	<cfif Getit.otpm ge -3 and Getit.otpm lt 0>
		<cfset tpmnegzeroto3 = tpmnegzeroto3 + 1>
	<cfelseif Getit.otpm ge -6 and Getit.otpm le -4>
		<cfset tpmnegFourto6 = tpmnegFourto6 + 1>
	<cfelseif Getit.otpm ge -9 and Getit.otpm le -7>
		<cfset tpmnegSevento9 = tpmnegSevento9 + 1>
	<cfelseif Getit.otpm ge -12 and Getit.otpm le -10>
		<cfset tpmnegTento12 = tpmnegTento12 + 1>
	<cfelseif Getit.otpm ge -15 and Getit.otpm le -13>
		<cfset tpmnegThirteento15 = tpmnegThirteento15 + 1>
	<cfelseif Getit.otpm le -16>	
		<cfset tpmnegGreater16 = tpmnegGreater16 + 1>
	</cfif>	
	
	

	<cfif Getit.oftm ge 0 and Getit.oftm le 3>
		<cfset ftmzeroto3 = ftmzeroto3 + 1>
	<cfelseif Getit.oftm ge 4 and Getit.oftm le 6>
		<cfset ftmFourto6 = ftmFourto6 + 1>
	<cfelseif Getit.oftm ge 7 and Getit.oftm le 9>
		<cfset ftmSevento9 = ftmSevento9 + 1>
	<cfelseif Getit.oftm ge 10 and Getit.oftm le 12>
		<cfset ftmTento12 = ftmTento12 + 1>
	<cfelseif Getit.oftm ge 13 and Getit.oftm le 15>
		<cfset ftmThirteento15 = ftmThirteento15 + 1>
	<cfelseif Getit.oftm ge 16>	
		<cfset ftmGreater16 = ftmGreater16 + 1>
	</cfif>	

	<cfif Getit.oftm ge -3 and Getit.oftm lt 0>
		<cfset ftmnegzeroto3 = ftmnegzeroto3 + 1>
	<cfelseif Getit.oftm ge -6 and Getit.oftm le -4>
		<cfset ftmnegFourto6 = ftmnegFourto6 + 1>
	<cfelseif Getit.oftm ge -9 and Getit.oftm le -7>
		<cfset ftmnegSevento9 = ftmnegSevento9 + 1>
	<cfelseif Getit.oftm ge -12 and Getit.oftm le -10>
		<cfset ftmnegTento12 = ftmnegTento12 + 1>
	<cfelseif Getit.oftm ge -15 and Getit.oftm le -13>
		<cfset ftmnegThirteento15 = ftmnegThirteento15 + 1>
	<cfelseif Getit.oftm le -16>	
		<cfset ftmnegGreater16 = ftmnegGreater16 + 1>
	</cfif>	
	
	
	<cfif Getit.oturnovers ge 0 and Getit.oturnovers le 3>
		<cfset tozeroto3 = tozeroto3 + 1>
	<cfelseif Getit.oturnovers ge 4 and Getit.oturnovers le 6>
		<cfset toFourto6 = toFourto6 + 1>
	<cfelseif Getit.oturnovers ge 7 and Getit.oturnovers le 9>
		<cfset toSevento9 = toSevento9 + 1>
	<cfelseif Getit.oturnovers ge 10 and Getit.oturnovers le 12>
		<cfset toTento12 = toTento12 + 1>
	<cfelseif Getit.oturnovers ge 13 and Getit.oturnovers le 15>
		<cfset toThirteento15 = toThirteento15 + 1>
	<cfelseif Getit.oturnovers ge 16>	
		<cfset toGreater16 = toGreater16 + 1>
	</cfif>	

	<cfif Getit.oturnovers ge -3 and Getit.oturnovers lt 0>
		<cfset tonegzeroto3 = tonegzeroto3 + 1>
	<cfelseif Getit.oturnovers ge -6 and Getit.oturnovers le -4>
		<cfset tonegFourto6 = tonegFourto6 + 1>
	<cfelseif Getit.oturnovers ge -9 and Getit.oturnovers le -7>
		<cfset tonegSevento9 = tonegSevento9 + 1>
	<cfelseif Getit.oturnovers ge -12 and Getit.oturnovers le -10>
		<cfset tonegTento12 = tonegTento12 + 1>
	<cfelseif Getit.oturnovers ge -15 and Getit.oturnovers le -13>
		<cfset tonegThirteento15 = tonegThirteento15 + 1>
	<cfelseif Getit.oturnovers le -16>	
		<cfset tonegGreater16 = tonegGreater16 + 1>
	</cfif>	
</cfloop>

<cfset TotalGames = GetIt.recordcount>

<cfif TotalGames neq 0>
<cfquery datasource="nba" name="addit">
Insert into BigWinStatsOff
(Team,
HA,
FG03,
FG46,
FG79,
FG1012,
FG1315,
FG16plus,
negFG03,
negFG46,
negFG79,
negFG1012,
negFG1315,
negFG16plus,
FGA03,
FGA46,
FGA79,
FGA1012,
FGA1315,
FGA16plus,
negFGA03,
negFGA46,
negFGA79,
negFGA1012,
negFGA1315,
negFGA16plus,
RB03,
RB46,
RB79,
RB1012,
RB1315,
RB16plus,
negRB03,
negRB46,
negRB79,
negRB1012,
negRB1315,
negRB16plus,
TPM03,
TPM46,
TPM79,
TPM1012,
TPM1315,
TPM16plus,
negTPM03,
negTPM46,
negTPM79,
negTPM1012,
negTPM1315,
negTPM16plus,
TO03,
TO46,
TO79,
TO1012,
TO1315,
TO16plus,
negTO03,
negTO46,
negTO79,
negTO1012,
negTO1315,
negTO16plus,
ftm03,
ftm46,
ftm79,
ftm1012,
ftm1315,
ftm16plus,
negftm03,
negftm46,
negftm79,
negftm1012,
negftm1315,
negftm16plus

)
values
(
'#GetTeams.Team#',
'H',
#(fgzeroto3/totalgames)*100#,
#(fgFourto6/totalgames)*100#,
#(fgSevento9/totalgames)*100#,
#(fgTento12/totalgames)*100#,
#(fgThirteento15/totalgames)*100#,
#(fgGreater16/totalgames)*100#,
#(fgnegzeroto3/totalgames)*100#,
#(fgnegFourto6/totalgames)*100#,
#(fgnegSevento9/totalgames)*100#,
#(fgnegTento12/totalgames)*100#,
#(fgnegThirteento15/totalgames)*100#,
#(fgnegGreater16/totalgames)*100#,
#(fgazeroto3/totalgames)*100#,
#(fgaFourto6/totalgames)*100#,
#(fgaSevento9/totalgames)*100#,
#(fgaTento12/totalgames)*100#,
#(fgaThirteento15/totalgames)*100#,
#(fgaGreater16/totalgames)*100#,
#(fganegzeroto3/totalgames)*100#,
#(fganegFourto6/totalgames)*100#,
#(fganegSevento9/totalgames)*100#,
#(fganegTento12/totalgames)*100#,
#(fganegThirteento15/totalgames)*100#,
#(fganegGreater16/totalgames)*100#,
#(rbzeroto3/totalgames)*100#,
#(rbFourto6/totalgames)*100#,
#(rbSevento9/totalgames)*100#,
#(rbTento12/totalgames)*100#,
#(rbThirteento15/totalgames)*100#,
#(rbGreater16/totalgames)*100#,
#(rbnegzeroto3/totalgames)*100#,
#(rbnegFourto6/totalgames)*100#,
#(rbnegSevento9/totalgames)*100#,
#(rbnegTento12/totalgames)*100#,
#(rbnegThirteento15/totalgames)*100#,
#(rbnegGreater16/totalgames)*100#,
#(tpmzeroto3/totalgames)*100#,
#(tpmFourto6/totalgames)*100#,
#(tpmSevento9/totalgames)*100#,
#(tpmTento12/totalgames)*100#,
#(tpmThirteento15/totalgames)*100#,
#(tpmGreater16/totalgames)*100#,
#(tpmnegzeroto3/totalgames)*100#,
#(tpmnegFourto6/totalgames)*100#,
#(tpmnegSevento9/totalgames)*100#,
#(tpmnegTento12/totalgames)*100#,
#(tpmnegThirteento15/totalgames)*100#,
#(tpmnegGreater16/totalgames)*100#,
#(tozeroto3/totalgames)*100#,
#(toFourto6/totalgames)*100#,
#(toSevento9/totalgames)*100#,
#(toTento12/totalgames)*100#,
#(toThirteento15/totalgames)*100#,
#(toGreater16/totalgames)*100#,
#(tonegzeroto3/totalgames)*100#,
#(tonegFourto6/totalgames)*100#,
#(tonegSevento9/totalgames)*100#,
#(tonegTento12/totalgames)*100#,
#(tonegThirteento15/totalgames)*100#,
#(tonegGreater16/totalgames)*100#,
#(ftmzeroto3/totalgames)*100#,
#(ftmFourto6/totalgames)*100#,
#(ftmSevento9/totalgames)*100#,
#(ftmTento12/totalgames)*100#,
#(ftmThirteento15/totalgames)*100#,
#(ftmGreater16/totalgames)*100#,
#(ftmnegzeroto3/totalgames)*100#,
#(ftmnegFourto6/totalgames)*100#,
#(ftmnegSevento9/totalgames)*100#,
#(ftmnegTento12/totalgames)*100#,
#(ftmnegThirteento15/totalgames)*100#,
#(ftmnegGreater16/totalgames)*100#
)
</cfquery>
<cfelse>
No data found for #GetTeams.Team#
</cfif>



</cfoutput>

















<cfquery datasource="nba" name="GetTeams">
Select Distinct team 
from gap
</cfquery>

<cfoutput query="GetTeams">

<cfquery datasource="nba" name="Getit">
	Select * from Power where Team = '#GetTeams.Team#'
	and ha = 'A'
	and gametime < '#mygametime#'
</cfquery>

<cfset fgzeroto3  = 0>
<cfset fgFourto6  = 0>
<cfset fgSevento9 = 0>
<cfset fgTento12  = 0>
<cfset fgThirteento15 = 0>
<cfset fgGreater16 = 0>

<cfset rbzeroto3  = 0>
<cfset rbFourto6  = 0>
<cfset rbSevento9 = 0>
<cfset rbTento12  = 0>
<cfset rbThirteento15 = 0>
<cfset rbGreater16 = 0>

<cfset fgazeroto3  = 0>
<cfset fgaFourto6  = 0>
<cfset fgaSevento9 = 0>
<cfset fgaTento12  = 0>
<cfset fgaThirteento15 = 0>
<cfset fgaGreater16 = 0>

<cfset tpmzeroto3  = 0>
<cfset tpmFourto6  = 0>
<cfset tpmSevento9 = 0>
<cfset tpmTento12  = 0>
<cfset tpmThirteento15 = 0>
<cfset tpmGreater16 = 0>

<cfset ftmzeroto3  = 0>
<cfset ftmFourto6  = 0>
<cfset ftmSevento9 = 0>
<cfset ftmTento12  = 0>
<cfset ftmThirteento15 = 0>
<cfset ftmGreater16 = 0>

<cfset tozeroto3  = 0>
<cfset toFourto6  = 0>
<cfset toSevento9 = 0>
<cfset toTento12  = 0>
<cfset toThirteento15 = 0>
<cfset toGreater16 = 0>




<cfset fgnegzeroto3  = 0>
<cfset fgnegFourto6  = 0>
<cfset fgnegSevento9 = 0>
<cfset fgnegTento12  = 0>
<cfset fgnegThirteento15 = 0>
<cfset fgnegGreater16 = 0>

<cfset rbnegzeroto3  = 0>
<cfset rbnegFourto6  = 0>
<cfset rbnegSevento9 = 0>
<cfset rbnegTento12  = 0>
<cfset rbnegThirteento15 = 0>
<cfset rbnegGreater16 = 0>

<cfset fganegzeroto3  = 0>
<cfset fganegFourto6  = 0>
<cfset fganegSevento9 = 0>
<cfset fganegTento12  = 0>
<cfset fganegThirteento15 = 0>
<cfset fganegGreater16 = 0>

<cfset tpmnegzeroto3  = 0>
<cfset tpmnegFourto6  = 0>
<cfset tpmnegSevento9 = 0>
<cfset tpmnegTento12  = 0>
<cfset tpmnegThirteento15 = 0>
<cfset tpmnegGreater16 = 0>

<cfset ftmnegzeroto3  = 0>
<cfset ftmnegFourto6  = 0>
<cfset ftmnegSevento9 = 0>
<cfset ftmnegTento12  = 0>
<cfset ftmnegThirteento15 = 0>
<cfset ftmnegGreater16 = 0>

<cfset tonegzeroto3  = 0>
<cfset tonegFourto6  = 0>
<cfset tonegSevento9 = 0>
<cfset tonegTento12  = 0>
<cfset tonegThirteento15 = 0>
<cfset tonegGreater16 = 0>


<cfloop query="GetIt">

	<cfif Getit.ofgpct ge 0 and Getit.ofgpct le 3>
		<cfset fgzeroto3 = fgzeroto3 + 1>
	<cfelseif Getit.ofgpct ge 4 and Getit.ofgpct le 6>
		<cfset fgFourto6 = fgFourto6 + 1>
	<cfelseif Getit.ofgpct ge 7 and Getit.ofgpct le 9>
		<cfset fgSevento9 = fgSevento9 + 1>
	<cfelseif Getit.ofgpct ge 10 and Getit.ofgpct le 12>
		<cfset fgTento12 = fgTento12 + 1>
	<cfelseif Getit.ofgpct ge 13 and Getit.ofgpct le 15>
		<cfset fgThirteento15 = fgThirteento15 + 1>
	<cfelseif Getit.ofgpct ge 16>	
		<cfset fgGreater16 = fgGreater16 + 1>
	</cfif>	

	<cfif Getit.ofgpct ge -3 and Getit.ofgpct lt 0>
		<cfset fgnegzeroto3 = fgnegzeroto3 + 1>
	<cfelseif Getit.ofgpct ge -6 and Getit.ofgpct le -4>
		<cfset fgnegFourto6 = fgnegFourto6 + 1>
	<cfelseif Getit.ofgpct ge -9 and Getit.ofgpct le -7>
		<cfset fgnegSevento9 = fgnegSevento9 + 1>
	<cfelseif Getit.ofgpct ge -12 and Getit.ofgpct le -10>
		<cfset fgnegTento12 = fgnegTento12 + 1>
	<cfelseif Getit.ofgpct ge -15 and Getit.ofgpct le -13>
		<cfset fgnegThirteento15 = fgnegThirteento15 + 1>
	<cfelseif Getit.ofgpct le -16>	
		<cfset fgnegGreater16 = fgnegGreater16 + 1>
	</cfif>	




	<cfif Getit.offreb ge 0 and Getit.offreb le 3>
		<cfset rbzeroto3 = rbzeroto3 + 1>
	<cfelseif Getit.offreb ge 4 and Getit.offreb le 6>
		<cfset rbFourto6 = rbFourto6 + 1>
	<cfelseif Getit.offreb ge 7 and Getit.offreb le 9>
		<cfset rbSevento9 = rbSevento9 + 1>
	<cfelseif Getit.offreb ge 10 and Getit.offreb le 12>
		<cfset rbTento12 = rbTento12 + 1>
	<cfelseif Getit.offreb ge 13 and Getit.offreb le 15>
		<cfset rbThirteento15 = rbThirteento15 + 1>
	<cfelseif Getit.offreb ge 16>	
		<cfset rbGreater16 = rbGreater16 + 1>
	</cfif>	

	<cfif Getit.offreb ge -3 and Getit.offreb lt 0>
		<cfset rbnegzeroto3 = rbnegzeroto3 + 1>
	<cfelseif Getit.offreb ge -6 and Getit.offreb le -4>
		<cfset rbnegFourto6 = rbnegFourto6 + 1>
	<cfelseif Getit.offreb ge -9 and Getit.offreb le -7>
		<cfset rbnegSevento9 = rbnegSevento9 + 1>
	<cfelseif Getit.offreb ge -12 and Getit.offreb le -10>
		<cfset rbnegTento12 = rbnegTento12 + 1>
	<cfelseif Getit.offreb ge -15 and Getit.offreb le -13>
		<cfset rbnegThirteento15 = rbnegThirteento15 + 1>
	<cfelseif Getit.offreb le -16>	
		<cfset rbnegGreater16 = rbnegGreater16 + 1>
	</cfif>	


	
	<cfif Getit.ofga ge 0 and Getit.ofga le 3>
		<cfset fgazeroto3 = fgazeroto3 + 1>
	<cfelseif Getit.ofga ge 4 and Getit.ofga le 6>
		<cfset fgaFourto6 = fgaFourto6 + 1>
	<cfelseif Getit.ofga ge 7 and Getit.ofga le 9>
		<cfset fgaSevento9 = fgaSevento9 + 1>
	<cfelseif Getit.ofga ge 10 and Getit.ofga le 12>
		<cfset fgaTento12 = fgaTento12 + 1>
	<cfelseif Getit.ofga ge 13 and Getit.ofga le 15>
		<cfset fgaThirteento15 = fgaThirteento15 + 1>
	<cfelseif Getit.ofga ge 16>	
		<cfset fgaGreater16 = fgaGreater16 + 1>
	</cfif>	

	<cfif Getit.ofga ge -3 and Getit.ofga lt 0>
		<cfset fganegzeroto3 = fganegzeroto3 + 1>
	<cfelseif Getit.ofga ge -6 and Getit.ofga le -4>
		<cfset fganegFourto6 = fganegFourto6 + 1>
	<cfelseif Getit.ofga ge -9 and Getit.ofga le -7>
		<cfset fganegSevento9 = fganegSevento9 + 1>
	<cfelseif Getit.ofga ge -12 and Getit.ofga le -10>
		<cfset fganegTento12 = fganegTento12 + 1>
	<cfelseif Getit.ofga ge -15 and Getit.ofga le -13>
		<cfset fganegThirteento15 = fganegThirteento15 + 1>
	<cfelseif Getit.ofga le -16>	
		<cfset fganegGreater16 = fganegGreater16 + 1>
	</cfif>	



	<cfif Getit.otpm ge 0 and Getit.otpm le 3>
		<cfset tpmzeroto3 = tpmzeroto3 + 1>
	<cfelseif Getit.otpm ge 4 and Getit.otpm le 6>
		<cfset tpmFourto6 = tpmFourto6 + 1>
	<cfelseif Getit.otpm ge 7 and Getit.otpm le 9>
		<cfset tpmSevento9 = tpmSevento9 + 1>
	<cfelseif Getit.otpm ge 10 and Getit.otpm le 12>
		<cfset tpmTento12 = tpmTento12 + 1>
	<cfelseif Getit.otpm ge 13 and Getit.otpm le 15>
		<cfset tpmThirteento15 = tpmThirteento15 + 1>
	<cfelseif Getit.otpm ge 16>	
		<cfset tpmGreater16 = tpmGreater16 + 1>
	</cfif>	

	<cfif Getit.otpm ge -3 and Getit.otpm lt 0>
		<cfset tpmnegzeroto3 = tpmnegzeroto3 + 1>
	<cfelseif Getit.otpm ge -6 and Getit.otpm le -4>
		<cfset tpmnegFourto6 = tpmnegFourto6 + 1>
	<cfelseif Getit.otpm ge -9 and Getit.otpm le -7>
		<cfset tpmnegSevento9 = tpmnegSevento9 + 1>
	<cfelseif Getit.otpm ge -12 and Getit.otpm le -10>
		<cfset tpmnegTento12 = tpmnegTento12 + 1>
	<cfelseif Getit.otpm ge -15 and Getit.otpm le -13>
		<cfset tpmnegThirteento15 = tpmnegThirteento15 + 1>
	<cfelseif Getit.otpm le -16>	
		<cfset tpmnegGreater16 = tpmnegGreater16 + 1>
	</cfif>	
	
	

	<cfif Getit.oftm ge 0 and Getit.oftm le 3>
		<cfset ftmzeroto3 = ftmzeroto3 + 1>
	<cfelseif Getit.oftm ge 4 and Getit.oftm le 6>
		<cfset ftmFourto6 = ftmFourto6 + 1>
	<cfelseif Getit.oftm ge 7 and Getit.oftm le 9>
		<cfset ftmSevento9 = ftmSevento9 + 1>
	<cfelseif Getit.oftm ge 10 and Getit.oftm le 12>
		<cfset ftmTento12 = ftmTento12 + 1>
	<cfelseif Getit.oftm ge 13 and Getit.oftm le 15>
		<cfset ftmThirteento15 = ftmThirteento15 + 1>
	<cfelseif Getit.oftm ge 16>	
		<cfset ftmGreater16 = ftmGreater16 + 1>
	</cfif>	

	<cfif Getit.oftm ge -3 and Getit.oftm lt 0>
		<cfset ftmnegzeroto3 = ftmnegzeroto3 + 1>
	<cfelseif Getit.oftm ge -6 and Getit.oftm le -4>
		<cfset ftmnegFourto6 = ftmnegFourto6 + 1>
	<cfelseif Getit.oftm ge -9 and Getit.oftm le -7>
		<cfset ftmnegSevento9 = ftmnegSevento9 + 1>
	<cfelseif Getit.oftm ge -12 and Getit.oftm le -10>
		<cfset ftmnegTento12 = ftmnegTento12 + 1>
	<cfelseif Getit.oftm ge -15 and Getit.oftm le -13>
		<cfset ftmnegThirteento15 = ftmnegThirteento15 + 1>
	<cfelseif Getit.oftm le -16>	
		<cfset ftmnegGreater16 = ftmnegGreater16 + 1>
	</cfif>	
	
	
	<cfif Getit.oturnovers ge 0 and Getit.oturnovers le 3>
		<cfset tozeroto3 = tozeroto3 + 1>
	<cfelseif Getit.oturnovers ge 4 and Getit.oturnovers le 6>
		<cfset toFourto6 = toFourto6 + 1>
	<cfelseif Getit.oturnovers ge 7 and Getit.oturnovers le 9>
		<cfset toSevento9 = toSevento9 + 1>
	<cfelseif Getit.oturnovers ge 10 and Getit.oturnovers le 12>
		<cfset toTento12 = toTento12 + 1>
	<cfelseif Getit.oturnovers ge 13 and Getit.oturnovers le 15>
		<cfset toThirteento15 = toThirteento15 + 1>
	<cfelseif Getit.oturnovers ge 16>	
		<cfset toGreater16 = toGreater16 + 1>
	</cfif>	

	<cfif Getit.oturnovers ge -3 and Getit.oturnovers lt 0>
		<cfset tonegzeroto3 = tonegzeroto3 + 1>
	<cfelseif Getit.oturnovers ge -6 and Getit.oturnovers le -4>
		<cfset tonegFourto6 = tonegFourto6 + 1>
	<cfelseif Getit.oturnovers ge -9 and Getit.oturnovers le -7>
		<cfset tonegSevento9 = tonegSevento9 + 1>
	<cfelseif Getit.oturnovers ge -12 and Getit.oturnovers le -10>
		<cfset tonegTento12 = tonegTento12 + 1>
	<cfelseif Getit.oturnovers ge -15 and Getit.oturnovers le -13>
		<cfset tonegThirteento15 = tonegThirteento15 + 1>
	<cfelseif Getit.oturnovers le -16>	
		<cfset tonegGreater16 = tonegGreater16 + 1>
	</cfif>	
</cfloop>

<cfset TotalGames = GetIt.recordcount>

<cfif TotalGames neq 0>
<cfquery datasource="nba" name="addit">
Insert into BigWinStatsOff
(Team,
HA,
FG03,
FG46,
FG79,
FG1012,
FG1315,
FG16plus,
negFG03,
negFG46,
negFG79,
negFG1012,
negFG1315,
negFG16plus,
FGA03,
FGA46,
FGA79,
FGA1012,
FGA1315,
FGA16plus,
negFGA03,
negFGA46,
negFGA79,
negFGA1012,
negFGA1315,
negFGA16plus,
RB03,
RB46,
RB79,
RB1012,
RB1315,
RB16plus,
negRB03,
negRB46,
negRB79,
negRB1012,
negRB1315,
negRB16plus,
TPM03,
TPM46,
TPM79,
TPM1012,
TPM1315,
TPM16plus,
negTPM03,
negTPM46,
negTPM79,
negTPM1012,
negTPM1315,
negTPM16plus,
TO03,
TO46,
TO79,
TO1012,
TO1315,
TO16plus,
negTO03,
negTO46,
negTO79,
negTO1012,
negTO1315,
negTO16plus,
ftm03,
ftm46,
ftm79,
ftm1012,
ftm1315,
ftm16plus,
negftm03,
negftm46,
negftm79,
negftm1012,
negftm1315,
negftm16plus
)
values
(
'#GetTeams.Team#',
'A',
#(fgzeroto3/totalgames)*100#,
#(fgFourto6/totalgames)*100#,
#(fgSevento9/totalgames)*100#,
#(fgTento12/totalgames)*100#,
#(fgThirteento15/totalgames)*100#,
#(fgGreater16/totalgames)*100#,
#(fgnegzeroto3/totalgames)*100#,
#(fgnegFourto6/totalgames)*100#,
#(fgnegSevento9/totalgames)*100#,
#(fgnegTento12/totalgames)*100#,
#(fgnegThirteento15/totalgames)*100#,
#(fgnegGreater16/totalgames)*100#,
#(fgazeroto3/totalgames)*100#,
#(fgaFourto6/totalgames)*100#,
#(fgaSevento9/totalgames)*100#,
#(fgaTento12/totalgames)*100#,
#(fgaThirteento15/totalgames)*100#,
#(fgaGreater16/totalgames)*100#,
#(fganegzeroto3/totalgames)*100#,
#(fganegFourto6/totalgames)*100#,
#(fganegSevento9/totalgames)*100#,
#(fganegTento12/totalgames)*100#,
#(fganegThirteento15/totalgames)*100#,
#(fganegGreater16/totalgames)*100#,
#(rbzeroto3/totalgames)*100#,
#(rbFourto6/totalgames)*100#,
#(rbSevento9/totalgames)*100#,
#(rbTento12/totalgames)*100#,
#(rbThirteento15/totalgames)*100#,
#(rbGreater16/totalgames)*100#,
#(rbnegzeroto3/totalgames)*100#,
#(rbnegFourto6/totalgames)*100#,
#(rbnegSevento9/totalgames)*100#,
#(rbnegTento12/totalgames)*100#,
#(rbnegThirteento15/totalgames)*100#,
#(rbnegGreater16/totalgames)*100#,
#(tpmzeroto3/totalgames)*100#,
#(tpmFourto6/totalgames)*100#,
#(tpmSevento9/totalgames)*100#,
#(tpmTento12/totalgames)*100#,
#(tpmThirteento15/totalgames)*100#,
#(tpmGreater16/totalgames)*100#,
#(tpmnegzeroto3/totalgames)*100#,
#(tpmnegFourto6/totalgames)*100#,
#(tpmnegSevento9/totalgames)*100#,
#(tpmnegTento12/totalgames)*100#,
#(tpmnegThirteento15/totalgames)*100#,
#(tpmnegGreater16/totalgames)*100#,
#(tozeroto3/totalgames)*100#,
#(toFourto6/totalgames)*100#,
#(toSevento9/totalgames)*100#,
#(toTento12/totalgames)*100#,
#(toThirteento15/totalgames)*100#,
#(toGreater16/totalgames)*100#,
#(tonegzeroto3/totalgames)*100#,
#(tonegFourto6/totalgames)*100#,
#(tonegSevento9/totalgames)*100#,
#(tonegTento12/totalgames)*100#,
#(tonegThirteento15/totalgames)*100#,
#(tonegGreater16/totalgames)*100#,
#(ftmzeroto3/totalgames)*100#,
#(ftmFourto6/totalgames)*100#,
#(ftmSevento9/totalgames)*100#,
#(ftmTento12/totalgames)*100#,
#(ftmThirteento15/totalgames)*100#,
#(ftmGreater16/totalgames)*100#,
#(ftmnegzeroto3/totalgames)*100#,
#(ftmnegFourto6/totalgames)*100#,
#(ftmnegSevento9/totalgames)*100#,
#(ftmnegTento12/totalgames)*100#,
#(ftmnegThirteento15/totalgames)*100#,
#(ftmnegGreater16/totalgames)*100#
)
</cfquery>
<cfelse>
No data found for #GetTeams.Team#
</cfif>



</cfoutput>





























------------------------------------------------ Defense --------------------------------------------------------------------------
<cfquery datasource="nba" name="GetTeams">
Delete from BigWinStatsDef
</cfquery>


<cfquery datasource="nba" name="GetTeams">
Select Distinct team 
from gap
</cfquery>

<cfoutput query="GetTeams">

<cfquery datasource="nba" name="Getit">
	Select * from Power where Team = '#GetTeams.Team#'
	and ha = 'H'
	and gametime < '#mygametime#'
</cfquery>

<cfset fgzeroto3  = 0>
<cfset fgFourto6  = 0>
<cfset fgSevento9 = 0>
<cfset fgTento12  = 0>
<cfset fgThirteento15 = 0>
<cfset fgGreater16 = 0>

<cfset rbzeroto3  = 0>
<cfset rbFourto6  = 0>
<cfset rbSevento9 = 0>
<cfset rbTento12  = 0>
<cfset rbThirteento15 = 0>
<cfset rbGreater16 = 0>

<cfset fgazeroto3  = 0>
<cfset fgaFourto6  = 0>
<cfset fgaSevento9 = 0>
<cfset fgaTento12  = 0>
<cfset fgaThirteento15 = 0>
<cfset fgaGreater16 = 0>

<cfset tpmzeroto3  = 0>
<cfset tpmFourto6  = 0>
<cfset tpmSevento9 = 0>
<cfset tpmTento12  = 0>
<cfset tpmThirteento15 = 0>
<cfset tpmGreater16 = 0>

<cfset ftmzeroto3  = 0>
<cfset ftmFourto6  = 0>
<cfset ftmSevento9 = 0>
<cfset ftmTento12  = 0>
<cfset ftmThirteento15 = 0>
<cfset ftmGreater16 = 0>

<cfset tozeroto3  = 0>
<cfset toFourto6  = 0>
<cfset toSevento9 = 0>
<cfset toTento12  = 0>
<cfset toThirteento15 = 0>
<cfset toGreater16 = 0>




<cfset fgnegzeroto3  = 0>
<cfset fgnegFourto6  = 0>
<cfset fgnegSevento9 = 0>
<cfset fgnegTento12  = 0>
<cfset fgnegThirteento15 = 0>
<cfset fgnegGreater16 = 0>

<cfset rbnegzeroto3  = 0>
<cfset rbnegFourto6  = 0>
<cfset rbnegSevento9 = 0>
<cfset rbnegTento12  = 0>
<cfset rbnegThirteento15 = 0>
<cfset rbnegGreater16 = 0>

<cfset fganegzeroto3  = 0>
<cfset fganegFourto6  = 0>
<cfset fganegSevento9 = 0>
<cfset fganegTento12  = 0>
<cfset fganegThirteento15 = 0>
<cfset fganegGreater16 = 0>

<cfset tpmnegzeroto3  = 0>
<cfset tpmnegFourto6  = 0>
<cfset tpmnegSevento9 = 0>
<cfset tpmnegTento12  = 0>
<cfset tpmnegThirteento15 = 0>
<cfset tpmnegGreater16 = 0>

<cfset ftmnegzeroto3  = 0>
<cfset ftmnegFourto6  = 0>
<cfset ftmnegSevento9 = 0>
<cfset ftmnegTento12  = 0>
<cfset ftmnegThirteento15 = 0>
<cfset ftmnegGreater16 = 0>

<cfset tonegzeroto3  = 0>
<cfset tonegFourto6  = 0>
<cfset tonegSevento9 = 0>
<cfset tonegTento12  = 0>
<cfset tonegThirteento15 = 0>
<cfset tonegGreater16 = 0>


<cfloop query="GetIt">

	<cfif Getit.dfgpct ge 0 and Getit.dfgpct le 3>
		<cfset fgzeroto3 = fgzeroto3 + 1>
	<cfelseif Getit.dfgpct ge 4 and Getit.dfgpct le 6>
		<cfset fgFourto6 = fgFourto6 + 1>
	<cfelseif Getit.dfgpct ge 7 and Getit.dfgpct le 9>
		<cfset fgSevento9 = fgSevento9 + 1>
	<cfelseif Getit.dfgpct ge 10 and Getit.dfgpct le 12>
		<cfset fgTento12 = fgTento12 + 1>
	<cfelseif Getit.dfgpct ge 13 and Getit.dfgpct le 15>
		<cfset fgThirteento15 = fgThirteento15 + 1>
	<cfelseif Getit.dfgpct ge 16>	
		<cfset fgGreater16 = fgGreater16 + 1>
	</cfif>	

	<cfif Getit.dfgpct ge -3 and Getit.dfgpct lt 0>
		<cfset fgnegzeroto3 = fgnegzeroto3 + 1>
	<cfelseif Getit.dfgpct ge -6 and Getit.dfgpct le -4>
		<cfset fgnegFourto6 = fgnegFourto6 + 1>
	<cfelseif Getit.dfgpct ge -9 and Getit.dfgpct le -7>
		<cfset fgnegSevento9 = fgnegSevento9 + 1>
	<cfelseif Getit.dfgpct ge -12 and Getit.dfgpct le -10>
		<cfset fgnegTento12 = fgnegTento12 + 1>
	<cfelseif Getit.dfgpct ge -15 and Getit.dfgpct le -13>
		<cfset fgnegThirteento15 = fgnegThirteento15 + 1>
	<cfelseif Getit.dfgpct le -16>	
		<cfset fgnegGreater16 = fgnegGreater16 + 1>
	</cfif>	




	<cfif Getit.defreb ge 0 and Getit.defreb le 3>
		<cfset rbzeroto3 = rbzeroto3 + 1>
	<cfelseif Getit.defreb ge 4 and Getit.defreb le 6>
		<cfset rbFourto6 = rbFourto6 + 1>
	<cfelseif Getit.defreb ge 7 and Getit.defreb le 9>
		<cfset rbSevento9 = rbSevento9 + 1>
	<cfelseif Getit.defreb ge 10 and Getit.defreb le 12>
		<cfset rbTento12 = rbTento12 + 1>
	<cfelseif Getit.defreb ge 13 and Getit.defreb le 15>
		<cfset rbThirteento15 = rbThirteento15 + 1>
	<cfelseif Getit.defreb ge 16>	
		<cfset rbGreater16 = rbGreater16 + 1>
	</cfif>	

	<cfif Getit.defreb ge -3 and Getit.defreb lt 0>
		<cfset rbnegzeroto3 = rbnegzeroto3 + 1>
	<cfelseif Getit.defreb ge -6 and Getit.defreb le -4>
		<cfset rbnegFourto6 = rbnegFourto6 + 1>
	<cfelseif Getit.defreb ge -9 and Getit.defreb le -7>
		<cfset rbnegSevento9 = rbnegSevento9 + 1>
	<cfelseif Getit.defreb ge -12 and Getit.defreb le -10>
		<cfset rbnegTento12 = rbnegTento12 + 1>
	<cfelseif Getit.defreb ge -15 and Getit.defreb le -13>
		<cfset rbnegThirteento15 = rbnegThirteento15 + 1>
	<cfelseif Getit.defreb le -16>	
		<cfset rbnegGreater16 = rbnegGreater16 + 1>
	</cfif>	


	
	<cfif Getit.dfga ge 0 and Getit.dfga le 3>
		<cfset fgazeroto3 = fgazeroto3 + 1>
	<cfelseif Getit.dfga ge 4 and Getit.dfga le 6>
		<cfset fgaFourto6 = fgaFourto6 + 1>
	<cfelseif Getit.dfga ge 7 and Getit.dfga le 9>
		<cfset fgaSevento9 = fgaSevento9 + 1>
	<cfelseif Getit.dfga ge 10 and Getit.dfga le 12>
		<cfset fgaTento12 = fgaTento12 + 1>
	<cfelseif Getit.dfga ge 13 and Getit.dfga le 15>
		<cfset fgaThirteento15 = fgaThirteento15 + 1>
	<cfelseif Getit.dfga ge 16>	
		<cfset fgaGreater16 = fgaGreater16 + 1>
	</cfif>	

	<cfif Getit.dfga ge -3 and Getit.dfga lt 0>
		<cfset fganegzeroto3 = fganegzeroto3 + 1>
	<cfelseif Getit.dfga ge -6 and Getit.dfga le -4>
		<cfset fganegFourto6 = fganegFourto6 + 1>
	<cfelseif Getit.dfga ge -9 and Getit.dfga le -7>
		<cfset fganegSevento9 = fganegSevento9 + 1>
	<cfelseif Getit.dfga ge -12 and Getit.dfga le -10>
		<cfset fganegTento12 = fganegTento12 + 1>
	<cfelseif Getit.dfga ge -15 and Getit.dfga le -13>
		<cfset fganegThirteento15 = fganegThirteento15 + 1>
	<cfelseif Getit.dfga le -16>	
		<cfset fganegGreater16 = fganegGreater16 + 1>
	</cfif>	



	<cfif Getit.dtpm ge 0 and Getit.dtpm le 3>
		<cfset tpmzeroto3 = tpmzeroto3 + 1>
	<cfelseif Getit.dtpm ge 4 and Getit.dtpm le 6>
		<cfset tpmFourto6 = tpmFourto6 + 1>
	<cfelseif Getit.dtpm ge 7 and Getit.dtpm le 9>
		<cfset tpmSevento9 = tpmSevento9 + 1>
	<cfelseif Getit.dtpm ge 10 and Getit.dtpm le 12>
		<cfset tpmTento12 = tpmTento12 + 1>
	<cfelseif Getit.dtpm ge 13 and Getit.dtpm le 15>
		<cfset tpmThirteento15 = tpmThirteento15 + 1>
	<cfelseif Getit.dtpm ge 16>	
		<cfset tpmGreater16 = tpmGreater16 + 1>
	</cfif>	

	<cfif Getit.dtpm ge -3 and Getit.dtpm lt 0>
		<cfset tpmnegzeroto3 = tpmnegzeroto3 + 1>
	<cfelseif Getit.dtpm ge -6 and Getit.dtpm le -4>
		<cfset tpmnegFourto6 = tpmnegFourto6 + 1>
	<cfelseif Getit.dtpm ge -9 and Getit.dtpm le -7>
		<cfset tpmnegSevento9 = tpmnegSevento9 + 1>
	<cfelseif Getit.dtpm ge -12 and Getit.dtpm le -10>
		<cfset tpmnegTento12 = tpmnegTento12 + 1>
	<cfelseif Getit.dtpm ge -15 and Getit.dtpm le -13>
		<cfset tpmnegThirteento15 = tpmnegThirteento15 + 1>
	<cfelseif Getit.dtpm le -16>	
		<cfset tpmnegGreater16 = tpmnegGreater16 + 1>
	</cfif>	
	
	

	<cfif Getit.dftm ge 0 and Getit.dftm le 3>
		<cfset ftmzeroto3 = ftmzeroto3 + 1>
	<cfelseif Getit.dftm ge 4 and Getit.dftm le 6>
		<cfset ftmFourto6 = ftmFourto6 + 1>
	<cfelseif Getit.dftm ge 7 and Getit.dftm le 9>
		<cfset ftmSevento9 = ftmSevento9 + 1>
	<cfelseif Getit.dftm ge 10 and Getit.dftm le 12>
		<cfset ftmTento12 = ftmTento12 + 1>
	<cfelseif Getit.dftm ge 13 and Getit.dftm le 15>
		<cfset ftmThirteento15 = ftmThirteento15 + 1>
	<cfelseif Getit.dftm ge 16>	
		<cfset ftmGreater16 = ftmGreater16 + 1>
	</cfif>	

	<cfif Getit.dftm ge -3 and Getit.dftm lt 0>
		<cfset ftmnegzeroto3 = ftmnegzeroto3 + 1>
	<cfelseif Getit.dftm ge -6 and Getit.dftm le -4>
		<cfset ftmnegFourto6 = ftmnegFourto6 + 1>
	<cfelseif Getit.dftm ge -9 and Getit.dftm le -7>
		<cfset ftmnegSevento9 = ftmnegSevento9 + 1>
	<cfelseif Getit.dftm ge -12 and Getit.dftm le -10>
		<cfset ftmnegTento12 = ftmnegTento12 + 1>
	<cfelseif Getit.dftm ge -15 and Getit.dftm le -13>
		<cfset ftmnegThirteento15 = ftmnegThirteento15 + 1>
	<cfelseif Getit.dftm le -16>	
		<cfset ftmnegGreater16 = ftmnegGreater16 + 1>
	</cfif>	
	
	
	<cfif Getit.dturnovers ge 0 and Getit.dturnovers le 3>
		<cfset tozeroto3 = tozeroto3 + 1>
	<cfelseif Getit.dturnovers ge 4 and Getit.dturnovers le 6>
		<cfset toFourto6 = toFourto6 + 1>
	<cfelseif Getit.dturnovers ge 7 and Getit.dturnovers le 9>
		<cfset toSevento9 = toSevento9 + 1>
	<cfelseif Getit.dturnovers ge 10 and Getit.dturnovers le 12>
		<cfset toTento12 = toTento12 + 1>
	<cfelseif Getit.dturnovers ge 13 and Getit.dturnovers le 15>
		<cfset toThirteento15 = toThirteento15 + 1>
	<cfelseif Getit.dturnovers ge 16>	
		<cfset toGreater16 = toGreater16 + 1>
	</cfif>	

	<cfif Getit.dturnovers ge -3 and Getit.dturnovers lt 0>
		<cfset tonegzeroto3 = tonegzeroto3 + 1>
	<cfelseif Getit.dturnovers ge -6 and Getit.dturnovers le -4>
		<cfset tonegFourto6 = tonegFourto6 + 1>
	<cfelseif Getit.dturnovers ge -9 and Getit.dturnovers le -7>
		<cfset tonegSevento9 = tonegSevento9 + 1>
	<cfelseif Getit.dturnovers ge -12 and Getit.dturnovers le -10>
		<cfset tonegTento12 = tonegTento12 + 1>
	<cfelseif Getit.dturnovers ge -15 and Getit.dturnovers le -13>
		<cfset tonegThirteento15 = tonegThirteento15 + 1>
	<cfelseif Getit.dturnovers le -16>	
		<cfset tonegGreater16 = tonegGreater16 + 1>
	</cfif>	
</cfloop>

<cfset TotalGames = GetIt.recordcount>

<cfif TotalGames neq 0>
<cfquery datasource="nba" name="addit">
Insert into BigWinStatsDef
(Team,
HA,
FG03,
FG46,
FG79,
FG1012,
FG1315,
FG16plus,
negFG03,
negFG46,
negFG79,
negFG1012,
negFG1315,
negFG16plus,
FGA03,
FGA46,
FGA79,
FGA1012,
FGA1315,
FGA16plus,
negFGA03,
negFGA46,
negFGA79,
negFGA1012,
negFGA1315,
negFGA16plus,
RB03,
RB46,
RB79,
RB1012,
RB1315,
RB16plus,
negRB03,
negRB46,
negRB79,
negRB1012,
negRB1315,
negRB16plus,
TPM03,
TPM46,
TPM79,
TPM1012,
TPM1315,
TPM16plus,
negTPM03,
negTPM46,
negTPM79,
negTPM1012,
negTPM1315,
negTPM16plus,
TO03,
TO46,
TO79,
TO1012,
TO1315,
TO16plus,
negTO03,
negTO46,
negTO79,
negTO1012,
negTO1315,
negTO16plus,
ftm03,
ftm46,
ftm79,
ftm1012,
ftm1315,
ftm16plus,
negftm03,
negftm46,
negftm79,
negftm1012,
negftm1315,
negftm16plus
)
values
(
'#GetTeams.Team#',
'H',
#(fgzeroto3/totalgames)*100#,
#(fgFourto6/totalgames)*100#,
#(fgSevento9/totalgames)*100#,
#(fgTento12/totalgames)*100#,
#(fgThirteento15/totalgames)*100#,
#(fgGreater16/totalgames)*100#,
#(fgnegzeroto3/totalgames)*100#,
#(fgnegFourto6/totalgames)*100#,
#(fgnegSevento9/totalgames)*100#,
#(fgnegTento12/totalgames)*100#,
#(fgnegThirteento15/totalgames)*100#,
#(fgnegGreater16/totalgames)*100#,
#(fgazeroto3/totalgames)*100#,
#(fgaFourto6/totalgames)*100#,
#(fgaSevento9/totalgames)*100#,
#(fgaTento12/totalgames)*100#,
#(fgaThirteento15/totalgames)*100#,
#(fgaGreater16/totalgames)*100#,
#(fganegzeroto3/totalgames)*100#,
#(fganegFourto6/totalgames)*100#,
#(fganegSevento9/totalgames)*100#,
#(fganegTento12/totalgames)*100#,
#(fganegThirteento15/totalgames)*100#,
#(fganegGreater16/totalgames)*100#,
#(rbzeroto3/totalgames)*100#,
#(rbFourto6/totalgames)*100#,
#(rbSevento9/totalgames)*100#,
#(rbTento12/totalgames)*100#,
#(rbThirteento15/totalgames)*100#,
#(rbGreater16/totalgames)*100#,
#(rbnegzeroto3/totalgames)*100#,
#(rbnegFourto6/totalgames)*100#,
#(rbnegSevento9/totalgames)*100#,
#(rbnegTento12/totalgames)*100#,
#(rbnegThirteento15/totalgames)*100#,
#(rbnegGreater16/totalgames)*100#,
#(tpmzeroto3/totalgames)*100#,
#(tpmFourto6/totalgames)*100#,
#(tpmSevento9/totalgames)*100#,
#(tpmTento12/totalgames)*100#,
#(tpmThirteento15/totalgames)*100#,
#(tpmGreater16/totalgames)*100#,
#(tpmnegzeroto3/totalgames)*100#,
#(tpmnegFourto6/totalgames)*100#,
#(tpmnegSevento9/totalgames)*100#,
#(tpmnegTento12/totalgames)*100#,
#(tpmnegThirteento15/totalgames)*100#,
#(tpmnegGreater16/totalgames)*100#,
#(tozeroto3/totalgames)*100#,
#(toFourto6/totalgames)*100#,
#(toSevento9/totalgames)*100#,
#(toTento12/totalgames)*100#,
#(toThirteento15/totalgames)*100#,
#(toGreater16/totalgames)*100#,
#(tonegzeroto3/totalgames)*100#,
#(tonegFourto6/totalgames)*100#,
#(tonegSevento9/totalgames)*100#,
#(tonegTento12/totalgames)*100#,
#(tonegThirteento15/totalgames)*100#,
#(tonegGreater16/totalgames)*100#,
#(ftmzeroto3/totalgames)*100#,
#(ftmFourto6/totalgames)*100#,
#(ftmSevento9/totalgames)*100#,
#(ftmTento12/totalgames)*100#,
#(ftmThirteento15/totalgames)*100#,
#(ftmGreater16/totalgames)*100#,
#(ftmnegzeroto3/totalgames)*100#,
#(ftmnegFourto6/totalgames)*100#,
#(ftmnegSevento9/totalgames)*100#,
#(ftmnegTento12/totalgames)*100#,
#(ftmnegThirteento15/totalgames)*100#,
#(ftmnegGreater16/totalgames)*100#
)
</cfquery>
<cfelse>
No data found for #GetTeams.Team#
</cfif>



</cfoutput>

















<cfquery datasource="nba" name="GetTeams">
Select Distinct team 
from gap
</cfquery>

<cfoutput query="GetTeams">

<cfquery datasource="nba" name="Getit">
	Select * from Power where Team = '#GetTeams.Team#'
	and ha = 'A'
	and gametime < '#mygametime#'
</cfquery>

<cfset fgzeroto3  = 0>
<cfset fgFourto6  = 0>
<cfset fgSevento9 = 0>
<cfset fgTento12  = 0>
<cfset fgThirteento15 = 0>
<cfset fgGreater16 = 0>

<cfset rbzeroto3  = 0>
<cfset rbFourto6  = 0>
<cfset rbSevento9 = 0>
<cfset rbTento12  = 0>
<cfset rbThirteento15 = 0>
<cfset rbGreater16 = 0>

<cfset fgazeroto3  = 0>
<cfset fgaFourto6  = 0>
<cfset fgaSevento9 = 0>
<cfset fgaTento12  = 0>
<cfset fgaThirteento15 = 0>
<cfset fgaGreater16 = 0>

<cfset tpmzeroto3  = 0>
<cfset tpmFourto6  = 0>
<cfset tpmSevento9 = 0>
<cfset tpmTento12  = 0>
<cfset tpmThirteento15 = 0>
<cfset tpmGreater16 = 0>

<cfset ftmzeroto3  = 0>
<cfset ftmFourto6  = 0>
<cfset ftmSevento9 = 0>
<cfset ftmTento12  = 0>
<cfset ftmThirteento15 = 0>
<cfset ftmGreater16 = 0>

<cfset tozeroto3  = 0>
<cfset toFourto6  = 0>
<cfset toSevento9 = 0>
<cfset toTento12  = 0>
<cfset toThirteento15 = 0>
<cfset toGreater16 = 0>




<cfset fgnegzeroto3  = 0>
<cfset fgnegFourto6  = 0>
<cfset fgnegSevento9 = 0>
<cfset fgnegTento12  = 0>
<cfset fgnegThirteento15 = 0>
<cfset fgnegGreater16 = 0>

<cfset rbnegzeroto3  = 0>
<cfset rbnegFourto6  = 0>
<cfset rbnegSevento9 = 0>
<cfset rbnegTento12  = 0>
<cfset rbnegThirteento15 = 0>
<cfset rbnegGreater16 = 0>

<cfset fganegzeroto3  = 0>
<cfset fganegFourto6  = 0>
<cfset fganegSevento9 = 0>
<cfset fganegTento12  = 0>
<cfset fganegThirteento15 = 0>
<cfset fganegGreater16 = 0>

<cfset tpmnegzeroto3  = 0>
<cfset tpmnegFourto6  = 0>
<cfset tpmnegSevento9 = 0>
<cfset tpmnegTento12  = 0>
<cfset tpmnegThirteento15 = 0>
<cfset tpmnegGreater16 = 0>

<cfset ftmnegzeroto3  = 0>
<cfset ftmnegFourto6  = 0>
<cfset ftmnegSevento9 = 0>
<cfset ftmnegTento12  = 0>
<cfset ftmnegThirteento15 = 0>
<cfset ftmnegGreater16 = 0>

<cfset tonegzeroto3  = 0>
<cfset tonegFourto6  = 0>
<cfset tonegSevento9 = 0>
<cfset tonegTento12  = 0>
<cfset tonegThirteento15 = 0>
<cfset tonegGreater16 = 0>


<cfloop query="GetIt">

	<cfif Getit.dfgpct ge 0 and Getit.dfgpct le 3>
		<cfset fgzeroto3 = fgzeroto3 + 1>
	<cfelseif Getit.dfgpct ge 4 and Getit.dfgpct le 6>
		<cfset fgFourto6 = fgFourto6 + 1>
	<cfelseif Getit.dfgpct ge 7 and Getit.dfgpct le 9>
		<cfset fgSevento9 = fgSevento9 + 1>
	<cfelseif Getit.dfgpct ge 10 and Getit.dfgpct le 12>
		<cfset fgTento12 = fgTento12 + 1>
	<cfelseif Getit.dfgpct ge 13 and Getit.dfgpct le 15>
		<cfset fgThirteento15 = fgThirteento15 + 1>
	<cfelseif Getit.dfgpct ge 16>	
		<cfset fgGreater16 = fgGreater16 + 1>
	</cfif>	

	<cfif Getit.dfgpct ge -3 and Getit.dfgpct lt 0>
		<cfset fgnegzeroto3 = fgnegzeroto3 + 1>
	<cfelseif Getit.dfgpct ge -6 and Getit.dfgpct le -4>
		<cfset fgnegFourto6 = fgnegFourto6 + 1>
	<cfelseif Getit.dfgpct ge -9 and Getit.dfgpct le -7>
		<cfset fgnegSevento9 = fgnegSevento9 + 1>
	<cfelseif Getit.dfgpct ge -12 and Getit.dfgpct le -10>
		<cfset fgnegTento12 = fgnegTento12 + 1>
	<cfelseif Getit.dfgpct ge -15 and Getit.dfgpct le -13>
		<cfset fgnegThirteento15 = fgnegThirteento15 + 1>
	<cfelseif Getit.dfgpct le -16>	
		<cfset fgnegGreater16 = fgnegGreater16 + 1>
	</cfif>	




	<cfif Getit.defreb ge 0 and Getit.defreb le 3>
		<cfset rbzeroto3 = rbzeroto3 + 1>
	<cfelseif Getit.defreb ge 4 and Getit.defreb le 6>
		<cfset rbFourto6 = rbFourto6 + 1>
	<cfelseif Getit.defreb ge 7 and Getit.defreb le 9>
		<cfset rbSevento9 = rbSevento9 + 1>
	<cfelseif Getit.defreb ge 10 and Getit.defreb le 12>
		<cfset rbTento12 = rbTento12 + 1>
	<cfelseif Getit.defreb ge 13 and Getit.defreb le 15>
		<cfset rbThirteento15 = rbThirteento15 + 1>
	<cfelseif Getit.defreb ge 16>	
		<cfset rbGreater16 = rbGreater16 + 1>
	</cfif>	

	<cfif Getit.defreb ge -3 and Getit.defreb lt 0>
		<cfset rbnegzeroto3 = rbnegzeroto3 + 1>
	<cfelseif Getit.defreb ge -6 and Getit.defreb le -4>
		<cfset rbnegFourto6 = rbnegFourto6 + 1>
	<cfelseif Getit.defreb ge -9 and Getit.defreb le -7>
		<cfset rbnegSevento9 = rbnegSevento9 + 1>
	<cfelseif Getit.defreb ge -12 and Getit.defreb le -10>
		<cfset rbnegTento12 = rbnegTento12 + 1>
	<cfelseif Getit.defreb ge -15 and Getit.defreb le -13>
		<cfset rbnegThirteento15 = rbnegThirteento15 + 1>
	<cfelseif Getit.defreb le -16>	
		<cfset rbnegGreater16 = rbnegGreater16 + 1>
	</cfif>	


	
	<cfif Getit.dfga ge 0 and Getit.dfga le 3>
		<cfset fgazeroto3 = fgazeroto3 + 1>
	<cfelseif Getit.dfga ge 4 and Getit.dfga le 6>
		<cfset fgaFourto6 = fgaFourto6 + 1>
	<cfelseif Getit.dfga ge 7 and Getit.dfga le 9>
		<cfset fgaSevento9 = fgaSevento9 + 1>
	<cfelseif Getit.dfga ge 10 and Getit.dfga le 12>
		<cfset fgaTento12 = fgaTento12 + 1>
	<cfelseif Getit.dfga ge 13 and Getit.dfga le 15>
		<cfset fgaThirteento15 = fgaThirteento15 + 1>
	<cfelseif Getit.dfga ge 16>	
		<cfset fgaGreater16 = fgaGreater16 + 1>
	</cfif>	

	<cfif Getit.dfga ge -3 and Getit.dfga lt 0>
		<cfset fganegzeroto3 = fganegzeroto3 + 1>
	<cfelseif Getit.dfga ge -6 and Getit.dfga le -4>
		<cfset fganegFourto6 = fganegFourto6 + 1>
	<cfelseif Getit.dfga ge -9 and Getit.dfga le -7>
		<cfset fganegSevento9 = fganegSevento9 + 1>
	<cfelseif Getit.dfga ge -12 and Getit.dfga le -10>
		<cfset fganegTento12 = fganegTento12 + 1>
	<cfelseif Getit.dfga ge -15 and Getit.dfga le -13>
		<cfset fganegThirteento15 = fganegThirteento15 + 1>
	<cfelseif Getit.dfga le -16>	
		<cfset fganegGreater16 = fganegGreater16 + 1>
	</cfif>	



	<cfif Getit.dtpm ge 0 and Getit.dtpm le 3>
		<cfset tpmzeroto3 = tpmzeroto3 + 1>
	<cfelseif Getit.dtpm ge 4 and Getit.dtpm le 6>
		<cfset tpmFourto6 = tpmFourto6 + 1>
	<cfelseif Getit.dtpm ge 7 and Getit.dtpm le 9>
		<cfset tpmSevento9 = tpmSevento9 + 1>
	<cfelseif Getit.dtpm ge 10 and Getit.dtpm le 12>
		<cfset tpmTento12 = tpmTento12 + 1>
	<cfelseif Getit.dtpm ge 13 and Getit.dtpm le 15>
		<cfset tpmThirteento15 = tpmThirteento15 + 1>
	<cfelseif Getit.dtpm ge 16>	
		<cfset tpmGreater16 = tpmGreater16 + 1>
	</cfif>	

	<cfif Getit.dtpm ge -3 and Getit.dtpm lt 0>
		<cfset tpmnegzeroto3 = tpmnegzeroto3 + 1>
	<cfelseif Getit.dtpm ge -6 and Getit.dtpm le -4>
		<cfset tpmnegFourto6 = tpmnegFourto6 + 1>
	<cfelseif Getit.dtpm ge -9 and Getit.dtpm le -7>
		<cfset tpmnegSevento9 = tpmnegSevento9 + 1>
	<cfelseif Getit.dtpm ge -12 and Getit.dtpm le -10>
		<cfset tpmnegTento12 = tpmnegTento12 + 1>
	<cfelseif Getit.dtpm ge -15 and Getit.dtpm le -13>
		<cfset tpmnegThirteento15 = tpmnegThirteento15 + 1>
	<cfelseif Getit.dtpm le -16>	
		<cfset tpmnegGreater16 = tpmnegGreater16 + 1>
	</cfif>	
	
	

	<cfif Getit.dftm ge 0 and Getit.dftm le 3>
		<cfset ftmzeroto3 = ftmzeroto3 + 1>
	<cfelseif Getit.dftm ge 4 and Getit.dftm le 6>
		<cfset ftmFourto6 = ftmFourto6 + 1>
	<cfelseif Getit.dftm ge 7 and Getit.dftm le 9>
		<cfset ftmSevento9 = ftmSevento9 + 1>
	<cfelseif Getit.dftm ge 10 and Getit.dftm le 12>
		<cfset ftmTento12 = ftmTento12 + 1>
	<cfelseif Getit.dftm ge 13 and Getit.dftm le 15>
		<cfset ftmThirteento15 = ftmThirteento15 + 1>
	<cfelseif Getit.dftm ge 16>	
		<cfset ftmGreater16 = ftmGreater16 + 1>
	</cfif>	

	<cfif Getit.dftm ge -3 and Getit.dftm lt 0>
		<cfset ftmnegzeroto3 = ftmnegzeroto3 + 1>
	<cfelseif Getit.dftm ge -6 and Getit.dftm le -4>
		<cfset ftmnegFourto6 = ftmnegFourto6 + 1>
	<cfelseif Getit.dftm ge -9 and Getit.dftm le -7>
		<cfset ftmnegSevento9 = ftmnegSevento9 + 1>
	<cfelseif Getit.dftm ge -12 and Getit.dftm le -10>
		<cfset ftmnegTento12 = ftmnegTento12 + 1>
	<cfelseif Getit.dftm ge -15 and Getit.dftm le -13>
		<cfset ftmnegThirteento15 = ftmnegThirteento15 + 1>
	<cfelseif Getit.dftm le -16>	
		<cfset ftmnegGreater16 = ftmnegGreater16 + 1>
	</cfif>	
	
	
	<cfif Getit.dturnovers ge 0 and Getit.dturnovers le 3>
		<cfset tozeroto3 = tozeroto3 + 1>
	<cfelseif Getit.dturnovers ge 4 and Getit.dturnovers le 6>
		<cfset toFourto6 = toFourto6 + 1>
	<cfelseif Getit.dturnovers ge 7 and Getit.dturnovers le 9>
		<cfset toSevento9 = toSevento9 + 1>
	<cfelseif Getit.dturnovers ge 10 and Getit.dturnovers le 12>
		<cfset toTento12 = toTento12 + 1>
	<cfelseif Getit.dturnovers ge 13 and Getit.dturnovers le 15>
		<cfset toThirteento15 = toThirteento15 + 1>
	<cfelseif Getit.dturnovers ge 16>	
		<cfset toGreater16 = toGreater16 + 1>
	</cfif>	

	<cfif Getit.dturnovers ge -3 and Getit.dturnovers lt 0>
		<cfset tonegzeroto3 = tonegzeroto3 + 1>
	<cfelseif Getit.dturnovers ge -6 and Getit.dturnovers le -4>
		<cfset tonegFourto6 = tonegFourto6 + 1>
	<cfelseif Getit.dturnovers ge -9 and Getit.dturnovers le -7>
		<cfset tonegSevento9 = tonegSevento9 + 1>
	<cfelseif Getit.dturnovers ge -12 and Getit.dturnovers le -10>
		<cfset tonegTento12 = tonegTento12 + 1>
	<cfelseif Getit.dturnovers ge -15 and Getit.dturnovers le -13>
		<cfset tonegThirteento15 = tonegThirteento15 + 1>
	<cfelseif Getit.dturnovers le -16>	
		<cfset tonegGreater16 = tonegGreater16 + 1>
	</cfif>	
</cfloop>

<cfset TotalGames = GetIt.recordcount>

<cfif TotalGames neq 0>
<cfquery datasource="nba" name="addit">
Insert into BigWinStatsDef
(Team,
HA,
FG03,
FG46,
FG79,
FG1012,
FG1315,
FG16plus,
negFG03,
negFG46,
negFG79,
negFG1012,
negFG1315,
negFG16plus,
FGA03,
FGA46,
FGA79,
FGA1012,
FGA1315,
FGA16plus,
negFGA03,
negFGA46,
negFGA79,
negFGA1012,
negFGA1315,
negFGA16plus,
RB03,
RB46,
RB79,
RB1012,
RB1315,
RB16plus,
negRB03,
negRB46,
negRB79,
negRB1012,
negRB1315,
negRB16plus,
TPM03,
TPM46,
TPM79,
TPM1012,
TPM1315,
TPM16plus,
negTPM03,
negTPM46,
negTPM79,
negTPM1012,
negTPM1315,
negTPM16plus,
TO03,
TO46,
TO79,
TO1012,
TO1315,
TO16plus,
negTO03,
negTO46,
negTO79,
negTO1012,
negTO1315,
negTO16plus,
ftm03,
ftm46,
ftm79,
ftm1012,
ftm1315,
ftm16plus,
negftm03,
negftm46,
negftm79,
negftm1012,
negftm1315,
negftm16plus
)
values
(
'#GetTeams.Team#',
'A',
#(fgzeroto3/totalgames)*100#,
#(fgFourto6/totalgames)*100#,
#(fgSevento9/totalgames)*100#,
#(fgTento12/totalgames)*100#,
#(fgThirteento15/totalgames)*100#,
#(fgGreater16/totalgames)*100#,
#(fgnegzeroto3/totalgames)*100#,
#(fgnegFourto6/totalgames)*100#,
#(fgnegSevento9/totalgames)*100#,
#(fgnegTento12/totalgames)*100#,
#(fgnegThirteento15/totalgames)*100#,
#(fgnegGreater16/totalgames)*100#,
#(fgazeroto3/totalgames)*100#,
#(fgaFourto6/totalgames)*100#,
#(fgaSevento9/totalgames)*100#,
#(fgaTento12/totalgames)*100#,
#(fgaThirteento15/totalgames)*100#,
#(fgaGreater16/totalgames)*100#,
#(fganegzeroto3/totalgames)*100#,
#(fganegFourto6/totalgames)*100#,
#(fganegSevento9/totalgames)*100#,
#(fganegTento12/totalgames)*100#,
#(fganegThirteento15/totalgames)*100#,
#(fganegGreater16/totalgames)*100#,
#(rbzeroto3/totalgames)*100#,
#(rbFourto6/totalgames)*100#,
#(rbSevento9/totalgames)*100#,
#(rbTento12/totalgames)*100#,
#(rbThirteento15/totalgames)*100#,
#(rbGreater16/totalgames)*100#,
#(rbnegzeroto3/totalgames)*100#,
#(rbnegFourto6/totalgames)*100#,
#(rbnegSevento9/totalgames)*100#,
#(rbnegTento12/totalgames)*100#,
#(rbnegThirteento15/totalgames)*100#,
#(rbnegGreater16/totalgames)*100#,
#(tpmzeroto3/totalgames)*100#,
#(tpmFourto6/totalgames)*100#,
#(tpmSevento9/totalgames)*100#,
#(tpmTento12/totalgames)*100#,
#(tpmThirteento15/totalgames)*100#,
#(tpmGreater16/totalgames)*100#,
#(tpmnegzeroto3/totalgames)*100#,
#(tpmnegFourto6/totalgames)*100#,
#(tpmnegSevento9/totalgames)*100#,
#(tpmnegTento12/totalgames)*100#,
#(tpmnegThirteento15/totalgames)*100#,
#(tpmnegGreater16/totalgames)*100#,
#(tozeroto3/totalgames)*100#,
#(toFourto6/totalgames)*100#,
#(toSevento9/totalgames)*100#,
#(toTento12/totalgames)*100#,
#(toThirteento15/totalgames)*100#,
#(toGreater16/totalgames)*100#,
#(tonegzeroto3/totalgames)*100#,
#(tonegFourto6/totalgames)*100#,
#(tonegSevento9/totalgames)*100#,
#(tonegTento12/totalgames)*100#,
#(tonegThirteento15/totalgames)*100#,
#(tonegGreater16/totalgames)*100#,
#(ftmzeroto3/totalgames)*100#,
#(ftmFourto6/totalgames)*100#,
#(ftmSevento9/totalgames)*100#,
#(ftmTento12/totalgames)*100#,
#(ftmThirteento15/totalgames)*100#,
#(ftmGreater16/totalgames)*100#,
#(ftmnegzeroto3/totalgames)*100#,
#(ftmnegFourto6/totalgames)*100#,
#(ftmnegSevento9/totalgames)*100#,
#(ftmnegTento12/totalgames)*100#,
#(ftmnegThirteento15/totalgames)*100#,
#(ftmnegGreater16/totalgames)*100#
)
</cfquery>
<cfelse>
No data found for #GetTeams.Team#
</cfif>



</cfoutput>



<!-- Create Predicted ranges based on teams offense and defense -->


<cfquery name="GetGames" datasource="nba">
Select * from nbaschedule where gametime='#mygametime#'
</cfquery>

<cfloop query="Getgames">

<cfset Fav = '#fav#'>
<cfset Und = '#und#'>
<cfset favha = '#Ha#'>

<cfif favha is 'H'>
	<cfset undha = 'A'>
<cfelse>
	<cfset undha = 'H'>
</cfif>


<cfquery datasource="nba" name="FGpctsfav">
Select Avg(ofgpct) as avofgpct, Avg(dfgpct) as avdfgpct
from nbadata
where team in ('#GetGames.fav#')
</cfquery>

<cfquery datasource="nba" name="FGpctsund">
Select Avg(ofgpct) as avofgpct, Avg(dfgpct) as avdfgpct
from nbadata
where team in ('#GetGames.und#')
</cfquery>

<cfset FavOfgpct = FGpctsfav.avofgpct>
<cfset UndOfgpct = FGpctsund.avofgpct>

<cfset Favdfgpct = FGpctsfav.avdfgpct>
<cfset Unddfgpct = FGpctsund.avdfgpct>


<cfset FavPredFGpct = (FavOfgpct + Unddfgpct)/2>
<cfset UndPredFGpct = (Favdfgpct + UndOfgpct)/2>  


<cfquery datasource="nba" name="addit">
Select (f.fg03 + u.negfg03 )/2 as pfg03,
       (f.fg46 + u.negfg46 )/2 as pfg46,
	   (f.fg79 + u.negfg79 )/2 as pfg79,
	   (f.fg1012 + u.negfg1012)/2 as pfg1012,
	   (f.fg1315 + u.negfg1315 )/2 as pfg1315,
	   (f.fg16plus + u.negfg16Plus )/2 as pfg16plus,
	   f.team
	   
from Bigwinstatsoff f, BigwinstatsDef u
Where f.Team = '#fav#'
and   f.ha = '#favha#'
and u.Team = '#und#'
and u.ha = '#undha#'

</cfquery>

<table border='1' width="100%">
<tr>
<td width="5%">Team</td>
<td width="10%">Avg FGpct</td>
<td width="10%">FG 0-3</td>
<td width="10%">FG 4-6</td>
<td width="10%">FG 7-9</td>
<td width="10%">FG 10-12</td>
<td width="10%">FG 13-15</td>
<td width="10%">FG 16+</td>
<td width="10%">Total</td>
</tr>
<cfset favtot = 0>
<cfoutput query="Addit">
<cfset favtot = pFG03 + pFG46 + pFG79 + pFG1012 + pFG1315 + pFG16plus>
<cfset FavOffUse = FavTot>


<tr>
<td>#Team#</td>
<td>#FavOfgpct#</td>
<td>#pFG03#</td>
<td>#pFG46#</td>
<td>#pFG79#</td>
<td>#pFG1012#</td>
<td>#pFG1315#</td>
<td>#pFG16plus#</td>
<td>#favtot#</td>
</tr>
</cfoutput>

<cfset FavOffTot = favtot>

<cfquery datasource="nba" name="addit22">
Select (u.fg03 + f.negfg03 )/2 as upfg03,
       (u.fg46 + f.negfg46 )/2 as upfg46,
	   (u.fg79 + f.negfg79 )/2 as upfg79,
	   (u.fg1012 + f.negfg1012 )/2 as upfg1012,
	   (u.fg1315 + f.negfg1315 )/2 as upfg1315,
	   (u.fg16plus + f.negfg16Plus )/2 as upfg16plus,
	   u.team
	   
from Bigwinstatsoff u, BigwinstatsDef f
Where f.Team = '#fav#'
and   f.ha = '#favha#'
and u.Team = '#und#'
and u.ha = '#undha#'


</cfquery>
<cfset undtot = 0>
<cfoutput query="Addit22">
<cfset undtot = upFG03 + upFG46 + upFG79 + upFG1012 + upFG1315 + upFG16plus>
<cfset UndOffTot = undtot>
<cfset UndOffUse = UndOffTot>

<tr>
<td>#Team#</td>
<td>#UndOfgpct#</td>
<td>#upFG03#</td>
<td>#upFG46#</td>
<td>#upFG79#</td>
<td>#upFG1012#</td>
<td>#upFG1315#</td>
<td>#upFG16plus#</td>
<td>#undtot#</td>
</tr>
</cfoutput>
</table>

<cfset OverPlay = true>
<cfif favtot ge 60 and undtot ge 60>
	<cfset OverPlay = true>
</cfif>

<cfset UnderPlay = true>
<cfif favtot lt 50 and undtot lt 50>
	<cfset UnderPlay = true>
</cfif>



<!--- 
<cfif favtot ge 60>
	Update FinalPicks
	Set BigWinPick = '#fav#',
	BigWinRat      = #favtot - Undtot#
	BigWinRatio    = #(pFG79 + pFG1012 + pFG1315 + pFG16plus)/favtot)*100#
	Where gametime = '#mygametime#'
	and fav = '#fav' 
</cfif>


<cfif undtot ge 60>
	Update FinalPicks
	Set BigWinPick = '#*und#',
	BigWinRat      = #Undtot - favtot#
	BigWinRatio    = #(uFG79 + uFG1012 + uFG1315 + uFG16plus)/undtot)*100#
	Where gametime = '#mygametime#'
	and fav = '#fav' 
</cfif> --->


--------------------------------- Defense ------------------------------------------------------

<cfquery datasource="nba" name="FGpctsfav">
Select Avg(ofgpct) as avofgpct, Avg(dfgpct) as avdfgpct
from nbadata
where team in ('#GetGames.fav#')
</cfquery>

<cfquery datasource="nba" name="FGpctsund">
Select Avg(ofgpct) as avofgpct, Avg(dfgpct) as avdfgpct
from nbadata
where team in ('#GetGames.und#')
</cfquery>

<cfset Favdfgpct = FGpctsfav.avdfgpct>
<cfset Unddfgpct = FGpctsund.avdfgpct>


<cfset FavPredFGpct = (FavOfgpct + Unddfgpct)/2>
<cfset UndPredFGpct = (Favdfgpct + UndOfgpct)/2>  


<cfquery datasource="nba" name="addit">
Select (f.fg03 + u.negfg03 )/2 as pfg03,
       (f.fg46 + u.negfg46 )/2 as pfg46,
	   (f.fg79 + u.negfg79 )/2 as pfg79,
	   (f.fg1012 + u.negfg1012)/2 as pfg1012,
	   (f.fg1315 + u.negfg1315 )/2 as pfg1315,
	   (f.fg16plus + u.negfg16Plus )/2 as pfg16plus,
	   f.team
	   
from BigwinstatsDef f, BigwinstatsOff u
Where f.Team = '#fav#'
and   f.ha = '#favha#'
and u.Team = '#und#'
and u.ha = '#undha#'

</cfquery>
<table border="1" width="100%">
<tr>
<td width="5%">Team</td>
<td width="10%">Avg FGpct</td>
<td width="10%">FG 0-3</td>
<td width="10%">FG 4-6</td>
<td width="10%">FG 7-9</td>
<td width="10%">FG 10-12</td>
<td width="10%">FG 13-15</td>
<td width="10%">FG 16+</td>
<td width="10%">Total</td>
</tr>

<cfset favtot = 0>
<cfoutput query="Addit">
<cfset favtot = pFG03 + pFG46 + pFG79 + pFG1012 + pFG1315 + pFG16plus>
<cfset FavDefTot = favtot>

<tr>
<td>#Fav#</td>
<td>#Favdfgpct#</td>
<td>#pFG03#</td>
<td>#pFG46#</td>
<td>#pFG79#</td>
<td>#pFG1012#</td>
<td>#pFG1315#</td>
<td>#pFG16plus#</td>
<td>#favtot#</td>
</tr>
</cfoutput>

<cfquery datasource="nba" name="addit22">
Select (u.fg03 + f.negfg03 )/2 as upfg03,
       (u.fg46 + f.negfg46 )/2 as upfg46,
	   (u.fg79 + f.negfg79 )/2 as upfg79,
	   (u.fg1012 + f.negfg1012 )/2 as upfg1012,
	   (u.fg1315 + f.negfg1315 )/2 as upfg1315,
	   (u.fg16plus + f.negfg16Plus )/2 as upfg16plus,
	   u.team
	   
from BigwinstatsDef u, BigwinstatsOff f
Where f.Team = '#fav#'
and   f.ha = '#favha#'
and u.Team = '#und#'
and u.ha = '#undha#'


</cfquery>

<cfset undtot = 0>
<cfset UndDefTot = 0>
<cfset FavDefTot = 0>
<cfoutput query="Addit22">
<cfset undtot = upFG03 + upFG46 + upFG79 + upFG1012 + upFG1315 + upFG16plus>
<cfset UndDefTot = undtot>

<tr>
<td>#Und#</td>
<td>#Unddfgpct#</td>
<td>#upFG03#</td>
<td>#upFG46#</td>
<td>#upFG79#</td>
<td>#upFG1012#</td>
<td>#upFG1315#</td>
<td>#upFG16plus#</td>
<td>#undtot#</td>
</tr>
</cfoutput>

</table>
<cfoutput>

<cfset FavDefUse = FavDefTot>
<cfset UndDefUse = UndDefTot>

<cfset FavHigher = false>
<cfset FavLower = false>

<cfset UndHigher = false>
<cfset UndLower = false>

<cfset FinalFavPct = 0>
<cfset FinalUndPct = 0>

<!--- <cfoutput>
checking #FavOffUse# and #UndDefTot#<br>
</cfoutput>
 --->
<cfif FavOffUse ge 50 and (100 - UndDefTot ge 50)>
	<cfoutput>
	
	</cfoutput>
	<cfset FinalFavPct = (FavOffUse + (100 - UndDefTot))/2>
	<cfset FavHigher = true>
</cfif> 

<cfif UndOffUse ge 50 and (100 - FavDefTot ge 50)>
	<cfset FinalUndPct = (UndOffUse + (100 - FavDefTot))/2>
	<cfset UndHigher = true>
</cfif> 



<cfif FavOffUse le 50 and (UndDefTot ge 50)>
	<cfset FinalFavPct = (UndDefTot + (100 - FavOffUse))/2>
	<cfset FavLower = true>
</cfif> 

<cfif UndOffUse le 50 and (FavDefTot ge 50)>
	<cfset FinalUndPct = (FavDefTot + (100 - UndOffUse))/2>
	<cfset UndLower = true>
</cfif> 

<table border="1">
<tr>
<td>Team</td>
<td>Predicted FGPct</td>
<td>Predict Higher</td>
<td>Predict Lower</td>
<td>Predict Pct</td>
</tr>

<tr>
<td>#Fav#</td>
<td>#FavPredFGPct#</td>
<td>#FavHigher#</td>
<td>#FavLower#</td>
<td>#FinalFavPct#</td>
</tr>

<tr>
<td>#Und#</td>
<td>#UndPredFGPct#</td>
<td>#UndHigher#</td>
<td>#UndLower#</td>
<td>#FinalUndPct#</td>
</tr>
</table>
<p>

</cfoutput>


<cfif FavHigher is false>
	<cfset FinalFavPct = (-1*FinalFavPct)>
</cfif>

<cfif UndHigher is false>
	<cfset FinalUndPct = (-1*FinalUndPct)>
</cfif>


<cfoutput>
<cfquery datasource="nba">
Insert into PreGameProb
(
Gametime,
Fav,
Und,
ffgpct,
ufgpct
)
values
(
'#mygametime#',
'#fav#',
'#und#',
#FinalFavPct#,
#FinalUndPct#
)
</cfquery>
</cfoutput>



<!--- <cfif FavOffTot lt 50>
	<cfset FavOffUse = 100 - FavOffTot>
</cfif>
	
<cfif UndOffTot lt 50>
	<cfset UndOffUse = 100 - UndOffTot>
</cfif>

<cfif FavDefTot lt 50>
	<cfset FavDefUse = 100 - FavDefTot>
</cfif>
	
<cfif UndDefTot lt 50>
	<cfset UndDefUse = 100 - UndDefTot>
</cfif> --->

<!-- If Fav has better then 50% of scoring higher in fgpct and opp is higher then 50% in allowing more fgpct -->



<p>

<cfset DefOverPlay = false>
<cfif favtot lt 50 and undtot lt 50>
	<cfset DefOverPlay = true>
</cfif>

<cfset DefUnderPlay = false>
<cfif favtot gt 60 and undtot gt 60>
	<cfset DefUnderPlay = true>
</cfif>



<cfset PlayOver = false>
<cfif DefOverPlay is true and OverPlay is true>
	<cfset PlayOver = true>
</cfif>

<cfset PlayUnder = false>
<cfif DefUnderPlay is true and UnderPlay is true>
	<cfset PlayUnder = true>
</cfif>

<cfif PlayUnder is true>
	<cfquery datasource="nba">
	Update FinalPicks
	Set OverUnderPick = 'UNDER'
	Where gametime = '#mygametime#'
	and fav = '#fav#' 
	</cfquery>
</cfif>

<cfif PlayOver is true>
	<cfquery datasource="nba">
	Update FinalPicks
	Set OverUnderPick = 'OVER'
	Where gametime = '#mygametime#'
	and fav = '#fav#' 
	</cfquery>
</cfif>


<!--- 
<cfif favtot ge 60>
	Update FinalPicks
	Set BigWinPick = '#fav#',
	BigWinRat      = #favtot - Undtot#
	BigWinRatio    = #(pFG79 + pFG1012 + pFG1315 + pFG16plus)/favtot)*100#
	Where gametime = '#mygametime#'
	and fav = '#fav' 
</cfif>


<cfif undtot ge 60>
	Update FinalPicks
	Set BigWinPick = '#*und#',
	BigWinRat      = #Undtot - favtot#
	BigWinRatio    = #(uFG79 + uFG1012 + uFG1315 + uFG16plus)/undtot)*100#
	Where gametime = '#mygametime#'
	and fav = '#fav' 
</cfif> --->

</cfloop>

<cfinclude template="CreateBigWinStatstpm.cfm">
<cfinclude template="CreateBigWinStatsreb.cfm">
<cfinclude template="CreateBigWinStatsfga.cfm">
<cfinclude template="CreateBigWinStatsturnovers.cfm">
<cfinclude template="CreateBigWinStatsftm.cfm"> 	   	 

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('Ran CreateBiwWinStats.cfm')
</cfquery>


  
</body>
</html>
