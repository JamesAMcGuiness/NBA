<cfquery datasource="NBA" name="GetGames">
Select s.gametime, 
		s.fav,
		s.und,
		s.spd,
		fp.whocovered 
		 
from ImportantStatPreds i, finalpicks fp, nbaschedule s
where i.gametime = fp.gametime
and   s.gametime = i.gametime 
and   (s.fav = i.fav)
and fp.fav = i.fav
and i.gametime >= '20141115'
and i.PIPAdv   = s.und
and i.RebAdv   = s.und
and i.FGPCTAdv = s.und
and whocovered <> 'PUSH'
and s.spd > 0
order by s.gametime desc
</cfquery>

<cfoutput query="GetGames">
	#gametime# - #fav#/#und#<br>
#Whocovered#<br>
<hr>
</cfoutput>