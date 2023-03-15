


<cfset mygametime="20120116">


11-3 (79%)
<cfquery datasource="NBA" name="GetGamesimAvgScore">
select distinct fpf.*
from finalpicks fpf, gap gf, finalpicks fpu, gap gu
where fpf.fav = gf.team
and gf.oPIP = 'G'
and fpu.und = gu.Team
and gu.dpip = 'P'
and fpf.gametime = fpu.gametime
and fpf.fav = fpu.fav
and gu.Rebounding = 'P'
and fpf.whocovered <> 'PUSH'
and fpf.FavPlayedYest = 'N'
and gu.fgpct <> 'G'
and fpf.gametime >= '20120101'
and fpf.favhealth >= fpu.undhealth 
and fpf.spd < 10
and fpf.ha = 'H' 
order by fpf.gametime desc
</cfquery>

18-9 (67%)
<cfquery datasource="NBA" name="GetGamesimAvgScore">
select distinct fpf.*
from finalpicks fpf, gap gf, finalpicks fpu, gap gu
where fpf.fav = gf.team
and gf.oPIP = 'G'
and fpu.und = gu.Team
and gu.dpip = 'P'
and fpf.gametime = fpu.gametime
and fpf.fav = fpu.fav
and gu.Rebounding = 'P'
and fpf.whocovered <> 'PUSH'
and fpf.FavPlayedYest = 'N'
and gu.fgpct <> 'G'
and fpf.gametime >= '20120101'
and fpf.favhealth >= fpu.undhealth 
and fpf.spd < 10
order by fpf.gametime desc
</cfquery>

21-13 (62%)
<cfquery datasource="NBA" name="GetGamesimAvgScore">
select distinct fpf.*
from finalpicks fpf, gap gf, finalpicks fpu, gap gu
where fpf.fav = gf.team
and gf.oPIP               = 'G'
and fpu.und = gu.Team
and gu.dpip               = 'P'
and fpf.gametime = fpu.gametime
and fpf.fav = fpu.fav
and gu.Rebounding         = 'P'
and fpf.whocovered <> 'PUSH'
and fpf.FavPlayedYest     = 'N'
and gu.fgpct             <> 'G'
and fpf.gametime >= '20120101'
and fpf.favhealth        >= fpu.undhealth 
order by fpf.gametime desc
</cfquery>



<cfset w = 0>
<cfoutput query="GetGamesimAvgScore">
#gametime#..#spd#....#fav#/#und#,#Whocovered#....#favhealth#.....#undhealth#....#ha#<br> 
<cfif '#whocovered#' is '#fav#'>
	WINNER!<br>
	<cfset w = w + 1>
</cfif>	
</cfoutput>


<cfoutput>
#w/GetGamesimAvgScore.recordcount#<br>
#w# - #GetGamesimAvgScore.recordcount - w#
</cfoutput>

<cfabort>

<cfoutput query="GetGameSimAvgScore">
	<cfset ourpick = ''>

		<cfif ourspd lt 0>
			<cfset ourpick = '#und#'>
		
		<cfelse> 
			<cfif ourspd gt Vegasspd>
				<cfset ourpick = '#fav#'>
			<cfelse>
				<cfset ourpick = '#und#'>
			</cfif>	
				
		</cfif>
	
		<cfif #diff# ge 7.5>
			<cfset ourpick = '**' & '#ourpick#'>
		</cfif>
		
		<cfquery datasource="NBA" name="AddPicks">
		Update FinalPicks
		Set GamesimAvgScore = '#ourPick#'
		Where Fav = '#GetGameSimAvgScore.Fav#' 
		and GameTime = '#mygametime#'
		</cfquery>
	
</cfoutput>



<cfabort>

<cfquery datasource="NBA" name="Games">
Select *
from FinalPicks
where gametime = '#mygametime#'
</cfquery>


<cfloop query="Games">

<cfset fav = '#fav#'>
<cfset und = '#und#'>
<cfset spd = #spd#>
<cfset hafav = '#Ha#'>


	<cfloop index="zz" from="1" to="6">

		<cfif zz is 1>
			<cfset stat = 'PTS'>
		<cfelseif zz is 2>
			<cfset stat = 'REB'>
		<cfelseif zz is 3>
			<cfset stat = 'TPM'>
		<cfelseif zz is 4>
			<cfset stat = 'FTM'>
		<cfelseif zz is 5>
			<cfset stat = 'FGPCT'>
		<cfelseif zz is 6>
			<cfset stat = 'PIP'>
		</cfif>

<cfif stat neq 'PTS'>
	<cfset spd = 0>
</cfif>




