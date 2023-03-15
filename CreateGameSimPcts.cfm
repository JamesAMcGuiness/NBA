<cfset Gametime = '20171117'>
<cfset AwayTeam = 'LAC'>
<cfset HomeTeam = 'CLE'>
<cfset thespd   = 6.5>



<cfquery datasource="NBA" name="oGetAwayPosCt1">
		Select TotalPossesions/(Select count(*) from NBASchedule where gametime > '20171016' and gametime < '#gametime#' and (Fav = '#AwayTeam#' or UND = '#Awayteam#')) as Stat
		FROM PBPStatsForPred
		WHERE Team IN ('#AwayTeam#')
		AND Period = 1
		AND OFFDef = 'O'
</cfquery>
	
<cfquery datasource="NBA" name="oGetAwayPosCt2">
		Select TotalPossesions/(Select count(*) from NBASchedule where gametime > '20171016' and gametime < '#gametime#' and (Fav = '#AwayTeam#' or UND = '#Awayteam#')) as Stat
		FROM PBPStatsForPred
		WHERE Team IN ('#AwayTeam#')
		AND Period = 2
		AND OFFDef = 'O'
</cfquery>
	
	
<cfquery datasource="NBA" name="oGetAwayPosCt3">
		Select TotalPossesions/(Select count(*) from NBASchedule where gametime > '20171016' and gametime < '#gametime#' and (Fav = '#AwayTeam#' or UND = '#Awayteam#')) as Stat
		FROM PBPStatsForPred
		WHERE Team IN ('#AwayTeam#')
		AND Period = 3
		AND OFFDef = 'O'
</cfquery>
	
	
<cfquery datasource="NBA" name="oGetAwayPosCt4">
		Select TotalPossesions/(Select count(*) from NBASchedule where gametime > '20171016' and gametime < '#gametime#' and (Fav = '#AwayTeam#' or UND = '#Awayteam#')) as Stat
		FROM PBPStatsForPred
		WHERE Team IN ('#AwayTeam#')
		AND Period = 4
		AND OFFDef = 'O'
</cfquery>



	
	
	
<cfquery datasource="NBA" name="oGetHomePosCt1">
		Select TotalPossesions/(Select count(*) from NBASchedule where gametime > '20171016' and gametime < '#gametime#' and (Fav = '#HomeTeam#' or UND = '#Hometeam#')) as Stat
		FROM PBPStatsForPred
		WHERE Team IN ('#HomeTeam#')
		AND Period = 1
		AND OFFDef = 'O'
</cfquery>	
	
<cfquery datasource="NBA" name="oGetHomePosCt2">
		Select TotalPossesions/(Select count(*) from NBASchedule where gametime > '20171016' and gametime < '#gametime#' and (Fav = '#HomeTeam#' or UND = '#Hometeam#')) as Stat
		FROM PBPStatsForPred
		WHERE Team IN ('#HomeTeam#')
		AND Period = 2
		AND OFFDef = 'O'
</cfquery>	
	
<cfquery datasource="NBA" name="oGetHomePosCt3">
		Select TotalPossesions/(Select count(*) from NBASchedule where gametime > '20171016' and gametime < '#gametime#' and (Fav = '#HomeTeam#' or UND = '#Hometeam#')) as Stat
		FROM PBPStatsForPred
		WHERE Team IN ('#HomeTeam#')
		AND Period = 3
		AND OFFDef = 'O'
</cfquery>	
	
<cfquery datasource="NBA" name="oGetHomePosCt4">
		Select TotalPossesions/(Select count(*) from NBASchedule where gametime > '20171016' and gametime < '#gametime#' and (Fav = '#HomeTeam#' or UND = '#Hometeam#')) as Stat
		FROM PBPStatsForPred
		WHERE Team IN ('#HomeTeam#')
		AND Period = 4
		AND OFFDef = 'O'
</cfquery>	
	


<cfquery datasource="NBA" name="dGetAwayPosCt1">
		Select TotalPossesions/(Select count(*) from NBASchedule where gametime > '20171016' and gametime < '#gametime#' and (Fav = '#AwayTeam#' or UND = '#Awayteam#')) as Stat
		FROM PBPStatsForPred
		WHERE Team IN ('#AwayTeam#')
		AND Period = 1
		AND OFFDef = 'D'
</cfquery>
	
<cfquery datasource="NBA" name="dGetAwayPosCt2">
		Select TotalPossesions/(Select count(*) from NBASchedule where gametime > '20171016' and gametime < '#gametime#' and (Fav = '#AwayTeam#' or UND = '#Awayteam#')) as Stat
		FROM PBPStatsForPred
		WHERE Team IN ('#AwayTeam#')
		AND Period = 2
		AND OFFDef = 'D'
</cfquery>
	
	
<cfquery datasource="NBA" name="dGetAwayPosCt3">
		Select TotalPossesions/(Select count(*) from NBASchedule where gametime > '20171016' and gametime < '#gametime#' and (Fav = '#AwayTeam#' or UND = '#Awayteam#')) as Stat
		FROM PBPStatsForPred
		WHERE Team IN ('#AwayTeam#')
		AND Period = 3
		AND OFFDef = 'D'
</cfquery>
	
	
<cfquery datasource="NBA" name="dGetAwayPosCt4">
		Select TotalPossesions/(Select count(*) from NBASchedule where gametime > '20171016' and gametime < '#gametime#' and (Fav = '#AwayTeam#' or UND = '#Awayteam#')) as Stat
		FROM PBPStatsForPred
		WHERE Team IN ('#AwayTeam#')
		AND Period = 4
		AND OFFDef = 'D'
</cfquery>
	
	
	
