<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
</cfoutput>

<CFQUERY BLOCKFACTOR="100" NAME="Check" Datasource="Corporate">
SELECT * from AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND ID = #url.id#
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
<cfif AuditType is "TPTDP">#externallocation#<Cfelse>#officename# (#area#)</cfif>
<br>
<cfif reschedulenextyear is "Yes">
<cfset nextyear = #year# +1>
Audit rescheduled for #nextyear#<br><br>
<u>Reschedule Notes:</u><br>
#reschedulenotes#<br>
<cfelseif status is "deleted">
<br>
<u>Cancellation Notes:</u><br>
#notes#<br>
</cfif>

</cfoutput>
</td></tr></table>
</body>
</html>