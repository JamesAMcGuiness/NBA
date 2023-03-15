<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfif not isdefined("dsname")>
	<cfset dsname = "psp_psp">
</cfif>

<cfset myyear  = Year(now())>
<cfset mymonth = Numberformat(Month(now()),'00')>
<cfset myday   = Numberformat(Day(now()),'00')>

<cfset mydate = myyear & mymonth & myday>
<cfset mytodayobj = CreateDate(myyear,mymonth,myday)>

<cfset thehour   = Hour(now())>
<cfset theminute = Minute(now())>

<!-- If the hour is before 7:00 EST -->
<cfif thehour le 7>
	<cfset myweekcanceldate  = DateAdd('d',7,mytodayobj)> 
	<cfset mymonthcanceldate = DateAdd('d',31,mytodayobj)>
	<cfset mydaycanceldate   = mytodayobj>
<cfelse>
	<cfset myweekcanceldate  = DateAdd('d',8,mytodayobj)> 
	<cfset mymonthcanceldate = DateAdd('d',32,mytodayobj)>
	<cfset mydaycanceldate   = mytodayobj>
</cfif>

<cfoutput>
myweekcanceldate  = #myweekcanceldate#>
mymonthcanceldate = #mymonthcanceldate#>
</cfoutput>

<!--- <cfset email = 'jmcguin1@nycap.rr.com'> --->
<cfset myemail    = ''>
<cfset membership = 'w'>

<cfif Isdefined("URL.type")>
	<cfset membership = URL.type>
</cfif>

<cfif isdefined("Cookie.email") and Cookie.email neq ''>
	<cfset myemail = '#Cookie.email#'>
</cfif>

<cfif isdefined("form.email") >
	<cfset myemail = form.email>
</cfif>

	
<cfoutput>
	<input type="hidden" name="hdn_Membership" value="#membership#">
</cfoutput>
	
<cfif myemail neq ''>
	
 	<cfmail to="#email#" from="admin@PointspreadPros.com" subject="Thank you for your purchase!" cc="james.mcguiness@ge.com" server="localhost" >
	Dear Member,
	
	Thank you for joining us, we feel you have made a great choice partnering with PointspreadPros.com.

	You will be able to access your picks from our website at http://www.pointspreadpros.com/nba/NBAPicksWithLogin.cfm, please use your
	email address (#email#) to login once you get there.	
	
	Best of luck!
	PointspreadPros.com
	
	</cfmail>
 
	 <cfif membership is 'w'>
 		<cfset amt = 60>
		<cfset canceldate = myweekcanceldate>
 	</cfif>

 	<cfif membership is 'm'>
 		<cfset amt = 195>
		<cfset canceldate = mymonthcanceldate>
 	</cfif>

 	<cfif membership is 'd'>
 		<cfset amt = 15>
		<cfset canceldate = mydaycanceldate>
 	</cfif>

 
	<cfoutput>
	<cfquery name="Insertit" datasource="#dsname#" dbtype="ODBC">
	Delete from Users
	where email = '#myemail#'
	</cfquery>
		
	<cfquery name="Insertit" datasource="#dsname#" dbtype="ODBC">
	Insert into Users
	(email,
	NBAMembershipType,
	MemberSince)
	Values
	('#myemail#',
	'#membership#',
	#Now()#
	)
	</cfquery>

	<cfquery name="Insertit2" datasource="Trans" dbtype="ODBC">
	Insert into Transactions
	(email,
	DateOfPurchase,
	PurchaseType,
	Amount,
	Sport,
	DateMembershipEnds
	)
	Values
	('#myemail#',
	#Now()#,
	'#membership#',
	#amt#,
	'NBA',
	#CreateODBCDate(canceldate)#	
	)
	</cfquery>
	
	</cfoutput>
	
	<cfset Session.IsLoggedIn = 'Y'>
	

	<script language="JavaScript">
	location.href="http://www.pointspreadpros.com/nba/NBAPicksWithLogin.cfm";
	</script>
<cfelse>

	<cfset Membership = 'w'>
	<cfif isdefined("URL.type")>
	<cfset Membership = '#URL.type#'>
	
</cfif>


<cfoutput>
<form action="OrderedNBAMembership.cfm?type=#membership#" method="post">
<input type="hidden" name="hdn_Membership" value="#Membership#">
</cfoutput>

<table cellspacing="4" cellpadding="4" align="center">
	<tr>
		<cfif isdefined("Cookie.email") and Cookie.email neq "">
		<td>
			<font face="Verdana" size="4">We Use Your Email Address As Authorization To Our Members Picks Page:....</font><br>
			<br>
			<font face="Verdana" size="2">Please verify the email address shown by clicking the OK button.
			<br><br>&nbsp;<cfoutput>My email address is:&nbsp;<input type="text" name="email" value="#Cookie.Email#" size="40" maxlength="250">&nbsp;<input type="submit" name="Order" value="Ok"></font></cfoutput>
		</td>
		<cfelse>
		<td>
			<font face="Verdana" size="4">We Use Your Email Address As Authorization To Our Members Picks Page:....</font><br>
			<br>
			<font face="Verdana" size="2">Please SLOWLY enter the email address you used in PAY PAL, and then click the OK button.
			<br><br>&nbsp;My email address is:&nbsp;<input type="text" name="email" size="40" maxlength="250">&nbsp;<input type="submit" name="Order" value="Ok"></font>
		</td>
		
		</cfif>
		
		
</tr>

</table>
</form>

</cfif>



</body>
</html>
