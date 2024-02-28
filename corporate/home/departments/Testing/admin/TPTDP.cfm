<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="TPTDPList">
SELECT * FROM ExternalLocation
WHERE ExternalLocation <> '- None -'
ORDER BY Status DESC, ExternalLocation
</CFQUERY>

<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="TPType">
SELECT * FROM ThirdPartyTypes
ORDER BY TPType
</CFQUERY>

<cfoutput>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
</cfoutput>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Audit Database</title>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#Request.ULNetCSS#" />
</cfoutput>
		
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
                          <td width="3%"></td> <td class="blog-date"><p align="center">Audit Database</p></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="table-menu" valign="top">
						  
							<cfinclude template="adminMenu.cfm">
							
							</td>
                          <td></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td class="article-end" colspan="3" align="right">&nbsp;</td>
                        </tr>
                      </table>
                      <br>
                      <table width="100%" height="400" border="0" cellpadding="0" cellspacing="0">
                        <tr> 
                          <td width="4%" height="20" align="right"> <p>&nbsp;</p></td>
                          <td colspan="2" align="left" class="blog-title"><p align="left">TPTDP Locations</p></td>
                        </tr>
	  
                        <tr> 
                          <td></td>
                          <td width="92%" align="left" class="blog-content">
						  <br>
<div class="blog-time">TPTDP Client List Help - <A HREF="javascript:popUp('../webhelp/webhelp_TPTDP.cfm')">[?]</A></div>
						  
						  <br>
						  <b>Current list of TPTDP locations:</b><br>
						  - <a href="TPTDP_add.cfm">Add Location</a>
						  <br><br>
						  <B>Third Party Report Card View</B><br>
						  <cfoutput>
- <a href="watch.cfm">Third Party Watch List</a><br>						  
- <a href="../report/report.cfm?Year=#CurYear#">View Report Card</a> (NACPO View)<br>
- <a href="rc_main.cfm">Add Third Party Report Card Quarterly Comments</a><br><br>
- Please add commments for each individual Third Party's Report Card by selected 'Report Card' below in the client's profile.<br><br>

<font color="red">Note: Certificates issued in 2007 will be available for viewing on the IQA Audit Database until the dates of expiration in 2008, New certificates will no longer be issued by IQA after the 2008 dates of expiration. Please contact the DAP Process Owner, Jodine Hepner, x42418, for information regarding issuance and maintenance of new certificates.</font><br>
						  </cfoutput>
						  <br><br>
						  <table border="1">
						  <tr>
						  <td class="blog-title">Third Party Name</td>
						  <td class="blog-title">Location</td>
						  <td class="blog-title">Participant Type</td>
						  </tr>
						  <CFOUTPUT query="TPTDPList">
						  <tr>
						  <td class="blog-content">
<b>#ExternalLocation#</b> <cfif Status is 0><font color="red">(Inactive)</font></cfif>
<br>

 - <a href="TP_Audit_Coverage.cfm?ExternalLocation=#ExternalLocation#">(Audit Coverage)</a><br>
<cfif Type is "CAP-EA/AA" or Type is "CAP-AA">
 - <a href="TP_AA_Audit_Coverage.cfm?ExternalLocation=#ExternalLocation#">(CAP AA Coverage)</a><br>
</cfif>
 - <a href="reportcard.cfm?TP=#ExternalLocation#">(Report Card)</a> <cfif Watch is 1><font color="red"><b>On Watch List</b></font></cfif><br>
 - <a href="TPTDP_View.cfm?ID=#ID#">(View)</a><br>
 - <a href="TPTDP_Edit.cfm?ID=#ID#">(Edit)</a><br>
 - <a href="TPTDP_Notes.cfm?ID=#ID#">(Notes)</a><br>

<cfif Type is "MOU" or Type is "TPTDP-I" or ID is 36>
 - <a href="../certs/#Certificate#.pdf">(Certificate)</a>
</cfif> 



						  </td>
						  <td class="blog-content" valign="top">
						  #Location#<br>
						  </td>
						  <td class="blog-content" valign="top">
						  <cfif Trim(Type) is ""><Cfelse>#Type#</cfif>
						  </td>
						  </tr>
						  </CFOUTPUT>
						  </table>
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->