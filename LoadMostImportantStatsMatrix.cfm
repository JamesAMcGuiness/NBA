<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfif 1 is 2>

<cfquery datasource="NBAstats" name="addit">
Select * from nbadata
</cfquery>

<cfoutput query="addit">
	<cfquery datasource="nba" name="addit3">
	Insert into nbadata
	(
	Team,
	opp,
	ha,
	gametime,
	ps,
	ofgm,
	ofga,
	ofgpct,
	otpm,
	otpa,
	otppct,
	oftm,
	ofta,
	oftpct,
	oreb,
	odreb,
	otreb,
	oassists,
	osteals,
	oturnovers,
	oblkshots,
	dps,
	dfgm,
	dfga,
	dfgpct,
	dtpm,
	dtpa,
	dtppct,
	dftm,
	dfta,
	dftpct,
	dreb,
	ddreb,
	dtreb,
	dassists,
	dsteals,
	dturnovers,
	dblkshots
	)
	values
	(
	'#addit.Team#',
	'#addit.opp#',
	'#addit.ha#',
	'#addit.gametime#',
	#addit.ps#,
	#addit.ofgm#,
	#addit.ofga#,
	#addit.ofgpct#,
	#addit.otpm#,
	#addit.otpa#,
	#addit.otppct#,
	#addit.oftm#,
	#addit.ofta#,
	#addit.oftpct#,
	#addit.oreb#,
	#addit.odreb#,
	#addit.otreb#,
	#addit.oassists#,
	#addit.osteals#,
	#addit.oturnovers#,
	#addit.oblkshots#,
	#addit.dps#,
	#addit.dfgm#,
	#addit.dfga#,
	#addit.dfgpct#,
	#addit.dtpm#,
	#addit.dtpa#,
	#addit.dtppct#,
	#addit.dftm#,
	#addit.dfta#,
	#addit.dftpct#,
	#addit.dreb#,
	#addit.ddreb#,
	#addit.dtreb#,
	#addit.dassists#,
	#addit.dsteals#,
	#addit.dturnovers#,
	#addit.dblkshots#
	
	
	)
	</cfquery>
</cfoutput>

</cfif>


<cfif 1 is 2>

<cfquery datasource="NBA" name="TheGames">
	Select distinct * 
	from nbadata
	where ps - dps > 0
</cfquery>



	
<cfloop query="TheGames">

