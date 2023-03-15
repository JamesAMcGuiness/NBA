<cfquery datasource="Nba" name="GetRec">
Select SystemNum,w2012 as Wins2021,L2012 as Losses2021,(w2012/(w2012+L2012))*100 as WinPct2021, UpToDateWins, UpToDateLosses, (UpToDateWins/(UpToDateWins+UpToDateLosses)*100) as UpToDatePct 
from SystemRecord
Where SystemNum in ('SYS34','SYS51','SYS50','SYS52','SYS6','SYS27','SYS16','SYS4','SYS103','SYS16','SYS500','SYS17','SYS10','SYS42','SYS20','SYS3','SYS15','SYS99','SYS103','SYS57')
order by 7 desc
</cfquery>


<cfquery datasource="Nba" name="GetPot">
Select SystemNum,w2012 as Wins2021,L2012 as Losses2021,(w2012/(w2012+L2012))*100 as WinPct2021, UpToDateWins, UpToDateLosses, (UpToDateWins/(UpToDateWins+UpToDateLosses)*100) as UpToDatePct 
from SystemRecord
Where SystemNum in ('SYS60B','SYS60C','SYS21','SYS41','SYS31','SYS19','SYS40','SYS9','SYS301','SYS22','SYS80')
order by 7 desc
</cfquery>


<b>These System Are Vetted With 100+ Games..</b><p>
<cfoutput>
<table border="1" cellspacing="4", cellpadding="4">
<tr>
<td></td>
<td colspan="3" align="center">
<b>Current Year Record</b>
</td>


<td colspan="3" align="center">
<b>Lifetime Record</b>
</td>
</tr>

</tr>

<tr>
<td>
System
</td>

<td>
Wins 2022
</td>

<td>
Losses 2022
</td>

<td>
Pct 2022
</td>
	
<td>
Lifetime Wins
</td>

<td>
Lifetime Losses
</td>

<td>
Lifetime Pct
</td>
	
	
</tr>

<cfloop query="GetRec">
<tr>

<td>
#SystemNum#
</td>


<td>
#Wins2021#
</td>

<td>
#Losses2021#
</td>

<td>
#Numberformat(WinPct2021,'999')#%
</td>



<td>
#UpToDateWins#
</td>

<td>
#UpToDateLosses#
</td>

<td>
#NumberFormat(UpToDatePct,'999')#%
</td>

</tr>

</cfloop>

</cfoutput>
</table>


<p>
<p>



<b>These Systems Look Potentially Good But Are NOT yet Vetted With 100+ Games..</b><p>
<cfoutput>
<table border="1" cellspacing="4", cellpadding="4">
<tr>
<td></td>
<td colspan="3" align="center">
<b>Current Year Record</b>
</td>


<td colspan="3" align="center">
<b>Lifetime Record</b>
</td>
</tr>

</tr>

<tr>
<td>
System
</td>

<td>
Wins 2022
</td>

<td>
Losses 2022
</td>

<td>
Pct 2022
</td>
	
<td>
Lifetime Wins
</td>

<td>
Lifetime Losses
</td>

<td>
Lifetime Pct
</td>
	
	
</tr>

<cfloop query="GetPot">
<tr>

<td>
#SystemNum#
</td>


<td>
#Wins2021#
</td>

<td>
#Losses2021#
</td>

<td>
#Numberformat(WinPct2021,'999')#%
</td>



<td>
#UpToDateWins#
</td>

<td>
#UpToDateLosses#
</td>

<td>
#NumberFormat(UpToDatePct,'999')#%
</td>

</tr>

</cfloop>

</cfoutput>
</table>