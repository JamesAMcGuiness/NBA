
<cfif 1 is 2>
<cfquery datasource="NBA" name="xGetIt">
Update FinalPicks
Set SYS60B = '',
SYS60C = ''
</cfquery>
</cfif>








<cfquery datasource="NBA" name="GetIt">
Select fp.Gametime,fp.Fav,fp.spd,fp.und,fp.FAVAdv,fp.WhoCovered
From FinalPicks fp, NBAGametime gt
Where  FAVAdv > ''
and spd > 6
and gt.Gametime = fp.Gametime
</cfquery>



<cfset w = 0>
<cfset t = 0>
**********************************************************************<br>
Play On Underdogs where FAVADV is -30 or more getting 6 or more points<br>
**********************************************************************<br>
<cfoutput query="GetIt">
<cfif val(Getit.FavAdv) lt -29>

	<cfquery datasource="NBA" name="zzGetIt">
	Update FinalPicks
	Set SYS60C = '#Getit.Und#'
	where gametime = '#getit.gametime#'
	and fav = '#getit.fav#'
	</cfquery>

	<cfset t = t + 1>
	#Gametime#,#Fav#,#spd#,#und#,#FAVAdv#,#WhoCovered# <cfif WhoCovered neq '#fav#'>WINNER!<cfelse>Loser</cfif><br>
	
	<cfif WhoCovered neq '#fav#'>
		<cfset w = w + 1>
	</cfif>
</cfif>

</cfoutput>

<cfif 1 is 2>
Wins = <cfoutput>#w#...out of #t#.... #w/t#</cfoutput>
</cfif>


<p>


<cfquery datasource="NBA" name="GetIt">
Select fp.Gametime,fp.Fav,fp.spd,fp.und,fp.FAVAdv,fp.WhoCovered
From FinalPicks fp,NBAGametime gt
Where  FAVAdv > ''
and gt.gametime = Fp.gametime
and spd < 6 
</cfquery>

<cfdump var="#GetIt#">



<cfset w = 0>
<cfset t = 0>
**********************************************************************<br>
Play On Favorites where FAVADV is 40 or more laying 5 or less         <br>
**********************************************************************<br>
<cfoutput query="GetIt">
<cfif val(Getit.FavAdv) gt 39>
	<cfquery datasource="NBA" name="zzGetIt">
	Update FinalPicks
	Set SYS60B = '#Getit.Fav#'
	where gametime = '#getit.gametime#'
	and fav = '#getit.fav#'
	</cfquery>
	<cfset t = t + 1>
	#Gametime#,#Fav#,#spd#,#und#,#FAVAdv#,#WhoCovered# <cfif WhoCovered is '#fav#'>WINNER!<cfelse>Loser</cfif><br>
	
	<cfif WhoCovered neq '#und#'>
		<cfset w = w + 1>
	</cfif>
</cfif>

</cfoutput>

<cfif 1 is 2>
Wins = <cfoutput>#w#...out of #t#.... #w/t#</cfoutput>
</cfif>


<cfquery datasource="NBA" name="GetIt">
Select Team, AVG(PS) as aPS, AVG(DPS) as aDPS
From NbaData 
Group By Team
</cfquery>



<cfquery datasource="NBA" name="GetIt">
SELECT n.* , gt.gametime
from NBASchedule n, NBAGametime gt
where gt.Gametime = n.gametime
</cfquery>

<cfif 1 is 2>
<cfquery datasource="NBA" name="GetGames">
SELECT n.* 
from NBASchedule n
where n.gametime ='20200111'
</cfquery>
</cfif>

<cfoutput query="Getit">