<!-- See what type of game it was... Close or blowout... -->
	<cfset rge1to3    = 0>
	<cfset rge4to6    = 0>
	<cfset rge7to9    = 0>
	<cfset rge10to12  = 0>
	<cfset rgeblowout = 0>

	<cfset fgadif_1to3   = 0> 
	<cfset fgadif_4to6   = 0> 
	<cfset fgadif_7to9   = 0> 
	<cfset fgadif_10to12 = 0> 
	<cfset fgadif_13plus = 0> 

	<cfset ftmdif_1to3   = 0> 
	<cfset ftmdif_4to6   = 0> 
	<cfset ftmdif_7to9   = 0> 
	<cfset ftmdif_10to12 = 0> 
	<cfset ftmdif_13plus = 0> 

	<cfset tpmdif_1to3   = 0> 
	<cfset tpmdif_4to6   = 0> 
	<cfset tpmdif_7to9   = 0> 
	<cfset tpmdif_10to12 = 0> 
	<cfset tpmdif_13plus = 0> 

	<cfset todif_1to3   = 0> 
	<cfset todif_4to6   = 0> 
	<cfset todif_7to9   = 0> 
	<cfset todif_10to12 = 0> 
	<cfset todif_13plus = 0> 

	<cfset fgpctdif_1to3   = 0> 
	<cfset fgpctdif_4to6   = 0> 
	<cfset fgpctdif_7to9   = 0> 
	<cfset fgpctdif_10to12 = 0> 
	<cfset fgpctdif_13plus = 0> 

	<cfset rebdif_1to3   = 0> 
	<cfset rebdif_4to6   = 0> 
	<cfset rebdif_7to9   = 0> 
	<cfset rebdif_10to12 = 0> 
	<cfset rebdif_13plus = 0> 


	<cfset fgpctwon = false>
	<cfset tpmwon   = false>
	<cfset ftmwon   = false>
	<cfset rebwon   = false>
	<cfset towon    = false>
	<cfset fgawon   = false>

	<cfset PtDif = TheGames.ps - thegames.dps>

	<cfset fgpctdif   = TheGames.ofgpct - TheGames.dfgpct>
	<cfset tpmdif     = TheGames.otpm   - TheGames.dtpm>
	<cfset ftmdif     = TheGames.oftm   - TheGames.dftm>
	<cfset rebdif     = TheGames.otreb  - TheGames.dtreb>
	<cfset todif      = TheGames.dturnovers  - TheGames.oturnovers>
	<cfset fgadif     = TheGames.ofga  - TheGames.dfga>
	
	<cfif fgpctdif gt 0>
		<cfset fgpctwon = true>

		<cfif fgpctdif ge 1 and fgpctdif le 3>
			<cfset fgpctdif_1to3 = fgpctdif_1to3 + 1> 
		</cfif>

		<cfif fgpctdif ge 4 and fgpctdif le 6>
			<cfset fgpctdif_4to6 = fgpctdif_4to6 + 1> 
		</cfif>

		<cfif fgpctdif ge 7 and fgpctdif le 9>
			<cfset fgpctdif_7to9 = fgpctdif_7to9 + 1> 
		</cfif>
		
		<cfif fgpctdif ge 10 and fgpctdif le 12>
			<cfset fgpctdif_10to12 = fgpctdif_10to12 + 1> 
		</cfif>

		<cfif fgpctdif ge 13>
			<cfset fgpctdif_13plus = fgpctdif_13plus + 1> 
		</cfif>

	</cfif>

	<cfif tpmdif gt 0>
		<cfset tpmwon = true>

		<cfif tpmdif ge 1 and tpmdif le 3>
			<cfset tpmdif_1to3 = tpmdif_1to3 + 1> 
		</cfif>

		<cfif tpmdif ge 4 and tpmdif le 6>
			<cfset tpmdif_4to6 = tpmdif_4to6 + 1> 
		</cfif>

		<cfif tpmdif ge 7 and tpmdif le 9>
			<cfset tpmdif_7to9 = tpmdif_7to9 + 1> 
		</cfif>
		
		<cfif tpmdif ge 10 and tpmdif le 12>
			<cfset tpmdif_10to12 = tpmdif_10to12 + 1> 
		</cfif>

		<cfif tpmdif ge 13>
			<cfset tpmdif_13plus = tpmdif_13plus + 1> 
		</cfif>

	</cfif>


	<cfif ftmdif gt 0>
		<cfset ftmwon = true>

		<cfif ftmdif ge 1 and ftmdif le 3>
			<cfset ftmdif_1to3 = ftmdif_1to3 + 1> 
		</cfif>

		<cfif ftmdif ge 4 and ftmdif le 6>
			<cfset ftmdif_4to6 = ftmdif_4to6 + 1> 
		</cfif>

		<cfif ftmdif ge 7 and ftmdif le 9>
			<cfset ftmdif_7to9 = ftmdif_7to9 + 1> 
		</cfif>
		
		<cfif ftmdif ge 10 and ftmdif le 12>
			<cfset ftmdif_10to12 = ftmdif_10to12 + 1> 
		</cfif>

		<cfif ftmdif ge 13>
			<cfset ftmdif_13plus = ftmdif_13plus + 1> 
		</cfif>

	</cfif>

	<cfif rebdif gt 0>
		<cfset rebwon = true>

		<cfif rebdif ge 1 and rebdif le 3>
			<cfset rebdif_1to3 = rebdif_1to3 + 1> 
		</cfif>

		<cfif rebdif ge 4 and rebdif le 6>
			<cfset rebdif_4to6 = rebdif_4to6 + 1> 
		</cfif>

		<cfif rebdif ge 7 and rebdif le 9>
			<cfset rebdif_7to9 = rebdif_7to9 + 1> 
		</cfif>
		
		<cfif rebdif ge 10 and rebdif le 12>
			<cfset rebdif_10to12 = rebdif_10to12 + 1> 
		</cfif>

		<cfif rebdif ge 13>
			<cfset rebdif_13plus = rebdif_13plus + 1> 
		</cfif>

	</cfif>

	<cfif todif gt 0>
		<cfset towon = true>

		<cfif todif ge 1 and todif le 3>
			<cfset todif_1to3 = todif_1to3 + 1> 
		</cfif>

		<cfif todif ge 4 and todif le 6>
			<cfset todif_4to6 = todif_4to6 + 1> 
		</cfif>

		<cfif todif ge 7 and todif le 9>
			<cfset todif_7to9 = todif_7to9 + 1> 
		</cfif>
		
		<cfif todif ge 10 and todif le 12>
			<cfset todif_10to12 = todif_10to12 + 1> 
		</cfif>

		<cfif todif ge 13>
			<cfset todif_13plus = todif_13plus + 1> 
		</cfif>

	</cfif>



	<cfif fgadif gt 0>
		<cfset fgawon = true>

		<cfif fgadif ge 1 and fgadif le 3>
			<cfset fgadif_1to3 = fgadif_1to3 + 1> 
		</cfif>

		<cfif fgadif ge 4 and fgadif le 6>
			<cfset fgadif_4to6 = fgadif_4to6 + 1> 
		</cfif>

		<cfif fgadif ge 7 and fgadif le 9>
			<cfset fgadif_7to9 = fgadif_7to9 + 1> 
		</cfif>
		
		<cfif fgadif ge 10 and fgadif le 12>
			<cfset fgadif_10to12 = fgadif_10to12 + 1> 
		</cfif>

		<cfif fgadif ge 13>
			<cfset fgadif_13plus = fgadif_13plus + 1> 
		</cfif>

	</cfif>
	
		
	<cfif ptdif ge 1 and ptdif le 3>
		<cfset rge1to3 = rge1to3 + 1>
	</cfif>

	<cfif ptdif ge 4 and ptdif le 6>
		<cfset rge4to6 = rge4to6 + 1>
	</cfif>
	
	<cfif ptdif ge 7 and ptdif le 9>
		<cfset rge7to9 = rge7to9 + 1>
	</cfif>

	<cfif ptdif ge 10 and ptdif le 12>
		<cfset rge10to12 = rge10to12 + 1>
	</cfif>

	<cfif ptdif ge 13>
		<cfset rgeblowout = rgeblowout + 1>
	</cfif>

	<cfoutput>
	<cfquery datasource="nba">
	Insert into StatImportance
	(
	PtDif,
	FGPCTWon,
	FGAWon,
	TPMWon,
	FTMWon,
	RebWon,
	ToWon,
	FGDif13,
	FGDif46,
	FGDif79,
	FGDif1012,
	FGDif13p,
	FGADif13,
	FGADif46,
	FGADif79,
	FGADif1012,
	FGADif13p,
	TPMDif13,
	TPMDif46,
	TPMDif79,
	TPMDif1012,
	TPMDif13p,
	FTMDif13,
	FTMDif46,
	FTMDif79,
	FTMDif1012,
	FTMDif13p,
	REBDif13,
	REBDif46,
	REBDif79,
	REBDif1012,
	REBDif13p,
	TODif13,
	TODif46,
	TODif79,
	TODif1012,
	TODif13p
		
	)
	values
	(
	#PtDif#,
	#FGPCTWon#,
	#FGAWon#,
	#TPMWon#,
	#FTMWon#,
	#RebWon#,
	#ToWon#,
	#FGpctDif_1to3#,
	#FGpctDif_4to6#,
	#FGpctDif_7to9#,
	#FGpctDif_10to12#,
	#FGpctDif_13plus#,
	#FGADif_1to3#,
	#FGADif_4to6#,
	#FGADif_7to9#,
	#FGADif_10to12#,
	#FGADif_13plus#,
	#TPMDif_1to3#,
	#TPMDif_4to6#,
	#TPMDif_7to9#,
	#TPMDif_10to12#,
	#TPMDif_13plus#,
	#FTMDif_1to3#,
	#FTMDif_4to6#,
	#FTMDif_7to9#,
	#FTMDif_10to12#,
	#FTMDif_13plus#,
	#REBDif_1to3#,
	#REBDif_4to6#,
	#REBDif_7to9#,
	#REBDif_10to12#,
	#REBDif_13plus#,
	#TODif_1to3#,
	#TODif_4to6#,
	#TODif_7to9#,
	#TODif_10to12#,
	#TODif_13plus#
	
	)
	
	</cfquery>
	</cfoutput>	
	


