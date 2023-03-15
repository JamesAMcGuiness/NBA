<cftry>

<cfif 1 is 2>
<cfquery datasource="NBA" name="Getit">
Select distinct Gametime, Fav,Und,spd,whocovered
from FinalPicks p, GAP gund, GAP gfav
Where p.Und = gund.Team
and p.fav = gfav.Team
and gund.dRebounding in ('G')
and gund.ops <> 'P'
and gfav.ops in ('P','A')
and p.Gametime = '20191202'
and p.spd >= 3.5
</cfquery>


<cfdump var="#Getit#">

<cfabort>


</cfif>


<cfset w = 0>
<cfset l = 0>

<cfinclude template="MJsPicks.cfm">


 

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('FFP: Ran MJsPicks.cfm')
</cfquery>



<cfquery datasource="nba" name="getinfo">
Select distinct * from finalpicks fp
where gametime in (select gametime from nbagametime)
</cfquery>





<cfoutput query="getinfo">

	<cfset Favct = 0>
	<cfset UndCt = 0>
	<cfset FinalRat = 0>
	<cfset Matchuppick = ''>
	
	<cfset myfav = '#Getinfo.fav#'>
	<cfset myund = '#Getinfo.und#'>
	
	<!--- See if this is a good matchup for betting --->
	<cfquery datasource="nba" name="getmufav">
	Select * 
	from PBPPercents 
	where team in ('#myfav#')
	</cfquery>

	<!--- See if this is a good matchup for betting --->
	<cfquery datasource="nba" name="getmuund">
	Select * 
	from PBPPercents 
	where team in ('#myund#')
	</cfquery>

	<cfif getmufav.GoodInsideTeam is 'Y' and getmuund.BadInsideTeam is 'Y'>
		<cfset Matchuppick = '#myfav#'> 
	</cfif>
	
	<cfif getmuund.GoodInsideTeam is 'Y' and getmufav.BadInsideTeam is 'Y'>
		<cfset Matchuppick = '#myund#'> 
	</cfif>
	
	<cfif GetInfo.FavHealthL7 lt -5 and GetInfo.UndHealthL7 gt -4 >
		<cfquery datasource="nba">
		Update FinalPicks
		Set SYS34 = '#myund#' 
		Where gametime = '#Getinfo.gametime#'
		and fav = '#myfav#'
		</cfquery> 
	</cfif>
	
	<cfif ThirtyRatFav gt ''>
		<cfquery datasource="nba">
		Update FinalPicks
		Set SYS2 = '#myfav#' 
		Where gametime = '#Getinfo.gametime#'
		and fav = '#myfav#'
		</cfquery> 
	</cfif>
	
	<cfif GetInfo.FavHealthL7 is -2>
	<cfquery datasource="nba">
				Update FinalPicks
				Set SYS51       = '#myfav#'
				Where gametime  = '#Getinfo.gametime#'
				and fav         = '#myfav#'
	</cfquery>
	</cfif>
	
	<cfif GetInfo.UndHealthL7 is -2>
	<cfquery datasource="nba">
				Update FinalPicks
				Set SYS51       = '#myund#'
				Where gametime  = '#Getinfo.gametime#'
				and fav         = '#myfav#'
	</cfquery>
	</cfif>
	
	<cfif 1 is 1>
	<cfif GetInfo.PIPPick gt ''>
		<cfif GetInfo.PIPPick is '#Left(GetInfo.SYS500,3)#' >
			<cfif GetInfo.SYS29 is GetInfo.PIPPick >
				<cfquery datasource="nba">
				Update FinalPicks
				Set SYS50       = '#GetInfo.PIPPick#'
				Where gametime  = '#Getinfo.gametime#'
				and fav         = '#myfav#'
			</cfquery>
			</cfif>
		</cfif>
	</cfif>
	</cfif>
	
	<cfif Getinfo.SixtyPctImpStat is GetInfo.Fav>
		<cfset favct = favct + 1>
	</cfif>
	
	<cfif Getinfo.SixtyPctImpStat is GetInfo.Und>
		<cfset undct = undct + 1>
	</cfif>
	
	<cfif Findnocase('#GetInfo.Fav#','#Getinfo.PredStatsFav#') gt 0>
		<cfset favct = favct + 1>
	</cfif>
	
	<cfif Findnocase('#GetInfo.Und#','#Getinfo.PredStatsFav#') gt 0>
		<cfset undct = undct + 1>
	</cfif>
	
	<cfif Getinfo.ThirtyRatFav is GetInfo.Fav>
		<cfset favct = favct + 1>
	</cfif>
	
	<cfif Getinfo.ThirtyRatFav is GetInfo.Und>
		<cfset undct = undct + 1>
	</cfif>
	
	<cfif Getinfo.FGREB is GetInfo.Fav>
		<cfset favct = favct + 1>
	</cfif>
	
	<cfif Getinfo.FGREB is GetInfo.Und>
		<cfset undct = undct + 1>
	</cfif>
	
	<cfif Findnocase('#GetInfo.Fav#','#Getinfo.GAPHA#') gt 0>
		<cfset favct = favct + 1>
	</cfif>
	
	<cfif Findnocase('#GetInfo.Und#','#Getinfo.GAPHA#') gt 0>
		<cfset undct = undct + 1>
	</cfif>

	
	<cfif Findnocase('#GetInfo.Fav#','#Getinfo.PowRecent#') gt 0>
		<cfset favct = favct + 1>
	</cfif>
	
	<cfif Findnocase('#GetInfo.Und#','#Getinfo.PowRecent#') gt 0>
		<cfset undct = undct + 1>
	</cfif>

	
	<cfif Getinfo.hblowoutscoring is GetInfo.Fav>
		<cfset favct = favct + 1>
	</cfif>
	
	<cfif Getinfo.hblowoutscoring is GetInfo.Und>
		<cfset undct = undct + 1>
	</cfif>
	
	<cfif Getinfo.hblowscorreb is GetInfo.Fav>
		<cfset favct = favct + 1>
	</cfif>
	
	<cfif Getinfo.hblowscorreb is GetInfo.Und>
		<cfset undct = undct + 1>
	</cfif>
	
	<cfif Findnocase('#GetInfo.Fav#','#Getinfo.GameSimSide#') gt 0>
		<cfset favct = favct + 1>
	</cfif>
	
	<cfif Findnocase('#GetInfo.Und#','#Getinfo.GameSimSide#') gt 0>
		<cfset undct = undct + 1>
	</cfif>
	
	<cfset unanimous = 'N'>
	<cfif Favct neq 0 and Undct is 0>
		<cfset unanimous = 'Y'>
	</cfif>
	
	<cfif Undct neq 0 and Favct is 0>
		<cfset unanimous = 'Y'>
	</cfif>
		
	<cfset myfinalpick = 'PASS'>
	<cfif Favct gt undct>
			<cfset myfinalpick = '#myfav#'>
			<cfset finalrat  = Favct - undct>
	</cfif>
	
	<cfif Favct lt undct>
			<cfset myfinalpick = '#myund#'>
			<cfset finalrat  = undct - favct>
	</cfif>
	
	<cfquery datasource="nba">
		Update FinalPicks
		Set PicksForFav = #favct#,
		PicksForUnd     = #undct#,
		FinalPick       = '#myFinalPick#',
		FinalPickRat    = #finalrat# 
		Where gametime = '#Getinfo.gametime#'
		and fav = '#myfav#'
	</cfquery> 
	
	<cfquery datasource="nba">
		Insert into PSPNBAPicks(Gametime,Fav,ha,Spd,Und,SYS200,SYS100,SYS20,ThirtyRatFav,Sys6,Sys4,Sys27,Sys14,Sys40,Sys18,Sys19,Sys99,Sys22,Sys15,Sys5,Sys16,Sys8)
    	values('#GetInfo.Gametime#','#GetInfo.fav#','#GetInfo.Ha#',#GetInfo.spd#,'#GetInfo.Und#','#GetInfo.Sys200#','#GetInfo.SYS100#','#GetInfo.SYS20#','#GetInfo.ThirtyRatFav#','#GetInfo.Sys6#','#GetInfo.Sys4#','#GetInfo.Sys27#','#GetInfo.Sys14#','#GetInfo.Sys40#','#GetInfo.Sys18#','#GetInfo.Sys19#','#GetInfo.Sys99#','#GetInfo.Sys22#','#GetInfo.Sys15#','#GetInfo.Sys5#','#GetInfo.Sys16#','#GetInfo.Sys8#')
	</cfquery>


	<cfquery datasource="nba" name="GetSitFav">
	Select * from TeamSituation
	Where Team = '#GetInfo.fav#'
	and Gametime = '#GetInfo.Gametime#'
	</cfquery>

	<cfquery datasource="nba" name="GetSitUnd">
	Select * from TeamSituation
	Where Team = '#GetInfo.und#'
	and Gametime = '#GetInfo.Gametime#'
	</cfquery>


	<cfloop query="GetSitFav">


		CHECKING NEW SYSTEM FOR FAV: #getsitfav.Team#<br>

	<!--- New system to check
	Go against any Favorite where in their last game they were BEHIND BIG for 25% or more of game
	 --->
		<cfif DownBigPct gte 25>
			
			<!--- Get the uderdog for this game --->
			<cfquery datasource="nba" name="Getund">
			Select Und,spd,gametime from FinalPicks
			Where Fav    = '#GetSitFav.Team#'
			and Gametime = '#GetSitFav.Gametime#'
			</cfquery>
		
			<cfif Getund.spd gte 6>
				Play on #GetUnd.Und# - SYS50<br>
				<cfquery datasource="nba">
				Update FinalPicks
				Set SYS50       = '#GetUnd.Und#'
				Where gametime  = '#Getinfo.gametime#'
				and fav         = '#GetSitFav.Team#'
				</cfquery>
				
				
				<cfquery datasource="nba">
				Update FinalPicks
				Set SYS51       = '#GetUnd.Und#'
				Where gametime  = '#Getinfo.gametime#'
				and fav         = '#GetSitFav.Team#'
				</cfquery>
				
			<cfelse>
				Play on #GetUnd.Und# - SYS51<br>
				<cfquery datasource="nba">
				Update FinalPicks
				Set SYS51       = '#GetUnd.Und#'
				Where gametime  = '#Getinfo.gametime#'
				and fav         = '#GetSitFav.Team#'
				</cfquery>
			 
			
			</cfif>
			
			
		</cfif>

	</cfloop>


	<cfloop query="GetSitUnd">
			
	 	CHECKING NEW SYSTEM FOR UND: #getsitund.Team#<br>
	 
	 
		<cfif DownBigPct gte 25>
			
			<!--- Get the fav for this game --->
			<cfquery datasource="nba" name="Getfav">
			Select fav,Und,ha,gametime from FinalPicks
			Where Und    = '#GetSitUnd.Team#'
			and Gametime = '#GetSitUnd.Gametime#'
			</cfquery>
	
			<!--- New system to check
			Play AGAINST underdog who is now HOME, after last game they were down BIG for 25% or more
	 		--->	
			<cfif GetFav.ha is 'A'>
				SYS52 - #GetFav.Fav#<br>
				<cfquery datasource="nba">
				Update FinalPicks
				Set SYS52       = '#GetFav.fav#'
				Where gametime  = '#GetFav.gametime#'
				and fav         = '#GetFav.fav#'
				</cfquery> 
			
			<cfelse>
				SYS53 - #GetSitUnd.Team#<br>
			
				<!--- New system to check
				Play ON underdog who is now AWAY, after last game they were down BIG for 25% or more
	 			--->
			
				<cfquery datasource="nba">
				Update FinalPicks
				Set SYS53       = '#Getfav.und#'
				Where gametime  = '#GetFav.gametime#'
				and fav         = '#GetFav.Fav#'
				</cfquery>
			
			</cfif>
			
			
		</cfif>

	</cfloop>


		




	<!--- 
<cfquery datasource="nba">
		Update PSPNBAPicks
		Set FavHealth   = #GetSitFav.TeamHealth#,
		FAVLatestCoverCt   = #GetSitFav.LatestCoverCt#,
		FAVLatestNoCoverCt = #GetSitFav.LatestNoCoverCt#,
		FAVCumSpd          = #GetSitFav.CumSpd#
		Where Gametime = '#GetInfo.Gametime#'
		and Fav = '#GetInfo.Fav#'
	</cfquery>

	<cfquery datasource="nba">
		Update PSPNBAPicks
		Set UndHealth   = #GetSitUnd.TeamHealth#,
		UndLatestCoverCt   = #GetSitUnd.LatestCoverCt#,
		UndLatestNoCoverCt = #GetSitUnd.LatestnoCoverCt#,
		UndCumSpd          = #GetSitUnd.CumSpd#
		Where Gametime = '#GetInfo.Gametime#'
		and Und = '#GetInfo.Und#'
	</cfquery>
 --->



</cfoutput>
<cfinclude template="UpdateSysx.cfm">
<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('FFP: Ran UpdateSysx.cfm')
</cfquery>

<cfinclude template="SYS60.cfm">
<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('FFP: Ran SYS60.cfm')
</cfquery>

<cfinclude template="Pace.cfm">
<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('FFP: Ran Pace.cfm')
</cfquery>


<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('FFP: Completed Run of FigureFinalPicks.cfm')
</cfquery>

<cfquery datasource="NBA" name="Getit">
Select distinct Gametime, Fav,Und,spd,whocovered
from FinalPicks p, GAP gund, GAP gfav
Where p.Und = gund.Team
and p.fav = gfav.Team
and gund.dRebounding in ('G')
and gund.ops <> 'P'
and gfav.ops in ('P','A')
and p.Gametime = '#gametime#'
and p.spd >= 3.5
</cfquery>

<cfquery datasource="NBA" name="Upd">
	Update FinalPicks
	Set Sys100 = ''
	where Gametime = '#gametime#'
	and Sys100 = 'UNDER'
</cfquery>


<cfoutput query="Getit">

	<cfquery datasource="NBA" name="Upd2">
	Update FinalPicks
	Set Sys100 = '#Getit.und#'
	where Gametime = '#gametime#'
	and Fav = '#Getit.Fav#'
	</cfquery>
	
</cfoutput>


<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:FigureFinalPicks.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>

