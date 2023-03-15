<cfset fav='BKN'>
<cfset Und='UTA'>
<cfset theTotal = 207.5>
<cfset theSpd   = 2>

<cfif 1 is 1>
<cfset fav='CLE'>
<cfset Und='LAC'>
<cfset theTotal = 222>
<cfset theSpd   = 6.5>
</cfif>

<cfset VegasFAVPredScore = (theTotal/2) + (thespd/2)>
<cfset VegasUNDPredScore = (theTotal/2) - (thespd/2)>

<cfquery Datasource="NBA" Name="GetFAVRank">
Select * from TeamRank Where Team = '#fav#'
</cfquery>
 
<cfquery Datasource="NBA" Name="GetUNDRank">
Select * from TeamRank Where Team = '#und#'
</cfquery>

<cfset FavAvgOffPS = GetFAVRank.AvgPS>
<cfset FavAvgDefPS = GetFAVRank.AvgDPS>

<cfset UndAvgOffPS = GetUndRank.AvgPS>
<cfset UndAvgDefPS = GetUndRank.AvgDPS>
<cfset FavOffOver = 0>
<cfset UndOffOver = 0>
<cfset FavOffUnder = 0>
<cfset UndOffUnder = 0>
<cfset FavDefOver = 0>
<cfset UndDefOver = 0>
<cfset FavDefUnder = 0>
<cfset UndDefUnder = 0>

 --- Favorite Expected to more likely score more than opponents avg defense<br>
 <cfif GetFavRank.OffBetterPct gte GetFavRank.OffWorsePct>
	Fav OffBetterPct gte GetFavRank.OffWorsePct<br>
	<cfif Abs((UndAvgDefPs + 15) - (VegasFAVPredScore)) gte 3>
		FAV Abs((UndAvgDefPs + 15) - (VegasFAVPredScore)) lte 3<br>
	     <cfset FavOffOver = FavOffOver + GetFavRank.oFifteenPlus>
	</cfif>
	<cfif (UndAvgDefPs + 11) gt VegasFAVPredScore>
		FAV (UndAvgDefPs + 11) gt VegasFAVPredScore<br>
		<cfset FavOffOver = FavOffOver + GetFavRank.oElevenTo14>
	</cfif>
	<cfif (UndAvgDefPs + 7) gt VegasFAVPredScore>
		FAV (UndAvgDefPs + 7) gt VegasFAVPredScore<br>
		<cfset FavOffOver = FavOffOver + GetFavRank.oSevenTo10>
	</cfif>
	<cfif (UndAvgDefPs + 4) gt VegasFAVPredScore>
		FAV (UndAvgDefPs + 4) gt VegasFAVPredScore<br>
		<cfset FavOffOver = FavOffOver + GetFavRank.oFourTo6>
	</cfif>
	<cfif (UndAvgDefPs + 1) gt VegasFAVPredScore>
		FAV (UndAvgDefPs + 1) gt VegasFAVPredScore<br>
		<cfset FavOffOver = FavOffOver + GetFavRank.oOneTo3>
	</cfif>
</cfif>

<cfoutput>	
FavOffOver = #FavOffOver#<br>
The confidence of #fav# going OVER #VegasFAVPredScore# is #(FavOffOver/100)* (GetFavRank.OffBetterPct/100)#<br>

<cfif 1 is 2>
<cfif (FavOffOver/100)* (GetFavRank.OffBetterPct/100) gte .50>
	The confidence of #fav# going OVER #VegasFAVPredScore# is #(FavOffOver/100)* (GetFavRank.OffBetterPct/100)#<br>
<cfelse>
	<cfif FavOffOver gt 0>
    The confidence of #fav# going UNDER #VegasFAVPredScore# is #1 - ((FavOffOver/100)* (GetFavRank.OffBetterPct/100))#<br>
	</cfif>
</cfif>	
</cfif>

</cfoutput>	