</cfloop>
</cfif>

















<cfquery datasource="nba" name="GetInfo">
Select * from StatImportance
where ptdif >= 4 
and ptdif <= 6
</cfquery>


<!-- See what type of game it was... Close or blowout... -->
	<cfset rge1to3    = 0>
	<cfset rge4to6    = 0>
	<cfset rge7to9    = 0>
	<cfset rge10to12  = 0>
	<cfset rgeblowout = 0>

	<cfset fgadif_1to3   = 0> 
	<cfset fgadif_4to6   = 0> 
	<cfset fgadif_7to9   = 0> 
	<cfset fgadif_10to12 = 0> 
	<cfset fgadif_13plus = 0> 

	<cfset ftmdif_1to3   = 0> 
	<cfset ftmdif_4to6   = 0> 
	<cfset ftmdif_7to9   = 0> 
	<cfset ftmdif_10to12 = 0> 
	<cfset ftmdif_13plus = 0> 

	<cfset tpmdif_1to3   = 0> 
	<cfset tpmdif_4to6   = 0> 
	<cfset tpmdif_7to9   = 0> 
	<cfset tpmdif_10to12 = 0> 
	<cfset tpmdif_13plus = 0> 

	<cfset todif_1to3   = 0> 
	<cfset todif_4to6   = 0> 
	<cfset todif_7to9   = 0> 
	<cfset todif_10to12 = 0> 
	<cfset todif_13plus = 0> 

	<cfset fgpctdif_1to3   = 0> 
	<cfset fgpctdif_4to6   = 0> 
	<cfset fgpctdif_7to9   = 0> 
	<cfset fgpctdif_10to12 = 0> 
	<cfset fgpctdif_13plus = 0> 

	<cfset rebdif_1to3   = 0> 
	<cfset rebdif_4to6   = 0> 
	<cfset rebdif_7to9   = 0> 
	<cfset rebdif_10to12 = 0> 
	<cfset rebdif_13plus = 0> 


	<cfset fgpctwon = false>
	<cfset tpmwon   = false>
	<cfset ftmwon   = false>
	<cfset rebwon   = false>
	<cfset towon    = false>
	<cfset fgawon   = false>