<cfset Fav        = '#Getit.Fav#'>
<cfset Und        = '#GetIt.Und#'>
<cfset OU         = Getit.Ou>
<cfset FavPredPts = Getit.FavExpectedPts>
<cfset UndPredPts = Getit.UndExpectedPts>
<cfset Gametime   = '#GetIt.Gametime#'>
	<cfquery datasource="NBA" name="GetFAVGAP">
	Select *
	From GAP g
	WHERE g.Team = '#Fav#'
	</cfquery>

	<cfquery datasource="NBA" name="GetUndGAP">
	Select *
	From GAP g
	WHERE g.Team = '#Und#'
	</cfquery>



	<cfquery datasource="NBA" name="FAVGetOverGamesPS">
	Select distinct d.gametime,d.Team as tm, d.PS as PtsPS, d.DPS as PtsDPS, g.*
	From NbaData d, GAP g
	WHERE g.Team = d.opp
	and d.Team = '#fav#'
	and d.PS - d.dps > #FavPredPts - UndPredPts#
	
	order by d.gametime desc
	</cfquery>

	<cfquery datasource="NBA" name="UndGetOverGamesPS">
	Select distinct d.gametime,d.Team as tm, d.PS as PtsPS, d.DPS as PtsDPS, g.*
	From NbaData d, GAP g 
	WHERE g.Team = d.opp
	and d.Team = '#und#'
	and ((d.PS - d.dps > #UndPredPts - FavPredPts#) or (d.PS > d.dps ))
	
	order by d.gametime desc
	</cfquery>

	<cfquery datasource="NBA" name="FAVGetUnderGamesPS">
	Select distinct d.gametime,d.Team as tm, d.PS as PtsPS, d.DPS as PtsDPS, g.*
	From NbaData d, GAP g
	WHERE g.Team = d.opp
	and d.Team = '#fav#'
	and ( (d.PS - d.dps < #FavPredPts - UndPredPts#) or (d.dps > d.ps))
	
	order by d.gametime desc
	</cfquery>

	<cfquery datasource="NBA" name="UndGetUnderGamesPS">
	Select distinct d.gametime,d.Team as tm, d.PS as PtsPS, d.DPS as PtsDPS, g.*
	From NbaData d, GAP g
	WHERE g.Team = d.opp
	and d.Team = '#und#'
	and (d.PS - d.dps < #UndPredPts - FavPredPts#) 
	order by d.gametime desc
	</cfquery>
	
	
	
	
	
	
	<cfset gDPS = 0>
	<cfset avDPS = 0>
	<cfset pDPS = 0>

	<cfset gDFGPCT = 0>
	<cfset aDFGPCT = 0>
	<cfset pDFGPCT = 0>


	<cfset gdPIP = 0>
	<cfset adPIP = 0>
	<cfset pdPIP = 0>

	<cfset gRebounding = 0>
	<cfset aRebounding = 0>
	<cfset pRebounding = 0>

	<cfset gdtppct = 0>
	<cfset adtppct = 0>
	<cfset pdtppct = 0>


	
	<cfloop query = "FavGetOverGamesPS">


		
		<cfif dPS is 'G'>
			<cfset gDPS = gDPS + 1>
		<cfelseif dPS is 'A'>	
			<cfset avDPS = avDPS + 1>
		<cfelse>
			<cfset pDPS = pDPS + 1>
		</cfif>	
		
		
		<cfif dPIP is 'G'>
			<cfset gdPIP = gdPIP + 1>
		<cfelseif dPIP is 'A'>	
			<cfset adPIP = adPIP + 1>
		<cfelse>
			<cfset pdPIP = pdPIP + 1>
		</cfif>	
				
		
		<cfif dFGPCT is 'G'>
			<cfset gdFGPct = gdFGPct + 1>
		<cfelseif dFGPCT is 'A'>	
			<cfset adFGPct = adFGPct + 1>
		<cfelse>
			<cfset pdFGPct = pdFGPct + 1>
		</cfif>	
		
		
		<cfif dRebounding is 'G'>
			<cfset gRebounding = gRebounding + 1>
		<cfelseif dRebounding is 'A'>	
			<cfset aRebounding = aRebounding + 1>
		<cfelse>
			<cfset pRebounding = pRebounding + 1>
		</cfif>	
		
		
		<cfif dtppct is 'G'>
			<cfset gdtppct = gdtppct + 1>
		<cfelseif dtppct is 'A'>	
			<cfset adtppct = adtppct + 1>
		<cfelse>
			<cfset pdtppct = pdtppct + 1>
		</cfif>	
		
	</cfloop>	
	<p>	
	******************************************************************************************************************<br>	
	
	<cfquery datasource="NBA" name="FavAvScore">
	Select AVG(d.PS) as avPts
	From NbaData d
	WHERE d.opp IN (Select Team from GAP where dps = '#GetUndGAP.dps#')
	and d.Team = '#fav#'
	</cfquery>
	
	
	The average score for this type of DPS Opponent is... #FavAvScore.avpts#<br>
	
	
	<cfquery datasource="NBA" name="FavAvScore">
	Select AVG(d.dPS) as avPts
	From NbaData d
	WHERE d.opp IN (Select Team from GAP where dps = '#GetUndGAP.ops#')
	and d.Team = '#fav#'
	</cfquery>
	
	
	The average score Given UP for this type of PS Opponent is... #FavAvScore.avpts#<br>



	<cfquery datasource="NBA" name="FavAvScore">
	Select AVG(d.PS) as avPts
	From NbaData d
	WHERE d.opp IN (Select Team from GAP where dps = '#GetUndGAP.dfgpct#')
	and d.Team = '#fav#'
	</cfquery>
		
	The average score for this type of DFGPCT Opponent is... #FavAvScore.avpts#<br>
	
	
	<cfquery datasource="NBA" name="FavAvScore">
	Select AVG(d.dPS) as avPts
	From NbaData d
	WHERE d.opp IN (Select Team from GAP where dps = '#GetUndGAP.ofgpct#')
	and d.Team = '#fav#'
	</cfquery>
		
	The average score Given UP for this type of FGPct Opponent is... #FavAvScore.avpts#<br>






	
	For #Fav# to cover the spread of #FavPredPts - UndPredPts#...Overall they cover the spread #FavGetOverGamesPS.recordcount/(FavGetOverGamesPS.recordcount+FavGetUnderGamesPS.recordcount)#<br>	
	Good DPS: #gDPS/FavGetOverGamesPS.recordcount#.......opp value is #GetUndGAP.dps#	<br>
	Avg DPS: #avDPS/FavGetOverGamesPS.recordcount#	<br>
	Poor DPS: #pDPS/FavGetOverGamesPS.recordcount#	<br>
	<p>
	Good PIP: #gdPIP/FavGetOverGamesPS.recordcount#	.......opp value is #GetUndGAP.dpip#	<br>
	Avg PIP: #adPIP/FavGetOverGamesPS.recordcount#	<br>
	Poor PIP: #pdPIP/FavGetOverGamesPS.recordcount#	<br>
	<p>
	Good dFGPCT: #gdFGPct/FavGetOverGamesPS.recordcount# .......opp value is #GetUndGAP.dFGPCT#	<br>
	Avg dFGPCT: #adFGPct/FavGetOverGamesPS.recordcount#	<br>
	Poor dFGPCT: #pdFGPct/FavGetOverGamesPS.recordcount#	<br>
	<p>
	Good Rebounding: #gRebounding/FavGetOverGamesPS.recordcount# .......opp value is #GetUndGAP.dRebounding#	<br>
	Avg Rebounding: #aRebounding/FavGetOverGamesPS.recordcount#	<br>
	Poor Rebounding: #pRebounding/FavGetOverGamesPS.recordcount#	<br>
	<p>
	Good dtppct: #gdtppct/FavGetOverGamesPS.recordcount#	.......opp value is #GetUndGAP.dtpPCT#	<br>
	Avg dtppct: #adtppct/FavGetOverGamesPS.recordcount#	<br>
	Poor dtppct: #pdtppct/FavGetOverGamesPS.recordcount#	<br>
	<p>
	<p>
	
	<cfset favtotpct = 0>
	<cfset undtotpct = 0>
	
	<cfif '#GetUndGAP.dps#' is 'P'>
		<cfset favtotpct = pDPS/FavGetOverGamesPS.recordcount>
	<cfelseif 	'#GetUndGAP.dps#' is 'A'>
		<cfset favtotpct = (pDPS/FavGetOverGamesPS.recordcount) + (avDPS/FavGetOverGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = gDPS/FavGetOverGamesPS.recordcount>
	</cfif>
	
	<cfif '#GetUndGAP.dpip#' is 'P'>
		<cfset favtotpct = favtotpct + (pDPIP/FavGetOverGamesPS.recordcount)>
	<cfelseif 	'#GetUndGAP.dpip#' is 'A'>
		<cfset favtotpct = favtotpct + (pDpip/FavGetOverGamesPS.recordcount) + (aDPIP/FavGetOverGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = favtotpct + (gDPIP/FavGetOverGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetUndGAP.dfgpct#' is 'P'>
		<cfset favtotpct = favtotpct + (pDfgpct/FavGetOverGamesPS.recordcount)>
	<cfelseif 	'#GetUndGAP.dfgpct#' is 'A'>
		<cfset favtotpct = favtotpct + (pDfgpct/FavGetOverGamesPS.recordcount) + (aDfgpct/FavGetOverGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = favtotpct + (gDfgpct/FavGetOverGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetUndGAP.drebounding#' is 'P'>
		<cfset favtotpct = favtotpct + (prebounding/FavGetOverGamesPS.recordcount)>
	<cfelseif 	'#GetUndGAP.drebounding#' is 'A'>
		<cfset favtotpct = favtotpct + (prebounding/FavGetOverGamesPS.recordcount) + (arebounding/FavGetOverGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = favtotpct + (grebounding/FavGetOverGamesPS.recordcount)>
	</cfif>
	
	
	<cfif '#GetUndGAP.dtppct#' is 'P'>
		<cfset favtotpct = favtotpct + (pdtppct/FavGetOverGamesPS.recordcount)>
	<cfelseif 	'#GetUndGAP.dtppct#' is 'A'>
		<cfset favtotpct = favtotpct + (pdtppct/FavGetOverGamesPS.recordcount) + (adtppct/FavGetOverGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = favtotpct + (gdtppct/FavGetOverGamesPS.recordcount)>
	</cfif>
	<p>
	The Total percent in FAVOR of covering is #FavTotPct/5#<br>

	<cfset FavFinal = 0>
	<cfset UndFinal = 0>


	<cfset FavFinal = FavFinal + (FavTotPct/5)>
	
	******************************************************************************************************************<br>


	<cfset gDPS = 0>
	<cfset avDPS = 0>
	<cfset pDPS = 0>

	<cfset gDFGPCT = 0>
	<cfset aDFGPCT = 0>
	<cfset pDFGPCT = 0>


	<cfset gdPIP = 0>
	<cfset adPIP = 0>
	<cfset pdPIP = 0>

	<cfset gRebounding = 0>
	<cfset aRebounding = 0>
	<cfset pRebounding = 0>

	<cfset gdtppct = 0>
	<cfset adtppct = 0>
	<cfset pdtppct = 0>


	<cfloop query = "UndGetOverGamesPS">


		
		<cfif dPS is 'G'>
			<cfset gDPS = gDPS + 1>
		<cfelseif dPS is 'A'>	
			<cfset avDPS = avDPS + 1>
		<cfelse>
			<cfset pDPS = pDPS + 1>
		</cfif>	
		
		
		<cfif dPIP is 'G'>
			<cfset gdPIP = gdPIP + 1>
		<cfelseif dPIP is 'A'>	
			<cfset adPIP = adPIP + 1>
		<cfelse>
			<cfset pdPIP = pdPIP + 1>
		</cfif>	
				
		
		<cfif dFGPCT is 'G'>
			<cfset gdFGPct = gdFGPct + 1>
		<cfelseif dFGPCT is 'A'>	
			<cfset adFGPct = adFGPct + 1>
		<cfelse>
			<cfset pdFGPct = pdFGPct + 1>
		</cfif>	
		
		
		<cfif dRebounding is 'G'>
			<cfset gRebounding = gRebounding + 1>
		<cfelseif dRebounding is 'A'>	
			<cfset aRebounding = aRebounding + 1>
		<cfelse>
			<cfset pRebounding = pRebounding + 1>
		</cfif>	
		
		
		<cfif dtppct is 'G'>
			<cfset gdtppct = gdtppct + 1>
		<cfelseif dtppct is 'A'>	
			<cfset adtppct = adtppct + 1>
		<cfelse>
			<cfset pdtppct = pdtppct + 1>
		</cfif>	
		
	</cfloop>	
	<p>	
	
	<cfquery datasource="NBA" name="UndAvScore">
	Select AVG(d.PS) as avPts
	From NbaData d
	WHERE d.Team IN (Select Team from GAP where dps = '#GetFavGAP.dps#')
	and d.opp = '#und#'
	</cfquery>
	
	
	The average score for this type of DPS Opponent is... #UndAvScore.avpts#<br>
	
	
	<cfquery datasource="NBA" name="UndAvScore">
	Select AVG(d.dPS) as avPts
	From NbaData d
	WHERE d.Team IN (Select Team from GAP where dps = '#GetFavGAP.ops#')
	and d.opp = '#und#'
	</cfquery>
	
	
	The average score given UP for this type of PS Opponent is... #UndAvScore.avpts#<br>
	
	
	<cfquery datasource="NBA" name="FavAvScore">
	Select AVG(d.PS) as avPts
	From NbaData d
	WHERE d.opp IN (Select Team from GAP where dps = '#GetFavGAP.dfgpct#')
	and d.Team = '#und#'
	</cfquery>
		
	The average score for this type of DFGPCT Opponent is... #FavAvScore.avpts#<br>
	
	
	<cfquery datasource="NBA" name="FavAvScore">
	Select AVG(d.dPS) as avPts
	From NbaData d
	WHERE d.opp IN (Select Team from GAP where dps = '#GetFavGAP.ofgpct#')
	and d.Team = '#und#'
	</cfquery>
		
	The average score Given UP for this type of FGPct Opponent is... #FavAvScore.avpts#<br>

	
	
	******************************************************************************************************************<br>	
	For #Und# to cover the spread of #FavPredPts - UndPredPts# Overall they cover the spread #UndGetOverGamesPS.recordcount/(UndGetOverGamesPS.recordcount+UndGetUnderGamesPS.recordcount)#<br>		
	Good DPS: #gDPS/UndGetOverGamesPS.recordcount#	.......opp value is #GetFAVGAP.dps#	<br>
	Avg DPS: #avDPS/UndGetOverGamesPS.recordcount#	<br>
	Poor DPS: #pDPS/UndGetOverGamesPS.recordcount#	<br>
	<p>
	Good PIP: #gdPIP/UndGetOverGamesPS.recordcount#	.......opp value is #GetFAVGAP.dPIP#	<br>
	Avg PIP: #adPIP/UndGetOverGamesPS.recordcount#	<br>
	Poor PIP: #pdPIP/UndGetOverGamesPS.recordcount#	<br>
	<p>
	Good dFGPCT: #gdFGPct/UndGetOverGamesPS.recordcount#	.......opp value is #GetFAVGAP.dfgpct#	<br>
	Avg dFGPCT: #adFGPct/UndGetOverGamesPS.recordcount#	<br>
	Poor dFGPCT: #pdFGPct/UndGetOverGamesPS.recordcount#	<br>
	<p>
	Good Rebounding: #gRebounding/UndGetOverGamesPS.recordcount#	.......opp value is #GetFAVGAP.dRebounding#	<br>
	Avg Rebounding: #aRebounding/UndGetOverGamesPS.recordcount#	<br>
	Poor Rebounding: #pRebounding/UndGetOverGamesPS.recordcount#	<br>
	<p>
	Good dtppct: #gdtppct/UndGetOverGamesPS.recordcount#	.......opp value is #GetFAVGAP.dtppct#	<br>
	Avg dtppct: #adtppct/UndGetOverGamesPS.recordcount#	<br>
	Poor dtppct: #pdtppct/UndGetOverGamesPS.recordcount#	<br>
	<p>
	<p>
	
	<cfset favtotpct = 0>
	<cfset undtotpct = 0>	
		
		
	<cfif '#GetFavGAP.dps#' is 'P'>
		<cfset undtotpct = (pDPS/undgetOverGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.dps#' is 'A'>
		<cfset undtotpct = (pDPS/undgetOverGamesPS.recordcount) + (avDPS/undgetOverGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = (gDPS/undgetOverGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetFavGAP.dpip#' is 'P'>
		<cfset undtotpct = undtotpct + (pDPIP/undgetOverGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.dpip#' is 'A'>
		<cfset undtotpct = undtotpct + (pDpip/undgetOverGamesPS.recordcount) + (aDPIP/undgetOverGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = undtotpct + (gDPIP/undgetOverGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetFavGAP.dfgpct#' is 'P'>
		<cfset undtotpct = undtotpct + (pDfgpct/undgetOverGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.dfgpct#' is 'A'>
		<cfset undtotpct = undtotpct + (pDfgpct/undgetOverGamesPS.recordcount) + (aDfgpct/undgetOverGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = undtotpct + (gDfgpct/undgetOverGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetFavGAP.drebounding#' is 'P'>
		<cfset undtotpct = undtotpct + (prebounding/undgetOverGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.drebounding#' is 'A'>
		<cfset undtotpct = undtotpct + (prebounding/undgetOverGamesPS.recordcount) + (arebounding/undgetOverGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = undtotpct + (grebounding/undgetOverGamesPS.recordcount)>
	</cfif>
	
	
	<cfif '#GetFavGAP.dtppct#' is 'P'>
		<cfset undtotpct = undtotpct + (pdtppct/undgetOverGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.dtppct#' is 'A'>
		<cfset undtotpct = undtotpct + (pdtppct/undgetOverGamesPS.recordcount) + (adtppct/undgetOverGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = undtotpct + (gdtppct/undgetOverGamesPS.recordcount)>
	</cfif>
	<p>
	The Total percent in undOR of covering is #undTotPct/5#<br>

	<cfset UndFinal = UndFinal + (undTotPct/5)>
	
	
	******************************************************************************************************************<br>




















	






	
	<cfset gDPS = 0>
	<cfset avDPS = 0>
	<cfset pDPS = 0>

	<cfset gDFGPCT = 0>
	<cfset aDFGPCT = 0>
	<cfset pDFGPCT = 0>


	<cfset gdPIP = 0>
	<cfset adPIP = 0>
	<cfset pdPIP = 0>

	<cfset gRebounding = 0>
	<cfset aRebounding = 0>
	<cfset pRebounding = 0>

	<cfset gdtppct = 0>
	<cfset adtppct = 0>
	<cfset pdtppct = 0>


	
	<cfloop query = "FavGetUnderGamesPS">


		
		<cfif dPS is 'G'>
			<cfset gDPS = gDPS + 1>
		<cfelseif dPS is 'A'>	
			<cfset avDPS = avDPS + 1>
		<cfelse>
			<cfset pDPS = pDPS + 1>
		</cfif>	
		
		
		<cfif dPIP is 'G'>
			<cfset gdPIP = gdPIP + 1>
		<cfelseif dPIP is 'A'>	
			<cfset adPIP = adPIP + 1>
		<cfelse>
			<cfset pdPIP = pdPIP + 1>
		</cfif>	
				
		
		<cfif dFGPCT is 'G'>
			<cfset gdFGPct = gdFGPct + 1>
		<cfelseif dFGPCT is 'A'>	
			<cfset adFGPct = adFGPct + 1>
		<cfelse>
			<cfset pdFGPct = pdFGPct + 1>
		</cfif>	
		
		
		<cfif dRebounding is 'G'>
			<cfset gRebounding = gRebounding + 1>
		<cfelseif dRebounding is 'A'>	
			<cfset aRebounding = aRebounding + 1>
		<cfelse>
			<cfset pRebounding = pRebounding + 1>
		</cfif>	
		
		
		<cfif dtppct is 'G'>
			<cfset gdtppct = gdtppct + 1>
		<cfelseif dtppct is 'A'>	
			<cfset adtppct = adtppct + 1>
		<cfelse>
			<cfset pdtppct = pdtppct + 1>
		</cfif>	
		
	</cfloop>	
	<p>	
	******************************************************************************************************************<br>	
	For #Fav# NOT to cover the spread of #FavPredPts - UndPredPts#<br>		
	Good DPS: #gDPS/FavGetUnderGamesPS.recordcount#	.......opp value is #GetUNDGAP.DPS#	<br>
	Avg DPS: #avDPS/FavGetUnderGamesPS.recordcount#	<br>
	Poor DPS: #pDPS/FavGetUnderGamesPS.recordcount#	<br>
	<p>
	Good PIP: #gdPIP/FavGetUnderGamesPS.recordcount#.......opp value is #GetUNDGAP.DPIP#	<br>
	Avg PIP: #adPIP/FavGetUnderGamesPS.recordcount#	<br>
	Poor PIP: #pdPIP/FavGetUnderGamesPS.recordcount#	<br>
	<p>
	Good dFGPCT: #gdFGPct/FavGetUnderGamesPS.recordcount#	.......opp value is #GetUNDGAP.DFGPCT#	<br>
	Avg dFGPCT: #adFGPct/FavGetUnderGamesPS.recordcount#	<br>
	Poor dFGPCT: #pdFGPct/FavGetUnderGamesPS.recordcount#	<br>
	<p>
	Good Rebounding: #gRebounding/FavGetUnderGamesPS.recordcount#	.......opp value is #GetUNDGAP.DRebounding#	<br>
	Avg Rebounding: #aRebounding/FavGetUnderGamesPS.recordcount#	<br>
	Poor Rebounding: #pRebounding/FavGetUnderGamesPS.recordcount#	<br>
	<p>
	Good dtppct: #gdtppct/FavGetUnderGamesPS.recordcount#	.......opp value is #GetUNDGAP.Dtppct#	<br>
	Avg dtppct: #adtppct/FavGetUnderGamesPS.recordcount#	<br>
	Poor dtppct: #pdtppct/FavGetUnderGamesPS.recordcount#	<br>
	<p>
	<p>
	
	<cfset favtotpct = 0>
	<cfset undtotpct = 0>
	
	<cfif '#GetUndGAP.dps#' is 'P'>
		<cfset favtotpct = pDPS/FavGetUnderGamesPS.recordcount>
	<cfelseif 	'#GetUndGAP.dps#' is 'A'>
		<cfset favtotpct = (pDPS/FavGetUnderGamesPS.recordcount) + (avDPS/FavGetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = gDPS/FavGetUnderGamesPS.recordcount>
	</cfif>
	
	<cfif '#GetUndGAP.dpip#' is 'P'>
		<cfset favtotpct = favtotpct + (pDPIP/FavGetUnderGamesPS.recordcount)>
	<cfelseif 	'#GetUndGAP.dpip#' is 'A'>
		<cfset favtotpct = favtotpct + (pDpip/FavGetUnderGamesPS.recordcount) + (aDPIP/FavGetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = favtotpct + (gDPIP/FavGetUnderGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetUndGAP.dfgpct#' is 'P'>
		<cfset favtotpct = favtotpct + (pDfgpct/FavGetUnderGamesPS.recordcount)>
	<cfelseif 	'#GetUndGAP.dfgpct#' is 'A'>
		<cfset favtotpct = favtotpct + (pDfgpct/FavGetUnderGamesPS.recordcount) + (aDfgpct/FavGetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = favtotpct + (gDfgpct/FavGetUnderGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetUndGAP.drebounding#' is 'P'>
		<cfset favtotpct = favtotpct + (prebounding/FavGetUnderGamesPS.recordcount)>
	<cfelseif 	'#GetUndGAP.drebounding#' is 'A'>
		<cfset favtotpct = favtotpct + (prebounding/FavGetUnderGamesPS.recordcount) + (arebounding/FavGetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = favtotpct + (grebounding/FavGetUnderGamesPS.recordcount)>
	</cfif>
	
	
	<cfif '#GetUndGAP.dtppct#' is 'P'>
		<cfset favtotpct = favtotpct + (pdtppct/FavGetUnderGamesPS.recordcount)>
	<cfelseif 	'#GetUndGAP.dtppct#' is 'A'>
		<cfset favtotpct = favtotpct + (pdtppct/FavGetUnderGamesPS.recordcount) + (adtppct/FavGetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = favtotpct + (gdtppct/FavGetUnderGamesPS.recordcount)>
	</cfif>
	<p>
	The Total percent in FAVOR of NOT covering is #FavTotPct/5#<br>

	<cfset FavFinal = FavFinal - (FavTotPct/5)>

	
	******************************************************************************************************************<br>


	<cfset gDPS = 0>
	<cfset avDPS = 0>
	<cfset pDPS = 0>

	<cfset gDFGPCT = 0>
	<cfset aDFGPCT = 0>
	<cfset pDFGPCT = 0>


	<cfset gdPIP = 0>
	<cfset adPIP = 0>
	<cfset pdPIP = 0>

	<cfset gRebounding = 0>
	<cfset aRebounding = 0>
	<cfset pRebounding = 0>

	<cfset gdtppct = 0>
	<cfset adtppct = 0>
	<cfset pdtppct = 0>


	<cfloop query = "UndGetUnderGamesPS">


		
		<cfif dPS is 'G'>
			<cfset gDPS = gDPS + 1>
		<cfelseif dPS is 'A'>	
			<cfset avDPS = avDPS + 1>
		<cfelse>
			<cfset pDPS = pDPS + 1>
		</cfif>	
		
		
		<cfif dPIP is 'G'>
			<cfset gdPIP = gdPIP + 1>
		<cfelseif dPIP is 'A'>	
			<cfset adPIP = adPIP + 1>
		<cfelse>
			<cfset pdPIP = pdPIP + 1>
		</cfif>	
				
		
		<cfif dFGPCT is 'G'>
			<cfset gdFGPct = gdFGPct + 1>
		<cfelseif dFGPct is 'A'>	
			<cfset adFGPct = adFGPct + 1>
		<cfelse>
			<cfset pdFGPct = pdFGPct + 1>
		</cfif>	
		
		
		<cfif dRebounding is 'G'>
			<cfset gRebounding = gRebounding + 1>
		<cfelseif dRebounding is 'A'>	
			<cfset aRebounding = aRebounding + 1>
		<cfelse>
			<cfset pRebounding = pRebounding + 1>
		</cfif>	
		
		
		<cfif dtppct is 'G'>
			<cfset gdtppct = gdtppct + 1>
		<cfelseif dtppct is 'A'>	
			<cfset adtppct = adtppct + 1>
		<cfelse>
			<cfset pdtppct = pdtppct + 1>
		</cfif>	
		
	</cfloop>	
	<p>	
	******************************************************************************************************************<br>	
	For #Und# NOT to cover the spread of #FavPredPts - UndPredPts#<br>		
	Good DPS: #gDPS/UndGetUnderGamesPS.recordcount#	.......opp value is #GetFAVGAP.DPS#	<br>
	Avg DPS: #avDPS/UndGetUnderGamesPS.recordcount#	<br>
	Poor DPS: #pDPS/UndGetUnderGamesPS.recordcount#	<br>
	<p>
	Good PIP: #gdPIP/UndGetUnderGamesPS.recordcount#	.......opp value is #GetFAVGAP.DPIP#	<br>
	Avg PIP: #adPIP/UndGetUnderGamesPS.recordcount#	<br>
	Poor PIP: #pdPIP/UndGetUnderGamesPS.recordcount#	<br>
	<p>
	Good dFGPCT: #gdFGPct/UndGetUnderGamesPS.recordcount#	.......opp value is #GetFAVGAP.DFGPCT#	<br>
	Avg dFGPCT: #adFGPct/UndGetUnderGamesPS.recordcount#	<br>
	Poor dFGPCT: #pdFGPct/UndGetUnderGamesPS.recordcount#	<br>
	<p>
	Good Rebounding: #gRebounding/UndGetUnderGamesPS.recordcount#	.......opp value is #GetFAVGAP.DRebounding#	<br>
	Avg Rebounding: #aRebounding/UndGetUnderGamesPS.recordcount#	<br>
	Poor Rebounding: #pRebounding/UndGetUnderGamesPS.recordcount#	<br>
	<p>
	Good dtppct: #gdtppct/UndGetUnderGamesPS.recordcount#	.......opp value is #GetFAVGAP.Dtppct#	<br>
	Avg dtppct: #adtppct/UndGetUnderGamesPS.recordcount#	<br>
	Poor dtppct: #pdtppct/UndGetUnderGamesPS.recordcount#	<br>
	<p>
	<p>

	<cfset favtotpct = 0>
	<cfset undtotpct = 0>


	<cfif '#GetFavGAP.dps#' is 'P'>
		<cfset undtotpct = (pDPS/undgetUnderGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.dps#' is 'A'>
		<cfset undtotpct = (pDPS/undgetUnderGamesPS.recordcount) + (avDPS/undgetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = (gDPS/undgetUnderGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetFavGAP.dpip#' is 'P'>
		<cfset undtotpct = undtotpct + (pDPIP/undgetUnderGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.dpip#' is 'A'>
		<cfset undtotpct = undtotpct + (pDpip/undgetUnderGamesPS.recordcount) + (aDPIP/undgetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = undtotpct + (gDPIP/undgetUnderGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetFavGAP.dfgpct#' is 'P'>
		<cfset undtotpct = undtotpct + (pDfgpct/undgetUnderGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.dfgpct#' is 'A'>
		<cfset undtotpct = undtotpct + (pDfgpct/undgetUnderGamesPS.recordcount) + (aDfgpct/undgetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = undtotpct + (gDfgpct/undgetUnderGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetFavGAP.drebounding#' is 'P'>
		<cfset undtotpct = undtotpct + (prebounding/undgetUnderGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.drebounding#' is 'A'>
		<cfset undtotpct = undtotpct + (prebounding/undgetUnderGamesPS.recordcount) + (arebounding/undgetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = undtotpct + (grebounding/undgetUnderGamesPS.recordcount)>
	</cfif>
	
	
	<cfif '#GetFavGAP.dtppct#' is 'P'>
		<cfset undtotpct = undtotpct + (pdtppct/undgetUnderGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.dtppct#' is 'A'>
		<cfset undtotpct = undtotpct + (pdtppct/undgetUnderGamesPS.recordcount) + (adtppct/undgetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = undtotpct + (gdtppct/undgetUnderGamesPS.recordcount)>
	</cfif>
	<p>
	The Total percent in undOR of NOT cUndering is #undTotPct/5#<br>

	<cfset UndFinal = UndFinal - (UndTotPct/5)>

	******************************************************************************************************************<br>
















<P>
<p>
<p>







***************************************** What Type Of Offense teams *********************************************************<br>


	























	
	
	
	<cfset gDPS = 0>
	<cfset avDPS = 0>
	<cfset pDPS = 0>

	<cfset gDFGPCT = 0>
	<cfset aDFGPCT = 0>
	<cfset pDFGPCT = 0>


	<cfset gdPIP = 0>
	<cfset adPIP = 0>
	<cfset pdPIP = 0>

	<cfset gRebounding = 0>
	<cfset aRebounding = 0>
	<cfset pRebounding = 0>

	<cfset gdtppct = 0>
	<cfset adtppct = 0>
	<cfset pdtppct = 0>


	
	<cfloop query = "FavGetOverGamesPS">


		
		<cfif oPS is 'G'>
			<cfset gDPS = gDPS + 1>
		<cfelseif oPS is 'A'>	
			<cfset avDPS = avDPS + 1>
		<cfelse>
			<cfset pDPS = pDPS + 1>
		</cfif>	
		
		
		<cfif oPIP is 'G'>
			<cfset gdPIP = gdPIP + 1>
		<cfelseif oPIP is 'A'>	
			<cfset adPIP = adPIP + 1>
		<cfelse>
			<cfset pdPIP = pdPIP + 1>
		</cfif>	
				
		
		<cfif oFGPCT is 'G'>
			<cfset gdFGPct = gdFGPct + 1>
		<cfelseif oFGPCT is 'A'>	
			<cfset adFGPct = adFGPct + 1>
		<cfelse>
			<cfset pdFGPct = pdFGPct + 1>
		</cfif>	
		
		
		<cfif oRebounding is 'G'>
			<cfset gRebounding = gRebounding + 1>
		<cfelseif oRebounding is 'A'>	
			<cfset aRebounding = aRebounding + 1>
		<cfelse>
			<cfset pRebounding = pRebounding + 1>
		</cfif>	
		
		 
		<cfif otppct is 'G'>
			<cfset gdtppct = gdtppct + 1>
		<cfelseif otppct is 'A'>	
			<cfset adtppct = adtppct + 1>
		<cfelse>
			<cfset pdtppct = pdtppct + 1>
		</cfif>	
		
	</cfloop>	
	<p>	
	******************************************************************************************************************<br>	
	For #Fav# to cover the spread of #FavPredPts - UndPredPts#...Overall they cover the spread #FavGetOverGamesPS.recordcount/(FavGetOverGamesPS.recordcount+FavGetUnderGamesPS.recordcount)#<br>	
	Good PS: #gDPS/FavGetOverGamesPS.recordcount#	.......opp value is #GetUNDGAP.oPS#	<br>
	Avg  PS: #avDPS/FavGetOverGamesPS.recordcount#	<br>
	Poor PS: #pDPS/FavGetOverGamesPS.recordcount#	<br>
	<p>
	Good PIP: #gdPIP/FavGetOverGamesPS.recordcount#	.......opp value is #GetUNDGAP.oPIP#	<br>
	Avg  PIP: #adPIP/FavGetOverGamesPS.recordcount#	<br>
	Poor PIP: #pdPIP/FavGetOverGamesPS.recordcount#	<br>
	<p>
	Good FGPCT: #gdFGPct/FavGetOverGamesPS.recordcount#	.......opp value is #GetUNDGAP.oFGPCT#	<br>
	Avg  FGPCT: #adFGPct/FavGetOverGamesPS.recordcount#	<br>
	Poor FGPCT: #pdFGPct/FavGetOverGamesPS.recordcount#	<br>
	<p>
	Good Rebounding: #gRebounding/FavGetOverGamesPS.recordcount#	.......opp value is #GetUNDGAP.oRebounding#	<br>
	Avg  Rebounding: #aRebounding/FavGetOverGamesPS.recordcount#	<br>
	Poor Rebounding: #pRebounding/FavGetOverGamesPS.recordcount#	<br>
	<p>
	Good tppct: #gdtppct/FavGetOverGamesPS.recordcount#	.......opp value is #GetUNDGAP.oTppct#	<br>
	Avg  tppct: #adtppct/FavGetOverGamesPS.recordcount#	<br>
	Poor tppct: #pdtppct/FavGetOverGamesPS.recordcount#	<br>
	<p>
	<p>
	<cfset favtotpct = 0>
	<cfset undtotpct = 0>
	
	<cfif '#GetUndGAP.dps#' is 'P'>
		<cfset favtotpct = pDPS/FavGetOverGamesPS.recordcount>
	<cfelseif 	'#GetUndGAP.dps#' is 'A'>
		<cfset favtotpct = (pDPS/FavGetOverGamesPS.recordcount) + (avDPS/FavGetOverGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = gDPS/FavGetOverGamesPS.recordcount>
	</cfif>
	
	<cfif '#GetUndGAP.dpip#' is 'P'>
		<cfset favtotpct = favtotpct + (pDPIP/FavGetOverGamesPS.recordcount)>
	<cfelseif 	'#GetUndGAP.dpip#' is 'A'>
		<cfset favtotpct = favtotpct + (pDpip/FavGetOverGamesPS.recordcount) + (aDPIP/FavGetOverGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = favtotpct + (gDPIP/FavGetOverGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetUndGAP.dfgpct#' is 'P'>
		<cfset favtotpct = favtotpct + (pDfgpct/FavGetOverGamesPS.recordcount)>
	<cfelseif 	'#GetUndGAP.dfgpct#' is 'A'>
		<cfset favtotpct = favtotpct + (pDfgpct/FavGetOverGamesPS.recordcount) + (aDfgpct/FavGetOverGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = favtotpct + (gDfgpct/FavGetOverGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetUndGAP.drebounding#' is 'P'>
		<cfset favtotpct = favtotpct + (prebounding/FavGetOverGamesPS.recordcount)>
	<cfelseif 	'#GetUndGAP.drebounding#' is 'A'>
		<cfset favtotpct = favtotpct + (prebounding/FavGetOverGamesPS.recordcount) + (arebounding/FavGetOverGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = favtotpct + (grebounding/FavGetOverGamesPS.recordcount)>
	</cfif>
	
	
	<cfif '#GetUndGAP.dtppct#' is 'P'>
		<cfset favtotpct = favtotpct + (pdtppct/FavGetOverGamesPS.recordcount)>
	<cfelseif 	'#GetUndGAP.dtppct#' is 'A'>
		<cfset favtotpct = favtotpct + (pdtppct/FavGetOverGamesPS.recordcount) + (adtppct/FavGetOverGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = favtotpct + (gdtppct/FavGetOverGamesPS.recordcount)>
	</cfif>
	<p>
	The Total percent in FAVOR of covering is #FavTotPct/5#<br>

	<cfset FavFinal = FavFinal + (FavTotPct/5)>
	
	
	******************************************************************************************************************<br>


	<cfset gDPS = 0>
	<cfset avDPS = 0>
	<cfset pDPS = 0>

	<cfset gDFGPCT = 0>
	<cfset aDFGPCT = 0>
	<cfset pDFGPCT = 0>


	<cfset gdPIP = 0>
	<cfset adPIP = 0>
	<cfset pdPIP = 0>

	<cfset gRebounding = 0>
	<cfset aRebounding = 0>
	<cfset pRebounding = 0>

	<cfset gdtppct = 0>
	<cfset adtppct = 0>
	<cfset pdtppct = 0>


	<cfloop query = "UndGetOverGamesPS">


		
		<cfif oPS is 'G'>
			<cfset gDPS = gDPS + 1>
		<cfelseif oPS is 'A'>	
			<cfset avDPS = avDPS + 1>
		<cfelse>
			<cfset pDPS = pDPS + 1>
		</cfif>	
		
		
		<cfif oPIP is 'G'>
			<cfset gdPIP = gdPIP + 1>
		<cfelseif oPIP is 'A'>	
			<cfset adPIP = adPIP + 1>
		<cfelse>
			<cfset pdPIP = pdPIP + 1>
		</cfif>	
				
		
		<cfif oFGPCT is 'G'>
			<cfset gdFGPct = gdFGPct + 1>
		<cfelseif oFGPCT  is 'A'>	
			<cfset adFGPct = adFGPct + 1>
		<cfelse>
			<cfset pdFGPct = pdFGPct + 1>
		</cfif>	
		
		
		<cfif oRebounding is 'G'>
			<cfset gRebounding = gRebounding + 1>
		<cfelseif oRebounding is 'A'>	
			<cfset aRebounding = aRebounding + 1>
		<cfelse>
			<cfset pRebounding = pRebounding + 1>
		</cfif>	
		
		 
		<cfif otppct is 'G'>
			<cfset gdtppct = gdtppct + 1>
		<cfelseif otppct is 'A'>	
			<cfset adtppct = adtppct + 1>
		<cfelse>
			<cfset pdtppct = pdtppct + 1>
		</cfif>	
		
	</cfloop>	
	<p>	
	******************************************************************************************************************<br>	
	For #Und# to cover the spread of #FavPredPts - UndPredPts# Overall they cover the spread #UndGetOverGamesPS.recordcount/(UndGetOverGamesPS.recordcount+UndGetUnderGamesPS.recordcount)#<br>		
	Good PS: #gDPS/UndGetOverGamesPS.recordcount#	.......opp value is #GetFAVGAP.oPS#	<br>
	Avg  PS: #avDPS/UndGetOverGamesPS.recordcount#	<br>
	Poor PS: #pDPS/UndGetOverGamesPS.recordcount#	<br>
	<p>
	Good PIP: #gdPIP/UndGetOverGamesPS.recordcount#	.......opp value is #GetFAVGAP.oPIP#	<br>
	Avg  PIP: #adPIP/UndGetOverGamesPS.recordcount#	<br>
	Poor PIP: #pdPIP/UndGetOverGamesPS.recordcount#	<br>
	<p>
	Good FGPCT: #gdFGPct/UndGetOverGamesPS.recordcount#	.......opp value is #GetFAVGAP.oFGPCT#	<br>
	Avg  FGPCT: #adFGPct/UndGetOverGamesPS.recordcount#	<br>
	Poor FGPCT: #pdFGPct/UndGetOverGamesPS.recordcount#	<br>
	<p>
	Good Rebounding: #gRebounding/UndGetOverGamesPS.recordcount#	.......opp value is #GetFAVGAP.oRebounding#	<br>
	Avg  Rebounding: #aRebounding/UndGetOverGamesPS.recordcount#	<br>
	Poor Rebounding: #pRebounding/UndGetOverGamesPS.recordcount#	<br>
	<p>
	Good tppct: #gdtppct/UndGetOverGamesPS.recordcount#	.......opp value is #GetFAVGAP.oTppct#	<br>
	Avg  tppct: #adtppct/UndGetOverGamesPS.recordcount#	<br>
	Poor tppct: #pdtppct/UndGetOverGamesPS.recordcount#	<br>
	<p>
	<p>
	
	<cfset favtotpct = 0>
	<cfset undtotpct = 0>	
		
		
	<cfif '#GetFavGAP.dps#' is 'P'>
		<cfset undtotpct = (pDPS/undgetOverGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.dps#' is 'A'>
		<cfset undtotpct = (pDPS/undgetOverGamesPS.recordcount) + (avDPS/undgetOverGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = (gDPS/undgetOverGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetFavGAP.dpip#' is 'P'>
		<cfset undtotpct = undtotpct + (pDPIP/undgetOverGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.dpip#' is 'A'>
		<cfset undtotpct = undtotpct + (pDpip/undgetOverGamesPS.recordcount) + (aDPIP/undgetOverGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = undtotpct + (gDPIP/undgetOverGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetFavGAP.dfgpct#' is 'P'>
		<cfset undtotpct = undtotpct + (pDfgpct/undgetOverGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.dfgpct#' is 'A'>
		<cfset undtotpct = undtotpct + (pDfgpct/undgetOverGamesPS.recordcount) + (aDfgpct/undgetOverGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = undtotpct + (gDfgpct/undgetOverGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetFavGAP.drebounding#' is 'P'>
		<cfset undtotpct = undtotpct + (prebounding/undgetOverGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.drebounding#' is 'A'>
		<cfset undtotpct = undtotpct + (prebounding/undgetOverGamesPS.recordcount) + (arebounding/undgetOverGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = undtotpct + (grebounding/undgetOverGamesPS.recordcount)>
	</cfif>
	
	
	<cfif '#GetFavGAP.dtppct#' is 'P'>
		<cfset undtotpct = undtotpct + (pdtppct/undgetOverGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.dtppct#' is 'A'>
		<cfset undtotpct = undtotpct + (pdtppct/undgetOverGamesPS.recordcount) + (adtppct/undgetOverGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = undtotpct + (gdtppct/undgetOverGamesPS.recordcount)>
	</cfif>
	<p>
	The Total percent in undOR of covering is #undTotPct/5#<br>

	<cfset UndFinal = UndFinal + (UndTotPct/5)>

	******************************************************************************************************************<br>





	
	<cfset gDPS = 0>
	<cfset avDPS = 0>
	<cfset pDPS = 0>

	<cfset gDFGPCT = 0>
	<cfset aDFGPCT = 0>
	<cfset pDFGPCT = 0>


	<cfset gdPIP = 0>
	<cfset adPIP = 0>
	<cfset pdPIP = 0>

	<cfset gRebounding = 0>
	<cfset aRebounding = 0>
	<cfset pRebounding = 0>

	<cfset gdtppct = 0>
	<cfset adtppct = 0>
	<cfset pdtppct = 0>


	
	<cfloop query = "FavGetUnderGamesPS">


		
		<cfif oPS is 'G'>
			<cfset gDPS = gDPS + 1>
		<cfelseif oPS is 'A'>	
			<cfset avDPS = avDPS + 1>
		<cfelse>
			<cfset pDPS = pDPS + 1>
		</cfif>	
		
		
		<cfif oPIP is 'G'>
			<cfset gdPIP = gdPIP + 1>
		<cfelseif oPIP is 'A'>	
			<cfset adPIP = adPIP + 1>
		<cfelse>
			<cfset pdPIP = pdPIP + 1>
		</cfif>	
				
		
		<cfif oFGPCT is 'G'>
			<cfset gdFGPct = gdFGPct + 1>
		<cfelseif oFGPCT is 'A'>	
			<cfset adFGPct = adFGPct + 1>
		<cfelse>
			<cfset pdFGPct = pdFGPct + 1>
		</cfif>	
		
		
		<cfif oRebounding is 'G'>
			<cfset gRebounding = gRebounding + 1>
		<cfelseif oRebounding is 'A'>	
			<cfset aRebounding = aRebounding + 1>
		<cfelse>
			<cfset pRebounding = pRebounding + 1>
		</cfif>	
		
		
		<cfif otppct is 'G'>
			<cfset gdtppct = gdtppct + 1>
		<cfelseif otppct is 'A'>	
			<cfset adtppct = adtppct + 1>
		<cfelse>
			<cfset pdtppct = pdtppct + 1>
		</cfif>	
		
	</cfloop>	
	<p>	
	******************************************************************************************************************<br>	
	For #Fav# NOT to cover the spread of #FavPredPts - UndPredPts#<br>		
	Good PS: #gDPS/FavGetUnderGamesPS.recordcount#	.......opp value is #GetUNDGAP.oPS#	<br>
	Avg  PS: #avDPS/FavGetUnderGamesPS.recordcount#	<br>
	Poor PS: #pDPS/FavGetUnderGamesPS.recordcount#	<br>
	<p>
	Good PIP: #gdPIP/FavGetUnderGamesPS.recordcount#	.......opp value is #GetUNDGAP.oPIP#	<br>
	Avg  PIP: #adPIP/FavGetUnderGamesPS.recordcount#	<br>
	Poor PIP: #pdPIP/FavGetUnderGamesPS.recordcount#	<br>
	<p>
	Good FGPCT: #gdFGPct/FavGetUnderGamesPS.recordcount#	.......opp value is #GetUNDGAP.oFGPCT#	<br>
	Avg  FGPCT: #adFGPct/FavGetUnderGamesPS.recordcount#	<br>
	Poor FGPCT: #pdFGPct/FavGetUnderGamesPS.recordcount#	<br>
	<p>
	Good Rebounding: #gRebounding/FavGetUnderGamesPS.recordcount#	.......opp value is #GetUNDGAP.oRebounding#	<br>
	Avg  Rebounding: #aRebounding/FavGetUnderGamesPS.recordcount#	<br>
	Poor Rebounding: #pRebounding/FavGetUnderGamesPS.recordcount#	<br>
	<p>
	Good tppct: #gdtppct/FavGetUnderGamesPS.recordcount#	.......opp value is #GetUNDGAP.oTppct#	<br>
	Avg  tppct: #adtppct/FavGetUnderGamesPS.recordcount#	<br>
	Poor tppct: #pdtppct/FavGetUnderGamesPS.recordcount#	<br>
	<p>
	<p>
	
		<cfset favtotpct = 0>
	<cfset undtotpct = 0>
	
	<cfif '#GetUndGAP.dps#' is 'P'>
		<cfset favtotpct = pDPS/FavGetUnderGamesPS.recordcount>
	<cfelseif 	'#GetUndGAP.dps#' is 'A'>
		<cfset favtotpct = (pDPS/FavGetUnderGamesPS.recordcount) + (avDPS/FavGetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = gDPS/FavGetUnderGamesPS.recordcount>
	</cfif>
	
	<cfif '#GetUndGAP.dpip#' is 'P'>
		<cfset favtotpct = favtotpct + (pDPIP/FavGetUnderGamesPS.recordcount)>
	<cfelseif 	'#GetUndGAP.dpip#' is 'A'>
		<cfset favtotpct = favtotpct + (pDpip/FavGetUnderGamesPS.recordcount) + (aDPIP/FavGetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = favtotpct + (gDPIP/FavGetUnderGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetUndGAP.dfgpct#' is 'P'>
		<cfset favtotpct = favtotpct + (pDfgpct/FavGetUnderGamesPS.recordcount)>
	<cfelseif 	'#GetUndGAP.dfgpct#' is 'A'>
		<cfset favtotpct = favtotpct + (pDfgpct/FavGetUnderGamesPS.recordcount) + (aDfgpct/FavGetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = favtotpct + (gDfgpct/FavGetUnderGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetUndGAP.drebounding#' is 'P'>
		<cfset favtotpct = favtotpct + (prebounding/FavGetUnderGamesPS.recordcount)>
	<cfelseif 	'#GetUndGAP.drebounding#' is 'A'>
		<cfset favtotpct = favtotpct + (prebounding/FavGetUnderGamesPS.recordcount) + (arebounding/FavGetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = favtotpct + (grebounding/FavGetUnderGamesPS.recordcount)>
	</cfif>
	
	
	<cfif '#GetUndGAP.dtppct#' is 'P'>
		<cfset favtotpct = favtotpct + (pdtppct/FavGetUnderGamesPS.recordcount)>
	<cfelseif 	'#GetUndGAP.dtppct#' is 'A'>
		<cfset favtotpct = favtotpct + (pdtppct/FavGetUnderGamesPS.recordcount) + (adtppct/FavGetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset favtotpct = favtotpct + (gdtppct/FavGetUnderGamesPS.recordcount)>
	</cfif>
	<p>
	The Total percent in FAVOR of NOT covering is #FavTotPct/5#<br>

	<cfset FavFinal = FavFinal - (FavTotPct/5)>

	
	******************************************************************************************************************<br>


	<cfset gDPS = 0>
	<cfset avDPS = 0>
	<cfset pDPS = 0>

	<cfset gDFGPCT = 0>
	<cfset aDFGPCT = 0>
	<cfset pDFGPCT = 0>


	<cfset gdPIP = 0>
	<cfset adPIP = 0>
	<cfset pdPIP = 0>

	<cfset gRebounding = 0>
	<cfset aRebounding = 0>
	<cfset pRebounding = 0>

	<cfset gdtppct = 0>
	<cfset adtppct = 0>
	<cfset pdtppct = 0>


	<cfloop query = "UndGetUnderGamesPS">


		
		<cfif oPS is 'G'>
			<cfset gDPS = gDPS + 1>
		<cfelseif oPS is 'A'>	
			<cfset avDPS = avDPS + 1>
		<cfelse>
			<cfset pDPS = pDPS + 1>
		</cfif>	
		
		
		<cfif oPIP is 'G'>
			<cfset gdPIP = gdPIP + 1>
		<cfelseif oPIP is 'A'>	
			<cfset adPIP = adPIP + 1>
		<cfelse>
			<cfset pdPIP = pdPIP + 1>
		</cfif>	
				
		
		<cfif oFGPCT is 'G'>
			<cfset gdFGPct = gdFGPct + 1>
		<cfelseif oFGPct is 'A'>	
			<cfset adFGPct = adFGPct + 1>
		<cfelse>
			<cfset pdFGPct = pdFGPct + 1>
		</cfif>	
		
		
		<cfif oRebounding is 'G'>
			<cfset gRebounding = gRebounding + 1>
		<cfelseif oRebounding is 'A'>	
			<cfset aRebounding = aRebounding + 1>
		<cfelse>
			<cfset pRebounding = pRebounding + 1>
		</cfif>	
		
		 
		<cfif otppct is 'G'>
			<cfset gdtppct = gdtppct + 1>
		<cfelseif otppct is 'A'>	
			<cfset adtppct = adtppct + 1>
		<cfelse>
			<cfset pdtppct = pdtppct + 1>
		</cfif>	
		
	</cfloop>	
	<p>	
	******************************************************************************************************************<br>	
	For #Und# NOT to cover the spread of #FavPredPts - UndPredPts#<br>		
	Good PS: #gDPS/UndGetUnderGamesPS.recordcount#	.......opp value is #GetFAVGAP.oPS#	<br>
	Avg  PS: #avDPS/UndGetUnderGamesPS.recordcount#	<br>
	Poor PS: #pDPS/UndGetUnderGamesPS.recordcount#	<br>
	<p>
	Good PIP: #gdPIP/UndGetUnderGamesPS.recordcount#	.......opp value is #GetFAVGAP.oPIP#	<br>
	Avg  PIP: #adPIP/UndGetUnderGamesPS.recordcount#	<br>
	Poor PIP: #pdPIP/UndGetUnderGamesPS.recordcount#	<br>
	<p>
	Good FGPCT: #gdFGPct/UndGetUnderGamesPS.recordcount#	.......opp value is #GetFAVGAP.oFGPCT#	<br>
	Avg  FGPCT: #adFGPct/UndGetUnderGamesPS.recordcount#	<br>
	Poor FGPCT: #pdFGPct/UndGetUnderGamesPS.recordcount#	<br>
	<p>
	Good Rebounding: #gRebounding/UndGetUnderGamesPS.recordcount#	.......opp value is #GetFAVGAP.oRebounding#	<br>
	Avg  Rebounding: #aRebounding/UndGetUnderGamesPS.recordcount#	<br>
	Poor Rebounding: #pRebounding/UndGetUnderGamesPS.recordcount#	<br>
	<p>
	Good tppct: #gdtppct/UndGetUnderGamesPS.recordcount#	.......opp value is #GetFAVGAP.oTppct#	<br>
	Avg  tppct: #adtppct/UndGetUnderGamesPS.recordcount#	<br>
	Poor tppct: #pdtppct/UndGetUnderGamesPS.recordcount#	<br>
	<p>
	<p>
	
		<cfset favtotpct = 0>
	<cfset undtotpct = 0>


	<cfif '#GetFavGAP.dps#' is 'P'>
		<cfset undtotpct = (pDPS/undgetUnderGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.dps#' is 'A'>
		<cfset undtotpct = (pDPS/undgetUnderGamesPS.recordcount) + (avDPS/undgetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = (gDPS/undgetUnderGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetFavGAP.dpip#' is 'P'>
		<cfset undtotpct = undtotpct + (pDPIP/undgetUnderGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.dpip#' is 'A'>
		<cfset undtotpct = undtotpct + (pDpip/undgetUnderGamesPS.recordcount) + (aDPIP/undgetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = undtotpct + (gDPIP/undgetUnderGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetFavGAP.dfgpct#' is 'P'>
		<cfset undtotpct = undtotpct + (pDfgpct/undgetUnderGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.dfgpct#' is 'A'>
		<cfset undtotpct = undtotpct + (pDfgpct/undgetUnderGamesPS.recordcount) + (aDfgpct/undgetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = undtotpct + (gDfgpct/undgetUnderGamesPS.recordcount)>
	</cfif>
	
	<cfif '#GetFavGAP.drebounding#' is 'P'>
		<cfset undtotpct = undtotpct + (prebounding/undgetUnderGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.drebounding#' is 'A'>
		<cfset undtotpct = undtotpct + (prebounding/undgetUnderGamesPS.recordcount) + (arebounding/undgetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = undtotpct + (grebounding/undgetUnderGamesPS.recordcount)>
	</cfif>
	
	
	<cfif '#GetFavGAP.dtppct#' is 'P'>
		<cfset undtotpct = undtotpct + (pdtppct/undgetUnderGamesPS.recordcount)>
	<cfelseif 	'#GetFavGAP.dtppct#' is 'A'>
		<cfset undtotpct = undtotpct + (pdtppct/undgetUnderGamesPS.recordcount) + (adtppct/undgetUnderGamesPS.recordcount) >
	<cfelse>
		<cfset undtotpct = undtotpct + (gdtppct/undgetUnderGamesPS.recordcount)>
	</cfif>
	<p>
	The Total percent in undOR of NOT cUndering is #undTotPct/5#<br>
	<cfset UndFinal = UndFinal - (UndTotPct/5)>

	******************************************************************************************************************<br>


	Final Fav = #1000*(FavFinal/8)#<br>
	Final Und = #1000*(UndFinal/8)#<br>

	<cfquery datasource="NBA" name="GetUndGAP">
	Update FinalPicks
	Set FavMatchupPct = #round(1000*(FavFinal/8))#,
	UndMatchupPct = #round(1000*(UndFinal/8))#
	
	WHERE GameTime = '#gametime#'
	and Fav = '#fav#'
	</cfquery>



	
</cfoutput>	
	
	

<cfquery datasource="NBA" name="GetIt">
SELECT n.* 
from NBASchedule n
where n.gametime ='#gametime#'
</cfquery>

	
<cfloop query="Getit">

	<cfset Fav        = '#Getit.Fav#'>
	<cfset Und        = '#GetIt.Und#'>
	<cfset OU         = Getit.Ou>
	<cfset FavPredPts = Getit.FavExpectedPts>
	<cfset UndPredPts = Getit.UndExpectedPts>
	<cfset HA         = '#Getit.Ha#'>
	<cfset Gametime   = '#GetIt.Gametime#'>	
	<cfset spd        = GetIt.spd>
	
	
	<cfif ha is 'H'>
		
		<cfquery datasource="NBA" name="GetFavGames">
		Select m.ops + h.hfa as ps
		From Matrix m, NBAHomeFieldAdv h	
		WHERE m.Team = '#fav#'
		and m.Opp = '#und#'
		</cfquery>
		
		<cfquery datasource="NBA" name="GetUndGames">
		Select ops as ps
		From Matrix	
		WHERE Team = '#und#'
		and Opp = '#fav#'
		</cfquery>

		<cfquery datasource="NBA" name="GetFavDGames">
		Select m.dps - h.hfa as ps
		From MatrixDps m, NBAHomeFieldAdv h	
		WHERE m.Team = '#fav#'
		and m.Opp = '#und#'
		</cfquery>
		
		<cfquery datasource="NBA" name="GetUndDGames">
		Select dps as ps
		From MatrixDps	
		WHERE Team = '#und#'
		and Opp = '#fav#'
		</cfquery>





	<cfelse>
	
		<cfquery datasource="NBA" name="GetUndGames">
		Select m.ops + h.hfa as ps
		From Matrix m, NBAHomeFieldAdv h	
		WHERE m.Team = '#und#'
		and m.Opp = '#fav#'
		</cfquery>
		
		<cfquery datasource="NBA" name="GetFavGames">
		Select ops as ps
		From Matrix	
		WHERE Team = '#fav#'
		and Opp = '#und#'
		</cfquery>
	
	
		<cfquery datasource="NBA" name="GetFavDGames">
		Select m.dps as ps
		From Matrixdps m
		WHERE m.Team = '#fav#'
		and m.Opp = '#und#'
		</cfquery>
		
		<cfquery datasource="NBA" name="GetUndDGames">
		Select m.dps - h.hfa as ps
		From Matrixdps m, NBAHomeFieldAdv h	
		WHERE m.Team = '#und#'
		and m.Opp = '#fav#'
		</cfquery>

	
	</cfif>



	
	<cfset UndWins = 0>
	<cfset FavWins = 0>
	<cfset Tie = 0>
	<cfset mov = 0>
	<cfset totgames = 0>
	<cfset Favtotpoints = 0>
	<cfset Undtotpoints = 0>
	<cfset TotPoints = 0>
	<cfset FavSpdWins = 0>
	<cfset UndSpdWins = 0>
	<cfset GTTotalGames = 0>
	
	
	<cfoutput query="GetFavGames">
		
		<cfloop query="GetUndGames"> 
		
			<cfset GTTotalGames = GTTotalGames + 1>
		
			<cfset mov = mov + GetFavGames.Ps - GetUndGames.Ps>
			
			<cfif (GetFavGames.Ps - GetUndGames.Ps) gt #spd#>
				<cfset FavSpdWins = FavSpdWins + 1>
							<cfset totgames = totgames + 1>
			<cfelseif (GetFavGames.Ps - GetUndGames.Ps) lt #spd#>
				<cfset UndSpdWins = UndSpdWins + 1>
							<cfset totgames = totgames + 1>
			</cfif>	
			
			<cfset TotPoints = TotPoints + (GetFavGames.Ps + GetUndGames.Ps)>
		

			<cfif GetUndGames.Ps gt GetFavGames.Ps>
				<cfset UndWins = UndWins + 1>
			<cfelseif GetUndGames.Ps lt GetFavGames.Ps>
				<cfset favWins = FavWins + 1>
			<cfelse>
				<cfset Tie = Tie + 1>
			</cfif>
		</cfloop>
	
	</cfoutput>	
		

	<cfoutput query="GetUndGames">
		
		<cfloop query="GetFavGames"> 
		
			<cfset GTTotalGames = GTTotalGames + 1>
		
			<cfset mov = mov + GetFavGames.Ps - GetUndGames.Ps>
			<cfset TotPoints = TotPoints + (GetFavGames.Ps + GetUndGames.Ps)>

			<cfif (GetFavGames.Ps - GetUndGames.Ps) gt #spd#>
				<cfset FavSpdWins = FavSpdWins + 1>
				<cfset totgames = totgames + 1>
			<cfelseif (GetFavGames.Ps - GetUndGames.Ps) lt #spd#>
				<cfset totgames = totgames + 1>
				<cfset UndSpdWins = UndSpdWins + 1>
			</cfif>	
		
		
			
			<cfif GetUndGames.Ps gt GetFavGames.Ps>
				<cfset UndWins = UndWins + 1>
			<cfelseif GetUndGames.Ps lt GetFavGames.Ps>
				<cfset favWins = FavWins + 1>
			<cfelse>
				<cfset Tie = Tie + 1>
			</cfif>
		</cfloop>
	
	</cfoutput>	
		
	<cfif 1 is 1>

	<cfoutput query="GetFavDGames">
		
		<cfloop query="GetUndDGames"> 
			<cfset GTTotalGames = GTTotalGames + 1>
			<cfset GameMOV = GetUndDGames.Ps - GetFavDGames.Ps>
			
			<cfset mov = mov + GameMOV>
			
			<cfif (Gamemov) gt #spd#>
				<cfset FavSpdWins = FavSpdWins + 1>
				<cfset totgames = totgames + 1>
			<cfelseif GameMov lt #spd#>
				<cfset UndSpdWins = UndSpdWins + 1>
				<cfset totgames = totgames + 1>
			</cfif>	
			
			<cfset TotPoints = TotPoints + (GetFavDGames.Ps + GetUndDGames.Ps)>
		
			
			<cfif GetUnddGames.Ps lt GetFavdGames.Ps>
				<cfset UndWins = UndWins + 1>
			<cfelseif GetUnddGames.Ps gt GetFavdGames.Ps>
				<cfset favWins = FavWins + 1>
			<cfelse>
				<cfset Tie = Tie + 1>
			</cfif>
		</cfloop>
	
	</cfoutput>	
		

	<cfoutput query="GetUndDGames">
		
		<cfloop query="GetFavDGames"> 
			<cfset GTTotalGames = GTTotalGames + 1>
		
			<cfset GameMOV = GetUndDGames.Ps - GetFavDGames.Ps>
			<cfset mov = mov + GameMov>
			<cfset TotPoints = TotPoints + (GetFavGames.Ps + GetUndGames.Ps)>

			<cfif GameMOV gt #spd#>
				<cfset FavSpdWins = FavSpdWins + 1>
				<cfset totgames = totgames + 1>
			<cfelseif GameMOV lt #spd#>
				<cfset UndSpdWins = UndSpdWins + 1>
				<cfset totgames = totgames + 1>
			</cfif>	
				
			
			<cfif GetUnddGames.Ps lt GetFavdGames.Ps>
				<cfset UndWins = UndWins + 1>
			<cfelseif GetUnddGames.Ps gt GetFavdGames.Ps>
				<cfset favWins = FavWins + 1>
			<cfelse>
				<cfset Tie = Tie + 1>
			</cfif>
		</cfloop>
	
	</cfoutput>	
	</cfif>	
		
	<cfoutput>
	Total wins by #fav#: #Favwins/totgames# by an average MOV of #mov/totgames# and Average Total Points is #TotPoints/GtTotalGames#<br>
	#Fav# covers the spread of #spd# #100*(FavSpdWins/TotGames)# of the games
	
	<cfset thePickRat = (mov/totgames) - #spd#>
	
	if thePickRat is >0 means FAV covers take thepickrat - spd for rating
	else
		Underdog covers pickrat = abs(thepickrat) + spd
	
	
	The PickRat is #thepickrat#<br>
	<cfif thepickrat gt 0>
		<cfset pick = '#fav#'>
		<cfset thepickrat = thepickrat>
	<cfelse>
		<cfset pick = '#und#'>
		<cfif mov/totgames lt 0>
			<cfset thepickrat = spd - (mov/totgames)>
		<cfelse>
			<cfif mov/totgames lt spd>
				<cfset thepickrat = spd - (mov/totgames)>
			</cfif>	
		</cfif>	
	</cfif>	
	
	
	<cfquery datasource="NBA" name="Add3">
	INSERT INTO NBAPicks(Gametime,Fav,spd,und,Pick,PickRating,SystemId) Values('#gametime#','#fav#',#spd#,'#und#','#pick#',#thepickrat#,'CreateTeamScoringProfiles.cfm') 
	</cfquery>
	
	
	<cfif 100*(FavSpdWins/TotGames) gte 50>
		<cfquery datasource="NBA" name="updIt">
		Update FinalPicks 
		Set FAVCoverPct = #Numberformat(100*(FavSpdWins/TotGames),'99.9')#
		Where Gametime = '#gametime#' 
		and FAV = '#fav#'
		</cfquery>

	<cfelse>
	
		<cfquery datasource="NBA" name="UpdIt">
		Update FinalPicks 
		Set UNDCoverPct = #Numberformat(100*(UndSpdWins/TotGames),'99.9')#
		Where Gametime = '#gametime#' 
		and FAV = '#fav#'
		</cfquery>
	
	</cfif>
		
	<cfquery datasource="NBA" name="UpdIt">
		Update FinalPicks 
		Set FAVADV = FavMatchupPct - UndMatchupPct 
	</cfquery>	
		
	</cfoutput>	
	<P>
	<p>
</cfloop>	

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('Ran CreateTeamScoringProfiles.cfm')
</cfquery>