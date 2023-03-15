<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>


<cfquery datasource="nba" name="GetDay">
Select Gametime
from NBAGametime
</cfquery>

<cfset mypickfilename = 'NBAPicks#GetDay.Gametime#.xls'>

<cfquery datasource="nba" name="GetPicks">
Select * from
(
Select distinct
	xxx.*,
	(xxx.w/(xxx.w + xxx.L))*100 as confidence
		
from

(
Select p.*, r.SystemNum, 
(r.W2012 + r.LifetimeWins) as w, 
(r.L2012 + r.LifetimeLosses) as l

from FinalPicks p, SystemRecord r	
WHERE 

(
p.SYS99 <> '' OR
p.SYS98 <> '' 
OR

	p.SYS6 <> '' OR
	p.SYS12 <> '' OR  
	p.SYS20 <> '' OR
	p.SYS27 <> '' OR
	p.SYS11 <> '' OR   
	p.SYS18 <> '' OR   
	



    p.SYS22 <> '' OR
	p.SYS3 <> '' OR  
	p.SYS4 <> '' OR
	p.SYS40 <> '' OR
	p.SYS15 <> '' OR   
	p.SYS23 <> '' OR   
	   
	p.SYS19 <> '' OR
	p.SYS34 <> '' OR
	p.SYS14 <> '' OR  
	p.SYS28 <> '' OR
	p.SYS16 <> '' OR
	p.SYS1 <> '' OR   
	p.SYS5 <> '' OR   
	   
	p.SYS17 <> '' OR
	p.SYS21 <> '' OR
	p.SYS17 <> '' OR  
	p.SYS24 <> '' OR
	p.SYS25 <> '' OR
	p.SYS29 <> '' OR   
	p.SYS30 <> '' OR   
	   
	p.SYS41 <> '' OR
	p.SYS31 <> '' OR
	p.SYS42 <> '' OR  
	p.SYS35 <> '' OR
	p.SYS43 <> '' OR
	p.SYS32 <> '' OR   
	p.SYS36 <> '' OR   
	   
	p.SYS33 <> '' OR
	p.SYS103 <> '' OR
	p.SYS80 <> '' OR  
	p.SYS51 <> '' OR
	p.SYS52 <> '' OR
	p.SYS53 <> '' OR   
	p.SYS54 <> '' OR   
	   
	p.SYS55 <> '' OR
	p.SYS56 <> '' OR
	p.SYS57 <> '' OR  
	p.SYS58 <> '' OR
	p.SYS59 <> '' OR
	   
	p.SYS200 <> '' OR
	p.SYS60 <> '' OR  
	p.SYS60A <> '' OR
	p.SYS60B <> '' OR
	p.SYS60C <> ''    
	)
	AND p.gametime = '#GetDay.gametime#'
	AND r.active = 'Y'
	AND 
	(
	'SYS99' = r.SystemNum OR
	'SYS98' = r.SystemNum 
	OR
	
	'SYS6'  = r.SystemNum OR
	'SYS12' = r.SystemNum OR  
	'SYS20' = r.SystemNum OR
	'SYS27' = r.SystemNum OR
	'SYS11' = r.SystemNum OR   
	'SYS18' = r.SystemNum OR   
	
	'SYS22' = r.SystemNum OR
	'SYS3' = r.SystemNum  OR
	'SYS4' = r.SystemNum OR
	'SYS40' = r.SystemNum OR
	'SYS15' = r.SystemNum OR   
	'SYS23' = r.SystemNum OR   
	   
	'SYS19' = r.SystemNum OR
	'SYS34' = r.SystemNum OR
	'SYS14' = r.SystemNum OR  
	'SYS28' = r.SystemNum OR
	'SYS16' = r.SystemNum OR
	'SYS1' = r.SystemNum OR   
	'SYS5' = r.SystemNum OR   
	   
	'SYS17' = r.SystemNum OR
	'SYS21' = r.SystemNum OR
	  
	'SYS24' = r.SystemNum OR
	'SYS25' = r.SystemNum OR
	'SYS29' = r.SystemNum OR   
	'SYS30' = r.SystemNum OR   
	   
	'SYS41' = r.SystemNum OR
	'SYS31' = r.SystemNum OR
	'SYS42' = r.SystemNum OR  
	'SYS35' = r.SystemNum OR
	'SYS43' = r.SystemNum OR
	'SYS32' = r.SystemNum OR   
	'SYS36' = r.SystemNum OR   
	   
	'SYS33' = r.SystemNum OR
	'SYS103' = r.SystemNum OR
	'SYS80' = r.SystemNum OR  
	'SYS51' = r.SystemNum OR
	'SYS52' = r.SystemNum OR
	'SYS53' = r.SystemNum OR   
	'SYS54' = r.SystemNum OR   
	   
	'SYS55' = r.SystemNum OR
	'SYS56' = r.SystemNum OR
	'SYS57' = r.SystemNum OR  
	'SYS58' = r.SystemNum OR
	'SYS59' = r.SystemNum OR
	   
	'SYS200' = r.SystemNum OR
	'SYS60' = r.SystemNum OR  
	'SYS60A' = r.SystemNum OR
	'SYS60B' = r.SystemNum OR
	'SYS60C' = r.SystemNum    
	)
	
)xxx

)
WHERE confidence >= 55
AND ACTIVE='Y'
order by fav

