
<cfquery datasource="NBA" name="GetPicks">
SELECT fp.fav,fp.spd,fp.und,sr.SystemNum, sr.UpToDatePct, sr.UpToDateWins, sr.UpToDateLosses
From SystemRecord sr, FinalPicks fp, NbaSchedule sched
WHERE Sched.GameTime = fp.GameTime
AND
(
fp.SYS27 > '' OR
fp.SYS28 > '' OR
fp.SYS35 > '' OR
fp.SYS6  > '' OR
fp.SYS16 > '' OR
fp.SYS10 > '' OR
fp.SYS20 > '' 
)
AND sr.UsingForPicksFlag = 'Y'

</cfquery>


<Table border="1" width="50%">
<tr>
<td>Fav</td>
<td>Spread</td>
<td>Und</td>
<td>System</td>
<td>Pick</td>
<td>Confidence</td>
<td>Lifetime Wins</td>
<td>Lifetime Losses</td>
</tr>

<cfloop query="GetPicks">

	<cfquery dbtype="query" name="GetPicks2">
	Select * from GetPicks 
	Where 
	SYS27 = '#GetPicks.Fav#' OR
	SYS28 = '#GetPicks.Fav#' OR
	SYS35 = '#GetPicks.Fav#' OR
	SYS6  = '#GetPicks.Fav#' OR
	SYS16 = '#GetPicks.Fav#' OR
	SYS10 = '#GetPicks.Fav#' OR
	SYS20 = '#GetPicks.Fav#' OR

	<cfif (ListFindNoCase(GetPicks2.ColumnList,"SYS27")) SYS27 = '#GetPicks.Und#' OR></cfif>
	SYS28 = '#GetPicks.Und#' OR
	SYS35 = '#GetPicks.Und#' OR
	SYS6  = '#GetPicks.Und#' OR
	SYS16 = '#GetPicks.Und#' OR
	SYS10 = '#GetPicks.Und#' OR
	SYS20 = '#GetPicks.Und#' 
	order by UpToDatePct DESC,SystemNum
	</cfquery>
	
	


<cfset rowct = 0>
<cfoutput query="GetPicks2">
	<cfset rowct = rowct + 1>
<tr>
<cfif Rowct is 1>
	<td>#Fav#</td>
	<td>#Spd#</td>
	<td>#Und#</td>
<cfelse>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
</cfif>
<td>#SystemNum#</td>
<cfif     '#Sys27#' neq ''>'#Sys27#'
<cfelseif '#Sys28#' neq ''>'#Sys28#'
<cfelseif '#Sys35#' neq ''>'#Sys35#'
<cfelseif '#Sys6#'  neq ''>'#Sys6#'
<cfelseif '#Sys16#' neq ''>'#Sys16#'
<cfelseif '#Sys10#' neq ''>'#Sys10#'
<cfelseif '#Sys20#' neq ''>'#Sys20#'
</cfif>
<td>#NumberFormat(UpToDatePct,"99.99")#</td>
<td>#NumberFormat(UpToDateWins,"99.99")#</td>
<td>#NumberFormat(UpToDateLosses,"99.99")#</td>
</tr>

</cfoutput>


</cfloop>















             