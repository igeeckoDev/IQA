

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AddID">
INSERT INTO AuditScheduleApprove(ID)
VALUES (#FORM.ID#)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="Query" Datasource="Corporate">
UPDATE AuditScheduleApprove

SET 
Year=#FORM.Year#,
<cfif Form.RD is "- None -" or Form.RD is "">
<cfelse>
RD='#FORM.RD#',
</cfif>

<cfif Form.KP is "- None -" or Form.KP is "">
<cfelse>
KP='#FORM.KP#',
</cfif>
Month='#Form.Month#',
LeadAuditor='#FORM.LeadAuditor#',
Auditor='#FORM.Auditor#',
AuditType='#FORM.AuditType#',
Scope='#FORM.Scope#',
Notes='#FORM.Notes#'
WHERE ID=#FORM.ID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="AuditScheduleApprove" Datasource="Corporate">
SELECT * FROM AuditScheduleApprove
WHERE ID=#FORM.ID#
</CFQUERY>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Internal Quality Audits</title>
		<link href="css.css" rel="stylesheet" media="screen">

<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style></head>

	<body leftmargin="0" marginheight="0" marginwidth="0" topmargin="0">
	<img border=0 height=53 src="/pagetempheader.gif" usemap=#FPMap0 width=756 align="top"> 
      <map name=FPMap0><area coords=0,41,89,52 
        href="http://#CGI.Server_Name#/" shape=RECT><area coords=94,40,226,52 
        href="http://#CGI.Server_Name#/deprtserv.htm" shape=RECT><area 
        coords=229,42,288,52 href="http://#CGI.Server_Name#/library.htm" 
        shape=RECT><area coords=290,40,353,52 
        href="http://#CGI.Server_Name#/toolkit/" shape=RECT><area 
        coords=451,41,560,52 href="http://#CGI.Server_Name#/employinfo.htm" 
        shape=RECT><area coords=564,37,664,52 
        href="http://#CGI.Server_Name#/cnsmrcrnr/" shape=RECT><area 
        coords=669,40,755,52 href="http://#CGI.Server_Name#/globalsites.htm" 
        shape=RECT><area coords=630,2,755,36 href="http://www.ul.com/" 
        shape=RECT><area coords=0,2,327,41 href="http://#CGI.Server_Name#/" 
        shape=RECT><area coords=396,6,442,14,431,30,396,33,358,25,360,14 
        href="http://#CGI.Server_Name#/help.htm" shape=POLY><area 
        coords=508,6,554,15,540,31,490,33,469,21,481,9 
        href="http://#CGI.Server_Name#/sitemap.htm" shape=POLY><area 
        coords=356,39,447,52 href="http://#CGI.Server_Name#/ee/" 
      shape=RECT></map> 
	
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
					<td class="table-masthead" align="right" valign="middle"><div align="center"><img src="../images/IQA2.jpg" width="317" height="34"></div></td>

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
                          <td class="blog-date"><p align="center">Audit Program Application</p></td>
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
                              Audit Schedule Log In</p></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">

						  
<CFOUTPUT query="AuditScheduleApprove">
Your data has been updated and is awaiting approval.<br><br>
<b>ID</b> - #Year#-#ID#<br>
<b>Scope</b> - #Form.Scope#<br>
<b>Lead Auditor(s)</b> - #LeadAuditor#<br>
<b>Auditor(s)</b> - #Auditor#<br>

<b>Location</b> - 
<cfif Trim(OfficeName) is "- None -" or Trim(OfficeName) is "">
#ExternalLocation#<br>
<cfelse>
#OfficeName#<br>
</cfif>
<b>Type of Audit</b> - #AuditType#<br>

<b>Month Scheduled</b>
<cfif Trim(Month) is 1>
<br>January
<cfelseif Trim(Month) is 2>
<br>February
<cfelseif Trim(Month) is 3>
<br>March
<cfelseif Trim(Month) is 4>
<br>April
<cfelseif Trim(Month) is 5>
<br>May
<cfelseif Trim(Month) is 6>
<br>June
<cfelseif Trim(Month) is 7>
<br>July
<cfelseif Trim(Month) is 8>
<br>August
<cfelseif Trim(Month) is 9>
<br>September
<cfelseif Trim(Month) is 10>
<br>October
<cfelseif Trim(Month) is 11>
<br>November
<cfelseif Trim(Month) is 12>
<br>December
<cfelse>
<br>No month scheduled.
</cfif>

<b>Dates of Audit</b> - <cfset CompareDate = Compare(StartDate, EndDate)>
						
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
</cfif>

<cfif Trim(KP) is "- None -">
<b>Reference Documents</b> - None Specified<br>
<cfelse>
<b>Reference Documents</b> - #RD#<br>
</cfif>

<cfif Trim(KP) is "- None -">
<b>Key Processes</b> - None Specified<br>
<cfelse>
<b>Key Processes</b> - #KP#<br>
</cfif>

<b>Notes</b> - #Form.Notes#<br>

</CFOUTPUT>		 



 
<br><br>
<a href="schedule.cfm">Return to the Audit Schedule</a>						  
						  
                            </p></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td class="article-end" colspan="3" align="right"><a href="#"><img src="../images/top.gif" alt="" height="7" width="5" border="0"></a></td>
                        </tr>
                      </table>
                      <br> 
                      
                      
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      
					  <table width="100%">
                        <tr><td width="70%">&nbsp;</td>
					  <td width="30%" align="left">

						</td>
						</tr></table>
                      
                    </td>
                    <td class="horizontalbar">&nbsp;</td>
                    <td class="content-column-right" valign="top">&nbsp;</td>
                  </tr>
                </table></td>
				</tr>
				<tr>
				  <td class="table-bookend-bottom-footer" valign="top">
				  <div class="box-header">&nbsp;</div>
				</td>
				  </tr>
				  <tr>				  
				  <td class="table-bookend-bottom-footer">
				  <p align="center"><font color=#808080 face=Arial size=1><a 
            href="http://#CGI.Server_Name#/"><font face="Arial, Helvetica, sans-serif"><br>
			      UL Net Home</font></a><font face="Arial, Helvetica, sans-serif"> - <a 
            href="http://#CGI.Server_Name#/deprtserv.htm">Departments &amp; Services</a> - <a 
            href="http://#CGI.Server_Name#/library.htm">Library</a> - <a 
            href="http://#CGI.Server_Name#/toolkit/">GBS</a> - <a 
            href="http://#CGI.Server_Name#/ee/">Electronic Eye</a> - <a 
            href="http://#CGI.Server_Name#/employinfo.htm">Employee Info Center</a> - <a href="http://#CGI.Server_Name#/cnsmrcrnr/">Consumer Corner</a> -&nbsp; <a 
            href="http://#CGI.Server_Name#/globalsites.htm">Global UL Sites</a></font></font> </p>
		          <p align=center><font face="Arial, Helvetica, sans-serif" size="1">The UL Net is a resource designed to assist you and other UL employees worldwide. We welcome and encourage your feedback. For questions or updates regarding IQA web content, please contact <a href="mailto:Christopher.J.Nicastro@ul.com">Christopher J. Nicastro</a>. Please direct any questions, comments, suggestions or problems with this site&nbsp; to the <a href="http://#CGI.Server_Name#/help.htm">UL NET TEAM</a>. Copyright &copy; 2004 Underwriters Laboratories Inc.&reg; All rights reserved.</font>                   
		          <p align=center><br>			      
	              </td>
			  </tr>
				<tr>
				  <td class="table-bookend-bottom">&nbsp;</td>
			  </tr>
				<tr>
					<td></td>

				</tr>
			</table>
			</div>
			</td></tr></table>
		</div>
	</body>

</html>

