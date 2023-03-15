 
<!--- 
 
<cfquery datasource="Nba" name="xGetit">
	Update FinalPicks
	Set Sys24 = ''
</cfquery>

<cfquery datasource="Nba" name="xGetit">
	Update FinalPicks
	Set Sys36 = ''
</cfquery>


<cfquery datasource="Nba" name="xGetit">
	Update FinalPicks
	Set Sys11 = ''
</cfquery>

<cfquery datasource="Nba" name="xGetit">
	Update FinalPicks
	Set Sys12 = ''
</cfquery>

<cfquery datasource="Nba" name="xGetit">
	Update FinalPicks
	Set Sys9 = ''
</cfquery>

<cfquery datasource="Nba" name="xGetit">
	Update FinalPicks
	Set Sys33 = ''
</cfquery>
 --->
 
<cfinclude template="LastSevenHealth2016.cfm">

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('ShowPicksWithSituation: Ran LastSevenHealth2016.cfm')
</cfquery>

<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>

	
<cfset w = 0>
<cfset l = 0>


<cfset sw = 0>
<cfset sl = 0>

<cfset apw = 0>
<cfset apl = 0>

<cfset flw = 0>
<cfset fll = 0>
  
<cfset w3star = 0>
<cfset l3star = 0>
 
<cfset w6star = 0>
<cfset l6star = 0>

<cfset wafupbigstar = 0>
<cfset lafupbigstar = 0>

<cfset BadSitFavw = 0>
<cfset BadSitFavl = 0>
  	
<!---  		
<cfloop index="ii" from="1" to = "30">

<cfif ii is 1>
	<cfset GameTime = '20141101'>
</cfif>

<cfif ii is 2>
	<cfset GameTime = '20141102'>
</cfif>

<cfif ii is 3>
	<cfset GameTime = '20141103'>
</cfif>

<cfif ii is 4>
	<cfset GameTime = '20141104'>
</cfif>

<cfif ii is 5>
	<cfset GameTime = '20141105'>
</cfif>

<cfif ii is 6>
	<cfset GameTime = '20141106'>
</cfif>

<cfif ii is 7>
	<cfset GameTime = '20141107'>
</cfif>

<cfif ii is 8>
	<cfset GameTime = '20141108'>
</cfif>

<cfif ii is 9>
	<cfset GameTime = '20141109'>
</cfif>

<cfif ii is 10>
	<cfset GameTime = '20141110'>
</cfif>

<cfif ii is 11>
	<cfset GameTime = '20141111'>
</cfif>

<cfif ii is 12>
	<cfset GameTime = '20141112'>
</cfif>

<cfif ii is 13>
	<cfset GameTime = '20141113'>
</cfif>

<cfif ii is 14>
	<cfset GameTime = '20141114'>
</cfif>

<cfif ii is 15>
	<cfset GameTime = '20141115'>
</cfif>

<cfif ii is 16>
	<cfset GameTime = '20141116'>
</cfif>

<cfif ii is 17>
	<cfset GameTime = '20141117'>
</cfif>

<cfif ii is 18>
	<cfset GameTime = '20141118'>
</cfif>

<cfif ii is 19>
	<cfset GameTime = '20141119'>
</cfif>

<cfif ii is 20>
	<cfset GameTime = '20141120'>
</cfif>

<cfif ii is 21>
	<cfset GameTime = '20141121'>
</cfif>

<cfif ii is 22>
	<cfset GameTime = '20141122'>
</cfif>

<cfif ii is 23>
	<cfset GameTime = '20141123'>
</cfif>

<cfif ii is 24>
	<cfset GameTime = '20141124'>
</cfif>

<cfif ii is 25>
	<cfset GameTime = '20141125'>
</cfif>

<cfif ii is 26>
	<cfset GameTime = '20141126'>
</cfif>

<cfif ii is 27>
	<cfset GameTime = '20141127'>
</cfif>

<cfif ii is 28>
	<cfset GameTime = '20141128'>
</cfif>

<cfif ii is 29>
	<cfset GameTime = '20141129'>
</cfif>

<cfif ii is 30>
	<cfset GameTime = '20141130'>
</cfif>
--->



 


Get all the Teams
<cfquery datasource="Nba" name="Getit">
	Select *
	from FinalPicks
	where Gametime >= '20221022'
</cfquery>