<cfquery datasource="NBA" name="dGetHomePosCt1">
		Select TotalPossesions/(Select count(*) from NBASchedule where gametime > '20171016' and gametime < '#gametime#' and (Fav = '#HomeTeam#' or UND = '#Hometeam#')) as Stat
		FROM PBPStatsForPred
		WHERE Team IN ('#HomeTeam#')
		AND Period = 1
		AND OFFDef = 'D'
</cfquery>	
	
<cfquery datasource="NBA" name="dGetHomePosCt2">
		Select TotalPossesions/(Select count(*) from NBASchedule where gametime > '20171016' and gametime < '#gametime#' and (Fav = '#HomeTeam#' or UND = '#Hometeam#')) as Stat
		FROM PBPStatsForPred
		WHERE Team IN ('#HomeTeam#')
		AND Period = 2
		AND OFFDef = 'D'
</cfquery>	
	
<cfquery datasource="NBA" name="dGetHomePosCt3">
		Select TotalPossesions/(Select count(*) from NBASchedule where gametime > '20171016' and gametime < '#gametime#' and (Fav = '#HomeTeam#' or UND = '#Hometeam#')) as Stat
		FROM PBPStatsForPred
		WHERE Team IN ('#HomeTeam#')
		AND Period = 3
		AND OFFDef = 'D'
</cfquery>	
	
<cfquery datasource="NBA" name="dGetHomePosCt4">
		Select TotalPossesions/(Select count(*) from NBASchedule where gametime > '20171016' and gametime < '#gametime#' and (Fav = '#HomeTeam#' or UND = '#Hometeam#')) as Stat
		FROM PBPStatsForPred
		WHERE Team IN ('#HomeTeam#')
		AND Period = 4
		AND OFFDef = 'D'
