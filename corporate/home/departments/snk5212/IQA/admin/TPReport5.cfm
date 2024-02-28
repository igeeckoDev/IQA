<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Audit">
SELECT * FROM AuditSchedule
WHERE ID = #URL.ID# and Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="TPInfo">
SELECT * FROM ExternalLocation
WHERE ExternalLocation = '#Audit.ExternalLocation#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="a"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT ID,YEAR_ as "Year"
 FROM TPReport4
 WHERE ID = #URL.ID#  AND  Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfif a.recordcount is 0>
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FirstEntry">
INSERT INTO TPReport4(ID, Year, AuditedBy)
VALUES (#URL.ID#, <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">, '#URL.AuditedBy#')
</cfquery>
</cfif>
	
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE TPReport4

SET	
DC = 
'#Form.DC#', DCComments ='#FORM.e_DCComments#',
MR= 
'#Form.MR#', MRComments ='#FORM.e_MRComments#',
IA= 
'#Form.IA#', IAComments ='#FORM.e_IAComments#',
RE= 
'#Form.RE#', REComments ='#FORM.e_REComments#',
CA=
'#Form.CA#', CAComments='#Form.e_CAComments#',
Overall=
'#Form.Overall#', OverallComments='#Form.e_OverallComments#'

WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET 

Report='4'

WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Audit">
SELECT * FROM AuditSchedule
WHERE ID = #URL.ID# and Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="ISO17025">
SELECT ISO_17025_2005, ID FROM Clauses
WHERE ISO_17025_2005 <> 'N/A'
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
                             Add Report (5) - ISO 17025 Audit Coverage Matrix</p><br></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
						  

<cfoutput query="Audit">
<cfif tpinfo.Type is "CAP-EA/AA" or TPInfo.Type is "CAP-AA">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="TPReport6.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">
<cfelse>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="TPReport5_submit.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">
</cfif>
</cfoutput>

<table border="1" valign="top">
<tr>
<td class="blog-title">&nbsp;</td>
<td class="blog-title">Audited - Yes/No</td>
</tr>
<cfoutput query="ISO17025">
<tr>
<cfset Dump1 = #replace(ISO_17025_2005, "Clause ", "", "All")#>
<td width="400" class="blog-content">#Dump1#</td>
<td class="blog-content">
<cfif ID is "3">
	<cfif FORM.DC is NOT "NA"> 
	Yes <INPUT TYPE="Radio" NAME="#ID#" value="1" checked>
	<cfelse>
	No <INPUT TYPE="Radio" NAME="#ID#" value="0" checked>
	</cfif>	
<cfelseif ID is "11">
	<cfif FORM.CA is NOT "NA">
	Yes <INPUT TYPE="Radio" NAME="#ID#" value="1" checked>
	<cfelse>
	No <INPUT TYPE="Radio" NAME="#ID#" value="0" checked>
	</cfif>
<cfelseif ID is "13">
	<cfif FORM.RE is NOT "NA">
	Yes <INPUT TYPE="Radio" NAME="#ID#" value="1" checked>
	<cfelse>
	No <INPUT TYPE="Radio" NAME="#ID#" value="0" checked>
	</cfif>		
<cfelseif ID is "14">
	<cfif FORM.IA is NOT "NA">
	Yes <INPUT TYPE="Radio" NAME="#ID#" value="1" checked>
	<cfelse>
	No <INPUT TYPE="Radio" NAME="#ID#" value="0" checked>
	</cfif>
<cfelseif ID is "15">
	<cfif FORM.MR is NOT "NA">
	Yes <INPUT TYPE="Radio" NAME="#ID#" value="1" checked>
	<cfelse>
	No <INPUT TYPE="Radio" NAME="#ID#" value="0" checked>
	</cfif>	
<cfelse>
Yes <INPUT TYPE="Radio" NAME="#ID#" value="1"> 
No <INPUT TYPE="Radio" NAME="#ID#" value="0" Checked>
</cfif>
</td>
</tr>
</cfoutput>
</table>
<br><br>
<INPUT TYPE="Submit" value="Save and Continue">

</FORM>

 
 <!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->

