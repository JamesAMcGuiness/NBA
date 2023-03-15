
<!-- See what week of the season it is -->
<cfif not isdefined("Session.IsLoggedIn")>
	<cfset Session.IsLoggedIn = 'N'>
</cfif>	

<table cellspacing="0" cellpadding="4" bordercolor="#BFC8DD" width="100%" border="0" align="center" bgcolor="#BFC8DD">
	<tr>
	<td colspan="2" valign="top" ><!-- Main page info -->
		<table width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="#BFC8DD" >

			<tr>
				<td bgcolor="Yellow">
				
				<p>
				<font color="red"><div><h3>4/04/2008: <b>We won ANOTHER 5* Play now (20-4) as Detroit blew out New Jersey. And lost our 4* on Toronto,as 
				Toronto can not seem to find their form.
				
				<!--- You can get them for only a $5.00 charge by going <a href="http://www.pointspreadpros.com/nba/nbasignup.cfm">here.</a> --->
				</b></h3></div></font>
				<br>
				<h3>
				******************************************************************************************<br>
				5* Play - (20-4)  Home Blowout Play AND one or more of my other systems picks the same side<br> 
				4* Play - (16-5)  Home Blowout Play<br> 
				3* Play - (11-9-1)  No blowout play, but 3 or more of my systems pick the game<br> 
				2* Play - (35-21) No blowout play, but 2 or more of my systems pick the game<br> 
				1* Play - (14-15) Away Blowout <br>
				******************************************************************************************<br>
				</h3>
				<p>
				<div align="center">
				<h2>To signup for our plays, and begin receiving our newsletter<br>at just $1.75/day, you can do it <a href="http://www.pointspreadpros.com/nba/nbasignup.cfm">here.</a></h2>
				</div>
				<p>
				
				<div>
				<cfinclude template="Week21PaidPicks.html">
				</div>
				</td>		
			</tr>
			
			<!---  
 			<tr>
			<td>
				<h2>
				<p>
				Thats now SIX in a row guys, we are on fire!.We have another easy winner for today!...We are offering a money back guarantee!..Get it for only $20. If you lose we will REFUND your money.</h2>
				<div align="center">
				<form action="https://www.paypal.com/cgi-bin/webscr" method="post">
				<input type="hidden" name="cmd" value="_xclick">
				<input type="hidden" name="business" value="jmcguin1@nycap.rr.com">
				<input type="hidden" name="item_name" value="Money back guarantee!">
				<input type="hidden" name="amount" value="20.00">
				<input type="hidden" name="buyer_credit_promo_code" value="">
				<input type="hidden" name="buyer_credit_product_category" value="">
				<input type="hidden" name="buyer_credit_shipping_method" value="">
				<input type="hidden" name="buyer_credit_user_address_change" value="">
				<input type="hidden" name="no_shipping" value="0">
				<input type="hidden" name="return" value="http://www.Pointspreadpros.com/OrderedNBAMembership.cfm?type=w">
				<input type="hidden" name="no_note" value="1">
				<input type="hidden" name="currency_code" value="USD">
				<input type="hidden" name="lc" value="US">
				<input type="hidden" name="bn" value="PP-BuyNowBF">
				<input type="image" src="https://www.paypal.com/en_US/i/btn/btn_paynowCC_LG.gif" border="0" name="submit" alt="Make payments with PayPal - it's fast, free and secure!">
				<img alt="" border="0" src="https://www.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1">
				</div>
				</form>
			</td>
			</tr>
			---->
 		</table>
	</td>
</tr>
<!--- <tr>
<td>
<cfinclude template="NBASignup.cfm">
</td>	
</tr> --->
</table>