--- Favorite Expected to more likely score LESS than opponents avg defense<br>
 <cfif GetFavRank.OffBetterPct lt GetFavRank.OffWorsePct>
  
	<cfif Abs((UndAvgDefPs - 15) - (VegasFavPredScore)) lte 3>
	1<br>
	     <cfset FavOffUnder = FavOffUnder + GetFavRank.owFifteenPlus>
	</cfif>
	<cfif (UndAvgDefPs - 11) lt VegasFavPredScore>
	2<br>
		<cfset FavOffUnder = FavOffUnder + GetFavRank.owElevenTo14>
	</cfif>
	<cfif (UndAvgDefPs - 7) lt VegasFavPredScore>
	3<br>
		<cfset FavOffUnder = FavOffUnder + GetFavRank.owSevenTo10>
	</cfif>
	<cfif (FavAvgDefPs - 4) lt VegasFavPredScore>
	4<br>
		<cfset FavOffUnder = FavOffUnder + GetFavRank.owFourTo6>
	</cfif>
	<cfif (FavAvgDefPs - 1) lt VegasFavPredScore>
	5<br>
		<cfset FavOffUnder = FavOffUnder + GetFavRank.owOneTo3>
	</cfif>
</cfif>


--- Underdog Expected to more likely score more than opponents avg defense<br>
 <cfif GetUndRank.OffBetterPct gte GetUndRank.OffWorsePct>
	<cfif Abs((FavAvgDefPs + 15) - (VegasUndPredScore)) gte 3>
	     <cfset UndOffOver = UndOffOver + GetUndRank.oFifteenPlus>
	</cfif>
	<cfif (FavAvgDefPs + 11) gt VegasUndPredScore>
		<cfset UndOffOver = UndOffOver + GetUndRank.oElevenTo14>
	</cfif>
	<cfif (FavAvgDefPs + 7) gt VegasUndPredScore>
		<cfset UndOffOver = UndOffOver + GetUndRank.oSevenTo10>
	</cfif>
	<cfif (FavAvgDefPs + 4) gt VegasUndPredScore>
		<cfset UndOffOver = UndOffOver + GetUndRank.oFourTo6>
	</cfif>
	<cfif (FavAvgDefPs + 1) gt VegasUndPredScore>
		<cfset UndOffOver = UndOffOver + GetUndRank.oOneTo3>
	</cfif>
</cfif>

107.1 vs 103.75<p>
--- Underdog Expected to more likely score LESS than opponents avg defense<br>
 <cfif GetUndRank.OffBetterPct lt GetUndRank.OffWorsePct>
  
	<cfif Abs((FavAvgDefPs - 15) - (VegasUndPredScore)) lte 3>
	1<br>
	     <cfset UndOffUnder = UndOffUnder + GetUndRank.owFifteenPlus>
	</cfif>
	<cfif (FavAvgDefPs - 11) lt VegasUndPredScore>
	2<br>
		<cfset UndOffUnder = UndOffUnder + GetUndRank.owElevenTo14>
	</cfif>
	<cfif (FavAvgDefPs - 7) lt VegasUndPredScore>
	3<br>
		<cfset UndOffUnder = UndOffUnder + GetUndRank.owSevenTo10>
	</cfif>
	<cfif (FavAvgDefPs - 4) lt VegasUndPredScore>
	4<br>
		<cfset UndOffUnder = UndOffUnder + GetUndRank.owFourTo6>
	</cfif>
	<cfif (FavAvgDefPs - 1) lt VegasUndPredScore>
	5<br>
		<cfset UndOffUnder = UndOffUnder + GetUndRank.owOneTo3>
	</cfif>
</cfif>




<cfoutput>
#UndOffUnder#<br>
<cfif (UndOffOver/100)* (GetUndRank.OffBetterPct/100) gte .50>
	The confidence of #und# going OVER #VegasUndPredScore# is #(UndOffOver/100)* (GetUndRank.OffBetterPct/100)#<br>
