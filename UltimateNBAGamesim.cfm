<cfset myUserCFC = createObject("component", "PSP2012.NFL.FORMS.User") />
<cfset myPBPCFC = createObject("component", "NBAPBP") />

<cfquery datasource="nba" name="GetDay">
Select Gametime 
from NBAGametime
</cfquery>

<cfset theday = GetDay.Gametime> 
<cfset theday = '20160121'>

<cfquery name="Games" datasource="nba">
Select distinct n.* 
from NbaSchedule n
where n.Gametime = '#theDay#'
</cfquery>

<cfoutput query="Games">


	<cfset fav='#Games.fav#'>
	<cfset und='#Games.und#'>

	<cfset FavStruc  = myPBPCFC.getDriveInfo2('O','#fav#','#theday#')>
	<cfset UndStruc  = myPBPCFC.getDriveInfo2('O','#und#','#theday#')>

	<cfquery datasource="NBA" name="addit">
		INSERT INTO NBAPOSESSION2014
		(TEAM,
		 HA,
		 GAMETIME,
		 COMMITFOULSHOOT,
		 FREETHROWMADE,
		 FREETHROWMISSED,
		 OFFENSIVEFOUL,
		 OFFPERSONALFOUL,
		 PT2MADE,
		 PT2MISS,
		 PT3MADE,
		 PT3MISSED,
		 REBOUND,
		 TEAMREB,
		 TURNOVER,
		 POSESSIONS,
		 OPP,
		 OFFDEF
		 )
		 VALUES
		 ('#fav#',
		 '#Games.HA#',
		 '#theday#',
		 #FavStruc.COMMITFOULSHOOTINGPCT#,
		 #FavStruc.FREETHROWMADEPCT#,
		 #FavStruc.FREETHROWMISSEDPCT#,
		 #FavStruc.OFFFOULPCT#,
		 #FavStruc.OFFPERSONALPCT#,
		
		 #FavStruc.PT2MADEPCT#,
		 #FavStruc.PT2MISSPCT#,
		 #FavStruc.PT3MADEPCT#,
		 #FavStruc.PT3MISSPCT#,
		 #FavStruc.REBOUNDPCT#,
		 #FavStruc.TEAMREBOUNDPCT#,
		 #FavStruc.TURNOVERPCT#,
		 #FavStruc.TotalPlays#,
		 '#und#',
		'O'
		)
		
	</cfquery>


		<cfquery datasource="NBA" name="addit">
		INSERT INTO NBAPOSESSION2014
		(TEAM,
		 HA,
		 GAMETIME,
		 COMMITFOULSHOOT,
		 FREETHROWMADE,
		 FREETHROWMISSED,
		 OFFENSIVEFOUL,
		 OFFPERSONALFOUL,
		 PT2MADE,
		 PT2MISS,
		 PT3MADE,
		 PT3MISSED,
		 REBOUND,
		 TEAMREB,
		 TURNOVER,
		 POSESSIONS,
		 OPP,
		 OFFDEF
		 )
		 VALUES
		 ('#fav#',
		 '#Games.HA#',
		 '#theday#',
		 #UndStruc.COMMITFOULSHOOTINGPCT#,
		 #UndStruc.FREETHROWMADEPCT#,
		 #UndStruc.FREETHROWMISSEDPCT#,
		 #UndStruc.OFFFOULPCT#,
		 #UndStruc.OFFPERSONALPCT#,
		
		 #UndStruc.PT2MADEPCT#,
		 #UndStruc.PT2MISSPCT#,
		 #UndStruc.PT3MADEPCT#,
		 #UndStruc.PT3MISSPCT#,
		 #UndStruc.REBOUNDPCT#,
		 #UndStruc.TEAMREBOUNDPCT#,
		 #UndStruc.TURNOVERPCT#,
		 #UndStruc.TotalPlays#,
		 '#und#',
		'D'
		)
		
	</cfquery>

	<cfset myha = 'H'>
	<cfif Games.ha is 'H'>
		<cfset myha = 'A'>
	</cfif>	
	
		<cfquery datasource="NBA" name="addit">
		INSERT INTO NBAPOSESSION2014
		(TEAM,
		 HA,
		 GAMETIME,
		 COMMITFOULSHOOT,
		 FREETHROWMADE,
		 FREETHROWMISSED,
		 OFFENSIVEFOUL,
		 OFFPERSONALFOUL,
		 PT2MADE,
		 PT2MISS,
		 PT3MADE,
		 PT3MISSED,
		 REBOUND,
		 TEAMREB,
		 TURNOVER,
		 POSESSIONS,
		 OPP,
		 OFFDEF
		 )
		 VALUES
		 ('#Und#',
		 '#myHA#',
		 '#theday#',
		 #UndStruc.COMMITFOULSHOOTINGPCT#,
		 #UndStruc.FREETHROWMADEPCT#,
		 #UndStruc.FREETHROWMISSEDPCT#,
		 #UndStruc.OFFFOULPCT#,
		 #UndStruc.OFFPERSONALPCT#,
		
		 #UndStruc.PT2MADEPCT#,
		 #UndStruc.PT2MISSPCT#,
		 #UndStruc.PT3MADEPCT#,
		 #UndStruc.PT3MISSPCT#,
		 #UndStruc.REBOUNDPCT#,
		 #UndStruc.TEAMREBOUNDPCT#,
		 #UndStruc.TURNOVERPCT#,
		 #UndStruc.TotalPlays#,
		 '#Fav#',
		'O'
		)
		
	</cfquery>
	

	<cfquery datasource="NBA" name="addit">
		INSERT INTO NBAPOSESSION2014
		(TEAM,
		 HA,
		 GAMETIME,
		 COMMITFOULSHOOT,
		 FREETHROWMADE,
		 FREETHROWMISSED,
		 OFFENSIVEFOUL,
		 OFFPERSONALFOUL,
		 PT2MADE,
		 PT2MISS,
		 PT3MADE,
		 PT3MISSED,
		 REBOUND,
		 TEAMREB,
		 TURNOVER,
		 POSESSIONS,
		 OPP,
		 OFFDEF
		 )
		 VALUES
		 ('#Und#',
		 '#myHA#',
		 '#theday#',
		 #FavStruc.COMMITFOULSHOOTINGPCT#,
		 #FavStruc.FREETHROWMADEPCT#,
		 #FavStruc.FREETHROWMISSEDPCT#,
		 #FavStruc.OFFFOULPCT#,
		 #FavStruc.OFFPERSONALPCT#,
		
		 #FavStruc.PT2MADEPCT#,
		 #FavStruc.PT2MISSPCT#,
		 #FavStruc.PT3MADEPCT#,
		 #FavStruc.PT3MISSPCT#,
		 #FavStruc.REBOUNDPCT#,
		 #FavStruc.TEAMREBOUNDPCT#,
		 #FavStruc.TURNOVERPCT#,
		 #FavStruc.TotalPlays#,
		 '#Fav#',
		'D'
		)
		
	</cfquery>
	
	
