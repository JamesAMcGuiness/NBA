<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<!-- Blowout -->
<cfquery datasource="nba" name="Getinfo">
Select * from ImportantStatPreds
where FGPctBig >= 60
and rebbig >= 60
and tpmbig >=60
and (fgpctadv = fav and rebadv = fav and tpmadv = fav or fgpctadv = und and rebadv = und and tpmadv = und )
order by gametime desc
</cfquery>

<!-- Criteria is Advatange in ALL phases, spread le 10 and didn't play night before -->
<cfquery datasource="nba" name="Getinfo">
Select * from ImportantStatPreds
where (fgpctadv = fav and rebadv = fav and tpmadv = fav and ftmadv = fav or fgpctadv = und and rebadv = und and tpmadv = und and ftmadv = und )
order by gametime desc
</cfquery> 


<!-- This looks promising... Also no play if they played night previous -->
<cfquery datasource="nba" name="Getinfo">
Select * from PredictedStats
where favfg - undfg >= 4.82 
and favreb - undreb >= 4.35
and val(spd) <= 12 and val(spd) <> 0
order by gametime desc
</cfquery> 

<!-- This looks promising... For UNDER plays -->
<cfquery datasource="nba" name="Getinfo">
Select * from PreGameProb
where ffgpct < -59 and ufgpct < -59 
and (ftpm < 0 or utpm < 0)
order by gametime desc
</cfquery> 

<!-- Promising for UNDERS... Start AFTER November 18 -->
<cfquery datasource="nba" name="Getinfo">
Select * from PredictedStats
where (favfg + undfg < 85)
and (favtpm + undtpm < 10)
and (favfg + undfg <> 0)
order by gametime desc
</cfquery> 


<table border="1" width="50%">
<cfoutput query="Getinfo">
<tr>
<td>#gametime#</td>
<td>#fav#</td>
<td>#spread#</td>
<td>#und#</td>
<td>#favfg + undfg#</td>
<td>#favtpm + undtpm#</td>
<td>#favftm + undftm#</td>
<td>#ou#</td>
</tr>
</cfoutput>
</table>
<cfabort>


<table border="1" width="50%">
<cfoutput query="Getinfo">
<tr>
<td>#gametime#</td>
<td>#fav#</td>
<td>#spd#</td>
<td>#und#</td>
<td>#fgpctadv#</td>
<td>#fgpct60#</td>
<td>#fgpctBig#</td>
<td>#fgpctadv#</td>
<td>#reb60#</td>
<td>reb- #rebBig#</td>
</tr>
</cfoutput>
</table>
</body>
</html>