<cfelse>
	<cfif UndOffOver gt 0>
    The confidence of #und# going UNDER #VegasUndPredScore# is #1-((UndOffOver/100)* (GetUndRank.OffBetterPct/100))#<br>
	</cfif>
</cfif>	

<cfif (UndOffUnder/100)* (GetUndRank.OffWorsePct/100) gte .50>
111<br>
	The confidence of #und# going UNDER #VegasUndPredScore# is #(UndOffUnder/100)* (GetUndRank.OffWorsePct/100)#<br>
<cfelse>
	<cfif UndOffUnder gt 0>
222<br>
    The confidence of #und# going OVER #VegasUndPredScore# is #(UndOffUnder/100)* (GetUndRank.OffWorsePct/100)#<br>
	</cfif>
</cfif>	






------------- Defense Fav-----------------------------------------------------------------------------------<br>
 --- Favorite Expected to more likely give up LESS than opponents avg offense<br>
 <cfif GetFavRank.DefBetterPct gte GetFavRank.DefWorsePct>
	Fav DefBetterPct gte GetFavRank.DefWorsePct<br>
	<cfif (UndAvgOffPs - 15) lt VegasUNDPredScore>
		FAV Abs((UndAvgOffPs - 15) - (VegasFAVPredScore)) lte 3<br>
	     <cfset FavDefUnder = FavDefUnder + GetFavRank.dFifteenPlus>
	</cfif>
	<cfif  (UndAvgOffPs - 11) lt VegasUndPredScore>
		FAV (UndAvgOffPs + 11) lt VegasUNDPredScore<br>
		<cfset FavDefUnder = FavDefUnder + GetFavRank.dElevenTo14>
	</cfif>
	<cfif (UndAvgOffPs - 7) lt VegasUNDPredScore>
		FAV (UndAvgOffPs + 7) lt VegasUNDPredScore<br>
		<cfset FavDefUnder = FavDefUnder + GetFavRank.dSevenTo10>
	</cfif>
	<cfif (UndAvgOffPs - 4) lt VegasUNDPredScore>
		FAV (UndAvgOffPs + 4) lt VegasUNDPredScore<br>
		<cfset FavDefUnder = FavDefUnder + GetFavRank.dFourTo6>
	</cfif>
	<cfif (UndAvgOffPs - 1) lt VegasUNDPredScore>
		FAV (UndAvgOffPs + 1) lt VegasUNDPredScore<br>
		<cfset FavDefUnder = FavDefUnder + GetFavRank.dOneTo3>
	</cfif>
</cfif>

 --- Favorite Expected to more likely give up MORE than opponents avg offense<br>
 <cfif GetFavRank.DefBetterPct lt GetFavRank.DefWorsePct>
	Fav DefBetterPct lt GetFavRank.DefWorsePct<br>
	<cfif (UndAvgOffPs + 15) gt VegasUndPredScore>
		FAV Abs((UndAvgDefPs - 15) - (VegasUndPredScore)) lte 3<br>
	     <cfset FavDefOver = FavDefOver + GetFavRank.dwFifteenPlus>
	</cfif>
	<cfif  (UndAvgOffPs + 11) gt VegasUndPredScore>
		FAV (UndAvgOffPs + 11) gt VegasUNDPredScore<br>
		<cfset FavDefOver = FavDefOver + GetFavRank.dwElevenTo14>
	</cfif>
	<cfif (UndAvgOffPs + 7) gt VegasUNDPredScore>
		FAV (UndAvgOffPs + 7) gt VegasUNDPredScore<br>
		<cfset FavDefOver = FavDefOver + GetFavRank.dwSevenTo10>
	</cfif>
	<cfif (UndAvgOffPs + 4) gt VegasUNDPredScore>
		FAV (UndAvgOffPs + 4) gt VegasUNDPredScore<br>
		<cfset FavDefOver = FavDefOver + GetFavRank.dwFourTo6>
	</cfif>
	<cfif (UndAvgOffPs + 1) gt VegasUNDPredScore>
		FAV (UndAvgOffPs + 1) gt VegasUNDPredScore<br>
		<cfset FavDefOver = FavDefOver + GetFavRank.dwOneTo3>
	</cfif>
