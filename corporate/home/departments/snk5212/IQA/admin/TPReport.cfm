<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Audit"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.ID, AuditSchedule.AuditedBy,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.ExternalLocation, AuditSchedule.StartDate, AuditSchedule.EndDate, AuditSchedule.Auditor, AuditSchedule.LeadAuditor, AuditSchedule.AuditType, ExternalLocation.KC, ExternalLocation.KCEmail, ExternalLocation.KCPhone, ExternalLocation.ExternalLocation, ExternalLocation.Type
 FROM AuditSchedule, ExternalLocation
 WHERE AuditSchedule.ID = #URL.ID# 
 AND  Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
 AND  AuditSchedule.ExternalLocation = ExternalLocation.ExternalLocation
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfif Audit.Type is "CAP-EA/AA" or Audit.Type is "CAP-AA">
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="CAPAA">
SELECT * FROM CAPAA
ORDER BY ID
</CFQUERY>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ISO17025">
SELECT ISO_17025_2005, ID FROM Clauses
WHERE ISO_17025_2005 <> 'N/A'
ORDER BY ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Recommend">
SELECT * FROM Recommend
ORDER BY ID
</CFQUERY>

<html>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Audit Database</title>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#Request.ULNetCSS#" />
</cfoutput>

<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style>
<script language="JavaScript" src="validate.js"></script>
<script language="JavaScript" src="date.js"></script>
<script language="JavaScript" src="popup2.js"></script>	
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
                              Add Report (1) - General Information and Nonconformances</p><br></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
		

<cfoutput query="Audit">		  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="TPReport2.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">
</cfoutput>

<cfoutput query="Audit">		
<B>Audit Report Number</b><br>
#Year#-#ID#<br><br>

<b>Location</b><br>
#ExternalLocation#<br><br>

<b>Audit Date(s)</b><br>
<cfset CompareDate = Compare(StartDate, EndDate)>

<cfset Start = #StartDate#>
<cfset End = #EndDate#>
<cfset Start1 = DateFormat(Start, 'mm')>
<cfset End1 = DateFormat(End, 'mm')>
						
<cfif Trim(StartDate) is "" AND Trim(EndDate) is "">No dates scheduled<br>
<cfelseif Trim(StartDate) is NOT "" AND Trim(EndDate) is "">#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelseif CompareDate eq 0>#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelse>
	<cfif End1 eq Start1>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'dd, yyyy')#<br>
	<cfelse>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'mmmm dd, yyyy')#<br>
	</cfif>
</cfif><br>

<b>Audit Report Date</b><br>
<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>
<input Type="text" Name="e_ReportDate" Value="#CurDate#" displayname="Report Date" onchange="return ValidateDate()"><br><br>

<b>Auditor(s)</b><br>
<cfif Trim(LeadAuditor) is "" or Trim(LeadAuditor) is "- None -">
	<cfif Trim(Auditor) is "" or Trim(Auditor) is "- None -">
	No Auditors Listed<br>
	<cfelse>
	#Auditor#<br>
	</cfif>
<cfelseif Trim(Auditor) is "" or Trim(Auditor) is "- None -">
#LeadAuditor#, Lead<br>
<CFELSE>
#LeadAuditor#, Lead<br>
#Auditor#<br>
</cfif><br>

<b>Audit Type</b><br>
#AuditType#, #Type#<br><br>

<b>Scope</b><br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_Scope" Value="" displayname="Scope"></textarea><br><br>

<b>Key Contact</b><br>
<INPUT TYPE="TEXT" NAME="e_KC" VALUE="#KC#" size="40" displayname="Key Contact Name"><br><br>
<b>Contact Email</b><br>
<INPUT TYPE="TEXT" NAME="e_KCEmail" VALUE="#KCEmail#" size="40" displayname="Key Contact Email"><br><br>
<b>Contact Phone</b><br>
<INPUT TYPE="TEXT" NAME="e_KCPhone" VALUE="#KCPhone#" size="40" displayname="Key Contact Phone"><br><br>