</cfquery>	
	
		<cfquery datasource="NBA" name="AGetStats1">
			Select 
				(o.gs2ptShortMissPct + d.gs2ptShortMissPct)/2 AS gs2ptShortMissPct,	
				(o.gs2ptShortMakePct + d.gs2ptShortMakePct)/2 AS gs2ptShortMakePct,    
				(o.gs2ptMidMissPct   + d.gs2ptMidMissPct)/2   AS gs2ptMidMissPct,      
				(o.gs2ptMidMakePct   + d.gs2ptMidMakePct)/2   AS gs2ptMidMakePct,      
				(o.gs3ptMakePct      + d.gs3ptMakePct)/2      AS gs3ptMakePct,         
				(o.gs3ptMissPct      + d.gs3ptMissPct)/2      AS gs3ptMissPct,         
				(o.gsFTMakePct       + d.gsFTMakePct)/2       AS gsFTMakePct,          
				(o.gsFTMissPct       + d.gsFTMissPct)/2       AS gsFTMissPct,         
				(o.gsShortRebPct     + d.gsShortRebPct)/2     AS gsShortRebPct, 
				(o.gsMidRebPct       + d.gsMidRebPct)/2       AS gsMidRebPct  ,   
				(o.gsLongRebPct      + d.gsLongRebPct)/2      AS gsLongRebPct      
			FROM PBPStatsForPred o, PBPStatsForPred d 
			WHERE o.Team = '#AWAYTEAM#'
			AND o.Period = 1
			AND o.OFFDef = 'O'
			
			AND d.Team = '#Hometeam#'
			AND d.Period = 1
			AND d.OFFDef = 'D'
		</cfquery>	
	
		<cfquery datasource="NBA" name="AGetStats2">
			Select 
				(o.gs2ptShortMissPct + d.gs2ptShortMissPct)/2 AS gs2ptShortMissPct,	
				(o.gs2ptShortMakePct + d.gs2ptShortMakePct)/2 AS gs2ptShortMakePct,    
				(o.gs2ptMidMissPct   + d.gs2ptMidMissPct)/2   AS gs2ptMidMissPct,      
				(o.gs2ptMidMakePct   + d.gs2ptMidMakePct)/2   AS gs2ptMidMakePct,      
				(o.gs3ptMakePct      + d.gs3ptMakePct)/2      AS gs3ptMakePct,         
				(o.gs3ptMissPct      + d.gs3ptMissPct)/2      AS gs3ptMissPct,         
				(o.gsFTMakePct       + d.gsFTMakePct)/2       AS gsFTMakePct,          
				(o.gsFTMissPct       + d.gsFTMissPct)/2       AS gsFTMissPct,         
				(o.gsShortRebPct     + d.gsShortRebPct)/2     AS gsShortRebPct, 
				(o.gsMidRebPct       + d.gsMidRebPct)/2       AS gsMidRebPct  ,   
				(o.gsLongRebPct      + d.gsLongRebPct)/2      AS gsLongRebPct      
			FROM PBPStatsForPred o, PBPStatsForPred d 
			WHERE o.Team = '#AWAYTEAM#'
			AND o.Period = 2
			AND o.OFFDef = 'O'
			
			AND d.Team = '#Hometeam#'
			AND d.Period = 2
			AND d.OFFDef = 'D'
		</cfquery>	
	
	
		<cfquery datasource="NBA" name="AGetStats3">
			Select 
				(o.gs2ptShortMissPct + d.gs2ptShortMissPct)/2 AS gs2ptShortMissPct,	
				(o.gs2ptShortMakePct + d.gs2ptShortMakePct)/2 AS gs2ptShortMakePct,    
				(o.gs2ptMidMissPct   + d.gs2ptMidMissPct)/2   AS gs2ptMidMissPct,      
				(o.gs2ptMidMakePct   + d.gs2ptMidMakePct)/2   AS gs2ptMidMakePct,      
				(o.gs3ptMakePct      + d.gs3ptMakePct)/2      AS gs3ptMakePct,         
				(o.gs3ptMissPct      + d.gs3ptMissPct)/2      AS gs3ptMissPct,         
				(o.gsFTMakePct       + d.gsFTMakePct)/2       AS gsFTMakePct,          
				(o.gsFTMissPct       + d.gsFTMissPct)/2       AS gsFTMissPct,         
				(o.gsShortRebPct     + d.gsShortRebPct)/2     AS gsShortRebPct, 
				(o.gsMidRebPct       + d.gsMidRebPct)/2       AS gsMidRebPct  ,   
				(o.gsLongRebPct      + d.gsLongRebPct)/2      AS gsLongRebPct      
			FROM PBPStatsForPred o, PBPStatsForPred d 
			WHERE o.Team = '#AWAYTEAM#'
			AND o.Period = 3
			AND o.OFFDef = 'O'
			
			AND d.Team = '#Hometeam#'
			AND d.Period = 3
			AND d.OFFDef = 'D'
		</cfquery>	

	
		<cfquery datasource="NBA" name="AGetStats4">
			Select 
				(o.gs2ptShortMissPct + d.gs2ptShortMissPct)/2 AS gs2ptShortMissPct,	
				(o.gs2ptShortMakePct + d.gs2ptShortMakePct)/2 AS gs2ptShortMakePct,    
				(o.gs2ptMidMissPct   + d.gs2ptMidMissPct)/2   AS gs2ptMidMissPct,      
				(o.gs2ptMidMakePct   + d.gs2ptMidMakePct)/2   AS gs2ptMidMakePct,      
				(o.gs3ptMakePct      + d.gs3ptMakePct)/2      AS gs3ptMakePct,         
				(o.gs3ptMissPct      + d.gs3ptMissPct)/2      AS gs3ptMissPct,         
				(o.gsFTMakePct       + d.gsFTMakePct)/2       AS gsFTMakePct,          
				(o.gsFTMissPct       + d.gsFTMissPct)/2       AS gsFTMissPct,         
				(o.gsShortRebPct     + d.gsShortRebPct)/2     AS gsShortRebPct, 
				(o.gsMidRebPct       + d.gsMidRebPct)/2       AS gsMidRebPct  ,   
				(o.gsLongRebPct      + d.gsLongRebPct)/2      AS gsLongRebPct      
			FROM PBPStatsForPred o, PBPStatsForPred d 
			WHERE o.Team = '#AWAYTEAM#'
			AND o.Period = 4
			AND o.OFFDef = 'O'
			
			AND d.Team = '#Hometeam#'
			AND d.Period = 4
			AND d.OFFDef = 'D'
		</cfquery>	

	
	
		<cfquery datasource="NBA" name="HGetStats1">
			Select 
				(o.gs2ptShortMissPct + d.gs2ptShortMissPct)/2 AS gs2ptShortMissPct,	
				(o.gs2ptShortMakePct + d.gs2ptShortMakePct)/2 AS gs2ptShortMakePct,    
				(o.gs2ptMidMissPct   + d.gs2ptMidMissPct)/2   AS gs2ptMidMissPct,      
				(o.gs2ptMidMakePct   + d.gs2ptMidMakePct)/2   AS gs2ptMidMakePct,      
				(o.gs3ptMakePct      + d.gs3ptMakePct)/2      AS gs3ptMakePct,         
				(o.gs3ptMissPct      + d.gs3ptMissPct)/2      AS gs3ptMissPct,         
				(o.gsFTMakePct       + d.gsFTMakePct)/2       AS gsFTMakePct,          
				(o.gsFTMissPct       + d.gsFTMissPct)/2       AS gsFTMissPct,         
				(o.gsShortRebPct     + d.gsShortRebPct)/2     AS gsShortRebPct, 
				(o.gsMidRebPct       + d.gsMidRebPct)/2       AS gsMidRebPct  ,   
				(o.gsLongRebPct      + d.gsLongRebPct)/2      AS gsLongRebPct      
			FROM PBPStatsForPred o, PBPStatsForPred d 
			WHERE o.Team = '#HOMETEAM#'
			AND o.Period = 1
			AND o.OFFDef = 'O'
			
			AND d.Team = '#Awayteam#'
			AND d.Period = 1
			AND d.OFFDef = 'D'
		</cfquery>	
	
		<cfquery datasource="NBA" name="HGetStats2">
			Select 
				(o.gs2ptShortMissPct + d.gs2ptShortMissPct)/2 AS gs2ptShortMissPct,	
				(o.gs2ptShortMakePct + d.gs2ptShortMakePct)/2 AS gs2ptShortMakePct,    
				(o.gs2ptMidMissPct   + d.gs2ptMidMissPct)/2   AS gs2ptMidMissPct,      
				(o.gs2ptMidMakePct   + d.gs2ptMidMakePct)/2   AS gs2ptMidMakePct,      
				(o.gs3ptMakePct      + d.gs3ptMakePct)/2      AS gs3ptMakePct,         
				(o.gs3ptMissPct      + d.gs3ptMissPct)/2      AS gs3ptMissPct,         
				(o.gsFTMakePct       + d.gsFTMakePct)/2       AS gsFTMakePct,          
				(o.gsFTMissPct       + d.gsFTMissPct)/2       AS gsFTMissPct,         
				(o.gsShortRebPct     + d.gsShortRebPct)/2     AS gsShortRebPct, 
				(o.gsMidRebPct       + d.gsMidRebPct)/2       AS gsMidRebPct  ,   
				(o.gsLongRebPct      + d.gsLongRebPct)/2      AS gsLongRebPct      
			FROM PBPStatsForPred o, PBPStatsForPred d 
			WHERE o.Team = '#HOMETEAM#'
			AND o.Period = 2
			AND o.OFFDef = 'O'
			
			AND d.Team = '#Awayteam#'
			AND d.Period = 2
			AND d.OFFDef = 'D'
		</cfquery>	
	
	
		<cfquery datasource="NBA" name="HGetStats3">
			Select 
				(o.gs2ptShortMissPct + d.gs2ptShortMissPct)/2 AS gs2ptShortMissPct,	
				(o.gs2ptShortMakePct + d.gs2ptShortMakePct)/2 AS gs2ptShortMakePct,    
				(o.gs2ptMidMissPct   + d.gs2ptMidMissPct)/2   AS gs2ptMidMissPct,      
				(o.gs2ptMidMakePct   + d.gs2ptMidMakePct)/2   AS gs2ptMidMakePct,      
				(o.gs3ptMakePct      + d.gs3ptMakePct)/2      AS gs3ptMakePct,         
				(o.gs3ptMissPct      + d.gs3ptMissPct)/2      AS gs3ptMissPct,         
				(o.gsFTMakePct       + d.gsFTMakePct)/2       AS gsFTMakePct,          
				(o.gsFTMissPct       + d.gsFTMissPct)/2       AS gsFTMissPct,         
				(o.gsShortRebPct     + d.gsShortRebPct)/2     AS gsShortRebPct, 
				(o.gsMidRebPct       + d.gsMidRebPct)/2       AS gsMidRebPct  ,   
				(o.gsLongRebPct      + d.gsLongRebPct)/2      AS gsLongRebPct      
			FROM PBPStatsForPred o, PBPStatsForPred d 
			WHERE o.Team = '#HomeTeam#'
			AND o.Period = 3
			AND o.OFFDef = 'O'
			
			AND d.Team = '#Awayteam#'
			AND d.Period = 3
			AND d.OFFDef = 'D'
		</cfquery>	

	
		<cfquery datasource="NBA" name="HGetStats4">
			Select 
				(o.gs2ptShortMissPct + d.gs2ptShortMissPct)/2 AS gs2ptShortMissPct,	
				(o.gs2ptShortMakePct + d.gs2ptShortMakePct)/2 AS gs2ptShortMakePct,    
				(o.gs2ptMidMissPct   + d.gs2ptMidMissPct)/2   AS gs2ptMidMissPct,      
				(o.gs2ptMidMakePct   + d.gs2ptMidMakePct)/2   AS gs2ptMidMakePct,      
				(o.gs3ptMakePct      + d.gs3ptMakePct)/2      AS gs3ptMakePct,         
				(o.gs3ptMissPct      + d.gs3ptMissPct)/2      AS gs3ptMissPct,         
				(o.gsFTMakePct       + d.gsFTMakePct)/2       AS gsFTMakePct,          
				(o.gsFTMissPct       + d.gsFTMissPct)/2       AS gsFTMissPct,         
				(o.gsShortRebPct     + d.gsShortRebPct)/2     AS gsShortRebPct, 
				(o.gsMidRebPct       + d.gsMidRebPct)/2       AS gsMidRebPct  ,   
				(o.gsLongRebPct      + d.gsLongRebPct)/2      AS gsLongRebPct      
			FROM PBPStatsForPred o, PBPStatsForPred d 
			WHERE o.Team = '#HOMETEAM#'
			AND o.Period = 4
			AND o.OFFDef = 'O'
			
			AND d.Team = '#Awayteam#'
			AND d.Period = 4
			AND d.OFFDef = 'D'
		</cfquery>	
	
		<cfset ags2ptMissShortReb1 = ROUND(100*AGetStats1.gsShortRebPct)>
		<cfset ags2ptMissMidReb1   = ROUND(100*AGetStats1.gsMidRebPct)>
		<cfset ags3ptMissReb1      = ROUND(100*AGetStats1.gsLongRebPct)>
		
		<cfset ags2ptMakeShort1     = ROUND(100*AGetStats1.gs2ptShortMakePct)>
		<cfset ags2ptMakeMid1        = ROUND(100*AGetStats1.gs2ptMidMakePct)>
		<cfset ags3ptMake1           = ROUND(100*AGetStats1.gs3ptMakePct)>
		<cfset agsFTMade1            = ROUND(100*AGetStats1.gsFTMakePct)>
		<cfset agsFTMiss1            = ROUND(100*AGetStats1.gsFTMissPct)>
		<cfset ags2ptShortMiss1      = ROUND(100*AGetStats1.gs2ptShortMissPct)>
		<cfset ags2ptMidMiss1        = ROUND(100*AGetStats1.gs2ptMidMissPct)>
		<cfset ags3ptMiss1           = ROUND(100*AGetStats1.gs3ptMissPct)>
	
		<cfset ags2ptMissShortReb2 = ROUND(100*AGetStats2.gsShortRebPct)>
		<cfset ags2ptMissMidReb2   = ROUND(100*AGetStats2.gsMidRebPct)>
		<cfset ags3ptMissReb2      = ROUND(100*AGetStats2.gsLongRebPct)>
		
		<cfset ags2ptMakeShort2     = ROUND(100*AGetStats2.gs2ptShortMakePct)>
		<cfset ags2ptMakeMid2       = ROUND(100*AGetStats2.gs2ptMidMakePct)>
		<cfset ags3ptMake2          = ROUND(100*AGetStats2.gs3ptMakePct)>
		<cfset agsFTMade2           = ROUND(100*AGetStats2.gsFTMakePct)>
		<cfset agsFTMiss2           = ROUND(100*AGetStats2.gsFTMissPct)>
		<cfset ags2ptShortMiss2     = ROUND(100*AGetStats2.gs2ptShortMissPct)>
		<cfset ags2ptMidMiss2       = ROUND(100*AGetStats2.gs2ptMidMissPct)>
		<cfset ags3ptMiss2          = ROUND(100*AGetStats2.gs3ptMissPct)>
	
		<cfset ags2ptMissShortReb3 = ROUND(100*AGetStats3.gsShortRebPct)>
		<cfset ags2ptMissMidReb3   = ROUND(100*AGetStats3.gsMidRebPct)>
		<cfset ags3ptMissReb3      = ROUND(100*AGetStats3.gsLongRebPct)>
		
		<cfset ags2ptMakeShort3     = ROUND(100*AGetStats3.gs2ptShortMakePct)>
		<cfset ags2ptMakeMid3       = ROUND(100*AGetStats3.gs2ptMidMakePct)>
		<cfset ags3ptMake3          = ROUND(100*AGetStats3.gs3ptMakePct)>
		<cfset agsFTMade3           = ROUND(100*AGetStats3.gsFTMakePct)>
		<cfset agsFTMiss3           = ROUND(100*AGetStats3.gsFTMissPct)>
		<cfset ags2ptShortMiss3     = ROUND(100*AGetStats3.gs2ptShortMissPct)>
		<cfset ags2ptMidMiss3       = ROUND(100*AGetStats3.gs2ptMidMissPct)>
		<cfset ags3ptMiss3          = ROUND(100*AGetStats3.gs3ptMissPct)>
	
		<cfset ags2ptMissShortReb4 = ROUND(100*AGetStats4.gsShortRebPct)>
		<cfset ags2ptMissMidReb4   = ROUND(100*AGetStats4.gsMidRebPct)>
		<cfset ags3ptMissReb4      = ROUND(100*AGetStats4.gsLongRebPct)>
		
		<cfset ags2ptMakeShort4     = ROUND(100*AGetStats4.gs2ptShortMakePct)>
		<cfset ags2ptMakeMid4       = ROUND(100*AGetStats4.gs2ptMidMakePct)>
		<cfset ags3ptMake4          = ROUND(100*AGetStats4.gs3ptMakePct)>
		<cfset agsFTMade4           = ROUND(100*AGetStats4.gsFTMakePct)>
		<cfset agsFTMiss4           = ROUND(100*AGetStats4.gsFTMissPct)>
		<cfset ags2ptShortMiss4      = ROUND(100*AGetStats4.gs2ptShortMissPct)>
		<cfset ags2ptMidMiss4        = ROUND(100*AGetStats4.gs2ptMidMissPct)>
		<cfset ags3ptMiss4           = ROUND(100*AGetStats4.gs3ptMissPct)>



		
	
		<cfset hgs2ptMissShortReb1 = ROUND(100*hGetStats1.gsShortRebPct)>
		<cfset hgs2ptMissMidReb1   = ROUND(100*hGetStats1.gsMidRebPct)>
		<cfset hgs3ptMissReb1      = ROUND(100*hGetStats1.gsLongRebPct)>
		
		<cfset hgs2ptMakeShort1     = ROUND(100*hGetStats1.gs2ptShortMakePct)>
		<cfset hgs2ptMakeMid1        = ROUND(100*hGetStats1.gs2ptMidMakePct)>
		<cfset hgs3ptMake1           = ROUND(100*hGetStats1.gs3ptMakePct)>
		<cfset hgsFTMade1            = ROUND(100*hGetStats1.gsFTMakePct)>
		<cfset hgsFTMiss1            = ROUND(100*hGetStats1.gsFTMissPct)>
		<cfset hgs2ptShortMiss1      = ROUND(100*hGetStats1.gs2ptShortMissPct)>
		<cfset hgs2ptMidMiss1        = ROUND(100*hGetStats1.gs2ptMidMissPct)>
		<cfset hgs3ptMiss1           = ROUND(100*hGetStats1.gs3ptMissPct)>
	
		<cfset hgs2ptMissShortReb2 = ROUND(100*hGetStats2.gsShortRebPct)>
		<cfset hgs2ptMissMidReb2   = ROUND(100*hGetStats2.gsMidRebPct)>
		<cfset hgs3ptMissReb2      = ROUND(100*hGetStats2.gsLongRebPct)>
		
		<cfset hgs2ptMakeShort2     = ROUND(100*hGetStats2.gs2ptShortMakePct)>
		<cfset hgs2ptMakeMid2       = ROUND(100*hGetStats2.gs2ptMidMakePct)>
		<cfset hgs3ptMake2          = ROUND(100*hGetStats2.gs3ptMakePct)>
		<cfset hgsFTMade2           = ROUND(100*hGetStats2.gsFTMakePct)>
		<cfset hgsFTMiss2           = ROUND(100*hGetStats2.gsFTMissPct)>
		<cfset hgs2ptShortMiss2      = ROUND(100*hGetStats2.gs2ptShortMissPct)>
		<cfset hgs2ptMidMiss2        = ROUND(100*hGetStats2.gs2ptMidMissPct)>
		<cfset hgs3ptMiss2           = ROUND(100*hGetStats2.gs3ptMissPct)>
	
		<cfset hgs2ptMissShortReb3 = ROUND(100*hGetStats3.gsShortRebPct)>
		<cfset hgs2ptMissMidReb3   = ROUND(100*hGetStats3.gsMidRebPct)>
		<cfset hgs3ptMissReb3      = ROUND(100*hGetStats3.gsLongRebPct)>
		
		<cfset hgs2ptMakeShort3     = ROUND(100*hGetStats3.gs2ptShortMakePct)>
		<cfset hgs2ptMakeMid3       = ROUND(100*hGetStats3.gs2ptMidMakePct)>
		<cfset hgs3ptMake3          = ROUND(100*hGetStats3.gs3ptMakePct)>
		<cfset hgsFTMade3           = ROUND(100*hGetStats3.gsFTMakePct)>
		<cfset hgsFTMiss3           = ROUND(100*hGetStats3.gsFTMissPct)>
		<cfset hgs2ptShortMiss3      = ROUND(100*hGetStats3.gs2ptShortMissPct)>
		<cfset hgs2ptMidMiss3        = ROUND(100*hGetStats3.gs2ptMidMissPct)>
		<cfset hgs3ptMiss3           = ROUND(100*hGetStats3.gs3ptMissPct)>

	
		<cfset hgs2ptMissShortReb4 = ROUND(100*hGetStats4.gsShortRebPct)>
		<cfset hgs2ptMissMidReb4   = ROUND(100*hGetStats4.gsMidRebPct)>
		<cfset hgs3ptMissReb4      = ROUND(100*hGetStats4.gsLongRebPct)>
		
		<cfset hgs2ptMakeShort4    = ROUND(100*hGetStats4.gs2ptShortMakePct)>
		<cfset hgs2ptMakeMid4      = ROUND(100*hGetStats4.gs2ptMidMakePct)>
		<cfset hgs3ptMake4        = ROUND(100*hGetStats4.gs3ptMakePct)>
		<cfset hgsFTMade4          = ROUND(100*hGetStats4.gsFTMakePct)>
		<cfset hgsFTMiss4          = ROUND(100*hGetStats4.gsFTMissPct)>
		<cfset hgs2ptShortMiss4      = ROUND(100*hGetStats4.gs2ptShortMissPct)>
		<cfset hgs2ptMidMiss4        = ROUND(100*hGetStats4.gs2ptMidMissPct)>
		<cfset hgs3ptMiss4           = ROUND(100*hGetStats4.gs3ptMissPct)>
	

