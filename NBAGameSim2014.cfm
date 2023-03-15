

<cfscript>
 Application.objRandom = CreateObject("Component", "Random");
</cfscript>

<cfset fav = 'PHX'>
<cfset und = 'CHA'>



<!--- 
Get The NBAPcts
 --->
<cfquery datasource="nba" name="GetInfo">
Select * from NBAPcts
</cfquery>

<!--- Get FAV NBAPcts --->
<cfquery dbtype="query" name="GetFavPcts">
Select * from GetInfo
where Team = '#FAV#'
</cfquery>

<!--- Get UND NBAPcts --->
<cfquery dbtype="query" name="GetUndPcts">
Select * from GetInfo
where Team = '#UND#'
</cfquery>

<!--- Get FAV Avgs --->
<cfquery datasource="NBA" name="GetFavAvgs">
Select * from NBAAvgs
where Team = '#FAV#'
</cfquery>

<!--- Get Und Avgs --->
<cfquery datasource="NBA" name="GetUndAvgs">
Select * from NBAAvgs
where Team = '#Und#'
</cfquery>


<!--- Create 	matrix --->
<cfquery datasource="NBA" name="GamePctMatrix">
Select 
	f.Team,
	(f.ofga + (100-u.dfga))/2     as oFAVFga,
	(f.ofgpct + (100-u.dfgpct))/2 as oFAVFgpct,
	(f.otpa + (100-u.dtpa))/2     as oFAVTPA,
	(f.ofta + (100-u.dfta))/2     as oFAVFTA,
	u.Team,
	(u.ofga + 100-(f.dfga))/2     as oUNDFga,
	(u.ofgpct + 100-(f.dfgpct))/2 as oUNDFgpct,
	(u.otpa + 100-(f.dtpa))/2     as oUNDTPA,
	(u.ofta + 100-(f.dfta))/2     as oUNDFTA
	
from NBAPcts f, NBAPcts u
Where f.Team = '#fav#'
and   u.Team = '#Und#'
</cfquery>


<table width="50%" border="1">
<tr>
<td>Team</td>
<td>FGA Over</td>
<td>FGPct Over</td>
<td>TPA Over</td>
<td>FTA Over</td>
</tr>
<cfoutput query = "GamePctMatrix">
<tr>
<td>
#fav#
</td>
<td>
#oFAVFga#
</td>
<td>
#oFAVFgpct#
</td>
<td>
#oFAVTPA#
</td>
<td>
#oFAVFTA#
</td>
</tr>



<tr>
<td>
#und#
</td>
<td>
#oUNDFga#
</td>
<td>
#oUNDFgpct#
</td>
<td>
#oUNDTPA#
</td>
<td>
#oUNDFTA#
</td>

</tr>


<tr>
<td>
Game
</td>
<td>
#(oUNDFga + oFAVFga)/2#
</td>
<td>
#(oUNDFgpct + oFAVFgpct)/2#
</td>
<td>
#(oUNDTPA + oFAVTPA)/2#
</td>
<td>
#(oUNDFTA + oFAVFTA)/2#
</td>

</tr>


</table>
</cfoutput>

<cfabort>


<!--- Create random number from 1 to 100 --->
<cfscript>
 Application.objRandom = CreateObject("Component", "Random");
 Application.objRandom.setBounds(1,100);
</cfscript>

<cfscript>
	RandomNumber = Application.objRandom.next();
</cfscript>



<cfscript>
	FAVKickOff = StructNew();
	StructInsert(FAVKickOff,'Team','#favname#');
	StructInsert(FAVKickOff,'FP1',FavKOFP1);
	StructInsert(FAVKickOff,'FP2',FavKOFP2);
	StructInsert(FAVKickOff,'FP3',FavKOFP3);
	StructInsert(FAVKickOff,'FP4',FavKOFP4);
	StructInsert(FAVKickOff,'FP5',FavKOFP5);
</cfscript>