</cfif>




------------- Defense Und-----------------------------------------------------------------------------------<br>
 --- Underdog Expected to more likely give up LESS than opponents avg offense<br>
 <cfif GetUndRank.DefBetterPct gte GetUndRank.DefWorsePct>
	UND DefBetterPct gte GetUndRank.DefWorsePct<br>
	<cfif (FAVAvgOffPs + 15) lt VegasFAVPredScore>
		UND Abs((FAVAvgOffPs - 15) - (VegasFAVPredScore)) lte 3<br>
	     <cfset UNDDefUnder = UNDDefUnder + GetUNDRank.dFifteenPlus>
	</cfif>
	<cfif  (FAVAvgOffPs - 11) lt VegasFAVPredScore>
		UND (FAVAvgOffPs + 11) lt VegasFAVPredScore<br>
		<cfset UNDDefUnder = UNDDefUnder + GetUNDRank.dElevenTo14>
	</cfif>
	<cfif (FAVAvgOffPs - 7) lt VegasFAVPredScore>
		UND (FAVAvgOffPs + 7) lt VegasFAVPredScore<br>
		<cfset UNDDefUnder = UNDDefUnder + GetUNDRank.dSevenTo10>
	</cfif>
	<cfif (FAVAvgOffPs - 4) lt VegasFAVPredScore>
		UND (FAVAvgOffPs + 4) lt VegasFAVPredScore<br>
		<cfset UNDDefUnder = UNDDefUnder + GetUNDRank.dFourTo6>
	</cfif>
	<cfif (FAVAvgOffPs - 1) lt VegasFAVPredScore>
		UND (FAVAvgOffPs + 1) lt VegasFAVPredScore<br>
		<cfset UndDefUnder = UndDefUnder + GetUndRank.dOneTo3>
	</cfif>
</cfif>

 --- Underdog Expected to more likely give up MORE than opponents avg offense<br>
 <cfif GetUndRank.DefBetterPct lt GetUndRank.DefWorsePct>
	UND DefBetterPct lt GetUndRank.DefWorsePct<br>
	<cfif (VegasFAVPredScore + 15) gt UndAvgOffPs>
		Abs( (VegasFAVPredScore) - (UndAvgOffPs - 15))  lte 3<br>
	     <cfset UndDefOver = UndDefOver + GetUndRank.dwFifteenPlus>
	</cfif>
	<cfif  (FAVAvgOffPs + 11) gt VegasFAVPredScore>
		UND (FAVAvgOffPs + 11) gt VegasFAVPredScore<br>
		<cfset UndDefOver = UndDefOver + GetUndRank.dwElevenTo14>
	</cfif>
	<cfif (FAVAvgOffPs + 7) gt VegasFAVPredScore>
		UND (FAVAvgOffPs + 7) gt VegasFAVPredScore<br>
		<cfset UndDefOver = UndDefOver + GetUndRank.dwSevenTo10>
	</cfif>
	<cfif (FAVAvgOffPs + 4) gt VegasFAVPredScore>
		UND (FAVAvgOffPs + 4) gt VegasFAVPredScore<br>
		<cfset UndDefOver = UndDefOver + GetUndRank.dwFourTo6>
	</cfif>
	<cfif (FAVAvgOffPs + 1) gt VegasFAVPredScore>
		UND (FAVAvgOffPs + 1) gt VegasFAVPredScore<br>
		<cfset UndDefOver = UndDefOver + GetUndRank.dwOneTo3>
	</cfif>
</cfif>