<cfscript>
 Application.objRandom = CreateObject("Component", "Random");
</cfscript>
 
<cfset tot = 0>
<cfset FinalScoreAllQtrsAway = 0>
<cfset FinalScoreAllQtrsHome = 0>

<cfloop index="zz" from="1" to="4">
	<cfset AwayTeamPlayCt = 0>
	<cfset HomeTeamPlayCt = 0>

	<cfset FinalHomeScore = 0>
	<cfset FinalAwayScore = 0>

	<cfset HomeWins  = 0>
	<cfset AwayWins  = 0>
	<cfset HomeCover = 0>

	<cfset period = zz>

	<cfswitch expression="#period#">
	
		<cfcase value=1>
			<cfset PredPossHome = 	(oGetHomePosCt1.Stat + dGetAwayPosCt1.Stat)/2 >
			<cfset PredPossAway = 	(oGetAwayPosCt1.Stat + dGetHomePosCt1.Stat)/2 >
		</cfcase>
	
		<cfcase value=2>
			<cfset PredPossHome = 	(oGetHomePosCt2.Stat + dGetAwayPosCt2.Stat)/2 >
			<cfset PredPossAway = 	(oGetAwayPosCt2.Stat + dGetHomePosCt2.Stat)/2 >
		</cfcase>
	
		<cfcase value=3>
			<cfset PredPossHome = 	(oGetHomePosCt3.Stat + dGetAwayPosCt3.Stat)/2 >
			<cfset PredPossAway = 	(oGetAwayPosCt3.Stat + dGetHomePosCt3.Stat)/2 >
		</cfcase>

		<cfcase value=4>
			<cfset PredPossHome = 	(oGetHomePosCt4.Stat + dGetAwayPosCt4.Stat)/2 >
			<cfset PredPossAway = 	(oGetAwayPosCt4.Stat + dGetHomePosCt4.Stat)/2 >
		</cfcase>

	</cfswitch>
	
	
	<cfloop index="r" from="1" to="1000">
		<cfset Score     = 0>
		<cfset AwayScore = 0>
		<cfset HomeScore = 0>
	
		<cfscript>
			Application.objRandom.setBounds(1,100);
		</cfscript>

		<cfscript>
				Rn = Application.objRandom.next();
		</cfscript>
			
		<cfset done    = false>
		<cfif r mod 2 is 0>
			<cfset PossFor = HomeTeam>
			<cfset PossForHa = 'H'>
			<cfset OppHa     = 'A'>
			
		<cfelse>
			<cfset PossFor = AwayTeam>
			<cfset PossForHa = 'A'>
			<cfset OppHa     = 'H'>
		</cfif>
	
