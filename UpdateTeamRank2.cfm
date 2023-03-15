<cfset Gametime = Session.Gametime2>
<cfoutput>
#Session.gametime2#
</cfoutput>



<cfquery datasource="NBA" name="GetAvgs">
SELECT Team,AVG(PS) as aoPS, AVG(dps) as aDPS
FROM NBADATA
WHERE GAMETIME >= '20171015' AND GAMETIME < '#gametime#'
GROUP BY TEAM
</cfquery>


<cfloop query="GetAvgs">

	<cfset theteam = '#GetAvgs.Team#'>

	--Get opponents and game data
	<cfquery datasource="NBA" Name="GetOpp">
	Select * from NBADATA Where Team='#theteam#'
	and gametime < '#gametime#'
	</cfquery>

	<cfset GameCt       = 0>
	<cfset FifteenPlus = 0>
	<cfset ElevenTo14    = 0>
	<cfset SevenTo10    = 0>
	<cfset FourTo6      = 0>
	<cfset OneTo3       = 0>
	<cfset PSBetter     = 0>
	<cfset DPSBetter    = 0>
	<cfset dFifteenPlus = 0>
	<cfset dElevenTo14   = 0>
	<cfset dSevenTo10    = 0>
	<cfset dFourTo6      = 0>
	<cfset dOneTo3       = 0>
	
	<cfset wFifteenPlus = 0>
	<cfset wElevenTo14    = 0>
	<cfset wSevenTo10    = 0>
	<cfset wFourTo6      = 0>
	<cfset wOneTo3       = 0>
	<cfset PSWorse     = 0>
	<cfset DPSWorse    = 0>
	<cfset dwFifteenPlus = 0>
	<cfset dwElevenTo14   = 0>
	<cfset dwSevenTo10    = 0>
	<cfset dwFourTo6      = 0>
	<cfset dwOneTo3       = 0>
	
	<cfset aOffBetter     = arraynew(1)>
	<cfset aOffWorse      = arraynew(1)>
	
	<cfset aDefBetter     = arraynew(1)>
	<cfset aDefWorse      = arraynew(1)>
	
	<cfloop index="x" from="1" to="22">
		<cfset aOffBetter[x]     = 0>
		<cfset aOffWorse[x]      = 0>
	
		<cfset aDefBetter[x]     = 0>
		<cfset aDefWorse[x]      = 0>
	</cfloop>
	
	
	
	<cfloop query="GetOpp">
	
		-- Get the Opponents Avgs
		<cfquery dbtype="query" name="GetoppAvg">
		Select aOPS, aDPS
		from GetAvgs
		Where Team = '#GetOpp.Opp#'
		</cfquery>
	
		-- See how team did versus Opponents averages (+ is good minus bad)
		<cfset psDiff  = round(Getopp.ps - GetOppAvg.aDPS)>
		<cfset dpsDiff = round(GetOppAvg.aOPS - Getopp.dps)>
		
		<cfset GameCt = GameCt + 1>
		
		-- Scored MORE than what Opp avg on defense usually allows
		<cfif psdiff gt 0>
			<cfset PSBetter = PSBetter + 1>
		
			-- See how much better the team did versus opp avg
			<cfif psDiff gt 21>
				<cfset aOffBetter[22] = aOffBetter[22] + 1>
			<cfelseif psDiff eq 21> 
				<cfset aOffBetter[21] = aOffBetter[21] + 1>
			<cfelseif psDiff eq 20> 
				<cfset aOffBetter[20] = aOffBetter[20] + 1>
			<cfelseif psDiff eq 19> 
				<cfset aOffBetter[19] = aOffBetter[19] + 1>
			<cfelseif psDiff eq 18> 
				<cfset aOffBetter[18] = aOffBetter[18] + 1>
			<cfelseif psDiff eq 17> 
				<cfset aOffBetter[17] = aOffBetter[17] + 1>
			<cfelseif psDiff eq 16> 
				<cfset aOffBetter[16] = aOffBetter[16] + 1>
			<cfelseif psDiff eq 15> 
				<cfset aOffBetter[15] = aOffBetter[15] + 1>
			<cfelseif psDiff eq 14> 
				<cfset aOffBetter[14] = aOffBetter[14] + 1>
			<cfelseif psDiff eq 13> 
				<cfset aOffBetter[13] = aOffBetter[13] + 1>
			<cfelseif psDiff eq 12> 
				<cfset aOffBetter[12] = aOffBetter[12] + 1>
			<cfelseif psDiff eq 11> 
				<cfset aOffBetter[11] = aOffBetter[11] + 1>
			<cfelseif psDiff eq 10> 
				<cfset aOffBetter[10] = aOffBetter[10] + 1>
			<cfelseif psDiff eq 9> 
				<cfset aOffBetter[9] = aOffBetter[9] + 1>
			<cfelseif psDiff eq 8> 
				<cfset aOffBetter[8] = aOffBetter[8] + 1>
			<cfelseif psDiff eq 7> 
				<cfset aOffBetter[7] = aOffBetter[7] + 1>
			<cfelseif psDiff eq 6> 
				<cfset aOffBetter[6] = aOffBetter[6] + 1>
			<cfelseif psDiff eq 5> 
				<cfset aOffBetter[5] = aOffBetter[5] + 1>
			<cfelseif psDiff eq 4> 
				<cfset aOffBetter[4] = aOffBetter[4] + 1>
			<cfelseif psDiff eq 3> 
				<cfset aOffBetter[3] = aOffBetter[3] + 1>
			<cfelseif psDiff eq 2> 
				<cfset aOffBetter[2] = aOffBetter[2] + 1>
			<cfelseif psDiff eq 1> 
				<cfset aOffBetter[1] = aOffBetter[1] + 1>

			<cfelse>
				<p>
				<cfoutput>
				error1:Offense Not found for #theteam#...#Getopp.opp#...#psdiff#!!!
				</cfoutput>	
				<p>
			</cfif>
				
		</cfif>		
			
		-- Gave up LESS than what Opp avg on offense usually gets
		<cfif dpsdiff gt 0>
			<cfset dPSBetter = dPSBetter + 1>
		
			-- See how much better the team did versus opp avg
			<cfif dpsDiff gte 15>
				<cfset dFifteenPlus = dFifteenPlus + 1>
			<cfelseif dpsDiff gte 11> 
				<cfset dElevenTo14 = dElevenTo14 + 1>
			<cfelseif dpsDiff gte 7> 
				<cfset dSevenTo10 = dSevenTo10 + 1>
			<cfelseif dpsDiff gte 4 >
				<cfset dFourTo6 = dFourTo6 + 1>
			<cfelseif dpsDiff gte 0 >
				<cfset dOneTo3 = dOneTo3 + 1>
			<cfelse>
				<p>
				<cfoutput>
				Defense Not found for #theteam#..#Getopp.opp#...#dpsdiff#!!!
				</cfoutput>
				<p>
			</cfif>
				
			<cfif dpsDiff gt 21>
				<cfset aDefBetter[22] = aDefBetter[22] + 1>
			<cfelseif dpsDiff eq 21> 
				<cfset aDefBetter[21] = aDefBetter[21] + 1>
			<cfelseif dpsDiff eq 20> 
				<cfset aDefBetter[20] = aDefBetter[20] + 1>
			<cfelseif dpsDiff eq 19> 
				<cfset aDefBetter[19] = aDefBetter[19] + 1>
			<cfelseif dpsDiff eq 18> 
				<cfset aDefBetter[18] = aDefBetter[18] + 1>
			<cfelseif dpsDiff eq 17> 
				<cfset aDefBetter[17] = aDefBetter[17] + 1>
			<cfelseif dpsDiff eq 16> 
				<cfset aDefBetter[16] = aDefBetter[16] + 1>
			<cfelseif dpsDiff eq 15> 
				<cfset aDefBetter[15] = aDefBetter[15] + 1>
			<cfelseif dpsDiff eq 14> 
				<cfset aDefBetter[14] = aDefBetter[14] + 1>
			<cfelseif dpsDiff eq 13> 
				<cfset aDefBetter[13] = aDefBetter[13] + 1>
			<cfelseif dpsDiff eq 12> 
				<cfset aDefBetter[12] = aDefBetter[12] + 1>
			<cfelseif dpsDiff eq 11> 
				<cfset aDefBetter[11] = aDefBetter[11] + 1>
			<cfelseif dpsDiff eq 10> 
				<cfset aDefBetter[10] = aDefBetter[10] + 1>
			<cfelseif dpsDiff eq 9> 
				<cfset aDefBetter[9] = aDefBetter[9] + 1>
			<cfelseif dpsDiff eq 8> 
				<cfset aDefBetter[8] = aDefBetter[8] + 1>
			<cfelseif dpsDiff eq 7> 
				<cfset aDefBetter[7] = aDefBetter[7] + 1>
			<cfelseif dpsDiff eq 6> 
				<cfset aDefBetter[6] = aDefBetter[6] + 1>
			<cfelseif dpsDiff eq 5> 
				<cfset aDefBetter[5] = aDefBetter[5] + 1>
			<cfelseif dpsDiff eq 4> 
				<cfset aDefBetter[4] = aDefBetter[4] + 1>
			<cfelseif dpsDiff eq 3> 
				<cfset aDefBetter[3] = aDefBetter[3] + 1>
			<cfelseif dpsDiff eq 2> 
				<cfset aDefBetter[2] = aDefBetter[2] + 1>
			<cfelseif dpsDiff eq 1> 
				<cfset aDefBetter[1] = aDefBetter[1] + 1>

			<cfelse>
				<p>
				<cfoutput>
				Error2:Offense Not found for #theteam#...#Getopp.opp#...#dpsDiff#!!!
				</cfoutput>	
				<p>
			</cfif>
				
				
				
		</cfif>		
		


		-- Scored LESS than what Opp avg on defense usually allows
		<cfif psdiff lt 0>
			<cfset PSWorse = PSWorse + 1>
		
			-- See how much worse the team did versus opp avg
			<cfif psDiff lte -15>
				<cfset wFifteenPlus = wFifteenPlus + 1>
			<cfelseif psDiff lte -11> 
				<cfset wElevenTo14 = wElevenTo14 + 1>
			<cfelseif psDiff lte -7> 
				<cfset wSevenTo10 = wSevenTo10 + 1>
			<cfelseif psDiff lte -4> 
				<cfset wFourTo6 = wFourTo6 + 1>
			<cfelseif psDiff lte 0> 
				<cfset wOneTo3 = wOneTo3 + 1>
			<cfelse>
				<p>
				<cfoutput>
				Offense Not found for #theteam#...#Getopp.opp#...#psdiff#!!!
				</cfoutput>	
				<p>
			</cfif>
				
			<cfif psDiff lt -21>
				<cfset aOffWorse[22] = aOffWorse[22] + 1>
			<cfelseif psDiff eq -21> 
				<cfset aOffWorse[21] = aOffWorse[21] + 1>
			<cfelseif psDiff eq -20> 
				<cfset aOffWorse[20] = aOffWorse[20] + 1>
			<cfelseif psDiff eq -19> 
				<cfset aOffWorse[19] = aOffWorse[19] + 1>
			<cfelseif psDiff eq -18> 
				<cfset aOffWorse[18] = aOffWorse[18] + 1>
			<cfelseif psDiff eq -17> 
				<cfset aOffWorse[17] = aOffWorse[17] + 1>
			<cfelseif psDiff eq -16> 
				<cfset aOffWorse[16] = aOffWorse[16] + 1>
			<cfelseif psDiff eq -15> 
				<cfset aOffWorse[15] = aOffWorse[15] + 1>
			<cfelseif psDiff eq -14> 
				<cfset aOffWorse[14] = aOffWorse[14] + 1>
			<cfelseif psDiff eq -13> 
				<cfset aOffWorse[13] = aOffWorse[13] + 1>
			<cfelseif psDiff eq -12> 
				<cfset aOffWorse[12] = aOffWorse[12] + 1>
			<cfelseif psDiff eq -11> 
				<cfset aOffWorse[11] = aOffWorse[11] + 1>
			<cfelseif psDiff eq -10> 
				<cfset aOffWorse[10] = aOffWorse[10] + 1>
			<cfelseif psDiff eq -9> 
				<cfset aOffWorse[9] = aOffWorse[9] + 1>
			<cfelseif psDiff eq -8> 
				<cfset aOffWorse[8] = aOffWorse[8] + 1>
			<cfelseif psDiff eq -7> 
				<cfset aOffWorse[7] = aOffWorse[7] + 1>
			<cfelseif psDiff eq -6> 
				<cfset aOffWorse[6] = aOffWorse[6] + 1>
			<cfelseif psDiff eq -5> 
				<cfset aOffWorse[5] = aOffWorse[5] + 1>
			<cfelseif psDiff eq -4> 
				<cfset aOffWorse[4] = aOffWorse[4] + 1>
			<cfelseif psDiff eq -3> 
				<cfset aOffWorse[3] = aOffWorse[3] + 1>
			<cfelseif psDiff eq -2> 
				<cfset aOffWorse[2] = aOffWorse[2] + 1>
			<cfelseif psDiff eq -1> 
				<cfset aOffWorse[1] = aOffWorse[1] + 1>

			<cfelse>
				<p>
				<cfoutput>
				ERROR3:Offense Not found for #theteam#...#Getopp.opp#...#psdiff#!!!
				</cfoutput>	
				<p>
			</cfif>			
				
		</cfif>		
			
		-- Gave up MORE than what Opp avg on offense usually gets
		<cfif dpsdiff lt 0>
			<cfset dPSWorse = dPSWorse + 1>
		
			-- See how much worse the team did versus opp avg
			<cfif dpsDiff lte -15>
				<cfset dwFifteenPlus = dwFifteenPlus + 1>
			<cfelseif dpsDiff lte -11> 
				<cfset dwElevenTo14 = dwElevenTo14 + 1>
			<cfelseif dpsDiff lte -7> 
				<cfset dwSevenTo10 = dwSevenTo10 + 1>
			<cfelseif dpsDiff lte -4 >
				<cfset dwFourTo6 = dwFourTo6 + 1>
			<cfelseif dpsDiff lte 0 >
				<cfset dwOneTo3 = dwOneTo3 + 1>
			<cfelse>
				<p>
				<cfoutput>
				Defense Not found for #theteam#..#Getopp.opp#...#dpsdiff#!!!
				</cfoutput>
				<p>
			</cfif>
				
			<cfif dpsDiff lt -21>
				<cfset aDefWorse[22] = aDefWorse[22] + 1>
			<cfelseif dpsDiff eq -21> 
				<cfset aDefWorse[21] = aDefWorse[21] + 1>
			<cfelseif dpsDiff eq -20> 
				<cfset aDefWorse[20] = aDefWorse[20] + 1>
			<cfelseif dpsDiff eq -19> 
				<cfset aDefWorse[19] = aDefWorse[19] + 1>
			<cfelseif dpsDiff eq -18> 
				<cfset aDefWorse[18] = aDefWorse[18] + 1>
			<cfelseif dpsDiff eq -17> 
				<cfset aDefWorse[17] = aDefWorse[17] + 1>
			<cfelseif dpsDiff eq -16> 
				<cfset aDefWorse[16] = aDefWorse[16] + 1>
			<cfelseif dpsDiff eq -15> 
				<cfset aDefWorse[15] = aDefWorse[15] + 1>
			<cfelseif dpsDiff eq -14> 
				<cfset aDefWorse[14] = aDefWorse[14] + 1>
			<cfelseif dpsDiff eq -13> 
				<cfset aDefWorse[13] = aDefWorse[13] + 1>
			<cfelseif dpsDiff eq -12> 
				<cfset aDefWorse[12] = aDefWorse[12] + 1>
			<cfelseif dpsDiff eq -11> 
				<cfset aDefWorse[11] = aDefWorse[11] + 1>
			<cfelseif dpsDiff eq -10> 
				<cfset aDefWorse[10] = aDefWorse[10] + 1>
			<cfelseif dpsDiff eq -9> 
				<cfset aDefWorse[9] = aDefWorse[9] + 1>
			<cfelseif dpsDiff eq -8> 
				<cfset aDefWorse[8] = aDefWorse[8] + 1>
			<cfelseif dpsDiff eq -7> 
				<cfset aDefWorse[7] = aDefWorse[7] + 1>
			<cfelseif dpsDiff eq -6> 
				<cfset aDefWorse[6] = aDefWorse[6] + 1>
			<cfelseif dpsDiff eq -5> 
				<cfset aDefWorse[5] = aDefWorse[5] + 1>
			<cfelseif dpsDiff eq -4> 
				<cfset aDefWorse[4] = aDefWorse[4] + 1>
			<cfelseif dpsDiff eq -3> 
				<cfset aDefWorse[3] = aDefWorse[3] + 1>
			<cfelseif dpsDiff eq -2> 
				<cfset aDefWorse[2] = aDefWorse[2] + 1>
			<cfelseif dpsDiff eq -1> 
				<cfset aDefWorse[1] = aDefWorse[1] + 1>

			<cfelse>
				<p>
				<cfoutput>
				Error4:Offense Not found for #theteam#...#Getopp.opp#...#dpsdiff#!!!
				</cfoutput>	
				<p>
			</cfif>			
				
		</cfif>		
				
	</cfloop>			
	
	-- Create the percentages
	<cfset offBetterPct = 100*(PSBetter / GameCt)>
	<cfset offpct1 = 100*(FifteenPlus / PsBetter)>
	<cfset offpct2 = 100*(ElevenTo14 / PsBetter)>
	<cfset offpct3 = 100*(SevenTo10 / PsBetter)>
	<cfset offpct4 = 100*(FourTo6 / PsBetter)>
	<cfset offpct5 = 100*(OneTo3 / PsBetter)>
		
	<cfset offBetterpct1 = 100*(aOffBetter[1] / PsBetter)>	
	<cfset offBetterpct2 = 100*(aOffBetter[2] / PsBetter)>	
	<cfset offBetterpct3 = 100*(aOffBetter[3] / PsBetter)>	
	<cfset offBetterpct4 = 100*(aOffBetter[4] / PsBetter)>	
	<cfset offBetterpct5 = 100*(aOffBetter[5] / PsBetter)>	
	<cfset offBetterpct6 = 100*(aOffBetter[6] / PsBetter)>	
	<cfset offBetterpct7 = 100*(aOffBetter[7] / PsBetter)>	
	<cfset offBetterpct8 = 100*(aOffBetter[8] / PsBetter)>	
	<cfset offBetterpct9 = 100*(aOffBetter[9] / PsBetter)>	
	<cfset offBetterpct10 = 100*(aOffBetter[10] / PsBetter)>	
	<cfset offBetterpct11 = 100*(aOffBetter[11] / PsBetter)>	
	<cfset offBetterpct12 = 100*(aOffBetter[12] / PsBetter)>	
	<cfset offBetterpct13 = 100*(aOffBetter[13] / PsBetter)>	
	<cfset offBetterpct14 = 100*(aOffBetter[14] / PsBetter)>	
	<cfset offBetterpct15 = 100*(aOffBetter[15] / PsBetter)>	
	<cfset offBetterpct16 = 100*(aOffBetter[16] / PsBetter)>	
	<cfset offBetterpct17 = 100*(aOffBetter[17] / PsBetter)>	
	<cfset offBetterpct18 = 100*(aOffBetter[18] / PsBetter)>	
	<cfset offBetterpct19 = 100*(aOffBetter[19] / PsBetter)>	
	<cfset offBetterpct20 = 100*(aOffBetter[20] / PsBetter)>	
	<cfset offBetterpct21 = 100*(aOffBetter[21] / PsBetter)>	
	<cfset offBetterpct22 = 100*(aOffBetter[22] / PsBetter)>	
	
	<cfset offWorsepct1 = 100*(aOffWorse[1] / PsWorse)>	
	<cfset offWorsepct2 = 100*(aOffWorse[2] / PsWorse)>	
	<cfset offWorsepct3 = 100*(aOffWorse[3] / PsWorse)>	
	<cfset offWorsepct4 = 100*(aOffWorse[4] / PsWorse)>	
	<cfset offWorsepct5 = 100*(aOffWorse[5] / PsWorse)>	
	<cfset offWorsepct6 = 100*(aOffWorse[6] / PsWorse)>	
	<cfset offWorsepct7 = 100*(aOffWorse[7] / PsWorse)>	
	<cfset offWorsepct8 = 100*(aOffWorse[8] / PsWorse)>	
	<cfset offWorsepct9 = 100*(aOffWorse[9] / PsWorse)>	
	<cfset offWorsepct10 = 100*(aOffWorse[10] / PsWorse)>	
	<cfset offWorsepct11 = 100*(aOffWorse[11] / PsWorse)>	
	<cfset offWorsepct12 = 100*(aOffWorse[12] / PsWorse)>	
	<cfset offWorsepct13 = 100*(aOffWorse[13] / PsWorse)>	
	<cfset offWorsepct14 = 100*(aOffWorse[14] / PsWorse)>	
	<cfset offWorsepct15 = 100*(aOffWorse[15] / PsWorse)>	
	<cfset offWorsepct16 = 100*(aOffWorse[16] / PsWorse)>	
	<cfset offWorsepct17 = 100*(aOffWorse[17] / PsWorse)>	
	<cfset offWorsepct18 = 100*(aOffWorse[18] / PsWorse)>	
	<cfset offWorsepct19 = 100*(aOffWorse[19] / PsWorse)>	
	<cfset offWorsepct20 = 100*(aOffWorse[20] / PsWorse)>	
	<cfset offWorsepct21 = 100*(aOffWorse[21] / PsWorse)>	
	<cfset offWorsepct22 = 100*(aOffWorse[22] / PsWorse)>	
	

	<cfset DefBetterpct1 = 100*(aDefBetter[1] / dPsBetter)>	
	<cfset DefBetterpct2 = 100*(aDefBetter[2] / dPsBetter)>	
	<cfset DefBetterpct3 = 100*(aDefBetter[3] / dPsBetter)>	
	<cfset DefBetterpct4 = 100*(aDefBetter[4] / dPsBetter)>	
	<cfset DefBetterpct5 = 100*(aDefBetter[5] / dPsBetter)>	
	<cfset DefBetterpct6 = 100*(aDefBetter[6] / dPsBetter)>	
	<cfset DefBetterpct7 = 100*(aDefBetter[7] / dPsBetter)>	
	<cfset DefBetterpct8 = 100*(aDefBetter[8] / dPsBetter)>	
	<cfset DefBetterpct9 = 100*(aDefBetter[9] / dPsBetter)>	
	<cfset DefBetterpct10 = 100*(aDefBetter[10] / dPsBetter)>	
	<cfset DefBetterpct11 = 100*(aDefBetter[11] / dPsBetter)>	
	<cfset DefBetterpct12 = 100*(aDefBetter[12] / dPsBetter)>	
	<cfset DefBetterpct13 = 100*(aDefBetter[13] / dPsBetter)>	
	<cfset DefBetterpct14 = 100*(aDefBetter[14] / dPsBetter)>	
	<cfset DefBetterpct15 = 100*(aDefBetter[15] / dPsBetter)>	
	<cfset DefBetterpct16 = 100*(aDefBetter[16] / dPsBetter)>	
	<cfset DefBetterpct17 = 100*(aDefBetter[17] / dPsBetter)>	
	<cfset DefBetterpct18 = 100*(aDefBetter[18] / dPsBetter)>	
	<cfset DefBetterpct19 = 100*(aDefBetter[19] / dPsBetter)>	
	<cfset DefBetterpct20 = 100*(aDefBetter[20] / dPsBetter)>	
	<cfset DefBetterpct21 = 100*(aDefBetter[21] / dPsBetter)>	
	<cfset DefBetterpct22 = 100*(aDefBetter[22] / dPsBetter)>	


	<cfset DefWorsepct1 = 100*(aDefWorse[1] / dPsWorse)>	
	<cfset DefWorsepct2 = 100*(aDefWorse[2] / dPsWorse)>	
	<cfset DefWorsepct3 = 100*(aDefWorse[3] / dPsWorse)>	
	<cfset DefWorsepct4 = 100*(aDefWorse[4] / dPsWorse)>	
	<cfset DefWorsepct5 = 100*(aDefWorse[5] / dPsWorse)>	
	<cfset DefWorsepct6 = 100*(aDefWorse[6] / dPsWorse)>	
	<cfset DefWorsepct7 = 100*(aDefWorse[7] / dPsWorse)>	
	<cfset DefWorsepct8 = 100*(aDefWorse[8] / dPsWorse)>	
	<cfset DefWorsepct9 = 100*(aDefWorse[9] / dPsWorse)>	
	<cfset DefWorsepct10 = 100*(aDefWorse[10] / dPsWorse)>	
	<cfset DefWorsepct11 = 100*(aDefWorse[11] / dPsWorse)>	
	<cfset DefWorsepct12 = 100*(aDefWorse[12] / dPsWorse)>	
	<cfset DefWorsepct13 = 100*(aDefWorse[13] / dPsWorse)>	
	<cfset DefWorsepct14 = 100*(aDefWorse[14] / dPsWorse)>	
	<cfset DefWorsepct15 = 100*(aDefWorse[15] / dPsWorse)>	
	<cfset DefWorsepct16 = 100*(aDefWorse[16] / dPsWorse)>	
	<cfset DefWorsepct17 = 100*(aDefWorse[17] / dPsWorse)>	
	<cfset DefWorsepct18 = 100*(aDefWorse[18] / dPsWorse)>	
	<cfset DefWorsepct19 = 100*(aDefWorse[19] / dPsWorse)>	
	<cfset DefWorsepct20 = 100*(aDefWorse[20] / dPsWorse)>	
	<cfset DefWorsepct21 = 100*(aDefWorse[21] / dPsWorse)>	
	<cfset DefWorsepct22 = 100*(aDefWorse[22] / dPsWorse)>	
		
	<cfset defBetterPct = 100*(dPSBetter / GameCt)>
	<cfset defpct1 = 100*(dFifteenPlus / dPsBetter)>
	<cfset defpct2 = 100*(dElevenTo14 / dPsBetter)>
	<cfset defpct3 = 100*(dSevenTo10 / dPsBetter)>
	<cfset defpct4 = 100*(dFourTo6 / dPsBetter)>
	<cfset defpct5 = 100*(dOneTo3 / dPsBetter)>
		
	<cfset offWorsePct = 100*(PSworse / GameCt)>
	<cfset woffpct1 = 100*(wFifteenPlus / PsWorse)>
	<cfset woffpct2 = 100*(wElevenTo14 / PsWorse)>
	<cfset woffpct3 = 100*(wSevenTo10 / PsWorse)>
	<cfset woffpct4 = 100*(wFourTo6 / PsWorse)>
	<cfset woffpct5 = 100*(wOneTo3 / PsWorse)>
		
	<cfset defWorsePct = 100*(dPSWorse / GameCt)>
	<cfset wdefpct1 = 100*(dwFifteenPlus / dPsWorse)>
	<cfset wdefpct2 = 100*(dwElevenTo14 / dPsWorse)>
	<cfset wdefpct3 = 100*(dwSevenTo10 / dPsWorse)>
	<cfset wdefpct4 = 100*(dwFourTo6 / dPsWorse)>
	<cfset wdefpct5 = 100*(dwOneTo3 / dPsWorse)>
	
	<cfquery dbtype="query" name="GetTeamAvg">
		Select aOPS, aDPS
		from GetAvgs
		Where Team = '#theteam#'
	</cfquery>
	
	<cfquery datasource="NBA" name="UpdIt">
	UPDATE TeamRank
	SET offBetterPct = #offBetterPct#,
	OFFBetter1 = #OFFBetterPct1#, 
	OFFBetter2 = #OFFBetterPct2#, 
	OFFBetter3 = #OFFBetterPct3#, 
	OFFBetter4 = #OFFBetterPct4#, 
	OFFBetter5 = #OFFBetterPct5#, 
	OFFBetter6 = #OFFBetterPct6#, 
	OFFBetter7 = #OFFBetterPct7#, 
	OFFBetter8 = #OFFBetterPct8#, 
	OFFBetter9 = #OFFBetterPct9#, 
	OFFBetter10 = #OFFBetterPct10#, 
	OFFBetter11 = #OFFBetterPct11#, 
	OFFBetter12 = #OFFBetterPct12#, 
	OFFBetter13 = #OFFBetterPct13#, 
	OFFBetter14 = #OFFBetterPct14#, 
	OFFBetter15 = #OFFBetterPct15#, 
	OFFBetter16 = #OFFBetterPct16#, 
	OFFBetter17 = #OFFBetterPct17#, 
	OFFBetter18 = #OFFBetterPct18#, 
	OFFBetter19 = #OFFBetterPct19#, 
	OFFBetter20 = #OFFBetterPct20#, 
	OFFBetter21 = #OFFBetterPct21#, 
	OFFBetter22 = #OFFBetterPct22#,
	DefBetter1 = #DefBetterPct1#, 
	DefBetter2 = #DefBetterPct2#, 
	DefBetter3 = #DefBetterPct3#, 
	DefBetter4 = #DefBetterPct4#, 
	DefBetter5 = #DefBetterPct5#, 
	DefBetter6 = #DefBetterPct6#, 
	DefBetter7 = #DefBetterPct7#, 
	DefBetter8 = #DefBetterPct8#, 
	DefBetter9 = #DefBetterPct9#, 
	DefBetter10 = #DefBetterPct10#, 
	DefBetter11 = #DefBetterPct11#, 
	DefBetter12 = #DefBetterPct12#, 
	DefBetter13 = #DefBetterPct13#, 
	DefBetter14 = #DefBetterPct14#, 
	DefBetter15 = #DefBetterPct15#, 
	DefBetter16 = #DefBetterPct16#, 
	DefBetter17 = #DefBetterPct17#, 
	DefBetter18 = #DefBetterPct18#, 
	DefBetter19 = #DefBetterPct19#, 
	DefBetter20 = #DefBetterPct20#, 
	DefBetter21 = #DefBetterPct21#, 
	DefBetter22 = #DefBetterPct22#,	
	OFFWorse1 = #OFFWorsePct1#, 
	OFFWorse2 = #OFFWorsePct2#, 
	OFFWorse3 = #OFFWorsePct3#, 
	OFFWorse4 = #OFFWorsePct4#, 
	OFFWorse5 = #OFFWorsePct5#, 
	OFFWorse6 = #OFFWorsePct6#, 
	OFFWorse7 = #OFFWorsePct7#, 
	OFFWorse8 = #OFFWorsePct8#, 
	OFFWorse9 = #OFFWorsePct9#, 
	OFFWorse10 = #OFFWorsePct10#, 
	OFFWorse11 = #OFFWorsePct11#, 
	OFFWorse12 = #OFFWorsePct12#, 
	OFFWorse13 = #OFFWorsePct13#, 
	OFFWorse14 = #OFFWorsePct14#, 
	OFFWorse15 = #OFFWorsePct15#, 
	OFFWorse16 = #OFFWorsePct16#, 
	OFFWorse17 = #OFFWorsePct17#, 
	OFFWorse18 = #OFFWorsePct18#, 
	OFFWorse19 = #OFFWorsePct19#, 
	OFFWorse20 = #OFFWorsePct20#, 
	OFFWorse21 = #OFFWorsePct21#, 
	OFFWorse22 = #OFFWorsePct22#,
	DefWorse1 = #DefWorsePct1#, 
	DefWorse2 = #DefWorsePct2#, 
	DefWorse3 = #DefWorsePct3#, 
	DefWorse4 = #DefWorsePct4#, 
	DefWorse5 = #DefWorsePct5#, 
	DefWorse6 = #DefWorsePct6#, 
	DefWorse7 = #DefWorsePct7#, 
	DefWorse8 = #DefWorsePct8#, 
	DefWorse9 = #DefWorsePct9#, 
	DefWorse10 = #DefWorsePct10#, 
	DefWorse11 = #DefWorsePct11#, 
	DefWorse12 = #DefWorsePct12#, 
	DefWorse13 = #DefWorsePct13#, 
	DefWorse14 = #DefWorsePct14#, 
	DefWorse15 = #DefWorsePct15#, 
	DefWorse16 = #DefWorsePct16#, 
	DefWorse17 = #DefWorsePct17#, 
	DefWorse18 = #DefWorsePct18#, 
	DefWorse19 = #DefWorsePct19#, 
	DefWorse20 = #DefWorsePct20#, 
	DefWorse21 = #DefWorsePct21#, 
	DefWorse22 = #DefWorsePct22#,		
	
	oFifteenPlus = #offpct1#,
	oElevenTo14 = #offpct2#,
	oSevenTo10 = #offpct3#,
	oFourTo6 = #offpct4#,
	oOneTo3 = #offpct5#,
	AvgPS   = #GetTeamAvg.aOPS#,
	
	DefBetterPct = #DefBetterPct#,
	dFifteenPlus = #defpct1#,
	dElevenTo14 = #defpct2#,
	dSevenTo10 = #defpct3#,
	dFourTo6 = #defpct4#,
	dOneTo3 = #defpct5#,
	AvgDPS = #GetTeamAvg.adPS#,
	
	offWorsePct = #offWorsePct#,
	owFifteenPlus = #woffpct1#,
	owElevenTo14 = #woffpct2#,
	owSevenTo10 = #woffpct3#,
	owFourTo6 = #woffpct4#,
	owOneTo3 = #woffpct5#,
		
	DefWorsePct = #DefWorsePct#,
	dwFifteenPlus = #wdefpct1#,
	dwElevenTo14 = #wdefpct2#,
	dwSevenTo10 = #wdefpct3#,
	dwFourTo6 = #wdefpct4#,
	dwOneTo3 = #wdefpct5#
		
	WHERE TEAM = '#theteam#'
	AND gametime = '#gametime#'
	</cfquery>
	
	
</cfloop>

<cfinclude template="AlgoForOU.cfm">
	
	
	
	
	





