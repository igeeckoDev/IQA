<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Standard Categories Matrix - Revision History</title>
<cfoutput>
<link href="#REQUEST.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#REQUEST.ULNetCSS#">
</cfoutput>
</head>

<body>
<cfquery name="RH" Datasource="Corporate">
SELECT * FROM Clauses_RevHistory
ORDER BY RevNo DESC
</cfquery>

<cfquery name="MaxRev" Datasource="Corporate">
SELECT MAX(RevNo) as RevNo FROM Clauses_RevHistory
</cfquery>

<span class="blog-title">Standard Categories Matrix - Revision History</span><br><br>

<table border="0" valign="top">
<cfoutput query="RH">
<tr>
<td class="blog-content" valign="top" align="left" width="700">
<u><b>Revision Number</b></u>: #RevNo# :: <a href="matrix_rev#RevNo#.cfm">View</a><br>
<u>Revision Date</u>: #dateformat(RevDate, "mm/dd/yyyy")#<br>
<u>Revision Details</u>:<Br>
<pre>#RevDetails#</pre><br>
</td>
</tr>
</cfoutput>
</table>

</body>
</html>