<b>Other Laboratory Certifications/Accreditations?</b><br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" name="e_LabCert" value="" displayname="Other Laboratory Certifications/Accreditations"></textarea>
<br><br>

<b>Other Laboratory Certifications/Accreditations Comments</b><br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_LabCertNotes" Value="" displayname="Other Laboratory Certifications/Accreditations Comments"></textarea><br><br>

<b>Number of Projects Submitted (since previous GALO)</b> (Numbers only)<br>
<input Type="text" Name="e_ProjectsCompleted" Value="" displayname="Number of Projects">
<A HREF="javascript:popUp('tpreport_note.cfm')">[Criteria]</A>
<br><br>

<b>Number of People in Facility</b> (Numbers only)<br>
<input Type="text" Name="e_PeopleInFacility" Value="" displayname="Number of People"><br><br>

<b>Audit Summary</b><br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_Summary" Value="" displayname="Audit Summary"></textarea><br><br>
</cfoutput>

<b>Recommendations</b><br>
<A HREF="javascript:popUp('recommend.cfm')">Guidance</a> for Recommendations<br><br>
<select name="e_Recommend" displayname="Recommendation">
	<OPTION VALUE="">Select From List Below
<cfoutput query="recommend">
	<OPTION VALUE="#ID#">- #recommend#
</cfoutput>
</select>
<br><br>

<b>Nonconformances</b><br>
Include the number of nonconformances and associated CAR numbers below.<br>
* Separate CAR numbers with a comma<br><br>
<table border="1">
<tr>
<td class="blog-title" width="300">Key Processes</td>
<td class="blog-title" align="center">Number of Findings</td>
<td class="blog-title" align="center">Number of Observations</td>
<td class="blog-title" align="Center">CAR/Audit Finding Number(s)*</td>
</tr>
<tr>
<td colspan="4" class="blog-title">ISO 17025 Requirements</td>
</tr>
<CFoutput query="ISO17025">
<tr>
<cfset Dump1 = #replace(ISO_17025_2005, "Clause ", "", "All")#>
<td class="blog-content">#Dump1#</td>
<td align="center"><INPUT TYPE="TEXT" NAME="e_Count#ID#" displayname="#Dump1# Number of Findings" VALUE="0" size="3"></td>
<td align="center"><INPUT TYPE="TEXT" NAME="e_OCount#ID#" displayname="#Dump1# Number of Observations" VALUE="0" size="3"></td>
<Td><Input Type="Text" Name="e_CAR#ID#" Value="N/A" displayname="#Dump1# CAR Numbers" size="25"></td>
</tr>
</CFoutput>
<cfif Audit.Type is "CAP-EA/AA" or Audit.Type is "CAP-AA">
<tr>
<td colspan="4" class="blog-title">CAP AA Requirements</td>
</tr>
<cfoutput query="CAPAA">
<tr>
<td class="blog-content">#CAPAA#</td>
<td align="center"><INPUT TYPE="TEXT" NAME="e_AACount#ID#" displayname="#CAPAA# Number of Findings" VALUE="0" size="3"></td>
<td align="center"><INPUT TYPE="TEXT" NAME="e_OAACount#ID#" displayname="#CAPAA# Number of Observations" VALUE="0" size="3"></td>
<Td><Input Type="Text" Name="e_CAPAA#ID#" Value="N/A" displayname="#CAPAA# CAR Number" size="25"></td>
</tr>
</cfoutput>
</cfif>
<tr>
<td class="blog-content">Other</td>
<td align="center"><INPUT TYPE="TEXT" NAME="e_CountOther" displayname="Other - Number of Findings" VALUE="0"size="3"></td>
<td align="center"><INPUT TYPE="TEXT" NAME="e_OCountOther" displayname="Other - Number of Observations" VALUE="0"size="3"></td>
<Td><Input Type="Text" Name="e_CAROther" Value="N/A" displayname="Other - CAR Numbers" size="25"></td>
</tr>
</table><br>

<b>Positive Observations</b><br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="BestPrac" Value="" displayname="Positive Observations"></textarea><br><br>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>

 <!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->