<cfloop condition="done is false">
	<cfset AddPlayCt = 'Y'>
	<cfset score     = 0>

	<cfif PossFor is awayteam>
		<!--- Get the correct data based on the quarter... --->
		<cfswitch expression="#period#">
			
			<cfcase value=1>
				<cfset gs2ptMakeShort    = ags2ptMakeShort1>
				<cfset gs2ptMakeMid      = ags2ptMakeMid1>
				<cfset gs3ptMake         = ags3ptMake1>
				<cfset gsFTMade          = agsFTMade1>
				<cfset gsFTMiss          = agsFTMiss1>
				<cfset gs2ptShortMiss    = ags2ptShortMiss1>
				<cfset gs2ptMidMiss      = ags2ptMidMiss1>
				<cfset gs3ptMiss         = ags3ptMiss1>
			</cfcase>
			
			<cfcase value=2>
				<cfset gs2ptMakeShort    = ags2ptMakeShort2>
				<cfset gs2ptMakeMid      = ags2ptMakeMid2>
				<cfset gs3ptMake         = ags3ptMake2>
				<cfset gsFTMade          = agsFTMade2>
				<cfset gsFTMiss          = agsFTMiss2>
				<cfset gs2ptShortMiss    = ags2ptShortMiss2>
				<cfset gs2ptMidMiss      = ags2ptMidMiss2>
				<cfset gs3ptMiss         = ags3ptMiss2>
			</cfcase>
			
			<cfcase value=3>
				<cfset gs2ptMakeShort    = ags2ptMakeShort3>
				<cfset gs2ptMakeMid      = ags2ptMakeMid3>
				<cfset gs3ptMake         = ags3ptMake3>
				<cfset gsFTMade          = agsFTMade3>
				<cfset gsFTMiss          = agsFTMiss3>
				<cfset gs2ptShortMiss    = ags2ptShortMiss3>
				<cfset gs2ptMidMiss      = ags2ptMidMiss3>
				<cfset gs3ptMiss         = ags3ptMiss3>

			</cfcase>
			
			<cfcase value=4>
				<cfset gs2ptMakeShort    = ags2ptMakeShort4>
				<cfset gs2ptMakeMid      = ags2ptMakeMid4>
				<cfset gs3ptMake         = ags3ptMake4>
				<cfset gsFTMade          = agsFTMade4>
				<cfset gsFTMiss          = agsFTMiss4>
				<cfset gs2ptShortMiss    = ags2ptShortMiss4>
				<cfset gs2ptMidMiss      = ags2ptMidMiss4>
				<cfset gs3ptMiss         = ags3ptMiss4>
			</cfcase>
		</cfswitch>		
			
	
	<cfelse>
	
		<!--- Get the correct data based on the quarter... --->
		<cfswitch expression="#period#">
			
			<cfcase value=1>
				<cfset gs2ptMakeShort    = hgs2ptMakeShort1>
				<cfset gs2ptMakeMid      = hgs2ptMakeMid1>
				<cfset gs3ptMake         = hgs3ptMake1>
				<cfset gsFTMade          = hgsFTMade1>
				<cfset gsFTMiss          = hgsFTMiss1>
				<cfset gs2ptShortMiss    = hgs2ptShortMiss1>
				<cfset gs2ptMidMiss      = hgs2ptMidMiss1>
				<cfset gs3ptMiss         = hgs3ptMiss1>
				
			</cfcase>
			
			<cfcase value=2>
				<cfset gs2ptMakeShort    = hgs2ptMakeShort2>
				<cfset gs2ptMakeMid      = hgs2ptMakeMid2>
				<cfset gs3ptMake         = hgs3ptMake2>
				<cfset gsFTMade          = hgsFTMade2>
				<cfset gsFTMiss          = hgsFTMiss2>
				<cfset gs2ptShortMiss    = hgs2ptShortMiss2>
				<cfset gs2ptMidMiss      = hgs2ptMidMiss2>
				<cfset gs3ptMiss         = hgs3ptMiss2>

			</cfcase>
			
			<cfcase value=3>
				<cfset gs2ptMakeShort    = hgs2ptMakeShort3>
				<cfset gs2ptMakeMid      = hgs2ptMakeMid3>
				<cfset gs3ptMake         = hgs3ptMake3>
				<cfset gsFTMade          = hgsFTMade3>
				<cfset gsFTMiss          = hgsFTMiss3>
				<cfset gs2ptShortMiss    = hgs2ptShortMiss3>
				<cfset gs2ptMidMiss      = hgs2ptMidMiss3>
				<cfset gs3ptMiss         = hgs3ptMiss3>
			</cfcase>
			
			<cfcase value=4>
				<cfset gs2ptMakeShort    = hgs2ptMakeShort4>
				<cfset gs2ptMakeMid      = hgs2ptMakeMid4>
				<cfset gs3ptMake         = hgs3ptMake4>
				<cfset gsFTMade          = hgsFTMade4>
				<cfset gsFTMiss          = hgsFTMiss4>
				<cfset gs2ptShortMiss    = hgs2ptShortMiss4>
				<cfset gs2ptMidMiss      = hgs2ptMidMiss4>
				<cfset gs3ptMiss         = hgs3ptMiss4>  
			</cfcase>
		</cfswitch>		
	</cfif>
	
	<cfset range1            = gs2ptMakeShort>
	<cfset range2 = range1   + gs2ptMakeMid>
	<cfset range3 = range2   + gs3ptMake>
	<cfset range4 = range3   + gs2ptShortMiss>
	<cfset range5 = range4   + gs2ptMidMiss>
	<cfset range6 = range5   + gs3ptMiss>
	<cfset range7 = range6   + gsFTMade>
	<cfset range8 = range7   + gsFTMiss>
	
		<!---
		<cfdump var="#variables#">
		
	<cfdump var="#variables#">