<cfswitch expression="#stat#">

	<cfcase value="PTS">
		<cfset stat1 = 'ops'>
		<cfset stat2 = 'dps'>
		<cfset table1 = 'Matrix'>
		<cfset table2 = 'Matrixdps'>
		<cfset blowout = 10 + spd>
	</cfcase>

	<cfcase value="FGPCT">
		<cfset stat1 = 'ofgpct'>
		<cfset stat2 = 'dfgpct'>
		<cfset table1 = 'Matrixfgpct'>
		<cfset table2 = 'Matrixdfgpct'>
		<cfset blowout = 5>
	</cfcase>

	<cfcase value="REB">
		<cfset stat1 = 'oreb'>
		<cfset stat2 = 'dreb'>
		<cfset table1 = 'MatrixReb'>
		<cfset table2 = 'MatrixdReb'>
		<cfset blowout = 10>
	</cfcase>

	<cfcase value="PIP">
		<cfset stat1 = 'opip'>
		<cfset stat2 = 'dpip'>
		<cfset table1 = 'MatrixPIP'>
		<cfset table2 = 'MatrixdPIP'>
		<cfset blowout = 10>
	</cfcase>

	<cfcase value="FTM">
		<cfset stat1 = 'oFTM'>
		<cfset stat2 = 'dFTM'>
		<cfset table1 = 'MatrixFTM'>
		<cfset table2 = 'MatrixdFTM'>
		<cfset blowout = 10>
	</cfcase>


	<cfcase value="TPM">
		<cfset stat1 = 'oTPM'>
		<cfset stat2 = 'dTPM'>
		<cfset table1 = 'MatrixTPM'>
		<cfset table2 = 'MatrixdTPM'>
		<cfset blowout = 5>
	</cfcase>

	<cfcase value="TO">
		<cfset stat1 = 'oTO'>
		<cfset stat2 = 'dTO'>
		<cfset table1 = 'MatrixTO'>
		<cfset table2 = 'MatrixdTO'>
		<cfset blowout = 7>
	</cfcase>
	
</cfswitch>






<cfif hafav is 'H'>
	<cfset haund = 'A'>
<cfelse>
	<cfset haund = 'H'>
</cfif>

<cfquery datasource="NBA" name="FavGetOff">
Select #stat1# as ps
from #table1#
where team = '#fav#'
and opp = '#und#'
and ha = '#hafav#'
and gametime < '#mygametime#'
union

Select #stat2# as ps
from #table2#
where team = '#und#'
and opp = '#fav#'
and ha = '#haund#'
and gametime < '#mygametime#'
</cfquery>


<cfquery datasource="NBA" name="UndGetOff">
Select #stat1# as ps
from #table1#
where team = '#und#'
and opp = '#fav#'
and ha = '#haund#'
and gametime < '#mygametime#'
union

Select #stat2# as ps
from #table2#
where team = '#fav#'
and opp = '#und#'
and ha = '#hafav#'
and gametime < '#mygametime#'
</cfquery>


<cfset favcov = 0>
<cfset undcov = 0>
<cfset totct = 0>
<cfset totpts = 0>
<cfset favbigstat = 0>
<cfset undbigstat = 0>

<cfoutput>
<cfloop query="favGetOff">
	<cfloop query="UndGetOff">
		
		<cfset totpts = totpts + (favGetOff.ps + UndGetOff.ps) >
		<cfset totct = totct + 1>
		<!--- comparing #favGetOff.ps# to #UndGetOff.ps#<br> --->
		<cfif favGetOff.ps - UndGetOff.ps gt spd>
			<cfset favcov = favcov + 1>
			
			<cfif favGetOff.ps - UndGetOff.ps gt blowout>
				<cfset FavBigStat = FavBigStat + 1 >
			
			</cfif>
			
			
			
			<!--- FAV covers #favGetOff.ps - UndGetOff.ps#<br> --->
		<cfelse>
			<cfif favGetOff.ps - UndGetOff.ps lt spd>
				<cfset undcov = undcov + 1>
			</cfif>	
			
			<cfif UndGetOff.ps - favGetOff.ps gt blowout>
				<cfset UndBigStat = UndBigStat + 1 >
			
			</cfif>
			
		</cfif>
		
	</cfloop>

</cfloop>
<cfif (favcov/(totct))*100 gt 50>
	For the STAT (#stat#) - in the game #fav#/#und#/#spd#, #fav# covers #(favcov/(totct))*100#, chance for blowout is #(favbigstat/(totct))*100#<br>
	
<cfelse>	
	For the STAT (#stat#) - in the game #fav#/#und#/#spd#, #und# covers #(undcov/(totct))*100#, chance for blowout is #(undbigstat/(totct))*100#<br>
</cfif>	

<!--- Avg total points is #numberformat(totpts/totct,'999.9')#<br> --->
</cfoutput>
<p></p>

</cfloop>
<hr>
</cfloop>