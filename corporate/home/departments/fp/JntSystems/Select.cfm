 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>Joint Systems Design Number Library</title>
	<link rel="stylesheet" type="text/css" href="css/fs1_2panel.css"/>
	<script type="text/javascript" src="../scripts/explode.js"></script>
</head>

<body onload="hideall();">
<script language=javascript type="text/javascript">
	function CloseWindow(){
	CloseWindow = window.close('Index.cfm', '', '')
	}	
</script>

<div id="banner">
<img src="images/welcome.jpg" alt="Fire Protection" width="901" height="98" border="0" align="top"/>
</div>

<cfif isDefined("Cookie.loggedIn")>
    <h2 align="center">Joint Systems Design Number Library</h2>
   	<h2 align="center">Main Menu</h2>  				
<br/>
<table cellspacing="2" cellpadding="2" border="0">
<tr>
	<td width="300"></td>
  <td width="350"><h3><a href="NewSelect1.cfm">Create a new design number.</a></h3></td>
 <td width="300"></td>
</tr>
<tr>
	<td></td>
	<td><h3>    <a href="SearchSelect.cfm">Search for existing design number.</a></h3></td>
	<td></td>
</tr>
<tr>
	<td></td>
	<td><h3>  <a href="SearchDate.cfm">Search for existing design numbers by date.</a></h3></td>
	<td></td>
</tr>
<tr>
	<td></td>
	<td><cflock scope="session" type="exclusive" Timeout="3"><cfif Session.admin neq 0>	<h3>   <a href="AdminSelect.cfm">Administrative Functions</a></h3></cfif></cflock></td>
	<td></td>
</tr>
<tr>
	<td></td>
	<td><br/></td>
	<td></td>
</tr>
<tr>
	<td></td>
	<td><br/></td>
	<td></td>
</tr>
<tr>
	<td></td>
	<td><h3><a href="javascript:CloseWindow()">Logout of the Design Number Library</a></h3></td>
<!--- 	<td><a href="http://<cfoutput>#global.homevar#</cfoutput>/departments/fp/">Logout of the Design Number Library</a></h3></td> --->
	<td></td>
</tr>
</table>



<br/>
<br/>
 						
<cfelse>
			<cflocation url="Logon.cfm">
  </cfif>
			
			
	
<script type="text/javascript" language="javascript" src="../scripts/footer.js"></script>

</body>
</html>