<table width="100%" border="1" cellpadding="0" cellspacing="0">
<tr>
<td>Cov</td>	
<td>Fav</td>
<td>L2Cum</td>
<td>CumSpd</td>
<td>Health</td>
<td>CoverCt</td>
<td>NoCoverCt</td>

<td>L2CumScore</td>
<td>L2DefCumScore</td>
<td>L2PTDiff</td>
<Td>TotalPtsL2</td>

<td>LstTotPlays</td>
<td>LstLeadChgs</td>
<td>InLeadPct</td>
<Td>UpBig</td>
<Td>DwnBig</td>



<td>Spread</td>
<td>H/A</td>
<td>Und</td>
<td>L2Cum</td>
<td>CumSpd</td>
<td>Health</td>
<td>CoverCt</td>
<td>NoCoverCt</td>

<td>L2CumScore</td>
<td>L2DefCumScore</td>
<td>L2PTDiff</td>
<Td>TotalPtsL2</td>

<td>LstTotPlays</td>
<td>LstLeadChgs</td>
<td>InLeadPct</td>
<Td>UpBig</td>
<Td>DwnBig</td>

<td>SYS100</td>
<td>SYS40</td>
<td>SYS27</td>
<td>SYS19</td>

<td>SYS200</td>
<td>SYS2</td>
<td>SYS18</td>
<td>SYS23</td>
<td>SYS20</td>
<td>SYS15</td>
<td>SYS4</td>
<td>SYS34</td>
<td>SYS5</td>
</tr>
<cfoutput query="Getit">

<cfset FavBadSitCt = 0>
<cfset UNDBADSITCT = 0>

<cfquery datasource="Nba" name="GetFavsit">
	Select *
	from TeamSituation
	where Gametime = '#Getit.Gametime#'
	and Team = '#Getit.fav#'
</cfquery>

<cfquery datasource="Nba" name="GetUndsit">
	Select *
	from TeamSituation
	where Gametime = '#Getit.Gametime#'
	and Team = '#Getit.Und#'
</cfquery>



<cfif GetFavsit.recordcount gt 0 and GetUndsit.recordcount gt 0>

<cfif GetFavSit.Cumspd lte -5 and Getit.spd gte 8 >
Bet On #Getit.Und#...#Getit.Whocovered#
<hr>
</cfif>



<cfif (Getit.UndPlayedYest is 'N' and GetFavSit.LastTwoCumScore - GetFavSit.LastTwoDefScore gte 40) and GetFavSit.TeamHealth lte GetUndSit.TeamHealth >
Fav Letdown $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$<br>
Bet On #GetIt.Und#....#Getit.Whocovered#<br>
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$<br>

<cfquery datasource="Nba" name="xGetit">
	Update FinalPicks
	Set Sys12 = '#Getit.und#'
	where Gametime = '#Getit.Gametime#'
	and Fav = '#Getit.FAV#'
</cfquery>



<cfif Getit.Whocovered is Getit.Und >
	<cfset flw = flw + 1 >
	<cfoutput>
	Gametime:#gametime#.......Wins: #flw# Losses:#fll#<br>	
	</cfoutput>
<cfelseif Getit.Whocovered neq 'PUSH' >	
	<cfset fll = fll + 1 >
	<cfoutput>
	Gametime:#gametime#.......Wins: #flw# Losses:#fll#<br>	
	</cfoutput>
	
</cfif>	


</cfif> 


<cfif (GetFavSit.LastTwoCumScore - GetFavSit.LastTwoDefScore gte 35 and Getit.ha is 'A' and GetFavSit.TeamHealth lte GetUndSit.TeamHealth)>
<p>
AwayPowerhouse $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$<br>
Bet On #GetIt.Und#....#Getit.Whocovered#<br>
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$<br>

<cfquery datasource="Nba" name="xGetit">
	Update FinalPicks
	Set Sys11 = '#Getit.und#'
	where Gametime = '#Getit.Gametime#'
	and Fav = '#Getit.FAV#'
</cfquery>


<cfif Getit.Whocovered is Getit.Und >
	<cfset apw = apw + 1 >
	<cfoutput>
	Gametime:#gametime#.......Wins: #apw# Losses:#apl#<br>	
	</cfoutput>
<cfelseif Getit.Whocovered neq 'PUSH' >	
	<cfset apl = apl + 1 >
	<cfoutput>
	Gametime:#gametime#.......Wins: #apw# Losses:#apl#<br>	
	</cfoutput>
	
</cfif>	


<p>
</cfif>