<cfoutput>	
FavOffOver = #FavOffOver#<br>
The confidence of #fav# going OVER #VegasFAVPredScore# is #(FavOffOver/100)* (GetFavRank.OffBetterPct/100)#<br>

<cfif 1 is 2>
<cfif (FavOffOver/100)* (GetFavRank.OffBetterPct/100) gte .50>
	The confidence of #fav# going OVER #VegasFAVPredScore# is #(FavOffOver/100)* (GetFavRank.OffBetterPct/100)#<br>
<cfelse>
	<cfif FavOffOver gt 0>
    The confidence of #fav# going UNDER #VegasFAVPredScore# is #1 - ((FavOffOver/100)* (GetFavRank.OffBetterPct/100))#<br>
	</cfif>
</cfif>	
</cfif>

</cfoutput>	


--- Favorite Expected to more likely score LESS than opponents avg defense<br>
 <cfif GetFavRank.OffBetterPct lt GetFavRank.OffWorsePct>
  
	<cfif Abs((UndAvgDefPs - 15) - (VegasFavPredScore)) lte 3>
	1<br>
	     <cfset FavOffUnder = FavOffUnder + GetFavRank.owFifteenPlus>
	</cfif>
	<cfif (UndAvgDefPs - 11) lt VegasFavPredScore>
	2<br>
		<cfset FavOffUnder = FavOffUnder + GetFavRank.owElevenTo14>
	</cfif>
	<cfif (UndAvgDefPs - 7) lt VegasFavPredScore>
	3<br>
		<cfset FavOffUnder = FavOffUnder + GetFavRank.owSevenTo10>
	</cfif>
	<cfif (FavAvgDefPs - 4) lt VegasFavPredScore>
	4<br>
		<cfset FavOffUnder = FavOffUnder + GetFavRank.owFourTo6>
	</cfif>
	<cfif (FavAvgDefPs - 1) lt VegasFavPredScore>
	5<br>
		<cfset FavOffUnder = FavOffUnder + GetFavRank.owOneTo3>
	</cfif>
</cfif>





FavOffOver  = #FavOffOver#<br>
FavOffUnder = #FavOffUnder#<br>
UndOffOver  = #UndOffOver#<br>
UndOffUnder = #UndOffUnder#<br>

FavDefOver  = #FavDefOver#<br>
FavDefUnder = #FavDefUnder#<br>
UndDefOver  = #UndDefOver#<br>
UndDefUnder = #UndDefUnder#<br>




<cfif FavOffOver gt FavOffUnder>
	The confidence of #fav# going OVER #VegasFAVPredScore# is #(FavOffOver/100)* (GetFavRank.OffBetterPct/100)#<br>
</cfif>	
	
<cfif FavOffUnder gte FavOffOver>
	The confidence of #fav# going UNDER #VegasFAVPredScore# is #(FavOffUnder/100)* (GetFavRank.OffWorsePct/100)#<br>
</cfif>	
	
<cfif UndOffOver gt UndOffUnder>
	The confidence of #und# going OVER #VegasUNDPredScore# is #(UndOffOver/100)* (GetUndRank.OffBetterPct/100)#<br>
</cfif>	
	
<cfif UndOffUnder gte UndOffOver>
	The confidence of #und# going UNDER #VegasUNDPredScore# is #(UndOffUnder/100)* (GetUndRank.OffWorsePct/100)#<br>
</cfif>	
	

	
	
<cfif FavDefOver gt FavDefUnder>
	The confidence of #fav# giving up MORE than #VegasUNDPredScore# is #(FavDefOver/100)* (GetFavRank.DefWorsePct/100)#<br>
</cfif>	
	
<cfif FavDefUnder gte FavDefOver>
	The confidence of #fav# giving up LESS than #VegasUNDPredScore# is #(FavDefUnder/100)* (GetFavRank.DefBetterPct/100)#<br>
</cfif>	
	
<cfif UndDefOver gt UndDefUnder>
	The confidence of #und# giving up MORE than #VegasFAVPredScore# is #(UndDefOver/100)* (GetUndRank.DefWorsePct/100)#<br>