<cfloop query="GetInfo">

		<cfif fgdif13 is 1>
			<cfset fgpctdif_1to3 = fgpctdif_1to3 + 1> 
		</cfif>

		<cfif fgdif46 is 1>
			<cfset fgpctdif_4to6 = fgpctdif_4to6 + 1> 
		</cfif>

		<cfif fgdif79 is 1>
			<cfset fgpctdif_7to9 = fgpctdif_7to9 + 1> 
		</cfif>
		
		<cfif fgdif1012 is 1>
			<cfset fgpctdif_10to12 = fgpctdif_10to12 + 1> 
		</cfif>

		<cfif fgdif13p is 1>
			<cfset fgpctdif_13plus = fgpctdif_13plus + 1> 
		</cfif>

		<cfif tpmdif13 is 1>
			<cfset tpmdif_1to3 = tpmdif_1to3 + 1> 
		</cfif>

		<cfif tpmdif46 is 1>
			<cfset tpmdif_4to6 = tpmdif_4to6 + 1> 
		</cfif>

		<cfif tpmdif79 is 1>
			<cfset tpmdif_7to9 = tpmdif_7to9 + 1> 
		</cfif>
		
		<cfif tpmdif1012 is 1>
			<cfset tpmdif_10to12 = tpmdif_10to12 + 1> 
		</cfif>

		<cfif tpmdif13p is 1>
			<cfset tpmdif_13plus = tpmdif_13plus + 1> 
		</cfif>


		<cfif ftmdif13 is 1>
			<cfset ftmdif_1to3 = ftmdif_1to3 + 1> 
		</cfif>

		<cfif ftmdif46 is 1>
			<cfset ftmdif_4to6 = ftmdif_4to6 + 1> 
		</cfif>

		<cfif ftmdif79 is 1>
			<cfset ftmdif_7to9 = ftmdif_7to9 + 1> 
		</cfif>
		
		<cfif ftmdif1012 is 1>
			<cfset ftmdif_10to12 = ftmdif_10to12 + 1> 
		</cfif>

		<cfif ftmdif13p>
			<cfset ftmdif_13plus = ftmdif_13plus + 1> 
		</cfif>

		<cfif rebdif13 is 1>
			<cfset rebdif_1to3 = rebdif_1to3 + 1> 
		</cfif>

		<cfif rebdif46 is 1>
			<cfset rebdif_4to6 = rebdif_4to6 + 1> 
		</cfif>

		<cfif rebdif79 is 1>
			<cfset rebdif_7to9 = rebdif_7to9 + 1> 
		</cfif>
		
		<cfif rebdif1012 is 1>
			<cfset rebdif_10to12 = rebdif_10to12 + 1> 
		</cfif>

		<cfif rebdif13p is 1>
			<cfset rebdif_13plus = rebdif_13plus + 1> 
		</cfif>


		<cfif todif13 is 1>
			<cfset todif_1to3 = todif_1to3 + 1> 
		</cfif>

		<cfif todif46 is 1>
			<cfset todif_4to6 = todif_4to6 + 1> 
		</cfif>

		<cfif todif79 is 1>
			<cfset todif_7to9 = todif_7to9 + 1> 
		</cfif>
		
		<cfif todif1012 is 1>
			<cfset todif_10to12 = todif_10to12 + 1> 
		</cfif>

		<cfif todif13p>
			<cfset todif_13plus = todif_13plus + 1> 
		</cfif>




		<cfif fgadif13 is 1>
			<cfset fgadif_1to3 = fgadif_1to3 + 1> 
		</cfif>

		<cfif fgadif46 is 1>
			<cfset fgadif_4to6 = fgadif_4to6 + 1> 
		</cfif>

		<cfif fgadif79 is 1>
			<cfset fgadif_7to9 = fgadif_7to9 + 1> 
		</cfif>
		
		<cfif fgadif1012 is 1>
			<cfset fgadif_10to12 = fgadif_10to12 + 1> 
		</cfif>

		<cfif fgadif13p is 1>
			<cfset fgadif_13plus = fgadif_13plus + 1> 
		</cfif>
	
		