<cfif Getit.FavPlayedYest is 'N' and GetFavSit.LASTTWOCUMSPD lt  GetFavSit.CUMSPD and (GetFavSit.LASTTWOCUMSPD lt 0 and GetFavSit.CUMSPD lt 0 ) and Getit.spd lte 10 and (GetFavSit.CUMSPD - GetFavSit.LASTTWOCUMSPD lte 13)  >
***Bet On #Getit.FAV#...#Getit.Whocovered#.....Difference: #GetFavSit.CUMSPD - GetFavSit.LASTTWOCUMSPD#...spd:#getit.spd#
<hr>

<cfif Getit.Whocovered is Getit.fav >
	<cfset w3star = w3star + 1 >
	
	333333333333333Gametime:#gametime#.......Wins: #w3star# Losses:#l3star#<br>	
	
<cfelseif Getit.Whocovered neq 'PUSH' >	
	<cfset l3star = l3star + 1 >
	
	3333333333333333Gametime:#gametime#.......Wins: #w3star# Losses:#l3star#<br>	
	
	
</cfif>	
<cfquery datasource="Nba" name="xGetit">
	Update FinalPicks
	Set Sys33 = '#Getit.fav#'
	where Gametime = '#Getit.Gametime#'
	and Fav = '#Getit.FAV#'
</cfquery>	

</cfif>



<cfif (GetFavSit.TeamHealth gte GetUndSit.TeamHealth) and GetFavSit.LASTTWOCUMSPD lt  GetFavSit.CUMSPD and (GetFavSit.LASTTWOCUMSPD lt 0 and GetFavSit.CUMSPD lt 0 ) and Getit.spd lte 10 and (GetFavSit.CUMSPD - GetFavSit.LASTTWOCUMSPD lte 13)  >
<cfif Getit.FavPlayedYest is 'N' >
<p>
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@<br>
***plusHealth Bet On #Getit.FAV#...#Getit.Whocovered#.....Difference: #GetFavSit.CUMSPD - GetFavSit.LASTTWOCUMSPD#...spd:#getit.spd#<br>
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@<br>
<p>
<cfquery datasource="Nba" name="xGetit">
	Update FinalPicks
	Set Sys36 = '#Getit.FAV#'
	where Gametime = '#Getit.Gametime#'
	and Fav = '#Getit.FAV#'
</cfquery>
</cfif>

<cfif Getit.Whocovered is Getit.FAV >
	<cfset w = w + 1 >
	
	Gametime:#gametime#.......Wins: #w# Losses:#l#<br>	
	
<cfelseif Getit.Whocovered neq 'PUSH' >	
	<cfset l = l + 1 >
	
	Gametime:#gametime#.......Wins: #w# Losses:#l#<br>	
	
	
</cfif>	
		
<hr>
</cfif>

 
<cfif Getit.FavPlayedYest is 'N' and GetFavSit.TeamHealth gt 0 and GetFavSit.LASTTWOCUMSPD lt  GetFavSit.CUMSPD and (GetFavSit.LASTTWOCUMSPD lt 0 and GetFavSit.CUMSPD lt 0 ) and Getit.spd lte 10 and (GetFavSit.CUMSPD - GetFavSit.LASTTWOCUMSPD lte 13)  >
******Bet On #Getit.FAV#...#Getit.Whocovered#.....Difference: #GetFavSit.CUMSPD - GetFavSit.LASTTWOCUMSPD#...spd:#getit.spd#
<hr>

<cfif Getit.Whocovered is Getit.fav >
	<cfset w6star = w6star + 1 >
	
	Gametime:66666666666666666#gametime#.......Wins: #w6star# Losses:#l6star#<br>	
	
<cfelseif Getit.Whocovered neq 'PUSH' >	
	<cfset l6star = l6star + 1 >
	
	Gametime:66666666666666666#gametime#.......Wins: #w6star# Losses:#l6star#<br>	
	
	
</cfif>	


</cfif>








<cfset FavHlthBG = ''>
<cfset UndHlthBG = ''>

<cfset FavCovBG = ''>
<cfset UndCovhBG = ''>

<cfset FavCovBG = ''>
<cfset UndCovBG = ''>
<cfset FavNoCovBG = ''>
<cfset UndNoCovBG = ''>



<cfset FavL2BG = ''>
<cfset UndL2BG = ''>

<cfif GetFavSit.LatestNoCoverCt gte 3 >
	<cfset FavNoCovBG = 'green'>
</cfif>

