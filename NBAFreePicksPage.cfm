<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>

<script>
function addfav()
   {
   
   if (document.all)
      {
      window.external.AddFavorite
      ("http://www.PointspreadPros.com","PointSpreadPros.com - Handicapping Service")
      }
   }
</script>

<head>
<!-- InstanceBeginEditable name="Free NFL Picks" -->
<title>NFL Picks | Free Football Picks | Free NFL Picks | Football Picks | Free Sports Picks | Free NBA Picks | NBA Picks</title>
<META name="description" content="If you want quality Free NFL picks, or Free quality NBA picks, or just an affordable handicapping service with a proven record of free football picks, look no further, we have just the football picks you're looking for.">
<META name="keywords" content="nfl picks, free football picks, free nfl picks, football picks, college football picks, sports picks, free sports picks, free NBA picks, free basketball picks">
<!-- InstanceEndEditable -->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- InstanceBeginEditable name="head" -->	
	
	<script src="AC_RunActiveContent.js" type="text/javascript"></script>

<style type="text/css">

/*Example CSS for the two demo scrollers*/

#pscroller1{
width: 200px;
height: 100px;
border: 1px solid black;
padding: 5px;
background-color: lightyellow;
}

#pscroller2{
width: 350px;
height: 20px;
border: 1px solid black;
padding: 3px;
}

#pscroller2 a{
text-decoration: none;
}