<cfabort>
		--->
		


	<cfscript>
		Rn = Application.objRandom.next();
	</cfscript>

	<!---<cfoutput>	
	The random number for Possession Type was... #rn#<br>
	</cfoutput>--->
	                                         
	<Cfset PossesionType = getPossesionType(RN,range1,range2,range3,range4,range5,range6,range7,range8)>
	
	<cfswitch expression="#PossesionType#">
		
			<cfcase value="MissShortRge">
				<!---<cfoutput>	
				Missed 2pt Short Shot for #PossFor#<br>
				</cfoutput>--->
								
			</cfcase>

			<cfcase value="MissMidRge">
				<!---<cfoutput>	
				Missed 2pt Mid Rge Shot for #PossFor#<br>
				</cfoutput>--->
				
			</cfcase>

			<cfcase value="MissLongRge">
				<!---<cfoutput>	
				Missed 3pt Shot for #PossFor#<br>
				</cfoutput>--->
			</cfcase>
			
			<cfcase value="2ptMakeShort">
				<!---<cfoutput>			
				Made 2pt Short Shot for #PossFor#<br>
				</cfoutput>--->
				<cfset Score      =  2>
			</cfcase>
						
			
			<cfcase value="2ptMakeMid">
				
				<!---<cfoutput>
				Made 2pt Mid Range shot for #possfor#<br>		
				</cfoutput>--->
				
				<cfset Score      =  2>
				
			</cfcase>
			
			<cfcase value="3ptMake">
				<!---<cfoutput>
				Made 3pt shot for #PossFor#<br>	
				</cfoutput>--->
				
				<cfset Score      =  3>
				
			</cfcase>
			
			<cfcase value="FTMade">
				<!---<cfoutput>
				Free Throw Made for #PossFor#<br>
				</cfoutput>--->
								
				<cfset Score = 1>
				
			</cfcase>
			
			<cfcase value="FTMiss">
				<!---<cfoutput>
				Free Throw Miss for #PossFor#<br>
				</cfoutput>--->
				
			</cfcase>

			<cfcase value="Turnover">
				<cfset Score = 0>
				<!---<cfoutput>
				Turnover! for #PossFor#<br>
				</cfoutput>--->	
			</cfcase>
			

			<cfcase value="Error">
				<cfabort showerror="Error: Not one of the defined Possesion Types">		
			</cfcase>
		</cfswitch>
		

		<cfscript>
			Rn = Application.objRandom.next();
		</cfscript>
		
		
		<cfif AddPlayCt is 'Y'>
			<cfif PossFor is HomeTeam>
				<cfset HomeScore = HomeScore + Score>
				<cfset HomeTeamPlayCt = HomeTeamPlayCt + 1> 
				<cfset PossFor = AwayTeam>
				<cfset PossForHa = 'A'>
			<cfelse>
				<cfset AwayScore = AwayScore + Score>
				<cfset AwayTeamPlayCt = AwayTeamPlayCt + 1>
				<cfset PossFor = HomeTeam>
				<cfset PossForHa = 'H'>
			</cfif>
		</cfif>
				
		<cfif HomeTeamPlayCt gte PredPossHome  >
			<cfset PossFor = AwayTeam>
			<cfset PossForHa = 'A'>
		</cfif>
		
		<cfif AwayTeamPlayCt gte PredPossAway >
			<cfset PossFor = HomeTeam>
			<cfset PossForHa = 'H'>
		</cfif>	
					
			
		<cfif AwayTeamPlayCt gte PredPossAway >
			<cfif HomeTeamPlayCt gte PredPossHome >
				<cfset Tot = tot + Homescore + AwayScore>
				<cfset done = true>
			</cfif>	
		</cfif>
		
		
		<!---
		<cfoutput>	
		DEN #HomeScore#...#HomeTeamPlayCt#<br>
		MIL #AwayScore#...#AwayTeamPlayCt#<br>
		Posession is now for: #PossFor#<br>
		Ha is #possforHA#<br>
		Done?...#done#<br>
		</cfoutput>	
		--->
		
		
