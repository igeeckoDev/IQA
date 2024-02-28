<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Effect">
SELECT * FROM Recommend
ORDER BY ID
</cfquery>

	<title>Guidance for Third Party Client Recommendations</title>
</head>

<body>
<table><tr>
<td width="2%">&nbsp;</td>
<td width="98%" class="blog-content">
<br>
<cfoutput query="Effect">
<b><u>#Recommend#</u></b><br><br>
<b>Text shown in report:</b> #text#<br><br>
<b>Guidance:</b> #Guidance#<br><br><hr width="65%" noshade><br><br>
</cfoutput>
</td></tr></table>
</body>
</html>