</cfif>	
	
<cfif UndDefUnder gte UndDefOver>
	The confidence of #und# giving up LESS than #VegasFAVPredScore# is #(UndDefUnder/100)* (GetUndRank.DefBetterPct/100)#<br>
</cfif>	

</cfoutput>	
<cfabort>































<cfset Gametime = '20171117'>

<cfquery datasource="NBA" name="GetAvgs">
SELECT Team,AVG(PS) as aoPS, AVG(dps) as aDPS
FROM NBADATA
WHERE GAMETIME < '#gametime#'
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
	
	
	
	<cfloop query="GetOpp">
	
		-- Get the Opponents Avgs
		<cfquery dbtype="query" name="GetoppAvg">
		Select aOPS, aDPS
		from GetAvgs
		Where Team = '#GetOpp.Opp#'
		</cfquery>
	
		-- See how team did versus Opponents averages (+ is good minus bad)
		<cfset psDiff  = Getopp.ps - GetOppAvg.aDPS>
		<cfset dpsDiff = GetOppAvg.aOPS - Getopp.dps>
		
		<cfset GameCt = GameCt + 1>
		
		-- Scored MORE than what Opp avg on defense usually allows
		<cfif psdiff gt 0>
			<cfset PSBetter = PSBetter + 1>
		
			-- See how much better the team did versus opp avg
			<cfif psDiff gte 15>
				<cfset FifteenPlus = FifteenPlus + 1>
			<cfelseif psDiff gte 11> 
				<cfset ElevenTo14 = ElevenTo14 + 1>
			<cfelseif psDiff gte 7> 
				<cfset SevenTo10 = SevenTo10 + 1>
			<cfelseif psDiff gte 4> 
				<cfset FourTo6 = FourTo6 + 1>
			<cfelseif psDiff gte 0> 
				<cfset OneTo3 = OneTo3 + 1>
			<cfelse>
				<p>
				<cfoutput>
				Offense Not found for #theteam#...#Getopp.opp#...#psdiff#!!!
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
				
		</cfif>		

		


		-- Scored MORE than what Opp avg on defense usually allows
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
				
		</cfif>		
				
	</cfloop>			
	
	-- Create the percentages
	<cfset offBetterPct = 100*(PSBetter / GameCt)>
	<cfset offpct1 = 100*(FifteenPlus / PsBetter)>
	<cfset offpct2 = 100*(ElevenTo14 / PsBetter)>
	<cfset offpct3 = 100*(SevenTo10 / PsBetter)>
	<cfset offpct4 = 100*(FourTo6 / PsBetter)>
	<cfset offpct5 = 100*(OneTo3 / PsBetter)>
		
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


<cfset theTotal = 215.5>
<cfset theSpd   = 7.5>
<cfset VegasFAVPredScore = (theTotal/2) + (thespd/2)>
<cfset VegasUNDPredScore = (theTotal/2) - (thespd/2)>

<cfquery Datasource="NBA" Name="GetFAVRank">
Select * from TeamRank Where Team = '#fav#'
</cfquery>
 
<cfquery Datasource="NBA" Name="GetUNDRank">
Select * from TeamRank Where Team = '#und#'
</cfquery>

<cfset FavAvgOffPS = GetFAVRank.AvgPS>
<cfset FavAvgDefPS = GetFAVRank.AvgDPS>