.someclass{ 
//class to apply to your scroller(s) if desired
{
		background-color : #FFF2EA;
		font-family: Verdana;
		font-size: 10px;
		color: Black;
		font-weight: normal;
		text-align: left;
		padding-top: 3px;
		
}

.someclasscenter{ 
//class to apply to your scroller(s) if desired
{
		background-color : #FFF2EA;
		font-family: Verdana;
		font-size: 10px;
		color: Black;
		font-weight: normal;
		text-align: center;
		padding-top: 3px;
		
}
.someclasscenter12{ 
//class to apply to your scroller(s) if desired
{
		background-color : #FFF2EA;
		font-family: Verdana;
		font-size: 12px;
		color: Black;
		font-weight: normal;
		text-align: center;
		padding-top: 3px;
}
.someclass12{ 
//class to apply to your scroller(s) if desired
{
		background-color : #FFF2EA;
		font-family: Verdana;
		font-size: 12px;
		color: Black;
		font-weight: normal;
		text-align: left;
		padding-top: 3px;		
}
</style>

<script type="text/javascript">

/*Example message arrays for the two demo scrollers*/

var pausecontent=new Array()
pausecontent[0]='<a href="http://www.javascriptkit.com">JavaScript Kit</a><br />Comprehensive JavaScript tutorials and over 400+ free scripts!'
pausecontent[1]='<a href="http://www.codingforums.com">Coding Forums</a><br />Web coding and development forums.'
pausecontent[2]='<a href="http://www.cssdrive.com" target="_new">CSS Drive</a><br />Categorized CSS gallery and examples.'

var pausecontent2=new Array()
pausecontent2[0]='<a href="http://www.news.com">News.com: Technology and business reports</a>'
pausecontent2[1]='<a href="http://www.cnn.com">CNN: Headline and breaking news 24/7</a>'
pausecontent2[2]='<a href="http://news.bbc.co.uk">BBC News: UK and international news</a>'

</script>

<script type="text/javascript">

/***********************************************
* Pausing up-down scroller- © Dynamic Drive (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit http://www.dynamicdrive.com/ for this script and 100s more.
***********************************************/

function pausescroller(content, divId, divClass, delay){
this.content=content //message array content
this.tickerid=divId //ID of ticker div to display information
this.delay=delay //Delay between msg change, in miliseconds.
this.mouseoverBol=0 //Boolean to indicate whether mouse is currently over scroller (and pause it if it is)
this.hiddendivpointer=1 //index of message array for hidden div
document.write('<div id="'+divId+'" class="'+divClass+'" style="position: relative; overflow: hidden"><div class="innerDiv" style="position: absolute; width: 100%" id="'+divId+'1">'+content[0]+'</div><div class="innerDiv" style="position: absolute; width: 100%; visibility: hidden" id="'+divId+'2">'+content[1]+'</div></div>')
var scrollerinstance=this
if (window.addEventListener) //run onload in DOM2 browsers
window.addEventListener("load", function(){scrollerinstance.initialize()}, false)
else if (window.attachEvent) //run onload in IE5.5+
window.attachEvent("onload", function(){scrollerinstance.initialize()})
else if (document.getElementById) //if legacy DOM browsers, just start scroller after 0.5 sec
setTimeout(function(){scrollerinstance.initialize()}, 500)
}

// -------------------------------------------------------------------
// initialize()- Initialize scroller method.
// -Get div objects, set initial positions, start up down animation
// -------------------------------------------------------------------

pausescroller.prototype.initialize=function(){
this.tickerdiv=document.getElementById(this.tickerid)
this.visiblediv=document.getElementById(this.tickerid+"1")
this.hiddendiv=document.getElementById(this.tickerid+"2")
this.visibledivtop=parseInt(pausescroller.getCSSpadding(this.tickerdiv))
//set width of inner DIVs to outer DIV's width minus padding (padding assumed to be top padding x 2)
this.visiblediv.style.width=this.hiddendiv.style.width=this.tickerdiv.offsetWidth-(this.visibledivtop*2)+"px"
this.getinline(this.visiblediv, this.hiddendiv)
this.hiddendiv.style.visibility="visible"
var scrollerinstance=this
document.getElementById(this.tickerid).onmouseover=function(){scrollerinstance.mouseoverBol=1}
document.getElementById(this.tickerid).onmouseout=function(){scrollerinstance.mouseoverBol=0}
if (window.attachEvent) //Clean up loose references in IE
window.attachEvent("onunload", function(){scrollerinstance.tickerdiv.onmouseover=scrollerinstance.tickerdiv.onmouseout=null})
setTimeout(function(){scrollerinstance.animateup()}, this.delay)
}


// -------------------------------------------------------------------
// animateup()- Move the two inner divs of the scroller up and in sync
// -------------------------------------------------------------------

pausescroller.prototype.animateup=function(){
var scrollerinstance=this
if (parseInt(this.hiddendiv.style.top)>(this.visibledivtop+5)){
this.visiblediv.style.top=parseInt(this.visiblediv.style.top)-5+"px"
this.hiddendiv.style.top=parseInt(this.hiddendiv.style.top)-5+"px"
setTimeout(function(){scrollerinstance.animateup()}, 50)
}
else{
this.getinline(this.hiddendiv, this.visiblediv)
this.swapdivs()
setTimeout(function(){scrollerinstance.setmessage()}, this.delay)
}
}

// -------------------------------------------------------------------
// swapdivs()- Swap between which is the visible and which is the hidden div
// -------------------------------------------------------------------

pausescroller.prototype.swapdivs=function(){
var tempcontainer=this.visiblediv
this.visiblediv=this.hiddendiv
this.hiddendiv=tempcontainer
}

pausescroller.prototype.getinline=function(div1, div2){
div1.style.top=this.visibledivtop+"px"
div2.style.top=Math.max(div1.parentNode.offsetHeight, div1.offsetHeight)+"px"
}

// -------------------------------------------------------------------
// setmessage()- Populate the hidden div with the next message before it's visible
// -------------------------------------------------------------------

pausescroller.prototype.setmessage=function(){
var scrollerinstance=this
if (this.mouseoverBol==1) //if mouse is currently over scoller, do nothing (pause it)
setTimeout(function(){scrollerinstance.setmessage()}, 100)
else{
var i=this.hiddendivpointer
var ceiling=this.content.length
this.hiddendivpointer=(i+1>ceiling-1)? 0 : i+1
this.hiddendiv.innerHTML=this.content[this.hiddendivpointer]
this.animateup()
}
}

pausescroller.getCSSpadding=function(tickerobj){ //get CSS padding value, if any
if (tickerobj.currentStyle)
return tickerobj.currentStyle["paddingTop"]
else if (window.getComputedStyle) //if DOM2
return window.getComputedStyle(tickerobj, "").getPropertyValue("padding-top")
else
return 0
}

</script>

</head>

<body>
<script type='text/javascript'>

//HV Menu v5.411- by Ger Versluis (http://www.burmees.nl/)
//Submitted to Dynamic Drive (http://www.dynamicdrive.com)
//Visit http://www.dynamicdrive.com for this script and more

function Go(){return}

</script>
<script type='text/javascript' src='exmplmenu_var.js'></script>
<script type='text/javascript' src='menu_com.js'></script>
<noscript>Your browser does not support script</noscript>

<!--- <script type="text/javascript">

//new pausescroller(name_of_message_array, CSS_ID, CSS_classname, pause_in_miliseconds)

new pausescroller(pausecontent, "pscroller1", "someclass", 3000)
document.write("<br />")
new pausescroller(pausecontent2, "pscroller2", "someclass", 2000)

</script> --->

<table cellspacing="0" cellpadding="4" bordercolor="#BFC8DD" width="885" height="800" border="1" align="center" bgcolor="#BFC8DD">

<tr>
		
	<td rowspan="2" colspan="2" valign="top" ><!-- Main page info -->
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="#BFC8DD" >
			<!--- <tr>
				<td align="center">
				<!-- NOTE: paste following code where you want the swf to display on the page -->
				<script type="text/javascript">AC_FL_RunContent('codebase','http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,65,0','loop','true','bgcolor','#bfc8dd','width','452','height','34','src','pspPicksLogo','quality','high','pluginspage','http://www.macromedia.com/go/getflashplayer','movie','pspPicksLogo');
				</script><noscript><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id=pspPicksLogo width=452 height=34 codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,65,0">
				 <param name="movie" value="pspPicksLogo.swf" />
				 <param name="quality" value="high" />
				 <param name="play" value="true" />
				 <param name="loop" value="true" />
				 <param name="bgcolor" value="#bfc8dd" />
				 <embed src="pspPicksLogo.swf"  width=452 height=34 bgcolor="#bfc8dd" quality="high" loop="true"
				  type="application/x-shockwave-flash" pluginspace="http://www.macromedia.com/go/getflashplayer" />
				 	</object></noscript>

				</td> 
			</tr> --->
			<tr>
				<td>
				<cfinclude template="../NBA/NBAPicksFree.cfm">
				</td>		
			</tr>
		</table>
	
	</td>
	
    <!--- <td valign="top" align="center" bgcolor="#BFC8DD"><font face="Verdana"><font size="-1">
	<div align="center" class="someclass">
	<P>
	<img src="trophy.gif" width="118" height="118" border="0" alt="">
	</div>
	<div class="someclass">
	<b>4th Place</b> 2000 <a href="http://www.ultimatehandicappingchallenge.com">Ultimate Handicapping Challenge</a> - <b>64% documented record</b>
	<P>
	<b>6th Place</b> 2004 <a href="http://www.ultimatehandicappingchallenge.com">Ultimate Handicapping Challenge</a> - <b>60% documented record</b>
	<P>
	<b>10th Place</b> 2006 <a href="http://www.ultimatehandicappingchallenge.com">Ultimate Handicapping Challenge</a> - <b>55% documented record</b>
	</div>
	</font></font>	
	<P>
	<br>
	
	<div align="left"  class="someclass">
	<!-- NOTE: paste following code where you want the swf to display on the page -->
	<script type="text/javascript">AC_FL_RunContent('codebase','http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,65,0','loop','true','bgcolor','#bfc8dd','width','175','height','34','src','WhatsNew','quality','high','pluginspage','http://www.macromedia.com/go/getflashplayer','movie','WhatsNew');
	</script><noscript><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id=WhatsNew width=175 height=34 codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,65,0">
 	<param name="movie" value="WhatsNew.swf" />
 	<param name="quality" value="high" />
 	<param name="play" value="true" />
 	<param name="loop" value="true" />
 	<param name="bgcolor" value="#bfc8dd" />
 	<embed src="WhatsNew.swf"  width=175 height=34 bgcolor="#bfc8dd" quality="high" loop="true"
  	type="application/x-shockwave-flash" pluginspace="http://www.macromedia.com/go/getflashplayer" />
	</object></noscript>	
	<script type="text/javascript"
	src="http://www.freshcontent.net/nfl_news_feed.php">
	</script>
	</div>
	<div class="someclasscenter">
	<br>
	<a href=http://www.freshcontent.net/directory/sports/nfl_news.html>Fresh Content.net</a>
	</div>
	</td> --->
	
</tr>

</table>

</body>
</html>
