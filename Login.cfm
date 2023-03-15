<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<!-- See what week of the season it is -->
<cfif not isdefined("Session.IsLoggedIn")>
	<cfset IsLoggedIn = 'N'>
</cfif>	


<cfset myemail = "">
<cfif IsDefined("Cookie.Email")>
	<cfset myemail = Cookie.Email>
</cfif>

<cfif IsDefined("Form.Email")>
	<cfset myemail = Form.email>
</cfif>


<cfif Isdefined("btnSubmit")>

	<cfquery name="GetUser" datasource="psp_psp">
	Select * from users where email = '#Trim(form.email)#'
	</cfquery>

	<cfcookie name="email" value="#Trim(Form.email)#" expires="NEVER">
	
	<cfif GetUser.Recordcount neq 0>
	
		<cfif GetUser.NBAMembershiptype is 'w' or GetUser.NBAMembershiptype is 'm' or GetUser.NBAMembershiptype is 'y'>
			<cfset Session.IsLoggedIn = 'Y'>
			
			<script language="JavaScript">
			location.href="http://www.pointspreadpros.com/pspweb/nba/NBAPicksWithLogin.cfm";
			</script>
			
		<cfelse>
	
			<div align="center" >
			You have not purchased a membership yet, you can purchase a daily, weekly or monthly membership <a href="../NBA/NBASignup.cfm">here</a>
			</div>
	
		</cfif>
	<cfelse>
	
		<div align="center" >
		You have not purchased a membership yet, you can purchase a daily, weekly or monthly membership <a href="../NBA/NBASignup.cfm">here</a>
		</div>
	
	</cfif>
</cfif>

<body>
<form action="Login.cfm" method="post">
<cfoutput>
<div align="center">
<h2>
Please Login To View Our Picks
</h2>
</div>
<br>
<div align="center">
Email Address: <input type="Text" name="email" value="#myemail#" maxlength="60" size="60">
</div>
<br>
<div align="center">
<input type="Submit" name="btnSubmit" value="Login">
</div>

</form>
</cfoutput>
</body>
</html>