<cfif GetUndSit.LatestNoCoverCt gte 3 >
	<cfset UndNoCovBG = 'green'>
</cfif>

<cfif GetFavSit.LatestCoverCt gte 3 >
	<cfset FavCovBG = 'red'>
	<cfset FavBadSitCt = FavBadSitCt + 1>
</cfif>

<cfif GetUndSit.LatestCoverCt gte 3 >
	<cfset UndCovBG = 'red'>
	<cfset UndBadSitCt = UndBadSitCt + 1>
</cfif>




<cfif GetFavSit.LastTwoCumSpd lte -30 >
	<cfset FavL2BG = 'green'>
</cfif>

<cfif GetUndSit.LastTwoCumSpd lte -30 >
	<cfset UndL2BG = 'green'>
</cfif>

<cfif GetFavSit.LastTwoCumSpd gte 30 >
	<cfset FavL2BG = 'red'>
	<cfset FavBadSitCt = FavBadSitCt + 1>

</cfif>

<cfif GetUndSit.LastTwoCumSpd gte 30 >
	<cfset UndL2BG = 'red'>
	<cfset UndBadSitCt = UndBadSitCt + 1>
</cfif>




<cfif GetFavSit.TeamHealth gte 5>
	<cfset FavHlthBG = 'green'>
</cfif>

<cfif GetFavSit.TeamHealth lte -5>
	<cfset FavHlthBG = 'red'>
	<cfset FavBadSitCt = FavBadSitCt + 1>

</cfif>

<cfif GetUndSit.TeamHealth gte 5>
	<cfset UndHlthBG = 'green'>
</cfif>

<cfif GetUndSit.TeamHealth lte -5>
	<cfset UndHlthBG = 'red'>
	<cfset UndBadSitCt = UndBadSitCt + 1>
</cfif>






<!--- If Away Favorite and last game they were up big for 10% or more of the game --->
<cfif GetFavSit.UpBigPct gte 10 and Getit.spd gte 7.5 and Getit.ha is 'A'>
********************************************* BINGO: #GetFavSit.UpBigPct#....PLAY ON #GetIt.Und# and Who covered was: #GetIt.Whocovered# ******************************************** <br>
<cfif Getit.Whocovered is Getit.Und >
	<cfset wafupbigstar = wafupbigstar + 1 >
	
	Gametime:#gametime#.......Wins: #wafupbigstar# Losses:#lafupbigstar#<br>	
	
<cfelseif Getit.Whocovered neq 'PUSH' >	
	<cfset lafupbigstar = lafupbigstar + 1 >
	
	Gametime:#gametime#.......Wins: #wafupbigstar# Losses:#lafupbigstar#<br>	
	

</cfif>	

<!---
<cfquery datasource="Nba" name="xGetit">
	Update FinalPicks
	Set Sys9 = '#Getit.und#'
	where Gametime = '#Gametime#'
	and Fav = '#Getit.FAV#'
</cfquery>	
 --->
</cfif>
<p>
<p>
<p>
<p>


 
<cfif (GetFavSit.LastTwoDefScore lt 180) and (GetFavSit.LastTwoDefScore + GetFavSit.LastTwoCumScore gte 300)   >


<cfif Getit.UndPlayedYest is 'N' and Getit.spd gte 4.5 and GetFavSit.TeamHealth lte GetUndSit.TeamHealth>
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%<br>
SUPER PLAY ON: #GetUndSit.Team#...#Getit.Whocovered#<br>
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%<br>


<cfif Getit.Whocovered is Getit.Und >
	<cfset sw = sw + 1 >
	<cfoutput>
	Gametime:#gametime#.......Wins: #sw# Losses:#sl#<br>	
	</cfoutput>
<cfelseif Getit.Whocovered neq 'PUSH' >	
	<cfset sl = sl + 1 >
	<cfoutput>
	Gametime:#gametime#.......Wins: #sw# Losses:#sl#<br>	
	</cfoutput>
	
</cfif>	





<cfquery datasource="Nba" name="xGetit">
	Update FinalPicks
	Set Sys24      = '#GetUndSit.Team#'
	where Gametime = '#Getit.Gametime#'
	and Fav        = '#Getit.FAV#'
</cfquery>
</cfif>


</cfif>

<cfquery datasource="Nba" name="UpdSit">
	UPDATE TeamSituation
	SET BadSitRat = #FavBadSitCt# 
	where Gametime = '#Getit.Gametime#'
	and Team = '#Getit.fav#'
</cfquery>