</cfloop>	

		
		
	<cfset score = 0>
	<cfset FinalHomeScore = FinalHomeScore + HomeScore>
	<cfset FinalAwayScore = FinalAwayScore + AwayScore>
	<cfset HomeTeamPlayCt = 0>
	<cfset AwayTeamPlayCt = 0>

</cfloop>	

<cfoutput>	
#hometeam# QTR:#period# Final #FinalHomeScore/r#<br>
#awayteam# QTR:#period# Final #FinalAwayScore/r#<br>
<cfset FinalScoreAllQtrsAway = FinalScoreAllQtrsAway + (FinalAwayScore/r)>
<cfset FinalScoreAllQtrsHome = FinalScoreAllQtrsHome + (FinalHomeScore/r)>
</cfoutput>

<p>
</cfloop>


<p>
<cfoutput>
Final Score:<br>
#hometeam# #FinalScoreAllQtrsHome#<br>
#awayteam# #FinalScoreAllQtrsAway#<br>
</cfoutput>

<cfscript> 
  function getFTPoss(rn)
  { 
	 if (rn lte 47.5)
	 	return 'ADDPOSS';
		
	if (rn gt 47.5)
	 	return 'NOADDPOSS';
		
		
  }
</cfscript>


	
<cfscript> 

  function getPossesionType(rn,MakeShortRge,MakeMidRge,LongMakeRge,MissShortRge,MissMidRge,MissLongRge,FTMadeRge,FTMissRge)
  { 
  
	if (rn lte MakeShortRge)
	 	return '2ptMakeShort';
  
	if (rn lte MakeMidRge)
	 	return '2ptMakeMid';

	if (rn lte LongMakeRge)
	 	return '3ptMake';
    		
	if (rn lte MissShortRge)
	 	return 'MissShortRge';
		
	if (rn lte MissMidRge)
	 	return 'MissMidRge';	
		
	if (rn lte MissLongRge)
	 	return 'MissLongRge';	
  
   	 if (rn lte FTMadeRge)
	 	return 'FTMade';
		
   	 if (rn lte FTMissRge)
	 	return 'FTMiss';
		
  	 if (rn lte 100)
	 	return 'Turnover';

     return 'Error'; 
	 
  } 
</cfscript>

<cfscript> 
  function getOFFRebResult(rn,ShotType,MissShortRebRge,MissMidRebRge,MissLongRebRge)
  { 
      if (ShotType is 'SHORTTWO')
	  {	
		if (rn lte MissShortRebRge)
			return 'REBOUND';
      
	  }
	  
	  if (ShotType is 'MIDTWO')
	  {
		if (rn lte MissMidRebRge)
			return 'REBOUND';
	  }	
  
	  if (ShotType is 'LONG')
	  {
		if (rn lte MissLongRebRge)
			return 'REBOUND';
    
	  }
	  return 'NOREBOUND';
   } 
</cfscript>