</cfoutput>	


Create SD's for....
<cfquery datasource="NBA" name="OffGetStatsFav">
Select
COMMITFOULSHOOTINGPCT,
FREETHROWMADEPCT,
FREETHROWMISSEDPCT,
OFFFOULPCT,
OFFPERSONALPCT,
PT2MADEPCT,
PT2MISSPCT,
PT3MADEPCT,
PT3MISSPCT,
REBOUNDPCT,
TEAMREBOUNDPCT,
TURNOVERPCT,
POSESSIONS
from NBAPosession2014
Where Team = '#fav#'
and OffDef='O'
</cfquery>

<cfquery datasource="NBA" name="OffGetStatsUnd">
Select
COMMITFOULSHOOTINGPCT,
FREETHROWMADEPCT,
FREETHROWMISSEDPCT,
OFFFOULPCT,
OFFPERSONALPCT,
PT2MADEPCT,
PT2MISSPCT,
PT3MADEPCT,
PT3MISSPCT,
REBOUNDPCT,
TEAMREBOUNDPCT,
TURNOVERPCT,
POSESSIONS
from NBAPosession2014
Where Team = '#Und#'
and OffDef='O'
</cfquery>


<cfquery datasource="NBA" name="DEFGetStatsFav">
Select
COMMITFOULSHOOTINGPCT,
FREETHROWMADEPCT,
FREETHROWMISSEDPCT,
OFFFOULPCT,
OFFPERSONALPCT,
PT2MADEPCT,
PT2MISSPCT,
PT3MADEPCT,
PT3MISSPCT,
REBOUNDPCT,
TEAMREBOUNDPCT,
TURNOVERPCT,
POSESSIONS
from NBAPosession2014
Where Team = '#fav#'
and OffDef='D'
</cfquery>

