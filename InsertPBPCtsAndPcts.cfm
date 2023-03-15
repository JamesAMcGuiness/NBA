<cfset Gametime = '20171117'>
<Cfquery datasource="NBA" Name="GetCts">
SELECT 
	TEAM,
	OFFDEF,
	
	SUM(	
		SWITCH(PLAYTYPE='2PTMADE' AND (SHOTLENGTH > -1 AND SHOTLENGTH <= 5),1
			  )
	) AS VeryShortSucCt,
	
	SUM(	
		SWITCH((SHOTLENGTH > -1 AND SHOTLENGTH <= 5),1
			  )
	) AS VeryShortCt,
		
	
	SUM(	
		SWITCH(PLAYTYPE='2PTMADE' AND (SHOTLENGTH > 5 AND SHOTLENGTH <= 10),1
			  )
	) AS ShortSucCt,
	
	SUM(	
		SWITCH((SHOTLENGTH > 5 AND SHOTLENGTH <= 10),1
			  )
	) AS ShortCt,
		
	
	SUM(	
		SWITCH(PLAYTYPE='2PTMADE' AND (SHOTLENGTH > 10 AND SHOTLENGTH <= 15),1
			  )
	) AS MidSucCt,
	
	
	SUM(	
		SWITCH((SHOTLENGTH > 10 AND SHOTLENGTH <= 15),1
			  )
	) AS MidCt,
		
	
	SUM(	
		SWITCH(PLAYTYPE='2PTMADE' AND (SHOTLENGTH > 15 AND SHOTLENGTH < 22),1
			  )
	) AS MidLongSucCt,
	
	
		
	SUM(	
		SWITCH((SHOTLENGTH > 15 AND SHOTLENGTH < 22),1
			  )
	) AS MidLongCt,
		
	
	SUM(	
		SWITCH(PLAYTYPE='3PTMADE' AND (SHOTLENGTH > 22),1
			  )
	) AS LongSucCt,
	
	SUM(	
		SWITCH((SHOTLENGTH > 22),1
			  )
	) AS LongCt
FROM PBPResults	
WHERE SHOTTYPE='SHOT'
GROUP BY TEAM, OFFDEF
ORDER BY TEAM, OFFDEF
</cfquery>

<cfloop query="GetCts">
	<cfquery datasource="NBA" name="Addit">
	INSERT INTO PBPCtsAndPcts(TEAM,GAMETIME,OFFDEF,VeryShortCt,VeryShortSucCt,ShortCt,ShortSucCt,MidCt,MidSucCt,MidLongCt,MidLongSucCt,LongCt,LongSucCt)
	VALUES('#TEAM#','#GAMETIME#','#OFFDEF#',#VeryShortCt#,#VeryShortSucCt#,#ShortCt#,#ShortSucCt#,#MidCt#,#MidSucCt#,#MidLongCt#,#MidLongSucCt#,#LongCt#,#LongSucCt#)
	</cfquery>
</cfloop>

	<cfquery datasource="NBA" name="Addit">
	UPDATE PBPCtsAndPcts
	SET VShortSucRate  = VeryShortSucCt / VeryShortCt,
		ShortSucRate   = ShortSucCt / ShortCt,
		MidSucRate     = MidSucCt / MidCt,
		MidLongSucRate = MidLongSucCt / MidLongCt,
		LongSucRate    = LongSucCt / LongCt,
		TotScenarios   = VeryShortCt + ShortCt + MidCt + MidLongCt + LongCt
	</cfquery>


	<cfquery datasource="NBA" name="Addit">
	UPDATE PBPCtsAndPcts
	SET VShortScen  = VeryShortCt / TotScenarios,
		ShortScen   = ShortCt / TotScenarios,
		MidScen     = MidCt / TotScenarios,
		MidLongScen = MidLongCt / TotScenarios,
		LongScen    = LongCt / TotScenarios
		
	</cfquery>

	
	