</cfquery>
<cfabort>
	   

<cfset tempcols = ValueList(GetPicks.SystemNum)>
<cfset temppcts = ValueList(GetPicks.Confidence)>

<cfset tempcols=#ListDeleteDuplicates(tempcols)# />
<cfset temppcts=#ListDeleteDuplicates(temppcts)# />
<cfsavecontent variable="NBAPicks">
<p>

<table border="1" bgcolor="" width="70%" cellpadding="6">
<tr>
<td>Fav</td>
<td>CRC</td>
<td>Health</td>
<td>H/A</td>
<td>Spread</td>
<td>Und</td>
<td>CRC</td>
<td>Health</td>

<cfoutput>

<cfloop list="#tempcols#" index="ListElement">
<td>#ListElement# #getWinPct('#ListElement#')#%</TD>
</CFLOOP>
</tr>

</cfoutput>


<cfoutput query="GetPicks" group="fav">
	<tr>	 
	<td>#Fav#</td>
	<td <cfif #getAwayCt('#fav#')# gt 2>bgcolor='RED'></cfif>#getAwayCt('#fav#')#</td>
	<td>#getLastSeven('#fav#')#</td>
	<td>#ha#</td>
	<td>#spd#</td>
	<td>#und#</td>
	<td <cfif #getAwayCt('#und#')# gt 2>bgcolor='RED'></cfif>#getAwayCt('#und#')#</td>
	<td>#getLastSeven('#und#')#</td>
	
	<cfloop list="#tempcols#" index="ListElement">
		
		
		<cfset checkthis = 'GetPicks.' & '#ListElement#'>
		<td nowrap=true>
		#Evaluate(checkthis)# 
		</TD>
		
	</cfloop>
	
</cfoutput>
</tr>

</table>
</cfsavecontent>

<cfoutput>
#NBAPicks#
</cfoutput>


<cfif 1 is 2>
<cffile action="WRITE" file="C:\ColdFusion9\wwwroot\psp2012\NFL\includes\#mypickfilename#" output=" 
<cfcontent type='application/vnd.ms-excel'> 
#NBAPicks#" 
addnewline="Yes" nameconflict="overwrite"> 


<cfhttp url="http://www.pointspreadpros.com/EmailPicksHaveFinished.cfm?mylink=http://www.pointspreadpros.com/#mypickfilename#">

<cfset i = 0>
<cfloop index="ii" from="1" to="1000000">
<cfset i = i + 1>
</cfloop>
</cfif>



<cfscript>
function listRemoveDupes(inList,delim)
{
	var listStruct = {};
	var i = 1;
	
	for(i=1;i<=listlen(inList, delim);i++)
    {
    	listStruct[listgetat(inList,i)] = listgetat(inList,i);
    }
    
    return structkeylist(listStruct);
}
</cfscript>

<cfscript>
/**
 * Case-sensitive function for removing duplicate entries in a list.
 * Based on dedupe by Raymond Camden
 * 
 * @param list The list to be modified. 
 * @return Returns a list. 
 * @author Jeff Howden (jeff@members.evolt.org) 
 * @version 1, March 21, 2002 
 */
function ListDeleteDuplicates(list) {
  var i = 1;
  var delimiter = ',';
  var returnValue = '';
  if(ArrayLen(arguments) GTE 2)
    delimiter = arguments[2];
  list = ListToArray(list, delimiter);
  for(i = 1; i LTE ArrayLen(list); i = i + 1)
    if(NOT ListFind(returnValue, list[i], delimiter))
      returnValue = ListAppend(returnValue, list[i], delimiter);
  return returnValue;
}
</cfscript>


<cffunction name="getAwayCt">
<cfargument name="sTeam" type="string" required="true" 
returntype="Number">

  <cfquery datasource="nba" name="GetRes">
  SELECT ConseqRoadCt
  FROM TeamHealth
  WHERE Team = '#arguments.sTeam#'
  </cfquery>
  
  <cfreturn #GetRes.ConseqRoadCt#>
  </cffunction>

  
 <cffunction name="getLastSeven">
<cfargument name="sTeam" type="string" required="true" 
returntype="Number">

  <cfquery datasource="nba" name="GetLS">
  SELECT LastSeven
  FROM TeamHealth
  WHERE Team = '#arguments.sTeam#'
  </cfquery>
  
  <cfreturn #GetLS.LastSeven#>
  </cffunction> 
  
  
  

<cffunction name="getWinPct">
<cfargument name="sSystem" type="string" required="true" 
returntype="Number">

  <cfquery datasource="nba" name="GetPct">
  Select 
	(xxx.w/(xxx.w + xxx.L))*100 as confidence
		
from

(
Select r.SystemNum, 
(r.W2012 + r.LifetimeWins) as w, 
(r.L2012 + r.LifetimeLosses) as l

from SystemRecord r	
)xxx
WHERE xxx.systemnum = '#arguments.sSystem#' 

  </cfquery>
  
  <cfreturn #Numberformat(GetPct.Confidence,'999.99')#>
  </cffunction>

</body>
</html>