<cfset UndAvgOffPS = GetUndRank.AvgPS>
<cfset UndAvgDefPS = GetUndRank.AvgDPS>


 --- Favorite Expected to more likely score more than opponents avg defense
 <cfif GetFavRank.OffBetterPct gte GetFavRank.OffWorsePct>
	<cfif Abs((UndAvgDefPs + 15) - (VegasFAVPredScore)) lte 3>
	     <cfset FavOffOver = FavOffOver + GetFavRank.oFifteenPlus>
	</cfif>
	<cfif (UndAvgDefPs + 11) gt VegasFAVPredScore>
		<cfset FavOffOver = FavOffOver + GetFavRank.oElevenTo14>
	</cfif>
	<cfif (UndAvgDefPs + 7) gt VegasFAVPredScore>
		<cfset FavOffOver = FavOffOver + GetFavRank.oSevenTo10>
	</cfif>
	<cfif (UndAvgDefPs + 4) gt VegasFAVPredScore>
		<cfset FavOffOver = FavOffOver + GetFavRank.oFourTo6>
	</cfif>
	<cfif (UndAvgDefPs + 1) gt VegasFAVPredScore>
		<cfset FavOffOver = FavOffOver + GetFavRank.oOneTo3>
	</cfif>
</cfif>
	
<cfif (FavOffOver/100)* (GetFavRank.OffBetterPct/100) gte .50>
	The confidence of #fav# going OVER #VegasFAVPredScore# is #(FavOffOver/100)* (GetFavRank.OffBetterPct/100)#
<cfelse>
    The confidence of #fav# going UNDER #VegasFAVPredScore# is #(FavOffOver/100)* (GetFavRank.OffBetterPct/100)#
</cfif>	
	
--- Underdog Expected to more likely score more than opponents avg defense
 <cfif GetUndRank.OffBetterPct gte GetUndRank.OffWorsePct>
	<cfif Abs((FavAvgDefPs + 15) - (VegasUndPredScore)) lte 3>
	     <cfset UndOffOver = UndOffOver + GetUndRank.oFifteenPlus>
	</cfif>
	<cfif (FavAvgDefPs + 11) gt VegasUndPredScore>
		<cfset UndOffOver = UndOffOver + GetUndRank.oElevenTo14>
	</cfif>
	<cfif (FavAvgDefPs + 7) gt VegasUndPredScore>
		<cfset UndOffOver = UndOffOver + GetUndRank.oSevenTo10>
	</cfif>
	<cfif (FavAvgDefPs + 4) gt VegasUndPredScore>
		<cfset UndOffOver = UndOffOver + GetUndRank.oFourTo6>
	</cfif>
	<cfif (FavAvgDefPs + 1) gt VegasUndPredScore>
		<cfset UndOffOver = UndOffOver + GetUndRank.oOneTo3>
	</cfif>
</cfif>

<cfif (UndOffOver/100)* (GetUndRank.OffBetterPct/100) gte .50>
	The confidence of #und# going OVER #VegasUndPredScore# is #(UndOffOver/100)* (GetUndRank.OffBetterPct/100)#
<cfelse>
    The confidence of #und# going UNDER #VegasUndPredScore# is #(UndOffOver/100)* (GetUndRank.OffBetterPct/100)#
</cfif>	
	

Take Total 215.5 and divide by 2 = 107.75
Take spread 7.5 and divide by 2  = 3.75
FAV Vegas Predicted Score = 107.75 + 3.75 = 111.5
UND Vegas Predicted Score = 107.75 - 3.75 = 103.75

Now we want to see the liklihood that GSW goes OVER 111.5
	1. Check OffBetterPct 78.5% and OffWorsePct 21.4%
		1.1 More likely to go OVER Boston's Def Avg DPS of 94.75
			1.1.1 There is a 78.5% chance GSW scores MORE than 94.75			
            1.2.1 There is a 45.45% chance GSW scores 15+ MORE (at least 109.75)
            1.2.2 There is a 18.2% chance GSW scores 11 - 14 MORE (105.75 )
            1.2.3 There is a 27.3% chance GSW scores 7-10 MORE (101.75 )
            1.2.4 There is a 0% chance GSW scores 4-6 MORE (98.75 )
            1.2.5 There is a 9.1% chance GSW scores 1-3 MORE (95.75)
