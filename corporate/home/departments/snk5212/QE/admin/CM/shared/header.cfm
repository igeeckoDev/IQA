<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<cfoutput>
	<title>#Request.SiteTitle#</title>
	<META NAME="description" CONTENT="#Request.MetaDescription#">
	<META NAME="keywords" CONTENT="#Request.MetaKeywords#">
	<link rel="stylesheet" type="text/css" media="screen" href="#SiteDir#SiteShared/cr_style.css" />
	<link rel="stylesheet" type="text/css" media="print" href="#SiteDir#SiteShared/cr_style.css" />
	<link rel="stylesheet" type="text/css" href="/header/ulnetheader.css" />
    <link rel="stylesheet" type="text/css" href="about/IE8.css" />
	</cfoutput>
	
<style type="text/css">
#dropmenudiv{
position:absolute;
border:1px solid black;
border-bottom-width: 0;
font:normal 10px Verdana;
line-height:18px;
z-index:100;
}

#dropmenudiv a{
width: 100%;
display: block;
border-bottom: 1px solid black;
padding: 0px;
text-decoration: none;
}

#dropmenudiv a:hover{ /*hover background color*/
background-color: #e8e8e8;
}
</style>

<script type="text/javascript">
//Contents for QE menu
var qemenu=new Array()
qemenu[0]='<a href="/">QE - Home</a>'
qemenu[1]='<a href="/">Knowledge Base</a>'
qemenu[2]='<a href="/">About / Contact QE</a>'
qemenu[3]='<a href="/">Request an Audit</a>'
qemenu[4]='<a href="/">Request to be an Auditor</a>'
qemenu[5]='<a href="/">Request to be a CAR Administrator</a>'
qemenu[6]='<a href="/">Calibration Meetings</a>'
qemenu[7]='<a href="/">Web Help</a>'

//Contents for Audit menu
var IQAmenu=new Array()
IQAmenu[0]='<a href="/">Audits- Home</a>'
IQAmenu[1]='<a href="/">Audits</a>'
IQAmenu[2]='<a href="/">Auditors</a>'
IQAmenu[3]='<a href="/">Audit Activity and Coverage</a>'
IQAmenu[4]='<a href="/">Audit Schedule Attainment</a>'
IQAmenu[5]='<a href="/">Metrics</a>'
IQAmenu[6]='<a href="/">Audit Plans</a>'

//Contents for CAR menu
var CARmenu=new Array()
CARmenu[0]='<a href="/">CAR Process - Home</a>'
CARmenu[1]='<a href="/">GCAR - Link to Application</a>'
CARmenu[2]='<a href="/">GCAR Metrics</a>'
CARmenu[3]='<a href="/">CAR Training</a>'
CARmenu[4]='<a href="/">Quality Alerts</a>'
CARmenu[5]='<a href="/">CAR Administrators</a>'

//Contents for FAQ menu
var FAQmenu=new Array()
FAQmenu[0]='<a href="/">IQA FAQ</a>'
FAQmenu[1]='<a href="/">CAR Process FAQ</a>'
FAQmenu[2]='<a href="/">GCAR FAQ</a>'

var menuwidth='167px' //default menu width
var menubgcolor='white'  //menu bgcolor
var disappeardelay=250  //menu disappear speed onMouseout (in miliseconds)
var hidemenu_onclick="no" //hide menu when user clicks within menu?

/////No further editting needed
var ie4=document.all
var ns6=document.getElementById&&!document.all

if (ie4||ns6)
document.write('<div id="dropmenudiv" style="visibility:hidden;width:'+menuwidth+';background-color:'+menubgcolor+'" onMouseover="clearhidemenu()" onMouseout="dynamichide(event)"></div>')

function getposOffset(what, offsettype){
var totaloffset=(offsettype=="left")? what.offsetLeft : what.offsetTop;
var parentEl=what.offsetParent;
while (parentEl!=null){
totaloffset=(offsettype=="left")? totaloffset+parentEl.offsetLeft : totaloffset+parentEl.offsetTop;
parentEl=parentEl.offsetParent;
}
return totaloffset;
}


function showhide(obj, e, visible, hidden, menuwidth){
if (ie4||ns6)
dropmenuobj.style.left=dropmenuobj.style.top="-500px"
if (menuwidth!=""){
dropmenuobj.widthobj=dropmenuobj.style
dropmenuobj.widthobj.width=menuwidth
}
if (e.type=="click" && obj.visibility==hidden || e.type=="mouseover")
obj.visibility=visible
else if (e.type=="click")
obj.visibility=hidden
}

function iecompattest(){
return (document.compatMode && document.compatMode!="BackCompat")? document.documentElement : document.body
}