<cfquery datasource="Nba" name="UpdSit2">
	UPDATE TeamSituation
	SET BadSitRat = #UndBadSitCt# 
	where Gametime = '#Getit.Gametime#'
	and Team = '#Getit.und#'
</cfquery>

<cfif FavBadSitCt gt 1 and UndBadSitCt is 0 >
<p>
<p>
<p><p><p><p><p><p>
BAD SIT FOR FAV!!!!!!!!!!!!!!! Bet on #Getit.Und#...And cover was #Getit.Whocovered#....SPREAD was #Getit.spd#  
<p>
<cfif Getit.Whocovered is Getit.Und >
	<cfset BadSitFavw = BadSitFavw + 1 >
	<cfoutput>
	BAD SIT FOR FAV....Gametime: #gametime#.......Wins: #BadSitFavw# Losses:#BadSitFavL#<br>	
	</cfoutput>
<cfelseif Getit.Whocovered neq 'PUSH' >	
	<cfset BadSitFavL = BadSitFavL + 1 >
	<cfoutput>
	BAD SIT FOR FAV....Gametime: #gametime#.......Wins: #BadSitFavw# Losses:#BadSitFavL#<br>	
	</cfoutput>
	
</cfif>	

</cfif>


<!--- 
<cfset t1 = 0>
<cfset t2  =0>

<cfset t1  = GetFavSit.LastTwoCumScore> 
<cfset t1a =  GetFavSit.LastTwoDefScore>
<cfset t1tot = t1a + t1>
 --->


<tr>
<td>#whocovered#</td>	
<td>#Fav#</td>

<td bgcolor="#FavL2BG#">#GetFavSit.LASTTWOCUMSPD#</td>
<td>#GetFavSit.CumSpd#</td>
<td bgcolor="#FavHlthBG#">#GetFavSit.TeamHealth#</td>
<td bgcolor="#FavCovBG#">#GetFavSit.LatestCoverCt#</td>
<td bgcolor="#FavNoCovBG#">#GetFavSit.LatestNoCoverCt#</td>

<td>#GetFavSit.LastTwoCumScore#</td>
<td>#GetFavSit.LastTwoDefScore#</td>
<td>#GetFavSit.LastTwoCumScore - GetFavSit.LastTwoDefScore#</td>
<td>#GetFavSit.LastTwoCumScore + GetFavSit.LastTwoDefScore# </td>

<td>#GetFavSit.LastTotalPlays#</td>
<td>#GetFavSit.LastLeadChanges#</td>
<td>#GetFavSit.InLeadPct#</td>
<Td>#GetFavSit.UpBigPct#</td>
<Td>#GetFavSit.DownBigPct#</td>




<td>#Spd#</td>
<td>#HA#</td>
<td>#Und#</td>

<td bgcolor="#UndL2BG#">#GetUndSit.LASTTWOCUMSPD#</td>
<td>#GetUndSit.CumSpd#</td>
<td bgcolor="#UndHlthBG#">#GetUndSit.TeamHealth#</td>
<td bgcolor="#UndCovBG#">#GetUndSit.LatestCoverCt#</td>
<td bgcolor="#UndNoCovBG#">#GetUndSit.LatestNoCoverCt#</td>
<td>#GetUndSit.LastTwoCumScore#</td>
<td>#GetUndSit.LastTwoDefScore#</td>
<td>#GetUndSit.LastTwoCumScore - GetUndSit.LastTwoDefScore#</td>
<td>#GetUndSit.LastTwoCumScore + GetUndSit.LastTwoDefScore# </td>

<td>#GetUndSit.LastTotalPlays#</td>
<td>#GetUndSit.LastLeadChanges#</td>
<td>#GetUndSit.InLeadPct#</td>
<Td>#GetUndSit.UpBigPct#</td>
<Td>#GetUndSit.DownBigPct#</td>

<td>#SYS100#</td>
<td>#SYS40#</td>
<td>#SYS27#</td>
<td>#SYS19#</td>

<td>#SYS200#</td>
<td>#SYS2#</td>
<td>#SYS18#</td>
<td>#SYS23#</td>
<td>#SYS20#</td>
<td>#SYS15#</td>
<td>#SYS4#</td>
<td>#SYS34#</td>
<td>#SYS5#</td>
</tr>
</cfif>
</cfoutput>
</table>
<hr>

<cfset UndBadSitCt = 0>
<cfset FavBadSitCt = 0>

<!--- </cfloop> --->  





