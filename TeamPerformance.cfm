

-- See how well a team performs versus expected based on Home/Away, Health, Health Advantage
<cfquery datasource="NBA" name="GetData">
SELECT 
    
    
   
        
        iif
        (
            d.OffEffort > 0 and d.ha = 'H' , 1, 0
        ) AS HOffBetterCt,
        
        iif
        (
            d.OffEffort < 0 and d.ha = 'H', 1, 0
        ) AS HOffWorseCt,
        
        iif
        (
            d.DefEffort > 0 and d.ha = 'H', 1, 0
        ) AS HDefBetterCt,
        
        iif
        (
            d.DefEffort < 0 and d.ha = 'H', 1, 0
        ) AS HDefWorseCt,


		iif
        (
            d.OffEffort > 0 and d.ha = 'A', 1, 0
        ) AS AOffBetterCt,
        
        iif
        (
            d.OffEffort < 0 and d.ha = 'A', 1, 0
        ) AS AOffWorseCt,
        
        iif
        (
            d.DefEffort > 0 and d.ha = 'A', 1, 0
        ) AS ADefBetterCt,
        
        iif
        (
            d.DefEffort < 0 and d.ha = 'A', 1, 0
        ) AS ADefWorseCt,
		
		 iif
    (
        p.FavHealthL7 <= -8,'Y','N'
    ) AS FavTiredFlag,
    
    iif
    (
        p.FavHealthL7 >= -3,'Y','N'
    ) AS FavRestedFlag,
    
    iif
    (
        p.UndHealthL7 <= -8,'Y','N'
    ) AS UndTiredFlag,
    
    iif
    (
        p.UndHealthL7 >= -3,'Y','N'
    ) AS UndRestedFlag,
    
    iif
    (
        p.UndHealthL7 - p.FavHealthL7 > 0,'Y','N'
    ) AS UndHealthADV,
    
    iif
    (
        p.UndHealthL7 - p.FavHealthL7 < 0,'Y','N'
    ) AS FavHealthADV,
    
    
    iif
    (
        p.UndHealthL7 - p.FavHealthL7 > 3,'Y','N'
    ) AS UndBigHealthADV,
    
    iif
    (
        p.UndHealthL7 - p.FavHealthL7 < -3,'Y','N'
    ) AS FavBigHealthADV,
    
    d.Team, 
    d.OffEffort, 
    d.DefEffort, 
    d.ha, 
    p.UndHealthL7, 
    p.FavHealthL7,     
    p.Fav AS FavTeam,
    p.Und AS UndTeam,
    iif
    (
        d.Team = p.FAV,'FAV','UND' 
    ) AS TeamType,
    d.gametime,
    p.WhoCovered,
    d.PS + d.dps AS TOTALPTS,
    s.ou,
    s.spd,
    iif
    (
            d.PS + d.dps > s.ou,'Y','N'
    ) AS WENT_OVER,
    
    iif
    (
            d.PS + d.dps < s.ou,'Y','N'
    ) AS WENT_UNDER,
    
    iif
    (
        p.WhoCovered = d.Team,'Y',iif(p.WhoCovered = 'PUSH','','N')
    ) AS DID_TEAM_COVER
     
FROM NBAData d, finalPicks p, NBASchedule s
WHERE (d.Team = p.fav or d.team = p.und)
AND d.gametime = p.gametime
AND d.gametime > '20181015'
AND d.mins     = 240
and s.gametime = d.gametime
and s.fav      = p.fav
and p.WhoCovered > ''
and d.OffEffort is not null
ORDER BY d.TEAM, d.Gametime
</cfquery>

<cfdump var="#GetData#">
   



<cfloop query="GetData">

<cfquery datasource="NBA" name="AddIt">
INSERT INTO TeamPerformance(TEAM,Gametime,HA,OffEffort,DefEffort,TeamType,spd,ou,TotalPts,Went_Over,Went_Under,WhoCovered,HOffBetterCt,HOffWorseCt,HDefBetterCt,HDefWorseCt,FavTiredFlag,FavRestedFlag,
UndTiredFlag,UndRestedFlag,FavHealthADV,UndHealthADV,UndHealthL7,FavHealthL7,Did_Team_Cover,FavBigHealthADV,UndBigHealthADV
)
Values
(
'#TEAM#','#Gametime#','#HA#',#OffEffort#,#DefEffort#,'#TeamType#',#spd#,#ou#,#TotalPts#,'#Went_Over#','#Went_Under#','#WhoCovered#',#HOffBetterCt#,#HOffWorseCt#,#HDefBetterCt#,#HDefWorseCt#,
'#FavTiredFlag#','#FavRestedFlag#','#UndTiredFlag#','#UndRestedFlag#','#FavHealthADV#','#UndHealthADV#',#UndHealthL7#,#FavHealthL7#,'#Did_Team_Cover#','#FavBigHealthADV#','#UndBigHealthADV#'
)
</cfquery>


</cfloop>


ADEFBETTERCT 	
ADEFWORSECT 	
AOFFBETTERCT 	
AOFFWORSECT 	
DEFEFFORT 	DID_TEAM_COVER 	FAVBIGHEALTHADV 	FAVHEALTHADV 	FAVHEALTHL7 	FAVRESTEDFLAG 	FAVTEAM 	FAVTIREDFLAG 	GAMETIME 	HA 	HDEFBETTERCT 	HDEFWORSECT 	HOFFBETTERCT 	HOFFWORSECT 	OFFEFFORT

