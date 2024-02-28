<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
</cfoutput>

<CFQUERY BLOCKFACTOR="100" NAME="Check2" Datasource="Corporate">
SELECT * from ExternalLocation
WHERE ExternalLocation = <cfqueryparam value="#url.externallocation#" cfsqltype="CF_SQL_VARCHAR">
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Check" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year from AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</cfquery>

	<title>Audit Schedule Status</title>
</head>

<body>
<table><tr>
<td width="2%">&nbsp;</td>
<td width="98%">
<p class="blog-content">
<cfoutput query="check">
<b><u>#year#-#id#</u></b><br>
#externallocation#<br><br>
</cfoutput>
<cfoutput query="check2">
<u>Close Out/Follow Up Notes:</u><br>
#Notes#<br>
</cfoutput>
</td></tr></table>
</body>
</html>