So we have a 78.5% liklihhod GSW scores OVER 94.75 and (.45*.78.5) 35.3% of going Over 111.5 so we have a 64.7% liklihood GSW scores less than 111.5
			
			

Now we want to see the liklihood that BOS goes OVER 103.75
	1. Check OffBetterPct 37.5% and OffWorsePct 62.5%
		1.1 More likely to go UNDER Warriors Def Avg DPS of 107.1
			1.1.1 There is a 62.5% chance BOS scores LESS than 107.1			
            1.2.1 There is a 30.0% chance BOS scores 15+ LESS (92 or worse)
            1.2.2 There is a 20.0% chance BOS scores 11 - 14 LESS (96)
            1.2.3 There is a 20.0% chance BOS scores 7-10 LESS (100)
            1.2.4 There is a 20.0% chance BOS scores 4-6 LESS (103)
            1.2.5 There is a 10.0% chance BOS scores 1-3 LESS (106)
So we have 62.5% liklihood Boston scores UNDER 107.1 and (.90*.62) 55.8% liklihood Boston scores less than 103.75 



Now we want to see the liklihood that GSW defense gives up more than BOS AvgPS (101.37)
	1. Check DefBetterPct 35.7% and DefWorsePct 64.3%
		1.1 More likely to go OVER Boston's Off Avg PS of 101.37
			1.1.1 There is a 64.3% chance BOS scores MORE than 101.37			
            1.2.1 There is a 11.1% chance BOS scores 15+ MORE (at least 116)
            1.2.2 There is a 0.0% chance BOS scores 11 - 14 MORE (112.75 )
            1.2.3 There is a 33.3% chance BOS scores 7-10 MORE (108.37 )
            1.2.4 There is a 22.2% chance BOS scores 4-6 MORE (105.37 )
            1.2.5 There is a 33.3% chance BOS scores 1-3 MORE (102.37)
So we have a 64.3% liklihhod BOS scores OVER 101.37 and (.643*.66) 42.2% of going Over 103.75 so we have a 42.2% liklihood BOS scores MORE than 103.75
			
			

			111.5
Now we want to see the liklihood that BOS defense gives up more that GSW AvgPS (115.3)
	1. Check DefBetterPct 87.5% and DefWorsePct 12.5%
		1.1 More likely to go UNDER Warriors Off Avg PS of 115.3
			1.1.1 There is a 87.5% chance GSW scores LESS than 115.3			
            1.2.1 There is a 42.9% chance GSW scores 15+ LESS (100 or worse)
            1.2.2 There is a 0.0% chance GSW scores 11 - 14 LESS (104)
            1.2.3 There is a 42.8% chance GSW scores 7-10 LESS (108)
            1.2.4 There is a 14.3% chance GSW scores 4-6 LESS (111)
            1.2.5 There is a 0.0% chance GSW scores 1-3 LESS (114)
So we have 87.5% liklihood GSW scores UNDER 115.3 and (.87*1) 87.5% liklihood GSW scores less than 111.5 




So we have a 78.5% liklihhod GSW scores OVER 94.75 and (.45*.78.5) 35.3% of going Over 111.5 so we have a 64.7% liklihood GSW scores less than 111.5
So we have 62.5% liklihood Boston scores UNDER 107.1 and (.90*.62) 55.8% liklihood Boston scores less than 103.75 
So we have a 64.3% liklihhod BOS scores OVER 101.37 and (.643*.66) 42.2% of going Over 103.75 so we have a 42.2% liklihood BOS scores MORE than 103.75
So we have 87.5% liklihood GSW scores UNDER 115.3 and (.87*1) 87.5% liklihood GSW scores less than 111.5 

so we have a 64.7% liklihood GSW scores less than 111.5
87.5% liklihood GSW scores less than 111.5

55.8% liklihood Boston scores less than 103.75
57.8% liklihood BOS scores Less than 103.75







So we have a (64.7 + 55.8)/2 = 60.3% chance we get an UNDER 215.5
BOS 92
GSW 88









