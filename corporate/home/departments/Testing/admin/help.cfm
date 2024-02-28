<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Effect">
SELECT * FROM Effectiveness
WHERE ID = #URL.ID#
</cfquery>

	<title><cfoutput query="Effect">#Name#</cfoutput></title>
</head>

<body>
<table><tr>
<td width="2%">&nbsp;</td>
<td width="98%">
<p class="blog-content"><br>
<cfoutput query="Effect">
<b><u>#Name#</u></b><br><br>
<b>Evaluation:</b> #Eval#<br><br>
<b>Effectiveness:</b> #Effect#<br><Br>
<b>Cannot Determine Effectiveness Definition:</b> Requirements are approved and published, however, evidence is not available to demonstrate complete implementation.  Typically used in situations where newly introduced or changed processes have not operated long enough to accumulate the necessary evidence to demonstrate implementation.   Also used in situations where evidence is not available or provided for mature processes. Typically, a nonconformance is written in these situations.<br></p>
</cfoutput>
</td></tr></table>
</body>
</html>