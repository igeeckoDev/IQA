<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<html>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Audit Database</title>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#Request.ULNetCSS#" />
</cfoutput>

<script language="JavaScript" src="file.js"></script>		

<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style>

</head>

	<body leftmargin="0" marginheight="0" marginwidth="0" topmargin="0">
	<!-- Begin UL Net Header -->
<cfoutput><SCRIPT language=JavaScript src="#Request.header#"></script></cfoutput>
<!-- End UL Net Header--> 
	
		<div align="left">
			<table width="756" border="0" cellpadding="0" cellspacing="0" bgcolor="#cecece" class="table-main">
			<tr>
			<td>
			<div align="center">
			<table class="table-main" width="675" border="0" cellspacing="0" cellpadding="0" bgcolor="#cecece">
				<tr>
					<td class="table-bookend-top">&nbsp;</td>
				</tr>
				<tr>
					<td class="table-masthead" align="right" valign="middle"><div align="center">&nbsp;</div></td>

				</tr>
				<tr>
					
              <td class="table-menu" valign="top"><div align="center">&nbsp;</div></td>
				</tr>
				<tr>

					
              <td height="925" class="table-content"> <table width="100%" height="" border="0" cellpadding="0" cellspacing="0">
                  <tr> 
                    <td height="927" valign="top" class="content-column-left"> 
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-date"><p align="center">Audit Database</p></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="table-menu" valign="top">
						  	<cfinclude template="adminmenu.cfm">
                          </td>
                          <td></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td class="article-end" colspan="3" align="right">&nbsp;</td>
                        </tr>
                      </table>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="3%" height="20" align="right"><p>&nbsp;</p></td>
                          <td width="94%" align="left" class="blog-title"><p align="left"><br>
                              CAR Responsiveness - Audit Report</p></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
						  
<CFQUERY BLOCKFACTOR="100" name="Car" Datasource="Corporate">
SELECT * FROM AuditSchedule, TPReport
WHERE AuditSchedule.ID = #URL.ID#
AND AuditSchedule.Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND TPReport.ID = #URL.ID#
AND TPReport.year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<div align="Left" class="blog-time"><br>
Follow Up Help - <A HREF="javascript:popUp('../webhelp/webhelp_followup.cfm')">[?]</A></div>

<cfif Car.recordcount is 0 AND CAR.Report is "">
The Report for this Audit has not been completed. Please complete the Audit Report before recording the Close Out Letter.<br><br>
<cfoutput>
Return to <a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">Audit Details</a>
</cfoutput>

<cfelseif Car.Ontime is "Yes" or Car.Ontime is "No">

<cflocation url="addFollowUp.cfm?ID=#ID#&Year=#Year#&auditedby=#url.auditedby#" ADDTOKEN="No">

<cfelse>

<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "SU" or SESSION.Auth.accesslevel is "Admin" or SESSION.Auth.SubRegion is Car.AuditedBy or Car.LeadAuditor is "#SESSION.AUTH.NAME#" or Car.Auditor is "#SESSION.AUTH.NAME#">

<cfoutput query="Car">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="addFollowUp.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">
<INPUT TYPE="Hidden" NAME="ID" VALUE="#ID#">
<INPUT TYPE="Hidden" NAME="Year" VALUE="#Year#">

Were all CAR Responses received within 30 days of filing the Audit Report (#DateFormat(ReportDate, 'mm/dd/yyyy')#)?<br>
Yes <input type="radio" value="Yes" Name="Response"> 
No <input type="radio" value="No" Name="Response"><br><br>

Comments necessary only if 'No' is selected above.<br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="70" NAME="Comments">Please add comments</textarea><br><br>

<INPUT TYPE="Submit" value="Submit Update">

</FORM>
</cfoutput>
</cfif>
</cflock>

</cfif>				  
<br><br>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->