</cfloop>

<cfset ct = Getinfo.recordcount>

<cfoutput>
<table width="100%" border="1">
<tr>
<td>&nbsp;</td>
<td>1-3</td>
<td>4-6</td>
<td>7-9</td>
<td>10-12</td>
<td>13+</td>
<td>Overall</td>
</tr>

<tr>
<td>FG%</td>
<td>#(FGpctdif_1to3/ct)*100#</td>
<td>#(FGpctdif_4to6/ct)*100#</td>
<td>#(FGpctdif_7to9/ct)*100#</td>
<td>#(FGpctdif_10to12/ct)*100#</td>
<td>#(FGpctdif_13plus/ct)*100#</td>
<td>#(FGpctdif_1to3/ct)*100 + (FGpctdif_4to6/ct)*100 + (FGpctdif_7to9/ct)*100 + (FGpctdif_10to12/ct)*100 + (FGpctdif_13plus/ct)*100#</td>
</tr>
<tr>
<tr>
<td>FGAtt</td>
<td>#(FGAdif_1to3/ct)*100#</td>
<td>#(FGAdif_4to6/ct)*100#</td>
<td>#(FGAdif_7to9/ct)*100#</td>
<td>#(FGAdif_10to12/ct)*100#</td>
<td>#(FGAdif_13plus/ct)*100#</td>
<td>#(FGAdif_1to3/ct)*100 + (FGAdif_4to6/ct)*100 + (FGAdif_7to9/ct)*100 + (FGAdif_10to12/ct)*100 + (FGAdif_13plus/ct)*100#</td>
</tr>
<tr>
<td>REB</td>
<td>#(Rebdif_1to3/ct)*100#</td>
<td>#(Rebdif_4to6/ct)*100#</td>
<td>#(Rebdif_7to9/ct)*100#</td>
<td>#(Rebdif_10to12/ct)*100#</td>
<td>#(Rebdif_13plus/ct)*100#</td>
<td>#(Rebdif_1to3/ct)*100 + (Rebdif_4to6/ct)*100 + (Rebdif_7to9/ct)*100 + (Rebdif_10to12/ct)*100 + (Rebdif_13plus/ct)*100#</td>
</tr>
<tr>
<td>3pt Made</td>
<td>#(tpmdif_1to3/ct)*100#</td>
<td>#(tpmdif_4to6/ct)*100#</td>
<td>#(tpmdif_7to9/ct)*100#</td>
<td>#(tpmdif_10to12/ct)*100#</td>
<td>#(tpmdif_13plus/ct)*100#</td>
<td>#(tpmdif_1to3/ct)*100 + (tpmdif_4to6/ct)*100 + (tpmdif_7to9/ct)*100 + (tpmdif_10to12/ct)*100 + (tpmdif_13plus/ct)*100#</td>
</tr>

<tr>
<td>FT Made</td>
<td>#(ftmdif_1to3/ct)*100#</td>
<td>#(ftmdif_4to6/ct)*100#</td>
<td>#(ftmdif_7to9/ct)*100#</td>
<td>#(ftmdif_10to12/ct)*100#</td>
<td>#(ftmdif_13plus/ct)*100#</td>
<td>#(Ftmdif_1to3/ct)*100 + (Ftmdif_4to6/ct)*100 + (Ftmdif_7to9/ct)*100 + (Ftmdif_10to12/ct)*100 + (Ftmdif_13plus/ct)*100#</td>
</tr>

<tr>
<td>TOs</td>
<td>#(todif_1to3/ct)*100#</td>
<td>#(todif_4to6/ct)*100#</td>
<td>#(todif_7to9/ct)*100#</td>
<td>#(todif_10to12/ct)*100#</td>
<td>#(todif_13plus/ct)*100#</td>
<td>#(todif_1to3/ct)*100 + (todif_4to6/ct)*100 + (todif_7to9/ct)*100 + (todif_10to12/ct)*100 + (todif_13plus/ct)*100#</td>
</tr>


</table>


</cfoutput>