<cfquery datasource="NBA" name="DEFGetStatsUnd">
Select
COMMITFOULSHOOTINGPCT,
FREETHROWMADEPCT,
FREETHROWMISSEDPCT,
OFFFOULPCT,
OFFPERSONALPCT,
PT2MADEPCT,
PT2MISSPCT,
PT3MADEPCT,
PT3MISSPCT,
REBOUNDPCT,
TEAMREBOUNDPCT,
TURNOVERPCT,
POSESSIONS
from NBAPosession2014
Where Team = '#Und#'
and OffDef='D'
</cfquery>




	<!--- Create array of stats --->
	<cfset aCOMMITFOULSHOOTINGPCT = arraynew(1)>
	<cfset aFREETHROWMADEPCT      = arraynew(1)>
	<cfset aFREETHROWMISSEDPCT    = arraynew(1)>
	<cfset aOFFFOULPCT			  = arraynew(1)>
	<cfset aOFFPERSONALPCT	      = arraynew(1)>
	<cfset atwoptmade             = arraynew(1)>
	<cfset atwoptmiss             = arraynew(1)>
	<cfset athreeptmade           = arraynew(1)>
	<cfset athreeptmiss           = arraynew(1)>
	<cfset aRebound               = arraynew(1)>
	<cfset aTeamRebound           = arraynew(1)>
	<cfset aTurnover              = arraynew(1)>
	<cfset atotalplays            = arraynew(1)>
	
	<cfset aCOMMITFOULSHOOTINGPCT   = ListToArray(Valuelist(GetHomeInfo.COMMITFOULSHOOTINGPCT))>
	<cfset aFREETHROWMADEPCT        = ListToArray(Valuelist(GetHomeInfo.FREETHROWMADEPCT))>
	<cfset aFREETHROWMISSEDPCT      = ListToArray(Valuelist(GetHomeInfo.FREETHROWMISSEDPCT))>
	<cfset aOFFFOULPCT              = ListToArray(Valuelist(GetHomeInfo.OFFFOULPCT))>
	<cfset aOFFPERSONALPCT          = ListToArray(Valuelist(GetHomeInfo.OFFPERSONALPCT))>
	
	<cfset atwoptmade               = ListToArray(Valuelist(GetHomeInfo.pt2made))>
	<cfset atwoptmiss               = ListToArray(Valuelist(GetHomeInfo.pt2miss))>
	<cfset athreeptmade             = ListToArray(Valuelist(GetHomeInfo.pt3made))>
	<cfset athreeptmiss             = ListToArray(Valuelist(GetHomeInfo.pt3miss))>
	
	
	<cfset aRebound               = ListToArray(Valuelist(GetHomeInfo.REBOUNDPCT))>
	<cfset aTeamRebound           = ListToArray(Valuelist(GetHomeInfo.TEAMREBOUNDPCT))>
	<cfset aTurnover              = ListToArray(Valuelist(GetHomeInfo.TURNOVER))>
	<cfset atotalplays            = ListToArray(Valuelist(GetHomeInfo.REBOUNDPCT))>
	
	
	
	
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aCOMMITFOULSHOOTINGPCT#	
	returnvariable  = "sdCommitFoulPct"			
	>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aFREETHROWMADEPCT#	
	returnvariable  = "sdFTMPct"			
	>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aFREETHROWMISSEDPCT#	
	returnvariable  = "sdFTMissPct"			
	>


	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aOFFFOULPCT#	
	returnvariable  = "sdOffFoulPct"			
	>
	
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aOFFPERSONALPCT#	
	returnvariable  = "sdOffPFPct"			
	>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #atwoptmade#	
	returnvariable  = "sd2ptMadePct"			
	>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #atwoptmiss#	
	returnvariable  = "sd2ptMissPct"			
	>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #athreeptmade#	
	returnvariable  = "sd3ptMadePct"			
	>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #athreeptmiss#	
	returnvariable  = "sd3ptMissPct"			
	>