function clearbrowseredge(obj, whichedge){
var edgeoffset=0
if (whichedge=="rightedge"){
var windowedge=ie4 && !window.opera? iecompattest().scrollLeft+iecompattest().clientWidth-15 : window.pageXOffset+window.innerWidth-15
dropmenuobj.contentmeasure=dropmenuobj.offsetWidth
if (windowedge-dropmenuobj.x < dropmenuobj.contentmeasure)
edgeoffset=dropmenuobj.contentmeasure-obj.offsetWidth
}
else{
var topedge=ie4 && !window.opera? iecompattest().scrollTop : window.pageYOffset
var windowedge=ie4 && !window.opera? iecompattest().scrollTop+iecompattest().clientHeight-15 : window.pageYOffset+window.innerHeight-18
dropmenuobj.contentmeasure=dropmenuobj.offsetHeight
if (windowedge-dropmenuobj.y < dropmenuobj.contentmeasure){ //move up?
edgeoffset=dropmenuobj.contentmeasure+obj.offsetHeight
if ((dropmenuobj.y-topedge)<dropmenuobj.contentmeasure) //up no good either?
edgeoffset=dropmenuobj.y+obj.offsetHeight-topedge
}
}
return edgeoffset
}

function populatemenu(what){
if (ie4||ns6)
dropmenuobj.innerHTML=what.join("")
}


function dropdownmenu(obj, e, menucontents, menuwidth){
if (window.event) event.cancelBubble=true
else if (e.stopPropagation) e.stopPropagation()
clearhidemenu()
dropmenuobj=document.getElementById? document.getElementById("dropmenudiv") : dropmenudiv
populatemenu(menucontents)

if (ie4||ns6){
showhide(dropmenuobj.style, e, "visible", "hidden", menuwidth)
dropmenuobj.x=getposOffset(obj, "left")
dropmenuobj.y=getposOffset(obj, "top")
dropmenuobj.style.left=dropmenuobj.x-clearbrowseredge(obj, "rightedge")+"px"
dropmenuobj.style.top=dropmenuobj.y-clearbrowseredge(obj, "bottomedge")+obj.offsetHeight+"px"
}

return clickreturnvalue()
}

function clickreturnvalue(){
if (ie4||ns6) return false
else return true
}

function contains_ns6(a, b) {
while (b.parentNode)
if ((b = b.parentNode) == a)
return true;
return false;
}

function dynamichide(e){
if (ie4&&!dropmenuobj.contains(e.toElement))
delayhidemenu()
else if (ns6&&e.currentTarget!= e.relatedTarget&& !contains_ns6(e.currentTarget, e.relatedTarget))
delayhidemenu()
}

function hidemenu(e){
if (typeof dropmenuobj!="undefined"){
if (ie4||ns6)
dropmenuobj.style.visibility="hidden"
}
}

function delayhidemenu(){
if (ie4||ns6)
delayhide=setTimeout("hidemenu()",disappeardelay)
}

function clearhidemenu(){
if (typeof delayhide!="undefined")
clearTimeout(delayhide)
}

if (hidemenu_onclick=="yes")
document.onclick=hidemenu
</script>

</head>
<body>
<cfoutput>
<!-- Begin UL Net Header -->
<SCRIPT language=JavaScript src="#request.serverProtocol##request.serverDomain#/header/header.js"></SCRIPT>
<!-- End UL Net Header-->

<div id="header">
  <table border="0" cellspacing="0" cellpadding="0" width="776">
    <tr>
      <td align="left" valign="top" colspan="2"><img src="images/hdr_qual_eng.jpg" alt="Quality Engineering Header Image" width="776" height="70" border="0"></td>
    </tr>
    <tr>
      <td align="center" valign="middle" width="158">
        <div class="navdate">
			
				#dateformat(now(), "MMMM d, yyyy")#
        	
		</div>
	</td>
<td align="left" valign="top" width="618" height="23"></cfoutput>
	<!---
	<!--- QE --->
	<a href="/">
		<img src="/depts/pde/images/nav_home.gif" alt="Home" width="78" height="23" border="0">
	</a>
	<!--- Audits --->
	<a href="/" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, tcmenu, '147px')" onMouseout="delayhidemenu()">
		<img src="/depts/pde/images/nav_tc.gif" alt="Technical Competency" width="150" height="23" border="0">
	</a>
	<!--- CAR --->
	<a href="/" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, resourcesmenu, '147px')" onMouseout="delayhidemenu()">
		<img src="/depts/pde/images/nav_resources.gif" alt="Resources" width="94" height="23" border="0">
	</a>
	<!--- FAQ --->
	<a href="/" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, orgmenu, '147px')" onMouseout="delayhidemenu()">
		<img src="/depts/pde/images/nav_orgcharts.gif" alt="Organizational Charts" width="94" height="23" border="0">
	</a>
	--->
</td>
    </tr>
  </table>
</div>